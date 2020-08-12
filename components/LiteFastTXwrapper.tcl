# Creating SmartDesign LiteFastTXwrapper
set sd_name {LiteFastTXwrapper}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {clk_tx_i} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rst_n_tx_i} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane_aligned} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {write_words} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {local_token_tx_i} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token_tx_i} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {LiteFast_k_tx_o} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {LiteFast_data_tx_o} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {write_count} -port_direction {IN} -port_range {[15:0]}

# Add COREFIFO_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {COREFIFO_C0} -instance_name {COREFIFO_C0_0}



# Add LiteFast_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {LiteFast_C0} -instance_name {LiteFast_C0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {LiteFast_C0_0:simplex_en_i} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {LiteFast_C0_0:crc_err_en_tx_i} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {LiteFast_C0_0:min_remote_token_tx_i} -value {00001000}



# Add SerdesTxController_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {SerdesTxController} -hdl_file {hdl\SerdesTxController.vhd} -instance_name {SerdesTxController_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:clk_tx_i" "COREFIFO_C0_0:WCLOCK" "COREFIFO_C0_0:RCLOCK" "clk_tx_i" "SerdesTxController_0:read_clk" "SerdesTxController_0:write_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREFIFO_C0_0:EMPTY" "SerdesTxController_0:fifo_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREFIFO_C0_0:FULL" "SerdesTxController_0:fifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:local_rece_rdy_tx_i" "lane_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:req_usr_data_tx_o" "SerdesTxController_0:req_usr_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:rst_n_tx_i" "COREFIFO_C0_0:RESET" "rst_n_tx_i" "SerdesTxController_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREFIFO_C0_0:RE" "SerdesTxController_0:fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREFIFO_C0_0:WE" "SerdesTxController_0:fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:usr_data_rdy_tx_i" "SerdesTxController_0:usr_data_rdy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:usr_data_val_tx_i" "SerdesTxController_0:usr_data_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"write_words" "SerdesTxController_0:write_words" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREFIFO_C0_0:Q" "SerdesTxController_0:data_from_fifo" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREFIFO_C0_0:RDCNT" "SerdesTxController_0:fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_data_tx_o" "LiteFast_C0_0:LiteFast_data_tx_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:LiteFast_k_tx_o" "LiteFast_k_tx_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:local_token_tx_i" "local_token_tx_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:remote_token_tx_i" "remote_token_tx_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREFIFO_C0_0:DATA" "SerdesTxController_0:data_to_fifo" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFast_C0_0:usr_data_tx_i" "SerdesTxController_0:data_to_serdes" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"write_count" "SerdesTxController_0:write_count" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign LiteFastTXwrapper
generate_component -component_name ${sd_name}
