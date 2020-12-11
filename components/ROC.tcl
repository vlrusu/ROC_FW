# Creating SmartDesign ROC
set sd_name {ROC}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {TDI} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SWCLKTCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {NTRST} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SWDITMS} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TX} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ADC_CLK_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ADC_CLK_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CLK_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CLK_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_HV_DEVRST_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREMAP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALODD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CALEVEN_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_CAL_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_CAL_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_CAL_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_CAL_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_HV_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_HV_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_HV_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_HV_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_CAL_CLK_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_CAL_CLK_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_HV_CLK_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_HV_CLK_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvsda} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {calscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {calsda} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_cal} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CLK_OUT_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_CLK_OUT_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N_0} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N_0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_active} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_hv} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_CLK_OUT_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_CLK_OUT_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROC_CAL_DEVRST_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SENSOR_MCP_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CKE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CS_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ODT} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RAS_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAS_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {WE_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD2} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD3} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {STAMP_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {STAMP_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ} -port_direction {INOUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS} -port_direction {INOUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range {[14:0]}

# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add CCC_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROC_CCC} -instance_name {CCC_0}



# Add CLKINT_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {CLKINT} -instance_name {CLKINT_0}



# Add COREJTAGDEBUG_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {COREJTAGDEBUG_C0} -instance_name {COREJTAGDEBUG_C0_0}



# Add DDRInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DDRInterface} -instance_name {DDRInterface_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:MEMFIFO_DATA} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DDRInterface_0:MEMFIFO_DATA} -pin_slices {[63:32]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRInterface_0:ram_ren} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRInterface_0:read_page_no} -value {00000001}



# Add DIGIINTERFACE_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DIGIINTERFACE} -instance_name {DIGIINTERFACE_0}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN_0} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_RXD_P_0" "LANE0_RXD_N_0" "LANE1_RXD_P_0" "LANE1_RXD_N_0" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT_0} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_TXD_P_0" "LANE0_TXD_N_0" "LANE1_TXD_P_0" "LANE1_TXD_N_0" }



# Add DTCInterface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DTCInterface} -instance_name {DTCInterface_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:RF_MARKER} -pin_slices {[6:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTCInterface_0:RF_MARKER} -pin_slices {[7]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTCInterface_0:RF_MARKER[7]} -value {GND}
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



# Add EWMaker_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {EWMaker} -hdl_file {hdl\EWMaker.vhd} -instance_name {EWMaker_0}



# Add INBUF_DIFF_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INBUF_DIFF} -instance_name {INBUF_DIFF_0}



# Add Init_Monitor_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {Init_Monitor} -instance_name {Init_Monitor_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:PCIE_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:USRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:SRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:USRAM_INIT_FROM_SNVM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:USRAM_INIT_FROM_UPROM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:USRAM_INIT_FROM_SPI_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:SRAM_INIT_FROM_SNVM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:SRAM_INIT_FROM_UPROM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:SRAM_INIT_FROM_SPI_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:AUTOCALIB_DONE}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add INV_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_1}



# Add MIV_RV32IMC_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MIV_RV32IMC_C0} -instance_name {MIV_RV32IMC_C0_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[1]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[1]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[2]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[2]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[3]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[3]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[4]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[4]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -pin_slices {[5]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ[5]} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:JTAG_TDO_DR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_RESETN}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_IRQ} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:TIME_COUNT_OUT}



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



# Add PF_CLK_DIV_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_CLK_DIV_C0} -instance_name {PF_CLK_DIV_C0_0}



# Add PF_OSC_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_OSC_C0} -instance_name {PF_OSC_C0_0}



# Add pf_reset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {pf_reset} -instance_name {pf_reset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:FF_US_RESTORE} -value {GND}



# Add PF_SRAM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_SRAM} -instance_name {PF_SRAM_0}



# Add pulse_stretcher_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_0:resetn_i} -value {VCC}



# Add SLOWCONTROLS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SLOWCONTROLS} -instance_name {SLOWCONTROLS_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRIN} -pin_slices {[9:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDROFFSET} -pin_slices {[19:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[23:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[30:24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMSPILLDATA} -pin_slices {[31]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMDATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMDATA} -pin_slices {[31:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMADDR} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMADDR} -pin_slices {[23:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[11:8]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[21:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[24]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[28]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[3:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DTCSIMPARAM} -pin_slices {[7:4]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRCS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_RESET}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:write_to_fifo}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re3}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_re2}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_HOWMANY}
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
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG_2}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DATAREQ_EVENT_WINDOW_TAG_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TOP_SERDES_0:DATAREQ_STATUS} -value {01010101}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TOP_SERDES_0:PATTERN}



# Add TrackerCCC_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TrackerCCC} -instance_name {TrackerCCC_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TrackerCCC_0:PLL_LOCK_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ADC_CLK_N" "OUTBUF_DIFF_0:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ADC_CLK_P" "OUTBUF_DIFF_0:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_N" "OUTBUF_DIFF_2:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALEVEN_P" "OUTBUF_DIFF_2:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_N" "OUTBUF_DIFF_1:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CALODD_P" "OUTBUF_DIFF_1:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CLK_OUT_N" "OUTBUF_DIFF_3:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_CLK_OUT_P" "OUTBUF_DIFF_3:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE1n" "SLOWCONTROLS_0:CAL_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MISO" "SLOWCONTROLS_0:CAL_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MOSI" "SLOWCONTROLS_0:CAL_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_SCLK" "SLOWCONTROLS_0:CAL_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREMAP_CE0n" "SLOWCONTROLS_0:CAL_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"calscl" "SLOWCONTROLS_0:calscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"calsda" "SLOWCONTROLS_0:calsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N" "DDRInterface_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:SERIAL_CLK" "TrackerCCC_0:REF_CLK_0" "MIV_RV32IMC_C0_0:CLK" "DIGIINTERFACE_0:serialfifo_rclk" "DIGIINTERFACE_0:init_clk" "DTCInterface_0:HCLK" "pf_reset_0:CLK" "PF_SRAM_0:HCLK" "SLOWCONTROLS_0:HCLK" "pulse_stretcher_0:clk_i" "SLOWCONTROLS_0:PCLK" "CCC_0:OUT0_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:D" "CCC_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CCC_0:OUT2_FABCLK_0" "DDRInterface_0:MEM_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:outfifo_wclk" "DIGIINTERFACE_0:ddrfifo_rclk" "CCC_0:OUT3_FABCLK_0" "DDRInterface_0:DIGIFIFO_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:PLL_LOCK" "CCC_0:PLL_LOCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0" "DDRInterface_0:CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0_N" "DDRInterface_0:CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "DDRInterface_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CCC_0:REF_CLK_0" "CLKINT_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TCK" "COREJTAGDEBUG_C0_0:TGT_TCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TDI" "COREJTAGDEBUG_C0_0:TGT_TDI_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TMS" "COREJTAGDEBUG_C0_0:TGT_TMS_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TRST" "COREJTAGDEBUG_C0_0:TGT_TRSTB_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS_N" "DDRInterface_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRFULL" "DDRInterface_0:DDR3_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:ddrfifo_re" "DDRInterface_0:DIGIFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRISERR" "DDRInterface_0:mem_test_err_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_DATA_READY" "TOP_SERDES_0:DATAREQ_DATA_READY_FLAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFOEMPTY" "DDRInterface_0:MEMFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFOFULL" "DDRInterface_0:MEMFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_LAST_WORD" "TOP_SERDES_0:DATAREQ_LAST_WORD_FLAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRTEMPFIFOEMPTY" "DDRInterface_0:TEMPFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRTEMPFIFOFULL" "DDRInterface_0:TEMPFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:ddrfifo_empty" "DDRInterface_0:DIGIFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:ddrfifo_full" "DDRInterface_0:DIGIFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_EMPTY" "DIGIINTERFACE_0:serialfifo_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_FULL" "DIGIINTERFACE_0:serialfifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewm_active" "EWMaker_0:ewm_active" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewm_cal" "ewm_hv" "EWMaker_0:ewm" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_CLK_OUT_N" "OUTBUF_DIFF_4:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_CLK_OUT_P" "OUTBUF_DIFF_4:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE0n" "SLOWCONTROLS_0:HV_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE1n" "SLOWCONTROLS_0:HV_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MISO" "SLOWCONTROLS_0:HV_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MOSI" "SLOWCONTROLS_0:HV_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_SCLK" "SLOWCONTROLS_0:HV_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hvscl" "SLOWCONTROLS_0:hvscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hvsda" "SLOWCONTROLS_0:hvsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:Y" "CLKINT_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:BANK_y_VDDI_STATUS" "Init_Monitor_0:BANK_2_VDDI_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:INIT_DONE" "Init_Monitor_0:DEVICE_INIT_DONE" "DDRInterface_0:SYS_RESET_N" "TOP_SERDES_0:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:FPGA_POR_N" "Init_Monitor_0:FABRIC_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:CTRL_ARST_N" "Init_Monitor_0:XCVR_INIT_DONE" "DIGIINTERFACE_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:Y" "pulse_stretcher_0:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_1:Y" "AND2_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "TOP_SERDES_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "TOP_SERDES_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "TOP_SERDES_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "TOP_SERDES_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_N" "DIGIINTERFACE_0:LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_N_0" "DIGIINTERFACE_0:LANE1_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_P" "DIGIINTERFACE_0:LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_P_0" "DIGIINTERFACE_0:LANE1_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_N" "DIGIINTERFACE_0:LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_N_0" "DIGIINTERFACE_0:LANE1_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_P" "DIGIINTERFACE_0:LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_P_0" "DIGIINTERFACE_0:LANE1_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TDO" "COREJTAGDEBUG_C0_0:TGT_TDO_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NTRST" "COREJTAGDEBUG_C0_0:TRSTB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT" "DDRInterface_0:ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CLK_DIV_C0_0:CLK_OUT" "DIGIINTERFACE_0:CTRL_CLK" "TOP_SERDES_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CLK_DIV_C0_0:CLK_IN" "PF_OSC_C0_0:RCOSC_160MHZ_CLK_DIV" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:OSC_CLK" "PF_OSC_C0_0:RCOSC_160MHZ_GL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:reset_n" "MIV_RV32IMC_C0_0:RESETN" "DIGIINTERFACE_0:init_reset_n" "DTCInterface_0:HRESETN" "PF_SRAM_0:HRESETN" "pf_reset_0:FABRIC_RESET_N" "SLOWCONTROLS_0:HRESETN" "SLOWCONTROLS_0:PRESETN" "AND2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:PLL_POWERDOWN_B" "CCC_0:PLL_POWERDOWN_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_1:A" "pulse_stretcher_0:gate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RAS_N" "DDRInterface_0:RAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "TOP_SERDES_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "TOP_SERDES_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "DDRInterface_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_CLK_N" "INBUF_DIFF_0:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_CLK_P" "INBUF_DIFF_0:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:EXT_RST_N" "TOP_SERDES_0:EXT_RST_N" "AND2_1:Y" "ROC_HV_DEVRST_N" "ROC_CAL_DEVRST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX" "SLOWCONTROLS_0:RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SENSOR_MCP_CEn" "SENSOR_MCP_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_CAL_CLK_N" "DIGIINTERFACE_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_CAL_CLK_P" "DIGIINTERFACE_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_CAL_RXD_N" "DIGIINTERFACE_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_CAL_RXD_P" "DIGIINTERFACE_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_CAL_TXD_N" "DIGIINTERFACE_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_CAL_TXD_P" "DIGIINTERFACE_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_HV_CLK_N" "DIGIINTERFACE_0:REF_CLK_PAD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_HV_CLK_P" "DIGIINTERFACE_0:REF_CLK_PAD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_HV_RXD_N" "DIGIINTERFACE_0:LANE0_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_HV_RXD_P" "DIGIINTERFACE_0:LANE0_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_HV_TXD_N" "DIGIINTERFACE_0:LANE0_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERDES_HV_TXD_P" "DIGIINTERFACE_0:LANE0_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD0" "DDRInterface_0:SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD1" "DDRInterface_0:SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD2" "DDRInterface_0:SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD3" "DDRInterface_0:SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRFIFO_RE" "DDRInterface_0:DDRFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRFIFOWEN" "DDRInterface_0:fifo_write_mem_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFO_RE" "DDRInterface_0:DDRMEMFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRPTTREN" "DDRInterface_0:pattern_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRREN" "DDRInterface_0:mem_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRSEL" "DDRInterface_0:DDR_DTCSIM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRSET" "DDRInterface_0:SIM_MEMFIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRWEN" "DDRInterface_0:mem_wr_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMBLKEN" "DTCInterface_0:BLK_WEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:DTC_SEL" "SLOWCONTROLS_0:DTCSIMPARAM[24]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMPARAM[28]" "TOP_SERDES_0:SIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMSPILLDATA[31]" "DTCInterface_0:ON_SPILL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMSTART" "DTCInterface_0:SIM_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:external_ewm" "SLOWCONTROLS_0:ewm" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:enable" "SLOWCONTROLS_0:ewm_enable" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:D" "OUTBUF_DIFF_1:D" "SLOWCONTROLS_0:PWM0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:FIFO_RESET" "SLOWCONTROLS_0:reset_fifo_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:A" "SLOWCONTROLS_0:ROCRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_RE" "DIGIINTERFACE_0:serialfifo_re" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"STAMP_N" "TOP_SERDES_0:STAMP_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"STAMP_P" "TOP_SERDES_0:STAMP_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SWCLKTCK" "COREJTAGDEBUG_C0_0:TCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SWDITMS" "COREJTAGDEBUG_C0_0:TMS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TDI" "COREJTAGDEBUG_C0_0:TDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TDO" "COREJTAGDEBUG_C0_0:TDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:READOUT_CLK" "TOP_SERDES_0:ALGO_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:EXT_SYS_IRQ[0]" "TOP_SERDES_0:BUSY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_RE" "TOP_SERDES_0:DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:fifo_read_mem_en" "TOP_SERDES_0:DATAREQ_START_EVENT_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:LANE0_RX_CLK_R" "DTCInterface_0:RX_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:ALIGN" "TOP_SERDES_0:RX_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TOP_SERDES_0:RX_RESETN" "DTCInterface_0:RX_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:tracker_clk" "OUTBUF_DIFF_3:D" "OUTBUF_DIFF_4:D" "TrackerCCC_0:OUT0_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:clk" "TrackerCCC_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX" "SLOWCONTROLS_0:TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WE_N" "DDRInterface_0:WE_N" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"A" "DDRInterface_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BA" "DDRInterface_0:BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRCONVDATA" "DDRInterface_0:CONVERTER_q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRCONVRDCNT" "DDRInterface_0:CONVERTER_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:ddr_rd_cnt" "SLOWCONTROLS_0:DDRDIAG1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRERRLOC" "DDRInterface_0:err_loc_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:mem_rd_cnt" "SLOWCONTROLS_0:DDRPAGERD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:mem_wr_cnt" "SLOWCONTROLS_0:DDRPAGEWR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_DATA" "TOP_SERDES_0:DATAREQ_DATA_REQ_REPLY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFODATA0" "DDRInterface_0:MEMFIFO_DATA[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRMEMFIFODATA1" "DDRInterface_0:MEMFIFO_DATA[63:32]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:MEMFIFO_DATA_PCKTS" "TOP_SERDES_0:DATAREQ_PACKETS_IN_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:memfifo_rd_cnt" "SLOWCONTROLS_0:DDRDIAG0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:ram_data_o" "SLOWCONTROLS_0:DDRRAM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:ddrfifo_data" "DDRInterface_0:DIGIFIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:ddrfifo_rdcnt" "DDRInterface_0:DIGIFIFO_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_DATA" "DIGIINTERFACE_0:serialfifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_RDCNT" "DIGIINTERFACE_0:serialfifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DM" "DDRInterface_0:DM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQ" "DDRInterface_0:DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS" "DDRInterface_0:DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS_N" "DDRInterface_0:DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:DATA_TO_TX" "TOP_SERDES_0:SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:KCHAR_TO_TX" "TOP_SERDES_0:SIM_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_OUT" "SLOWCONTROLS_0:GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRIN[9:0]" "DDRInterface_0:ram_addr_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRNHITS" "DDRInterface_0:hit_no" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDROFFSET[19:0]" "DDRInterface_0:mem_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRInterface_0:write_page_no" "SLOWCONTROLS_0:DDRPAGENO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DDRPATTRN" "DDRInterface_0:pattern_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMADDR[15:0]" "DTCInterface_0:ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMADDR[23:16]" "DTCInterface_0:MODULE_ID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:BLK_ADDR" "SLOWCONTROLS_0:DTCSIMBLKADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:BLK_DATA" "SLOWCONTROLS_0:DTCSIMBLKDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMDATA[15:0]" "DTCInterface_0:WDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMDATA[31:16]" "DTCInterface_0:BLOCK_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:PACKET_TYPE" "SLOWCONTROLS_0:DTCSIMPARAM[3:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:MARKER_TYPE" "SLOWCONTROLS_0:DTCSIMPARAM[7:4]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:SEQ_NUM" "SLOWCONTROLS_0:DTCSIMPARAM[11:8]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCInterface_0:OP_CODE" "SLOWCONTROLS_0:DTCSIMPARAM[21:16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMSPILLDATA[15:0]" "DTCInterface_0:EVENT_WINDOW_TAG[15:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMSPILLDATA[23:16]" "DTCInterface_0:EVENT_MODE[7:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCSIMSPILLDATA[30:24]" "DTCInterface_0:RF_MARKER[6:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:event_window_early_cut" "SLOWCONTROLS_0:event_window_early_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:event_window_late_cut" "SLOWCONTROLS_0:event_window_late_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:delay" "SLOWCONTROLS_0:ewm_delay" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:use_lane" "DIGIINTERFACE_0:use_lane" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:DTCDATAREAD" "TOP_SERDES_0:TX_DATA_OUT" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_SRAM_0:AHBSlaveInterface" "MIV_RV32IMC_C0_0:AHBL_M_SLV" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:APB_MSTR" "SLOWCONTROLS_0:APB3mmaster" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign ROC
generate_component -component_name ${sd_name}
