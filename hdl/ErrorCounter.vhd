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
    
    din : in std_logic;
    enable_alignment : out std_logic;
    
    address : in std_logic_vector(3 downto 0);
    counter_out : out std_logic_vector(7 downto 0)
    --<other_ports>;
);
end ErrorCounter;
architecture architecture_ErrorCounter of ErrorCounter is

    signal clk_counter : unsigned(7 downto 0);
    signal rx_val_counter : unsigned(7 downto 0);
    signal aligned_counter : unsigned(7 downto 0);
    signal rx_err_counter : unsigned(7 downto 0);
    signal b_cerr_counter : unsigned(7 downto 0);
    signal invalid_k_counter : unsigned(7 downto 0);
    signal code_err_n_counter : unsigned(7 downto 0);
    signal rd_err_counter : unsigned(7 downto 0);

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
        enable_alignment <= '1';
    elsif rising_edge(clk) then
        if address = X"0" then
            counter_out <= std_logic_vector(rx_val_counter);
        elsif address = X"1" then
            counter_out <= std_logic_vector(rx_err_counter);
        elsif address = X"2" then
            counter_out <= std_logic_vector(b_cerr_counter);
        elsif address = X"3" then
            counter_out <= std_logic_vector(invalid_k_counter);
        elsif address = X"4" then
            counter_out <= std_logic_vector(code_err_n_counter);
        elsif address = X"5" then
            counter_out <= std_logic_vector(rd_err_counter);
        elsif address = X"6" then
            counter_out <= std_logic_vector(aligned_counter);
        elsif address = X"7" then
            counter_out <= std_logic_vector(clk_counter);
        elsif address = X"8" then
            counter_out <= rx_crc_error(7 downto 0);
        elsif address = X"9" then
            counter_out <= rx_packet_error(7 downto 0);
        else
            counter_out <= (others => '0');
        end if;
        
        if address = X"A" then
            enable_alignment <= din;
        end if;
        
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
        clk_counter <= clk_counter + 1;
    end if;
    end process;


end architecture_ErrorCounter;
