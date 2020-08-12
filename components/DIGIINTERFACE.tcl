# Creating SmartDesign DIGIINTERFACE
set sd_name {DIGIINTERFACE}
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
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RCLOCKSERIAL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FIFO_RESET} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_fifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {init_reset_n} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {init_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_fifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_fifo_re_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_fifo_re_0} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_dummy_status_out} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_dummy_status_out} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_dummy_status_out_0} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_dummy_status_out_0} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_address} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_rdcnt} -port_direction {OUT} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_fifo_data_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_rdcnt} -port_direction {OUT} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_fifo_data_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_rdcnt_0} -port_direction {OUT} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_fifo_data_out_0} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_fifo_data_out_0} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_rdcnt_0} -port_direction {OUT} -port_range {[12:0]}

# Add serdes_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SerdesIF} -instance_name {serdes_0}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {serdes_0} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {serdes_0} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_0:write_words} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_0:write_count} -value {1101111010101101}



# Add serdes_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SerdesIF} -instance_name {serdes_1}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {serdes_1} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {serdes_1} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_1:write_words} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_1:write_count} -value {1101111010101101}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:CTRL_ARST_N" "serdes_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:CTRL_CLK" "serdes_0:CTRL_CLK" "CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:fifo_reset_n" "serdes_0:fifo_reset_n" "FIFO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:init_clk" "serdes_0:init_clk" "init_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:init_reset_n" "serdes_0:init_reset_n" "init_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane0_fifo_re" "lane0_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane0_fifo_re" "lane0_fifo_re_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_RXD_N" "LANE0_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_RXD_P" "LANE0_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_TXD_N" "LANE0_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_TXD_P" "LANE0_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane1_fifo_re" "lane1_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane1_fifo_re" "lane1_fifo_re_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_RXD_N" "LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_RXD_N" "LANE1_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_RXD_P" "LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_RXD_P" "LANE1_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_TXD_N" "LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_TXD_N" "LANE1_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_TXD_P" "LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_TXD_P" "LANE1_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:fifo_rclk" "serdes_0:fifo_rclk" "RCLOCKSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:REF_CLK_PAD_N" "REF_CLK_PAD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:REF_CLK_PAD_P" "REF_CLK_PAD_P_0" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:dummy_address" "serdes_0:dummy_address" "dummy_status_address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane0_dummy_out" "lane0_dummy_status_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane0_dummy_out" "lane0_dummy_status_out_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane0_fifo_data_out" "lane0_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane0_fifo_data_out" "lane0_fifo_data_out_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane0_rdcnt" "lane0_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane0_rdcnt" "lane0_rdcnt_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane1_dummy_out" "lane1_dummy_status_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane1_dummy_out" "lane1_dummy_status_out_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane1_fifo_data_out" "lane1_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane1_fifo_data_out" "lane1_fifo_data_out_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:lane1_rdcnt" "lane1_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane1_rdcnt" "lane1_rdcnt_0" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DIGIINTERFACE
generate_component -component_name ${sd_name}
