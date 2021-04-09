# Creating SmartDesign DigiInterface
set sd_name {DigiInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_reset} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serialfifo_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddrfifo_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PCS_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PCS_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PMA_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PMA_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PCS_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PCS_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_PMA_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_PMA_ARST_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane0_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane1_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane0_aligned} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane1_aligned} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {use_lane} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serialfifo_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serialfifo_rdcnt} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ddrfifo_rdcnt} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ddrfifo_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane1_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane0_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane1_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane0_alignment} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane1_error_count} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane0_error_count} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane1_error_count} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane0_error_count} -port_direction {OUT} -port_range {[7:0]}

# Add DigiLink_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiLink} -instance_name {DigiLink_0}



# Add DigiLink_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiLink} -instance_name {DigiLink_1}



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



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:aligned" "cal_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:aligned_0" "cal_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:CTRL_ARST_N" "DigiLink_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:CTRL_CLK" "DigiLink_0:CTRL_CLK" "CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:EMPTY" "ddrfifo_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:FULL" "ddrfifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:RCLOCK" "ddrfifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:RE" "ddrfifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane0_empty" "DigiLink_0:lane0_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane1_empty" "DigiLink_0:lane1_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane2_empty" "DigiLink_1:lane0_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane3_empty" "DigiLink_1:lane1_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:fifo_re[0]" "DigiLink_0:lane0_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:fifo_re[1]" "DigiLink_0:lane1_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:fifo_re[2]" "DigiLink_1:lane0_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:fifo_re[3]" "DigiLink_1:lane1_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:outfifo_we" "DigiReaderFIFO_1:WE" "DigiReaderFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:clk" "DigiLink_1:fifo_rclk" "DigiReaderFIFO_1:WCLOCK" "DigiReaderFIFO_0:WCLOCK" "DigiLink_0:fifo_rclk" "fifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:reset_n" "DigiLink_1:fifo_reset" "DigiReaderFIFO_1:RESET" "DigiReaderFIFO_0:RESET" "DigiLink_0:fifo_reset" "fifo_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:FPGA_POR_N" "DigiLink_0:FPGA_POR_N" "FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:aligned" "hv_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:aligned_0" "hv_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:INIT_DONE" "DigiLink_0:INIT_DONE" "INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_PCS_ARST_N" "LANE0_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_PCS_ARST_N" "LANE0_PCS_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_PMA_ARST_N" "LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_PMA_ARST_N" "LANE0_PMA_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_RXD_N" "LANE0_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_RXD_P" "LANE0_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_TXD_N" "LANE0_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE0_TXD_P" "LANE0_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_PCS_ARST_N" "LANE1_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_PCS_ARST_N" "LANE1_PCS_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_PMA_ARST_N" "LANE1_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_PMA_ARST_N" "LANE1_PMA_ARST_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_RXD_N" "LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_RXD_N" "LANE1_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_RXD_P" "LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_RXD_P" "LANE1_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_TXD_N" "LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_TXD_N" "LANE1_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:LANE1_TXD_P" "LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:LANE1_TXD_P" "LANE1_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:REF_CLK_PAD_N" "REF_CLK_PAD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_1:REF_CLK_PAD_P" "REF_CLK_PAD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:EMPTY" "serialfifo_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:FULL" "serialfifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:RCLOCK" "serialfifo_rclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:RE" "serialfifo_re" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"hv_lane1_alignment" "DigiLink_1:alignment_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:alignment" "cal_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:error_count" "cal_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:alignment_0" "cal_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:error_count_0" "cal_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:Q" "ddrfifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:RDCNT" "ddrfifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:lane0_fifo_data_out" "DigiReaderSM_0:lane0_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:lane0_rdcnt" "DigiReaderSM_0:lane0_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane1_data" "DigiLink_0:lane1_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiLink_0:lane1_rdcnt" "DigiReaderSM_0:lane1_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane2_data" "DigiLink_1:lane0_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane2_rdcnt" "DigiLink_1:lane0_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane3_data" "DigiLink_1:lane1_fifo_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:lane3_rdcnt" "DigiLink_1:lane1_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_1:DATA" "DigiReaderSM_0:outfifo_data" "DigiReaderFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hv_lane0_alignment" "DigiLink_1:alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hv_lane0_error_count" "DigiLink_1:error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hv_lane1_error_count" "DigiLink_1:error_count_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:Q" "serialfifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderFIFO_0:RDCNT" "serialfifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReaderSM_0:use_lane" "use_lane" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DigiInterface
generate_component -component_name ${sd_name}
