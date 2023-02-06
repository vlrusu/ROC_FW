# Creating SmartDesign ROC
set sd_name {ROC}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD0_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD0_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD1_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALtoROC_SERDES_TXD1_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD0_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD0_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD1_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVtoROC_SERDES_TXD1_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO1} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO2} -port_direction {IN}
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

sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CLOCK_ALIGNED} -port_direction {OUT}
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
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO3} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO4} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {KEY_IO5} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_ACCEL_CLK1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_DEVRSTn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_LVDS0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_LVDS0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_DTC_SERDES_TXD0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_DTC_SERDES_TXD0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_DEVRSTn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_LVDS0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_LVDS0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_LED0_n} -port_direction {OUT}
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
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_LVTTL1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_SERDES_TXD1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_CLK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_CLK0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_LVTTL0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD0_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD1_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_SERDES_TXD1_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD1} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD2} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD3} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {word_aligned} -port_direction {OUT}

sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoCAL_LVTTL2} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCtoHV_LVTTL1} -port_direction {INOUT}

# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {ALIGNMENT_LOSS_COUNTER} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_ADDR} -port_direction {OUT} -port_range {[13:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_BA} -port_direction {OUT} -port_range {[1:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQM} -port_direction {OUT} -port_range {[3:0]} -port_is_pad {1}

sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQS_N} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQS_P} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDR4_DQ} -port_direction {INOUT} -port_range {[31:0]} -port_is_pad {1}

# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add AND2_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_3}



# Add AND3_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND3} -instance_name {AND3_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {AND3_0:C} -value {VCC}



# Add AND3_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND3} -instance_name {AND3_1}



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



# Add DReqClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {DReqClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DReqClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DReqClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DReqClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DReqClkReset:PLL_POWERDOWN_B}



# Add DTCSimulator_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DTCSimulator} -instance_name {DTCSimulator_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:EVENT_MODE} -pin_slices {[15:8]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCSimulator_0:EVENT_MODE[15:8]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:EVENT_MODE} -pin_slices {[23:16]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCSimulator_0:EVENT_MODE[23:16]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:EVENT_MODE} -pin_slices {[31:24]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCSimulator_0:EVENT_MODE[31:24]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:EVENT_MODE} -pin_slices {[7:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:EVENT_WINDOW_TAG} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:EVENT_WINDOW_TAG} -pin_slices {[31:16]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCSimulator_0:EVENT_WINDOW_TAG[31:16]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:EVENT_WINDOW_TAG} -pin_slices {[47:32]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCSimulator_0:EVENT_WINDOW_TAG[47:32]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:RF_MARKER} -pin_slices {[6:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCSimulator_0:RF_MARKER} -pin_slices {[7:7]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCSimulator_0:RF_MARKER[7:7]} -value {GND}



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



# Add INV_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_1}



# Add INV_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_2}



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
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:TIME_COUNT_OUT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:JTAG_TDO_DR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_RESETN}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_IRQ} -value {GND}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add NewDDRInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {NewDDRInterface} -instance_name {NewDDRInterface_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {NewDDRInterface_0:serial_offset} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {NewDDRInterface_0:serial_offset} -pin_slices {[47:32]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {NewDDRInterface_0:serial_offset[47:32]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {NewDDRInterface_0:ewtag_offset_out} -pin_slices {[31:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {NewDDRInterface_0:ew_DDR_wrap}



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



# Add SerdesClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {SerdesClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SerdesClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SerdesClkReset:PLL_POWERDOWN_B}



# Add SLOWCONTROLS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SLOWCONTROLS} -instance_name {SLOWCONTROLS_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRERROR} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRERROR} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRERROR} -pin_slices {[2:2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRERROR} -pin_slices {[3:3]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZERD} -pin_slices {[19:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZERD} -pin_slices {[23:20]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSIZERD[23:20]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZERD} -pin_slices {[25:24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZERD} -pin_slices {[27:26]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSIZERD[27:26]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZERD} -pin_slices {[28:28]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZERD} -pin_slices {[31:29]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSIZERD[31:29]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZEWR} -pin_slices {[19:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZEWR} -pin_slices {[23:20]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSIZEWR[23:20]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZEWR} -pin_slices {[25:24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZEWR} -pin_slices {[27:26]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSIZEWR[27:26]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZEWR} -pin_slices {[28:28]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRSIZEWR} -pin_slices {[31:29]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSIZEWR[31:29]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMADDR} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMADDR} -pin_slices {[23:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMDATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMDATA} -pin_slices {[31:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[11:8]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[21:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[24:24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[28:28]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[3:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[7:4]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[23:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[30:24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[31:31]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:GPIO_OUT} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:GPIO_OUT} -pin_slices {[3:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:GPIO_OUT[3:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DTCSIMBLKEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SENSOR_MCP_CEn}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:cal_serdes_reset_n}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:hv_serdes_reset_n}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re2}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re3}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:write_to_fifo}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_aligned} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt3} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DTCSIMBLKADDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DTCSIMBLKDATA}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_HOWMANY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_address}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:event_window_early_cut}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:event_window_expected}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:event_window_late_cut}



# Add TOP_SERDES_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TOP_SERDES} -instance_name {TOP_SERDES_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:FETCH_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:HEARTBEAT_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {TOP_SERDES_0:PREFETCH_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PRBS_EN} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DATAREQ_STATUS} -value {01010101}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PRBS_DATA} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PRBS_KCHAR} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DCS_TAG_OFFSET}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:EVT_MODE}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:A" "NewDDRInterface_0:SERIAL_pattern_en" "SLOWCONTROLS_0:DDRPTTREN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:B" "SLOWCONTROLS_0:DTCSIMPARAM[28:28]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:Y" "TOP_SERDES_0:DTCSIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:A" "INIT_component_0:XCVR_INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:B" "SLOWCONTROLS_0:dtc_serdes_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:Y" "DigiInterface_0:CTRL_ARST_N" "TOP_SERDES_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:A" "INIT_component_0:BANK_0_CALIB_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:B" "INIT_component_0:BANK_1_CALIB_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:Y" "NewDDRInterface_0:DDR_BANK_CALIB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:A" "MIV_RV32IMC_C0_0:RESETN" "PF_SRAM_0:HRESETN" "Reset50MHz:FABRIC_RESET_N" "SLOWCONTROLS_0:PRESETN" "TOP_SERDES_0:HRESETN" "pulse_stretcher_0:resetn_i" "pulse_stretcher_1:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:B" "INV_2:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:C" "INV_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:Y" "DReqClkReset:EXT_RST_N" "DTCSimulator_0:EXT_RST_N" "NewDDRInterface_0:EXT_RST_N" "SerdesClkReset:EXT_RST_N" "TOP_SERDES_0:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_N" "OUTBUF_DIFF_6:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_P" "OUTBUF_DIFF_6:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_N" "OUTBUF_DIFF_5:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_P" "OUTBUF_DIFF_5:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE0n" "SLOWCONTROLS_0:CAL_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE1n" "SLOWCONTROLS_0:CAL_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MISO" "SLOWCONTROLS_0:CAL_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MOSI" "SLOWCONTROLS_0:CAL_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_SCLK" "SLOWCONTROLS_0:CAL_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD0_N" "DigiInterface_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD0_P" "DigiInterface_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD1_N" "DigiInterface_0:LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALtoROC_SERDES_TXD1_P" "DigiInterface_0:LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLKINT_0:A" "INBUF_DIFF_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLKINT_0:Y" "PF_CCC_111_0:REF_CLK_0" "PF_CCC_C0_0:REF_CLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "TOP_SERDES_0:CLOCK_ALIGNED" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:BANK_y_VDDI_STATUS" "CORERESET_2_LOCK_1:BANK_y_VDDI_STATUS" "DReqClkReset:BANK_y_VDDI_STATUS" "DigiClkReset_0:BANK_y_VDDI_STATUS" "DigiFIFOReset_0:BANK_y_VDDI_STATUS" "DigiReset_0:BANK_y_VDDI_STATUS" "INIT_component_0:BANK_2_VDDI_STATUS" "Reset50MHz:BANK_y_VDDI_STATUS" "SerdesClkReset:BANK_y_VDDI_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:CLK" "PF_CCC_C0_0:OUT0_FABCLK_0" "PF_NGMUX_C0_0:CLK0" "TOP_SERDES_0:DCS_CLK" "pulse_stretcher_1:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:FPGA_POR_N" "CORERESET_2_LOCK_1:FPGA_POR_N" "DReqClkReset:FPGA_POR_N" "DigiClkReset_0:FPGA_POR_N" "DigiFIFOReset_0:FPGA_POR_N" "DigiInterface_0:FPGA_POR_N" "DigiReset_0:FPGA_POR_N" "INIT_component_0:FABRIC_POR_N" "NewDDRInterface_0:FPGA_POR_N" "Reset50MHz:FPGA_POR_N" "SerdesClkReset:FPGA_POR_N" "TOP_SERDES_0:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:INIT_DONE" "CORERESET_2_LOCK_1:INIT_DONE" "DReqClkReset:INIT_DONE" "DigiClkReset_0:INIT_DONE" "DigiFIFOReset_0:INIT_DONE" "DigiInterface_0:INIT_DONE" "DigiReset_0:INIT_DONE" "INIT_component_0:DEVICE_INIT_DONE" "NewDDRInterface_0:INIT_DONE" "Reset50MHz:INIT_DONE" "SerdesClkReset:INIT_DONE" "TOP_SERDES_0:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_2_LOCK_0:PLL_LOCK" "DReqClkReset:PLL_LOCK" "DigiFIFOReset_0:PLL_LOCK" "PF_CCC_C0_0:PLL_LOCK_0" "Reset50MHz:PLL_LOCK" "SerdesClkReset:PLL_LOCK" "TOP_SERDES_0:PLL_LOCK" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"DReqClkReset:CLK" "DTCSimulator_0:DREQ_CLK" "NewDDRInterface_0:dreqclk" "PF_CCC_C0_0:OUT2_FABCLK_0" "TOP_SERDES_0:DREQ_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DReqClkReset:FABRIC_RESET_N" "DTCSimulator_0:DREQCLK_RESETN" "NewDDRInterface_0:dreqclk_resetn" "TOP_SERDES_0:DREQCLK_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:ALIGN" "TOP_SERDES_0:PCS_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:DATAREQ_LAST_WORD" "NewDDRInterface_0:last_word" "TOP_SERDES_0:DATAREQ_LAST_WORD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:MARKER_SEL" "SLOWCONTROLS_0:DTCSIMPARAM[24:24]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:ON_SPILL" "SLOWCONTROLS_0:DTCSIMSPILLDATA[31:31]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:RXCLK_RESETN" "NewDDRInterface_0:RXCLK_RESETN" "TOP_SERDES_0:RXCLK_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:RX_CLK" "NewDDRInterface_0:RX_CLK" "PF_NGMUX_C0_0:CLK1" "TOP_SERDES_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERDESCLK_RESETN" "DigiInterface_0:serdesclk_resetn" "NewDDRInterface_0:resetn_serdesclk" "SerdesClkReset:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERDES_CLK" "DigiFIFOReset_0:CLK" "DigiInterface_0:fifo_rclk" "NewDDRInterface_0:serdesclk" "PF_CCC_C0_0:OUT1_FABCLK_0" "SerdesClkReset:CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERIAL_CFO_EN" "SLOWCONTROLS_0:DDRCFOEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERIAL_CFO_PREF_EN" "SLOWCONTROLS_0:DDRPREFETCHEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERIAL_CFO_START" "SLOWCONTROLS_0:DDRCFOSTART" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SIM_START" "SLOWCONTROLS_0:DTCSIMSTART" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:TXCLK_RESETN" "TOP_SERDES_0:TXCLK_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:TX_CLK" "TOP_SERDES_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:dreq_start" "NewDDRInterface_0:event_start" "TOP_SERDES_0:DATAREQ_START_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:hb_start" "NewDDRInterface_0:hb_valid" "TOP_SERDES_0:HEARTBEAT_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiClkReset_0:FABRIC_RESET_N" "EWMaker_0:digi_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiClkReset_0:PLL_LOCK" "DigiReset_0:PLL_LOCK" "PF_CCC_C1_0:PLL_LOCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:EXT_RST_N" "SLOWCONTROLS_0:reset_fifo_n" "counter_16bit_0:rst_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:FABRIC_RESET_N" "DigiInterface_0:fifo_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:CAL_lane0_empty" "TOP_SERDES_0:DCS_CAL_LANE0_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:CAL_lane1_empty" "TOP_SERDES_0:DCS_CAL_LANE1_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:CTRL_CLK" "PF_CLK_DIV_C0_0:CLK_OUT" "TOP_SERDES_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:HV_lane0_empty" "TOP_SERDES_0:DCS_HV_LANE0_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:HV_lane1_empty" "TOP_SERDES_0:DCS_HV_LANE1_EMPTY" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_done" "NewDDRInterface_0:DIGI_ew_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_fifo_full" "NewDDRInterface_0:ew_fifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_fifo_we" "NewDDRInterface_0:DIGI_ew_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_ovfl" "NewDDRInterface_0:DIGI_ew_ovfl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:force_full" "SLOWCONTROLS_0:force_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_aligned" "SLOWCONTROLS_0:hv_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_aligned" "SLOWCONTROLS_0:hv_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_empty" "SLOWCONTROLS_0:SERDES_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_full" "SLOWCONTROLS_0:SERDES_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_rclk" "MIV_RV32IMC_C0_0:CLK" "PF_CCC_C0_0:OUT3_FABCLK_0" "PF_SRAM_0:HCLK" "Reset50MHz:CLK" "SLOWCONTROLS_0:PCLK" "pulse_stretcher_0:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_re" "SLOWCONTROLS_0:SERDES_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:use_uart" "SLOWCONTROLS_0:use_uart" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReset_0:EXT_RST_N" "SLOWCONTROLS_0:DIGIDEVICE_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReset_0:FABRIC_RESET_N" "ROC_CAL_DEVRSTn" "ROC_HV_DEVRSTn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiReset_0:PLL_POWERDOWN_B" "PF_CCC_C1_0:PLL_POWERDOWN_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm" "MX2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm_enable_50mhz" "SLOWCONTROLS_0:ewm_enable_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:external_ewm_50mhz" "SLOWCONTROLS_0:ewm_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE0n" "SLOWCONTROLS_0:HV_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE1n" "SLOWCONTROLS_0:HV_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MISO" "SLOWCONTROLS_0:HV_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MOSI" "SLOWCONTROLS_0:HV_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_SCLK" "SLOWCONTROLS_0:HV_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:PADN" "ROC_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:PADP" "ROC_CLK_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_1:A" "pulse_stretcher_1:gate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_2:A" "pulse_stretcher_0:gate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO0" "SLOWCONTROLS_0:TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO1" "SLOWCONTROLS_0:RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO2" "SLOWCONTROLS_0:SPI2_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO3" "SLOWCONTROLS_0:SPI2_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO4" "SLOWCONTROLS_0:SPI2_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"KEY_IO5" "SLOWCONTROLS_0:SPI2_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:B" "TOP_SERDES_0:EWM_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:S" "SLOWCONTROLS_0:enable_fiber_marker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:CTRLR_READY" "SLOWCONTROLS_0:DDRCTRLREADY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:DCS_pattern_en" "TOP_SERDES_0:DCS_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:DREQ_FIFO_EMPTY" "SLOWCONTROLS_0:DDRSIZERD[28:28]" "TOP_SERDES_0:DCS_DREQ_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:DREQ_FIFO_FULL" "SLOWCONTROLS_0:DDRSIZEWR[28:28]" "TOP_SERDES_0:DCS_DREQ_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:MEM_CLK" "PF_CCC_111_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:NEWSPILL" "TOP_SERDES_0:NEWSPILL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:ONSPILL" "TOP_SERDES_0:ONSPILL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD0" "SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD1" "SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD2" "SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:SHIELD3" "SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:data_error" "SLOWCONTROLS_0:DDRERROR[3:3]" "TOP_SERDES_0:DCS_DATA_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:data_ready" "TOP_SERDES_0:DATAREQ_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_fifo_re" "TOP_SERDES_0:DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:event_error" "SLOWCONTROLS_0:DDRERROR[0:0]" "TOP_SERDES_0:DCS_EVT_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_null_valid" "TOP_SERDES_0:NULL_HEARTBEAT_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:header1_error" "SLOWCONTROLS_0:DDRERROR[1:1]" "TOP_SERDES_0:DCS_HDR1_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:header2_error" "SLOWCONTROLS_0:DDRERROR[2:2]" "TOP_SERDES_0:DCS_HDR2_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:pref_valid" "TOP_SERDES_0:PREFETCH_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:set_serial_offset" "SLOWCONTROLS_0:DDRSERIALSET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:start_fetch" "TOP_SERDES_0:FETCH_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:PADN" "ROC_HV_LVDS0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:PADP" "ROC_HV_LVDS0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_1:PADN" "ROCtoCAL_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_1:PADP" "ROCtoCAL_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:PADN" "ROC_CAL_LVDS0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:PADP" "ROC_CAL_LVDS0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_3:PADN" "ROCtoHV_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_3:PADP" "ROCtoHV_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:D" "OUTBUF_DIFF_4_0:D" "PF_CCC_C1_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:PADN" "ROC_ACCEL_CLK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:PADP" "ROC_ACCEL_CLK0_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4_0:PADN" "ROC_ACCEL_CLK1_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4_0:PADP" "ROC_ACCEL_CLK1_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_5:D" "OUTBUF_DIFF_6:D" "SLOWCONTROLS_0:PWM0" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoCAL_LVTTL1" "SLOWCONTROLS_0:calscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoCAL_LVTTL2" "SLOWCONTROLS_0:calsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoDTC_SERDES_CLK_N" "TOP_SERDES_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoDTC_SERDES_CLK_P" "TOP_SERDES_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoHV_LVTTL0" "SLOWCONTROLS_0:hvscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCtoHV_LVTTL1" "SLOWCONTROLS_0:hvsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDR_RESETN" "pulse_stretcher_0:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCALIGN_RESETN" "TOP_SERDES_0:DTCALIGN_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dtc_enable_reset" "TOP_SERDES_0:ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:DCS_DDRRESET" "pulse_stretcher_1:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:word_aligned" "word_aligned" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNMENT_LOSS_COUNTER" "TOP_SERDES_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_ADDR" "NewDDRInterface_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_BA" "NewDDRInterface_0:BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQ" "NewDDRInterface_0:DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQM" "NewDDRInterface_0:DM_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQS_N" "NewDDRInterface_0:DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_DQS_P" "NewDDRInterface_0:DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:ADDR" "SLOWCONTROLS_0:DTCSIMADDR[15:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:BLOCK_CNT" "SLOWCONTROLS_0:DTCSIMDATA[31:16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:EVENT_MODE[7:0]" "SLOWCONTROLS_0:DTCSIMSPILLDATA[23:16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:EVENT_WINDOW_TAG[15:0]" "SLOWCONTROLS_0:DTCSIMSPILLDATA[15:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:MARKER_TYPE" "SLOWCONTROLS_0:DTCSIMPARAM[7:4]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:MODULE_ID" "SLOWCONTROLS_0:DTCSIMADDR[23:16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:OP_CODE" "SLOWCONTROLS_0:DTCSIMPARAM[21:16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:PACKET_TYPE" "SLOWCONTROLS_0:DTCSIMPARAM[3:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:RF_MARKER[6:0]" "SLOWCONTROLS_0:DTCSIMSPILLDATA[30:24]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SEQ_NUM" "SLOWCONTROLS_0:DTCSIMPARAM[11:8]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERIAL_DELTAHB" "SLOWCONTROLS_0:DDRCFODELTAHB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERIAL_NUMBERHB" "SLOWCONTROLS_0:DDRCFONUMBERHB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SERIAL_OFFSETHB" "NewDDRInterface_0:serial_offset[31:0]" "SLOWCONTROLS_0:DDRCFOOFFSET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SIM_TX_DATA" "TOP_SERDES_0:DTCSIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:SIM_TX_KCHAR" "TOP_SERDES_0:DTCSIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:WDATA" "SLOWCONTROLS_0:DTCSIMDATA[15:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:dreq_ewtag" "TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSimulator_0:hb_ewtag" "NewDDRInterface_0:run_offset" "TOP_SERDES_0:HEARTBEAT_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:DCS_use_lane" "TOP_SERDES_0:DCS_USE_LANE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:SERIAL_use_lane" "SLOWCONTROLS_0:use_lane" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_alignment" "SLOWCONTROLS_0:cal_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_error_count" "SLOWCONTROLS_0:cal_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_alignment" "SLOWCONTROLS_0:cal_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_error_count" "SLOWCONTROLS_0:cal_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_fifo_data" "NewDDRInterface_0:DIGI_ew_fifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_size" "NewDDRInterface_0:DIGI_ew_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ew_tag" "NewDDRInterface_0:DIGI_ew_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_alignment" "SLOWCONTROLS_0:hv_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_error_count" "SLOWCONTROLS_0:hv_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_alignment" "SLOWCONTROLS_0:hv_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_error_count" "SLOWCONTROLS_0:hv_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_data" "SLOWCONTROLS_0:SERDES_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_rdcnt" "SLOWCONTROLS_0:SERDES_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:state_count" "TOP_SERDES_0:cntrl_state_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm_period_5ns" "SLOWCONTROLS_0:ewm_delay" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:data_expc" "SLOWCONTROLS_0:data_expc" "TOP_SERDES_0:data_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:data_seen" "SLOWCONTROLS_0:data_seen" "TOP_SERDES_0:data_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_fifo_rdata" "TOP_SERDES_0:DATAREQ_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:et_pckts" "TOP_SERDES_0:DATAREQ_PACKETS_IN_EVT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:event_window_fetch" "TOP_SERDES_0:FETCH_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:evt_expc" "SLOWCONTROLS_0:evt_expc" "TOP_SERDES_0:evt_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:evt_seen" "SLOWCONTROLS_0:evt_seen" "TOP_SERDES_0:evt_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:ewtag_offset_out" "TOP_SERDES_0:DCS_OFFSETTAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:ewtag_offset_out[31:0]" "SLOWCONTROLS_0:DDROFFSETTAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_cnt" "SLOWCONTROLS_0:DDRSIZERD[19:0]" "TOP_SERDES_0:DCS_FETCH_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:fetch_pos_cnt" "SLOWCONTROLS_0:DDRSIZERD[25:24]" "TOP_SERDES_0:DCS_FETCH_POS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_cnt" "SLOWCONTROLS_0:DDRHBONHOLD" "TOP_SERDES_0:DCS_HBONHOLD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_null_cnt" "SLOWCONTROLS_0:DDRNULLHBCNT" "TOP_SERDES_0:DCS_NULLHBCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hb_seen_cnt" "SLOWCONTROLS_0:DDRHBCNT" "TOP_SERDES_0:DCS_HBCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr1_expc" "SLOWCONTROLS_0:hdr1_expc" "TOP_SERDES_0:hdr1_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr1_seen" "SLOWCONTROLS_0:hdr1_seen" "TOP_SERDES_0:hdr1_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr2_expc" "SLOWCONTROLS_0:hdr2_expc" "TOP_SERDES_0:hdr2_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:hdr2_seen" "SLOWCONTROLS_0:hdr2_seen" "TOP_SERDES_0:hdr2_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:pref_seen_cnt" "SLOWCONTROLS_0:DDRPREFCNT" "TOP_SERDES_0:DCS_PREFCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:spill_hbtag_in" "SLOWCONTROLS_0:DDRSPILLCNT" "TOP_SERDES_0:SPILL_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:start_tag_cnt" "SLOWCONTROLS_0:DDRDREQCNT" "TOP_SERDES_0:DCS_DREQCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:store_cnt" "SLOWCONTROLS_0:DDRSIZEWR[19:0]" "TOP_SERDES_0:DCS_STORE_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:store_pos_cnt" "SLOWCONTROLS_0:DDRSIZEWR[25:24]" "TOP_SERDES_0:DCS_STORE_POS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_done_cnt" "SLOWCONTROLS_0:DDRDREQSENT" "TOP_SERDES_0:DCS_DREQSENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_null_cnt" "SLOWCONTROLS_0:DDRDREQNULL" "TOP_SERDES_0:DCS_DREQNULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NewDDRInterface_0:tag_sent_cnt" "SLOWCONTROLS_0:DDRDREQREAD" "TOP_SERDES_0:DCS_DREQREAD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRDREQTAG" "TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRFETCHTAG" "TOP_SERDES_0:FETCH_EVENT_WINDOW_TAG[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRHBTAG" "TOP_SERDES_0:HEARTBEAT_EVENT_WINDOW_TAG[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRPRETAG" "TOP_SERDES_0:PREFETCH_EVENT_WINDOW_TAG[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCDATAREAD" "TOP_SERDES_0:DTCDATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dtc_error_address" "TOP_SERDES_0:address_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dtc_error_counter" "TOP_SERDES_0:counter_out" }
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
