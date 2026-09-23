-- Runtime FPGA-only activation of SPI directory index 0.
-- Insert AFTER PanelIdReader and BEFORE PF_SYSTEM_SERVICES. No CPU reset or
-- interrupted-transaction recovery: refuse an owned/busy mailbox or active SPI.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity GoldenImageRecovery is
    generic (TIMEOUT_CLKS : positive := 50000000);
    port (
        PCLK, PRESETn : in std_logic;
        S_PADDR, S_PWDATA : in std_logic_vector(31 downto 0);
        S_PSEL, S_PENABLE, S_PWRITE : in std_logic;
        S_PRDATA : out std_logic_vector(31 downto 0);
        S_PREADY, S_PSLVERR : out std_logic;
        M_PADDR, M_PWDATA : out std_logic_vector(31 downto 0);
        M_PSEL, M_PENABLE, M_PWRITE : out std_logic;
        M_PRDATA : in std_logic_vector(31 downto 0);
        M_PREADY, M_PSLVERR : in std_logic;
        PANEL_VALID, PREPARE, COMMIT : in std_logic;
        READY, DENIED : out std_logic;
        SPI_CS_N : in std_logic;
        SPI_RESET_N : out std_logic;
        -- [0] armed, [1] committed, [2] error, [3] owns interface;
        -- [15:8] local error; [31:16] returned IAP status (FFFF until read).
        STATUS : out std_logic_vector(31 downto 0)
    );
end;
architecture rtl of GoldenImageRecovery is
    type state_t is (PASS_CPU, CLAIM, CHECK_IDLE, ARMED, PROGRAM_IMAGE,
                     POLL_DONE, READ_RESULT, HANDOFF, LOCKED);
    type phase_t is (IDLE, SETUP, BUS_ACCESS);
    signal state : state_t;
    signal phase : phase_t;
    signal cpu_owned, committed, done, bus_error : std_logic;
    signal addr, data, result : std_logic_vector(31 downto 0);
    signal wr, launch : std_logic;
    signal timer : natural range 0 to TIMEOUT_CLKS-1;
    signal step : natural range 0 to 6;
    signal error_code : std_logic_vector(7 downto 0);
    signal service_status : std_logic_vector(15 downto 0);
    signal req_addr, req_data : std_logic_vector(31 downto 0);
    signal req_write, owns : std_logic;
begin
    owns <= '0' when state = PASS_CPU or state = CLAIM or state = HANDOFF else '1';
    SPI_RESET_N <= PRESETn and not owns;
    READY <= '1' when state = ARMED else '0';
    STATUS(31 downto 16) <= service_status;
    STATUS(15 downto 8) <= error_code;
    STATUS(7 downto 4) <= "0000";
    STATUS(3) <= owns;
    STATUS(2) <= '1' when error_code /= x"00" else '0';
    STATUS(1) <= committed;
    STATUS(0) <= '1' when state = ARMED else '0';

    -- Track whole upstream service transactions, including command preparation.
    -- The existing ROC driver finishes every transaction by reading SS_STAT.
    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then cpu_owned <= '0';
        elsif rising_edge(PCLK) then
            if (state = PASS_CPU or state = CLAIM) and S_PSEL = '1' and
               S_PENABLE = '1' and M_PREADY = '1' then
                if S_PWRITE = '1' then cpu_owned <= '1';
                elsif S_PADDR(7 downto 0) = x"08" and M_PSLVERR = '0' then cpu_owned <= '0';
                end if;
            end if;
        end if;
    end process;

    process(state, step)
    begin
        req_addr <= x"00000030"; req_data <= (others => '0'); req_write <= '0'; launch <= '0';
        case state is
            when CHECK_IDLE | POLL_DONE => launch <= '1';
            when READ_RESULT => launch <= '1'; req_addr <= x"00000008";
            when PROGRAM_IMAGE =>
                launch <= '1'; req_write <= '1';
                -- Same register sequence as SYS_iap_service(0x42, 0).
                -- Explicitly clear stale NVM read descriptors before requesting IAP.
                case step is
                    when 0 => req_addr <= x"00000004"; req_data <= x"00000042";
                    when 1 => req_addr <= x"00000014"; req_data <= x"00000001";
                    when 2 => req_addr <= x"0000001C";
                    when 3 => req_addr <= x"00000018";
                    when 4 => req_addr <= x"00000020";
                    when 5 => req_addr <= x"0000000C"; req_data <= x"00000001";
                    when 6 => req_addr <= x"00000028"; -- index 0, no arbitrary address
                end case;
            when others => null;
        end case;
    end process;

    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            phase <= IDLE; done <= '0'; bus_error <= '0'; wr <= '0';
            addr <= (others => '0'); data <= (others => '0'); result <= (others => '0');
        elsif rising_edge(PCLK) then
            done <= '0';
            case phase is
                when IDLE =>
                    if launch = '1' and done = '0' and timer < TIMEOUT_CLKS-1 then
                        addr <= req_addr; data <= req_data; wr <= req_write; phase <= SETUP;
                    end if;
                when SETUP => phase <= BUS_ACCESS;
                when BUS_ACCESS =>
                    if M_PREADY = '1' then
                        result <= M_PRDATA; bus_error <= M_PSLVERR; done <= '1'; phase <= IDLE;
                    end if;
            end case;
        end if;
    end process;

    process(state, phase, addr, data, wr, S_PADDR, S_PWDATA, S_PSEL, S_PENABLE,
            S_PWRITE, M_PRDATA, M_PREADY, M_PSLVERR, PRESETn)
    begin
        M_PADDR <= addr; M_PWDATA <= data; M_PWRITE <= wr;
        M_PSEL <= '0'; M_PENABLE <= '0';
        S_PRDATA <= (others => '0'); S_PREADY <= '0'; S_PSLVERR <= '0';
        if phase /= IDLE then M_PSEL <= '1'; end if;
        if phase = BUS_ACCESS then M_PENABLE <= '1'; end if;
        if state = PASS_CPU or state = CLAIM or state = HANDOFF then
            M_PADDR <= S_PADDR; M_PWDATA <= S_PWDATA; M_PWRITE <= S_PWRITE; M_PSEL <= S_PSEL;
            if state /= HANDOFF then
                M_PENABLE <= S_PENABLE; S_PRDATA <= M_PRDATA;
                S_PREADY <= M_PREADY; S_PSLVERR <= M_PSLVERR;
            end if;
        elsif state = LOCKED then
            S_PREADY <= '1'; S_PSLVERR <= S_PSEL and S_PENABLE;
        end if;
        if PRESETn = '0' then M_PSEL <= '0'; M_PENABLE <= '0'; S_PREADY <= '0'; S_PSLVERR <= '0'; end if;
    end process;

    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            state <= PASS_CPU; timer <= 0; step <= 0; committed <= '0'; DENIED <= '0';
            error_code <= x"00"; service_status <= x"FFFF";
        elsif rising_edge(PCLK) then
            DENIED <= '0';
            if PREPARE = '1' and state /= PASS_CPU then DENIED <= '1'; end if;
            case state is
                when PASS_CPU =>
                    if PREPARE = '1' then
                        if PANEL_VALID = '0' then DENIED <= '1'; error_code <= x"10";
                        else timer <= 0; error_code <= x"00"; state <= CLAIM; end if;
                    end if;
                when CLAIM =>
                    -- Do not preempt even a partially prepared CPU transaction.
                    if cpu_owned = '1' or SPI_CS_N = '0' or timer = TIMEOUT_CLKS-1 then
                        DENIED <= '1'; error_code <= x"11"; state <= PASS_CPU;
                    elsif S_PSEL = '0' then timer <= 0; state <= CHECK_IDLE;
                    else timer <= timer + 1; end if;
                when HANDOFF => state <= PASS_CPU;
                when LOCKED => null; -- no retry/reprogramming until common reset
                when others =>
                    if timer = TIMEOUT_CLKS-1 then
                        error_code <= x"12"; DENIED <= '1';
                        if state = ARMED then state <= HANDOFF; else state <= LOCKED; end if;
                    else
                        timer <= timer + 1;
                        if state = ARMED then
                            if COMMIT = '1' then
                                committed <= '1'; step <= 0; timer <= 0; state <= PROGRAM_IMAGE;
                            end if;
                        elsif done = '1' then
                            if bus_error = '1' then error_code <= x"13"; DENIED <= '1'; state <= LOCKED;
                            else
                                case state is
                                    when CHECK_IDLE =>
                                        if result(2 downto 0) /= "000" then
                                            DENIED <= '1'; error_code <= x"11"; state <= HANDOFF;
                                        else timer <= 0; state <= ARMED; end if;
                                    when PROGRAM_IMAGE =>
                                        if step = 6 then state <= POLL_DONE;
                                        else step <= step + 1; end if;
                                    when POLL_DONE =>
                                        if result(2) = '1' then error_code <= x"14"; state <= LOCKED;
                                        elsif result(0) = '0' then state <= READ_RESULT; end if;
                                    when READ_RESULT =>
                                        service_status <= result(15 downto 0); state <= LOCKED;
                                        if result(15 downto 0) /= x"0000" then error_code <= x"15"; end if;
                                    when others => null;
                                end case;
                            end if;
                        end if;
                    end if;
            end case;
        end if;
    end process;
end;
