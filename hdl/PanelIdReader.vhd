-- Read the panel ID from plaintext sNVM page 0 without the Mi-V CPU.
-- Own PF_SYSTEM_SERVICES from common reset through the complete transaction;
-- afterwards pass CPU APB accesses through. See docs/panel-id-reader.md.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PanelIdReader is
    generic (
        SNVM_PAGE : natural range 0 to 221 := 0;
        MIN_PANEL_ID : natural range 0 to 511 := 1;
        MAX_PANEL_ID : natural range 0 to 511 := 511;
        TIMEOUT_CLKS : positive := 50000000 -- 1 s at the existing 50 MHz PCLK
    );
    port (
        PCLK, PRESETn : in std_logic;
        -- CPU-facing APB target, formerly connected straight to System Services.
        S_PADDR, S_PWDATA : in std_logic_vector(31 downto 0);
        S_PSEL, S_PENABLE, S_PWRITE : in std_logic;
        S_PRDATA : out std_logic_vector(31 downto 0);
        S_PREADY, S_PSLVERR : out std_logic;
        -- APB initiator connected only to PF_SYSTEM_SERVICES.APBSlave.
        M_PADDR, M_PWDATA : out std_logic_vector(31 downto 0);
        M_PSEL, M_PENABLE, M_PWRITE : out std_logic;
        M_PRDATA : in std_logic_vector(31 downto 0);
        M_PREADY, M_PSLVERR : in std_logic;
        PANEL_ID : out std_logic_vector(8 downto 0);
        PANEL_VALID : out std_logic;
        -- [0] busy, [1] done, [2] valid, [3] quarantined,
        -- [15:8] local error, [31:16] System Controller status (FFFF: unread).
        STATUS : out std_logic_vector(31 downto 0)
    );
end PanelIdReader;

architecture rtl of PanelIdReader is
    type operation_t is (WAIT_IDLE, CMD, WCNT, WADDR, RCNT, RADDR, REQUEST,
                         WRITE_INPUT, WAIT_WORD, CHECK_ECC, READ_WORD,
                         WAIT_DONE, READ_STATUS, CPU_SETUP, CPU_PASS, FAILED);
    type phase_t is (BUS_IDLE, BUS_SETUP, BUS_ACCESS);
    signal op : operation_t := WAIT_IDLE;
    signal phase : phase_t := BUS_IDLE;
    signal addr, wdata, rdata : std_logic_vector(31 downto 0) := (others => '0');
    signal wr, transfer_done, transfer_error : std_logic := '0';
    signal requested_addr, requested_data : std_logic_vector(31 downto 0);
    signal requested_write, launch : std_logic;
    signal timer : natural range 0 to TIMEOUT_CLKS-1 := 0;
    signal input_word : natural range 0 to 3 := 0;
    signal output_word : natural range 0 to 63 := 0;
    signal candidate : unsigned(15 downto 0) := (others => '0');
    signal id_reg : std_logic_vector(8 downto 0) := (others => '0');
    signal valid_reg, done_reg : std_logic := '0';
    signal error_code : std_logic_vector(7 downto 0) := x"00";
    signal service_status : std_logic_vector(15 downto 0) := x"FFFF";
begin
    assert MIN_PANEL_ID <= MAX_PANEL_ID report "Invalid panel ID range" severity failure;
    PANEL_ID <= id_reg;
    PANEL_VALID <= valid_reg;
    STATUS(31 downto 16) <= service_status;
    STATUS(15 downto 8) <= error_code;
    STATUS(7 downto 4) <= (others => '0');
    STATUS(3) <= '1' when op = FAILED else '0';
    STATUS(2) <= valid_reg;
    STATUS(1) <= done_reg;
    STATUS(0) <= not done_reg;

    -- Follow execute_ss_command()/SYS_secure_nvm_read() in the ROC driver.
    -- Counts and mailbox offsets are WORDS. Drain all 64 returned words,
    -- including the admin word, before allowing CPU ownership.
    process(op, input_word)
    begin
        requested_addr <= x"00000030";
        requested_data <= (others => '0');
        requested_write <= '0';
        launch <= '1';
        case op is
            when CMD => requested_addr <= x"00000004"; requested_data <= x"00000018"; requested_write <= '1';
            when WCNT => requested_addr <= x"00000014"; requested_data <= x"00000004"; requested_write <= '1';
            when WADDR => requested_addr <= x"0000001C"; requested_write <= '1';
            when RCNT => requested_addr <= x"00000018"; requested_data <= x"00000040"; requested_write <= '1';
            when RADDR => requested_addr <= x"00000020"; requested_data <= x"00000004"; requested_write <= '1';
            when REQUEST => requested_addr <= x"0000000C"; requested_data <= x"00000001"; requested_write <= '1';
            when WRITE_INPUT =>
                requested_addr <= x"00000028"; requested_write <= '1';
                if input_word = 0 then
                    requested_data <= std_logic_vector(to_unsigned(SNVM_PAGE, 32));
                end if;
            when CHECK_ECC => requested_addr <= x"00000010";
            when READ_WORD => requested_addr <= x"0000002C";
            when READ_STATUS => requested_addr <= x"00000008";
            when CPU_SETUP | CPU_PASS | FAILED => launch <= '0';
            when others => null;
        end case;
    end process;

    -- Bus engine never abandons an APB access, even if the global deadline
    -- expires. On timeout the CPU is isolated until common reset; a hung
    -- downstream access stays stable until its PREADY eventually arrives.
    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            phase <= BUS_IDLE; transfer_done <= '0'; transfer_error <= '0';
            addr <= (others => '0'); wdata <= (others => '0');
            rdata <= (others => '0'); wr <= '0';
        elsif rising_edge(PCLK) then
            transfer_done <= '0';
            case phase is
                when BUS_IDLE =>
                    if launch = '1' and transfer_done = '0' and timer < TIMEOUT_CLKS-1 then
                        addr <= requested_addr; wdata <= requested_data;
                        wr <= requested_write; phase <= BUS_SETUP;
                    end if;
                when BUS_SETUP => phase <= BUS_ACCESS;
                when BUS_ACCESS =>
                    if M_PREADY = '1' then
                        rdata <= M_PRDATA; transfer_error <= M_PSLVERR;
                        transfer_done <= '1'; phase <= BUS_IDLE;
                    end if;
            end case;
        end if;
    end process;

    process(op, phase, addr, wdata, wr, S_PADDR, S_PWDATA, S_PSEL,
            S_PENABLE, S_PWRITE, M_PRDATA, M_PREADY, M_PSLVERR, PRESETn)
    begin
        M_PADDR <= addr; M_PWDATA <= wdata; M_PWRITE <= wr;
        M_PSEL <= '0'; M_PENABLE <= '0';
        S_PRDATA <= (others => '0'); S_PREADY <= '0'; S_PSLVERR <= '0';
        if phase /= BUS_IDLE then M_PSEL <= '1'; end if;
        if phase = BUS_ACCESS then M_PENABLE <= '1'; end if;
        if op = CPU_SETUP or op = CPU_PASS then
            M_PADDR <= S_PADDR; M_PWDATA <= S_PWDATA; M_PWRITE <= S_PWRITE;
            M_PSEL <= S_PSEL;
            if op = CPU_PASS then
                M_PENABLE <= S_PENABLE;
                S_PRDATA <= M_PRDATA; S_PREADY <= M_PREADY; S_PSLVERR <= M_PSLVERR;
            end if;
        elsif op = FAILED then
            -- Complete CPU requests with a bus error, never with stale data.
            S_PREADY <= '1'; S_PSLVERR <= S_PSEL and S_PENABLE;
        end if;
        if PRESETn = '0' then
            M_PSEL <= '0'; M_PENABLE <= '0'; S_PREADY <= '0'; S_PSLVERR <= '0';
        end if;
    end process;

    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            op <= WAIT_IDLE; timer <= 0; input_word <= 0; output_word <= 0;
            candidate <= (others => '0'); id_reg <= (others => '0');
            valid_reg <= '0'; done_reg <= '0'; error_code <= x"00";
            service_status <= x"FFFF";
        elsif rising_edge(PCLK) then
            if op = CPU_SETUP then
                -- Insert an APB setup cycle for a CPU access stalled at boot.
                op <= CPU_PASS;
            elsif op /= CPU_PASS and op /= FAILED then
                if timer = TIMEOUT_CLKS-1 then
                    error_code <= x"01"; done_reg <= '1'; op <= FAILED;
                else
                    timer <= timer + 1;
                    if transfer_done = '1' then
                        if transfer_error = '1' then
                            error_code <= x"02"; done_reg <= '1'; op <= FAILED;
                        else
                            case op is
                                when WAIT_IDLE =>
                                    if rdata(2) = '1' or rdata(1) = '1' then
                                        error_code <= x"03"; done_reg <= '1'; op <= FAILED;
                                    elsif rdata(0) = '0' then op <= CMD; end if;
                                when CMD => op <= WCNT;
                                when WCNT => op <= WADDR;
                                when WADDR => op <= RCNT;
                                when RCNT => op <= RADDR;
                                when RADDR => op <= REQUEST;
                                when REQUEST => op <= WRITE_INPUT;
                                when WRITE_INPUT =>
                                    if input_word = 3 then op <= WAIT_WORD;
                                    else input_word <= input_word + 1; end if;
                                when WAIT_WORD =>
                                    if rdata(2) = '1' then
                                        error_code <= x"03"; done_reg <= '1'; op <= FAILED;
                                    elsif rdata(1) = '1' then op <= CHECK_ECC;
                                    end if;
                                when CHECK_ECC =>
                                    -- Conservatively reject ANY mailbox ECC indication,
                                    -- but drain the transaction to permit safe handoff.
                                    if rdata(1 downto 0) /= "00" then error_code <= x"04"; end if;
                                    op <= READ_WORD;
                                when READ_WORD =>
                                    -- response[0] is page admin, response[1] begins data.
                                    if output_word = 1 then candidate <= unsigned(rdata(15 downto 0)); end if;
                                    if output_word = 63 then op <= WAIT_DONE;
                                    else output_word <= output_word + 1; op <= WAIT_WORD; end if;
                                when WAIT_DONE =>
                                    if rdata(2) = '1' or rdata(1) = '1' then
                                        error_code <= x"03"; done_reg <= '1'; op <= FAILED;
                                    elsif rdata(0) = '0' then op <= READ_STATUS; end if;
                                when READ_STATUS =>
                                    service_status <= rdata(15 downto 0);
                                    done_reg <= '1'; op <= CPU_SETUP;
                                    if rdata(15 downto 0) /= x"0000" then error_code <= x"05";
                                    elsif error_code /= x"00" then null;
                                    elsif candidate < MIN_PANEL_ID or candidate > MAX_PANEL_ID then error_code <= x"06";
                                    else id_reg <= std_logic_vector(candidate(8 downto 0)); valid_reg <= '1'; end if;
                                when others => null;
                            end case;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
end rtl;
