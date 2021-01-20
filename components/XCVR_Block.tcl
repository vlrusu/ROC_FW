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
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALGO_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALGO_RESET} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_RST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALIGNED} -port_direction {OUT}

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

# Add Core_PCS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CorePCS_C0} -instance_name {Core_PCS_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_PWRDN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_TXOOB}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_TxVAL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_RxERR}



# Add INV_20bit_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {INV_20bit} -hdl_file {hdl\INV_20bit.vhd} -instance_name {INV_20bit_0}



# Add XCVR_Clk_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_REF_CLK_C0} -instance_name {XCVR_Clk_0}



# Add XCVR_Controller_Init instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C1} -instance_name {XCVR_Controller_Init}
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:ALIGNED" "ALIGNED" "XCVR_Reset_Controller_0_0:ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_ARST_N" "XCVR_IF_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:SLOW_CLK" "CTRL_CLK" "XCVR_Controller_Init:CLK" "XCVR_IF_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EXT_RST_N" "XCVR_Controller_Init:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INIT_DONE" "XCVR_Controller_Init:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxCLK" "LANE0_RX_CLK_R" "XCVR_IF_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxVAL" "LANE0_RX_VAL" "XCVR_IF_0:LANE0_RX_VAL" "XCVR_Reset_Controller_0_0:RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "XCVR_IF_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "XCVR_IF_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_TxCLK" "LANE0_TX_CLK_R" "XCVR_IF_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TX_CLK_STABLE" "XCVR_IF_0:LANE0_TX_CLK_STABLE" "XCVR_Reset_Controller_0_0:TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "XCVR_IF_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "XCVR_IF_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "XCVR_Clk_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "XCVR_Clk_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RESET_XCVR_ERRORS" "RESET_XCVR_ERRORS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_PLL_0:REF_CLK" "XCVR_Clk_0:REF_CLK" "XCVR_IF_0:LANE0_CDR_REF_CLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:INIT_RESET_N" "XCVR_Controller_Init:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxIDLE" "XCVR_IF_0:LANE0_RX_IDLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_READY" "XCVR_IF_0:LANE0_RX_READY" "XCVR_Reset_Controller_0_0:RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_LOCK" "XCVR_Reset_Controller_0_0:XCVR_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:PLL_LOCK" "XCVR_PLL_0:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:PCS_RESET_N" "XCVR_IF_0:LANE0_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:PMA_RESET_N" "XCVR_IF_0:LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RESET_CORE_N" "Core_PCS_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxRSTn" "XCVR_Reset_Controller_0_0:RX_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_TxRSTn" "XCVR_Reset_Controller_0_0:TX_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:WA_RST_N" "Core_PCS_0:WA_RSTn" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_ADDR" "ALGO_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_RDATA" "ALGO_RDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:ALGO_WDATA" "ALGO_WDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:B_CERR" "B_CERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:CODE_ERR_N" "CODE_ERR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_IF_0:LANE0_TX_DATA" "Core_PCS_0:EPCS_TxDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DISP_SEL" "Core_PCS_0:DISP_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FORCE_DISP" "Core_PCS_0:FORCE_DISP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Reset_Controller_0_0:RX_DATA" "Core_PCS_0:EPCS_RxDATA" "INV_20bit_0:portOut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:INVALID_K" "INVALID_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RD_ERR" "RD_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RX_DATA" "RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RX_K_CHAR" "RX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:TX_DATA" "TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:TX_K_CHAR" "TX_K_CHAR" }
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
