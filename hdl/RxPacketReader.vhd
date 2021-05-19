--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: RxPacketReader.vhd
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

entity RxPacketReader is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    aligned : in std_logic;
    
    data_in : in std_logic_vector(15 downto 0);
    k_in : in std_logic_vector(1 downto 0);
    
    error_count : out std_logic_vector(15 downto 0);
    data_out : out std_logic_vector(15 downto 0);
    we : out std_logic
);
end RxPacketReader;
architecture architecture_RxPacketReader of RxPacketReader is

    signal word_count : integer range 0 to 31;

begin

    process(reset_n, clk)
    begin
    if reset_n = '0' then
        word_count <= 0;
        error_count <= (others => '0');
        we <= '0';
        data_out <= (others => '0');
    elsif rising_edge(clk) then
        we <= '0';
        if aligned = '1' then
            if word_count = 0 then
                if k_in = "10" and data_in(15 downto 0) = X"1C00" then
                    word_count <= word_count + 1;
                    we <= '1';
                    data_out <= data_in;
                end if;
            else
                word_count <= word_count + 1;
                we <= '1';
                data_out <= data_in;
                if k_in = "10" then
                    error_count <= std_logic_vector(unsigned(error_count) + 1);
                end if;
                if word_count = 9 then
                    word_count <= 0;
                end if;
            end if;
        end if;
    end if;
    end process;

   -- architecture body
end architecture_RxPacketReader;
