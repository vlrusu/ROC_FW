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
sd_create_scalar_port -sd_name ${sd_name} -port_name {rocreset} -port_direction {OUT}
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

sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {OUT} -port_range {[3:0]}

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND3_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND3} -instance_name {AND3_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {AND3_0:Y}



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
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:RCLOCK} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:REDAQ} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:EMPTY}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:REDDR} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:FULLDDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:EMPTYDDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:RDCNT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:Q}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:RDCNTDDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DIGIINTERFACE_0:QDDR}



# Add EWMaker_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {EWMaker} -hdl_file {hdl\EWMaker.vhd} -instance_name {EWMaker_0}



# Add INBUF_DIFF_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INBUF_DIFF} -instance_name {INBUF_DIFF_0}



# Add Init_Monitor_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {Init_Monitor} -instance_name {Init_Monitor_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:FABRIC_POR_N}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:PCIE_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:USRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:SRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Init_Monitor_0:XCVR_INIT_DONE}
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



# Add pf_reset_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {pf_reset} -instance_name {pf_reset_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:EXT_RST_N} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pf_reset_0:FPGA_POR_N} -value {VCC}



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
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPATTRN}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRMEMFIFODATA0} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRMEMFIFODATA1} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRDIAG1} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRDIAG0} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPAGEWR} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPAGERD} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SLOWCONTROLS_0:DDRPAGENO}



# Add TrackerCCC_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TrackerCCC} -instance_name {TrackerCCC_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TrackerCCC_0:PLL_LOCK_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:PADN" "ADC_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:PADP" "ADC_CLK_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:PADN" "CAL_CALEVEN_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_2:PADP" "CAL_CALEVEN_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_1:PADN" "CAL_CALODD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_1:PADP" "CAL_CALODD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_3:PADN" "CAL_CLK_OUT_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_3:PADP" "CAL_CLK_OUT_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:CAL_PREAMP_CE1n" "CAL_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:CAL_PREAMP_MISO" "CAL_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:CAL_PREAMP_MOSI" "CAL_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:CAL_PREAMP_SCLK" "CAL_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:CAL_PREAMP_CE0n" "CAL_PREMAP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:calscl" "calscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:calsda" "calsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:HCLK" "SLOWCONTROLS_0:PCLK" "pf_reset_0:CLK" "PF_SRAM_0:HCLK" "DIGIINTERFACE_0:RCLOCKSERIAL" "MIV_RV32IMC_C0_0:CLK" "TrackerCCC_0:REF_CLK_0" "CCC_0:OUT0_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_0:D" "CCC_0:OUT1_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:clk" "CCC_0:OUT3_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:PLL_LOCK" "CCC_0:PLL_LOCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CCC_0:REF_CLK_0" "CLKINT_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TCK" "COREJTAGDEBUG_C0_0:TGT_TCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TDI" "COREJTAGDEBUG_C0_0:TGT_TDI_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TMS" "COREJTAGDEBUG_C0_0:TGT_TMS_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TRST" "COREJTAGDEBUG_C0_0:TGT_TRSTB_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_EMPTY" "DIGIINTERFACE_0:EMPTYSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_FULL" "DIGIINTERFACE_0:FULLSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm_active" "ewm_active" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWMaker_0:ewm" "ewm_cal" "ewm_hv" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:PADN" "HV_CLK_OUT_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OUTBUF_DIFF_4:PADP" "HV_CLK_OUT_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:HV_PREAMP_CE0n" "HV_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:HV_PREAMP_CE1n" "HV_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:HV_PREAMP_MISO" "HV_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:HV_PREAMP_MOSI" "HV_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:HV_PREAMP_SCLK" "HV_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:hvscl" "hvscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:hvsda" "hvsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:Y" "CLKINT_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Init_Monitor_0:BANK_0_CALIB_STATUS" "AND3_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Init_Monitor_0:BANK_7_CALIB_STATUS" "AND3_0:C" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pf_reset_0:INIT_DONE" "Init_Monitor_0:DEVICE_INIT_DONE" "AND3_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_RXD_N" "LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_RXD_N_0" "LANE1_RXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_RXD_P" "LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_RXD_P_0" "LANE1_RXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_TXD_N" "LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_TXD_N_0" "LANE1_TXD_N_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_TXD_P" "LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE1_TXD_P_0" "LANE1_TXD_P_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:JTAG_TDO" "COREJTAGDEBUG_C0_0:TGT_TDO_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TRSTB" "NTRST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:HRESETN" "SLOWCONTROLS_0:PRESETN" "pf_reset_0:FABRIC_RESET_N" "PF_SRAM_0:HRESETN" "EWMaker_0:reset_n" "MIV_RV32IMC_C0_0:RESETN" "AND2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:PADN" "ROC_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INBUF_DIFF_0:PADP" "ROC_CLK_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "rocreset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:RX" "RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:REF_CLK_PAD_N" "SERDES_CAL_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:REF_CLK_PAD_P" "SERDES_CAL_CLK_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_RXD_N" "SERDES_CAL_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_RXD_P" "SERDES_CAL_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_TXD_N" "SERDES_CAL_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_TXD_P" "SERDES_CAL_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:REF_CLK_PAD_N_0" "SERDES_HV_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:REF_CLK_PAD_P_0" "SERDES_HV_CLK_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_RXD_N_0" "SERDES_HV_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_RXD_P_0" "SERDES_HV_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_TXD_N_0" "SERDES_HV_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIINTERFACE_0:LANE0_TXD_P_0" "SERDES_HV_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:ewm" "EWMaker_0:external_ewm" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:ewm_enable" "EWMaker_0:enable" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:PWM0" "OUTBUF_DIFF_1:D" "OUTBUF_DIFF_2:D" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:ROCRESET" "AND2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_RE" "DIGIINTERFACE_0:RESERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_RESET" "DIGIINTERFACE_0:RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI0_ADC0_CEn" "SPI0_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI0_ADC1_CEn" "SPI0_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI0_ADC2_CEn" "SPI0_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI0_MISO" "SPI0_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI0_MOSI" "SPI0_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI0_SCLK" "SPI0_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI1_ADC0_CEn" "SPI1_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI1_ADC1_CEn" "SPI1_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI1_ADC2_CEn" "SPI1_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI1_MISO" "SPI1_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI1_MOSI" "SPI1_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SPI1_SCLK" "SPI1_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TCK" "SWCLKTCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TMS" "SWDITMS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TDI" "TDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREJTAGDEBUG_C0_0:TDO" "TDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:tracker_clk" "OUTBUF_DIFF_4:D" "OUTBUF_DIFF_3:D" "EWMaker_0:clk" "TrackerCCC_0:OUT0_FABCLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:TX" "TX" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_DATA" "DIGIINTERFACE_0:QSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_RDCNT" "DIGIINTERFACE_0:RDCNTSERIAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:serdes_aligned" "DIGIINTERFACE_0:serdes_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:GPIO_OUT" "GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:event_window_early_cut" "EWMaker_0:event_window_early_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:event_window_late_cut" "EWMaker_0:event_window_late_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:ewm_delay" "EWMaker_0:delay" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SLOWCONTROLS_0:SERDES_HOWMANY" "DIGIINTERFACE_0:howmany" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:AHBL_M_SLV" "PF_SRAM_0:AHBSlaveInterface" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIV_RV32IMC_C0_0:APB_MSTR" "SLOWCONTROLS_0:APB3mmaster" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign ROC
generate_component -component_name ${sd_name}
