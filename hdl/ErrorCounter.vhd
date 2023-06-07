--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: ErrorCounter.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
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
    event_marker_counter : in std_logic_vector(15 downto 0);   -- any event arker
    evm_for_dreq_counter : in std_logic_vector(15 downto 0);    -- markers with a non-null heartbeat PLUS 1
    clock_marker_counter : in std_logic_vector(15 downto 0);
    loop_marker_counter : in std_logic_vector(15 downto 0);
    other_marker_counter : in std_logic_vector(15 downto 0);
    retr_marker_counter : in std_logic_vector(15 downto 0);
    ewm_out_counter : in std_logic_vector(15 downto 0);       --  markers sent to the DIGIs
    
    dreq_timeout_counter : in std_logic_vector(15 downto 0);
    hb_empty_overlap_counter : in std_logic_vector(15 downto 0);
    ew_fifo_emptied_counter : in std_logic_vector(15 downto 0);
    tag_valid_counter : in std_logic_vector(15 downto 0);
    tag_error_counter : in std_logic_vector(15 downto 0);
    comma_error_counter : in std_logic_vector(15 downto 0);
    
    dreq_state      : in std_logic_vector(7 downto 0);
    rocfifocntrl_state : in std_logic_vector(7 downto 0);
    ewtag_state     : in std_logic_vector(2 downto 0);
    datareq_state   : in std_logic_vector(1 downto 0);
    dcs_proc_state  : in std_logic_vector(7 downto 0);
    dcs_rx_state    : in std_logic_vector(7 downto 0);
    dcs_tx_state    : in std_logic_vector(7 downto 0);
    
    fetch_state : in std_logic_vector(1 downto 0);
    fetch_event_tag : in std_logic_vector(15 downto 0);
    next_read_event_tag : in std_logic_vector(15 downto 0);
    
    reqType_debug : in std_logic_vector(3 downto 0);
    reqEventWindowTag_debug : in std_logic_vector(47 downto 0);
    
    ewm     : in std_logic;
    
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
        rx_val_counter <= (others => '0');
        aligned_counter <= (others => '0');
        rx_err_counter <= (others => '0');
        b_cerr_counter <= (others => '0');
        invalid_k_counter <= (others => '0');
        code_err_n_counter <= (others => '0');
        rd_err_counter <= (others => '0');
        clk_counter <= (others => '0');
        counter_out <= (others => '0');
        event_window_seen <= (others => '0');
    elsif rising_edge(clk) then
         if address = X"00" then
            counter_out <= std_logic_vector(rx_val_counter);
        elsif address = X"01" then
            counter_out <= std_logic_vector(rx_err_counter);
        elsif address = X"02" then
            counter_out <= std_logic_vector(b_cerr_counter);
        elsif address = X"03" then
            counter_out <= std_logic_vector(invalid_k_counter);
        elsif address = X"04" then
            counter_out <= std_logic_vector(code_err_n_counter);
        elsif address = X"05" then
            counter_out <= std_logic_vector(rd_err_counter);
        elsif address = X"06" then
            counter_out <= std_logic_vector(aligned_counter);
        elsif address = X"07" then
            counter_out <= std_logic_vector(clk_counter);
        elsif address = X"08" then
            counter_out <= rx_crc_error;
        elsif address = X"09" then
            counter_out <= rx_packet_error;
        elsif address = X"0A" then
            counter_out <= std_logic_vector(event_window_seen);
        elsif address = X"0B" then
            counter_out <= dreq_crc_error;
        elsif address = X"0C" then
            counter_out <= seq_error_counter;
        elsif address = X"0D" then
            counter_out <= marker_error;
        elsif address = X"0E" then
            counter_out <= ewm_out_counter; -- this is a counter of markers sent to the DIGIs
        elsif address = X"0F" then
            counter_out <= evm_for_dreq_counter;   -- this is event marker with dreq PLUS 1
        elsif address = X"10" then
            counter_out <= event_marker_counter;   -- this is any event marker
        elsif address = X"11" then
            counter_out <= clock_marker_counter;
        elsif address = X"12" then
            counter_out <= loop_marker_counter;
        elsif address = X"13" then
            counter_out <= other_marker_counter;
        elsif address = X"14" then-- 20
            counter_out <= retr_marker_counter;
        elsif address = X"15" then
            counter_out <= dreq_timeout_counter;
        elsif address = X"17" then
            counter_out(7 downto 0) <= rocfifocntrl_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"18" then      -- 24
            counter_out(2 downto 0) <= ewtag_state(2 downto 0);
            counter_out(15 downto 3) <= (others => '0');
        elsif address = X"19" then
            counter_out(1 downto 0) <= datareq_state(1 downto 0);
            counter_out(15 downto 2) <= (others => '0');
        elsif address = X"1A" then
            counter_out(7 downto 0) <= dreq_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"1B" then
            counter_out <= hb_empty_overlap_counter;
        elsif address = X"1C" then      -- 28
            counter_out <= ew_fifo_emptied_counter;
        elsif address = X"1D" then
            counter_out <= tag_valid_counter;
        elsif address = X"1E" then
            counter_out <= tag_error_counter;
        elsif address = X"1F" then
            counter_out(1 downto 0) <= fetch_state(1 downto 0);
            counter_out(15 downto 2) <= (others => '0');
        elsif address = X"20" then      -- 32
            counter_out <= fetch_event_tag;
        elsif address = X"21" then
            counter_out <= next_read_event_tag;
        elsif address = X"22" then
            counter_out(3 downto 0) <= reqType_debug(3 downto 0);
            counter_out(15 downto 4) <= (others => '0');
        elsif address = X"23" then
            counter_out <= reqEventWindowTag_debug(15 downto 0);
        elsif address = X"24" then      -- 36
            counter_out <= reqEventWindowTag_debug(31 downto 16);
        elsif address = X"25" then
            counter_out <= reqEventWindowTag_debug(47 downto 32);
        elsif address = X"26" then
            counter_out <= comma_error_counter;
        elsif address = X"27" then
            counter_out(7 downto 0) <= dcs_proc_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"28" then  -- 40
            counter_out(7 downto 0) <= dcs_rx_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"29" then
            counter_out(7 downto 0) <= dcs_tx_state(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        else
            counter_out <= (others => '0');
        end if;
        
        -- internally generated counters
        clk_counter <= clk_counter + 1;
        if rx_val = '0' then
            rx_val_counter <= rx_val_counter + 1;
        end if;
        if aligned = '0' then
            aligned_counter <= aligned_counter + 1;
        end if;
        if rx_err = '1' then
            rx_err_counter <= rx_err_counter + 1;
        end if;
        if b_cerr /= "00" then
            b_cerr_counter <= b_cerr_counter + 1;
        end if;
        if invalid_k /= "00" then
            invalid_k_counter <= invalid_k_counter + 1;
        end if;
        if code_err_n /= "11" then
            code_err_n_counter <= code_err_n_counter + 1;
        end if;
        if rd_err /= "00" then
            rd_err_counter <= rd_err_counter + 1;
        end if;
        
        if ewm = '1' then
            event_window_seen <= event_window_seen + 1;
        end if;
        
        -- latch DCS_ERROR_EN twice to help with Cross-Domain of 200 MHz clock 
        dcs_error_reg   <= dcs_error_en;
        dcs_error_latch <= dcs_error_reg;
        -- latch DCS_ADDRESS so we can reuse same register to read back the content
        if  (dcs_error_en = '1' and dcs_error_latch = '0')then
            dcs_address_latch <= dcs_address;
        end if;
        
    end if;
    end process;


end architecture_ErrorCounter;
