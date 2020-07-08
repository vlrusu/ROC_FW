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
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FULLSERIAL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EMPTYSERIAL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESERIAL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RCLOCKSERIAL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RCLOCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REDAQ} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REDDR} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FULLDDR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EMPTYDDR} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {howmany} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RDCNTSERIAL} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {QSERIAL} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_aligned} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RDCNT} -port_direction {OUT} -port_range {[10:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {Q} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RDCNTDDR} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {QDDR} -port_direction {OUT} -port_range {[31:0]}

sd_create_pin_slices -sd_name ${sd_name} -pin_name {serdes_aligned} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {serdes_aligned} -pin_slices {[1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {serdes_aligned} -pin_slices {[2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {serdes_aligned} -pin_slices {[3]}
# Add DAQFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DAQFIFO} -instance_name {DAQFIFO_0}



# Add DIGIFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DIGIFIFO} -instance_name {DIGIFIFO_0}



# Add DIGIFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DIGIFIFO} -instance_name {DIGIFIFO_1}



# Add DIGISERDES_Controller_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DIGISERDES_Controller} -hdl_file {hdl\DIGISERDES_Controller.vhd} -instance_name {DIGISERDES_Controller_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_ready} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_ready} -pin_slices {[1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_ready} -pin_slices {[2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_ready} -pin_slices {[3]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_re} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_re} -pin_slices {[1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_re} -pin_slices {[2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DIGISERDES_Controller_0:fifo_re} -pin_slices {[3]}



# Add serdes_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {serdes} -instance_name {serdes_0}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {serdes_0} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {serdes_0} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_0:FULL0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_0:EMPTY0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_0:EMPTY1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_0:FULL1}



# Add serdes_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {serdes} -instance_name {serdes_1}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {serdes_1} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {serdes_1} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_1:FULL0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_1:EMPTY0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_1:EMPTY1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {serdes_1:FULL1}



# Add serdesmux_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {serdesmux} -hdl_file {hdl\serdesmux.vhd} -instance_name {serdesmux_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {serdesmux_0:y} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {serdesmux_0:y} -pin_slices {[31:16]}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:WCLOCK" "DIGISERDES_Controller_0:clk" "serdes_0:RCLOCK" "serdes_1:RCLOCK" "DAQFIFO_0:WCLOCK" "DIGIFIFO_0:WCLOCK" "clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_re[0]" "serdes_1:RE0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_re[1]" "serdes_1:RE1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_re[2]" "serdes_0:RE0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_re[3]" "serdes_0:RE1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:WE" "DIGISERDES_Controller_0:outfifo_we" "DAQFIFO_0:WE" "DIGIFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFIFO_0:EMPTY" "EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:EMPTY" "EMPTYDDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_0:EMPTY" "EMPTYSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFIFO_0:FULL" "FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:FULL" "FULLDDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_0:FULL" "FULLSERIAL" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFIFO_0:RCLOCK" "RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:RCLOCK" "DIGIFIFO_0:RCLOCK" "RCLOCKSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFIFO_0:RE" "REDAQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:RE" "REDDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:REF_CLK_PAD_N" "REF_CLK_PAD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:REF_CLK_PAD_P" "REF_CLK_PAD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_0:RE" "RESERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:RESET" "DIGISERDES_Controller_0:reset_n" "serdes_0:RRESET" "serdes_1:RRESET" "DAQFIFO_0:RESET" "DIGIFIFO_0:RESET" "RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_ready[2]" "serdes_0:fifo_ready0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_ready[3]" "serdes_0:fifo_ready1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_ready[0]" "serdes_1:fifo_ready0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:fifo_ready[1]" "serdes_1:fifo_ready1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:serdes_aligned" "serdes_aligned[2]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:serdes_aligned" "serdes_aligned[0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_0:serdes_aligned_0" "serdes_aligned[1]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:serdes_aligned_0" "serdes_aligned[3]" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdesmux_0:sel" "DIGISERDES_Controller_0:fifo_select" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGISERDES_Controller_0:howmany" "serdes_0:howmany" "serdes_1:howmany" "howmany" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFIFO_0:Q" "Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:Q" "QDDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_0:Q" "QSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFIFO_0:RDCNT" "RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_1:RDCNT" "RDCNTDDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_0:RDCNT" "RDCNTSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdesmux_0:d2" "serdes_0:Q0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdesmux_0:d3" "serdes_0:Q1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdesmux_0:d0" "serdes_1:Q0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_1:Q1" "serdesmux_0:d1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdesmux_0:y" "DIGIFIFO_0:DATA" "DIGIFIFO_1:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdesmux_0:y[15:0]" "DAQFIFO_0:DATA" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DIGIINTERFACE
generate_component -component_name ${sd_name}
