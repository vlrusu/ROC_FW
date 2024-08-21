# Creating SmartDesign pattern_FIFO_filler
set sd_name {pattern_FIFO_filler}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {axi_start_on_serdesclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ddr_done} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {haltrun_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {newspill_reset} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {pattern_init} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {pattern_type} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {resetn_serdesclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdesclk} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {curr_ewfifo_wr} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_done} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_fifo_we} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_ovfl} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_in} -port_direction {IN} -port_range {[19:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {ew_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_size} -port_direction {OUT} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_tag} -port_direction {OUT} -port_range {[19:0]}


# Add clus_pattern_cntrl_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {clus_pattern_cntrl} -hdl_file {hdl\clus_pattern_cntrl.v} -instance_name {clus_pattern_cntrl_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {clus_pattern_cntrl_0:hit_over}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {clus_pattern_cntrl_0:hit_under}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {clus_pattern_cntrl_0:hit_error}



# Add hit_ram_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {hit_ram} -hdl_file {hdl\hit_ram.vhd} -instance_name {hit_ram_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {hit_ram_0:dataout} -pin_slices {[9:0]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hit_ram_0:we} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hit_ram_0:datain} -value {GND}



# Add rocfifo_cntrl_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {rocfifo_cntrl} -hdl_file {hdl\rocfifo_cntrl.v} -instance_name {rocfifo_cntrl_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {rocfifo_cntrl_0:rocfifo0_wrcnt} -pin_slices {[11:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {rocfifo_cntrl_0:rocfifo0_wrcnt} -pin_slices {[16:12]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {rocfifo_cntrl_0:rocfifo0_wrcnt[16:12]} -value {00000}



# Add SIM_ROC_FIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SIM_ROC_FIFO} -instance_name {SIM_ROC_FIFO_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:EMPTY" "rocfifo_cntrl_0:rocfifo0_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:FULL" "rocfifo_cntrl_0:rocfifo0_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:RCLOCK" "SIM_ROC_FIFO_0:WCLOCK" "clus_pattern_cntrl_0:serdesclk" "hit_ram_0:clock" "rocfifo_cntrl_0:serdesclk" "serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:RE" "rocfifo_cntrl_0:rocfifo0_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:RRESET_N" "SIM_ROC_FIFO_0:WRESET_N" "clus_pattern_cntrl_0:serdesclk_resetn" "resetn_serdesclk" "rocfifo_cntrl_0:resetn_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:WE" "clus_pattern_cntrl_0:pattern_we0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"axi_start_on_serdesclk" "rocfifo_cntrl_0:axi_start_on_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:ddr_done" "ddr_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:haltrun_en" "haltrun_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:hit_re" "hit_ram_0:re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:newspill_reset" "newspill_reset" "rocfifo_cntrl_0:newspill_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:pattern_init" "pattern_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:pattern_type" "pattern_type" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"curr_ewfifo_wr" "rocfifo_cntrl_0:curr_ewfifo_wr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_done" "rocfifo_cntrl_0:ew_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_fifo_we" "rocfifo_cntrl_0:ew_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_ovfl" "rocfifo_cntrl_0:ew_ovfl" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:DATA" "clus_pattern_cntrl_0:pattern_data0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:Q" "rocfifo_cntrl_0:rocfifo0_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_ROC_FIFO_0:WRCNT" "rocfifo_cntrl_0:rocfifo0_wrcnt[11:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:ewtag_in" "ewtag_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:hit_in" "hit_ram_0:dataout[9:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_cntrl_0:hit_rdaddr" "hit_ram_0:address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_data" "rocfifo_cntrl_0:ew_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size" "rocfifo_cntrl_0:ew_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_tag" "rocfifo_cntrl_0:ew_tag" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign pattern_FIFO_filler
generate_component -component_name ${sd_name}
