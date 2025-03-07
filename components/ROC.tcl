# Creating SmartDesign ROC
set sd_name {ROC}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISDI} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD0_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD0_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD1_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD1_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DI} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_LVTTL0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FLASH} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISDI} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD0_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD0_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD1_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD1_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {IFACE} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO1} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO4} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CLK_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CLK_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_DTC_SERDES_RXD0_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_DTC_SERDES_RXD0_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI0_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI1_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_CLK0_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_CLK0_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoDTC_SERDES_CLK_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoDTC_SERDES_CLK_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_CLK0_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_CLK0_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TDI} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TMS} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TRSTB} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rs485_rx} -port_direction {IN}


sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISCLKO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISS} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_MARKER} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_ACTn} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_ADDR14} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_ADDR15} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_ADDR16} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_BG0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_CKE0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_CLK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_CLK0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_CS0N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_ODT0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR4_RESETn} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DO} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISCLKO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISS} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_MARKER} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_FCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO2} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO3} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO5} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_DEVRSTn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_LVDS0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_LVDS0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_LVDS1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_LVDS1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_DTC_SERDES_TXD0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_DTC_SERDES_TXD0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_DEVRSTn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_LVDS0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_LVDS0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_LVDS1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_LVDS1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_LED0_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SC_GOLDENn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI0_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI0_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI0_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI0_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI0_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI1_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI1_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI1_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI1_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_SPI1_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_CLK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_CLK0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_LVTTL0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_LVTTL1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_LVTTL3} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_CLK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_CLK0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_LVTTL0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_LVTTL2} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_LVTTL3} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD1} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD2} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD3} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rs485_tx_enable} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rs485_tx} -port_direction {OUT}


sd_create_scalar_port -sd_name ${sd_name} -port_name {CLK} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MOSI} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_LVTTL2} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_LVTTL1} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SS} -port_direction {INOUT} -port_is_pad {1}

# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_ADDR} -port_direction {OUT} -port_range {[13:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_BA} -port_direction {OUT} -port_range {[1:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQM} -port_direction {OUT} -port_range {[3:0]} -port_is_pad {1}

sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQS_N} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQS_P} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQ} -port_direction {INOUT} -port_range {[31:0]} -port_is_pad {1}

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND2_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_3}



# Add AND3_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND3} -instance_name {AND3_0}



# Add AND3_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND3} -instance_name {AND3_1}



# Add Blinking_LED_driver_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {Blinking_LED_driver} -hdl_file {hdl\Blinking_LED_driver.vhd} -instance_name {Blinking_LED_driver_0}



# Add CLKINT_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {CLKINT} -instance_name {CLKINT_0}



# Add COREJTAGDEBUG_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {COREJTAGDEBUG_C0} -instance_name {COREJTAGDEBUG_C0_0}



# Add CORERESET_2_LOCK_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {CORERESET_2_LOCK_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_0:FABRIC_RESET_N}



# Add CORERESET_2_LOCK_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {CORERESET_2_LOCK_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_1:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_1:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_1:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_1:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_2_LOCK_1:FABRIC_RESET_N}



# Add counter_16bit_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter_16bit} -hdl_file {hdl\counter_16bit.v} -instance_name {counter_16bit_0}



# Add DFN1_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_0}



# Add DigiClkReset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {DigiClkReset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DigiClkReset_0:PLL_POWERDOWN_B}



# Add DigiFIFOReset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {DigiFIFOReset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:PLL_POWERDOWN_B}



# Add DigiInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiInterface} -instance_name {DigiInterface_0}



# Add DigiReset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {DigiReset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiReset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiReset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiReset_0:FF_US_RESTORE} -value {GND}



# Add EWMaker_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {EWMaker} -hdl_file {hdl\EWMaker.vhd} -instance_name {EWMaker_0}



# Add INBUF_DIFF_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INBUF_DIFF} -instance_name {INBUF_DIFF_0}



# Add INIT_component_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {INIT_component} -instance_name {INIT_component_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:PCIE_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:USRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:SRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:USRAM_INIT_FROM_SNVM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:USRAM_INIT_FROM_UPROM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:USRAM_INIT_FROM_SPI_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:SRAM_INIT_FROM_SNVM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:SRAM_INIT_FROM_UPROM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:SRAM_INIT_FROM_SPI_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {INIT_component_0:AUTOCALIB_DONE}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add INV_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_3}



# Add MIV_RV32IMC_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MIV_RV32IMC_C0} -instance_name {MIV_RV32IMC_C0_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[0:0]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[0:0]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[1:1]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[1:1]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[2:2]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[2:2]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[3:3]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[3:3]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[4:4]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[4:4]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[5:5]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[5:5]} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:JTAG_TDO_DR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_RESETN}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_IRQ} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:TIME_COUNT_OUT}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add NewDDRInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {NewDDRInterface} -instance_name {NewDDRInterface_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {NewDDRInterface_0:start_fetch_cnt} -pin_slices {[15:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {NewDDRInterface_0:et_fifo_full}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {NewDDRInterface_0:ew_DDR_wrap}



# Add OR2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_0}



# Add OUTBUF_DIFF_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_0}



# Add OUTBUF_DIFF_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_1}



# Add OUTBUF_DIFF_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_2}



# Add OUTBUF_DIFF_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_3}



# Add OUTBUF_DIFF_4 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_4}



# Add OUTBUF_DIFF_4_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_4_0}



# Add OUTBUF_DIFF_5 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_5}



# Add OUTBUF_DIFF_6 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_6}



# Add OUTBUF_DIFF_7 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_7}



# Add OUTBUF_DIFF_8 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_8}



# Add PF_CCC_111_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_CCC_111} -instance_name {PF_CCC_111_0}



# Add PF_CCC_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_CCC_C0} -instance_name {PF_CCC_C0_0}



# Add PF_CCC_C1_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_CCC_C1} -instance_name {PF_CCC_C1_0}



# Add PF_CLK_DIV_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_CLK_DIV_C0} -instance_name {PF_CLK_DIV_C0_0}



# Add PF_NGMUX_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_NGMUX_C0} -instance_name {PF_NGMUX_C0_0}



# Add PF_OSC_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_OSC_0} -instance_name {PF_OSC_0_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_OSC_0_0:RCOSC_160MHZ_GL}



# Add PF_SRAM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_SRAM} -instance_name {PF_SRAM_0}



# Add pulse_stretcher_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_0:polarity_i} -value {GND}



# Add pulse_stretcher_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_1:polarity_i} -value {VCC}



# Add Reset50MHz instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {Reset50MHz}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Reset50MHz:PLL_POWERDOWN_B}



# Add SLOWCONTROLS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SLOWCONTROLS} -instance_name {SLOWCONTROLS_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:GPIO_OUT} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:GPIO_OUT} -pin_slices {[3:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:GPIO_OUT[3:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SENSOR_MCP_CEn}



# Add TOP_SERDES_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TOP_SERDES} -instance_name {TOP_SERDES_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:FETCH_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:HEARTBEAT_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:PREFETCH_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:SPILL_EVENT_WINDOW_TAG} -pin_slices {[19:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:SPILL_EVENT_WINDOW_TAG} -pin_slices {[39:20]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DCS_DLYD_EVM_EN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PCS_ALIGNED}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DCS_TAG_OFFSET}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "INV_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "SLOWCONTROLS_0:reset_fifo_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "DigiFIFOReset_0:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:A" "INIT_component_0:XCVR_INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:B" "SLOWCONTROLS_0:dtc_serdes_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:Y" "DigiInterface_0:CTRL_ARST_N" "TOP_SERDES_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:A" "INIT_component_0:BANK_0_CALIB_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:B" "INIT_component_0:BANK_1_CALIB_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:C" "CORERESET_2_LOCK_0:INIT_DONE" "CORERESET_2_LOCK_1:INIT_DONE" "DigiClkReset_0:INIT_DONE" "DigiFIFOReset_0:INIT_DONE" "DigiInterface_0:INIT_DONE" "DigiReset_0:INIT_DONE" "INIT_component_0:DEVICE_INIT_DONE" "NewDDRInterface_0:INIT_DONE" "Reset50MHz:INIT_DONE" "TOP_SERDES_0:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:Y" "NewDDRInterface_0:DDR_BANK_CALIB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:A" "Blinking_LED_driver_0:RESETN" "MIV_RV32IMC_C0_0:RESETN" "PF_SRAM_0:HRESETN" "Reset50MHz:FABRIC_RESET_N" "SLOWCONTROLS_0:PRESETN" "TOP_SERDES_0:HRESETN" "pulse_stretcher_0:resetn_i" "pulse_stretcher_1:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:B" "pulse_stretcher_0:ngate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:C" "pulse_stretcher_1:ngate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:Y" "DigiInterface_0:EXT_RST_N" "NewDDRInterface_0:EXT_RST_N" "SLOWCONTROLS_0:EXT_RST_N" "TOP_SERDES_0:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Blinking_LED_driver_0:CLK" "DigiInterface_0:serialfifo_rclk" "MIV_RV32IMC_C0_0:CLK" "PF_CCC_C0_0:OUT3_FABCLK_0" "PF_SRAM_0:HCLK" "Reset50MHz:CLK" "SLOWCONTROLS_0:PCLK" "pulse_stretcher_0:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Blinking_LED_driver_0:LED_OFF" "OR2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Blinking_LED_driver_0:SIGIN" "TOP_SERDES_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Blinking_LED_driver_0:SIGOUT" "ROC_SC_GOLDENn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISCLKO" "SLOWCONTROLS_0:CALPROGSPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISDI" "SLOWCONTROLS_0:CALPROGSPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISDO" "SLOWCONTROLS_0:CALPROGSPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISS" "SLOWCONTROLS_0:CALPROGSPISS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_N" "OUTBUF_DIFF_6:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_P" "OUTBUF_DIFF_6:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_N" "OUTBUF_DIFF_5:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_P" "OUTBUF_DIFF_5:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_MARKER" "HV_MARKER" "TOP_SERDES_0:TAG_SYNC" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE0n" "SLOWCONTROLS_0:CAL_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE1n" "SLOWCONTROLS_0:CAL_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MISO" "SLOWCONTROLS_0:CAL_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MOSI" "SLOWCONTROLS_0:CAL_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_SCLK" "SLOWCONTROLS_0:CAL_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD0_N" "DigiInterface_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD0_P" "DigiInterface_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD1_N" "DigiInterface_0:LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD1_P" "DigiInterface_0:LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLK" "SLOWCONTROLS_0:CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLKINT_0:A" "INBUF_DIFF_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLKINT_0:Y" "PF_CCC_111_0:REF_CLK_0" "PF_CCC_C0_0:REF_CLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TCK" "TCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TDI" "TDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TDO" "TDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TGT_TCK_0" "MIV_RV32IMC_C0_0:JTAG_TCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TGT_TDI_0" "MIV_RV32IMC_C0_0:JTAG_TDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TGT_TDO_0" "MIV_RV32IMC_C0_0:JTAG_TDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TGT_TMS_0" "MIV_RV32IMC_C0_0:JTAG_TMS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TGT_TRST_0" "MIV_RV32IMC_C0_0:JTAG_TRST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TMS" "TMS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TRSTB" "TRSTB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:BANK_y_VDDI_STATUS" "CORERESET_2_LOCK_1:BANK_y_VDDI_STATUS" "DigiClkReset_0:BANK_y_VDDI_STATUS" "DigiFIFOReset_0:BANK_y_VDDI_STATUS" "DigiReset_0:BANK_y_VDDI_STATUS" "INIT_component_0:BANK_2_VDDI_STATUS" "Reset50MHz:BANK_y_VDDI_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:CLK" "PF_CCC_C0_0:OUT0_FABCLK_0" "PF_NGMUX_C0_0:CLK0" "SLOWCONTROLS_0:DCS_CLK" "TOP_SERDES_0:DCS_CLK" "pulse_stretcher_1:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:FPGA_POR_N" "CORERESET_2_LOCK_1:FPGA_POR_N" "DigiClkReset_0:FPGA_POR_N" "DigiFIFOReset_0:FPGA_POR_N" "DigiInterface_0:FPGA_POR_N" "DigiReset_0:FPGA_POR_N" "INIT_component_0:FABRIC_POR_N" "NewDDRInterface_0:FPGA_POR_N" "Reset50MHz:FPGA_POR_N" "TOP_SERDES_0:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:PLL_LOCK" "DigiFIFOReset_0:PLL_LOCK" "PF_CCC_C0_0:PLL_LOCK_0" "Reset50MHz:PLL_LOCK" "TOP_SERDES_0:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:PLL_POWERDOWN_B" "PF_CCC_C0_0:PLL_POWERDOWN_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_1:CLK" "PF_CCC_111_0:OUT0_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_1:PLL_LOCK" "PF_CCC_111_0:PLL_LOCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_1:PLL_POWERDOWN_B" "PF_CCC_111_0:PLL_POWERDOWN_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_ACTn" "NewDDRInterface_0:ACT_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_ADDR14" "NewDDRInterface_0:WE_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_ADDR15" "NewDDRInterface_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_ADDR16" "NewDDRInterface_0:RAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_BG0" "NewDDRInterface_0:BG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_CKE0" "NewDDRInterface_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_CLK0_N" "NewDDRInterface_0:CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_CLK0_P" "NewDDRInterface_0:CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_CS0N" "NewDDRInterface_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_ODT0" "NewDDRInterface_0:ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_RESETn" "NewDDRInterface_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0:CLK" "DigiClkReset_0:CLK" "DigiReset_0:CLK" "EWMaker_0:digi_clk" "OUTBUF_DIFF_1:D" "OUTBUF_DIFF_3:D" "PF_CCC_C1_0:OUT0_FABCLK_0" "counter_16bit_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0:D" "MX2_0:Y" "counter_16bit_0:en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0:Q" "OUTBUF_DIFF_0:D" "OUTBUF_DIFF_2:D" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DI" "SLOWCONTROLS_0:DI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DO" "SLOWCONTROLS_0:DO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiClkReset_0:FABRIC_RESET_N" "EWMaker_0:digi_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiClkReset_0:PLL_LOCK" "DigiReset_0:PLL_LOCK" "PF_CCC_C1_0:PLL_LOCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:CLK" "DigiInterface_0:fifo_rclk" "NewDDRInterface_0:serdesclk" "PF_CCC_C0_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:FABRIC_RESET_N" "DigiInterface_0:fifo_resetn" "counter_16bit_0:rst_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:CTRL_CLK" "PF_CLK_DIV_C0_0:CLK_OUT" "TOP_SERDES_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PCS_ARST_N" "SLOWCONTROLS_0:cal_lane0_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PCS_ARST_N_0" "SLOWCONTROLS_0:hv_lane0_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PMA_ARST_N" "SLOWCONTROLS_0:cal_lane0_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PMA_ARST_N_0" "SLOWCONTROLS_0:hv_lane0_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_RXD_N_0" "HVtoROC_SERDES_TXD0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_RXD_P_0" "HVtoROC_SERDES_TXD0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_N" "ROCtoCAL_SERDES_TXD0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_N_0" "ROCtoHV_SERDES_TXD0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_P" "ROCtoCAL_SERDES_TXD0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_P_0" "ROCtoHV_SERDES_TXD0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PCS_ARST_N" "SLOWCONTROLS_0:cal_lane1_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PCS_ARST_N_0" "SLOWCONTROLS_0:hv_lane1_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PMA_ARST_N" "SLOWCONTROLS_0:cal_lane1_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PMA_ARST_N_0" "SLOWCONTROLS_0:hv_lane1_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_RXD_N_0" "HVtoROC_SERDES_TXD1_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_RXD_P_0" "HVtoROC_SERDES_TXD1_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_N" "ROCtoCAL_SERDES_TXD1_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_N_0" "ROCtoHV_SERDES_TXD1_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_P" "ROCtoCAL_SERDES_TXD1_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_P_0" "ROCtoHV_SERDES_TXD1_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_N" "ROCtoHV_SERDES_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_N_0" "ROCtoCAL_SERDES_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_P" "ROCtoHV_SERDES_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_P_0" "ROCtoCAL_SERDES_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:align" "SLOWCONTROLS_0:align_roc_to_digi" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:axi_start_on_serdesclk" "NewDDRInterface_0:axi_start_on_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_aligned" "SLOWCONTROLS_0:cal_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_aligned" "SLOWCONTROLS_0:cal_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:curr_ewfifo_wr" "NewDDRInterface_0:DIGI_curr_ewfifo_wr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:en_digi_sim" "TOP_SERDES_0:DCS_DIGI_SIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_done" "NewDDRInterface_0:DIGI_ew_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_fifo_full" "NewDDRInterface_0:ew_fifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_fifo_we" "NewDDRInterface_0:DIGI_ew_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_ovfl" "NewDDRInterface_0:DIGI_ew_ovfl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_tag_error" "NewDDRInterface_0:DIGI_ew_tag_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:force_full" "SLOWCONTROLS_0:force_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:haltrun_en" "NewDDRInterface_0:haltrun_en" "TOP_SERDES_0:HALTRUN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_aligned" "SLOWCONTROLS_0:hv_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_aligned" "SLOWCONTROLS_0:hv_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:newrun" "NewDDRInterface_0:NEWRUN" "TOP_SERDES_0:NEWRUN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:pattern_init" "NewDDRInterface_0:pattern_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:pattern_type" "NewDDRInterface_0:pattern_type" "TOP_SERDES_0:DCS_PATTERN_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_empty" "SLOWCONTROLS_0:SERDES_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_full" "SLOWCONTROLS_0:SERDES_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_re" "SLOWCONTROLS_0:SERDES_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:tag_sync_error" "NewDDRInterface_0:DIGI_tag_sync_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:use_uart" "SLOWCONTROLS_0:use_uart" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReset_0:EXT_RST_N" "SLOWCONTROLS_0:DIGIDEVICE_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReset_0:FABRIC_RESET_N" "ROC_CAL_DEVRSTn" "ROC_HV_DEVRSTn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReset_0:PLL_POWERDOWN_B" "PF_CCC_C1_0:PLL_POWERDOWN_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm" "MX2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm_enable_50mhz" "SLOWCONTROLS_0:ewm_enable_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:external_ewm_50mhz" "SLOWCONTROLS_0:ewm_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EXT_LVTTL0" "OUTBUF_DIFF_7:D" "OUTBUF_DIFF_8:D" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FLASH" "SLOWCONTROLS_0:FLASH" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HVPROGSPISCLKO" "SLOWCONTROLS_0:HVPROGSPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HVPROGSPISDI" "SLOWCONTROLS_0:HVPROGSPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HVPROGSPISDO" "SLOWCONTROLS_0:HVPROGSPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HVPROGSPISS" "SLOWCONTROLS_0:HVPROGSPISS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE0n" "SLOWCONTROLS_0:HV_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE1n" "SLOWCONTROLS_0:HV_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_FCLK" "SLOWCONTROLS_0:HV_PREAMP_FCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MISO" "SLOWCONTROLS_0:HV_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MOSI" "SLOWCONTROLS_0:HV_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_SCLK" "SLOWCONTROLS_0:HV_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IFACE" "SLOWCONTROLS_0:IFACE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:PADN" "ROC_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:PADP" "ROC_CLK_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:A" "TOP_SERDES_0:DCS_RESETFIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_3:A" "TOP_SERDES_0:ONSPILL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_3:Y" "ROCtoCAL_LVTTL3" "ROCtoHV_LVTTL3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO0" "SLOWCONTROLS_0:TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO1" "SLOWCONTROLS_0:RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO2" "SLOWCONTROLS_0:SPI2_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO3" "SLOWCONTROLS_0:SPI2_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO4" "SLOWCONTROLS_0:SPI2_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO5" "SLOWCONTROLS_0:SPI2_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:B" "TOP_SERDES_0:EWM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:S" "SLOWCONTROLS_0:enable_fiber_marker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:CTRLR_READY" "SLOWCONTROLS_0:DDRCTRLREADY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:DCS_pattern_en" "TOP_SERDES_0:DCS_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:DREQ_FIFO_EMPTY" "TOP_SERDES_0:DCS_DREQ_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:DREQ_FIFO_FULL" "TOP_SERDES_0:DCS_DREQ_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:MEM_CLK" "PF_CCC_111_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:RXCLK_RESETN" "TOP_SERDES_0:RXCLK_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:RX_CLK" "PF_NGMUX_C0_0:CLK1" "TOP_SERDES_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD0" "SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD1" "SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD2" "SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD3" "SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:data_ready" "TOP_SERDES_0:DATAREQ_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:dreqclk" "PF_CCC_C0_0:OUT2_FABCLK_0" "TOP_SERDES_0:DREQ_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:end_evm_seen" "TOP_SERDES_0:END_EVM_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_fifo_re" "TOP_SERDES_0:DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_pckts_err" "TOP_SERDES_0:DATAREQ_TAG_ERROR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_pckts_ovfl" "TOP_SERDES_0:DATAREQ_PACKETS_OVFL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:event_start" "TOP_SERDES_0:DATAREQ_START_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:first_hb_seen" "TOP_SERDES_0:FIRST_HB_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_seen" "TOP_SERDES_0:HEARTBEAT_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:last_word" "TOP_SERDES_0:DATAREQ_LAST_WORD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:start_fetch" "TOP_SERDES_0:FETCH_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_0:A" "TOP_SERDES_0:DCS_LED_OFF" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_0:B" "SLOWCONTROLS_0:led_off" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:PADN" "ROC_HV_LVDS0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:PADP" "ROC_HV_LVDS0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_1:PADN" "ROCtoCAL_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_1:PADP" "ROCtoCAL_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:PADN" "ROC_CAL_LVDS0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:PADP" "ROC_CAL_LVDS0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_3:PADN" "ROCtoHV_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_3:PADP" "ROCtoHV_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:D" "OUTBUF_DIFF_4_0:D" "PF_CCC_111_0:OUT2_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:PADN" "ROC_ACCEL_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:PADP" "ROC_ACCEL_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4_0:PADN" "ROC_ACCEL_CLK1_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4_0:PADP" "ROC_ACCEL_CLK1_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_5:D" "OUTBUF_DIFF_6:D" "SLOWCONTROLS_0:PWM0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_7:PADN" "ROC_CAL_LVDS1_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_7:PADP" "ROC_CAL_LVDS1_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_8:PADN" "ROC_HV_LVDS1_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_8:PADP" "ROC_HV_LVDS1_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CCC_C1_0:REF_CLK_0" "PF_NGMUX_C0_0:CLK_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CLK_DIV_C0_0:CLK_IN" "PF_OSC_0_0:RCOSC_160MHZ_CLK_DIV" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_NGMUX_C0_0:SEL" "SLOWCONTROLS_0:enable_fiber_clock" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_DTC_SERDES_RXD0_N" "TOP_SERDES_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_DTC_SERDES_RXD0_P" "TOP_SERDES_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_DTC_SERDES_TXD0_N" "TOP_SERDES_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_DTC_SERDES_TXD0_P" "TOP_SERDES_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_LED0_n" "SLOWCONTROLS_0:GPIO_OUT[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI0_ADC0_CEn" "SLOWCONTROLS_0:SPI0_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI0_ADC1_CEn" "SLOWCONTROLS_0:SPI0_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI0_ADC2_CEn" "SLOWCONTROLS_0:SPI0_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI0_MISO" "SLOWCONTROLS_0:SPI0_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI0_MOSI" "SLOWCONTROLS_0:SPI0_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI0_SCLK" "SLOWCONTROLS_0:SPI0_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI1_ADC0_CEn" "SLOWCONTROLS_0:SPI1_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI1_ADC1_CEn" "SLOWCONTROLS_0:SPI1_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI1_ADC2_CEn" "SLOWCONTROLS_0:SPI1_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI1_MISO" "SLOWCONTROLS_0:SPI1_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI1_MOSI" "SLOWCONTROLS_0:SPI1_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_SPI1_SCLK" "SLOWCONTROLS_0:SPI1_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoCAL_LVTTL0" "ROCtoHV_LVTTL2" "TOP_SERDES_0:LAST_EWM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoCAL_LVTTL1" "SLOWCONTROLS_0:calscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoCAL_LVTTL2" "SLOWCONTROLS_0:calsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoDTC_SERDES_CLK_N" "TOP_SERDES_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoDTC_SERDES_CLK_P" "TOP_SERDES_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoHV_LVTTL0" "SLOWCONTROLS_0:hvscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoHV_LVTTL1" "SLOWCONTROLS_0:hvsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:CMD_IN_WE" "TOP_SERDES_0:CMD_IN_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_RX_EMPTY" "TOP_SERDES_0:DCS_RX_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_RX_FULL" "TOP_SERDES_0:DCS_RX_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_TX_EMPTY" "TOP_SERDES_0:DCS_TX_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_TX_FULL" "TOP_SERDES_0:DCS_TX_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_TX_RE" "TOP_SERDES_0:DCS_TX_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDR_RESETN" "pulse_stretcher_0:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCALIGN_RESETN" "TOP_SERDES_0:DTCALIGN_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PRBS_EN" "TOP_SERDES_0:PRBS_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PRBS_ERRORCLR" "TOP_SERDES_0:ERROR_CLEAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PRBS_ERROROUT" "TOP_SERDES_0:ERROR_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PRBS_LOCK" "TOP_SERDES_0:PRBS_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PRBS_ON" "TOP_SERDES_0:PRBS_ON" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SS" "SS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_cal_busy" "TOP_SERDES_0:dcs_cal_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_cal_init" "TOP_SERDES_0:dcs_cal_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_digirw_sel" "TOP_SERDES_0:dcs_digirw_sel" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_enable_fiber_clock" "TOP_SERDES_0:DCS_ENABLE_CLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_enable_fiber_marker" "TOP_SERDES_0:DCS_ENABLE_MARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_ewm_enable_50mhz" "TOP_SERDES_0:DCS_INT_EVM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_force_full" "TOP_SERDES_0:DCS_FORCE_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_hv_busy" "TOP_SERDES_0:dcs_hv_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_hv_init" "TOP_SERDES_0:dcs_hv_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dtc_enable_reset" "TOP_SERDES_0:ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:DCS_DDRRESET" "pulse_stretcher_1:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:rs485_rx" "rs485_rx" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:rs485_tx" "rs485_tx" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:rs485_tx_enable" "rs485_tx_enable" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_ADDR" "NewDDRInterface_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_BA" "NewDDRInterface_0:BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQ" "NewDDRInterface_0:DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQM" "NewDDRInterface_0:DM_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQS_N" "NewDDRInterface_0:DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQS_P" "NewDDRInterface_0:DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE_EMPTY" "TOP_SERDES_0:DCS_LANE_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE_FULL" "TOP_SERDES_0:DCS_LANE_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE_SIM_EMPTY" "TOP_SERDES_0:DCS_SIM_LANE_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE_SIM_FULL" "TOP_SERDES_0:DCS_SIM_LANE_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_alignment" "SLOWCONTROLS_0:cal_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_error_count" "SLOWCONTROLS_0:cal_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_alignment" "SLOWCONTROLS_0:cal_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_error_count" "SLOWCONTROLS_0:cal_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_done_cnt" "TOP_SERDES_0:ew_done_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_fifo_data" "NewDDRInterface_0:DIGI_ew_fifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_size" "NewDDRInterface_0:DIGI_ew_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_tag" "NewDDRInterface_0:DIGI_ew_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ewtag_in" "NewDDRInterface_0:spill_ewtag_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hit_in" "TOP_SERDES_0:DCS_SIM_HIT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_alignment" "SLOWCONTROLS_0:hv_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_error_count" "SLOWCONTROLS_0:hv_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_alignment" "SLOWCONTROLS_0:hv_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_error_count" "SLOWCONTROLS_0:hv_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:lane_empty_seen" "TOP_SERDES_0:LANE_EMPTY_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:rocfifocntrl_state" "TOP_SERDES_0:rocfifocntrl_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_data" "SLOWCONTROLS_0:SERDES_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_rdcnt" "SLOWCONTROLS_0:SERDES_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:tag_sync_err_cnt" "TOP_SERDES_0:tag_sync_err_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:use_lane" "SLOWCONTROLS_0:use_lane" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm_period_5ns" "SLOWCONTROLS_0:ewm_delay" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:DDR_error_mask" "TOP_SERDES_0:DDR_ERROR_MASK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:data_expc" "TOP_SERDES_0:data_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:data_seen" "TOP_SERDES_0:data_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:datareq_state" "TOP_SERDES_0:datareq_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:dreq_cnt" "TOP_SERDES_0:DCS_DREQCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:dreq_full_count" "TOP_SERDES_0:dreq_full_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:dreq_tag" "TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_fifo_rdata" "TOP_SERDES_0:DATAREQ_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_pckts" "TOP_SERDES_0:DATAREQ_PACKETS_IN_EVT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:event_window_fetch" "TOP_SERDES_0:FETCH_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:evm_end_cnt" "TOP_SERDES_0:DCS_EVMCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:evt_expc" "TOP_SERDES_0:evt_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:evt_seen" "TOP_SERDES_0:evt_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:ew_fifo_emptied_count" "TOP_SERDES_0:ew_fifo_emptied_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:ewtag_dreq_full" "TOP_SERDES_0:DCS_FULLTAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:ewtag_offset_out" "TOP_SERDES_0:DCS_OFFSETTAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:ewtag_state" "TOP_SERDES_0:ewtag_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_cnt" "TOP_SERDES_0:DCS_FETCH_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_event_tag" "TOP_SERDES_0:fetch_event_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_missing_TAG" "TOP_SERDES_0:fetch_missing_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_missing_cnt" "TOP_SERDES_0:fetch_missing_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_pos_cnt" "TOP_SERDES_0:DCS_FETCH_POS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_runover_TAG" "TOP_SERDES_0:fetch_runover_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_runover_cnt" "TOP_SERDES_0:fetch_runover_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_state_cnt" "TOP_SERDES_0:fetch_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_timeout_cnt" "TOP_SERDES_0:fetch_timeout_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_cnt_onhold" "TOP_SERDES_0:DCS_HBONHOLD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_dreq_error_cnt" "TOP_SERDES_0:hb_dreq_err_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_empty_overlap_count" "TOP_SERDES_0:hb_empty_overlap_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_event_window" "TOP_SERDES_0:HEARTBEAT_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_tag_err_cnt" "TOP_SERDES_0:hb_tag_err_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_tag_full_count" "TOP_SERDES_0:hb_tag_full_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr1_expc" "TOP_SERDES_0:hdr1_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr1_seen" "TOP_SERDES_0:hdr1_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr2_expc" "TOP_SERDES_0:hdr2_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr2_seen" "TOP_SERDES_0:hdr2_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:next_read_event_tag" "TOP_SERDES_0:next_read_event_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:skipped_DREQ_cnt" "TOP_SERDES_0:skipped_DREQ_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:skipped_DREQ_tag" "TOP_SERDES_0:skipped_DREQ_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:spill_hbtag_in" "TOP_SERDES_0:SPILL_EVENT_WINDOW_TAG[19:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:spill_hbtag_rollover" "TOP_SERDES_0:SPILL_EVENT_WINDOW_TAG[39:20]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:spilltag_full_count" "TOP_SERDES_0:spilltag_full_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:start_fetch_cnt[15:0]" "TOP_SERDES_0:start_fetch_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:store_cnt" "TOP_SERDES_0:DCS_STORE_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:store_pos_cnt" "TOP_SERDES_0:DCS_STORE_POS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_done_cnt" "TOP_SERDES_0:DCS_DREQSENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_error_count" "TOP_SERDES_0:tag_error_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_expc" "TOP_SERDES_0:tag_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_null_cnt" "TOP_SERDES_0:DCS_DREQNULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_seen" "TOP_SERDES_0:tag_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_sent_cnt" "TOP_SERDES_0:DCS_DREQREAD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_valid_count" "TOP_SERDES_0:tag_valid_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:CMD_IN_DATA" "TOP_SERDES_0:CMD_IN_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_CMD_STATUS" "TOP_SERDES_0:DCS_CMD_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_DIAG_DATA" "TOP_SERDES_0:DCS_DIAG_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_RX_WRCNT" "TOP_SERDES_0:DCS_RX_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_TO_SERIAL_TEST" "TOP_SERDES_0:DCS_TO_SERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_TX_Q" "TOP_SERDES_0:DCS_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DCS_TX_WRCNT" "TOP_SERDES_0:DCS_TX_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PRBS_ERRORCNT" "TOP_SERDES_0:PRBS_ERROR_COUNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_cal_addr" "TOP_SERDES_0:dcs_cal_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_cal_data" "TOP_SERDES_0:dcs_cal_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_cal_data_out" "TOP_SERDES_0:dcs_cal_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_hv_addr" "TOP_SERDES_0:dcs_hv_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_hv_data" "TOP_SERDES_0:dcs_hv_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_hv_data_out" "TOP_SERDES_0:dcs_hv_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dcs_use_lane" "TOP_SERDES_0:DCS_USE_LANE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:error_address" "TOP_SERDES_0:address_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:error_counter" "TOP_SERDES_0:counter_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:ewm_out_counter" "counter_16bit_0:cnt" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:AHBL_M_SLV" "PF_SRAM_0:AHBSlaveInterface" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:APB_MSTR" "SLOWCONTROLS_0:APB3mmaster" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign ROC
generate_component -component_name ${sd_name}
