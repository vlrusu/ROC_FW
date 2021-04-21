# Creating SmartDesign TOP_SERDES
set sd_name {TOP_SERDES}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {eventwindowmarker} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CLOCK_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ENABLE_ALIGNMENT} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {reversed} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {word_aligned} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {ALIGNMENT_LOSS_COUNTER} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_marker_count} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {address} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {counter_out} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {Q} -port_direction {OUT} -port_range {[19:16]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATA} -port_direction {IN} -port_range {[39:29]}
sd_create_bus_port -sd_name ${sd_name} -port_name {Q_0} -port_direction {OUT} -port_range {[39:0]}

# Add CORERESET_PF_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {CORERESET_PF_C0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:PLL_LOCK} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:INIT_DONE} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:FPGA_POR_N} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:PLL_POWERDOWN_B}



# Add crc_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {crc_0}



# Add EventMarker_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {EventMarker} -hdl_file {hdl\EventMarker.vhd} -instance_name {EventMarker_0}



# Add RxPacketFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxPacketFIFO} -instance_name {RxPacketFIFO_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:Q} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:Q} -pin_slices {[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:EMPTY}



# Add RxPacketReader_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {RxPacketReader} -hdl_file {hdl\RxPacketReader.vhd} -instance_name {RxPacketReader_0}



# Add TxPacketWriter_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {TxPacketWriter} -hdl_file {hdl\TxPacketWriter.vhd} -instance_name {TxPacketWriter_0}



# Add XCVR_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_Block} -instance_name {XCVR_Block_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:LANE0_RX_VAL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:LANE0_TX_CLK_STABLE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:B_CERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:RD_ERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:CODE_ERR_N}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:INVALID_K}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "XCVR_Block_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_0:FABRIC_RESET_N" "TxPacketWriter_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "XCVR_Block_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ENABLE_ALIGNMENT" "XCVR_Block_0:ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"eventwindowmarker" "EventMarker_0:eventmarker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:EPCS_RXCLK" "LANE0_RX_CLK_R" "RxPacketFIFO_0:WCLOCK" "RxPacketReader_0:clk" "XCVR_Block_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RE" "XCVR_Block_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "XCVR_Block_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:reversed" "reversed" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:WE" "RxPacketReader_0:rxpacket_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_0:CRC_EN" "TxPacketWriter_0:crc_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_0:RST" "TxPacketWriter_0:crc_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:RE" "TxPacketWriter_0:rxpacket_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:word_aligned" "word_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:RESET_N" "CORERESET_PF_C0_0:EXT_RST_N" "RxPacketFIFO_0:RESET" "RxPacketReader_0:reset_n" "XCVR_Block_0:ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_0:CLK" "CORERESET_PF_C0_0:CLK" "RxPacketFIFO_0:RCLOCK" "TxPacketWriter_0:clk" "XCVR_Block_0:LANE0_TX_CLK_R" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"address" "XCVR_Block_0:address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNMENT_LOSS_COUNTER" "XCVR_Block_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter_out" "XCVR_Block_0:counter_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_0:CRC_OUT" "TxPacketWriter_0:data_from_crc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATA" "XCVR_Block_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_marker_count" "EventMarker_0:event_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:Q[19:16]" "Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Q_0" "XCVR_Block_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:Q[15:0]" "TxPacketWriter_0:rxpacket_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:RDCNT" "TxPacketWriter_0:rxpacket_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:DATA" "RxPacketReader_0:rxpacket_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:data_out" "XCVR_Block_0:TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_0:DATA_IN" "TxPacketWriter_0:data_to_crc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:kchar_out" "XCVR_Block_0:TX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:RX_DATA" "RxPacketReader_0:data_in" "XCVR_Block_0:RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:RX_K_CHAR" "RxPacketReader_0:k_char" "XCVR_Block_0:RX_K_CHAR" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TOP_SERDES
generate_component -component_name ${sd_name}
