# Creating SmartDesign LiteFastRXwrapper
set sd_name {LiteFastRXwrapper}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane_aligned_rx_o} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {crc_err_rx_o} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rx_val} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {tx_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rx_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {usr_data_val_rx_o} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {block_aligned_rx_o} -port_direction {OUT} -port_range {[0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane_k_rx_i} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane_data_rx_i} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {usr_data_rx_o} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {local_token} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {wrcnt} -port_direction {IN} -port_range {[12:0]}

# Add LiteFast_C1_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {LiteFast_C1} -instance_name {LiteFast_C1_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {LiteFast_C1_0:word_aligned_rx_i} -value {VCC}



# Add SerdesRxController_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {SerdesRxController} -hdl_file {hdl\SerdesRxController.vhd} -instance_name {SerdesRxController_0}



# Add TokenFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TokenFIFO} -instance_name {TokenFIFO_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TokenFIFO_0:WE} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TokenFIFO_0:RE} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TokenFIFO_0:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TokenFIFO_0:EMPTY}



# Add TokenFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TokenFIFO} -instance_name {TokenFIFO_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TokenFIFO_1:WE} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TokenFIFO_1:RE} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TokenFIFO_1:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TokenFIFO_1:EMPTY}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:block_aligned_rx_o" "block_aligned_rx_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:crc_err_rx_o" "crc_err_rx_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:lane_aligned_rx_o" "lane_aligned_rx_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:clk_rx_i" "TokenFIFO_0:WCLOCK" "TokenFIFO_1:WCLOCK" "rx_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:serdes_rx_val_i" "LiteFast_C1_0:rst_n_rx_i" "TokenFIFO_0:RESET" "TokenFIFO_1:RESET" "rx_val" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TokenFIFO_0:RCLOCK" "TokenFIFO_1:RCLOCK" "tx_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:usr_data_val_rx_o" "usr_data_val_rx_o" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:lane_data_rx_i" "lane_data_rx_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane_k_rx_i" "LiteFast_C1_0:lane_k_rx_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:remote_token_rx_o" "TokenFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TokenFIFO_1:Q" "local_token" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"remote_token" "TokenFIFO_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:local_token" "TokenFIFO_1:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C1_0:usr_data_rx_o" "usr_data_rx_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesRxController_0:wrcnt" "wrcnt" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign LiteFastRXwrapper
generate_component -component_name ${sd_name}
