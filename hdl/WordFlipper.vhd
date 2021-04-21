--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: WordFlipper.vhd
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

entity WordFlipper is
port (
    k_char_in : in std_logic_vector(1 downto 0);
    data_in : in std_logic_vector(15 downto 0);
    
    k_char_out : out std_logic_vector(1 downto 0);
    data_out : out std_logic_vector(15 downto 0)
);
end WordFlipper;
architecture architecture_WordFlipper of WordFlipper is

begin

    k_char_out <= k_char_in(0) & k_char_in(1);
    data_out <= data_in(7 downto 0) & data_in(15 downto 8);

end architecture_WordFlipper;
