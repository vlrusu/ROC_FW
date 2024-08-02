# Creating SmartDesign DigiLink_Sim
set sd_name {DigiLink_Sim}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifoclk_resetn} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifoclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_sim_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_sim_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane2_sim_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane3_sim_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {pattern_init} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {pattern_type} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_sim_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_sim_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_sim_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_sim_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane2_sim_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane2_sim_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane3_sim_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane3_sim_full} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_in} -port_direction {IN} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hit_in} -port_direction {IN} -port_range {[9:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_sim_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_sim_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane2_sim_data} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane3_sim_data} -port_direction {OUT} -port_range {[31:0]}


# Add clus_pattern_sim_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {clus_pattern_sim} -hdl_file {hdl\clus_pattern_sim.v} -instance_name {clus_pattern_sim_0}



# Add ROCFIFO_SIM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO_SIM} -instance_name {ROCFIFO_SIM_0}



# Add ROCFIFO_SIM_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO_SIM} -instance_name {ROCFIFO_SIM_1}



# Add ROCFIFO_SIM_2 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO_SIM} -instance_name {ROCFIFO_SIM_2}



# Add ROCFIFO_SIM_3 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO_SIM} -instance_name {ROCFIFO_SIM_3}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:EMPTY" "lane0_sim_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:FULL" "lane0_sim_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:RCLOCK" "ROCFIFO_SIM_0:WCLOCK" "ROCFIFO_SIM_1:RCLOCK" "ROCFIFO_SIM_1:WCLOCK" "ROCFIFO_SIM_2:RCLOCK" "ROCFIFO_SIM_2:WCLOCK" "ROCFIFO_SIM_3:RCLOCK" "ROCFIFO_SIM_3:WCLOCK" "clus_pattern_sim_0:fifoclk" "fifoclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:RE" "lane0_sim_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:RRESET_N" "ROCFIFO_SIM_0:WRESET_N" "ROCFIFO_SIM_1:RRESET_N" "ROCFIFO_SIM_1:WRESET_N" "ROCFIFO_SIM_2:RRESET_N" "ROCFIFO_SIM_2:WRESET_N" "ROCFIFO_SIM_3:RRESET_N" "ROCFIFO_SIM_3:WRESET_N" "clus_pattern_sim_0:fifoclk_resetn" "fifoclk_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:WE" "ROCFIFO_SIM_1:WE" "ROCFIFO_SIM_2:WE" "ROCFIFO_SIM_3:WE" "clus_pattern_sim_0:pattern_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_1:EMPTY" "lane1_sim_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_1:FULL" "lane1_sim_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_1:RE" "lane1_sim_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_2:EMPTY" "lane2_sim_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_2:FULL" "lane2_sim_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_2:RE" "lane2_sim_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_3:EMPTY" "lane3_sim_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_3:FULL" "lane3_sim_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_3:RE" "lane3_sim_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_sim_0:pattern_init" "pattern_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_sim_0:pattern_type" "pattern_type" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:DATA" "ROCFIFO_SIM_1:DATA" "ROCFIFO_SIM_2:DATA" "ROCFIFO_SIM_3:DATA" "clus_pattern_sim_0:pattern_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_0:Q" "lane0_sim_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_1:Q" "lane1_sim_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_2:Q" "lane2_sim_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_SIM_3:Q" "lane3_sim_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_sim_0:ewtag_in" "ewtag_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"clus_pattern_sim_0:hit_in" "hit_in" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DigiLink_Sim
generate_component -component_name ${sd_name}
