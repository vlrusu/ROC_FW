# Creating SmartDesign DigiLink
set sd_name {DigiLink}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PCS_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PMA_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PCS_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PMA_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {align} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_reset} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {force_full} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_fifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_fifo_re} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {aligned_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {aligned_1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_full} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {alignment_0} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {alignment_1} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {error_count_0} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {error_count_1} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_fifo_data_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_fifo_data_out} -port_direction {OUT} -port_range {[31:0]}


# Add CORERESET_PF_C1_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C1} -instance_name {CORERESET_PF_C1_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_0:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_0:PLL_POWERDOWN_B}



# Add CORERESET_PF_C1_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C1} -instance_name {CORERESET_PF_C1_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_1:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_1:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_1:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_1:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_1:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_1:PLL_POWERDOWN_B}



# Add CORERESET_PF_C1_2 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C1} -instance_name {CORERESET_PF_C1_2}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_2:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_2:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_2:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_2:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_2:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_2:PLL_POWERDOWN_B}



# Add CORERESET_PF_C1_3 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C1} -instance_name {CORERESET_PF_C1_3}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_3:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_3:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_3:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_3:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_3:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C1_3:PLL_POWERDOWN_B}



# Add PF_TX_PLL_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_TX_PLL_0} -instance_name {PF_TX_PLL_0_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_TX_PLL_0_0:PLL_LOCK}



# Add PF_XCVR_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_0} -instance_name {PF_XCVR_0_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE0_RX_IDLE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE1_RX_IDLE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE0_LOS} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE1_LOS} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE0_TX_DISPFNC} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE1_TX_DISPFNC} -value {GND}



# Add PF_XCVR_REF_CLK_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_REF_CLK_0} -instance_name {PF_XCVR_REF_CLK_0_0}



# Add ROCFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO} -instance_name {ROCFIFO_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ROCFIFO_0:RDCNT}



# Add ROCFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO} -instance_name {ROCFIFO_1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ROCFIFO_1:RDCNT}



# Add RxController_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {RxController} -hdl_file {hdl\RxController.vhd} -instance_name {RxController_0}



# Add RxController_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {RxController} -hdl_file {hdl\RxController.vhd} -instance_name {RxController_1}



# Add TxController_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {TxController} -hdl_file {hdl\TxController.vhd} -instance_name {TxController_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TxController_0:wrcnt} -pin_slices {[12:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TxController_0:wrcnt} -pin_slices {[16:13]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxController_0:wrcnt[16:13]} -value {0000}



# Add TxController_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {TxController} -hdl_file {hdl\TxController.vhd} -instance_name {TxController_1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TxController_1:wrcnt} -pin_slices {[12:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TxController_1:wrcnt} -pin_slices {[16:13]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TxController_1:wrcnt[16:13]} -value {GND}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_0:CLK" "PF_XCVR_0_0:LANE0_RX_CLK_R" "ROCFIFO_0:WCLOCK" "RxController_0:rx_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_0:FABRIC_RESET_N" "RxController_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_0:FPGA_POR_N" "CORERESET_PF_C1_1:FPGA_POR_N" "CORERESET_PF_C1_2:FPGA_POR_N" "CORERESET_PF_C1_3:FPGA_POR_N" "FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_0:INIT_DONE" "CORERESET_PF_C1_1:INIT_DONE" "CORERESET_PF_C1_2:INIT_DONE" "CORERESET_PF_C1_3:INIT_DONE" "INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_0:PLL_LOCK" "PF_XCVR_0_0:LANE0_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_1:CLK" "PF_XCVR_0_0:LANE1_RX_CLK_R" "ROCFIFO_1:WCLOCK" "RxController_1:rx_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_1:FABRIC_RESET_N" "RxController_1:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_1:PLL_LOCK" "PF_XCVR_0_0:LANE1_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_2:CLK" "PF_XCVR_0_0:LANE0_TX_CLK_R" "TxController_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_2:FABRIC_RESET_N" "TxController_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_2:PLL_LOCK" "PF_XCVR_0_0:LANE0_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_3:CLK" "PF_XCVR_0_0:LANE1_TX_CLK_R" "TxController_1:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_3:FABRIC_RESET_N" "TxController_1:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C1_3:PLL_LOCK" "PF_XCVR_0_0:LANE1_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_ARST_N" "PF_XCVR_0_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "PF_XCVR_0_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_PCS_ARST_N" "PF_XCVR_0_0:LANE0_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_PMA_ARST_N" "PF_XCVR_0_0:LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "PF_XCVR_0_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "PF_XCVR_0_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "PF_XCVR_0_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "PF_XCVR_0_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_PCS_ARST_N" "PF_XCVR_0_0:LANE1_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_PMA_ARST_N" "PF_XCVR_0_0:LANE1_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_N" "PF_XCVR_0_0:LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_P" "PF_XCVR_0_0:LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_N" "PF_XCVR_0_0:LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_P" "PF_XCVR_0_0:LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_TX_PLL_0_0:REF_CLK" "PF_XCVR_0_0:LANE0_CDR_REF_CLK_0" "PF_XCVR_0_0:LANE1_CDR_REF_CLK_0" "PF_XCVR_REF_CLK_0_0:REF_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_VAL" "RxController_0:rx_val" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE1_RX_VAL" "RxController_1:rx_val" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_REF_CLK_0_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_REF_CLK_0_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:EMPTY" "lane0_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:FULL" "lane0_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:RCLOCK" "ROCFIFO_1:RCLOCK" "fifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:RE" "lane0_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:RRESET_N" "ROCFIFO_0:WRESET_N" "ROCFIFO_1:RRESET_N" "ROCFIFO_1:WRESET_N" "fifo_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:WE" "RxController_0:data_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_1:EMPTY" "lane1_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_1:FULL" "lane1_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_1:RE" "lane1_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_1:WE" "RxController_1:data_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxController_0:aligned" "aligned_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxController_1:aligned" "aligned_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxController_0:align" "TxController_1:align" "align" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxController_0:force_full" "TxController_1:force_full" "force_full" }

# Add bus net connections
sd_create_bus_net -sd_name ${sd_name} -net_name {alignment_0} -net_range {[3:0]}
sd_create_bus_net -sd_name ${sd_name} -net_name {error_count_0} -net_range {[7:0]}
sd_connect_net_to_pins -sd_name ${sd_name} -net_name {alignment_0} -pin_names {"RxController_0:alignment" "alignment_0" }
sd_connect_net_to_pins -sd_name ${sd_name} -net_name {error_count_0} -pin_names {"RxController_0:error_count" "error_count_0" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_8B10B_RX_K" "RxController_0:k_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_8B10B_TX_K" "TxController_0:kchar_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_CODE_VIOLATION" "RxController_0:code_violation" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_DATA" "ROCFIFO_0:DATA" "RxController_0:data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_DISPARITY_ERROR" "RxController_0:disp_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_TX_DATA" "TxController_0:data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE1_8B10B_RX_K" "RxController_1:k_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE1_8B10B_TX_K" "TxController_1:kchar_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE1_RX_CODE_VIOLATION" "RxController_1:code_violation" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE1_RX_DATA" "ROCFIFO_1:DATA" "RxController_1:data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE1_RX_DISPARITY_ERROR" "RxController_1:disp_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE1_TX_DATA" "TxController_1:data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:Q" "lane0_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:WRCNT" "TxController_0:wrcnt[12:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_1:Q" "lane1_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_1:WRCNT" "TxController_1:wrcnt[12:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxController_1:alignment" "alignment_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxController_1:error_count" "error_count_1" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_TX_PLL_0_0:CLKS_TO_XCVR" "PF_XCVR_0_0:CLKS_FROM_TXPLL_0" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DigiLink
generate_component -component_name ${sd_name}
