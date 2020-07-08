# Microsemi Corp.
# Date: 2020-Jul-08 11:44:49
# This file was generated based on the following SDC source files:
#   D:/rbonv/ROC_FW_simple2/ROC/component/work/ROC_CCC/ROC_CCC_0/ROC_CCC_ROC_CCC_0_PF_CCC.sdc
#   D:/rbonv/ROC_FW_simple2/ROC/component/work/TxIF/I_XCVR/TxIF_I_XCVR_PF_XCVR.sdc
#   D:/rbonv/ROC_FW_simple2/ROC/component/work/TxPLL/TxPLL_0/TxPLL_TxPLL_0_PF_TX_PLL.sdc
#   D:/rbonv/ROC_FW_simple2/ROC/component/work/TrackerCCC/TrackerCCC_0/TrackerCCC_TrackerCCC_0_PF_CCC.sdc
#

create_clock -name {ROC_CLK_P} -period 20 [ get_ports { ROC_CLK_P } ]
create_clock -name {DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/TX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/TX_CLK_R } ]
create_clock -name {DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/RX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE0/RX_CLK_R } ]
create_clock -name {DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE1/TX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE1/TX_CLK_R } ]
create_clock -name {DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE1/RX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_0/TxIF_0/I_XCVR/LANE1/RX_CLK_R } ]
create_clock -name {DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/TX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/TX_CLK_R } ]
create_clock -name {DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/RX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE0/RX_CLK_R } ]
create_clock -name {DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE1/TX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE1/TX_CLK_R } ]
create_clock -name {DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE1/RX_CLK_R} -period 6.66667 [ get_pins { DIGIINTERFACE_0/serdes_1/TxIF_0/I_XCVR/LANE1/RX_CLK_R } ]
create_clock -name {SERDES_CAL_CLK_P} -period 10 [ get_ports { SERDES_CAL_CLK_P } ]
create_clock -name {SERDES_HV_CLK_P} -period 10 [ get_ports { SERDES_HV_CLK_P } ]
create_clock -name {CCC_0/ROC_CCC_0/pll_inst_0/OUT0} -period 20 [ get_pins { CCC_0/ROC_CCC_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {CCC_0/ROC_CCC_0/pll_inst_0/OUT1} -divide_by 1 -source [ get_pins { CCC_0/ROC_CCC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { CCC_0/ROC_CCC_0/pll_inst_0/OUT1 } ]
create_generated_clock -name {CCC_0/ROC_CCC_0/pll_inst_0/OUT3} -multiply_by 2 -source [ get_pins { CCC_0/ROC_CCC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { CCC_0/ROC_CCC_0/pll_inst_0/OUT3 } ]
create_generated_clock -name {TrackerCCC_0/TrackerCCC_0/pll_inst_0/OUT0} -multiply_by 4 -divide_by 5 -source [ get_pins { TrackerCCC_0/TrackerCCC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { TrackerCCC_0/TrackerCCC_0/pll_inst_0/OUT0 } ]
