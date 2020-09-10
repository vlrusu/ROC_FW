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

sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {OUT} -port_range {[3:0]}

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add CCC_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROC_CCC} -instance_name {CCC_0}



# Add CLKINT_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {CLKINT} -instance_name {CLKINT_0}



# Add COREJTAGDEBUG_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {COREJTAGDEBUG_C0} -instance_name {COREJTAGDEBUG_C0_0}



# Add DIGIINTERFACE_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DIGIINTERFACE} -instance_name {DIGIINTERFACE_0}
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_RXD_P" "LANE0_RXD_N" "LANE1_RXD_P" "LANE1_RXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_TXD_P" "LANE0_TXD_N" "LANE1_TXD_P" "LANE1_TXD_N" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_IN_0} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_RXD_P_0" "LANE0_RXD_N_0" "LANE1_RXD_P_0" "LANE1_RXD_N_0" }
sd_create_pin_group -sd_name ${sd_name} -group_name {PADs_OUT_0} -instance_name {DIGIINTERFACE_0} -pin_names {"LANE0_TXD_P_0" "LANE0_TXD_N_0" "LANE1_TXD_P_0" "LANE1_TXD_N_0" }



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



# Add MIV_RV32IMC_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MIV_RV32IMC_C0} -instance_name {MIV_RV32IMC_C0_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:JTAG_TDO_DR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_RESETN}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_IRQ} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:TIME_COUNT_OUT}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIV_RV32IMC_C0_0:EXT_SYS_IRQ} -value {GND}



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



# Add SLOWCONTROLS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SLOWCONTROLS} -instance_name {SLOWCONTROLS_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDRIN} -pin_slices {[9:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRIN[9:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDROFFSET} -pin_slices {[15:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDROFFSET[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SLOWCONTROLS_0:DDROFFSET} -pin_slices {[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDROFFSET[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRCS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRWEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRREN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRDMAEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_RE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_RESET}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_FULL} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_EMPTY} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSEL}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRFULL} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRMEMFIFOEMPTY} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRMEMFIFOFULL} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRMEMFIFO_RE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRSET}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRFIFO_RE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRTEMPFIFOEMPTY} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRTEMPFIFOFULL} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRNHITS}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_DATA} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:SERDES_RDCNT} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:serdes_aligned} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPATTRN}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRMEMFIFODATA0} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRMEMFIFODATA1} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRDIAG1} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRDIAG0} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPAGEWR} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPAGERD} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPAGENO}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:remote_token2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out3} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out0} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out1} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_out2} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:dummy_status_address}



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
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:CLK" "PF_SRAM_0:HCLK" "SLOWCONTROLS_0:PCLK" "SLOWCONTROLS_0:HCLK" "MIV_RV32IMC_C0_0:CLK" "CCC_0:OUT0_FABCLK_0" "DIGIINTERFACE_0:RCLOCKSERIAL" "DIGIINTERFACE_0:init_clk" "TrackerCCC_0:REF_CLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:D" "CCC_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:PLL_LOCK" "CCC_0:PLL_LOCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CCC_0:REF_CLK_0" "CLKINT_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TCK" "COREJTAGDEBUG_C0_0:TGT_TCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TDI" "COREJTAGDEBUG_C0_0:TGT_TDI_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TMS" "COREJTAGDEBUG_C0_0:TGT_TMS_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TRST" "COREJTAGDEBUG_C0_0:TGT_TRSTB_0" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:INIT_DONE" "Init_Monitor_0:DEVICE_INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:FPGA_POR_N" "Init_Monitor_0:FABRIC_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Init_Monitor_0:XCVR_INIT_DONE" "DIGIINTERFACE_0:CTRL_ARST_N" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CLK_DIV_C0_0:CLK_OUT" "DIGIINTERFACE_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_OSC_C0_0:RCOSC_160MHZ_GL" "PF_CLK_DIV_C0_0:CLK_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:FABRIC_RESET_N" "PF_SRAM_0:HRESETN" "SLOWCONTROLS_0:PRESETN" "SLOWCONTROLS_0:HRESETN" "EWMaker_0:reset_n" "MIV_RV32IMC_C0_0:RESETN" "AND2_0:A" "DIGIINTERFACE_0:init_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:PLL_POWERDOWN_B" "CCC_0:PLL_POWERDOWN_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_HV_DEVRST_N" "ROC_CAL_DEVRST_N" "AND2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_CLK_N" "INBUF_DIFF_0:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROC_CLK_P" "INBUF_DIFF_0:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX" "SLOWCONTROLS_0:RX" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:external_ewm" "SLOWCONTROLS_0:ewm" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:enable" "SLOWCONTROLS_0:ewm_enable" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:D" "OUTBUF_DIFF_1:D" "SLOWCONTROLS_0:PWM0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:FIFO_RESET" "SLOWCONTROLS_0:reset_fifo_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "SLOWCONTROLS_0:ROCRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane0_fifo_re" "SLOWCONTROLS_0:serdes_re0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane1_fifo_re" "SLOWCONTROLS_0:serdes_re1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane0_fifo_re_0" "SLOWCONTROLS_0:serdes_re2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane1_fifo_re_0" "SLOWCONTROLS_0:serdes_re3" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"SWCLKTCK" "COREJTAGDEBUG_C0_0:TCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SWDITMS" "COREJTAGDEBUG_C0_0:TMS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TDI" "COREJTAGDEBUG_C0_0:TDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TDO" "COREJTAGDEBUG_C0_0:TDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_3:D" "OUTBUF_DIFF_4:D" "EWMaker_0:clk" "TrackerCCC_0:OUT0_FABCLK_0" "SLOWCONTROLS_0:tracker_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX" "SLOWCONTROLS_0:TX" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane0_fifo_data_out" "SLOWCONTROLS_0:serdes_data0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane0_fifo_data_out_0" "SLOWCONTROLS_0:serdes_data2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane0_rdcnt" "SLOWCONTROLS_0:serdes_rdcnt0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane0_rdcnt_0" "SLOWCONTROLS_0:serdes_rdcnt2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane1_fifo_data_out" "SLOWCONTROLS_0:serdes_data1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane1_fifo_data_out_0" "SLOWCONTROLS_0:serdes_data3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane1_rdcnt" "SLOWCONTROLS_0:serdes_rdcnt1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:lane1_rdcnt_0" "SLOWCONTROLS_0:serdes_rdcnt3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_OUT" "SLOWCONTROLS_0:GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:event_window_early_cut" "SLOWCONTROLS_0:event_window_early_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:event_window_late_cut" "SLOWCONTROLS_0:event_window_late_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:delay" "SLOWCONTROLS_0:ewm_delay" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_SRAM_0:AHBSlaveInterface" "MIV_RV32IMC_C0_0:AHBL_M_SLV" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:APB_MSTR" "SLOWCONTROLS_0:APB3mmaster" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign ROC
generate_component -component_name ${sd_name}
