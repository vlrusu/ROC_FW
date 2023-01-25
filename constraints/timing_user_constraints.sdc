# Adding Clock Groups since XCVR RX_CLK and CCC OUT clock are independent to each other
set_clock_groups -name {DTCLane0Ref} -asynchronous \
    -group [ get_clocks { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/RX_CLK_R } ] \
    -group [ get_clocks { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/TX_CLK_R } ] \
    -group [ get_clocks { ROCtoDTC_SERDES_CLK_P } ]

set_clock_groups -name {CalLane0Ref} -asynchronous \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ] \
    -group [ get_clocks { ROCtoHV_SERDES_CLK0_P } ]
set_clock_groups -name {CalLane1Ref} -asynchronous \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ] \
    -group [ get_clocks { ROCtoHV_SERDES_CLK0_P } ]
set_clock_groups -name {HVLane0Ref} -asynchronous \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ] \
    -group [ get_clocks { ROCtoCAL_SERDES_CLK0_P } ]
set_clock_groups -name {HVLane1Ref} -asynchronous \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ] \
    -group [ get_clocks { ROCtoCAL_SERDES_CLK0_P } ]
    
set_clock_groups -name {asyn2} -asynchronous \
    -group [ get_clocks { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT0 } ] \
    -group [ get_clocks { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT1 } ] \
    -group [ get_clocks { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT2 } ] \
    -group [ get_clocks { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT3 } ] \
    -group [ get_clocks { PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ] \
    -group [ get_clocks { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT1 } ] \
    -group [ get_clocks { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/RX_CLK_R } ] \
    -group [ get_clocks { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/TX_CLK_R } ]  \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ] \
    -group [ get_clocks { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ] \
    -group [ get_clocks { PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/Y_DIV } ] \
    -group [ get_clocks { PF_OSC_0_0/PF_OSC_0_0/I_OSC_160/CLK } ]

# TX_CLK and RX_CLK on Regionals clock uncertainty constraint
set_clock_uncertainty -setup 0.150 [ get_pins { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_uncertainty -setup 0.175 [ get_pins { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/RX_CLK_R } ]
set_clock_uncertainty -setup 0.150 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_uncertainty -setup 0.175 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ]
set_clock_uncertainty -setup 0.150 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ]
set_clock_uncertainty -setup 0.175 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ]
set_clock_uncertainty -setup 0.150 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_uncertainty -setup 0.175 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ]
set_clock_uncertainty -setup 0.150 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ]
set_clock_uncertainty -setup 0.175 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ]


#JTAG_tck_constraints
#create_clock -name {TCK} -period 33.33 -waveform {0 16.665 } [ get_ports { TCK } ]


# to limit DDR routing time
#set_false_path -from [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT2 } ] -to [ get_clocks { NewDDRInterface_0/DDR3_Cntrl_0/CCC_0/pll_inst_0/OUT1 } ]
#set_false_path -from [ get_clocks { NewDDRInterface_0/DDR3_Cntrl_0/CCC_0/pll_inst_0/OUT1 } ] -to [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT2 }


#set_false_path -from [ get_pins { SLOWCONTROLS_0/Registers_0/enable_fiber_clock/CLK SLOWCONTROLS_0/Registers_0/enable_fiber_marker/CLK } ]
#set_false_path -from [ get_pins { TOP_SERDES_0/ForwardDetector_0/fifo_rst/CLK } ]