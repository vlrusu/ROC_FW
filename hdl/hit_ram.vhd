--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: hit_ram.vhd
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
use IEEE.Numeric_Std.all;

entity hit_ram is
port (
   clock   : in  std_logic;
   we      : in  std_logic;
   re      : in  std_logic;
   address : in  std_logic_vector(5 downto 0); -- Address to write/read RAM
   datain  : in  std_logic_vector(11 downto 0); -- Data to write into RAM
   dataout : out std_logic_vector(11 downto 0) -- Data output of RAM
);
end hit_ram;

architecture architecture_hit_ram of hit_ram is

   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(datain'range);
   signal ram : ram_type:=(
      x"001",x"002",x"003",x"000",  -- 0x00:
      x"000",x"000",x"007",x"008",  -- 0x04:
      x"009",x"00A",x"00B",x"00C",  -- 0x08:
      x"00D",x"00E",x"00F",x"010",  -- 0x0C:
      x"000",x"014",x"015",x"016",  -- 0x10:
      x"00C",x"00D",x"00B",x"00C",  -- 0x14:
      x"000",x"000",x"008",x"004",  -- 0x18:
      x"00C",x"00B",x"00C",x"00D",  -- 0x1C:
      x"010",x"006",x"003",x"001",  -- 0x20:
      x"00C",x"000",x"010",x"011",  -- 0x24:
      x"012",x"013",x"00C",x"001",  -- 0x28:
      x"00C",x"00C",x"00B",x"00B",  -- 0x2C:
      x"000",x"000",x"000",x"000",  -- 0x30:
      x"00D",x"00E",x"00A",x"00D",  -- 0x34:
      x"00B",x"00E",x"00E",x"00F",  -- 0x38:
      x"008",x"009",x"00A",x"020"   -- 0x3C:
   ); 
   signal read_address : std_logic_vector(address'range);

begin

  RamProc: process(clock) is

  begin
    if rising_edge(clock) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain;
      end if;
      read_address <= address;
    end if;
  end process RamProc;

  dataout <= ram(to_integer(unsigned(read_address)));
  
end architecture_hit_ram;
