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
    dtc_seq_error : in std_logic_vector(15 downto 0);
    marker_error : in std_logic_vector(15 downto 0);
    event_marker_counter : in std_logic_vector(15 downto 0);
    clock_marker_counter : in std_logic_vector(15 downto 0);
    loop_marker_counter : in std_logic_vector(15 downto 0);
    other_marker_counter : in std_logic_vector(15 downto 0);
    retr_marker_counter : in std_logic_vector(15 downto 0);
    ewm_out_counter : in std_logic_vector(15 downto 0);
    cntrl_state_count : in std_logic_vector(7 downto 0);
    
    --din : in std_logic;
    --enable_alignment : out std_logic;
    ewm : in std_logic;
    --event_window_expected : in std_logic_vector(15 downto 0);
    
    address : in std_logic_vector(7 downto 0);
    counter_out : out std_logic_vector(15 downto 0)
    --<other_ports>;
);
end ErrorCounter;
architecture architecture_ErrorCounter of ErrorCounter is

    signal clk_counter : unsigned(15 downto 0);
    signal rx_val_counter : unsigned(15 downto 0);
    signal aligned_counter : unsigned(15 downto 0);
    signal rx_err_counter : unsigned(15 downto 0);
    signal b_cerr_counter : unsigned(15 downto 0);
    signal invalid_k_counter : unsigned(15 downto 0);
    signal code_err_n_counter : unsigned(15 downto 0);
    signal rd_err_counter : unsigned(15 downto 0);
    --signal ewm_counter : unsigned(15 downto 0);
    signal event_window_seen : unsigned(15 downto 0);

begin

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
        --enable_alignment <= '1';
        --ewm_counter <= (others => '0');
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
            counter_out <= dtc_seq_error;
        elsif address = X"0D" then
            counter_out <= marker_error;
        elsif address = X"0E" then
            counter_out <= ewm_out_counter;
        elsif address = X"0F" then
            counter_out(7 downto 0) <= cntrl_state_count(7 downto 0);
            counter_out(15 downto 8) <= (others => '0');
        elsif address = X"10" then
            counter_out <= event_marker_counter;
        elsif address = X"11" then
            counter_out <= clock_marker_counter;
        elsif address = X"12" then
            counter_out <= loop_marker_counter;
        elsif address = X"13" then
            counter_out <= other_marker_counter;
        elsif address = X"14" then
            counter_out <= retr_marker_counter;
        else
            counter_out <= (others => '0');
        end if;
        
        --if address = X"A" then
            --enable_alignment <= din;
        --end if;
        
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
        
        --ewm_counter <= ewm_counter + 1;
        if ewm = '1' then
            event_window_seen <= event_window_seen + 1;
            --ewm_counter <= (others => '0');
            --if std_logic_vector(ewm_counter) /= event_window_expected then
                --event_window_missed <= std_logic_vector(unsigned(event_window_missed) + 1);
            --end if;
        end if;
    end if;
    end process;


end architecture_ErrorCounter;
