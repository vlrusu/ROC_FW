-- Actel Corporation Proprietary and Confidential
--  Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--  Revision Information:
-- Jun09    Revision 4.1
-- Aug10    Revision 4.2
-- SVN Revision Information:
-- SVN $Revision: 8508 $
-- SVN $Date: 2009-06-15 16:49:49 -0700 (Mon, 15 Jun 2009) $
library ieee;
use ieeE.STD_LOgic_1164.all;
library POLARFIRE;
entity UARTapb_UARTapb_0_fifo_256x8 is
generic (SYNC_Reset: INTEGER := 0); port (CUARToool: out STD_LOGic_vector(7 downto 0);
CUARTlool: in std_logic;
CUARTiool: in STD_LOGIC;
CUARTOLOL: in STD_Logic_vector(7 downto 0);
wrb: in STD_LOGIC;
rdb: in std_logic;
RESET: in STD_LOGIC;
full: out std_logiC;
EMPTY: out STD_LOGIc);
end entity UARTapb_UARTapb_0_FIFO_256x8;

architecture CUARTlol of UARTapb_UARTapb_0_Fifo_256x8 is

component UARTapb_UARTapb_0_FIFO_CTRL_256
generic (SYNC_reset: INTEGER := 0;
CUARTOO0L: intEGER := 8;
CUARTLO0L: intEGER := 8;
CUARTI1IL: integER := 256);
port (CUARTio0l: in std_logic;
reset_n: in STD_LOGIC;
Data_in: in std_logic_vector(CUARTLO0L-1 downto 0);
CUARTol0l: in STD_LOGIC;
CUARTLl0l: in std_loGIC;
CUARTIL0L: in std_logic_vector(CUARToo0l-1 downto 0);
data_out: out STD_LOGIC_VECTOR(CUARTlo0l-1 downto 0);
FULL: out std_logic;
empTY: out STD_LOGIC;
CUARToi0l: out stD_LOGIC);
end component;

constant CUARTIL0L: STD_LOGIC_VECTOR(7 downto 0) := "01000000";

signal AEMPTY: STD_LOGIC;

signal AFUll: std_logiC;

signal CUARTli0l: STD_LOGIC_VECTOR(7 downto 0);

signal CUARTii0l: STd_logic;

signal CUARTO00L: Std_logic;

signal geqth: STD_LOGIC;

begin
CUARTOOOL <= CUARTli0l;
full <= CUARTii0l;
empty <= CUARTo00l;
CUARTl0ii: UARTapb_UARTapb_0_fifo_ctRL_256
generic map (SYNC_RESET => SYNC_RESET)
port map (DATA_in => CUARTolol,
DATA_OUT => CUARTLi0l,
CUARTll0l => WRB,
CUARTol0l => RDB,
CUARTio0l => CUARTIOOL,
full => CUARTII0L,
empty => CUARTo00l,
CUARTOI0L => GEQTH,
reset_n => reset,
CUARTil0l => CUARTIL0L);
end architecture CUARTLOL;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.STd_logic_unsigned.all;
use ieee.STD_LOGIC_Arith.all;
library polarfire;
entity UARTapb_UARTapb_0_fifo_ctrl_256 is
generic (SYNC_RESET: integer := 0;
CUARTI1IL: INTEGER := 256;
CUARToo0l: Integer := 8;
CUARTLO0L: intEGER := 8); port (CUARTio0l: in STD_LOGIC;
RESET_N: in STD_LOGIC;
DATA_IN: in Std_logic_vector(CUARTlo0l-1 downto 0);
CUARTol0l: in STD_LOGIC;
CUARTll0l: in STD_LOGIC;
CUARTil0l: in STD_Logic_vector(CUARToo0L-1 downto 0);
DATA_OUT: out std_logic_vectOR(CUARTlo0l-1 downto 0);
full: out STD_LOGIC;
EMPTY: out std_logic;
CUARToi0l: out std_logic);
end entity UARTapb_UARTapb_0_FIFO_CTrl_256;

architecture CUARTlol of UARTapb_UARTapb_0_FIFO_CTRL_256 is

component CUARTI0II
port (CUARTo1oi: in std_logic_vector(7 downto 0);
CUARTL1OI: out std_lOGIC_VECTOR(7 downto 0);
CUARTi1oi: in std_logiC_VECTOR(7 downto 0);
CUARTooli: in std_logic_vector(7 downto 0);
CUARTLOLI: in std_logic;
RE: in std_logic;
CUARTIOOL: in STD_Logic;
reset_n: in STD_LOGIC;
CUARTlool: in std_logic);
end component;

signal CUARTOL1L: std_logic_vecTOR(CUARTLO0L-1 downto 0);

signal CUARTll1l: STD_LOGic;

signal CUARTIL1L: std_logic_veCTOR(CUARToo0l-1 downto 0);

signal CUARToi1l: STD_logic_vector(CUARToo0l-1 downto 0);

signal CUARTli1l: std_logic_vector(CUARTOO0L-1 downto 0);

signal CUARTii1l: STD_LOGic;

signal CUARTO01L: std_logic;

signal CUARTO00: std_logic;

signal CUARTL01L: std_logic_vector(CUARTLO0L-1 downto 0);

signal CUARTii0l: std_logic;

signal CUARTo00l: STD_LOGIC;

signal CUARTi01l: STD_LOGIC;

signal CUARTii: STD_LOGIC;

signal CUARTo0: std_LOGIC;

begin
CUARTII <= '1' when (SYNC_RESET = 1) else
rESET_N;
CUARTO0 <= reset_n when (sync_reset = 1) else
'1';
DATA_OUT <= CUARTl01l;
full <= CUARTii0l;
empty <= CUARTO00l;
CUARToI0L <= CUARTI01L;
CUARTII1L <= '1' when (CUARTil1l = CONV_STD_LOGIC_vector(CUARTi1il-1,
8)) else
'0';
CUARTii0l <= CUARTii1l;
CUARTo01l <= '1' when (CUARTil1l = "00000000") else
'0';
CUARTO00L <= CUARTO01L;
CUARTO00 <= '1' when (CUARTil1l >= CUARTIL0L) else
'0';
CUARTi01l <= CUARTo00;
process (CUARTio0l,CUARTii)
begin
if (not CUARTii = '1') then
CUARTOI1L <= ( others => '0');
CUARTli1l <= ( others => '0');
CUARTIL1L <= ( others => '0');
elsif (CUARTio0l'EVENT and CUARTIO0L = '1') then
if (not CUARTo0 = '1') then
CUARToi1l <= ( others => '0');
CUARTli1l <= ( others => '0');
CUARTil1l <= ( others => '0');
else
if (not CUARTol0l = '1') then
if (CUARTll0L = '1') then
CUARTIl1l <= CUARTIL1l-"00000001";
end if;
if (CUARToi1l = CONV_STD_logic_vector(CUARTi1il-1,
8)) then
CUARToi1l <= ( others => '0');
else
CUARToi1l <= CUARToi1l+"00000001";
end if;
end if;
if (not CUARTLL0L = '1') then
if (CUARTol0l = '1') then
CUARTil1l <= CUARTil1l+"00000001";
end if;
if (CUARTLI1L = conv_std_logic_vecTOR(CUARTI1IL-1,
8)) then
CUARTLI1L <= ( others => '0');
else
CUARTLI1l <= CUARTli1l+"00000001";
end if;
end if;
end if;
end if;
end process;
process (CUARTio0l,CUARTii)
begin
if (not CUARTII = '1') then
CUARTll1l <= '0';
elsif (CUARTio0l'event and CUARTIO0L = '1') then
if (not CUARTo0 = '1') then
CUARTLL1L <= '0';
else
CUARTll1l <= CUARTol0l;
if (CUARTll1l = '0') then
CUARTL01l <= CUARTOL1L;
else
CUARTl01l <= CUARTl01l;
end if;
end if;
end if;
end process;
CUARTo1ii: CUARTi0ii
port map (CUARTo1oi => data_in,
CUARTL1oi => CUARTOL1L,
CUARTi1oi => CUARTLI1L,
CUARTooli => CUARToi1l,
CUARTloli => CUARTll0l,
re => CUARTol0l,
RESET_N => REset_n,
CUARTiool => CUARTIO0L,
CUARTLOOL => CUARTio0l);
end architecture CUARTLOL;

library Ieee;
use IEEE.std_LOGIC_1164.all;
library polarfire;
entity CUARTI0II is
port (CUARTo1oi: in std_logic_vECTOR(7 downto 0);
CUARTl1oi: out STD_logic_vector(7 downto 0);
CUARTi1oi: in sTD_LOGIC_VECTOR(7 downto 0);
CUARTooli: in std_logic_VECTOR(7 downto 0);
CUARTloli: in STD_logic;
re: in std_logic;
RESET_N: in STD_logic;
CUARTiool: in STD_LOGIC;
CUARTlool: in std_logic);
end entity CUARTi0ii;

architecture CUARTlol of CUARTi0ii is

component INV
port (A: in STD_LOGIC := 'U';
y: out std_logic);
end component;

component Ram1k20
port (a_dOUT: out STD_LOGIC_Vector(19 downto 0);
b_DOUT: out std_logic_VECTOR(19 downto 0);
accESS_BUSY: out std_LOGIC;
DB_DETECT: out STD_LOGIC;
SB_CORRECT: out STD_LOGIC;
BUSY_Fb: in std_LOGIC;
ECC_EN: in std_logiC;
ECC_BYPASS: in std_logic;
a_clk: in STD_logic;
a_dout_en: in std_logic;
a_blK_EN: in std_logIC_VECTOR(2 downto 0);
A_DOUT_srst_n: in STD_LOGIC;
a_dout_arst_n: in std_logic;
a_bypass: in std_logic;
A_DIN: in std_logic_vector(19 downto 0);
A_addr: in STD_logic_vector(13 downto 0);
A_WEN: in std_loGIC_VECTOR(1 downto 0);
A_REN: in std_logic;
A_WIDTH: in STD_LOGIC_VECTOR(2 downto 0);
a_WMODE: in std_LOGIC_VECTOR(1 downto 0);
B_CLK: in std_logic;
b_DOUT_EN: in std_logic;
B_BLK_EN: in std_logic_VECTOR(2 downto 0);
B_DOUt_srst_n: in STD_logic;
B_Dout_arst_n: in STD_LOGIC;
b_BYPASS: in std_logic;
b_din: in std_logic_vector(19 downto 0);
B_ADDR: in std_logic_VECTOR(13 downto 0);
b_wen: in std_logic_vectOR(1 downto 0);
B_REN: in std_logic;
b_width: in std_logiC_VECTOR(2 downto 0);
B_WMOde: in stD_LOGIC_VECTOR(1 downto 0));
end component;

component VCC
port (y: out std_logic);
end component;

component GND
port (Y: out STD_Logic);
end component;

signal CUARTOLli: STD_LOGIC;

signal CUARTLLLI: std_logic;

signal CUARTILIi: STD_LOGIC_VECTor(19 downto 0);

signal CUARTL1II: std_logiC_VECTOR(13 downto 0);

signal CUARTI1II: std_logic_vectOR(13 downto 0);

signal CUARToo0i: std_LOGIC_VECTOR(19 downto 0);

signal CUARTLO0I: STD_LOGIC_VECTOR(2 downto 0);

signal CUARTIO0I: std_logic_vector(2 downto 0);

begin
CUARTl0li: inv
port map (A => CUARTloli,
y => CUARTLLLI);
CUARTI0LI: INV
port map (A => RE,
y => CUARTOLLI);
CUARTL1OI <= CUARTilii(7 downto 0);
CUARTL1ii <= "00"&CUARTooli&"0000";
CUARTI1II <= "00"&CUARTi1oi&"0000";
CUARTOO0I <= "000000000000"&CUARTo1oi;
CUARTio0i <= CUARTLLLI&"11";
CUARTLO0I <= CUARTOLLI&"11";
ram_r0c0: ram1k20
port map (a_dout => CUARTILIi,
b_dout => open ,
ACCESS_BUSY => open ,
busy_fb => '1',
ecc_en => '0',
ecc_bypass => '0',
DB_detect => open ,
sb_correCT => open ,
A_clk => CUARTLOOL,
A_DOUT_en => '1',
A_dout_srst_n => '1',
a_dout_arst_n => '1',
A_BYPASS => '1',
A_BLK_EN => CUARTlo0i,
a_din => X"00000",
A_ADDR => CUARTl1ii,
A_WEN => "00",
A_REN => '1',
A_WIDTH => "100",
A_Wmode => "00",
b_clk => CUARTiool,
b_DOUT_EN => '1',
B_DOUT_srst_n => '1',
b_dout_arst_n => '1',
b_bypass => '1',
b_blk_en => CUARTio0i,
B_DIN => CUARTOO0I,
B_addr => CUARTi1ii,
b_wen => "11",
b_ren => '0',
b_width => "100",
B_wmode => "00");
end architecture CUARTLol;
