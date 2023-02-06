-- Version: 2022.3 2022.3.0.8

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity RxPacketFIFO_RxPacketFIFO_0_LSRAM_top is

    port( W_DATA : in    std_logic_vector(19 downto 0);
          R_DATA : out   std_logic_vector(19 downto 0);
          W_ADDR : in    std_logic_vector(9 downto 0);
          R_ADDR : in    std_logic_vector(9 downto 0);
          W_EN   : in    std_logic;
          R_EN   : in    std_logic;
          W_CLK  : in    std_logic;
          R_CLK  : in    std_logic
        );

end RxPacketFIFO_RxPacketFIFO_0_LSRAM_top;

architecture DEF_ARCH of RxPacketFIFO_RxPacketFIFO_0_LSRAM_top is 

  component RAM1K20
    generic (MEMORYFILE:string := ""; RAMINDEX:string := ""; 
        INIT0:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT1:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT2:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT3:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT4:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT5:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT6:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT7:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT8:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT9:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT10:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT11:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT12:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT13:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT14:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT15:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT16:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT17:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT18:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT19:std_logic_vector(1023 downto 0) := (others => 'X')
        );

    port( A_DOUT        : out   std_logic_vector(19 downto 0);
          B_DOUT        : out   std_logic_vector(19 downto 0);
          DB_DETECT     : out   std_logic;
          SB_CORRECT    : out   std_logic;
          ACCESS_BUSY   : out   std_logic;
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_BLK_EN      : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_CLK         : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(19 downto 0) := (others => 'U');
          A_REN         : in    std_logic := 'U';
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_DOUT_EN     : in    std_logic := 'U';
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_BLK_EN      : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(19 downto 0) := (others => 'U');
          B_REN         : in    std_logic := 'U';
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_DOUT_EN     : in    std_logic := 'U';
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          ECC_EN        : in    std_logic := 'U';
          BUSY_FB       : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_BYPASS      : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_BYPASS      : in    std_logic := 'U';
          ECC_BYPASS    : in    std_logic := 'U'
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal \ACCESS_BUSY[0][0]\, \VCC\, \GND\, ADLIB_VCC
         : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc1, nc8, nc13, nc16, nc19, nc20, nc9, nc14, nc5, nc15, 
        nc3, nc10, nc7, nc17, nc4, nc12, nc2, nc18, nc6, nc11
         : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    RxPacketFIFO_RxPacketFIFO_0_LSRAM_top_R0C0 : RAM1K20

              generic map(RAMINDEX => "core%1024-1024%20-20%SPEED%0%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => R_DATA(19), A_DOUT(18) => R_DATA(18), 
        A_DOUT(17) => R_DATA(17), A_DOUT(16) => R_DATA(16), 
        A_DOUT(15) => R_DATA(15), A_DOUT(14) => R_DATA(14), 
        A_DOUT(13) => R_DATA(13), A_DOUT(12) => R_DATA(12), 
        A_DOUT(11) => R_DATA(11), A_DOUT(10) => R_DATA(10), 
        A_DOUT(9) => R_DATA(9), A_DOUT(8) => R_DATA(8), A_DOUT(7)
         => R_DATA(7), A_DOUT(6) => R_DATA(6), A_DOUT(5) => 
        R_DATA(5), A_DOUT(4) => R_DATA(4), A_DOUT(3) => R_DATA(3), 
        A_DOUT(2) => R_DATA(2), A_DOUT(1) => R_DATA(1), A_DOUT(0)
         => R_DATA(0), B_DOUT(19) => nc1, B_DOUT(18) => nc8, 
        B_DOUT(17) => nc13, B_DOUT(16) => nc16, B_DOUT(15) => 
        nc19, B_DOUT(14) => nc20, B_DOUT(13) => nc9, B_DOUT(12)
         => nc14, B_DOUT(11) => nc5, B_DOUT(10) => nc15, 
        B_DOUT(9) => nc3, B_DOUT(8) => nc10, B_DOUT(7) => nc7, 
        B_DOUT(6) => nc17, B_DOUT(5) => nc4, B_DOUT(4) => nc12, 
        B_DOUT(3) => nc2, B_DOUT(2) => nc18, B_DOUT(1) => nc6, 
        B_DOUT(0) => nc11, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][0]\, A_ADDR(13) => 
        R_ADDR(9), A_ADDR(12) => R_ADDR(8), A_ADDR(11) => 
        R_ADDR(7), A_ADDR(10) => R_ADDR(6), A_ADDR(9) => 
        R_ADDR(5), A_ADDR(8) => R_ADDR(4), A_ADDR(7) => R_ADDR(3), 
        A_ADDR(6) => R_ADDR(2), A_ADDR(5) => R_ADDR(1), A_ADDR(4)
         => R_ADDR(0), A_ADDR(3) => \GND\, A_ADDR(2) => \GND\, 
        A_ADDR(1) => \GND\, A_ADDR(0) => \GND\, A_BLK_EN(2) => 
        \VCC\, A_BLK_EN(1) => \VCC\, A_BLK_EN(0) => \VCC\, A_CLK
         => R_CLK, A_DIN(19) => \GND\, A_DIN(18) => \GND\, 
        A_DIN(17) => \GND\, A_DIN(16) => \GND\, A_DIN(15) => 
        \GND\, A_DIN(14) => \GND\, A_DIN(13) => \GND\, A_DIN(12)
         => \GND\, A_DIN(11) => \GND\, A_DIN(10) => \GND\, 
        A_DIN(9) => \GND\, A_DIN(8) => \GND\, A_DIN(7) => \GND\, 
        A_DIN(6) => \GND\, A_DIN(5) => \GND\, A_DIN(4) => \GND\, 
        A_DIN(3) => \GND\, A_DIN(2) => \GND\, A_DIN(1) => \GND\, 
        A_DIN(0) => \GND\, A_REN => R_EN, A_WEN(1) => \GND\, 
        A_WEN(0) => \GND\, A_DOUT_EN => \VCC\, A_DOUT_ARST_N => 
        \VCC\, A_DOUT_SRST_N => \VCC\, B_ADDR(13) => W_ADDR(9), 
        B_ADDR(12) => W_ADDR(8), B_ADDR(11) => W_ADDR(7), 
        B_ADDR(10) => W_ADDR(6), B_ADDR(9) => W_ADDR(5), 
        B_ADDR(8) => W_ADDR(4), B_ADDR(7) => W_ADDR(3), B_ADDR(6)
         => W_ADDR(2), B_ADDR(5) => W_ADDR(1), B_ADDR(4) => 
        W_ADDR(0), B_ADDR(3) => \GND\, B_ADDR(2) => \GND\, 
        B_ADDR(1) => \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => 
        W_EN, B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK
         => W_CLK, B_DIN(19) => W_DATA(19), B_DIN(18) => 
        W_DATA(18), B_DIN(17) => W_DATA(17), B_DIN(16) => 
        W_DATA(16), B_DIN(15) => W_DATA(15), B_DIN(14) => 
        W_DATA(14), B_DIN(13) => W_DATA(13), B_DIN(12) => 
        W_DATA(12), B_DIN(11) => W_DATA(11), B_DIN(10) => 
        W_DATA(10), B_DIN(9) => W_DATA(9), B_DIN(8) => W_DATA(8), 
        B_DIN(7) => W_DATA(7), B_DIN(6) => W_DATA(6), B_DIN(5)
         => W_DATA(5), B_DIN(4) => W_DATA(4), B_DIN(3) => 
        W_DATA(3), B_DIN(2) => W_DATA(2), B_DIN(1) => W_DATA(1), 
        B_DIN(0) => W_DATA(0), B_REN => \VCC\, B_WEN(1) => \VCC\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \VCC\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \VCC\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
