# Creating SmartDesign TOP_SERDES
set sd_name {TOP_SERDES}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {eventwindowmarker} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CLOCK_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ENABLE_ALIGNMENT} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {reversed} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {word_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PLL_LOCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {ALIGNMENT_LOSS_COUNTER} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_marker_count} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {address} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {counter_out} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_expected} -port_direction {IN} -port_range {[15:0]}

# Add CORERESET_PF_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {CORERESET_PF_C0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:PLL_POWERDOWN_B}



# Add CORERESET_PF_C0_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {CORERESET_PF_C0_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_1:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_1:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_1:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_1:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_1:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_1:PLL_POWERDOWN_B}



# Add CORERESET_PF_C0_2 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {CORERESET_PF_C0_2}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_2:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_2:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_2:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_2:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_2:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_2:PLL_POWERDOWN_B}



# Add crc_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {crc_0}



# Add DCSProcessor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DCSProcessor} -hdl_file {hdl\DCSProcessor.vhd} -instance_name {DCSProcessor_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCSProcessor_0:state_count}



# Add EventMarker_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {EventMarker} -hdl_file {hdl\EventMarker.vhd} -instance_name {EventMarker_0}



# Add RxPacketFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxPacketFIFO} -instance_name {RxPacketFIFO_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:DATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:DATA} -pin_slices {[19:16]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:DATA[19:16]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:Q} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:Q} -pin_slices {[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:Q[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:EMPTY}



# Add RxPacketFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxPacketFIFO} -instance_name {RxPacketFIFO_1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:DATA} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:DATA} -pin_slices {[19:18]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxPacketFIFO_1:DATA[19:18]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:Q} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:Q} -pin_slices {[19:18]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_1:Q[19:18]}



# Add RxPacketReader_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {RxPacketReader} -hdl_file {hdl\RxPacketReader.vhd} -instance_name {RxPacketReader_0}



# Add TxPacketWriter_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {TxPacketWriter} -hdl_file {hdl\TxPacketWriter.vhd} -instance_name {TxPacketWriter_0}



# Add XCVR_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_Block} -instance_name {XCVR_Block_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:LANE0_RX_VAL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:B_CERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:RD_ERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:CODE_ERR_N}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:INVALID_K}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "XCVR_Block_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_0:FABRIC_RESET_N" "TxPacketWriter_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:reset_n" "CORERESET_PF_C0_1:FABRIC_RESET_N" "RxPacketFIFO_1:RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_2:FABRIC_RESET_N" "RxPacketFIFO_0:RESET" "RxPacketReader_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "XCVR_Block_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:RCLOCK" "CORERESET_PF_C0_1:CLK" "crc_0:CLK" "RxPacketFIFO_1:WCLOCK" "dcs_clk" "DCSProcessor_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_en" "crc_0:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_rst" "crc_0:RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_re" "RxPacketFIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_we" "RxPacketFIFO_1:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ENABLE_ALIGNMENT" "XCVR_Block_0:ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:ewm" "eventwindowmarker" "EventMarker_0:eventmarker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_2:FPGA_POR_N" "CORERESET_PF_C0_0:FPGA_POR_N" "CORERESET_PF_C0_1:FPGA_POR_N" "FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_2:INIT_DONE" "CORERESET_PF_C0_0:INIT_DONE" "CORERESET_PF_C0_1:INIT_DONE" "INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RX_CLK_R" "CORERESET_PF_C0_2:CLK" "XCVR_Block_0:LANE0_RX_CLK_R" "EventMarker_0:EPCS_RXCLK" "RxPacketFIFO_0:WCLOCK" "RxPacketReader_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_1:PLL_LOCK" "PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "XCVR_Block_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:reversed" "reversed" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:WE" "RxPacketReader_0:we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:fifo_re" "RxPacketFIFO_1:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:word_aligned" "word_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:ALIGNED" "EventMarker_0:RESET_N" "RxPacketReader_0:aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RX_READY" "CORERESET_PF_C0_2:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_0:CLK" "RxPacketFIFO_1:RCLOCK" "TxPacketWriter_0:clk" "XCVR_Block_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TX_CLK_STABLE" "CORERESET_PF_C0_0:PLL_LOCK" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"address" "XCVR_Block_0:address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNMENT_LOSS_COUNTER" "XCVR_Block_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter_out" "XCVR_Block_0:counter_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_data_in" "crc_0:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_data_out" "crc_0:DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:rx_crc_error" "DCSProcessor_0:error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_data_out" "RxPacketFIFO_1:DATA[17:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_marker_count" "EventMarker_0:event_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_window_expected" "XCVR_Block_0:event_window_expected" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:Q[15:0]" "DCSProcessor_0:fifo_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:RDCNT" "DCSProcessor_0:fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:Q[17:0]" "TxPacketWriter_0:fifo_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:fifo_rdcnt" "RxPacketFIFO_1:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:DATA[15:0]" "RxPacketReader_0:data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:rx_packet_error" "RxPacketReader_0:error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:data_out" "XCVR_Block_0:TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:kchar_out" "XCVR_Block_0:TX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:RX_DATA" "RxPacketReader_0:data_in" "XCVR_Block_0:RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_K_CHAR" "EventMarker_0:RX_K_CHAR" "RxPacketReader_0:k_in" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TOP_SERDES
generate_component -component_name ${sd_name}
