#JTAG_tck_constraints
create_clock -name {SWCLKTCK} -period 33.33 -waveform {0 16.665 } [ get_ports { SWCLKTCK } ]
#create_clock -name {TCLK_40REF} -period 25 -waveform {0 15 } [ get_nets { TOP_SERDES_0/clk_40_net } ]
#set_false_path -from [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT2 } ] -to [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT1 } ]
#set_false_path -from [ get_clocks { DDRInterface_0/PF_DDR3_Cntrl_0/CCC_0/pll_inst_0/OUT1 } ] -to [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT2 } ]
#set_clock_groups  -asynchronous -group [ get_clocks { CCC_0/CCC_0/pll_inst_0/OUT0 } ] -group [ get_clocks { CCC_0/CCC_0/pll_inst_0/OUT2 } ] -group [ get_clocks { TOP_SERDES_0/ALGO_CLK_PLL_1/ALGO_CLK_PLL_0_0/pll_inst_0/OUT0 } ] -group [ get_clocks { osc_rc160mhz } ] -group [ get_clocks { DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/RX_CLK_R DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/TX_CLK_R } ] -group [ get_clocks { RX_CLK_R } ] -group [ get_clocks { TX_CLK_R } ] -group [ get_clocks { DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/RX_CLK_R DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_groups  -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/RX_CLK_R DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/TX_CLK_R } ] -group [ get_clocks { DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/RX_CLK_R DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/TX_CLK_R } ] -group [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT0 } ]
#-group [ get_clocks { TOP_SERDES_0/Ctrl_clk_0/Ctrl_clk_0/I_CD/Y_DIV } ]
set_clock_groups -name {trackerclk} -asynchronous -group [ get_clocks { TrackerCCC_0/TrackerCCC_0/pll_inst_0/OUT0 } ]
