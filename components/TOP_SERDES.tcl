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

sd_create_bus_port -sd_name ${sd_name} -port_name {ALIGNMENT_LOSS_COUNTER} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_marker_count} -port_direction {OUT} -port_range {[15:0]}

# Add EventMarker_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {EventMarker} -hdl_file {hdl\EventMarker.vhd} -instance_name {EventMarker_0}



# Add XCVR_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_Block} -instance_name {XCVR_Block_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:LANE0_TX_CLK_R}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:LANE0_RX_VAL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:LANE0_TX_CLK_STABLE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:B_CERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:RD_ERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:INVALID_K}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "XCVR_Block_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "XCVR_Block_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ENABLE_ALIGNMENT" "XCVR_Block_0:ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"eventwindowmarker" "EventMarker_0:eventmarker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RX_CLK_R" "EventMarker_0:EPCS_RXCLK" "XCVR_Block_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "XCVR_Block_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:RESET_N" "XCVR_Block_0:ALIGNED" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNMENT_LOSS_COUNTER" "XCVR_Block_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_marker_count" "EventMarker_0:event_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_DATA" "EventMarker_0:RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EventMarker_0:RX_K_CHAR" "XCVR_Block_0:RX_K_CHAR" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TOP_SERDES
generate_component -component_name ${sd_name}
