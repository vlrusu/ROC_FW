--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: ErrorCounter.vhd
-- File history:
--      <v1>: <Feb. 17,2024>: Register fast signals to easy timing
--      <v2>: <June 20,2024>: Move XCVR errors to CTRL_CLK
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ErrorCounter is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    CTRL_RESET_N : IN std_logic;
    CTRL_CLK : IN std_logic;

    rx_val : in std_logic;
    aligned : in std_logic;
    rx_err : in std_logic;
    b_cerr : in std_logic_vector(1 downto 0);
    invalid_k : in std_logic_vector(1 downto 0);
    code_err_n : in std_logic_vector(1 downto 0);
    rd_err : in std_logic_vector(1 downto 0);
    rx_crc_error : in std_logic_vector(15 downto 0);
    rx_packet_error : in std_logic_vector(15 downto 0);
    dreq_crc_error : in std_logic_vector(15 downto 0);
    seq_error_counter : in std_logic_vector(15 downto 0);
    marker_error : in std_logic_vector(15 downto 0);
    clock_marker_counter : in std_logic_vector(15 downto 0);
    loop_marker_counter : in std_logic_vector(15 downto 0);
    other_marker_counter : in std_logic_vector(15 downto 0);
    retr_marker_counter : in std_logic_vector(15 downto 0);
    ewm_out_counter : in std_logic_vector(15 downto 0);         --  markers sent to the DIGIs
    start_fetch_counter : in std_logic_vector(15 downto 0);     -- PREFETCH or DREQ
    any_marker_counter : in std_logic_vector(15 downto 0);
    dcs_counter : in std_logic_vector(15 downto 0);
    dreq_full_counter : in std_logic_vector(15 downto 0);
    invalid_hb_counter : in std_logic_vector(15 downto 0);
    hb_bad_crc_counter : in std_logic_vector(15 downto 0);
    hb_tag_full_counter : in std_logic_vector(15 downto 0);
    spilltag_full_counter : in std_logic_vector(15 downto 0);
   
    dreq_timeout_counter : in std_logic_vector(15 downto 0);
    hb_empty_overlap_counter : in std_logic_vector(15 downto 0);
    ew_fifo_emptied_counter : in std_logic_vector(15 downto 0);
    tag_valid_counter : in std_logic_vector(15 downto 0);
    tag_error_counter : in std_logic_vector(15 downto 0);
    comma_error_counter : in std_logic_vector(15 downto 0);
    is_skipped_dreq_cnt : in std_logic_vector(15 downto 0);
    bad_marker_cnt      : in std_logic_vector(15 downto 0);
    
    dreq_state      : in std_logic_vector(7 downto 0);
    rocfifocntrl_state : in std_logic_vector(7 downto 0);
    ewtag_state     : in std_logic_vector(2 downto 0);
    datareq_state   : in std_logic_vector(1 downto 0);
    dcs_proc_state  : in std_logic_vector(7 downto 0);
    dcs_rx_state    : in std_logic_vector(7 downto 0);
    dcs_tx_state    : in std_logic_vector(7 downto 0);
    
    fetch_state     : in std_logic_vector(1 downto 0);
    fetch_event_tag : in std_logic_vector(47 downto 0);
    next_read_event_tag : in std_logic_vector(47 downto 0);
    missed_fetch_cnt    : in std_logic_vector(15 downto 0);
    
    reqType_debug : in std_logic_vector(3 downto 0);
    reqEventWindowTag_debug     : in std_logic_vector(47 downto 0);
    fetchEventWindowTag_debug   : in std_logic_vector(47 downto 0);
    
    end_ewm     : in std_logic;
    
    dcs_error_en    : in std_logic;  -- must be 
    dcs_address     : in std_logic_vector(7 downto 0);
    serial_address  : in std_logic_vector(7 downto 0);
    counter_out     : out std_logic_vector(15 downto 0)
    --<other_ports>;
);
end ErrorCounter;
architecture architecture_ErrorCounter of ErrorCounter is

    signal address          : std_logic_vector(7 downto 0);
    signal dcs_address_latch: std_logic_vector(7 downto 0);
    signal dcs_error_reg    : std_logic;
    signal dcs_error_latch  : std_logic;

    signal rx_val_reg   : std_logic;
    signal aligned_reg  : std_logic;
    signal rx_err_reg   : std_logic;
    signal b_cerr_reg   : std_logic_vector(1 downto 0);
    signal invalid_k_reg: std_logic_vector(1 downto 0);
    signal code_errn_reg: std_logic_vector(1 downto 0);
    signal rd_err_reg   : std_logic_vector(1 downto 0);
    
    signal clk_counter  : unsigned(15 downto 0);
    signal rx_val_counter   : unsigned(15 downto 0);
    signal aligned_counter  : unsigned(15 downto 0);
    signal rx_err_counter   : unsigned(15 downto 0);
    signal b_cerr_counter   : unsigned(15 downto 0);
    signal invalid_k_counter    : unsigned(15 downto 0);
    signal code_err_n_counter   : unsigned(15 downto 0);
    signal rd_err_counter   : unsigned(15 downto 0);
    signal event_window_seen: unsigned(15 downto 0);

begin

-- select between fiber and serial read of Error Counter (must be set AFTER passing address via fiber)
    address <= dcs_address_latch      when dcs_error_en = '1'     else serial_address;

    process(reset_n, clk)
    begin
    if reset_n = '0' then
     
        clk_counter     <= (others => '0');
        counter_out     <= (others => '0');
        event_window_seen   <= (others => '0');
        
    elsif rising_edge(clk) then
     
        -- latch DCS_ERROR_EN twice to help with Cross-Domain of 200 MHz clock 
        dcs_error_reg   <= dcs_error_en;
        dcs_error_latch <= dcs_error_reg;
        -- latch DCS_ADDRESS so we can reuse same register to read back the content
        if  (dcs_error_reg = '1' and dcs_error_latch = '0')then
            dcs_address_latch <= dcs_address;
        end if;
        
        if address = X"00" then  -- debug error counter
            counter_out <= X"4321";
        elsif address = X"01" then
            counter_out <= std_logic_vector(rx_val_counter);
        elsif address = X"02" then
            counter_out <= std_logic_vector(rx_err_counter);
        elsif address = X"03" then
            counter_out <= std_logic_vector(b_cerr_counter);
        elsif address = X"04" then
            counter_out <= std_logic_vector(invalid_k_counter);
        elsif address = X"05" then
            counter_out <= std_logic_vector(code_err_n_counter);
        elsif address = X"06" then
            counter_out <= std_logic_vector(rd_err_counter);
        elsif address = X"07" then
            counter_out <= std_logic_vector(aligned_counter);
        elsif address = X"08" then
            counter_out <= std_logic_vector(clk_counter);
        elsif address = X"09" then
            counter_out <= rx_crc_error;
        elsif address = X"0A" then -- 10
            counter_out <= rx_packet_error;
        elsif address = X"0B" then -- 11
            counter_out <= std_logic_vector(event_window_seen);
        elsif address = X"0C" then -- 12
            counter_out <= dreq_crc_error;
        elsif address = X"0D" then -- 13
            counter_out <= seq_error_counter;
        elsif address = X"0E" then -- 14
            counter_out <= marker_error;
        elsif address = X"0F" then -- 15
            counter_out <= ewm_out_counter; -- this is a counter of EWM markers sent to the DIGIs (both internal and from DTC)
        elsif address = X"10" then -- 16
            counter_out <= any_marker_counter;            
        elsif address = X"11" then -- 17
            counter_out <= clock_marker_counter;
        elsif address = X"12" then  -- 18
            counter_out <= loop_marker_counter;
        elsif address = X"13" then  -- 19
            counter_out <= other_marker_counter;
        elsif address = X"14" then  -- 20
            counter_out <= retr_marker_counter;
        elsif address = X"15" then  -- 21
            counter_out <= dreq_timeout_counter;
        elsif address = X"16" then  -- 22
            counter_out <= tag_valid_counter;
        elsif address = X"17" then  -- 23
            counter_out <= missed_fetch_cnt;
        elsif address = X"18" then  -- 24
            counter_out <= is_skipped_dreq_cnt;
        elsif address = X"19" then  -- 25
            counter_out <= bad_marker_cnt;
        elsif address = X"1A" then      -- 26
            counter_out <= hb_empty_overlap_counter;
        elsif address = X"1B" then      -- 27
            counter_out <= ew_fifo_emptied_counter;
        elsif address = X"1C" then      -- 28
            counter_out <= dcs_counter;            
        elsif address = X"1D" then      -- 29
            counter_out <= start_fetch_counter;
        elsif address = X"1E" then      -- 30
            counter_out <= tag_error_counter;
        elsif address = X"1F" then      -- 31
            counter_out <= comma_error_counter;
            
        elsif address = X"20" then      -- 32
            counter_out <= fetch_event_tag(15 downto 0);
        elsif address = X"21" then      -- 33
            counter_out <= fetch_event_tag(31 downto 16);
        elsif address = X"22" then      -- 34
            counter_out <= fetch_event_tag(47 downto 32);
        elsif address = X"23" then      -- 35
            counter_out <= next_read_event_tag(15 downto 0);
        elsif address = X"24" then      -- 36
            counter_out <= next_read_event_tag(31 downto 16);
        elsif address = X"25" then      -- 37
            counter_out <= next_read_event_tag(47 downto 32);
        elsif address = X"26" then      -- 38
            counter_out(3 downto 0) <= reqType_debug(3 downto 0);
            counter_out(15 downto 4) <= (others => '0');
        elsif address = X"27" then      -- 39
            counter_out <= reqEventWindowTag_debug(15 downto 0);
        elsif address = X"28" then      -- 40
            counter_out <= reqEventWindowTag_debug(31 downto 16);
        elsif address = X"29" then      -- 41
            counter_out <= reqEventWindowTag_debug(47 downto 32);
        elsif address = X"2A" then      -- 42
            counter_out <= fetchEventWindowTag_debug(15 downto 0);
        elsif address = X"2B" then      -- 43
            counter_out <= fetchEventWindowTag_debug(31 downto 16);
        elsif address = X"2C" then      -- 44
            counter_out <= fetchEventWindowTag_debug(47 downto 32);
            
        elsif address = X"30" then      -- 48
            counter_out(7 downto 0) <= dcs_proc_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"31" then      -- 49
            counter_out(7 downto 0) <= dcs_rx_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"32" then      -- 50
            counter_out(7 downto 0) <= dcs_tx_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"33" then      -- 51
            counter_out(7 downto 0) <= rocfifocntrl_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"34" then      -- 52
            counter_out(2 downto 0) <= ewtag_state(2 downto 0);
            counter_out(15 downto 3) <= (others => '0');
        elsif address = X"35" then      -- 53
            counter_out(1 downto 0) <= datareq_state(1 downto 0);
            counter_out(15 downto 2) <= (others => '0');
        elsif address = X"36" then      -- 54
            counter_out(7 downto 0) <= dreq_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"37" then      -- 55
            counter_out(1 downto 0) <= fetch_state(1 downto 0);
            counter_out(15 downto 2) <= (others => '0');
            
        elsif address = X"40" then      -- 64
            counter_out <= dreq_full_counter;
        elsif address = X"41" then      -- 65
            counter_out <= invalid_hb_counter;
        elsif address = X"42" then      -- 66
            counter_out <= hb_bad_crc_counter;
        elsif address = X"43" then      -- 67
            counter_out <= hb_tag_full_counter;
        elsif address = X"44" then      -- 68
            counter_out <= spilltag_full_counter;
             
        else
            counter_out <= (others => '0');
        end if;
        
        -- internally generated counters
        clk_counter <= clk_counter + 1;
    
        if  end_ewm = '1' then
            event_window_seen <= event_window_seen + 1;
        end if;
        
    end if;
    end process;
    
    
    --process(CTRL_RESET_N, CTRL_CLK)
    --begin
    --if CTRL_RESET_N = '0' then
    process(reset_n, clk)
    begin
    if reset_n = '0' then
 
    
        rx_val_reg  <= '0';
        aligned_reg <= '0';
        rx_err_reg  <= '0';
        b_cerr_reg      <= (others => '0');
        invalid_k_reg   <= (others => '0');
        code_errn_reg   <= (others => '0');
        rd_err_reg      <= (others => '0');
        
        rx_val_counter  <= (others => '0');
        aligned_counter <= (others => '0');
        rx_err_counter  <= (others => '0');
        b_cerr_counter  <= (others => '0');
        invalid_k_counter   <= (others => '0');
        code_err_n_counter  <= (others => '0');
        rd_err_counter  <= (others => '0');
        
--    elsif rising_edge(CTRL_CLK) then
    elsif rising_edge(clk) then
        -- count when it stops being valid
        rx_val_reg  <= rx_val;
        if rx_val = '0' and rx_val_reg = '1'    then
            rx_val_counter <= rx_val_counter + 1;
        end if;
        
        -- count when it stops being aligned
        aligned_reg <= aligned;
        if aligned = '0' and aligned_reg = '1'  then
            aligned_counter <= aligned_counter + 1;
        end if;
        
        -- count when errors seen
        rx_err_reg  <= rx_err;
        if rx_err = '1' and rx_err_reg = '0'    then
            rx_err_counter <= rx_err_counter + 1;
        end if;
        
        b_cerr_reg  <= b_cerr;
        if (b_cerr(0) = '1' and b_cerr_reg(0) = '0') or (b_cerr(1) = '1' and b_cerr_reg(1) = '0') then
            b_cerr_counter <= b_cerr_counter + 1;
        end if;
        
        invalid_k_reg   <= invalid_k;
        if (invalid_k(1) = '1' and invalid_k_reg(0) = '0') or (invalid_k(1) = '1' and invalid_k_reg(1) = '0') then
            invalid_k_counter <= invalid_k_counter + 1;
        end if;
        
        code_errn_reg   <= code_err_n;
        if (code_err_n(0) = '0' and code_errn_reg(0) = '1') or (code_err_n(1) = '0' and code_errn_reg(1) = '1') then
            code_err_n_counter <= code_err_n_counter + 1;
        end if;
        
        rd_err_reg  <= rd_err;
        if (rd_err(0) = '1' and rd_err_reg(0) = '0') or (rd_err(1) = '1' and rd_err_reg(1) = '0') then
            rd_err_counter <= rd_err_counter + 1;
        end if;
        
    end if;
    end process;
        
end architecture_ErrorCounter;
