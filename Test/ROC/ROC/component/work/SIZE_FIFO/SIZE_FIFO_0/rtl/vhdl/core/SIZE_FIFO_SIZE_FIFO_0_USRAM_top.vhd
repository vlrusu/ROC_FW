-- Version: 2022.3 2022.3.0.8

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity SIZE_FIFO_SIZE_FIFO_0_USRAM_top is

    port( R_DATA        : out   std_logic_vector(11 downto 0);
          W_DATA        : in    std_logic_vector(11 downto 0);
          R_ADDR        : in    std_logic_vector(5 downto 0);
          W_ADDR        : in    std_logic_vector(5 downto 0);
          BLK_EN        : in    std_logic;
          R_ADDR_ARST_N : in    std_logic;
          R_ADDR_EN     : in    std_logic;
          R_CLK         : in    std_logic;
          W_CLK         : in    std_logic;
          W_EN          : in    std_logic
        );

end SIZE_FIFO_SIZE_FIFO_0_USRAM_top;

architecture DEF_ARCH of SIZE_FIFO_SIZE_FIFO_0_USRAM_top is 

  component RAM64x12
    generic (MEMORYFILE:string := ""; RAMINDEX:string := ""; 
        INIT0:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT1:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT2:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT3:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT4:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT5:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT6:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT7:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT8:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT9:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT10:std_logic_vector(63 downto 0) := (others => 'X'); 
        INIT11:std_logic_vector(63 downto 0) := (others => 'X')
        );

    port( BLK_EN        : in    std_logic := 'U';
          BUSY_FB       : in    std_logic := 'U';
          R_ADDR        : in    std_logic_vector(5 downto 0) := (others => 'U');
          R_ADDR_AD_N   : in    std_logic := 'U';
          R_ADDR_AL_N   : in    std_logic := 'U';
          R_ADDR_BYPASS : in    std_logic := 'U';
          R_ADDR_EN     : in    std_logic := 'U';
          R_ADDR_SD     : in    std_logic := 'U';
          R_ADDR_SL_N   : in    std_logic := 'U';
          R_CLK         : in    std_logic := 'U';
          R_DATA_AD_N   : in    std_logic := 'U';
          R_DATA_AL_N   : in    std_logic := 'U';
          R_DATA_BYPASS : in    std_logic := 'U';
          R_DATA_EN     : in    std_logic := 'U';
          R_DATA_SD     : in    std_logic := 'U';
          R_DATA_SL_N   : in    std_logic := 'U';
          W_ADDR        : in    std_logic_vector(5 downto 0) := (others => 'U');
          W_CLK         : in    std_logic := 'U';
          W_DATA        : in    std_logic_vector(11 downto 0) := (others => 'U');
          W_EN          : in    std_logic := 'U';
          ACCESS_BUSY   : out   std_logic;
          R_DATA        : out   std_logic_vector(11 downto 0)
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

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    SIZE_FIFO_SIZE_FIFO_0_USRAM_top_R0C0 : RAM64x12
      generic map(RAMINDEX => "core%64%12%SPEED%0%0%MICRO_RAM")

      port map(BLK_EN => BLK_EN, BUSY_FB => \GND\, R_ADDR(5) => 
        R_ADDR(5), R_ADDR(4) => R_ADDR(4), R_ADDR(3) => R_ADDR(3), 
        R_ADDR(2) => R_ADDR(2), R_ADDR(1) => R_ADDR(1), R_ADDR(0)
         => R_ADDR(0), R_ADDR_AD_N => \VCC\, R_ADDR_AL_N => 
        R_ADDR_ARST_N, R_ADDR_BYPASS => \GND\, R_ADDR_EN => 
        R_ADDR_EN, R_ADDR_SD => \GND\, R_ADDR_SL_N => \VCC\, 
        R_CLK => R_CLK, R_DATA_AD_N => \VCC\, R_DATA_AL_N => 
        \VCC\, R_DATA_BYPASS => \VCC\, R_DATA_EN => \VCC\, 
        R_DATA_SD => \GND\, R_DATA_SL_N => \VCC\, W_ADDR(5) => 
        W_ADDR(5), W_ADDR(4) => W_ADDR(4), W_ADDR(3) => W_ADDR(3), 
        W_ADDR(2) => W_ADDR(2), W_ADDR(1) => W_ADDR(1), W_ADDR(0)
         => W_ADDR(0), W_CLK => W_CLK, W_DATA(11) => W_DATA(11), 
        W_DATA(10) => W_DATA(10), W_DATA(9) => W_DATA(9), 
        W_DATA(8) => W_DATA(8), W_DATA(7) => W_DATA(7), W_DATA(6)
         => W_DATA(6), W_DATA(5) => W_DATA(5), W_DATA(4) => 
        W_DATA(4), W_DATA(3) => W_DATA(3), W_DATA(2) => W_DATA(2), 
        W_DATA(1) => W_DATA(1), W_DATA(0) => W_DATA(0), W_EN => 
        W_EN, ACCESS_BUSY => \ACCESS_BUSY[0][0]\, R_DATA(11) => 
        R_DATA(11), R_DATA(10) => R_DATA(10), R_DATA(9) => 
        R_DATA(9), R_DATA(8) => R_DATA(8), R_DATA(7) => R_DATA(7), 
        R_DATA(6) => R_DATA(6), R_DATA(5) => R_DATA(5), R_DATA(4)
         => R_DATA(4), R_DATA(3) => R_DATA(3), R_DATA(2) => 
        R_DATA(2), R_DATA(1) => R_DATA(1), R_DATA(0) => R_DATA(0));
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
