# Creating SmartDesign serdes
set sd_name {serdes}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RE0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FULL0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EMPTY0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RCLOCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RRESET} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_ready0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_ready1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EMPTY1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FULL1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RE1} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_aligned_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {Q0} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {howmany} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {Q1} -port_direction {OUT} -port_range {[31:0]}

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add RxFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxFIFO} -instance_name {RxFIFO_0}



# Add RxFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxFIFO} -instance_name {RxFIFO_1}



# Add RxFIFOReset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxFIFOReset} -instance_name {RxFIFOReset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_0:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_0:PLL_LOCK} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_0:INIT_DONE} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_0:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_0:FPGA_POR_N} -value {VCC}



# Add RxFIFOReset_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxFIFOReset} -instance_name {RxFIFOReset_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_1:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_1:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_1:PLL_LOCK} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_1:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_1:INIT_DONE} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_1:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxFIFOReset_1:FPGA_POR_N} -value {VCC}



# Add SerdesRxController_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {SerdesRxController} -instance_name {SerdesRxController_0}
# Exporting Parameters of instance SerdesRxController_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {SerdesRxController_0} -params {\
"FIFO_ADDRESS_WIDTH:13" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {SerdesRxController_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesRxController_0:rx_valid} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesRxController_0:rx_code_violation} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesRxController_0:rx_disparity_error} -value {GND}



# Add SerdesRxController_1 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {SerdesRxController} -instance_name {SerdesRxController_1}
# Exporting Parameters of instance SerdesRxController_1
sd_configure_core_instance -sd_name ${sd_name} -instance_name {SerdesRxController_1} -params {\
"FIFO_ADDRESS_WIDTH:13" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {SerdesRxController_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesRxController_1:rx_valid} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesRxController_1:rx_code_violation} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesRxController_1:rx_disparity_error} -value {GND}



# Add TxIF_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TxIF} -instance_name {TxIF_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE0_TX_DATA} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE0_PCS_ARST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE0_PMA_ARST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE0_TX_DISPFNC} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE0_8B10B_TX_K} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE1_TX_DATA} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE1_PCS_ARST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE1_PMA_ARST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE1_TX_DISPFNC} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxIF_0:LANE1_8B10B_TX_K} -value {GND}



# Add TxPLL_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TxPLL} -instance_name {TxPLL_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TxPLL_0:PLL_LOCK}



# Add TxRefCLK_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TxRefCLK} -instance_name {TxRefCLK_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "RxFIFOReset_0:EXT_RST_N" "SerdesRxController_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:reset_n" "AND2_1:Y" "RxFIFOReset_1:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:EMPTY" "EMPTY0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_1:EMPTY" "EMPTY1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:fifo_ready" "fifo_ready0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:fifo_ready" "fifo_ready1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:FULL" "SerdesRxController_0:fifo_full" "FULL0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:fifo_full" "RxFIFO_1:FULL" "FULL1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE1_RXD_N" "LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE1_RXD_P" "LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE1_TXD_N" "LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE1_TXD_P" "LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:RCLOCK" "RxFIFO_1:RCLOCK" "RxFIFOReset_0:CLK" "RxFIFOReset_1:CLK" "RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:RE" "RE0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_1:RE" "RE1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "TxRefCLK_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "TxRefCLK_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "AND2_1:A" "RRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:RESET" "RxFIFOReset_0:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_1:RESET" "RxFIFOReset_1:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:serdes_aligned" "serdes_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:serdes_aligned" "serdes_aligned_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:WE" "SerdesRxController_0:fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:fifo_we" "RxFIFO_1:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:WCLOCK" "SerdesRxController_0:clk" "TxIF_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "TxIF_0:LANE0_RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:clk" "RxFIFO_1:WCLOCK" "TxIF_0:LANE1_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:B" "TxIF_0:LANE1_RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:LANE0_CDR_REF_CLK_0" "TxIF_0:LANE1_CDR_REF_CLK_0" "TxPLL_0:REF_CLK" "TxRefCLK_0:REF_CLK" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:howmany" "SerdesRxController_1:howmany" "howmany" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_0:Q" "Q0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_1:Q" "Q1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:fifo_rdcnt" "RxFIFO_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_1:RDCNT" "SerdesRxController_1:fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:data_out" "RxFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxFIFO_1:DATA" "SerdesRxController_1:data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:k_in" "TxIF_0:LANE0_8B10B_RX_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:data_in" "TxIF_0:LANE0_RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:k_in" "TxIF_0:LANE1_8B10B_RX_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_1:data_in" "TxIF_0:LANE1_RX_DATA" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxIF_0:CLKS_FROM_TXPLL_0" "TxPLL_0:CLKS_TO_XCVR" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign serdes
generate_component -component_name ${sd_name}
