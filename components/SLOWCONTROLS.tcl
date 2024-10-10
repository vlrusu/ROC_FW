# Creating SmartDesign SLOWCONTROLS
set sd_name {SLOWCONTROLS}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISDI} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CMD_IN_WE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_CLK_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_TX_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRCTRLREADY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DI} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_RST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FLASH} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISDI} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {IFACE} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PENABLE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_LOCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_ON} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PSEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PWRITE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane0_aligned} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane1_aligned} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_cal_init} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_enable_fiber_clock} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_enable_fiber_marker} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_ewm_enable_50mhz} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_force_full} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_hv_init} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane0_aligned} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane1_aligned} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISCLKO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CALPROGSPISS} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_RX_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_RX_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_TX_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_TX_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRPTTREN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_RESETN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIDEVICE_RESETN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DO} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DTCALIGN_RESETN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISCLKO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISDO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HVPROGSPISS} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_FCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_ERRORCLR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_ERROROUT} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PREADY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PSLVERR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PWM0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SENSOR_MCP_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_RE} -port_direction {OUT}
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
sd_create_scalar_port -sd_name ${sd_name} -port_name {TX} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {align_roc_to_digi} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane0_pcs_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane0_pma_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane1_pcs_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_lane1_pma_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {cal_serdes_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {calscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_cal_busy} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_hv_busy} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dtc_enable_reset} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dtc_serdes_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {enable_fiber_clock} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {enable_fiber_marker} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_50mhz} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_enable_50mhz} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {force_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane0_pcs_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane0_pma_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane1_pcs_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_lane1_pma_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hv_serdes_reset_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {reset_fifo_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re2} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re3} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {use_uart} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {write_to_fifo} -port_direction {OUT}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CLK} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MOSI} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SS} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {calsda} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvsda} -port_direction {INOUT}

# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {CMD_IN_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRERROR} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRSIZERD} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRSIZEWR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PADDR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRBS_ERRORCNT} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PWDATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERDES_DATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERDES_RDCNT} -port_direction {IN} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane0_alignment} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane0_error_count} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane1_alignment} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {cal_lane1_error_count} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_cal_addr} -port_direction {IN} -port_range {[8:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_cal_data} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_hv_addr} -port_direction {IN} -port_range {[8:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_hv_data} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_use_lane} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out0} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out1} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out2} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out3} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {error_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane0_alignment} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane0_error_count} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane1_alignment} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hv_lane1_error_count} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token0} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token1} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token2} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token3} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_aligned} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data0} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data1} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data2} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data3} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt0} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt1} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt2} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt3} -port_direction {IN} -port_range {[12:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_CMD_STATUS} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_DIAG_DATA} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_RX_WRCNT} -port_direction {OUT} -port_range {[10:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_TX_Q} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_TX_WRCNT} -port_direction {OUT} -port_range {[10:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRDATA} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERDES_HOWMANY} -port_direction {OUT} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_cal_data_out} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_hv_data_out} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_address} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {error_address} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_early_cut} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_expected} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_late_cut} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewm_delay} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {use_lane} -port_direction {OUT} -port_range {[3:0]}


# Create top level Bus interface Ports
sd_create_bif_port -sd_name ${sd_name} -port_name {APB3mmaster} -port_bif_vlnv {AMBA:AMBA2:APB:r0p0} -port_bif_role {mirroredMaster} -port_bif_mapping {\
"PADDR:PADDR" \
"PSELx:PSEL" \
"PENABLE:PENABLE" \
"PWRITE:PWRITE" \
"PRDATA:PRDATA" \
"PWDATA:PWDATA" \
"PREADY:PREADY" \
"PSLVERR:PSLVERR" } 

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add APB3_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {APB3} -instance_name {APB3_0}



# Add CAL_SPI_PROG_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAL_SPI_PROG} -instance_name {CAL_SPI_PROG_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {CAL_SPI_PROG_0:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {CAL_SPI_PROG_0:SPISS} -pin_slices {[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPISS[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_0:SPIMODE}



# Add CAL_SPI_PROG_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAL_SPI_PROG} -instance_name {CAL_SPI_PROG_1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {CAL_SPI_PROG_1:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {CAL_SPI_PROG_1:SPISS} -pin_slices {[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPISS[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CAL_SPI_PROG_1:SPIMODE}



# Add CMD_TO_PROC_BUFFER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CMD_TO_PROC_BUFFER} -instance_name {CMD_TO_PROC_BUFFER_0}



# Add CORESPI_IAP_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORESPI_IAP} -instance_name {CORESPI_IAP_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {CORESPI_IAP_0:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {CORESPI_IAP_0:SPISS} -pin_slices {[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORESPI_IAP_0:SPISS[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORESPI_IAP_0:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORESPI_IAP_0:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORESPI_IAP_0:SPITXRFM}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORESPI_IAP_0:SPIMODE}



# Add counter32_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_0}



# Add DCS_RX_BUFFER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DCS_RX_BUFFER} -instance_name {DCS_RX_BUFFER_0}



# Add DCS_TX_BUFFER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DCS_TX_BUFFER} -instance_name {DCS_TX_BUFFER_0}



# Add DCSRegisters_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {DCSRegisters} -instance_name {DCSRegisters_0}
# Exporting Parameters of instance DCSRegisters_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {DCSRegisters_0} -params {\
"APB_ADDRESS_WIDTH:32" \
"APB_DATA_WIDTH:32" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {DCSRegisters_0}
sd_update_instance -sd_name ${sd_name} -instance_name {DCSRegisters_0}



# Add GPIO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {GPIO} -instance_name {GPIO_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_0:INT}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_0:GPIO_IN} -value {VCC}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add LeakMux_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {LeakMux} -hdl_file {hdl\LeakMux.vhd} -instance_name {LeakMux_0}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add PF_SPI_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {PF_SPI} -instance_name {PF_SPI_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_SPI_0:FAB_SPI_OWNER}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_SPI_0:CLK_OE} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_SPI_0:SS_OE} -value {VCC}



# Add PF_SYSTEM_SERVICES_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_SYSTEM_SERVICES_C0} -instance_name {PF_SYSTEM_SERVICES_C0_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_SYSTEM_SERVICES_C0_0:USR_CMD_ERROR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_SYSTEM_SERVICES_C0_0:USR_BUSY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_SYSTEM_SERVICES_C0_0:SS_BUSY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_SYSTEM_SERVICES_C0_0:USR_RDVLD}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_SYSTEM_SERVICES_C0_0:SYSSERV_INIT_REQ}



# Add PREAMPSPI_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PREAMPSPI} -instance_name {PREAMPSPI_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_0:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_0:SPISS} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_0:SPISS} -pin_slices {[2:2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_0:SPISS} -pin_slices {[7:3]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPISS[7:3]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_0:SPIMODE}



# Add PREAMPSPI_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PREAMPSPI} -instance_name {PREAMPSPI_1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_1:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_1:SPISS} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_1:SPISS} -pin_slices {[7:2]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPISS[7:2]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PREAMPSPI_1:SPIMODE}



# Add pwm_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {pwm} -instance_name {pwm_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {pwm_0:PWM} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {pwm_0:PWM} -pin_slices {[1:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pwm_0:PWM[1:1]}



# Add Registers_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {Registers} -instance_name {Registers_0}
# Exporting Parameters of instance Registers_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {Registers_0} -params {\
"APB_ADDRESS_WIDTH:32" \
"APB_DATA_WIDTH:32" \
"CB_ADDRESS_WIDTH:6" \
"SERDES_ADDRESS_WIDTH:10" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {Registers_0}
sd_update_instance -sd_name ${sd_name} -instance_name {Registers_0}



# Add SPI0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SPI0} -instance_name {SPI0_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_0:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_0:SPISS} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_0:SPISS} -pin_slices {[2:2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_0:SPISS} -pin_slices {[7:3]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_0:SPISS[7:3]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_0:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_0:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_0:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI0_0:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI0_0:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_0:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_0:SPIMODE}



# Add SPI0_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SPI0} -instance_name {SPI0_1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_1:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_1:SPISS} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_1:SPISS} -pin_slices {[2:2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_1:SPISS} -pin_slices {[7:3]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_1:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_1:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_1:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI0_1:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI0_1:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_1:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_1:SPIMODE}



# Add SPI_KEY_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SPI_KEY} -instance_name {SPI_KEY_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI_KEY_0:SPISS} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI_KEY_0:SPISS} -pin_slices {[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPISS[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIMODE}



# Add TVS_Interface_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TVS_Interface} -instance_name {TVS_Interface_0}



# Add UARTapb_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {UARTapb} -instance_name {UARTapb_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {UARTapb_0:TXRDY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {UARTapb_0:RXRDY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {UARTapb_0:PARITY_ERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {UARTapb_0:OVERFLOW}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {UARTapb_0:FRAMING_ERR}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "AND2_1:B" "CAL_SPI_PROG_0:PRESETN" "CAL_SPI_PROG_1:PRESETN" "CORESPI_IAP_0:PRESETN" "GPIO_0:PRESETN" "PF_SYSTEM_SERVICES_C0_0:RESETN" "PREAMPSPI_0:PRESETN" "PREAMPSPI_1:PRESETN" "PRESETN" "Registers_0:PRESETn" "SPI0_0:PRESETN" "SPI0_1:PRESETN" "SPI_KEY_0:PRESETN" "UARTapb_0:PRESETN" "pwm_0:PRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "Registers_0:TVS_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "TVS_Interface_0:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:A" "EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:Y" "CMD_TO_PROC_BUFFER_0:RRESET_N" "DCSRegisters_0:PRESETn" "DCS_RX_BUFFER_0:RESET_N" "DCS_TX_BUFFER_0:WRESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISCLKO" "CAL_SPI_PROG_0:SPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISDI" "CAL_SPI_PROG_0:SPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISDO" "CAL_SPI_PROG_0:SPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CALPROGSPISS" "CAL_SPI_PROG_0:SPISS[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE0n" "PREAMPSPI_1:SPISS[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_CE1n" "PREAMPSPI_1:SPISS[1:1]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MISO" "PREAMPSPI_1:SPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_MOSI" "PREAMPSPI_1:SPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_PREAMP_SCLK" "MX2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_SPI_PROG_0:PCLK" "CAL_SPI_PROG_1:PCLK" "CMD_TO_PROC_BUFFER_0:RCLOCK" "CORESPI_IAP_0:PCLK" "DCSRegisters_0:PCLK" "DCS_RX_BUFFER_0:CLK" "DCS_TX_BUFFER_0:WCLOCK" "GPIO_0:PCLK" "PCLK" "PF_SYSTEM_SERVICES_C0_0:CLK" "PREAMPSPI_0:PCLK" "PREAMPSPI_1:PCLK" "Registers_0:PCLK" "SPI0_0:PCLK" "SPI0_1:PCLK" "SPI_KEY_0:PCLK" "TVS_Interface_0:R_CLK" "TVS_Interface_0:clk" "UARTapb_0:PCLK" "counter32_0:clk" "pwm_0:PCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_SPI_PROG_1:SPISCLKO" "HVPROGSPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_SPI_PROG_1:SPISDI" "HVPROGSPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_SPI_PROG_1:SPISDO" "HVPROGSPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAL_SPI_PROG_1:SPISS[0:0]" "HVPROGSPISS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLK" "PF_SPI_0:CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_IN_WE" "CMD_TO_PROC_BUFFER_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_TO_PROC_BUFFER_0:EMPTY" "DCSRegisters_0:PROC_CMD_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_TO_PROC_BUFFER_0:FULL" "DCSRegisters_0:PROC_CMD_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_TO_PROC_BUFFER_0:RE" "DCSRegisters_0:PROC_CMD_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_TO_PROC_BUFFER_0:WCLOCK" "DCS_CLK" "DCS_TX_BUFFER_0:RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_TO_PROC_BUFFER_0:WRESET_N" "DCS_CLK_RESETN" "DCS_TX_BUFFER_0:RRESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORESPI_IAP_0:SPICLKI" "PF_SPI_0:CLK_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORESPI_IAP_0:SPIOEN" "PF_SPI_0:D_OE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORESPI_IAP_0:SPISCLKO" "PF_SPI_0:CLK_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORESPI_IAP_0:SPISDI" "PF_SPI_0:D_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORESPI_IAP_0:SPISDO" "PF_SPI_0:D_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORESPI_IAP_0:SPISSI" "PF_SPI_0:SS_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORESPI_IAP_0:SPISS[0:0]" "PF_SPI_0:SS_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_RX_EMPTY" "DCS_RX_BUFFER_0:EMPTY" "DCS_RX_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_RX_FULL" "DCS_RX_BUFFER_0:FULL" "DCS_RX_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_RX_RE" "DCS_RX_BUFFER_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_RX_WE" "DCS_RX_BUFFER_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_TX_WE" "DCS_TX_BUFFER_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TX_BUFFER_0:EMPTY" "DCS_TX_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TX_BUFFER_0:FULL" "DCS_TX_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TX_BUFFER_0:RE" "DCS_TX_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRCTRLREADY" "Registers_0:DDRCTRLREADY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRPTTREN" "Registers_0:DDRPTTREN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_RESETN" "Registers_0:DDR_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DI" "PF_SPI_0:DI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIDEVICE_RESETN" "Registers_0:DIGIDEVICE_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DO" "PF_SPI_0:DO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCALIGN_RESETN" "Registers_0:DTCALIGN_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FLASH" "PF_SPI_0:FLASH" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE0n" "PREAMPSPI_0:SPISS[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_CE1n" "PREAMPSPI_0:SPISS[1:1]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_FCLK" "LeakMux_0:HV_PREAMP_FCLK_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MISO" "PREAMPSPI_0:SPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_MOSI" "LeakMux_0:HV_PREAMP_MOSI_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HV_PREAMP_SCLK" "PREAMPSPI_0:SPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IFACE" "PF_SPI_0:IFACE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:A" "MX2_0:A" "PREAMPSPI_1:SPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:Y" "MX2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LeakMux_0:HV_PREAMP_MOSI" "PREAMPSPI_0:SPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LeakMux_0:LEAK_SCL" "Registers_0:leak_scl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LeakMux_0:LEAK_SDA_DIR" "Registers_0:leak_sdir" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LeakMux_0:LEAK_SDI" "Registers_0:leak_sdi" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LeakMux_0:LEAK_SDO" "Registers_0:leak_sdo" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LeakMux_0:muxselect" "Registers_0:leak_muxselect" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:S" "Registers_0:INVERTCALSPICLCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_SPI_0:SS" "SS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_EN" "Registers_0:PRBS_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_ERRORCLR" "Registers_0:PRBS_ERRORCLR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_ERROROUT" "Registers_0:PRBS_ERROROUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_LOCK" "Registers_0:PRBS_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_ON" "Registers_0:PRBS_ON" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_0:SPISS[2:2]" "SENSOR_MCP_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PWM0" "pwm_0:PWM[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX" "UARTapb_0:RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_EMPTY" "SERDES_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_FULL" "SERDES_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_RE" "SERDES_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:TIMERENABLE" "counter32_0:en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:TIMERRESET" "counter32_0:rst_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:align_roc_to_digi" "align_roc_to_digi" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_busy" "dcs_cal_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane0_aligned" "cal_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane0_pcs_reset_n" "cal_lane0_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane0_pma_reset_n" "cal_lane0_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane1_aligned" "cal_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane1_pcs_reset_n" "cal_lane1_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane1_pma_reset_n" "cal_lane1_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_serdes_reset_n" "cal_serdes_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:calscl" "calscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:calsda" "calsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_cal_init" "dcs_cal_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_enable_fiber_clock" "dcs_enable_fiber_clock" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_enable_fiber_marker" "dcs_enable_fiber_marker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_ewm_enable_50mhz" "dcs_ewm_enable_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_force_full" "dcs_force_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_hv_init" "dcs_hv_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dtc_enable_reset" "dtc_enable_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dtc_serdes_reset_n" "dtc_serdes_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:enable_fiber_clock" "enable_fiber_clock" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:enable_fiber_marker" "enable_fiber_marker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ewm_50mhz" "ewm_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ewm_enable_50mhz" "ewm_enable_50mhz" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:force_full" "force_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_busy" "dcs_hv_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane0_aligned" "hv_lane0_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane0_pcs_reset_n" "hv_lane0_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane0_pma_reset_n" "hv_lane0_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane1_aligned" "hv_lane1_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane1_pcs_reset_n" "hv_lane1_pcs_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane1_pma_reset_n" "hv_lane1_pma_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_serdes_reset_n" "hv_serdes_reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hvscl" "hvscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hvsda" "hvsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:reset_fifo_n" "reset_fifo_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re0" "serdes_re0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re1" "serdes_re1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re2" "serdes_re2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re3" "serdes_re3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:use_uart" "use_uart" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:write_to_fifo" "write_to_fifo" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISCLKO" "SPI0_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISDI" "SPI0_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISDO" "SPI0_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISS[0:0]" "SPI0_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISS[1:1]" "SPI0_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISS[2:2]" "SPI0_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISCLKO" "SPI1_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISDI" "SPI1_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISDO" "SPI1_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISS[0:0]" "SPI1_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISS[1:1]" "SPI1_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISS[2:2]" "SPI1_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_ADC0_CEn" "SPI_KEY_0:SPISS[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_MISO" "SPI_KEY_0:SPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_MOSI" "SPI_KEY_0:SPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_SCLK" "SPI_KEY_0:SPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX" "UARTapb_0:TX" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_IN_DATA" "CMD_TO_PROC_BUFFER_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_TO_PROC_BUFFER_0:Q" "DCSRegisters_0:PROC_CMD_DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_TO_PROC_BUFFER_0:RDCNT" "DCSRegisters_0:PROC_CMD_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_CMD_STATUS" "DCS_CMD_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_DIAG_DATA" "DCS_DIAG_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_RX_IN" "DCS_RX_BUFFER_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_RX_OUT" "DCS_RX_BUFFER_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSRegisters_0:DCS_TX_IN" "DCS_TX_BUFFER_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RX_BUFFER_0:WRCNT" "DCS_RX_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TX_BUFFER_0:Q" "DCS_TX_Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TX_BUFFER_0:WRCNT" "DCS_TX_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRERROR" "Registers_0:DDRERROR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRSIZERD" "Registers_0:DDRSIZERD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRSIZEWR" "Registers_0:DDRSIZEWR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_0:GPIO_OUT" "GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_ERRORCNT" "Registers_0:PRBS_ERRORCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ROCTVS_ADDR" "TVS_Interface_0:R_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ROCTVS_VAL" "TVS_Interface_0:R_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_DATA" "SERDES_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_HOWMANY" "SERDES_HOWMANY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_RDCNT" "SERDES_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:TIMERCOUNTER" "counter32_0:cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_data_out" "dcs_cal_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane0_alignment" "cal_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane0_error_count" "cal_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane1_alignment" "cal_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:cal_lane1_error_count" "cal_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_cal_addr" "dcs_cal_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_cal_data" "dcs_cal_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_hv_addr" "dcs_hv_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_hv_data" "dcs_hv_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dcs_use_lane" "dcs_use_lane" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dummy_status_address" "dummy_status_address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dummy_status_out0" "dummy_status_out0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dummy_status_out1" "dummy_status_out1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dummy_status_out2" "dummy_status_out2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:dummy_status_out3" "dummy_status_out3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:error_address" "error_address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:error_counter" "error_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:event_window_early_cut" "event_window_early_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:event_window_expected" "event_window_expected" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:event_window_late_cut" "event_window_late_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ewm_delay" "ewm_delay" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_data_out" "dcs_hv_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane0_alignment" "hv_lane0_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane0_error_count" "hv_lane0_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane1_alignment" "hv_lane1_alignment" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hv_lane1_error_count" "hv_lane1_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:remote_token0" "remote_token0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:remote_token1" "remote_token1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:remote_token2" "remote_token2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:remote_token3" "remote_token3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_aligned" "serdes_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data0" "serdes_data0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data1" "serdes_data1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data2" "serdes_data2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data3" "serdes_data3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_rdcnt0" "serdes_rdcnt0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_rdcnt1" "serdes_rdcnt1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_rdcnt2" "serdes_rdcnt2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_rdcnt3" "serdes_rdcnt3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:use_lane" "use_lane" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APB3mmaster" "APB3mmaster" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave0" "GPIO_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave1" "pwm_0:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave10" "DCSRegisters_0:BIF_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave11" "CORESPI_IAP_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave12" "CAL_SPI_PROG_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave13" "CAL_SPI_PROG_1:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave2" "Registers_0:BIF_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave3" "UARTapb_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave4" "SPI0_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave5" "SPI0_1:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave6" "PREAMPSPI_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave7" "PREAMPSPI_1:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave8" "PF_SYSTEM_SERVICES_C0_0:APBSlave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave9" "SPI_KEY_0:APB_bif" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign SLOWCONTROLS
generate_component -component_name ${sd_name}
