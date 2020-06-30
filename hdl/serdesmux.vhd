--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: serdesmux.vhd
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



library ieee;
use ieee.std_logic_1164.all;


entity serdesmux is
  generic (
    data_width : integer := 32);
  port
    (
      d0  : in  std_logic_vector (data_width-1 downto 0);
      d1  : in  std_logic_vector (data_width-1 downto 0);
      d2  : in  std_logic_vector (data_width-1 downto 0);
      d3  : in  std_logic_vector (data_width-1 downto 0);
      sel : in  std_logic_vector (1 downto 0);
      y   : out std_logic_vector (data_width-1 downto 0)

      );
end serdesmux;


architecture SYN of serdesmux is


  signal zeros : std_logic_vector(data_width-1 downto 0);

begin

  zeros <= (others => '0');

  with sel select
    y <= d0 when b"00",
    d1      when b"01",
    d2      when b"10",
    d3      when b"11",


    zeros when others;
end SYN;






