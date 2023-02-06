-- Version: 2022.3 2022.3.0.8

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity SIM_ROC_FIFO_SIM_ROC_FIFO_0_LSRAM_top is

    port( W_DATA : in    std_logic_vector(31 downto 0);
          R_DATA : out   std_logic_vector(31 downto 0);
          W_ADDR : in    std_logic_vector(10 downto 0);
          R_ADDR : in    std_logic_vector(10 downto 0);
          W_EN   : in    std_logic;
          R_EN   : in    std_logic;
          W_CLK  : in    std_logic;
          R_CLK  : in    std_logic
        );

end SIM_ROC_FIFO_SIM_ROC_FIFO_0_LSRAM_top;

architecture DEF_ARCH of SIM_ROC_FIFO_SIM_ROC_FIFO_0_LSRAM_top is 

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
    signal nc123, nc121, nc47, nc113, nc111, nc34, nc98, nc89, 
        nc70, nc60, nc105, nc74, nc120, nc119, nc64, nc110, nc9, 
        nc92, nc91, nc13, nc23, nc55, nc80, nc33, nc84, nc16, 
        nc26, nc45, nc73, nc58, nc63, nc27, nc17, nc127, nc99, 
        nc126, nc117, nc36, nc116, nc48, nc37, nc5, nc103, nc101, 
        nc52, nc76, nc51, nc66, nc77, nc67, nc4, nc124, nc109, 
        nc42, nc114, nc100, nc83, nc41, nc90, nc94, nc122, nc112, 
        nc86, nc59, nc25, nc15, nc87, nc35, nc49, nc28, nc18, 
        nc128, nc107, nc118, nc106, nc75, nc65, nc38, nc93, nc1, 
        nc2, nc50, nc22, nc12, nc21, nc11, nc78, nc54, nc68, nc3, 
        nc32, nc104, nc40, nc31, nc96, nc44, nc7, nc97, nc85, 
        nc72, nc6, nc71, nc62, nc61, nc125, nc115, nc102, nc19, 
        nc29, nc88, nc53, nc39, nc8, nc82, nc108, nc81, nc79, 
        nc43, nc69, nc56, nc20, nc10, nc57, nc95, nc24, nc14, 
        nc46, nc30 : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    SIM_ROC_FIFO_SIM_ROC_FIFO_0_LSRAM_top_R0C3 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%32-32%SPEED%0%3%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc123, A_DOUT(18) => nc121, 
        A_DOUT(17) => nc47, A_DOUT(16) => nc113, A_DOUT(15) => 
        nc111, A_DOUT(14) => nc34, A_DOUT(13) => nc98, A_DOUT(12)
         => nc89, A_DOUT(11) => nc70, A_DOUT(10) => nc60, 
        A_DOUT(9) => nc105, A_DOUT(8) => nc74, A_DOUT(7) => 
        R_DATA(31), A_DOUT(6) => R_DATA(30), A_DOUT(5) => 
        R_DATA(29), A_DOUT(4) => R_DATA(28), A_DOUT(3) => 
        R_DATA(27), A_DOUT(2) => R_DATA(26), A_DOUT(1) => 
        R_DATA(25), A_DOUT(0) => R_DATA(24), B_DOUT(19) => nc120, 
        B_DOUT(18) => nc119, B_DOUT(17) => nc64, B_DOUT(16) => 
        nc110, B_DOUT(15) => nc9, B_DOUT(14) => nc92, B_DOUT(13)
         => nc91, B_DOUT(12) => nc13, B_DOUT(11) => nc23, 
        B_DOUT(10) => nc55, B_DOUT(9) => nc80, B_DOUT(8) => nc33, 
        B_DOUT(7) => nc84, B_DOUT(6) => nc16, B_DOUT(5) => nc26, 
        B_DOUT(4) => nc45, B_DOUT(3) => nc73, B_DOUT(2) => nc58, 
        B_DOUT(1) => nc63, B_DOUT(0) => nc27, DB_DETECT => OPEN, 
        SB_CORRECT => OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][3]\, 
        A_ADDR(13) => R_ADDR(10), A_ADDR(12) => R_ADDR(9), 
        A_ADDR(11) => R_ADDR(8), A_ADDR(10) => R_ADDR(7), 
        A_ADDR(9) => R_ADDR(6), A_ADDR(8) => R_ADDR(5), A_ADDR(7)
         => R_ADDR(4), A_ADDR(6) => R_ADDR(3), A_ADDR(5) => 
        R_ADDR(2), A_ADDR(4) => R_ADDR(1), A_ADDR(3) => R_ADDR(0), 
        A_ADDR(2) => \GND\, A_ADDR(1) => \GND\, A_ADDR(0) => 
        \GND\, A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => \VCC\, 
        A_BLK_EN(0) => \VCC\, A_CLK => R_CLK, A_DIN(19) => \GND\, 
        A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16) => 
        \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, A_DIN(13)
         => \GND\, A_DIN(12) => \GND\, A_DIN(11) => \GND\, 
        A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8) => \GND\, 
        A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5) => \GND\, 
        A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2) => \GND\, 
        A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN => R_EN, 
        A_WEN(1) => \GND\, A_WEN(0) => \GND\, A_DOUT_EN => \VCC\, 
        A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N => \VCC\, 
        B_ADDR(13) => W_ADDR(10), B_ADDR(12) => W_ADDR(9), 
        B_ADDR(11) => W_ADDR(8), B_ADDR(10) => W_ADDR(7), 
        B_ADDR(9) => W_ADDR(6), B_ADDR(8) => W_ADDR(5), B_ADDR(7)
         => W_ADDR(4), B_ADDR(6) => W_ADDR(3), B_ADDR(5) => 
        W_ADDR(2), B_ADDR(4) => W_ADDR(1), B_ADDR(3) => W_ADDR(0), 
        B_ADDR(2) => \GND\, B_ADDR(1) => \GND\, B_ADDR(0) => 
        \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => \VCC\, 
        B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19) => \GND\, 
        B_DIN(18) => \GND\, B_DIN(17) => \GND\, B_DIN(16) => 
        \GND\, B_DIN(15) => \GND\, B_DIN(14) => \GND\, B_DIN(13)
         => \GND\, B_DIN(12) => \GND\, B_DIN(11) => \GND\, 
        B_DIN(10) => \GND\, B_DIN(9) => \GND\, B_DIN(8) => \GND\, 
        B_DIN(7) => W_DATA(31), B_DIN(6) => W_DATA(30), B_DIN(5)
         => W_DATA(29), B_DIN(4) => W_DATA(28), B_DIN(3) => 
        W_DATA(27), B_DIN(2) => W_DATA(26), B_DIN(1) => 
        W_DATA(25), B_DIN(0) => W_DATA(24), B_REN => \VCC\, 
        B_WEN(1) => \GND\, B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, 
        B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN
         => \GND\, BUSY_FB => \GND\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => 
        \GND\, A_WMODE(0) => \GND\, A_BYPASS => \VCC\, B_WIDTH(2)
         => \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \VCC\, ECC_BYPASS => \GND\);
    
    SIM_ROC_FIFO_SIM_ROC_FIFO_0_LSRAM_top_R0C2 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%32-32%SPEED%0%2%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc17, A_DOUT(18) => nc127, 
        A_DOUT(17) => nc99, A_DOUT(16) => nc126, A_DOUT(15) => 
        nc117, A_DOUT(14) => nc36, A_DOUT(13) => nc116, 
        A_DOUT(12) => nc48, A_DOUT(11) => nc37, A_DOUT(10) => nc5, 
        A_DOUT(9) => nc103, A_DOUT(8) => nc101, A_DOUT(7) => 
        R_DATA(23), A_DOUT(6) => R_DATA(22), A_DOUT(5) => 
        R_DATA(21), A_DOUT(4) => R_DATA(20), A_DOUT(3) => 
        R_DATA(19), A_DOUT(2) => R_DATA(18), A_DOUT(1) => 
        R_DATA(17), A_DOUT(0) => R_DATA(16), B_DOUT(19) => nc52, 
        B_DOUT(18) => nc76, B_DOUT(17) => nc51, B_DOUT(16) => 
        nc66, B_DOUT(15) => nc77, B_DOUT(14) => nc67, B_DOUT(13)
         => nc4, B_DOUT(12) => nc124, B_DOUT(11) => nc109, 
        B_DOUT(10) => nc42, B_DOUT(9) => nc114, B_DOUT(8) => 
        nc100, B_DOUT(7) => nc83, B_DOUT(6) => nc41, B_DOUT(5)
         => nc90, B_DOUT(4) => nc94, B_DOUT(3) => nc122, 
        B_DOUT(2) => nc112, B_DOUT(1) => nc86, B_DOUT(0) => nc59, 
        DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY => 
        \ACCESS_BUSY[0][2]\, A_ADDR(13) => R_ADDR(10), A_ADDR(12)
         => R_ADDR(9), A_ADDR(11) => R_ADDR(8), A_ADDR(10) => 
        R_ADDR(7), A_ADDR(9) => R_ADDR(6), A_ADDR(8) => R_ADDR(5), 
        A_ADDR(7) => R_ADDR(4), A_ADDR(6) => R_ADDR(3), A_ADDR(5)
         => R_ADDR(2), A_ADDR(4) => R_ADDR(1), A_ADDR(3) => 
        R_ADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => \GND\, 
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
         => \VCC\, B_ADDR(13) => W_ADDR(10), B_ADDR(12) => 
        W_ADDR(9), B_ADDR(11) => W_ADDR(8), B_ADDR(10) => 
        W_ADDR(7), B_ADDR(9) => W_ADDR(6), B_ADDR(8) => W_ADDR(5), 
        B_ADDR(7) => W_ADDR(4), B_ADDR(6) => W_ADDR(3), B_ADDR(5)
         => W_ADDR(2), B_ADDR(4) => W_ADDR(1), B_ADDR(3) => 
        W_ADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => \GND\, 
        B_ADDR(0) => \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => 
        \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19)
         => \GND\, B_DIN(18) => \GND\, B_DIN(17) => \GND\, 
        B_DIN(16) => \GND\, B_DIN(15) => \GND\, B_DIN(14) => 
        \GND\, B_DIN(13) => \GND\, B_DIN(12) => \GND\, B_DIN(11)
         => \GND\, B_DIN(10) => \GND\, B_DIN(9) => \GND\, 
        B_DIN(8) => \GND\, B_DIN(7) => W_DATA(23), B_DIN(6) => 
        W_DATA(22), B_DIN(5) => W_DATA(21), B_DIN(4) => 
        W_DATA(20), B_DIN(3) => W_DATA(19), B_DIN(2) => 
        W_DATA(18), B_DIN(1) => W_DATA(17), B_DIN(0) => 
        W_DATA(16), B_REN => \VCC\, B_WEN(1) => \GND\, B_WEN(0)
         => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => \GND\, 
        B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB => \GND\, 
        A_WIDTH(2) => \GND\, A_WIDTH(1) => \VCC\, A_WIDTH(0) => 
        \VCC\, A_WMODE(1) => \GND\, A_WMODE(0) => \GND\, A_BYPASS
         => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1) => \VCC\, 
        B_WIDTH(0) => \VCC\, B_WMODE(1) => \GND\, B_WMODE(0) => 
        \GND\, B_BYPASS => \VCC\, ECC_BYPASS => \GND\);
    
    SIM_ROC_FIFO_SIM_ROC_FIFO_0_LSRAM_top_R0C1 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%32-32%SPEED%0%1%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc25, A_DOUT(18) => nc15, A_DOUT(17)
         => nc87, A_DOUT(16) => nc35, A_DOUT(15) => nc49, 
        A_DOUT(14) => nc28, A_DOUT(13) => nc18, A_DOUT(12) => 
        nc128, A_DOUT(11) => nc107, A_DOUT(10) => nc118, 
        A_DOUT(9) => nc106, A_DOUT(8) => nc75, A_DOUT(7) => 
        R_DATA(15), A_DOUT(6) => R_DATA(14), A_DOUT(5) => 
        R_DATA(13), A_DOUT(4) => R_DATA(12), A_DOUT(3) => 
        R_DATA(11), A_DOUT(2) => R_DATA(10), A_DOUT(1) => 
        R_DATA(9), A_DOUT(0) => R_DATA(8), B_DOUT(19) => nc65, 
        B_DOUT(18) => nc38, B_DOUT(17) => nc93, B_DOUT(16) => nc1, 
        B_DOUT(15) => nc2, B_DOUT(14) => nc50, B_DOUT(13) => nc22, 
        B_DOUT(12) => nc12, B_DOUT(11) => nc21, B_DOUT(10) => 
        nc11, B_DOUT(9) => nc78, B_DOUT(8) => nc54, B_DOUT(7) => 
        nc68, B_DOUT(6) => nc3, B_DOUT(5) => nc32, B_DOUT(4) => 
        nc104, B_DOUT(3) => nc40, B_DOUT(2) => nc31, B_DOUT(1)
         => nc96, B_DOUT(0) => nc44, DB_DETECT => OPEN, 
        SB_CORRECT => OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][1]\, 
        A_ADDR(13) => R_ADDR(10), A_ADDR(12) => R_ADDR(9), 
        A_ADDR(11) => R_ADDR(8), A_ADDR(10) => R_ADDR(7), 
        A_ADDR(9) => R_ADDR(6), A_ADDR(8) => R_ADDR(5), A_ADDR(7)
         => R_ADDR(4), A_ADDR(6) => R_ADDR(3), A_ADDR(5) => 
        R_ADDR(2), A_ADDR(4) => R_ADDR(1), A_ADDR(3) => R_ADDR(0), 
        A_ADDR(2) => \GND\, A_ADDR(1) => \GND\, A_ADDR(0) => 
        \GND\, A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => \VCC\, 
        A_BLK_EN(0) => \VCC\, A_CLK => R_CLK, A_DIN(19) => \GND\, 
        A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16) => 
        \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, A_DIN(13)
         => \GND\, A_DIN(12) => \GND\, A_DIN(11) => \GND\, 
        A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8) => \GND\, 
        A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5) => \GND\, 
        A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2) => \GND\, 
        A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN => R_EN, 
        A_WEN(1) => \GND\, A_WEN(0) => \GND\, A_DOUT_EN => \VCC\, 
        A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N => \VCC\, 
        B_ADDR(13) => W_ADDR(10), B_ADDR(12) => W_ADDR(9), 
        B_ADDR(11) => W_ADDR(8), B_ADDR(10) => W_ADDR(7), 
        B_ADDR(9) => W_ADDR(6), B_ADDR(8) => W_ADDR(5), B_ADDR(7)
         => W_ADDR(4), B_ADDR(6) => W_ADDR(3), B_ADDR(5) => 
        W_ADDR(2), B_ADDR(4) => W_ADDR(1), B_ADDR(3) => W_ADDR(0), 
        B_ADDR(2) => \GND\, B_ADDR(1) => \GND\, B_ADDR(0) => 
        \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => \VCC\, 
        B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19) => \GND\, 
        B_DIN(18) => \GND\, B_DIN(17) => \GND\, B_DIN(16) => 
        \GND\, B_DIN(15) => \GND\, B_DIN(14) => \GND\, B_DIN(13)
         => \GND\, B_DIN(12) => \GND\, B_DIN(11) => \GND\, 
        B_DIN(10) => \GND\, B_DIN(9) => \GND\, B_DIN(8) => \GND\, 
        B_DIN(7) => W_DATA(15), B_DIN(6) => W_DATA(14), B_DIN(5)
         => W_DATA(13), B_DIN(4) => W_DATA(12), B_DIN(3) => 
        W_DATA(11), B_DIN(2) => W_DATA(10), B_DIN(1) => W_DATA(9), 
        B_DIN(0) => W_DATA(8), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \VCC\, 
        A_WIDTH(0) => \VCC\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \VCC\, B_WIDTH(0) => \VCC\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    SIM_ROC_FIFO_SIM_ROC_FIFO_0_LSRAM_top_R0C0 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%32-32%SPEED%0%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc7, A_DOUT(18) => nc97, A_DOUT(17)
         => nc85, A_DOUT(16) => nc72, A_DOUT(15) => nc6, 
        A_DOUT(14) => nc71, A_DOUT(13) => nc62, A_DOUT(12) => 
        nc61, A_DOUT(11) => nc125, A_DOUT(10) => nc115, A_DOUT(9)
         => nc102, A_DOUT(8) => nc19, A_DOUT(7) => R_DATA(7), 
        A_DOUT(6) => R_DATA(6), A_DOUT(5) => R_DATA(5), A_DOUT(4)
         => R_DATA(4), A_DOUT(3) => R_DATA(3), A_DOUT(2) => 
        R_DATA(2), A_DOUT(1) => R_DATA(1), A_DOUT(0) => R_DATA(0), 
        B_DOUT(19) => nc29, B_DOUT(18) => nc88, B_DOUT(17) => 
        nc53, B_DOUT(16) => nc39, B_DOUT(15) => nc8, B_DOUT(14)
         => nc82, B_DOUT(13) => nc108, B_DOUT(12) => nc81, 
        B_DOUT(11) => nc79, B_DOUT(10) => nc43, B_DOUT(9) => nc69, 
        B_DOUT(8) => nc56, B_DOUT(7) => nc20, B_DOUT(6) => nc10, 
        B_DOUT(5) => nc57, B_DOUT(4) => nc95, B_DOUT(3) => nc24, 
        B_DOUT(2) => nc14, B_DOUT(1) => nc46, B_DOUT(0) => nc30, 
        DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY => 
        \ACCESS_BUSY[0][0]\, A_ADDR(13) => R_ADDR(10), A_ADDR(12)
         => R_ADDR(9), A_ADDR(11) => R_ADDR(8), A_ADDR(10) => 
        R_ADDR(7), A_ADDR(9) => R_ADDR(6), A_ADDR(8) => R_ADDR(5), 
        A_ADDR(7) => R_ADDR(4), A_ADDR(6) => R_ADDR(3), A_ADDR(5)
         => R_ADDR(2), A_ADDR(4) => R_ADDR(1), A_ADDR(3) => 
        R_ADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => \GND\, 
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
         => \VCC\, B_ADDR(13) => W_ADDR(10), B_ADDR(12) => 
        W_ADDR(9), B_ADDR(11) => W_ADDR(8), B_ADDR(10) => 
        W_ADDR(7), B_ADDR(9) => W_ADDR(6), B_ADDR(8) => W_ADDR(5), 
        B_ADDR(7) => W_ADDR(4), B_ADDR(6) => W_ADDR(3), B_ADDR(5)
         => W_ADDR(2), B_ADDR(4) => W_ADDR(1), B_ADDR(3) => 
        W_ADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => \GND\, 
        B_ADDR(0) => \GND\, B_BLK_EN(2) => W_EN, B_BLK_EN(1) => 
        \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => W_CLK, B_DIN(19)
         => \GND\, B_DIN(18) => \GND\, B_DIN(17) => \GND\, 
        B_DIN(16) => \GND\, B_DIN(15) => \GND\, B_DIN(14) => 
        \GND\, B_DIN(13) => \GND\, B_DIN(12) => \GND\, B_DIN(11)
         => \GND\, B_DIN(10) => \GND\, B_DIN(9) => \GND\, 
        B_DIN(8) => \GND\, B_DIN(7) => W_DATA(7), B_DIN(6) => 
        W_DATA(6), B_DIN(5) => W_DATA(5), B_DIN(4) => W_DATA(4), 
        B_DIN(3) => W_DATA(3), B_DIN(2) => W_DATA(2), B_DIN(1)
         => W_DATA(1), B_DIN(0) => W_DATA(0), B_REN => \VCC\, 
        B_WEN(1) => \GND\, B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, 
        B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN
         => \GND\, BUSY_FB => \GND\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => 
        \GND\, A_WMODE(0) => \GND\, A_BYPASS => \VCC\, B_WIDTH(2)
         => \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \VCC\, ECC_BYPASS => \GND\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
