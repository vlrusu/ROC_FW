--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: RightFastTx.vhd
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

entity RxController is
port (
    rx_clk : in std_logic;
    reset_n : in std_logic;
    
    rx_val : in std_logic;
    k_in : in std_logic_vector(3 downto 0);
    data_in : in std_logic_vector(31 downto 0);
    
    code_violation : in std_logic_vector(3 downto 0);
    disp_error : in std_logic_vector(3 downto 0);
    
    aligned : out std_logic;
    alignment : out std_logic_vector(3 downto 0);
    
    error_count : out std_logic_vector(7 downto 0);
    
    data_valid : out std_logic
);
end RxController;
architecture architecture_RxController of RxController is

    signal valid_seen : std_logic;
    signal error_counter : unsigned(7 downto 0);

begin

    data_valid <= '1' when k_in = "0000" and rx_val = '1' and aligned = '1' else '0';
    error_count <= std_logic_vector(error_counter);

    process(rx_clk, reset_n)
    begin
    if reset_n = '0' then
        valid_seen <= '0';
        alignment <= (others => '0');
        aligned <= '0';
        error_counter <= (others => '0');
    elsif rising_edge(rx_clk) then
        if k_in = "0000" then
            -- pass;
        elsif k_in = "0001" then
            alignment <= "0001";
            aligned <= '1';
        elsif k_in = "0010" then
            alignment <= "0010";
            aligned <= '1';
        elsif k_in = "0100" then
            alignment <= "0100";
            aligned <= '1';
        elsif k_in = "1000" then
            alignment <= "1000";
            aligned <= '1';
        else
            alignment <= "1111";
            aligned <= '0';
        end if;
        if rx_val = '0' then
            alignment <= "0000";
            aligned <= '0';
        else
            valid_seen <= '1';
        end if;
        if (rx_val = '0' or disp_error /= "0000" or code_violation /= "0000") and valid_seen = '1' then
            error_counter <= error_counter + 1;
        end if;
                
    end if;
    end process;

end architecture_RxController;
