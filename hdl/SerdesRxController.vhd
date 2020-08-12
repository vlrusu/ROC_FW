--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SerdesRxController.vhd
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

entity SerdesRxController is
port (
    wrcnt : in std_logic_vector(12 downto 0);
    local_token : out std_logic_vector(7 downto 0)
);
end SerdesRxController;
architecture architecture_SerdesRxController of SerdesRxController is
	signal space_in_fifo : unsigned(12 downto 0); 

begin

    space_in_fifo <= "1000000000000" - unsigned(wrcnt);

    local_token <= "00" & std_logic_vector(space_in_fifo(12 downto 7));

   -- architecture body
end architecture_SerdesRxController;
