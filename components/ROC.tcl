# Creating SmartDesign ROC
set sd_name {ROC}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N_1} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P_1} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N_1} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P_0} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P_1} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CLK_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CLK_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TDI} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TMS} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TRSTB} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {ADC_CLK_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ADC_CLK_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CLK_OUT2_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CLK_OUT2_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CLK_OUT_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CLK_OUT_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_DEVRST_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CKE} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CLOCK_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_CLK_OUT2_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_CLK_OUT2_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_CLK_OUT_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_CLK_OUT_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_DEVRST_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N_1} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P_1} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P_0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ODT} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SENSOR_MCP_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD1} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD2} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD3} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TX} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {WE_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {calscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_cal} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_hv} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {word_aligned} -port_direction {OUT}

sd_create_scalar_port -sd_name ${sd_name} -port_name {calsda} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvsda} -port_direction {INOUT}

# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {ALIGNMENT_LOSS_COUNTER} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range {[14:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range {[2:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM} -port_direction {OUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {OUT} -port_range {[3:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ} -port_direction {INOUT} -port_range {[31:0]} -port_is_pad {1}

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}

# Create top level Bus Ports


# Add AND2_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_3}



# Add AND3_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND3} -instance_name {AND3_0}



# Add AND3_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND3} -instance_name {AND3_1}



# Add CLKINT_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {CLKINT} -instance_name {CLKINT_0}



# Add COREJTAGDEBUG_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {COREJTAGDEBUG_C0} -instance_name {COREJTAGDEBUG_C0_0}



# Add CORERESET_PF_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {CORERESET_PF_C0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C0_0:FABRIC_RESET_N}



# Add DDRInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DDRInterface} -instance_name {DDRInterface_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:memfifo_rd_cnt} -pin_slices {[16:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:MEMFIFO_DATA} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:MEMFIFO_DATA} -pin_slices {[63:32]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:expc_out} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:expc_out} -pin_slices {[63:32]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:true_out} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:true_out} -pin_slices {[63:32]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:DCS_WRITE_PAGE_NO} -pin_slices {[19:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:DCS_WRITE_PAGE_NO} -pin_slices {[31:20]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRInterface_0:DCS_WRITE_PAGE_NO[31:20]} -value {000000000000}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDRInterface_0:expc_empty}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDRInterface_0:expc_full}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDRInterface_0:true_empty}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDRInterface_0:true_full}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRInterface_0:read_page_no} -value {00000001}



# Add DFN1_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_0}



# Add DigiClkReset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiClkReset} -instance_name {DigiClkReset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiClkReset_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DigiClkReset_0:PLL_POWERDOWN_B}



# Add DigiFIFOReset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiFIFOReset} -instance_name {DigiFIFOReset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DigiFIFOReset_0:PLL_POWERDOWN_B}



# Add DigiInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiInterface} -instance_name {DigiInterface_0}



# Add DigiReset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DigiReset} -instance_name {DigiReset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiReset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiReset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiReset_0:FF_US_RESTORE} -value {GND}



# Add DTCInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DTCInterface} -instance_name {DTCInterface_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:RF_MARKER} -pin_slices {[6:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:RF_MARKER} -pin_slices {[7:7]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCInterface_0:RF_MARKER[7:7]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:EVENT_WINDOW_TAG} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:EVENT_WINDOW_TAG} -pin_slices {[31:16]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCInterface_0:EVENT_WINDOW_TAG[31:16]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:EVENT_WINDOW_TAG} -pin_slices {[47:32]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCInterface_0:EVENT_WINDOW_TAG[47:32]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:EVENT_MODE} -pin_slices {[15:8]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCInterface_0:EVENT_MODE[15:8]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:EVENT_MODE} -pin_slices {[23:16]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCInterface_0:EVENT_MODE[23:16]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:EVENT_MODE} -pin_slices {[31:24]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCInterface_0:EVENT_MODE[31:24]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:EVENT_MODE} -pin_slices {[7:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DTCInterface_0:DCS_PACKET_CNT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DTCInterface_0:DTC_MARKER_CNT}



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



# Add INV_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_1}



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



# Add OUTBUF_DIFF_5 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_5}



# Add OUTBUF_DIFF_6 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OUTBUF_DIFF} -instance_name {OUTBUF_DIFF_6}



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



# Add PF_SRAM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_SRAM} -instance_name {PF_SRAM_0}



# Add pulse_stretcher_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_0:polarity_i} -value {GND}



# Add pulse_stretcher_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_1:polarity_i} -value {VCC}



# Add Reset50MHz instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C2} -instance_name {Reset50MHz}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Reset50MHz:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Reset50MHz:PLL_POWERDOWN_B}



# Add SLOWCONTROLS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SLOWCONTROLS} -instance_name {SLOWCONTROLS_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[23:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[30:24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[31:31]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMDATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMDATA} -pin_slices {[31:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMADDR} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMADDR} -pin_slices {[23:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[11:8]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[21:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[24:24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[28:28]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[3:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[7:4]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[15:10]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRFIFODIA[15:10]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[3:2]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRFIFODIA[3:2]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[4:4]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[5:5]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[7:6]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRFIFODIA[7:6]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[8:8]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRFIFODIA} -pin_slices {[9:9]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:write_to_fifo}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re3}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re2}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:cal_serdes_reset_n}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:hv_serdes_reset_n}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_HOWMANY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:event_window_early_cut}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:event_window_late_cut}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_aligned} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out2} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_address}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_rdcnt3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_data2} -value {GND}



# Add TOP_SERDES_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TOP_SERDES} -instance_name {TOP_SERDES_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PRBS_EN} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DATAREQ_STATUS} -value {01010101}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG2}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PRBS_DATA} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PRBS_KCHAR} -value {GND}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ADC_CLK_N" "OUTBUF_DIFF_4:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ADC_CLK_P" "OUTBUF_DIFF_4:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_SRAM_0:HRESETN" "pulse_stretcher_0:resetn_i" "pulse_stretcher_1:resetn_i" "Reset50MHz:FABRIC_RESET_N" "SLOWCONTROLS_0:PRESETN" "MIV_RV32IMC_C0_0:RESETN" "AND2_0:A" "AND3_1:A" "DTCInterface_0:HRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCALIGN_RESETN" "AND2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "TOP_SERDES_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:A" "INIT_component_0:XCVR_INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:B" "SLOWCONTROLS_0:dtc_serdes_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_3:Y" "DigiInterface_0:CTRL_ARST_N" "DigiInterface_0:CTRL_ARST_N_0" "TOP_SERDES_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:A" "INIT_component_0:BANK_0_CALIB_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:B" "INIT_component_0:BANK_1_CALIB_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:C" "INIT_component_0:BANK_7_CALIB_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_0:Y" "DDRInterface_0:DDR_banks_calibrated" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_1:Y" "AND3_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:Y" "AND3_1:C" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND3_1:Y" "DDRInterface_0:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_N" "OUTBUF_DIFF_6:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_P" "OUTBUF_DIFF_6:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_N" "OUTBUF_DIFF_5:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_P" "OUTBUF_DIFF_5:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CLK_OUT2_N" "OUTBUF_DIFF_2:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CLK_OUT2_P" "OUTBUF_DIFF_2:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CLK_OUT_N" "OUTBUF_DIFF_0:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CLK_OUT_P" "OUTBUF_DIFF_0:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_DEVRST_N" "HV_DEVRST_N" "DigiReset_0:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE0n" "SLOWCONTROLS_0:CAL_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE1n" "SLOWCONTROLS_0:CAL_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MISO" "SLOWCONTROLS_0:CAL_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MOSI" "SLOWCONTROLS_0:CAL_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_SCLK" "SLOWCONTROLS_0:CAL_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N" "DDRInterface_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0" "DDRInterface_0:CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0_N" "DDRInterface_0:CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "DDRInterface_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:Y" "CLKINT_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLKINT_0:Y" "PF_CCC_C0_0:REF_CLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "TOP_SERDES_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TCK" "COREJTAGDEBUG_C0_0:TCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TDI" "COREJTAGDEBUG_C0_0:TDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TDO" "COREJTAGDEBUG_C0_0:TDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TCK" "COREJTAGDEBUG_C0_0:TGT_TCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TDI" "COREJTAGDEBUG_C0_0:TGT_TDI_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TDO" "COREJTAGDEBUG_C0_0:TGT_TDO_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TMS" "COREJTAGDEBUG_C0_0:TGT_TMS_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TRST" "COREJTAGDEBUG_C0_0:TGT_TRST_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TMS" "COREJTAGDEBUG_C0_0:TMS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TRSTB" "COREJTAGDEBUG_C0_0:TRSTB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiClkReset_0:BANK_y_VDDI_STATUS" "DigiFIFOReset_0:BANK_y_VDDI_STATUS" "CORERESET_PF_C0_0:BANK_y_VDDI_STATUS" "DDRInterface_0:BANK_y_VDDI_STATUS" "Reset50MHz:BANK_y_VDDI_STATUS" "DigiReset_0:BANK_y_VDDI_STATUS" "INIT_component_0:BANK_2_VDDI_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CCC_C0_0:OUT0_FABCLK_0" "PF_NGMUX_C0_0:CLK0" "pulse_stretcher_1:clk_i" "CORERESET_PF_C0_0:CLK" "DDRInterface_0:DCS_CLK" "TOP_SERDES_0:DCS_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:FPGA_POR_N" "DigiInterface_0:FPGA_POR_N" "DigiClkReset_0:FPGA_POR_N" "DigiReset_0:FPGA_POR_N" "INIT_component_0:FABRIC_POR_N" "CORERESET_PF_C0_0:FPGA_POR_N" "DDRInterface_0:FPGA_POR_N" "Reset50MHz:FPGA_POR_N" "TOP_SERDES_0:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:INIT_DONE" "DigiInterface_0:INIT_DONE" "DigiClkReset_0:INIT_DONE" "DigiReset_0:INIT_DONE" "INIT_component_0:DEVICE_INIT_DONE" "CORERESET_PF_C0_0:INIT_DONE" "DDRInterface_0:INIT_DONE" "Reset50MHz:INIT_DONE" "TOP_SERDES_0:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:PLL_LOCK" "DigiClkReset_0:PLL_LOCK" "CORERESET_PF_C0_0:PLL_LOCK" "DDRInterface_0:PLL_LOCK" "Reset50MHz:PLL_LOCK" "PF_CCC_C0_0:PLL_LOCK_0" "TOP_SERDES_0:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C0_0:PLL_POWERDOWN_B" "PF_CCC_C0_0:PLL_POWERDOWN_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS_N" "DDRInterface_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DCS_DREQ_SEL" "TOP_SERDES_0:DCS_DREQ_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DCS_MEMFIFO_REN" "TOP_SERDES_0:DCS_MEMFIFO_REN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DCS_MEM_REN" "TOP_SERDES_0:DCS_READ_MEM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DCS_MEM_WEN" "TOP_SERDES_0:DCS_WRITE_MEM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DCS_PATTERN_EN" "TOP_SERDES_0:DCS_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRFULL" "DDRInterface_0:DDR3_full" "TOP_SERDES_0:DDR_DDR3_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRSET" "DDRInterface_0:DDRSIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:D" "PF_CCC_C0_0:OUT1_FABCLK_0" "PF_SRAM_0:HCLK" "pulse_stretcher_0:clk_i" "Reset50MHz:CLK" "SLOWCONTROLS_0:PCLK" "MIV_RV32IMC_C0_0:CLK" "DDRInterface_0:DIGIFIFO_CLK" "DDRInterface_0:SERIAL_CLK" "DigiFIFOReset_0:CLK" "DigiInterface_0:serialfifo_rclk" "DigiInterface_0:fifo_rclk" "DigiInterface_0:ddrfifo_rclk" "DTCInterface_0:HCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ddrfifo_empty" "DDRInterface_0:DIGIFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ddrfifo_full" "DDRInterface_0:DIGIFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:ddrfifo_re" "DDRInterface_0:DIGIFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DREQ_MEMFIFO_RE" "TOP_SERDES_0:DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DREQ_MEM_REN" "TOP_SERDES_0:DATAREQ_START_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_DATA_READY" "TOP_SERDES_0:DATAREQ_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFOEMPTY" "DDRInterface_0:MEMFIFO_EMPTY" "TOP_SERDES_0:MEMFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFOFULL" "DDRInterface_0:MEMFIFO_FULL" "TOP_SERDES_0:MEMFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_LAST_WORD" "TOP_SERDES_0:DATAREQ_LAST_WORD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEM_CLK" "PF_CCC_C0_0:OUT2_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT" "DDRInterface_0:ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RAS_N" "DDRInterface_0:RAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CCC_C0_0:OUT3_FABCLK_0" "DDRInterface_0:READOUT_CLK" "TOP_SERDES_0:DREQ_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "DDRInterface_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRSEL" "DDRInterface_0:SERIAL_DREQ_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRCS" "DDRInterface_0:SERIAL_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFO_RE" "DDRInterface_0:SERIAL_MEMFIFO_REN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRFIFO_RE" "DDRInterface_0:SERIAL_MEM_REN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRFIFOWEN" "DDRInterface_0:SERIAL_MEM_WEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRPTTREN" "DDRInterface_0:SERIAL_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD0" "DDRInterface_0:SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD1" "DDRInterface_0:SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD2" "DDRInterface_0:SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD3" "DDRInterface_0:SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRTEMPFIFOEMPTY" "DDRInterface_0:TEMPFIFO_EMPTY" "TOP_SERDES_0:TEMPFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRTEMPFIFOFULL" "DDRInterface_0:TEMPFIFO_FULL" "TOP_SERDES_0:TEMPFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WE_N" "DDRInterface_0:WE_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRERRREN" "DDRInterface_0:err_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:error_empty" "SLOWCONTROLS_0:DDRFIFODIA[8:8]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:error_full" "SLOWCONTROLS_0:DDRFIFODIA[9:9]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRREN" "DDRInterface_0:mem_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRRWEN" "DDRInterface_0:mem_rw_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRWEN" "DDRInterface_0:mem_wr_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRRAMREN" "DDRInterface_0:ram_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:read_empty" "SLOWCONTROLS_0:DDRFIFODIA[4:4]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:read_full" "SLOWCONTROLS_0:DDRFIFODIA[5:5]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRRDTREN" "DDRInterface_0:read_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:write_empty" "SLOWCONTROLS_0:DDRFIFODIA[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:write_full" "SLOWCONTROLS_0:DDRFIFODIA[1:1]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRWRTREN" "DDRInterface_0:write_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:D" "OUTBUF_DIFF_2:D" "OUTBUF_DIFF_1:D" "OUTBUF_DIFF_3:D" "PF_CCC_C1_0:OUT0_FABCLK_0" "DFN1_0:CLK" "DigiClkReset_0:CLK" "DigiReset_0:CLK" "EWMaker_0:digi_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:Y" "DFN1_0:D" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewm_cal" "ewm_hv" "DFN1_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:ALIGN" "TOP_SERDES_0:PCS_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMBLKEN" "DTCInterface_0:BLK_WEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:MARKER_SEL" "SLOWCONTROLS_0:DTCSIMPARAM[24:24]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:ON_SPILL" "SLOWCONTROLS_0:DTCSIMSPILLDATA[31:31]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMSTART" "DTCInterface_0:SIM_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:XCVR_CLK" "TOP_SERDES_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:XCVR_RESETN" "TOP_SERDES_0:TX_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiClkReset_0:FABRIC_RESET_N" "EWMaker_0:digi_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:EXT_RST_N" "SLOWCONTROLS_0:reset_fifo_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFIFOReset_0:FABRIC_RESET_N" "DigiInterface_0:fifo_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:CTRL_CLK" "TOP_SERDES_0:CTRL_CLK" "PF_CLK_DIV_C0_0:CLK_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PCS_ARST_N" "SLOWCONTROLS_0:cal_lane0_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PCS_ARST_N_0" "SLOWCONTROLS_0:hv_lane0_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PMA_ARST_N" "SLOWCONTROLS_0:cal_lane0_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_PMA_ARST_N_0" "SLOWCONTROLS_0:hv_lane0_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_RXD_N_0" "LANE0_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_RXD_P_0" "LANE0_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_N_0" "LANE0_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE0_TXD_P_0" "LANE0_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PCS_ARST_N" "SLOWCONTROLS_0:cal_lane1_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PCS_ARST_N_0" "SLOWCONTROLS_0:hv_lane1_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PMA_ARST_N" "SLOWCONTROLS_0:cal_lane1_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_PMA_ARST_N_0" "SLOWCONTROLS_0:hv_lane1_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_RXD_N" "LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_RXD_N_0" "LANE1_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_RXD_P" "LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_RXD_P_0" "LANE1_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_N" "LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_N_0" "LANE1_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_P" "LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:LANE1_TXD_P_0" "LANE1_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_N_0" "REF_CLK_PAD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:REF_CLK_PAD_P_0" "REF_CLK_PAD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:align" "SLOWCONTROLS_0:align_roc_to_digi" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_aligned" "SLOWCONTROLS_0:cal_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_aligned" "SLOWCONTROLS_0:cal_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:force_full" "SLOWCONTROLS_0:force_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_aligned" "SLOWCONTROLS_0:hv_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_aligned" "SLOWCONTROLS_0:hv_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_empty" "SLOWCONTROLS_0:SERDES_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_full" "SLOWCONTROLS_0:SERDES_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:serialfifo_re" "SLOWCONTROLS_0:SERDES_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DIGIDEVICE_RESETN" "DigiReset_0:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CCC_C1_0:PLL_LOCK_0" "DigiReset_0:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CCC_C1_0:PLL_POWERDOWN_N_0" "DigiReset_0:PLL_POWERDOWN_B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm" "MX2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:ewm_enable_50mhz" "EWMaker_0:ewm_enable_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:ewm_50mhz" "EWMaker_0:external_ewm_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_CLK_OUT2_N" "OUTBUF_DIFF_3:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_CLK_OUT2_P" "OUTBUF_DIFF_3:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_CLK_OUT_N" "OUTBUF_DIFF_1:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_CLK_OUT_P" "OUTBUF_DIFF_1:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE0n" "SLOWCONTROLS_0:HV_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE1n" "SLOWCONTROLS_0:HV_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MISO" "SLOWCONTROLS_0:HV_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MOSI" "SLOWCONTROLS_0:HV_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_SCLK" "SLOWCONTROLS_0:HV_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_CLK_N" "INBUF_DIFF_0:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_CLK_P" "INBUF_DIFF_0:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_stretcher_1:gate_o" "INV_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_stretcher_0:gate_o" "INV_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N_1" "TOP_SERDES_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P_1" "TOP_SERDES_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N_1" "TOP_SERDES_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P_1" "TOP_SERDES_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:eventwindowmarker" "MX2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:S" "SLOWCONTROLS_0:enable_fiber_marker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PWM0" "OUTBUF_DIFF_5:D" "OUTBUF_DIFF_6:D" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CCC_C1_0:REF_CLK_0" "PF_NGMUX_C0_0:CLK_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CLK_DIV_C0_0:CLK_IN" "PF_OSC_0_0:RCOSC_160MHZ_CLK_DIV" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:LANE0_RX_CLK_R" "PF_NGMUX_C0_0:CLK1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:enable_fiber_clock" "PF_NGMUX_C0_0:SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N_1" "TOP_SERDES_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P_1" "TOP_SERDES_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX" "SLOWCONTROLS_0:RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SENSOR_MCP_CEn" "SENSOR_MCP_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDR_RESETN" "pulse_stretcher_0:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMPARAM[28:28]" "TOP_SERDES_0:DTCSIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_ADC0_CEn" "SLOWCONTROLS_0:SPI0_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_ADC1_CEn" "SLOWCONTROLS_0:SPI0_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_ADC2_CEn" "SLOWCONTROLS_0:SPI0_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_MISO" "SLOWCONTROLS_0:SPI0_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_MOSI" "SLOWCONTROLS_0:SPI0_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_SCLK" "SLOWCONTROLS_0:SPI0_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_ADC0_CEn" "SLOWCONTROLS_0:SPI1_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_ADC1_CEn" "SLOWCONTROLS_0:SPI1_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_ADC2_CEn" "SLOWCONTROLS_0:SPI1_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_MISO" "SLOWCONTROLS_0:SPI1_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_MOSI" "SLOWCONTROLS_0:SPI1_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_SCLK" "SLOWCONTROLS_0:SPI1_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI2_ADC0_CEn" "SPI2_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI2_MISO" "SPI2_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI2_MOSI" "SPI2_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI2_SCLK" "SPI2_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX" "SLOWCONTROLS_0:TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"calscl" "SLOWCONTROLS_0:calscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"calsda" "SLOWCONTROLS_0:calsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:ENABLE_ALIGNMENT" "SLOWCONTROLS_0:dtc_enable_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hvscl" "SLOWCONTROLS_0:hvscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hvsda" "SLOWCONTROLS_0:hvsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_stretcher_1:pulse_i" "TOP_SERDES_0:DCS_DDRRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"word_aligned" "TOP_SERDES_0:word_aligned" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"A" "DDRInterface_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNMENT_LOSS_COUNTER" "TOP_SERDES_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BA" "DDRInterface_0:BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRBURST" "DDRInterface_0:BURST_LENGTH" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRCONVDATA" "DDRInterface_0:CONVERTER_q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRCONVRDCNT" "DDRInterface_0:CONVERTER_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:DCS_PATTERN" "DDRInterface_0:DCS_PATTERN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:DCS_WRITE_PAGE_NO" "DDRInterface_0:DCS_WRITE_PAGE_NO[19:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DIGIFIFO_DATA" "DigiInterface_0:ddrfifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DIGIFIFO_RDCNT" "DigiInterface_0:ddrfifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DM" "DDRInterface_0:DM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQ" "DDRInterface_0:DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS" "DDRInterface_0:DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS_N" "DDRInterface_0:DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_DATA" "TOP_SERDES_0:DATAREQ_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFODATA0" "DDRInterface_0:MEMFIFO_DATA[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFODATA1" "DDRInterface_0:MEMFIFO_DATA[63:32]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_DATA_PCKTS" "TOP_SERDES_0:DATAREQ_PACKETS_IN_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRPATTRN" "DDRInterface_0:SERIAL_PATTERN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRPAGENO" "DDRInterface_0:SERIAL_WRITE_PAGE_NO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:ddr_rd_cnt" "SLOWCONTROLS_0:DDRDIAG1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRERRLOC" "DDRInterface_0:error_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDREXPCL" "DDRInterface_0:expc_out[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDREXPCH" "DDRInterface_0:expc_out[63:32]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRNHITS" "DDRInterface_0:hit_no" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRLOCRAM" "DDRInterface_0:loc_offset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRERRCNT" "DDRInterface_0:mem_err_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDROFFSET" "DDRInterface_0:mem_offset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:memfifo_rd_cnt" "SLOWCONTROLS_0:DDRDIAG0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:memfifo_rd_cnt[16:1]" "TOP_SERDES_0:FIFO_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRRAMADDR" "DDRInterface_0:ram_addr_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRRAMDATA" "DDRInterface_0:ram_data_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRRDBCNT" "DDRInterface_0:rdburst_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRRDTIME" "DDRInterface_0:read_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRTRUEL" "DDRInterface_0:true_out[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRTRUEH" "DDRInterface_0:true_out[63:32]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRWRBCNT" "DDRInterface_0:wdburst_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRWRTIME" "DDRInterface_0:write_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMADDR[15:0]" "DTCInterface_0:ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:BLK_ADDR" "SLOWCONTROLS_0:DTCSIMBLKADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMBLKDATA" "DTCInterface_0:BLK_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMDATA[31:16]" "DTCInterface_0:BLOCK_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:EVENT_MODE[7:0]" "SLOWCONTROLS_0:DTCSIMSPILLDATA[23:16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:EVENT_WINDOW_TAG[15:0]" "SLOWCONTROLS_0:DTCSIMSPILLDATA[15:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMPARAM[7:4]" "DTCInterface_0:MARKER_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMADDR[23:16]" "DTCInterface_0:MODULE_ID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMPARAM[21:16]" "DTCInterface_0:OP_CODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMPARAM[3:0]" "DTCInterface_0:PACKET_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:RF_MARKER[6:0]" "SLOWCONTROLS_0:DTCSIMSPILLDATA[30:24]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMPARAM[11:8]" "DTCInterface_0:SEQ_NUM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:DTCSIM_DATA" "DTCInterface_0:SIM_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:DTCSIM_KCHAR" "DTCInterface_0:SIM_TX_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMDATA[15:0]" "DTCInterface_0:WDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_alignment" "SLOWCONTROLS_0:cal_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane0_error_count" "SLOWCONTROLS_0:cal_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_alignment" "SLOWCONTROLS_0:cal_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:cal_lane1_error_count" "SLOWCONTROLS_0:cal_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_alignment" "SLOWCONTROLS_0:hv_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane0_error_count" "SLOWCONTROLS_0:hv_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_alignment" "SLOWCONTROLS_0:hv_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:hv_lane1_error_count" "SLOWCONTROLS_0:hv_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_DATA" "DigiInterface_0:serialfifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_RDCNT" "DigiInterface_0:serialfifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiInterface_0:use_lane" "SLOWCONTROLS_0:use_lane" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:ewm_delay" "EWMaker_0:ewm_period_5ns" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_OUT" "SLOWCONTROLS_0:GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:DTCDATA_OUT" "SLOWCONTROLS_0:DTCDATAREAD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dtc_error_address" "TOP_SERDES_0:address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:dtc_error_counter" "TOP_SERDES_0:counter_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:event_window_expected" "SLOWCONTROLS_0:event_window_expected" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_SRAM_0:AHBSlaveInterface" "MIV_RV32IMC_C0_0:AHBL_M_SLV" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:APB_MSTR" "SLOWCONTROLS_0:APB3mmaster" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:DCS_FORCE_MEMRD" "TOP_SERDES_0:DCS_FORCE_MEMRD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:SERIAL_FORCE_MEMRD" "SLOWCONTROLS_0:DDRFORCERD" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:mem_rd_cnt" "SLOWCONTROLS_0:DDRDIAG0" "SLOWCONTROLS_0:DDRPAGERD" "TOP_SERDES_0:MEM_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:mem_wr_cnt" "SLOWCONTROLS_0:DDRPAGEWR" "TOP_SERDES_0:MEM_WR_CNT" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign ROC
generate_component -component_name ${sd_name}
