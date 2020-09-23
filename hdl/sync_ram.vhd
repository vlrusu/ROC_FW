-- Simple generic RAM Model
--
-- +-----------------------------+
-- |    Copyright 2008 DOULOS    |
-- |   designer :  JK            |
-- +-----------------------------+

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity sync_ram is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(6 downto 0); -- Address to write/read RAM
    datain  : in  std_logic_vector(7 downto 0); -- Data to write into RAM
    dataout : out std_logic_vector(7 downto 0) -- Data output of RAM
  );
end entity sync_ram;

architecture RTL of sync_ram is

   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(datain'range);
   signal ram : ram_type:=(
      x"01",x"02",x"03",x"04",-- 0x00: 
      x"05",x"06",x"07",x"08",-- 0x04: 
      x"09",x"0A",x"0B",x"0C",-- 0x08: 
      x"0D",x"0E",x"0F",x"10",-- 0x0C: 
      x"11",x"12",x"13",x"14",-- 0x10: 
      x"15",x"16",x"17",x"18",-- 0x14: 
      x"19",x"1A",x"1B",x"1C",-- 0x18: 
      x"1D",x"1E",x"1F",x"20",-- 0x1C: 
      x"21",x"22",x"23",x"24",-- 0x20: 
      x"25",x"26",x"27",x"28",-- 0x24: 
      x"29",x"2A",x"2B",x"2C",-- 0x28: 
      x"2D",x"2E",x"2F",x"30",-- 0x2C: 
      x"31",x"32",x"33",x"34",-- 0x30: 
      x"35",x"36",x"37",x"38",-- 0x34: 
      x"39",x"3A",x"3B",x"3C",-- 0x38: 
      x"3D",x"3E",x"3F",x"40",-- 0x3C: 
      x"41",x"42",x"43",x"44",-- 0x40: 
      x"45",x"46",x"47",x"48",-- 0x44: 
      x"49",x"4A",x"4B",x"4C",-- 0x48: 
      x"4D",x"4E",x"4F",x"50",-- 0x4C: 
      x"51",x"52",x"53",x"54",-- 0x50: 
      x"55",x"56",x"57",x"58",-- 0x54: 
      x"59",x"5A",x"5B",x"5C",-- 0x58: 
      x"5D",x"5E",x"5F",x"60",-- 0x5C: 
      x"00",x"00",x"00",x"00",-- 0x60:
      x"00",x"00",x"00",x"00",-- 0x64:
      x"00",x"00",x"00",x"00",-- 0x68:
      x"00",x"00",x"00",x"00",-- 0x6C:
      x"00",x"00",x"00",x"00",-- 0x70:
      x"00",x"00",x"00",x"00",-- 0x74:
      x"00",x"00",x"00",x"00",-- 0x78:
      x"00",x"00",x"00",x"00" -- 0x7C:
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

end architecture RTL;