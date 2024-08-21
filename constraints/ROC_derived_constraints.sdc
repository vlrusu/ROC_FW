# Microsemi Corp.
# Date: 2024-Jul-29 12:07:45
# This file was generated based on the following SDC source files:
#   C:/Users/tecchio/Desktop/ROC_new/component/work/PF_TX_PLL_0/PF_TX_PLL_0_0/PF_TX_PLL_0_PF_TX_PLL_0_0_PF_TX_PLL.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/PF_XCVR_0/I_XCVR/PF_XCVR_0_I_XCVR_PF_XCVR.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/AXI4_Interconnect/AXI4_Interconnect_0/AXI4_Interconnect.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/DDR4_Cntrl/DDR4_Cntrl.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/DDR4_Cntrl/CCC_0/DDR4_Cntrl_CCC_0_PF_CCC.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/DDR4_Cntrl/DLL_0/DDR4_Cntrl_DLL_0_PF_CCC.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/PF_CCC_111/PF_CCC_111_0/PF_CCC_111_PF_CCC_111_0_PF_CCC.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/PF_CCC_C0/PF_CCC_C0_0/PF_CCC_C0_PF_CCC_C0_0_PF_CCC.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/PF_CCC_C1/PF_CCC_C1_0/PF_CCC_C1_PF_CCC_C1_0_PF_CCC.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/PF_CLK_DIV_C0/PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_PF_CLK_DIV_C0_0_PF_CLK_DIV.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/CorePCS_C0/CorePCS_C0_0/CorePCS_C0.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/PF_XCVR_ERM_C0/I_XCVR/PF_XCVR_ERM_C0_I_XCVR_PF_XCVR.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/XCVR_PLL_0/XCVR_PLL_0_0/XCVR_PLL_0_XCVR_PLL_0_0_PF_TX_PLL.sdc
#   C:/Microchip/Libero_SoC_v2022.3/Designer/data/aPA5M/cores/constraints/osc_rc160mhz.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/ROCFIFO/ROCFIFO_0/ROCFIFO_ROCFIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/ROCFIFO_SIM/ROCFIFO_SIM_0/ROCFIFO_SIM_ROCFIFO_SIM_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/DigiReaderFIFO/DigiReaderFIFO_0/DigiReaderFIFO_DigiReaderFIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/DREQ_FIFO/DREQ_FIFO_0/DREQ_FIFO_DREQ_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/EW_FIFO/EW_FIFO_0/EW_FIFO_EW_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/EVT_FIFO/EVT_FIFO_0/EVT_FIFO_EVT_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/SIZE_FIFO/SIZE_FIFO_0/SIZE_FIFO_SIZE_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/CNT_FIFO/CNT_FIFO_0/CNT_FIFO_CNT_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/EWTAG_FIFO/EWTAG_FIFO_0/EWTAG_FIFO_EWTAG_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/SPILLTAG_FIFO/SPILLTAG_FIFO_0/SPILLTAG_FIFO_SPILLTAG_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/LARGE_TAG_FIFO/LARGE_TAG_FIFO_0/LARGE_TAG_FIFO_LARGE_TAG_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/SIM_ROC_FIFO/SIM_ROC_FIFO_0/SIM_ROC_FIFO_SIM_ROC_FIFO_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/CMD_TO_PROC_BUFFER/CMD_TO_PROC_BUFFER_0/CMD_TO_PROC_BUFFER_CMD_TO_PROC_BUFFER_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/DCS_RX_BUFFER/DCS_RX_BUFFER_0/DCS_RX_BUFFER_DCS_RX_BUFFER_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/DCS_TX_BUFFER/DCS_TX_BUFFER_0/DCS_TX_BUFFER_DCS_TX_BUFFER_0_COREFIFO.sdc
#   C:/Users/tecchio/Desktop/ROC_new/component/work/RxPacketFIFO/RxPacketFIFO_0/RxPacketFIFO_RxPacketFIFO_0_COREFIFO.sdc
# *** Any modifications to this file will be lost if derived constraints is re-run. ***
#

create_clock -name {ROCtoHV_SERDES_CLK0_P} -period 10 [ get_ports { ROCtoHV_SERDES_CLK0_P } ]
create_clock -name {ROCtoCAL_SERDES_CLK0_P} -period 10 [ get_ports { ROCtoCAL_SERDES_CLK0_P } ]
create_clock -name {DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ]
create_clock -name {DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ]
create_clock -name {DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ]
create_clock -name {DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_0/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ]
create_clock -name {DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ]
create_clock -name {DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ]
create_clock -name {DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/TX_CLK_R } ]
create_clock -name {DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R} -period 6.66667 [ get_pins { DigiInterface_0/DigiLink_1/PF_XCVR_0_0/I_XCVR/LANE1/RX_CLK_R } ]
create_clock -name {ROC_CLK_P} -period 20 [ get_ports { ROC_CLK_P } ]
create_clock -name {ROCtoDTC_SERDES_CLK_P} -period 10 [ get_ports { ROCtoDTC_SERDES_CLK_P } ]
create_clock -name {TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/TX_CLK_R} -period 5 [ get_pins { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/TX_CLK_R } ]
create_clock -name {TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/RX_CLK_R} -period 5 [ get_pins { TOP_SERDES_0/XCVR_Block_0/XCVR_IF_0/I_XCVR/LANE0/RX_CLK_R } ]
create_clock -name {PF_OSC_0_0/PF_OSC_0_0/I_OSC_160/CLK} -period 6.25 [ get_pins { PF_OSC_0_0/PF_OSC_0_0/I_OSC_160/CLK } ]
create_generated_clock -name {NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT0} -multiply_by 6 -source [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT1} -multiply_by 3 -divide_by 2 -source [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT1 } ]
create_generated_clock -name {NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT2} -multiply_by 6 -source [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT2 } ]
create_generated_clock -name {NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT3} -multiply_by 6 -source [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/OUT3 } ]
create_generated_clock -name {PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/OUT0} -multiply_by 4 -source [ get_pins { PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/OUT1} -multiply_by 20 -divide_by 9 -source [ get_pins { PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/OUT1 } ]
create_generated_clock -name {PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/OUT2} -multiply_by 4 -divide_by 5 -source [ get_pins { PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_111_0/PF_CCC_111_0/pll_inst_0/OUT2 } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT0} -multiply_by 4 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT1} -multiply_by 3 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT1 } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT2} -multiply_by 8 -divide_by 5 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT2 } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT3} -divide_by 1 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT3 } ]
create_generated_clock -name {PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/OUT0} -divide_by 1 -source [ get_pins { PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/Y_DIV} -divide_by 4 -source [ get_pins { PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/A } ] [ get_pins { PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/Y_DIV } ]
set_false_path -through [ get_nets { NewDDRInterface_0/AXI4_Interconnect_0/ARESETN* } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_IOD_*/ARST_N } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_*_CTRL/I_LANECTRL/HS_IO_CLK_PAUSE } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANECTRL_ADDR_CMD_0/I_LANECTRL*/HS_IO_CLK_PAUSE } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_IOD_*/RX_SYNC_RST* } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_IOD_*/DELAY_LINE_MOVE } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_IOD_*/DELAY_LINE_OUT_OF_RANGE } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DDR_READ } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/RESET } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DELAY_LINE_DIRECTION } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DELAY_LINE_MOVE } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DELAY_LINE_LOAD NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DELAY_LINE_SEL } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/SWITCH } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/READ_CLK_SEL[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[0] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[1] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[3] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[4] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[5] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[6] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_0_CTRL/I_LANECTRL/DLL_CODE[7] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DDR_READ } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/RESET } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DELAY_LINE_DIRECTION } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DELAY_LINE_MOVE } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DELAY_LINE_LOAD NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DELAY_LINE_SEL } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/SWITCH } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/READ_CLK_SEL[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[0] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[1] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[3] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[4] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[5] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[6] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_1_CTRL/I_LANECTRL/DLL_CODE[7] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DDR_READ } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/RESET } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DELAY_LINE_DIRECTION } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DELAY_LINE_MOVE } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DELAY_LINE_LOAD NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DELAY_LINE_SEL } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/SWITCH } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/READ_CLK_SEL[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[0] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[1] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[3] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[4] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[5] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[6] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_2_CTRL/I_LANECTRL/DLL_CODE[7] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DDR_READ } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/RESET } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DELAY_LINE_DIRECTION } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DELAY_LINE_MOVE } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DELAY_LINE_LOAD NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DELAY_LINE_SEL } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/SWITCH } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/READ_CLK_SEL[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[0] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[1] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[2] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[3] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[4] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[5] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[6] } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/LANE_3_CTRL/I_LANECTRL/DLL_CODE[7] } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_*FEEDBACK*/Y } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/OB_DIFF_CK0/Y } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/OB_A_12/Y } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_TRIBUFF_*/D } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_TRIBUFF_*/E } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_BIBUF*/D } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_BIBUF*/E } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_BIBUF*/Y } ]
set_false_path -through [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/*/I_BIBUF_DIFF_DQS_*/YN } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/PHASE_OUT0_SEL } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/PHASE_OUT2_SEL } ]
set_false_path -to [ get_pins { NewDDRInterface_0/DDR4_Cntrl_0/CCC_0/pll_inst_0/PHASE_OUT3_SEL } ]
set_false_path -through [ get_nets { TOP_SERDES_0/XCVR_Block_0/Core_PCS_0/*/cpcs_rst_sync*/RESET_N* } ]
set_false_path -through [ get_nets { TOP_SERDES_0/XCVR_Block_0/Core_PCS_0/*/cpcs_rst_sync*/WA_RSTn* } ]
set_false_path -through [ get_nets { TOP_SERDES_0/XCVR_Block_0/Core_PCS_0/*/cpcs_rst_sync*/EPCS_RxVAL* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_0/ROCFIFO_0/ROCFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_1/ROCFIFO_0/ROCFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_0/ROCFIFO_1/ROCFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_1/ROCFIFO_1/ROCFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_Sim_0/ROCFIFO_SIM_0/ROCFIFO_SIM_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_Sim_0/ROCFIFO_SIM_1/ROCFIFO_SIM_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_Sim_0/ROCFIFO_SIM_2/ROCFIFO_SIM_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiLink_Sim_0/ROCFIFO_SIM_3/ROCFIFO_SIM_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { DigiInterface_0/DigiReaderFIFO_0/DigiReaderFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/DREQ_FIFO_1/DREQ_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/ew_fifo0/EW_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/ew_fifo1/EW_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/evt_fifo0/EVT_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/evt_fifo1/EVT_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/size_fifo2/SIZE_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/size_fifo1/SIZE_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/size_fifo0/SIZE_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/cnt_fifo1/CNT_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/cnt_fifo0/CNT_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/EW_FIFO_controller_0/ewtag_fifo0/EWTAG_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/ewtag_cntrl_0/ewtag_fifo_offset/EWTAG_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/ewtag_cntrl_0/dreq_tag_fifo/EWTAG_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/ewtag_cntrl_0/spilltag_fifo0/SPILLTAG_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/ewtag_cntrl_0/hb_tag_fifo/LARGE_TAG_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { NewDDRInterface_0/pattern_FIFO_filler_0/SIM_ROC_FIFO_0/SIM_ROC_FIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { SLOWCONTROLS_0/CMD_TO_PROC_BUFFER_0/CMD_TO_PROC_BUFFER_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { SLOWCONTROLS_0/DCS_TX_BUFFER_0/DCS_TX_BUFFER_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { TOP_SERDES_0/RxPacketFIFO_0/RxPacketFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { TOP_SERDES_0/RxPacketFIFO_1/RxPacketFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { TOP_SERDES_0/RxPacketFIFO_2/RxPacketFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_false_path -to [ get_cells { TOP_SERDES_0/RxPacketFIFO_3/RxPacketFIFO_0/genblk*.U_corefifo_async/*/shift_reg* } ]
set_multicycle_path -setup_only 2 -from [ get_cells { NewDDRInterface_0/DDR4_Cntrl_0/DDRPHY_BLK_0/IOD_TRAINING_0/COREDDR_TIP_INT_U/TIP_CTRL_BLK/u_write_callibrator/select* } ]
