#JTAG_tck_constraints
create_clock -name {SWCLKTCK} -period 33.33 -waveform {0 16.665 } [ get_ports { SWCLKTCK } ]
#set_clock_groups -name {jtagclk} -asynchronous -group [ get_clocks {SWCLKTCK} ]

set_clock_groups -name {slowclk} -asynchronous -group [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT0 } ] 
#set_clock_groups -name {fastreadclk} -asynchronous -group [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT3 } ]  
set_clock_groups -name {serdes0_0} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE0/RX_CLK_R   DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_groups -name {serdes1_0} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE0/RX_CLK_R   DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_groups -name {serdes0_1} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE1/RX_CLK_R   DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE1/TX_CLK_R } ]
set_clock_groups -name {serdes1_1} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE1/RX_CLK_R   DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE1/TX_CLK_R } ]

# to limit DDR routing time
set_false_path -from [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT2 } ] -to [ get_clocks { DDRInterface_0/DDR3_Cntrl_0/CCC_0/pll_inst_0/OUT1 } ]
set_false_path -from [ get_clocks { DDRInterface_0/DDR3_Cntrl_0/CCC_0/pll_inst_0/OUT1 } ] -to [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT2 } ]

#TIP: Use an escape character '\' at the END of the line (with no spaces) to be able to write the command on multiple lines (for readability)
## original clock groups
#set_clock_groups -name {asyn_noxcvr} -asynchronous -group [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT0   CCC_0/ROC_CCC_0/pll_inst_0/OUT2 } ] \
#-group [ get_clocks { TOP_SERDES_0/ALGO_CLK_PLL_1/ALGO_CLK_PLL_0_0/pll_inst_0/OUT1   PF_OSC_C0_0/PF_OSC_C0_0/I_OSC_160/CLK } ] \
#-group [ get_clocks { TOP_SERDES_0/ALGO_CLK_PLL_1/ALGO_CLK_PLL_0_0/pll_inst_0/OUT0   TrackerCCC_0/TrackerCCC_0/pll_inst_0/OUT0 } ]
#
## 02/02/2021 MT changed
set_clock_groups -name {asyn_noxcvr} -asynchronous -group [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT0   CCC_0/ROC_CCC_0/pll_inst_0/OUT2  CCC_0/ROC_CCC_0/pll_inst_0/OUT3 } ]\
-group [ get_clocks { TOP_SERDES_0/ALGO_CLK_PLL_1/ALGO_CLK_PLL_0_0/pll_inst_0/OUT1   PF_OSC_C0_0/PF_OSC_C0_0/I_OSC_160/CLK  PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/Y_DIV } ]\
-group [ get_clocks { TrackerCCC_0/TrackerCCC_0/pll_inst_0/OUT0 } ]

set_clock_groups -name {asyn_xcvr} -asynchronous -group [ get_clocks { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/RX_CLK_R   TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/TX_CLK_R } ]

set_false_path -from [ get_pins { SLOWCONTROLS_0/Registers_0/enable_fiber_clock/CLK SLOWCONTROLS_0/Registers_0/enable_fiber_marker/CLK } ]
set_false_path -from [ get_pins { TOP_SERDES_0/ForwardDetector_0/fifo_rst/CLK } ]

# 02/02/2021 MT added
set_false_path -to [ get_pins { TOP_SERDES_0/DracMonitor_0/mem_read_cnt[*]/D } ]
set_false_path -to [ get_pins { TOP_SERDES_0/DracMonitor_0/mem_write_cnt[*]/D } ]
set_false_path -to [ get_pins { TOP_SERDES_0/DracMonitor_0/ddr_full/D } ]
set_false_path -to [ get_pins { TOP_SERDES_0/DracMonitor_0/tempfifo_e[*]/D } ]
set_false_path -to [ get_pins { DDRInterface_0/dvl_generator_0/data_valid/*} ]
set_false_path -from [ get_pins { DDRInterface_0/MEMFIFO_0/MEMFIFO_0/L31.U_corefifo_async/wptr_gray[*]/CLK } ] -to [ get_pins { DDRInterface_0/MEMFIFO_0/MEMFIFO_0/L31.U_corefifo_async/Wr_corefifo_NstagesSync/shift_array_0[*]/D } ]
set_false_path -from [ get_pins { DDRInterface_0/TEMPFIFO_0/TEMPFIFO_0/L31.U_corefifo_async/rptr_gray_fwft[*]/CLK } ] -to [ get_pins { DDRInterface_0/TEMPFIFO_0/TEMPFIFO_0/L31.U_corefifo_async/Rd_NstagesSync_fwft/shift_array_0[*]/D } ]