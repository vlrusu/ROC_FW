# Creating SmartDesign DigiInterface
set sd_name {DigiInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PCS_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PCS_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PMA_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PMA_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PCS_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PCS_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PMA_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PMA_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {align} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {axi_start_on_serdesclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_fifo_full} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_resetn} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {force_full} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {newspill} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdesclk_resetn} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {use_uart} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_lane0_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_lane0_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_lane1_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_lane1_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_lane0_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_lane0_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_lane1_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_lane1_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane0_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane1_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {curr_ewfifo_wr} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_done} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_fifo_we} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_ovfl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane0_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane1_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_full} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {use_lane} -port_direction {IN} -port_range {[3:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane0_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane0_error_count} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane1_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane1_error_count} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_fifo_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_size} -port_direction {OUT} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_tag} -port_direction {OUT} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane0_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane0_error_count} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane1_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane1_error_count} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {rocfifocntrl_state} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serialfifo_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serialfifo_rdcnt} -port_direction {OUT} -port_range {[16:0]}


# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add DigiLink_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiLink} -instance_name {DigiLink_0}



# Add DigiLink_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiLink} -instance_name {DigiLink_1}



# Add DigiReaderFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiReaderFIFO} -instance_name {DigiReaderFIFO_0}



# Add edge_generator_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {edge_generator} -hdl_file {hdl\edge_generator.v} -instance_name {edge_generator_1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {edge_generator_1:fallingEdge}



# Add ROCFIFOController_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {ROCFIFOController} -hdl_file {hdl\ROCFIFOController.vhd} -instance_name {ROCFIFOController_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "DigiLink_0:fifo_reset" "DigiLink_1:fifo_reset" "DigiReaderFIFO_0:RRESET_N" "DigiReaderFIFO_0:WRESET_N" "edge_generator_1:resetn" "fifo_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "serdesclk_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "ROCFIFOController_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_lane0_empty" "DigiLink_0:lane0_empty" "ROCFIFOController_0:lane0_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_lane0_full" "DigiLink_0:lane0_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_lane1_empty" "DigiLink_0:lane1_empty" "ROCFIFOController_0:lane1_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_lane1_full" "DigiLink_0:lane1_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_ARST_N" "DigiLink_0:CTRL_ARST_N" "DigiLink_1:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "DigiLink_0:CTRL_CLK" "DigiLink_1:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:FPGA_POR_N" "DigiLink_1:FPGA_POR_N" "FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:INIT_DONE" "DigiLink_1:INIT_DONE" "INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_PCS_ARST_N" "LANE0_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_PMA_ARST_N" "LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_PCS_ARST_N" "LANE1_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_PMA_ARST_N" "LANE1_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_RXD_N" "LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_RXD_P" "LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_TXD_N" "LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_TXD_P" "LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:align" "DigiLink_1:align" "align" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:aligned_0" "cal_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:aligned_1" "cal_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:fifo_rclk" "DigiLink_1:fifo_rclk" "DigiReaderFIFO_0:WCLOCK" "ROCFIFOController_0:clk" "edge_generator_1:clk" "fifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:force_full" "DigiLink_1:force_full" "force_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:lane0_fifo_re" "ROCFIFOController_0:lane0_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:lane1_fifo_re" "ROCFIFOController_0:lane1_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_PCS_ARST_N" "LANE0_PCS_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_PMA_ARST_N" "LANE0_PMA_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_RXD_N" "LANE0_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_RXD_P" "LANE0_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_TXD_N" "LANE0_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_TXD_P" "LANE0_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_PCS_ARST_N" "LANE1_PCS_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_PMA_ARST_N" "LANE1_PMA_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_RXD_N" "LANE1_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_RXD_P" "LANE1_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_TXD_N" "LANE1_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_TXD_P" "LANE1_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:REF_CLK_PAD_N" "REF_CLK_PAD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:REF_CLK_PAD_P" "REF_CLK_PAD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:aligned_0" "hv_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:aligned_1" "hv_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane0_empty" "HV_lane0_empty" "ROCFIFOController_0:lane2_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane0_fifo_re" "ROCFIFOController_0:lane2_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane0_full" "HV_lane0_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane1_empty" "HV_lane1_empty" "ROCFIFOController_0:lane3_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane1_fifo_re" "ROCFIFOController_0:lane3_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane1_full" "HV_lane1_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:EMPTY" "serialfifo_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:FULL" "ROCFIFOController_0:uart_fifo_full" "serialfifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:RCLOCK" "serialfifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:RE" "serialfifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:WE" "ROCFIFOController_0:uart_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:axi_start_on_serdesclk" "axi_start_on_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:curr_ewfifo_wr" "curr_ewfifo_wr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:ew_done" "ew_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:ew_fifo_full" "ew_fifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:ew_fifo_we" "ew_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:ew_ovfl" "ew_ovfl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:newspill_reset" "edge_generator_1:risingEdge" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:use_uart" "use_uart" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"edge_generator_1:gate" "newspill" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:alignment_0" "cal_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:alignment_1" "cal_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:error_count_0" "cal_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:error_count_1" "cal_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:lane0_fifo_data_out" "ROCFIFOController_0:lane0_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:lane1_fifo_data_out" "ROCFIFOController_0:lane1_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:alignment_0" "hv_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:alignment_1" "hv_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:error_count_0" "hv_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:error_count_1" "hv_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane0_fifo_data_out" "ROCFIFOController_0:lane2_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:lane1_fifo_data_out" "ROCFIFOController_0:lane3_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:DATA" "ROCFIFOController_0:uart_fifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:Q" "serialfifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:RDCNT" "serialfifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:ew_fifo_data" "ew_fifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:ew_size" "ew_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:ew_tag" "ew_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:state_count" "rocfifocntrl_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFOController_0:use_lane" "use_lane" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DigiInterface
generate_component -component_name ${sd_name}
