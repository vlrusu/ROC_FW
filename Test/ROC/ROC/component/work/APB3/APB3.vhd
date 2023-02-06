----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:22:06 2023
-- Version: 2022.3 2022.3.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of APB3 to TCL
--# Family: PolarFire
--# Part Number: MPF300TS-FCG484I
--# Create and Configure the core component APB3
--create_and_configure_core -core_vlnv {Actel:DirectCore:CoreAPB3:4.2.100} -component_name {APB3} -params {\
--"APB_DWIDTH:32"  \
--"APBSLOT0ENABLE:true"  \
--"APBSLOT1ENABLE:true"  \
--"APBSLOT2ENABLE:true"  \
--"APBSLOT3ENABLE:true"  \
--"APBSLOT4ENABLE:true"  \
--"APBSLOT5ENABLE:true"  \
--"APBSLOT6ENABLE:true"  \
--"APBSLOT7ENABLE:true"  \
--"APBSLOT8ENABLE:true"  \
--"APBSLOT9ENABLE:true"  \
--"APBSLOT10ENABLE:false"  \
--"APBSLOT11ENABLE:false"  \
--"APBSLOT12ENABLE:false"  \
--"APBSLOT13ENABLE:false"  \
--"APBSLOT14ENABLE:false"  \
--"APBSLOT15ENABLE:false"  \
--"IADDR_OPTION:0"  \
--"MADDR_BITS:16"  \
--"SC_0:false"  \
--"SC_1:false"  \
--"SC_2:false"  \
--"SC_3:false"  \
--"SC_4:false"  \
--"SC_5:false"  \
--"SC_6:false"  \
--"SC_7:false"  \
--"SC_8:false"  \
--"SC_9:false"  \
--"SC_10:false"  \
--"SC_11:false"  \
--"SC_12:false"  \
--"SC_13:false"  \
--"SC_14:false"  \
--"SC_15:false"  \
--"UPR_NIBBLE_POSN:6"   }
--# Exporting Component Description of APB3 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
library COREAPB3_LIB;
use COREAPB3_LIB.all;
use COREAPB3_LIB.components.all;
----------------------------------------------------------------------
-- APB3 entity declaration
----------------------------------------------------------------------
entity APB3 is
    -- Port list
    port(
        -- Inputs
        PADDR     : in  std_logic_vector(31 downto 0);
        PENABLE   : in  std_logic;
        PRDATAS0  : in  std_logic_vector(31 downto 0);
        PRDATAS1  : in  std_logic_vector(31 downto 0);
        PRDATAS2  : in  std_logic_vector(31 downto 0);
        PRDATAS3  : in  std_logic_vector(31 downto 0);
        PRDATAS4  : in  std_logic_vector(31 downto 0);
        PRDATAS5  : in  std_logic_vector(31 downto 0);
        PRDATAS6  : in  std_logic_vector(31 downto 0);
        PRDATAS7  : in  std_logic_vector(31 downto 0);
        PRDATAS8  : in  std_logic_vector(31 downto 0);
        PRDATAS9  : in  std_logic_vector(31 downto 0);
        PREADYS0  : in  std_logic;
        PREADYS1  : in  std_logic;
        PREADYS2  : in  std_logic;
        PREADYS3  : in  std_logic;
        PREADYS4  : in  std_logic;
        PREADYS5  : in  std_logic;
        PREADYS6  : in  std_logic;
        PREADYS7  : in  std_logic;
        PREADYS8  : in  std_logic;
        PREADYS9  : in  std_logic;
        PSEL      : in  std_logic;
        PSLVERRS0 : in  std_logic;
        PSLVERRS1 : in  std_logic;
        PSLVERRS2 : in  std_logic;
        PSLVERRS3 : in  std_logic;
        PSLVERRS4 : in  std_logic;
        PSLVERRS5 : in  std_logic;
        PSLVERRS6 : in  std_logic;
        PSLVERRS7 : in  std_logic;
        PSLVERRS8 : in  std_logic;
        PSLVERRS9 : in  std_logic;
        PWDATA    : in  std_logic_vector(31 downto 0);
        PWRITE    : in  std_logic;
        -- Outputs
        PADDRS    : out std_logic_vector(31 downto 0);
        PENABLES  : out std_logic;
        PRDATA    : out std_logic_vector(31 downto 0);
        PREADY    : out std_logic;
        PSELS0    : out std_logic;
        PSELS1    : out std_logic;
        PSELS2    : out std_logic;
        PSELS3    : out std_logic;
        PSELS4    : out std_logic;
        PSELS5    : out std_logic;
        PSELS6    : out std_logic;
        PSELS7    : out std_logic;
        PSELS8    : out std_logic;
        PSELS9    : out std_logic;
        PSLVERR   : out std_logic;
        PWDATAS   : out std_logic_vector(31 downto 0);
        PWRITES   : out std_logic
        );
end APB3;
----------------------------------------------------------------------
-- APB3 architecture body
----------------------------------------------------------------------
architecture RTL of APB3 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.2.100
-- using entity instantiation for component CoreAPB3
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal APB3mmaster_PRDATA        : std_logic_vector(31 downto 0);
signal APB3mmaster_PREADY        : std_logic;
signal APB3mmaster_PSLVERR       : std_logic;
signal APBmslave0_PADDR          : std_logic_vector(31 downto 0);
signal APBmslave0_PENABLE        : std_logic;
signal APBmslave0_PSELx          : std_logic;
signal APBmslave0_PWDATA         : std_logic_vector(31 downto 0);
signal APBmslave0_PWRITE         : std_logic;
signal APBmslave1_PSELx          : std_logic;
signal APBmslave2_PSELx          : std_logic;
signal APBmslave3_PSELx          : std_logic;
signal APBmslave4_PSELx          : std_logic;
signal APBmslave5_PSELx          : std_logic;
signal APBmslave6_PSELx          : std_logic;
signal APBmslave7_PSELx          : std_logic;
signal APBmslave8_PSELx          : std_logic;
signal APBmslave9_PSELx          : std_logic;
signal APB3mmaster_PRDATA_net_0  : std_logic_vector(31 downto 0);
signal APB3mmaster_PREADY_net_0  : std_logic;
signal APB3mmaster_PSLVERR_net_0 : std_logic;
signal APBmslave0_PADDR_net_0    : std_logic_vector(31 downto 0);
signal APBmslave0_PSELx_net_0    : std_logic;
signal APBmslave0_PENABLE_net_0  : std_logic;
signal APBmslave0_PWRITE_net_0   : std_logic;
signal APBmslave0_PWDATA_net_0   : std_logic_vector(31 downto 0);
signal APBmslave1_PSELx_net_0    : std_logic;
signal APBmslave2_PSELx_net_0    : std_logic;
signal APBmslave3_PSELx_net_0    : std_logic;
signal APBmslave4_PSELx_net_0    : std_logic;
signal APBmslave5_PSELx_net_0    : std_logic;
signal APBmslave6_PSELx_net_0    : std_logic;
signal APBmslave7_PSELx_net_0    : std_logic;
signal APBmslave8_PSELx_net_0    : std_logic;
signal APBmslave9_PSELx_net_0    : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                   : std_logic;
signal VCC_net                   : std_logic;
signal IADDR_const_net_0         : std_logic_vector(31 downto 0);
signal PRDATAS10_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS11_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS12_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS13_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS14_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS15_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS16_const_net_0     : std_logic_vector(31 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net               <= '0';
 VCC_net               <= '1';
 IADDR_const_net_0     <= B"00000000000000000000000000000000";
 PRDATAS10_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS11_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS12_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS13_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS14_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS15_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS16_const_net_0 <= B"00000000000000000000000000000000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 APB3mmaster_PRDATA_net_0  <= APB3mmaster_PRDATA;
 PRDATA(31 downto 0)       <= APB3mmaster_PRDATA_net_0;
 APB3mmaster_PREADY_net_0  <= APB3mmaster_PREADY;
 PREADY                    <= APB3mmaster_PREADY_net_0;
 APB3mmaster_PSLVERR_net_0 <= APB3mmaster_PSLVERR;
 PSLVERR                   <= APB3mmaster_PSLVERR_net_0;
 APBmslave0_PADDR_net_0    <= APBmslave0_PADDR;
 PADDRS(31 downto 0)       <= APBmslave0_PADDR_net_0;
 APBmslave0_PSELx_net_0    <= APBmslave0_PSELx;
 PSELS0                    <= APBmslave0_PSELx_net_0;
 APBmslave0_PENABLE_net_0  <= APBmslave0_PENABLE;
 PENABLES                  <= APBmslave0_PENABLE_net_0;
 APBmslave0_PWRITE_net_0   <= APBmslave0_PWRITE;
 PWRITES                   <= APBmslave0_PWRITE_net_0;
 APBmslave0_PWDATA_net_0   <= APBmslave0_PWDATA;
 PWDATAS(31 downto 0)      <= APBmslave0_PWDATA_net_0;
 APBmslave1_PSELx_net_0    <= APBmslave1_PSELx;
 PSELS1                    <= APBmslave1_PSELx_net_0;
 APBmslave2_PSELx_net_0    <= APBmslave2_PSELx;
 PSELS2                    <= APBmslave2_PSELx_net_0;
 APBmslave3_PSELx_net_0    <= APBmslave3_PSELx;
 PSELS3                    <= APBmslave3_PSELx_net_0;
 APBmslave4_PSELx_net_0    <= APBmslave4_PSELx;
 PSELS4                    <= APBmslave4_PSELx_net_0;
 APBmslave5_PSELx_net_0    <= APBmslave5_PSELx;
 PSELS5                    <= APBmslave5_PSELx_net_0;
 APBmslave6_PSELx_net_0    <= APBmslave6_PSELx;
 PSELS6                    <= APBmslave6_PSELx_net_0;
 APBmslave7_PSELx_net_0    <= APBmslave7_PSELx;
 PSELS7                    <= APBmslave7_PSELx_net_0;
 APBmslave8_PSELx_net_0    <= APBmslave8_PSELx;
 PSELS8                    <= APBmslave8_PSELx_net_0;
 APBmslave9_PSELx_net_0    <= APBmslave9_PSELx;
 PSELS9                    <= APBmslave9_PSELx_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- APB3_0   -   Actel:DirectCore:CoreAPB3:4.2.100
APB3_0 : entity COREAPB3_LIB.CoreAPB3
    generic map( 
        APB_DWIDTH      => ( 32 ),
        APBSLOT0ENABLE  => ( 1 ),
        APBSLOT1ENABLE  => ( 1 ),
        APBSLOT2ENABLE  => ( 1 ),
        APBSLOT3ENABLE  => ( 1 ),
        APBSLOT4ENABLE  => ( 1 ),
        APBSLOT5ENABLE  => ( 1 ),
        APBSLOT6ENABLE  => ( 1 ),
        APBSLOT7ENABLE  => ( 1 ),
        APBSLOT8ENABLE  => ( 1 ),
        APBSLOT9ENABLE  => ( 1 ),
        APBSLOT10ENABLE => ( 0 ),
        APBSLOT11ENABLE => ( 0 ),
        APBSLOT12ENABLE => ( 0 ),
        APBSLOT13ENABLE => ( 0 ),
        APBSLOT14ENABLE => ( 0 ),
        APBSLOT15ENABLE => ( 0 ),
        FAMILY          => ( 19 ),
        IADDR_OPTION    => ( 0 ),
        MADDR_BITS      => ( 16 ),
        SC_0            => ( 0 ),
        SC_1            => ( 0 ),
        SC_2            => ( 0 ),
        SC_3            => ( 0 ),
        SC_4            => ( 0 ),
        SC_5            => ( 0 ),
        SC_6            => ( 0 ),
        SC_7            => ( 0 ),
        SC_8            => ( 0 ),
        SC_9            => ( 0 ),
        SC_10           => ( 0 ),
        SC_11           => ( 0 ),
        SC_12           => ( 0 ),
        SC_13           => ( 0 ),
        SC_14           => ( 0 ),
        SC_15           => ( 0 ),
        UPR_NIBBLE_POSN => ( 6 )
        )
    port map( 
        -- Inputs
        PRESETN    => GND_net, -- tied to '0' from definition
        PCLK       => GND_net, -- tied to '0' from definition
        PADDR      => PADDR,
        PWRITE     => PWRITE,
        PENABLE    => PENABLE,
        PWDATA     => PWDATA,
        PSEL       => PSEL,
        PRDATAS0   => PRDATAS0,
        PREADYS0   => PREADYS0,
        PSLVERRS0  => PSLVERRS0,
        PRDATAS1   => PRDATAS1,
        PREADYS1   => PREADYS1,
        PSLVERRS1  => PSLVERRS1,
        PRDATAS2   => PRDATAS2,
        PREADYS2   => PREADYS2,
        PSLVERRS2  => PSLVERRS2,
        PRDATAS3   => PRDATAS3,
        PREADYS3   => PREADYS3,
        PSLVERRS3  => PSLVERRS3,
        PRDATAS4   => PRDATAS4,
        PREADYS4   => PREADYS4,
        PSLVERRS4  => PSLVERRS4,
        PRDATAS5   => PRDATAS5,
        PREADYS5   => PREADYS5,
        PSLVERRS5  => PSLVERRS5,
        PRDATAS6   => PRDATAS6,
        PREADYS6   => PREADYS6,
        PSLVERRS6  => PSLVERRS6,
        PRDATAS7   => PRDATAS7,
        PREADYS7   => PREADYS7,
        PSLVERRS7  => PSLVERRS7,
        PRDATAS8   => PRDATAS8,
        PREADYS8   => PREADYS8,
        PSLVERRS8  => PSLVERRS8,
        PRDATAS9   => PRDATAS9,
        PREADYS9   => PREADYS9,
        PSLVERRS9  => PSLVERRS9,
        PRDATAS10  => PRDATAS10_const_net_0, -- tied to X"0" from definition
        PREADYS10  => VCC_net, -- tied to '1' from definition
        PSLVERRS10 => GND_net, -- tied to '0' from definition
        PRDATAS11  => PRDATAS11_const_net_0, -- tied to X"0" from definition
        PREADYS11  => VCC_net, -- tied to '1' from definition
        PSLVERRS11 => GND_net, -- tied to '0' from definition
        PRDATAS12  => PRDATAS12_const_net_0, -- tied to X"0" from definition
        PREADYS12  => VCC_net, -- tied to '1' from definition
        PSLVERRS12 => GND_net, -- tied to '0' from definition
        PRDATAS13  => PRDATAS13_const_net_0, -- tied to X"0" from definition
        PREADYS13  => VCC_net, -- tied to '1' from definition
        PSLVERRS13 => GND_net, -- tied to '0' from definition
        PRDATAS14  => PRDATAS14_const_net_0, -- tied to X"0" from definition
        PREADYS14  => VCC_net, -- tied to '1' from definition
        PSLVERRS14 => GND_net, -- tied to '0' from definition
        PRDATAS15  => PRDATAS15_const_net_0, -- tied to X"0" from definition
        PREADYS15  => VCC_net, -- tied to '1' from definition
        PSLVERRS15 => GND_net, -- tied to '0' from definition
        PRDATAS16  => PRDATAS16_const_net_0, -- tied to X"0" from definition
        PREADYS16  => VCC_net, -- tied to '1' from definition
        PSLVERRS16 => GND_net, -- tied to '0' from definition
        IADDR      => IADDR_const_net_0, -- tied to X"0" from definition
        -- Outputs
        PRDATA     => APB3mmaster_PRDATA,
        PREADY     => APB3mmaster_PREADY,
        PSLVERR    => APB3mmaster_PSLVERR,
        PADDRS     => APBmslave0_PADDR,
        PWRITES    => APBmslave0_PWRITE,
        PENABLES   => APBmslave0_PENABLE,
        PWDATAS    => APBmslave0_PWDATA,
        PSELS0     => APBmslave0_PSELx,
        PSELS1     => APBmslave1_PSELx,
        PSELS2     => APBmslave2_PSELx,
        PSELS3     => APBmslave3_PSELx,
        PSELS4     => APBmslave4_PSELx,
        PSELS5     => APBmslave5_PSELx,
        PSELS6     => APBmslave6_PSELx,
        PSELS7     => APBmslave7_PSELx,
        PSELS8     => APBmslave8_PSELx,
        PSELS9     => APBmslave9_PSELx,
        PSELS10    => OPEN,
        PSELS11    => OPEN,
        PSELS12    => OPEN,
        PSELS13    => OPEN,
        PSELS14    => OPEN,
        PSELS15    => OPEN,
        PSELS16    => OPEN 
        );

end RTL;
