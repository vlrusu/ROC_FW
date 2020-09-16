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
sd_create_scalar_port -sd_name ${sd_name} -port_name {init_reset_n} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {init_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {outfifo_wclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_re} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {serialfifo_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serialfifo_rdcnt} -port_direction {OUT} -port_range {[11:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {use_lane} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ddrfifo_rdcnt} -port_direction {OUT} -port_range {[11:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ddrfifo_data} -port_direction {OUT} -port_range {[31:0]}

# Add DigiReaderFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiReaderFIFO} -instance_name {DigiReaderFIFO_0}



# Add DigiReaderFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiReaderFIFO} -instance_name {DigiReaderFIFO_1}



# Add DigiReaderSM_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DigiReaderSM} -hdl_file {hdl\DigiReaderSM.vhd} -instance_name {DigiReaderSM_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DigiReaderSM_0:fifo_re} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DigiReaderSM_0:fifo_re} -pin_slices {[1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DigiReaderSM_0:fifo_re} -pin_slices {[2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DigiReaderSM_0:fifo_re} -pin_slices {[3]}



# Add serdes_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SerdesIF} -instance_name {serdes_0}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {serdes_0} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {serdes_0} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_0:write_words} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_0:write_count} -value {1101111010101101}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_0:dummy_address} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_0:lane0_dummy_out}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_0:lane1_dummy_out}



# Add serdes_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SerdesIF} -instance_name {serdes_1}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {serdes_1} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {serdes_1} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_1:write_words} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_1:write_count} -value {1101111010101101}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {serdes_1:dummy_address} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_1:lane0_dummy_out}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_1:lane1_dummy_out}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:CTRL_ARST_N" "serdes_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:CTRL_CLK" "serdes_0:CTRL_CLK" "CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ddrfifo_empty" "DigiReaderFIFO_1:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ddrfifo_full" "DigiReaderFIFO_1:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:RCLOCK" "ddrfifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:RE" "ddrfifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:fifo_re[0]" "serdes_0:lane0_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:fifo_re[1]" "serdes_0:lane1_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane0_fifo_re" "DigiReaderSM_0:fifo_re[2]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane1_fifo_re" "DigiReaderSM_0:fifo_re[3]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:WE" "DigiReaderSM_0:outfifo_we" "DigiReaderFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_RESET" "DigiReaderFIFO_1:RESET" "DigiReaderSM_0:reset_n" "DigiReaderFIFO_0:RESET" "serdes_1:fifo_reset_n" "serdes_0:fifo_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:init_clk" "serdes_0:init_clk" "init_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:init_reset_n" "serdes_0:init_reset_n" "init_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_RXD_N" "LANE0_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_RXD_P" "LANE0_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_TXD_N" "LANE0_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE0_TXD_P" "LANE0_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_RXD_N" "LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_RXD_N" "LANE1_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_RXD_P" "LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_RXD_P" "LANE1_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_TXD_N" "LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_TXD_N" "LANE1_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:LANE1_TXD_P" "LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:LANE1_TXD_P" "LANE1_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"outfifo_wclk" "DigiReaderFIFO_1:WCLOCK" "DigiReaderSM_0:clk" "DigiReaderFIFO_0:WCLOCK" "serdes_1:fifo_rclk" "serdes_0:fifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:REF_CLK_PAD_N" "REF_CLK_PAD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:REF_CLK_PAD_P" "REF_CLK_PAD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane0_empty" "serdes_0:lane0_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane1_empty" "serdes_0:lane1_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane2_empty" "serdes_1:lane0_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane3_empty" "serdes_1:lane1_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serialfifo_empty" "DigiReaderFIFO_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serialfifo_full" "DigiReaderFIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serialfifo_rclk" "DigiReaderFIFO_0:RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serialfifo_re" "DigiReaderFIFO_0:RE" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ddrfifo_data" "DigiReaderFIFO_1:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ddrfifo_rdcnt" "DigiReaderFIFO_1:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:DATA" "DigiReaderFIFO_0:DATA" "DigiReaderSM_0:outfifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane0_data" "serdes_0:lane0_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane0_fifo_data_out" "DigiReaderSM_0:lane2_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane0_rdcnt" "serdes_0:lane0_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane2_rdcnt" "serdes_1:lane0_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane1_data" "serdes_0:lane1_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:lane1_fifo_data_out" "DigiReaderSM_0:lane3_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane1_rdcnt" "serdes_0:lane1_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane3_rdcnt" "serdes_1:lane1_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serialfifo_data" "DigiReaderFIFO_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serialfifo_rdcnt" "DigiReaderFIFO_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"use_lane" "DigiReaderSM_0:use_lane" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DIGIINTERFACE
generate_component -component_name ${sd_name}
