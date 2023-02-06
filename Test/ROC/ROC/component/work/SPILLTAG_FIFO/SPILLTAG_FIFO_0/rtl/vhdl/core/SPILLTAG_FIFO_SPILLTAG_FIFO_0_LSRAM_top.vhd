-- Version: 2022.3 2022.3.0.8

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity SPILLTAG_FIFO_SPILLTAG_FIFO_0_LSRAM_top is

    port( W_DATA : in    std_logic_vector(19 downto 0);
          R_DATA : out   std_logic_vector(19 downto 0);
          W_ADDR : in    std_logic_vector(11 downto 0);
          R_ADDR : in    std_logic_vector(11 downto 0);
          W_EN   : in    std_logic;
          R_EN   : in    std_logic;
          W_CLK  : in    std_logic;
          R_CLK  : in    std_logic
        );

end SPILLTAG_FIFO_SPILLTAG_FIFO_0_LSRAM_top;

architecture DEF_ARCH of SPILLTAG_FIFO_SPILLTAG_FIFO_0_LSRAM_top is 

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

    signal \ACCESS_BUSY[0][0]\, \ACCESS_BUSY[0][1]\, 
        \ACCESS_BUSY[0][2]\, \ACCESS_BUSY[0][3]\, \VCC\, \GND\, 
        ADLIB_VCC : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc23, nc58, nc116, nc74, nc133, nc84, nc39, nc72, nc82, 
        nc57, nc125, nc73, nc107, nc66, nc83, nc9, nc54, nc135, 
        nc41, nc100, nc52, nc29, nc118, nc60, nc45, nc53, nc121, 
        nc11, nc131, nc96, nc79, nc89, nc119, nc48, nc126, nc15, 
        nc102, nc3, nc47, nc90, nc136, nc59, nc18, nc44, nc117, 
        nc42, nc17, nc2, nc110, nc128, nc43, nc36, nc61, nc104, 
        nc138, nc14, nc12, nc30, nc65, nc7, nc129, nc8, nc13, 
        nc26, nc139, nc112, nc68, nc49, nc91, nc5, nc20, nc67, 
        nc127, nc103, nc76, nc140, nc86, nc95, nc120, nc137, nc64, 
        nc19, nc70, nc62, nc80, nc130, nc98, nc114, nc56, nc105, 
        nc63, nc97, nc31, nc50, nc94, nc122, nc35, nc4, nc92, 
        nc101, nc132, nc21, nc93, nc69, nc38, nc113, nc106, nc25, 
        nc1, nc37, nc46, nc71, nc124, nc81, nc34, nc28, nc115, 
        nc134, nc32, nc40, nc99, nc75, nc85, nc27, nc108, nc16, 
        nc51, nc33, nc78, nc24, nc88, nc111, nc55, nc10, nc22, 
        nc77, nc6, nc109, nc87, nc123 : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    SPILLTAG_FIFO_SPILLTAG_FIFO_0_LSRAM_top_R0C1 : RAM1K20

              generic map(RAMINDEX => "core%4096-4096%20-20%SPEED%0%1%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc23, A_DOUT(18) => nc58, A_DOUT(17)
         => nc116, A_DOUT(16) => nc74, A_DOUT(15) => nc133, 
        A_DOUT(14) => nc84, A_DOUT(13) => nc39, A_DOUT(12) => 
        nc72, A_DOUT(11) => nc82, A_DOUT(10) => nc57, A_DOUT(9)
         => nc125, A_DOUT(8) => nc73, A_DOUT(7) => nc107, 
        A_DOUT(6) => nc66, A_DOUT(5) => nc83, A_DOUT(4) => 
        R_DATA(9), A_DOUT(3) => R_DATA(8), A_DOUT(2) => R_DATA(7), 
        A_DOUT(1) => R_DATA(6), A_DOUT(0) => R_DATA(5), 
        B_DOUT(19) => nc9, B_DOUT(18) => nc54, B_DOUT(17) => 
        nc135, B_DOUT(16) => nc41, B_DOUT(15) => nc100, 
        B_DOUT(14) => nc52, B_DOUT(13) => nc29, B_DOUT(12) => 
        nc118, B_DOUT(11) => nc60, B_DOUT(10) => nc45, B_DOUT(9)
         => nc53, B_DOUT(8) => nc121, B_DOUT(7) => nc11, 
        B_DOUT(6) => nc131, B_DOUT(5) => nc96, B_DOUT(4) => nc79, 
        B_DOUT(3) => nc89, B_DOUT(2) => nc119, B_DOUT(1) => nc48, 
        B_DOUT(0) => nc126, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][1]\, A_ADDR(13) => 
        R_ADDR(11), A_ADDR(12) => R_ADDR(10), A_ADDR(11) => 
        R_ADDR(9), A_ADDR(10) => R_ADDR(8), A_ADDR(9) => 
        R_ADDR(7), A_ADDR(8) => R_ADDR(6), A_ADDR(7) => R_ADDR(5), 
        A_ADDR(6) => R_ADDR(4), A_ADDR(5) => R_ADDR(3), A_ADDR(4)
         => R_ADDR(2), A_ADDR(3) => R_ADDR(1), A_ADDR(2) => 
        R_ADDR(0), A_ADDR(1) => \GND\, A_ADDR(0) => \GND\, 
        A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => \VCC\, A_BLK_EN(0)
         => \VCC\, A_CLK => R_CLK, A_DIN(19) => \GND\, A_DIN(18)
         => \GND\, A_DIN(17) => \GND\, A_DIN(16) => \GND\, 
        A_DIN(15) => \GND\, A_DIN(14) => \GND\, A_DIN(13) => 
        \GND\, A_DIN(12) => \GND\, A_DIN(11) => \GND\, A_DIN(10)
         => \GND\, A_DIN(9) => \GND\, A_DIN(8) => \GND\, A_DIN(7)
         => \GND\, A_DIN(6) => \GND\, A_DIN(5) => \GND\, A_DIN(4)
         => \GND\, A_DIN(3) => \GND\, A_DIN(2) => \GND\, A_DIN(1)
         => \GND\, A_DIN(0) => \GND\, A_REN => R_EN, A_WEN(1) => 
        \GND\, A_WEN(0) => \GND\, A_DOUT_EN => \VCC\, 
        A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N => \VCC\, 
        B_ADDR(13) => W_ADDR(11), B_ADDR(12) => W_ADDR(10), 
        B_ADDR(11) => W_ADDR(9), B_ADDR(10) => W_ADDR(8), 
        B_ADDR(9) => W_ADDR(7), B_ADDR(8) => W_ADDR(6), B_ADDR(7)
         => W_ADDR(5), B_ADDR(6) => W_ADDR(4), B_ADDR(5) => 
        W_ADDR(3), B_ADDR(4) => W_ADDR(2), B_ADDR(3) => W_ADDR(1), 
        B_ADDR(2) => W_ADDR(0), B_ADDR(1) => \GND\, B_ADDR(0) => 
        \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => \VCC\, 
        B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19) => \GND\, 
        B_DIN(18) => \GND\, B_DIN(17) => \GND\, B_DIN(16) => 
        \GND\, B_DIN(15) => \GND\, B_DIN(14) => \GND\, B_DIN(13)
         => \GND\, B_DIN(12) => \GND\, B_DIN(11) => \GND\, 
        B_DIN(10) => \GND\, B_DIN(9) => \GND\, B_DIN(8) => \GND\, 
        B_DIN(7) => \GND\, B_DIN(6) => \GND\, B_DIN(5) => \GND\, 
        B_DIN(4) => W_DATA(9), B_DIN(3) => W_DATA(8), B_DIN(2)
         => W_DATA(7), B_DIN(1) => W_DATA(6), B_DIN(0) => 
        W_DATA(5), B_REN => \VCC\, B_WEN(1) => \GND\, B_WEN(0)
         => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => \GND\, 
        B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB => \GND\, 
        A_WIDTH(2) => \GND\, A_WIDTH(1) => \VCC\, A_WIDTH(0) => 
        \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => \GND\, A_BYPASS
         => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1) => \VCC\, 
        B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, B_WMODE(0) => 
        \GND\, B_BYPASS => \VCC\, ECC_BYPASS => \GND\);
    
    SPILLTAG_FIFO_SPILLTAG_FIFO_0_LSRAM_top_R0C0 : RAM1K20

              generic map(RAMINDEX => "core%4096-4096%20-20%SPEED%0%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc15, A_DOUT(18) => nc102, 
        A_DOUT(17) => nc3, A_DOUT(16) => nc47, A_DOUT(15) => nc90, 
        A_DOUT(14) => nc136, A_DOUT(13) => nc59, A_DOUT(12) => 
        nc18, A_DOUT(11) => nc44, A_DOUT(10) => nc117, A_DOUT(9)
         => nc42, A_DOUT(8) => nc17, A_DOUT(7) => nc2, A_DOUT(6)
         => nc110, A_DOUT(5) => nc128, A_DOUT(4) => R_DATA(4), 
        A_DOUT(3) => R_DATA(3), A_DOUT(2) => R_DATA(2), A_DOUT(1)
         => R_DATA(1), A_DOUT(0) => R_DATA(0), B_DOUT(19) => nc43, 
        B_DOUT(18) => nc36, B_DOUT(17) => nc61, B_DOUT(16) => 
        nc104, B_DOUT(15) => nc138, B_DOUT(14) => nc14, 
        B_DOUT(13) => nc12, B_DOUT(12) => nc30, B_DOUT(11) => 
        nc65, B_DOUT(10) => nc7, B_DOUT(9) => nc129, B_DOUT(8)
         => nc8, B_DOUT(7) => nc13, B_DOUT(6) => nc26, B_DOUT(5)
         => nc139, B_DOUT(4) => nc112, B_DOUT(3) => nc68, 
        B_DOUT(2) => nc49, B_DOUT(1) => nc91, B_DOUT(0) => nc5, 
        DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY => 
        \ACCESS_BUSY[0][0]\, A_ADDR(13) => R_ADDR(11), A_ADDR(12)
         => R_ADDR(10), A_ADDR(11) => R_ADDR(9), A_ADDR(10) => 
        R_ADDR(8), A_ADDR(9) => R_ADDR(7), A_ADDR(8) => R_ADDR(6), 
        A_ADDR(7) => R_ADDR(5), A_ADDR(6) => R_ADDR(4), A_ADDR(5)
         => R_ADDR(3), A_ADDR(4) => R_ADDR(2), A_ADDR(3) => 
        R_ADDR(1), A_ADDR(2) => R_ADDR(0), A_ADDR(1) => \GND\, 
        A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => 
        \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => R_CLK, A_DIN(19)
         => \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, 
        A_DIN(16) => \GND\, A_DIN(15) => \GND\, A_DIN(14) => 
        \GND\, A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11)
         => \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, 
        A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, 
        A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, 
        A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, 
        A_REN => R_EN, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(11), B_ADDR(12) => 
        W_ADDR(10), B_ADDR(11) => W_ADDR(9), B_ADDR(10) => 
        W_ADDR(8), B_ADDR(9) => W_ADDR(7), B_ADDR(8) => W_ADDR(6), 
        B_ADDR(7) => W_ADDR(5), B_ADDR(6) => W_ADDR(4), B_ADDR(5)
         => W_ADDR(3), B_ADDR(4) => W_ADDR(2), B_ADDR(3) => 
        W_ADDR(1), B_ADDR(2) => W_ADDR(0), B_ADDR(1) => \GND\, 
        B_ADDR(0) => \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => 
        \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19)
         => \GND\, B_DIN(18) => \GND\, B_DIN(17) => \GND\, 
        B_DIN(16) => \GND\, B_DIN(15) => \GND\, B_DIN(14) => 
        \GND\, B_DIN(13) => \GND\, B_DIN(12) => \GND\, B_DIN(11)
         => \GND\, B_DIN(10) => \GND\, B_DIN(9) => \GND\, 
        B_DIN(8) => \GND\, B_DIN(7) => \GND\, B_DIN(6) => \GND\, 
        B_DIN(5) => \GND\, B_DIN(4) => W_DATA(4), B_DIN(3) => 
        W_DATA(3), B_DIN(2) => W_DATA(2), B_DIN(1) => W_DATA(1), 
        B_DIN(0) => W_DATA(0), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \VCC\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \VCC\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    SPILLTAG_FIFO_SPILLTAG_FIFO_0_LSRAM_top_R0C2 : RAM1K20

              generic map(RAMINDEX => "core%4096-4096%20-20%SPEED%0%2%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc20, A_DOUT(18) => nc67, A_DOUT(17)
         => nc127, A_DOUT(16) => nc103, A_DOUT(15) => nc76, 
        A_DOUT(14) => nc140, A_DOUT(13) => nc86, A_DOUT(12) => 
        nc95, A_DOUT(11) => nc120, A_DOUT(10) => nc137, A_DOUT(9)
         => nc64, A_DOUT(8) => nc19, A_DOUT(7) => nc70, A_DOUT(6)
         => nc62, A_DOUT(5) => nc80, A_DOUT(4) => R_DATA(14), 
        A_DOUT(3) => R_DATA(13), A_DOUT(2) => R_DATA(12), 
        A_DOUT(1) => R_DATA(11), A_DOUT(0) => R_DATA(10), 
        B_DOUT(19) => nc130, B_DOUT(18) => nc98, B_DOUT(17) => 
        nc114, B_DOUT(16) => nc56, B_DOUT(15) => nc105, 
        B_DOUT(14) => nc63, B_DOUT(13) => nc97, B_DOUT(12) => 
        nc31, B_DOUT(11) => nc50, B_DOUT(10) => nc94, B_DOUT(9)
         => nc122, B_DOUT(8) => nc35, B_DOUT(7) => nc4, B_DOUT(6)
         => nc92, B_DOUT(5) => nc101, B_DOUT(4) => nc132, 
        B_DOUT(3) => nc21, B_DOUT(2) => nc93, B_DOUT(1) => nc69, 
        B_DOUT(0) => nc38, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][2]\, A_ADDR(13) => 
        R_ADDR(11), A_ADDR(12) => R_ADDR(10), A_ADDR(11) => 
        R_ADDR(9), A_ADDR(10) => R_ADDR(8), A_ADDR(9) => 
        R_ADDR(7), A_ADDR(8) => R_ADDR(6), A_ADDR(7) => R_ADDR(5), 
        A_ADDR(6) => R_ADDR(4), A_ADDR(5) => R_ADDR(3), A_ADDR(4)
         => R_ADDR(2), A_ADDR(3) => R_ADDR(1), A_ADDR(2) => 
        R_ADDR(0), A_ADDR(1) => \GND\, A_ADDR(0) => \GND\, 
        A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => \VCC\, A_BLK_EN(0)
         => \VCC\, A_CLK => R_CLK, A_DIN(19) => \GND\, A_DIN(18)
         => \GND\, A_DIN(17) => \GND\, A_DIN(16) => \GND\, 
        A_DIN(15) => \GND\, A_DIN(14) => \GND\, A_DIN(13) => 
        \GND\, A_DIN(12) => \GND\, A_DIN(11) => \GND\, A_DIN(10)
         => \GND\, A_DIN(9) => \GND\, A_DIN(8) => \GND\, A_DIN(7)
         => \GND\, A_DIN(6) => \GND\, A_DIN(5) => \GND\, A_DIN(4)
         => \GND\, A_DIN(3) => \GND\, A_DIN(2) => \GND\, A_DIN(1)
         => \GND\, A_DIN(0) => \GND\, A_REN => R_EN, A_WEN(1) => 
        \GND\, A_WEN(0) => \GND\, A_DOUT_EN => \VCC\, 
        A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N => \VCC\, 
        B_ADDR(13) => W_ADDR(11), B_ADDR(12) => W_ADDR(10), 
        B_ADDR(11) => W_ADDR(9), B_ADDR(10) => W_ADDR(8), 
        B_ADDR(9) => W_ADDR(7), B_ADDR(8) => W_ADDR(6), B_ADDR(7)
         => W_ADDR(5), B_ADDR(6) => W_ADDR(4), B_ADDR(5) => 
        W_ADDR(3), B_ADDR(4) => W_ADDR(2), B_ADDR(3) => W_ADDR(1), 
        B_ADDR(2) => W_ADDR(0), B_ADDR(1) => \GND\, B_ADDR(0) => 
        \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => \VCC\, 
        B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19) => \GND\, 
        B_DIN(18) => \GND\, B_DIN(17) => \GND\, B_DIN(16) => 
        \GND\, B_DIN(15) => \GND\, B_DIN(14) => \GND\, B_DIN(13)
         => \GND\, B_DIN(12) => \GND\, B_DIN(11) => \GND\, 
        B_DIN(10) => \GND\, B_DIN(9) => \GND\, B_DIN(8) => \GND\, 
        B_DIN(7) => \GND\, B_DIN(6) => \GND\, B_DIN(5) => \GND\, 
        B_DIN(4) => W_DATA(14), B_DIN(3) => W_DATA(13), B_DIN(2)
         => W_DATA(12), B_DIN(1) => W_DATA(11), B_DIN(0) => 
        W_DATA(10), B_REN => \VCC\, B_WEN(1) => \GND\, B_WEN(0)
         => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => \GND\, 
        B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB => \GND\, 
        A_WIDTH(2) => \GND\, A_WIDTH(1) => \VCC\, A_WIDTH(0) => 
        \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => \GND\, A_BYPASS
         => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1) => \VCC\, 
        B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, B_WMODE(0) => 
        \GND\, B_BYPASS => \VCC\, ECC_BYPASS => \GND\);
    
    SPILLTAG_FIFO_SPILLTAG_FIFO_0_LSRAM_top_R0C3 : RAM1K20

              generic map(RAMINDEX => "core%4096-4096%20-20%SPEED%0%3%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc113, A_DOUT(18) => nc106, 
        A_DOUT(17) => nc25, A_DOUT(16) => nc1, A_DOUT(15) => nc37, 
        A_DOUT(14) => nc46, A_DOUT(13) => nc71, A_DOUT(12) => 
        nc124, A_DOUT(11) => nc81, A_DOUT(10) => nc34, A_DOUT(9)
         => nc28, A_DOUT(8) => nc115, A_DOUT(7) => nc134, 
        A_DOUT(6) => nc32, A_DOUT(5) => nc40, A_DOUT(4) => 
        R_DATA(19), A_DOUT(3) => R_DATA(18), A_DOUT(2) => 
        R_DATA(17), A_DOUT(1) => R_DATA(16), A_DOUT(0) => 
        R_DATA(15), B_DOUT(19) => nc99, B_DOUT(18) => nc75, 
        B_DOUT(17) => nc85, B_DOUT(16) => nc27, B_DOUT(15) => 
        nc108, B_DOUT(14) => nc16, B_DOUT(13) => nc51, B_DOUT(12)
         => nc33, B_DOUT(11) => nc78, B_DOUT(10) => nc24, 
        B_DOUT(9) => nc88, B_DOUT(8) => nc111, B_DOUT(7) => nc55, 
        B_DOUT(6) => nc10, B_DOUT(5) => nc22, B_DOUT(4) => nc77, 
        B_DOUT(3) => nc6, B_DOUT(2) => nc109, B_DOUT(1) => nc87, 
        B_DOUT(0) => nc123, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][3]\, A_ADDR(13) => 
        R_ADDR(11), A_ADDR(12) => R_ADDR(10), A_ADDR(11) => 
        R_ADDR(9), A_ADDR(10) => R_ADDR(8), A_ADDR(9) => 
        R_ADDR(7), A_ADDR(8) => R_ADDR(6), A_ADDR(7) => R_ADDR(5), 
        A_ADDR(6) => R_ADDR(4), A_ADDR(5) => R_ADDR(3), A_ADDR(4)
         => R_ADDR(2), A_ADDR(3) => R_ADDR(1), A_ADDR(2) => 
        R_ADDR(0), A_ADDR(1) => \GND\, A_ADDR(0) => \GND\, 
        A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => \VCC\, A_BLK_EN(0)
         => \VCC\, A_CLK => R_CLK, A_DIN(19) => \GND\, A_DIN(18)
         => \GND\, A_DIN(17) => \GND\, A_DIN(16) => \GND\, 
        A_DIN(15) => \GND\, A_DIN(14) => \GND\, A_DIN(13) => 
        \GND\, A_DIN(12) => \GND\, A_DIN(11) => \GND\, A_DIN(10)
         => \GND\, A_DIN(9) => \GND\, A_DIN(8) => \GND\, A_DIN(7)
         => \GND\, A_DIN(6) => \GND\, A_DIN(5) => \GND\, A_DIN(4)
         => \GND\, A_DIN(3) => \GND\, A_DIN(2) => \GND\, A_DIN(1)
         => \GND\, A_DIN(0) => \GND\, A_REN => R_EN, A_WEN(1) => 
        \GND\, A_WEN(0) => \GND\, A_DOUT_EN => \VCC\, 
        A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N => \VCC\, 
        B_ADDR(13) => W_ADDR(11), B_ADDR(12) => W_ADDR(10), 
        B_ADDR(11) => W_ADDR(9), B_ADDR(10) => W_ADDR(8), 
        B_ADDR(9) => W_ADDR(7), B_ADDR(8) => W_ADDR(6), B_ADDR(7)
         => W_ADDR(5), B_ADDR(6) => W_ADDR(4), B_ADDR(5) => 
        W_ADDR(3), B_ADDR(4) => W_ADDR(2), B_ADDR(3) => W_ADDR(1), 
        B_ADDR(2) => W_ADDR(0), B_ADDR(1) => \GND\, B_ADDR(0) => 
        \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => \VCC\, 
        B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19) => \GND\, 
        B_DIN(18) => \GND\, B_DIN(17) => \GND\, B_DIN(16) => 
        \GND\, B_DIN(15) => \GND\, B_DIN(14) => \GND\, B_DIN(13)
         => \GND\, B_DIN(12) => \GND\, B_DIN(11) => \GND\, 
        B_DIN(10) => \GND\, B_DIN(9) => \GND\, B_DIN(8) => \GND\, 
        B_DIN(7) => \GND\, B_DIN(6) => \GND\, B_DIN(5) => \GND\, 
        B_DIN(4) => W_DATA(19), B_DIN(3) => W_DATA(18), B_DIN(2)
         => W_DATA(17), B_DIN(1) => W_DATA(16), B_DIN(0) => 
        W_DATA(15), B_REN => \VCC\, B_WEN(1) => \GND\, B_WEN(0)
         => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => \GND\, 
        B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB => \GND\, 
        A_WIDTH(2) => \GND\, A_WIDTH(1) => \VCC\, A_WIDTH(0) => 
        \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => \GND\, A_BYPASS
         => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1) => \VCC\, 
        B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, B_WMODE(0) => 
        \GND\, B_BYPASS => \VCC\, ECC_BYPASS => \GND\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
