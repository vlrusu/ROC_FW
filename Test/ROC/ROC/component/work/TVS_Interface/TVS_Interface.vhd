----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:22:32 2023
-- Version: 2022.3 2022.3.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- TVS_Interface entity declaration
----------------------------------------------------------------------
entity TVS_Interface is
    -- Port list
    port(
        -- Inputs
        R_ADDR   : in  std_logic_vector(1 downto 0);
        R_CLK    : in  std_logic;
        clk      : in  std_logic;
        resetn_i : in  std_logic;
        -- Outputs
        R_DATA   : out std_logic_vector(15 downto 0)
        );
end TVS_Interface;
----------------------------------------------------------------------
-- TVS_Interface architecture body
----------------------------------------------------------------------
architecture RTL of TVS_Interface is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- PF_TVS_C0
component PF_TVS_C0
    -- Port list
    port(
        -- Inputs
        ENABLE_18V      : in  std_logic;
        ENABLE_1V       : in  std_logic;
        ENABLE_25V      : in  std_logic;
        ENABLE_TEMP     : in  std_logic;
        TEMP_HIGH_CLEAR : in  std_logic;
        TEMP_LOW_CLEAR  : in  std_logic;
        -- Outputs
        ACTIVE          : out std_logic;
        CHANNEL         : out std_logic_vector(1 downto 0);
        TEMP_HIGH       : out std_logic;
        TEMP_LOW        : out std_logic;
        VALID           : out std_logic;
        VALUE           : out std_logic_vector(15 downto 0)
        );
end component;
-- PF_URAM_C0
component PF_URAM_C0
    -- Port list
    port(
        -- Inputs
        R_ADDR : in  std_logic_vector(1 downto 0);
        R_CLK  : in  std_logic;
        W_ADDR : in  std_logic_vector(1 downto 0);
        W_CLK  : in  std_logic;
        W_DATA : in  std_logic_vector(15 downto 0);
        W_EN   : in  std_logic;
        -- Outputs
        R_DATA : out std_logic_vector(15 downto 0)
        );
end component;
-- TVS_Cntrl
component TVS_Cntrl
    -- Port list
    port(
        -- Inputs
        channel_i : in  std_logic_vector(1 downto 0);
        clk       : in  std_logic;
        resetn_i  : in  std_logic;
        valid_i   : in  std_logic;
        value_i   : in  std_logic_vector(15 downto 0);
        -- Outputs
        channel_o : out std_logic_vector(1 downto 0);
        value_o   : out std_logic_vector(15 downto 0);
        w_en_o    : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal PF_TVS_C0_0_CHANNEL   : std_logic_vector(1 downto 0);
signal PF_TVS_C0_0_VALID     : std_logic;
signal PF_TVS_C0_0_VALUE     : std_logic_vector(15 downto 0);
signal R_DATA_net_0          : std_logic_vector(15 downto 0);
signal TVS_Cntrl_0_channel_o : std_logic_vector(1 downto 0);
signal TVS_Cntrl_0_value_o   : std_logic_vector(15 downto 0);
signal TVS_Cntrl_0_w_en_o    : std_logic;
signal R_DATA_net_1          : std_logic_vector(15 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net               : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 R_DATA_net_1        <= R_DATA_net_0;
 R_DATA(15 downto 0) <= R_DATA_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- PF_TVS_C0_0
PF_TVS_C0_0 : PF_TVS_C0
    port map( 
        -- Inputs
        TEMP_HIGH_CLEAR => VCC_net,
        TEMP_LOW_CLEAR  => VCC_net,
        ENABLE_1V       => VCC_net,
        ENABLE_18V      => VCC_net,
        ENABLE_25V      => VCC_net,
        ENABLE_TEMP     => VCC_net,
        -- Outputs
        TEMP_HIGH       => OPEN,
        TEMP_LOW        => OPEN,
        VALUE           => PF_TVS_C0_0_VALUE,
        CHANNEL         => PF_TVS_C0_0_CHANNEL,
        VALID           => PF_TVS_C0_0_VALID,
        ACTIVE          => OPEN 
        );
-- PF_URAM_C0_0
PF_URAM_C0_0 : PF_URAM_C0
    port map( 
        -- Inputs
        W_DATA => TVS_Cntrl_0_value_o,
        R_ADDR => R_ADDR,
        W_ADDR => TVS_Cntrl_0_channel_o,
        W_EN   => TVS_Cntrl_0_w_en_o,
        R_CLK  => R_CLK,
        W_CLK  => clk,
        -- Outputs
        R_DATA => R_DATA_net_0 
        );
-- TVS_Cntrl_0
TVS_Cntrl_0 : TVS_Cntrl
    port map( 
        -- Inputs
        clk       => clk,
        resetn_i  => resetn_i,
        valid_i   => PF_TVS_C0_0_VALID,
        value_i   => PF_TVS_C0_0_VALUE,
        channel_i => PF_TVS_C0_0_CHANNEL,
        -- Outputs
        value_o   => TVS_Cntrl_0_value_o,
        channel_o => TVS_Cntrl_0_channel_o,
        w_en_o    => TVS_Cntrl_0_w_en_o 
        );

end RTL;
