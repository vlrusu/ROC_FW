-- RS485 protocol v2. See docs/rs485-v2.md for the wire and APB contracts.
-- 7E | escaped(version,type,ROC_LE16,transaction_LE16,command,length,
--              payload,FCS_LE16) | 7E
-- FCS: RFC1662 CRC-16/IBM-SDLC. Legacy three-byte traffic is not accepted.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RS485Registers is
    generic (
        APB_ADDRESS_WIDTH : positive := 32;
        APB_DATA_WIDTH : positive := 32;
        CLKS_PER_BIT : positive := 1302;       -- 50 MHz / 38400, rounded
        DELAY_UNIT_CLKS : positive := 5000000; -- existing my_delay unit: 100 ms
        RX_TIMEOUT_CLKS : positive := 250000; -- proposed interbyte timeout: 5 ms
        CPU_TIMEOUT_CLKS : positive := 250000000; -- proposed CPU deadline: 5 s
        DE_SETUP_CLKS : positive := 1302;     -- one bit of driver setup
        DIRECT_TURNAROUND_CLKS : positive := 50000 -- 1 ms at 50 MHz; type03 only
    );
    port (
        PCLK, PRESETn, PENABLE, PSEL : in std_logic;
        PADDR : in std_logic_vector(APB_ADDRESS_WIDTH-1 downto 0);
        PWRITE : in std_logic;
        PWDATA : in std_logic_vector(APB_DATA_WIDTH-1 downto 0);
        PRDATA : out std_logic_vector(APB_DATA_WIDTH-1 downto 0);
        PREADY, PSLVERR : out std_logic;
        rx : in std_logic;
        tx, tx_enable : out std_logic;
        my_delay : in std_logic_vector(7 downto 0);
        my_address : in std_logic_vector(8 downto 0);
        panel_id : in std_logic_vector(8 downto 0) := (others => '0');
        panel_valid : in std_logic := '0';
        recovery_ready, recovery_reject : in std_logic := '0';
        recovery_status : in std_logic_vector(15 downto 0) := (others => '0');
        tvs_values : in std_logic_vector(63 downto 0) := (others => '0');
        tvs_fresh : in std_logic_vector(3 downto 0) := (others => '0');
        recovery_prepare, recovery_commit : out std_logic
    );
end RS485Registers;

architecture rtl of RS485Registers is
    subtype byte_t is std_logic_vector(7 downto 0);
    type bytes_t is array(natural range <>) of byte_t;
    constant FLAG : byte_t := x"7E";
    constant ESC : byte_t := x"7D";
    constant VERSION : byte_t := x"02";
    constant REQUEST_TYPE : byte_t := x"01";
    constant RESPONSE_TYPE : byte_t := x"02";
    constant MAX_PAYLOAD : natural := 32;
    constant MAX_FRAME : natural := 8 + MAX_PAYLOAD + 2;
    constant STATUS_OK : byte_t := x"00";
    constant STATUS_BAD_LENGTH : byte_t := x"02";
    constant STATUS_CPU_PROTOCOL : byte_t := x"03";

    function crc_byte(crc : unsigned(15 downto 0); b : byte_t) return unsigned is
        variable c : unsigned(15 downto 0) := crc xor resize(unsigned(b), 16);
    begin
        for i in 0 to 7 loop
            if c(0) = '1' then
                c := shift_right(c, 1) xor x"8408";
            else
                c := shift_right(c, 1);
            end if;
        end loop;
        return c;
    end;

    -- Initialize registers only through PRESETn. Declaration initializers can
    -- conflict with resettable storage in the target synthesis flow.
    signal rx_meta, rx_sync : std_logic;
    type uart_rx_state_t is (U_IDLE, U_START, U_DATA, U_STOP, U_BREAK);
    signal uart_rx_state : uart_rx_state_t;
    signal rx_ticks : natural range 0 to CLKS_PER_BIT-1;
    signal rx_bit : natural range 0 to 7;
    signal rx_shift, rx_byte : byte_t;
    signal byte_valid, byte_error : std_logic;

    signal frame_buf : bytes_t(0 to MAX_FRAME-1);
    signal frame_count : natural range 0 to MAX_FRAME;
    signal frame_active, escape_pending : std_logic;
    signal frame_crc : unsigned(15 downto 0);
    signal frame_ticks : natural range 0 to RX_TIMEOUT_CLKS-1;
    signal request_valid, request_control, request_guard : std_logic;
    signal request_cmd, request_length : byte_t;
    signal request_roc, request_id : std_logic_vector(15 downto 0);
    signal crc_errors, frame_errors, frame_timeouts, frame_overflows : unsigned(31 downto 0);

    type engine_state_t is (E_IDLE, E_CPU, E_BUILD, E_TRANSMIT, E_STALE, E_PREPARE, E_RECOVERY_LOCK);
    signal engine : engine_state_t;
    signal rx_ready, active_control, commit_after_ack, resume_stale, recovery_latched : std_logic;
    signal active_cmd, active_status : byte_t;
    signal active_roc, active_id, active_data : std_logic_vector(15 downto 0);
    signal active_delay : std_logic_vector(7 downto 0);
    signal cpu_data : std_logic_vector(15 downto 0);
    signal cpu_status : byte_t;
    signal cpu_wrote : std_logic;
    signal cpu_ticks : natural range 0 to CPU_TIMEOUT_CLKS-1;
    signal build_index : natural range 0 to 12;
    signal build_crc : unsigned(15 downto 0);
    signal reply_buf : bytes_t(0 to 12);
    signal launch_tx, tx_done : std_logic;
    signal accepted, busy_drops, cpu_timeouts, reply_count : unsigned(31 downto 0);

    type uart_tx_state_t is (T_IDLE, T_DELAY, T_DIRECT_DELAY, T_SETUP, T_LOAD, T_BITS);
    type wire_phase_t is (W_OPEN, W_BODY, W_CLOSE, W_DONE);
    signal uart_tx_state : uart_tx_state_t;
    signal wire_phase : wire_phase_t;
    signal tx_en : std_logic;
    signal tx_word : std_logic_vector(9 downto 0);
    signal tx_bit : natural range 0 to 9;
    signal tx_ticks : natural range 0 to CLKS_PER_BIT-1;
    signal delay_ticks : natural range 0 to DELAY_UNIT_CLKS-1;
    signal delay_left : natural range 0 to 255;
    signal direct_ticks : natural range 0 to DIRECT_TURNAROUND_CLKS-1;
    signal setup_ticks : natural range 0 to DE_SETUP_CLKS-1;
    signal wire_index : natural range 0 to 12;
    signal tx_escape : std_logic;
begin
    assert APB_ADDRESS_WIDTH >= 10 and APB_DATA_WIDTH >= 32
        report "RS485Registers requires >=10 address and >=32 data bits" severity failure;
    assert CLKS_PER_BIT >= 8 report "CLKS_PER_BIT must be at least8" severity failure;
    PREADY <= '1';
    PSLVERR <= '0';
    tx_enable <= tx_en;

    -- Synchronize the input even when an upstream design also registers it.
    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            rx_meta <= '1'; rx_sync <= '1';
        elsif rising_edge(PCLK) then
            rx_meta <= rx; rx_sync <= rx_meta;
        end if;
    end process;

    -- Byte reception is independent of CPU acknowledgment. No byte is delivered
    -- until its stop bit is sampled high. A break waits for an idle-high line.
    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            uart_rx_state <= U_IDLE; rx_ticks <= 0; rx_bit <= 0;
            rx_shift <= (others => '0'); rx_byte <= (others => '0');
            byte_valid <= '0'; byte_error <= '0';
        elsif rising_edge(PCLK) then
            byte_valid <= '0'; byte_error <= '0';
            if tx_en = '1' then
                uart_rx_state <= U_IDLE; rx_ticks <= 0; rx_bit <= 0;
            else
                case uart_rx_state is
                    when U_IDLE =>
                        rx_ticks <= 0; rx_bit <= 0;
                        if rx_sync = '0' then uart_rx_state <= U_START; end if;
                    when U_START =>
                        if rx_ticks = (CLKS_PER_BIT-1)/2 then
                            rx_ticks <= 0;
                            if rx_sync = '0' then uart_rx_state <= U_DATA;
                            else uart_rx_state <= U_IDLE; end if;
                        else rx_ticks <= rx_ticks + 1; end if;
                    when U_DATA =>
                        if rx_ticks = CLKS_PER_BIT-1 then
                            rx_ticks <= 0;
                            rx_shift(rx_bit) <= rx_sync;
                            if rx_bit = 7 then uart_rx_state <= U_STOP;
                            else rx_bit <= rx_bit + 1; end if;
                        else rx_ticks <= rx_ticks + 1; end if;
                    when U_STOP =>
                        if rx_ticks = CLKS_PER_BIT-1 then
                            rx_ticks <= 0;
                            if rx_sync = '1' then
                                rx_byte <= rx_shift; byte_valid <= '1'; uart_rx_state <= U_IDLE;
                            else byte_error <= '1'; uart_rx_state <= U_BREAK; end if;
                        else rx_ticks <= rx_ticks + 1; end if;
                    when U_BREAK =>
                        if rx_sync = '1' then uart_rx_state <= U_IDLE; end if;
                end case;
            end if;
        end if;
    end process;

    -- Decode complete frames before address/type dispatch. Delimiters always
    -- restore framing, including after overflow, a dangling escape or bad CRC.
    process(PCLK, PRESETn)
        variable b : byte_t;
        variable dest : std_logic_vector(15 downto 0);
    begin
        if PRESETn = '0' then
            frame_buf <= (others => (others => '0'));
            frame_count <= 0; frame_active <= '0'; escape_pending <= '0';
            frame_crc <= (others => '1'); frame_ticks <= 0;
            request_valid <= '0'; request_control <= '0'; request_guard <= '0'; request_cmd <= (others => '0');
            request_length <= (others => '0'); request_roc <= (others => '0'); request_id <= (others => '0');
            crc_errors <= (others => '0'); frame_errors <= (others => '0');
            frame_timeouts <= (others => '0'); frame_overflows <= (others => '0');
        elsif rising_edge(PCLK) then
            request_valid <= '0';
            if tx_en = '1' then
                frame_active <= '0'; frame_count <= 0; escape_pending <= '0'; frame_ticks <= 0;
            elsif byte_error = '1' then
                frame_active <= '0'; frame_count <= 0; escape_pending <= '0'; frame_ticks <= 0;
                frame_errors <= frame_errors + 1;
            elsif byte_valid = '1' then
                frame_ticks <= 0;
                if rx_byte = FLAG then
                    if frame_active = '1' and (frame_count /= 0 or escape_pending = '1') then
                        if escape_pending = '1' or frame_count < 10 then
                            frame_errors <= frame_errors + 1;
                        elsif frame_crc /= x"F0B8" then
                            crc_errors <= crc_errors + 1;
                        elsif to_integer(unsigned(frame_buf(7))) > MAX_PAYLOAD or
                              frame_count /= 10 + to_integer(unsigned(frame_buf(7))) then
                            frame_errors <= frame_errors + 1;
                        else
                            dest := frame_buf(3) & frame_buf(2);
                            if frame_buf(0) = VERSION and
                               ((frame_buf(1) = REQUEST_TYPE and dest = ("0000000" & my_address)) or
                                (frame_buf(1) = x"03" and panel_valid = '1' and dest = ("0000000" & panel_id))) then
                                request_control <= '0'; request_guard <= '0';
                                if frame_buf(1) = x"03" then request_control <= '1'; end if;
                                if frame_buf(7) = x"04" and frame_buf(8) = x"47" and frame_buf(9) = x"4F" and
                                   frame_buf(10) = x"4C" and frame_buf(11) = x"44" then request_guard <= '1'; end if;
                                request_cmd <= frame_buf(6);
                                request_length <= frame_buf(7);
                                request_roc <= dest;
                                request_id <= frame_buf(5) & frame_buf(4);
                                request_valid <= '1';
                            end if;
                        end if;
                    end if;
                    frame_active <= '1'; frame_count <= 0; escape_pending <= '0';
                    frame_crc <= (others => '1');
                elsif frame_active = '1' then
                    if escape_pending = '0' and rx_byte = ESC then
                        escape_pending <= '1';
                    else
                        b := rx_byte;
                        if escape_pending = '1' then b := rx_byte xor x"20"; end if;
                        escape_pending <= '0';
                        -- Accept only the two canonical escapes specified by v2.
                        if escape_pending = '1' and rx_byte /= x"5E" and rx_byte /= x"5D" then
                            frame_active <= '0'; frame_count <= 0;
                            frame_errors <= frame_errors + 1;
                        elsif frame_count = MAX_FRAME then
                            frame_active <= '0'; frame_count <= 0;
                            frame_overflows <= frame_overflows + 1;
                        else
                            frame_buf(frame_count) <= b;
                            frame_count <= frame_count + 1;
                            frame_crc <= crc_byte(frame_crc, b);
                        end if;
                    end if;
                end if;
            elsif frame_active = '1' and (frame_count /= 0 or escape_pending = '1') then
                if frame_ticks = RX_TIMEOUT_CLKS-1 then
                    frame_active <= '0'; frame_count <= 0; escape_pending <= '0'; frame_ticks <= 0;
                    frame_timeouts <= frame_timeouts + 1;
                else frame_ticks <= frame_ticks + 1; end if;
            else frame_ticks <= 0;
            end if;
        end if;
    end process;

    -- Single transaction slot: ACK clears RX_READY, not request ownership.
    -- Metadata is frozen until the complete response has left the wire.
    process(PCLK, PRESETn)
        variable b : byte_t;
        variable wr, cpu_finished : boolean;
        variable tvs_channel : natural range 0 to 3;
    begin
        if PRESETn = '0' then
            active_control <= '0'; commit_after_ack <= '0'; resume_stale <= '0'; recovery_latched <= '0';
            recovery_prepare <= '0'; recovery_commit <= '0';
            engine <= E_IDLE; rx_ready <= '0'; cpu_wrote <= '0'; cpu_ticks <= 0;
            active_cmd <= (others => '0'); active_status <= STATUS_OK;
            active_roc <= (others => '0'); active_id <= (others => '0');
            active_data <= (others => '0'); active_delay <= (others => '0');
            cpu_data <= (others => '0'); cpu_status <= STATUS_OK;
            build_index <= 0; build_crc <= (others => '1'); launch_tx <= '0';
            reply_buf <= (others => (others => '0'));
            accepted <= (others => '0'); busy_drops <= (others => '0');
            cpu_timeouts <= (others => '0'); reply_count <= (others => '0');
        elsif rising_edge(PCLK) then
            launch_tx <= '0'; recovery_prepare <= '0'; recovery_commit <= '0';
            wr := PSEL = '1' and PENABLE = '1' and PWRITE = '1';
            cpu_finished := wr and PADDR(9 downto 2) = x"07" and PWDATA(0) = '1';
            -- A late CPU completion during a hardware reply is discarded, but
            -- still releases the stale slot once that reply finishes.
            if active_control = '1' and cpu_finished then resume_stale <= '0'; end if;
            if request_valid = '1' and engine /= E_IDLE then busy_drops <= busy_drops + 1; end if;
            -- Hardware control bypasses an absent CPU, including stale telemetry.
            -- It never interrupts a response already being built/transmitted.
            if request_valid = '1' and request_control = '1' and
               (engine = E_IDLE or engine = E_CPU or engine = E_STALE or engine = E_RECOVERY_LOCK) then
                active_control <= '1'; commit_after_ack <= '0';
                resume_stale <= '0';
                if (engine = E_CPU or engine = E_STALE) and not cpu_finished then resume_stale <= '1'; end if;
                rx_ready <= '0'; active_cmd <= request_cmd; active_roc <= request_roc; active_id <= request_id;
                active_delay <= x"00"; -- direct responses use their own turnaround timer
                active_status <= STATUS_OK; active_data <= (others => '0');
                build_index <= 0; build_crc <= (others => '1'); engine <= E_BUILD;
                if request_cmd = x"00" and request_length = x"00" then active_data <= recovery_status;
                elsif request_cmd = x"02" and request_length = x"00" then
                    active_data <= "0000000" & panel_id;
                elsif unsigned(request_cmd) >= 3 and unsigned(request_cmd) <= 6 then
                    tvs_channel := to_integer(unsigned(request_cmd)) - 3;
                    if request_length /= x"00" then active_status <= STATUS_BAD_LENGTH;
                    elsif tvs_fresh(tvs_channel) /= '1' then active_status <= x"07";
                    else active_data <= tvs_values(16*tvs_channel+15 downto 16*tvs_channel); end if;
                elsif request_cmd = x"01" and request_guard = '1' then
                    if recovery_latched = '1' then active_status <= x"06";
                    else recovery_prepare <= '1'; engine <= E_PREPARE; end if;
                elsif request_cmd = x"00" or request_cmd = x"01" or request_cmd = x"02" then active_status <= STATUS_BAD_LENGTH;
                else active_status <= x"01"; end if;
            else
            case engine is
                when E_IDLE =>
                    rx_ready <= '0'; cpu_wrote <= '0'; cpu_ticks <= 0;
                    if request_valid = '1' then
                        active_control <= '0'; commit_after_ack <= '0'; resume_stale <= '0';
                        accepted <= accepted + 1;
                        active_cmd <= request_cmd; active_roc <= request_roc; active_id <= request_id;
                        active_delay <= my_delay; active_data <= (others => '0');
                        active_status <= STATUS_OK; cpu_status <= STATUS_OK; cpu_data <= (others => '0');
                        build_index <= 0; build_crc <= (others => '1');
                        if request_length /= x"00" then
                            active_status <= STATUS_BAD_LENGTH; engine <= E_BUILD;
                        else
                            -- Command semantics belong to the CPU. Deliver all
                            -- 256 command values after transport validation.
                            rx_ready <= '1'; engine <= E_CPU;
                        end if;
                    end if;
                when E_CPU =>
                    if wr then
                        case PADDR(9 downto 2) is
                            when x"03" => cpu_data <= PWDATA(15 downto 0); cpu_wrote <= '1';
                            when x"05" => if PWDATA(0) = '1' then rx_ready <= '0'; end if;
                            when x"08" => cpu_status <= PWDATA(7 downto 0);
                            when others => null;
                        end case;
                    end if;
                    if wr and PADDR(9 downto 2) = x"07" and PWDATA(0) = '1' then
                        rx_ready <= '0';
                        if cpu_wrote = '1' and rx_ready = '0' then
                            active_data <= cpu_data; active_status <= cpu_status;
                        else active_data <= (others => '0'); active_status <= STATUS_CPU_PROTOCOL; end if;
                        build_index <= 0; build_crc <= (others => '1'); engine <= E_BUILD;
                    elsif cpu_ticks = CPU_TIMEOUT_CLKS-1 then
                        -- Do not relabel a late CPU reply as a subsequent request.
                        -- Discard it in E_STALE before accepting another request.
                        rx_ready <= '0'; cpu_timeouts <= cpu_timeouts + 1; engine <= E_STALE;
                    else cpu_ticks <= cpu_ticks + 1; end if;
                when E_STALE =>
                    if wr and PADDR(9 downto 2) = x"07" and PWDATA(0) = '1' then engine <= E_IDLE; end if;
                when E_PREPARE =>
                    if recovery_ready = '1' then commit_after_ack <= '1'; engine <= E_BUILD;
                    elsif recovery_reject = '1' then active_status <= x"06"; engine <= E_BUILD; end if;
                when E_RECOVERY_LOCK => null;
                when E_BUILD =>
                    b := (others => '0');
                    case build_index is
                        when 0 => b := VERSION;
                        when 1 => if active_control = '1' then b := x"04"; else b := RESPONSE_TYPE; end if;
                        when 2 => b := active_roc(7 downto 0);
                        when 3 => b := active_roc(15 downto 8);
                        when 4 => b := active_id(7 downto 0);
                        when 5 => b := active_id(15 downto 8);
                        when 6 => b := active_cmd;
                        when 7 => b := x"03";
                        when 8 => b := active_status;
                        when 9 => b := active_data(7 downto 0);
                        when 10 => b := active_data(15 downto 8);
                        when 11 => b := std_logic_vector(not build_crc(7 downto 0));
                        when 12 => b := std_logic_vector(not build_crc(15 downto 8));
                    end case;
                    reply_buf(build_index) <= b;
                    if build_index <= 10 then build_crc <= crc_byte(build_crc, b); end if;
                    if build_index = 12 then launch_tx <= '1'; engine <= E_TRANSMIT;
                    else build_index <= build_index + 1; end if;
                when E_TRANSMIT =>
                    if tx_done = '1' then
                        reply_count <= reply_count + 1;
                        if commit_after_ack = '1' then
                            recovery_commit <= '1'; recovery_latched <= '1'; engine <= E_RECOVERY_LOCK;
                        elsif recovery_latched = '1' then engine <= E_RECOVERY_LOCK;
                        elsif resume_stale = '1' and not cpu_finished then engine <= E_STALE;
                        else engine <= E_IDLE; end if;
                    end if;
            end case;
            end if;
        end if;
    end process;

    -- Continuous driver enable across opening flag, escaped body and closing
    -- flag. The response buffer cannot change while this process is active.
    process(PCLK, PRESETn)
        variable b : byte_t;
    begin
        if PRESETn = '0' then
            uart_tx_state <= T_IDLE; wire_phase <= W_OPEN; tx <= '1'; tx_en <= '0'; tx_done <= '0';
            tx_word <= (others => '1'); tx_bit <= 0; tx_ticks <= 0;
            delay_ticks <= 0; delay_left <= 0; direct_ticks <= 0; setup_ticks <= 0; wire_index <= 0; tx_escape <= '0';
        elsif rising_edge(PCLK) then
            tx_done <= '0';
            case uart_tx_state is
                when T_IDLE =>
                    tx <= '1'; tx_en <= '0';
                    if launch_tx = '1' then
                        delay_left <= to_integer(unsigned(active_delay)); delay_ticks <= 0;
                        wire_phase <= W_OPEN; wire_index <= 0; tx_escape <= '0';
                        if active_control = '1' then
                            direct_ticks <= 0; uart_tx_state <= T_DIRECT_DELAY;
                        else uart_tx_state <= T_DELAY; end if;
                    end if;
                when T_DELAY =>
                    if delay_left = 0 then
                        tx_en <= '1'; setup_ticks <= 0; uart_tx_state <= T_SETUP;
                    elsif delay_ticks = DELAY_UNIT_CLKS-1 then
                        delay_ticks <= 0; delay_left <= delay_left - 1;
                    else delay_ticks <= delay_ticks + 1; end if;
                when T_DIRECT_DELAY =>
                    -- Fixed hardware-response turnaround, independent of the
                    -- CPU's my_delay and DELAY_UNIT_CLKS. Give the Pi time to
                    -- release its driver before asserting our driver enable.
                    if direct_ticks = DIRECT_TURNAROUND_CLKS-1 then
                        tx_en <= '1'; setup_ticks <= 0; uart_tx_state <= T_SETUP;
                    else direct_ticks <= direct_ticks + 1; end if;
                when T_SETUP =>
                    if setup_ticks = DE_SETUP_CLKS-1 then uart_tx_state <= T_LOAD;
                    else setup_ticks <= setup_ticks + 1; end if;
                when T_LOAD =>
                    b := FLAG;
                    case wire_phase is
                        when W_OPEN => wire_phase <= W_BODY;
                        when W_BODY =>
                            b := reply_buf(wire_index);
                            if tx_escape = '0' and (b = FLAG or b = ESC) then
                                b := ESC; tx_escape <= '1';
                            else
                                if tx_escape = '1' then b := b xor x"20"; end if;
                                tx_escape <= '0';
                                if wire_index = 12 then wire_phase <= W_CLOSE;
                                else wire_index <= wire_index + 1; end if;
                            end if;
                        when W_CLOSE => wire_phase <= W_DONE;
                        when W_DONE => null;
                    end case;
                    tx_word <= '1' & b & '0'; tx <= '0'; tx_bit <= 0; tx_ticks <= 0;
                    uart_tx_state <= T_BITS;
                when T_BITS =>
                    if tx_ticks = CLKS_PER_BIT-1 then
                        tx_ticks <= 0;
                        if tx_bit = 9 then
                            tx <= '1';
                            if wire_phase = W_DONE then
                                tx_en <= '0'; tx_done <= '1'; uart_tx_state <= T_IDLE;
                            else uart_tx_state <= T_LOAD; end if;
                        else tx_bit <= tx_bit + 1; tx <= tx_word(tx_bit+1); end if;
                    else tx_ticks <= tx_ticks + 1; end if;
            end case;
        end if;
    end process;

    -- Combinational APB read mux: valid throughout setup/access (PREADY=1).
    process(PSEL, PWRITE, PADDR, rx_ready, active_cmd, engine, cpu_status,
            active_id, active_roc, crc_errors, frame_errors, frame_timeouts,
            frame_overflows, busy_drops, cpu_timeouts, accepted, reply_count)
        variable d : std_logic_vector(APB_DATA_WIDTH-1 downto 0);
    begin
        d := (others => '0');
        if PSEL = '1' and PWRITE = '0' then
            case PADDR(9 downto 2) is
                when x"01" => d(0) := rx_ready;
                when x"02" => d(7 downto 0) := active_cmd;
                when x"06" => if engine /= E_IDLE then d(0) := '1'; end if;
                when x"08" => d(7 downto 0) := cpu_status;
                when x"09" => d(31 downto 0) := x"00020020"; -- version2 / payload cap32
                when x"0A" => d(31 downto 0) := active_roc & active_id;
                when x"0B" => d(7 downto 0) := std_logic_vector(to_unsigned(engine_state_t'pos(engine), 8));
                when x"10" => d(31 downto 0) := std_logic_vector(crc_errors);
                when x"11" => d(31 downto 0) := std_logic_vector(frame_errors);
                when x"12" => d(31 downto 0) := std_logic_vector(frame_timeouts);
                when x"13" => d(31 downto 0) := std_logic_vector(frame_overflows);
                when x"14" => d(31 downto 0) := std_logic_vector(busy_drops);
                when x"15" => d(31 downto 0) := std_logic_vector(cpu_timeouts);
                when x"16" => d(31 downto 0) := std_logic_vector(accepted);
                when x"17" => d(31 downto 0) := std_logic_vector(reply_count);
                when others => null;
            end case;
        end if;
        PRDATA <= d;
    end process;
end rtl;
