# Creating SmartDesign ResetController
set sd_name {ResetController}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {SLOW_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SEL_RESET} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_DCSRESP} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_FWD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_PS_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_RM_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_CH_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_TS_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_40CLK_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_DCSRECV} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_RSP} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_RCV} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_RESET_N} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {SEL_RST_CNTL} -port_direction {IN} -port_range {[9:0]}

# Add MainResetController_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {MainResetController} -hdl_file {hdl\MainResetController_0.vhd} -instance_name {MainResetController_0}
sd_invert_pins -sd_name ${sd_name} -pin_names {MainResetController_0:RESET_RESP_FIFO_N}
sd_invert_pins -sd_name ${sd_name} -pin_names {MainResetController_0:RESET_RECV_FIFO_N}
sd_invert_pins -sd_name ${sd_name} -pin_names {MainResetController_0:RESET_DCSRCV_N}
sd_invert_pins -sd_name ${sd_name} -pin_names {MainResetController_0:RESET_DCSRESP_N}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"INIT_RESET_N" "MainResetController_0:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_40CLK_N" "MainResetController_0:RESET_40CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_CH_N" "MainResetController_0:RESET_CH_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_DCSRECV" "MainResetController_0:RESET_DCSRCV_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_DCSRESP" "MainResetController_0:RESET_DCSRESP_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_FWD_N" "MainResetController_0:RESET_FW_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_PS_N" "MainResetController_0:RESET_PS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_RCV" "MainResetController_0:RESET_RECV_FIFO_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_RM_N" "MainResetController_0:RESET_RM_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_RSP" "MainResetController_0:RESET_RESP_FIFO_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_TS_N" "MainResetController_0:RESET_TS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SEL_RESET" "MainResetController_0:SEL_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOW_CLK" "MainResetController_0:SLOW_CLK" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"MainResetController_0:SEL_RST_CNTL" "SEL_RST_CNTL" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign ResetController
generate_component -component_name ${sd_name}
