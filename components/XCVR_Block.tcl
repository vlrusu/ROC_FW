# Creating SmartDesign XCVR_Block
set sd_name {XCVR_Block}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {XCVR_LOCK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_XCVR_ERRORS} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_VAL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TX_CLK_STABLE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CLK200} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SIM_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALGO_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALGO_RESET} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {clk200_RSTN} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {B_CERR} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RD_ERR} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RX_K_CHAR} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CODE_ERR_N} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RX_DATA} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {INVALID_K} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {TX_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {TX_K_CHAR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DISP_SEL} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {FORCE_DISP} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {XCVR_LOSS_COUNTER} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ALGO_ADDR} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ALGO_WDATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ALGO_RDATA} -port_direction {INOUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_K_CHAR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {TX_DATA_OUT} -port_direction {OUT} -port_range {[31:0]}

# Add Core_PCS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CorePCS_C0} -instance_name {Core_PCS_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_PWRDN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_TXOOB}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_TxVAL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_RxERR}



# Add INV_20bit_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {INV_20bit} -hdl_file {hdl\INV_20bit.vhd} -instance_name {INV_20bit_0}



# Add mux_rxout_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {mux_rxout} -hdl_file {hdl\mux_rxout.v} -instance_name {mux_rxout_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {mux_rxout_0:SIM_ALIGNED} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {mux_rxout_0:SIM_RX_VALID} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {mux_rxout_0:SIM_INVALID} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {mux_rxout_0:SIM_CODE_ERR_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {mux_rxout_0:SIM_B_CERR} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {mux_rxout_0:SIM_RD_ERR} -value {GND}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add MX2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_1}



# Add MX2_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_2}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MX2_2:B} -value {VCC}



# Add MX2_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_3}



# Add MX2_4 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_4}



# Add ReplyPktDecoder_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {ReplyPktDecoder} -hdl_file {hdl\ReplyPktDecoder.v} -instance_name {ReplyPktDecoder_0}



# Add XCVR_Clk_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_REF_CLK_C0} -instance_name {XCVR_Clk_0}



# Add XCVR_Controller_Init instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C1} -instance_name {XCVR_Controller_Init}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_Controller_Init:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_Controller_Init:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_Controller_Init:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_Controller_Init:PLL_LOCK} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_Controller_Init:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_Controller_Init:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_Controller_Init:FPGA_POR_N} -value {VCC}



# Add XCVR_IF_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_ERM_C0} -instance_name {XCVR_IF_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_IF_0:LANE0_RX_SLIP} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_IF_0:LANE0_RX_BYPASS_DATA}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_IF_0:LANE0_LOS} -value {GND}



# Add XCVR_PLL_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_PLL_0} -instance_name {XCVR_PLL_0}



# Add XCVR_Reset_Controller_0_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {XCVR_Reset_Controller_0} -hdl_file {hdl\XCVR_Reset_Controller.vhd} -instance_name {XCVR_Reset_Controller_0_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_CLK" "ALGO_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_RESET" "ALGO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNED" "mux_rxout_0:ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLK200" "MX2_0:B" "MX2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clk200_RSTN" "MX2_4:B" "MX2_3:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALIGNED" "Core_PCS_0:ALIGNED" "mux_rxout_0:DTC_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_ARST_N" "XCVR_IF_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:SLOW_CLK" "CTRL_CLK" "XCVR_Controller_Init:CLK" "XCVR_IF_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INIT_DONE" "XCVR_Controller_Init:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RX_CLK_R" "mux_rxout_0:RX_CLK" "MX2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RX_VAL" "mux_rxout_0:RX_VALID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "XCVR_IF_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "XCVR_IF_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TX_CLK_R" "MX2_1:Y" "ReplyPktDecoder_0:TX_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:TX_CLK_STABLE" "LANE0_TX_CLK_STABLE" "XCVR_IF_0:LANE0_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "XCVR_IF_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "XCVR_IF_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_TxRSTn" "MX2_3:Y" "ReplyPktDecoder_0:TX_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "XCVR_Clk_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "XCVR_Clk_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RESET_XCVR_ERRORS" "RESET_XCVR_ERRORS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxRSTn" "mux_rxout_0:RX_RSTN" "MX2_4:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_EN" "mux_rxout_0:SIM_EN" "MX2_0:S" "MX2_2:S" "MX2_1:S" "MX2_3:S" "MX2_4:S" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_PLL_0:REF_CLK" "XCVR_Clk_0:REF_CLK" "XCVR_IF_0:LANE0_CDR_REF_CLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:INIT_RESET_N" "XCVR_Controller_Init:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxCLK" "MX2_0:A" "XCVR_IF_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxIDLE" "XCVR_IF_0:LANE0_RX_IDLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RX_READY" "Core_PCS_0:EPCS_READY" "XCVR_IF_0:LANE0_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RX_VAL" "Core_PCS_0:EPCS_RxVAL" "mux_rxout_0:DTC_RX_VALID" "XCVR_IF_0:LANE0_RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_TxCLK" "MX2_1:A" "XCVR_IF_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_LOCK" "MX2_2:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:PLL_LOCK" "XCVR_PLL_0:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:PCS_RESET_N" "XCVR_IF_0:LANE0_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:PMA_RESET_N" "XCVR_IF_0:LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RESET_CORE_N" "Core_PCS_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RX_RESET_N" "MX2_4:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:TX_RESET_N" "MX2_3:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:WA_RST_N" "Core_PCS_0:WA_RSTn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:XCVR_LOCK" "MX2_2:A" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_ADDR" "ALGO_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_RDATA" "ALGO_RDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_WDATA" "ALGO_WDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"B_CERR" "mux_rxout_0:B_CERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CODE_ERR_N" "mux_rxout_0:CODE_ERR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:B_CERR" "mux_rxout_0:DTC_B_CERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:CODE_ERR_N" "mux_rxout_0:DTC_CODE_ERR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_IF_0:LANE0_TX_DATA" "Core_PCS_0:EPCS_TxDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:INVALID_K" "mux_rxout_0:DTC_INVALID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RD_ERR" "mux_rxout_0:DTC_RD_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RX_DATA" "mux_rxout_0:DTC_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RX_K_CHAR" "mux_rxout_0:DTC_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DISP_SEL" "Core_PCS_0:DISP_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FORCE_DISP" "Core_PCS_0:FORCE_DISP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RX_DATA" "Core_PCS_0:EPCS_RxDATA" "INV_20bit_0:portOut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INVALID_K" "mux_rxout_0:INVALID_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RD_ERR" "mux_rxout_0:RD_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_DATA" "mux_rxout_0:RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_K_CHAR" "mux_rxout_0:RX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_DATA" "mux_rxout_0:SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_K_CHAR" "mux_rxout_0:SIM_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_DATA" "Core_PCS_0:TX_DATA" "ReplyPktDecoder_0:data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_DATA_OUT" "ReplyPktDecoder_0:TX_DATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_K_CHAR" "Core_PCS_0:TX_K_CHAR" "ReplyPktDecoder_0:kchar_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_20bit_0:portIn" "XCVR_IF_0:LANE0_RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:XCVR_LOSS_COUNTER" "XCVR_LOSS_COUNTER" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_PLL_0:CLKS_TO_XCVR" "XCVR_IF_0:CLKS_FROM_TXPLL_0" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign XCVR_Block
generate_component -component_name ${sd_name}
