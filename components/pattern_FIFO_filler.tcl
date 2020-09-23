# Creating SmartDesign pattern_FIFO_filler
set sd_name {pattern_FIFO_filler}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {pattern_init} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {digiclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {resetn} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EMPTY} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {pattern} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RDCNT} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {Q} -port_direction {OUT} -port_range {[31:0]}

# Add PATTERN_FIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PATTERN_FIFO} -instance_name {PATTERN_FIFO_0}



# Add pattern_FIFO_cntrl_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pattern_FIFO_cntrl} -hdl_file {hdl\pattern_FIFO_cntrl.v} -instance_name {pattern_FIFO_cntrl_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PATTERN_FIFO_0:WCLOCK" "PATTERN_FIFO_0:RCLOCK" "digiclk" "pattern_FIFO_cntrl_0:digiclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PATTERN_FIFO_0:EMPTY" "EMPTY" "pattern_FIFO_cntrl_0:pattern_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PATTERN_FIFO_0:RE" "fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PATTERN_FIFO_0:FULL" "FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PATTERN_FIFO_0:AFULL" "pattern_FIFO_cntrl_0:pattern_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PATTERN_FIFO_0:WE" "pattern_FIFO_cntrl_0:pattern_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_init" "pattern_FIFO_cntrl_0:pattern_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PATTERN_FIFO_0:RESET" "resetn" "pattern_FIFO_cntrl_0:resetn" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern" "pattern_FIFO_cntrl_0:pattern" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_cntrl_0:pattern_data" "PATTERN_FIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Q" "PATTERN_FIFO_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RDCNT" "PATTERN_FIFO_0:RDCNT" "pattern_FIFO_cntrl_0:pattern_rd_cnt" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign pattern_FIFO_filler
generate_component -component_name ${sd_name}
