----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:21:02 2023
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
-- pattern_FIFO_filler entity declaration
----------------------------------------------------------------------
entity pattern_FIFO_filler is
    -- Port list
    port(
        -- Inputs
        axi_start_on_serdesclk : in  std_logic;
        ddr_done               : in  std_logic;
        ewtag_in               : in  std_logic_vector(19 downto 0);
        pattern_init           : in  std_logic;
        resetn_serdesclk       : in  std_logic;
        serdesclk              : in  std_logic;
        -- Outputs
        curr_ewfifo_wr         : out std_logic;
        ew_data                : out std_logic_vector(31 downto 0);
        ew_done                : out std_logic;
        ew_fifo_we             : out std_logic;
        ew_ovfl                : out std_logic;
        ew_size                : out std_logic_vector(9 downto 0);
        ew_tag                 : out std_logic_vector(19 downto 0)
        );
end pattern_FIFO_filler;
----------------------------------------------------------------------
-- pattern_FIFO_filler architecture body
----------------------------------------------------------------------
architecture RTL of pattern_FIFO_filler is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- clus_pattern_cntrl
component clus_pattern_cntrl
    -- Port list
    port(
        -- Inputs
        ddr_done         : in  std_logic;
        ewtag_in         : in  std_logic_vector(19 downto 0);
        hit_in           : in  std_logic_vector(9 downto 0);
        pattern_init     : in  std_logic;
        serdesclk        : in  std_logic;
        serdesclk_resetn : in  std_logic;
        -- Outputs
        hit_error        : out std_logic;
        hit_over         : out std_logic;
        hit_rdaddr       : out std_logic_vector(5 downto 0);
        hit_re           : out std_logic;
        hit_under        : out std_logic;
        pattern_data0    : out std_logic_vector(31 downto 0);
        pattern_we0      : out std_logic
        );
end component;
-- hit_ram
component hit_ram
    -- Port list
    port(
        -- Inputs
        address : in  std_logic_vector(5 downto 0);
        clock   : in  std_logic;
        datain  : in  std_logic_vector(11 downto 0);
        re      : in  std_logic;
        we      : in  std_logic;
        -- Outputs
        dataout : out std_logic_vector(11 downto 0)
        );
end component;
-- rocfifo_cntrl
component rocfifo_cntrl
    -- Port list
    port(
        -- Inputs
        axi_start_on_serdesclk : in  std_logic;
        resetn_serdesclk       : in  std_logic;
        rocfifo0_data          : in  std_logic_vector(31 downto 0);
        rocfifo0_empty         : in  std_logic;
        rocfifo0_full          : in  std_logic;
        rocfifo0_wrcnt         : in  std_logic_vector(16 downto 0);
        serdesclk              : in  std_logic;
        -- Outputs
        curr_ewfifo_wr         : out std_logic;
        ew_data                : out std_logic_vector(31 downto 0);
        ew_done                : out std_logic;
        ew_fifo_we             : out std_logic;
        ew_ovfl                : out std_logic;
        ew_size                : out std_logic_vector(9 downto 0);
        ew_tag                 : out std_logic_vector(19 downto 0);
        rocfifo0_re            : out std_logic
        );
end component;
-- SIM_ROC_FIFO
component SIM_ROC_FIFO
    -- Port list
    port(
        -- Inputs
        DATA     : in  std_logic_vector(31 downto 0);
        RCLOCK   : in  std_logic;
        RE       : in  std_logic;
        RRESET_N : in  std_logic;
        WCLOCK   : in  std_logic;
        WE       : in  std_logic;
        WRESET_N : in  std_logic;
        -- Outputs
        EMPTY    : out std_logic;
        FULL     : out std_logic;
        Q        : out std_logic_vector(31 downto 0);
        WRCNT    : out std_logic_vector(11 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal clus_pattern_cntrl_0_hit_rdaddr    : std_logic_vector(5 downto 0);
signal clus_pattern_cntrl_0_hit_re        : std_logic;
signal clus_pattern_cntrl_0_pattern_data0 : std_logic_vector(31 downto 0);
signal clus_pattern_cntrl_0_pattern_we0   : std_logic;
signal curr_ewfifo_wr_net_0               : std_logic;
signal ew_data_net_0                      : std_logic_vector(31 downto 0);
signal ew_done_net_0                      : std_logic;
signal ew_fifo_we_net_0                   : std_logic;
signal ew_ovfl_net_0                      : std_logic;
signal ew_size_net_0                      : std_logic_vector(9 downto 0);
signal ew_tag_net_0                       : std_logic_vector(19 downto 0);
signal hit_ram_0_dataout9to0              : std_logic_vector(9 downto 0);
signal rocfifo_cntrl_0_rocfifo0_re        : std_logic;
signal SIM_ROC_FIFO_0_EMPTY               : std_logic;
signal SIM_ROC_FIFO_0_FULL                : std_logic;
signal SIM_ROC_FIFO_0_Q                   : std_logic_vector(31 downto 0);
signal SIM_ROC_FIFO_0_WRCNT               : std_logic_vector(11 downto 0);
signal curr_ewfifo_wr_net_1               : std_logic;
signal ew_done_net_1                      : std_logic;
signal ew_fifo_we_net_1                   : std_logic;
signal ew_ovfl_net_1                      : std_logic;
signal ew_data_net_1                      : std_logic_vector(31 downto 0);
signal ew_size_net_1                      : std_logic_vector(9 downto 0);
signal ew_tag_net_1                       : std_logic_vector(19 downto 0);
signal dataout_net_0                      : std_logic_vector(11 downto 0);
signal rocfifo0_wrcnt_net_0               : std_logic_vector(16 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                            : std_logic;
signal datain_const_net_0                 : std_logic_vector(11 downto 0);
signal rocfifo0_wrcnt_const_net_0         : std_logic_vector(16 downto 12);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net                    <= '0';
 datain_const_net_0         <= B"000000000000";
 rocfifo0_wrcnt_const_net_0 <= B"00000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 curr_ewfifo_wr_net_1 <= curr_ewfifo_wr_net_0;
 curr_ewfifo_wr       <= curr_ewfifo_wr_net_1;
 ew_done_net_1        <= ew_done_net_0;
 ew_done              <= ew_done_net_1;
 ew_fifo_we_net_1     <= ew_fifo_we_net_0;
 ew_fifo_we           <= ew_fifo_we_net_1;
 ew_ovfl_net_1        <= ew_ovfl_net_0;
 ew_ovfl              <= ew_ovfl_net_1;
 ew_data_net_1        <= ew_data_net_0;
 ew_data(31 downto 0) <= ew_data_net_1;
 ew_size_net_1        <= ew_size_net_0;
 ew_size(9 downto 0)  <= ew_size_net_1;
 ew_tag_net_1         <= ew_tag_net_0;
 ew_tag(19 downto 0)  <= ew_tag_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 hit_ram_0_dataout9to0 <= dataout_net_0(9 downto 0);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 rocfifo0_wrcnt_net_0 <= ( B"00000" & SIM_ROC_FIFO_0_WRCNT );
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- clus_pattern_cntrl_0
clus_pattern_cntrl_0 : clus_pattern_cntrl
    port map( 
        -- Inputs
        serdesclk        => serdesclk,
        serdesclk_resetn => resetn_serdesclk,
        pattern_init     => pattern_init,
        ddr_done         => ddr_done,
        hit_in           => hit_ram_0_dataout9to0,
        ewtag_in         => ewtag_in,
        -- Outputs
        pattern_we0      => clus_pattern_cntrl_0_pattern_we0,
        pattern_data0    => clus_pattern_cntrl_0_pattern_data0,
        hit_re           => clus_pattern_cntrl_0_hit_re,
        hit_rdaddr       => clus_pattern_cntrl_0_hit_rdaddr,
        hit_over         => OPEN,
        hit_under        => OPEN,
        hit_error        => OPEN 
        );
-- hit_ram_0
hit_ram_0 : hit_ram
    port map( 
        -- Inputs
        clock   => serdesclk,
        we      => GND_net,
        re      => clus_pattern_cntrl_0_hit_re,
        address => clus_pattern_cntrl_0_hit_rdaddr,
        datain  => datain_const_net_0,
        -- Outputs
        dataout => dataout_net_0 
        );
-- rocfifo_cntrl_0
rocfifo_cntrl_0 : rocfifo_cntrl
    port map( 
        -- Inputs
        serdesclk              => serdesclk,
        resetn_serdesclk       => resetn_serdesclk,
        rocfifo0_full          => SIM_ROC_FIFO_0_FULL,
        rocfifo0_data          => SIM_ROC_FIFO_0_Q,
        rocfifo0_empty         => SIM_ROC_FIFO_0_EMPTY,
        rocfifo0_wrcnt         => rocfifo0_wrcnt_net_0,
        axi_start_on_serdesclk => axi_start_on_serdesclk,
        -- Outputs
        rocfifo0_re            => rocfifo_cntrl_0_rocfifo0_re,
        curr_ewfifo_wr         => curr_ewfifo_wr_net_0,
        ew_done                => ew_done_net_0,
        ew_fifo_we             => ew_fifo_we_net_0,
        ew_ovfl                => ew_ovfl_net_0,
        ew_data                => ew_data_net_0,
        ew_size                => ew_size_net_0,
        ew_tag                 => ew_tag_net_0 
        );
-- SIM_ROC_FIFO_0
SIM_ROC_FIFO_0 : SIM_ROC_FIFO
    port map( 
        -- Inputs
        WCLOCK   => serdesclk,
        RCLOCK   => serdesclk,
        WRESET_N => resetn_serdesclk,
        RRESET_N => resetn_serdesclk,
        DATA     => clus_pattern_cntrl_0_pattern_data0,
        WE       => clus_pattern_cntrl_0_pattern_we0,
        RE       => rocfifo_cntrl_0_rocfifo0_re,
        -- Outputs
        Q        => SIM_ROC_FIFO_0_Q,
        FULL     => SIM_ROC_FIFO_0_FULL,
        EMPTY    => SIM_ROC_FIFO_0_EMPTY,
        WRCNT    => SIM_ROC_FIFO_0_WRCNT 
        );

end RTL;
