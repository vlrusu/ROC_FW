--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: INV_20bit.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity INV_20bit is
port (
	portIn  : IN  std_logic_vector(19 downto 0); 
    portOut : OUT std_logic_vector(19 downto 0)  
);
end INV_20bit;
architecture architecture_INV_20bit of INV_20bit is

begin
   portOut(19 downto 0) <= not portIn (19 downto 0);
end architecture_INV_20bit;
