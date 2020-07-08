# Creating SmartDesign TVS_Interface
set sd_name {TVS_Interface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {resetn_i} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {R_CLK} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {R_ADDR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {R_DATA} -port_direction {OUT} -port_range {[15:0]}

# Add PF_TVS_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_TVS_C0} -instance_name {PF_TVS_C0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:TEMP_HIGH_CLEAR} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:TEMP_LOW_CLEAR} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:ENABLE_TEMP} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:TEMP_HIGH}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:TEMP_LOW}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:ACTIVE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:ENABLE_1V} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:ENABLE_18V} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_TVS_C0_0:ENABLE_25V} -value {VCC}



# Add PF_URAM_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_URAM_C0} -instance_name {PF_URAM_C0_0}



# Add TVS_Cntrl_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {TVS_Cntrl} -hdl_file {hdl\TVS_Cntrl.v} -instance_name {TVS_Cntrl_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_URAM_C0_0:W_CLK" "clk" "TVS_Cntrl_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_TVS_C0_0:VALID" "TVS_Cntrl_0:valid_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_URAM_C0_0:R_CLK" "R_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"resetn_i" "TVS_Cntrl_0:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_URAM_C0_0:W_EN" "TVS_Cntrl_0:w_en_o" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_TVS_C0_0:CHANNEL" "TVS_Cntrl_0:channel_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_TVS_C0_0:VALUE" "TVS_Cntrl_0:value_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"R_ADDR" "PF_URAM_C0_0:R_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"R_DATA" "PF_URAM_C0_0:R_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TVS_Cntrl_0:channel_o" "PF_URAM_C0_0:W_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TVS_Cntrl_0:value_o" "PF_URAM_C0_0:W_DATA" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TVS_Interface
generate_component -component_name ${sd_name}
