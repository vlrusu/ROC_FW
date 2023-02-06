----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:22:22 2023
-- Version: 2022.3 2022.3.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of SPI0 to TCL
--# Family: PolarFire
--# Part Number: MPF300TS-FCG484I
--# Create and Configure the core component SPI0
--create_and_configure_core -core_vlnv {Actel:DirectCore:CORESPI:5.2.104} -component_name {SPI0} -params {\
--"APB_DWIDTH:32"  \
--"CFG_CLK:7"  \
--"CFG_FIFO_DEPTH:4"  \
--"CFG_FRAME_SIZE:16"  \
--"CFG_MODE:0"  \
--"CFG_MOT_MODE:0"  \
--"CFG_MOT_SSEL:false"  \
--"CFG_NSC_OPERATION:0"  \
--"CFG_TI_JMB_FRAMES:false"  \
--"CFG_TI_NSC_CUSTOM:0"  \
--"CFG_TI_NSC_FRC:false"   }
--# Exporting Component Description of SPI0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
library CORESPI_LIB;
use CORESPI_LIB.all;
----------------------------------------------------------------------
-- SPI0 entity declaration
----------------------------------------------------------------------
entity SPI0 is
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(31 downto 0);
        PREADY     : out std_logic;
        PSLVERR    : out std_logic;
        SPIINT     : out std_logic;
        SPIMODE    : out std_logic;
        SPIOEN     : out std_logic;
        SPIRXAVAIL : out std_logic;
        SPISCLKO   : out std_logic;
        SPISDO     : out std_logic;
        SPISS      : out std_logic_vector(7 downto 0);
        SPITXRFM   : out std_logic
        );
end SPI0;
----------------------------------------------------------------------
-- SPI0 architecture body
----------------------------------------------------------------------
architecture RTL of SPI0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CORESPI   -   Actel:DirectCore:CORESPI:5.2.104
component CORESPI
    generic( 
        APB_DWIDTH        : integer := 32 ;
        CFG_CLK           : integer := 7 ;
        CFG_FIFO_DEPTH    : integer := 4 ;
        CFG_FRAME_SIZE    : integer := 16 ;
        CFG_MODE          : integer := 0 ;
        CFG_MOT_MODE      : integer := 0 ;
        CFG_MOT_SSEL      : integer := 0 ;
        CFG_NSC_OPERATION : integer := 0 ;
        CFG_TI_JMB_FRAMES : integer := 0 ;
        CFG_TI_NSC_CUSTOM : integer := 0 ;
        CFG_TI_NSC_FRC    : integer := 0 
        );
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(31 downto 0);
        PREADY     : out std_logic;
        PSLVERR    : out std_logic;
        SPIINT     : out std_logic;
        SPIMODE    : out std_logic;
        SPIOEN     : out std_logic;
        SPIRXAVAIL : out std_logic;
        SPISCLKO   : out std_logic;
        SPISDO     : out std_logic;
        SPISS      : out std_logic_vector(7 downto 0);
        SPITXRFM   : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal APB_bif_PRDATA        : std_logic_vector(31 downto 0);
signal APB_bif_PREADY        : std_logic;
signal APB_bif_PSLVERR       : std_logic;
signal SPIINT_net_0          : std_logic;
signal SPIMODE_net_0         : std_logic;
signal SPIOEN_net_0          : std_logic;
signal SPIRXAVAIL_net_0      : std_logic;
signal SPISCLKO_net_0        : std_logic;
signal SPISDO_net_0          : std_logic;
signal SPISS_net_0           : std_logic_vector(7 downto 0);
signal SPITXRFM_net_0        : std_logic;
signal SPIINT_net_1          : std_logic;
signal SPIRXAVAIL_net_1      : std_logic;
signal SPITXRFM_net_1        : std_logic;
signal SPISS_net_1           : std_logic_vector(7 downto 0);
signal SPISCLKO_net_1        : std_logic;
signal SPIOEN_net_1          : std_logic;
signal SPISDO_net_1          : std_logic;
signal SPIMODE_net_1         : std_logic;
signal APB_bif_PRDATA_net_0  : std_logic_vector(31 downto 0);
signal APB_bif_PREADY_net_0  : std_logic;
signal APB_bif_PSLVERR_net_0 : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPIINT_net_1          <= SPIINT_net_0;
 SPIINT                <= SPIINT_net_1;
 SPIRXAVAIL_net_1      <= SPIRXAVAIL_net_0;
 SPIRXAVAIL            <= SPIRXAVAIL_net_1;
 SPITXRFM_net_1        <= SPITXRFM_net_0;
 SPITXRFM              <= SPITXRFM_net_1;
 SPISS_net_1           <= SPISS_net_0;
 SPISS(7 downto 0)     <= SPISS_net_1;
 SPISCLKO_net_1        <= SPISCLKO_net_0;
 SPISCLKO              <= SPISCLKO_net_1;
 SPIOEN_net_1          <= SPIOEN_net_0;
 SPIOEN                <= SPIOEN_net_1;
 SPISDO_net_1          <= SPISDO_net_0;
 SPISDO                <= SPISDO_net_1;
 SPIMODE_net_1         <= SPIMODE_net_0;
 SPIMODE               <= SPIMODE_net_1;
 APB_bif_PRDATA_net_0  <= APB_bif_PRDATA;
 PRDATA(31 downto 0)   <= APB_bif_PRDATA_net_0;
 APB_bif_PREADY_net_0  <= APB_bif_PREADY;
 PREADY                <= APB_bif_PREADY_net_0;
 APB_bif_PSLVERR_net_0 <= APB_bif_PSLVERR;
 PSLVERR               <= APB_bif_PSLVERR_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- SPI0_0   -   Actel:DirectCore:CORESPI:5.2.104
SPI0_0 : CORESPI
    generic map( 
        APB_DWIDTH        => ( 32 ),
        CFG_CLK           => ( 7 ),
        CFG_FIFO_DEPTH    => ( 4 ),
        CFG_FRAME_SIZE    => ( 16 ),
        CFG_MODE          => ( 0 ),
        CFG_MOT_MODE      => ( 0 ),
        CFG_MOT_SSEL      => ( 0 ),
        CFG_NSC_OPERATION => ( 0 ),
        CFG_TI_JMB_FRAMES => ( 0 ),
        CFG_TI_NSC_CUSTOM => ( 0 ),
        CFG_TI_NSC_FRC    => ( 0 )
        )
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        PADDR      => PADDR,
        PSEL       => PSEL,
        PENABLE    => PENABLE,
        PWRITE     => PWRITE,
        PWDATA     => PWDATA,
        SPISSI     => SPISSI,
        SPISDI     => SPISDI,
        SPICLKI    => SPICLKI,
        -- Outputs
        PRDATA     => APB_bif_PRDATA,
        PREADY     => APB_bif_PREADY,
        PSLVERR    => APB_bif_PSLVERR,
        SPIINT     => SPIINT_net_0,
        SPIRXAVAIL => SPIRXAVAIL_net_0,
        SPITXRFM   => SPITXRFM_net_0,
        SPISS      => SPISS_net_0,
        SPISCLKO   => SPISCLKO_net_0,
        SPIOEN     => SPIOEN_net_0,
        SPISDO     => SPISDO_net_0,
        SPIMODE    => SPIMODE_net_0 
        );

end RTL;
