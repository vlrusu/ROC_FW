# Creating SmartDesign SLOWCONTROLS
set sd_name {SLOWCONTROLS}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {HCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_MOSI} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TX} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI0_ADC1_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HV_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE1n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAL_PREAMP_CE0n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PWM0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRCS} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRWEN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRREN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRDMAEN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCRESET} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_RE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_RESET} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {calsda} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {calscl} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hvsda} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {tracker_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ewm_enable} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRSEL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRFULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRMEMFIFOEMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRMEMFIFOFULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRMEMFIFO_RE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRSET} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRFIFO_RE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRTEMPFIFOEMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRTEMPFIFOFULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI1_ADC2_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {write_to_fifo} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {reset_fifo_n} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re3} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re0} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re1} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdes_re2} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PSEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PENABLE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PWRITE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PREADY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PSLVERR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SENSOR_MCP_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_MISO} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_ADC0_CEn} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_SCLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SPI2_MOSI} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRNHITS} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERDES_DATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERDES_RDCNT} -port_direction {IN} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERDES_HOWMANY} -port_direction {OUT} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewm_delay} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_early_cut} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_late_cut} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_aligned} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRPATTRN} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRMEMFIFODATA0} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRMEMFIFODATA1} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRDIAG1} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRDIAG0} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRPAGEWR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRPAGERD} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRPAGENO} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDRIN} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DDROFFSET} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token3} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token0} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token1} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {remote_token2} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out3} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out0} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out1} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_out2} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_status_address} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data3} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt0} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt1} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt2} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_rdcnt3} -port_direction {IN} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data0} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data1} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serdes_data2} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PADDR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRDATA} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PWDATA} -port_direction {IN} -port_range {[31:0]}

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



# Add APB3_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {APB3} -instance_name {APB3_0}



# Add counter32_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_0}



# Add GPIO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {GPIO} -instance_name {GPIO_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_0:INT}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_0:GPIO_IN} -value {VCC}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add PREAMPSPI_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PREAMPSPI} -instance_name {PREAMPSPI_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_0:SPISS} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_0:SPISS} -pin_slices {[1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_0:SPISS} -pin_slices {[2]}
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
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_1:SPISS} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PREAMPSPI_1:SPISS} -pin_slices {[1]}
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
sd_create_pin_slices -sd_name ${sd_name} -pin_name {pwm_0:PWM} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {pwm_0:PWM} -pin_slices {[1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pwm_0:PWM[1]}



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



# Add SPI0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SPI0} -instance_name {SPI0_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_0:SPISS} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_0:SPISS} -pin_slices {[1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_0:SPISS} -pin_slices {[2]}
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
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_1:SPISS} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_1:SPISS} -pin_slices {[1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI0_1:SPISS} -pin_slices {[2]}
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
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI_KEY_0:SPISS} -pin_slices {[0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {SPI_KEY_0:SPISS} -pin_slices {[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPISS[7:1]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIINT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPITXRFM}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPISSI} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPICLKI} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIOEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_KEY_0:SPIMODE}



# Add sysservices_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {sysservices} -instance_name {sysservices_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {sysservices_0:USR_CMD_ERROR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {sysservices_0:USR_BUSY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {sysservices_0:SS_BUSY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {sysservices_0:USR_RDVLD}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {sysservices_0:SYSSERV_INIT_REQ}



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
sd_connect_pins -sd_name ${sd_name} -pin_names {"TVS_Interface_0:resetn_i" "AND2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_1:SPISS[0]" "CAL_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_1:SPISS[1]" "CAL_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_1:SPISDI" "CAL_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_1:SPISDO" "CAL_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:Y" "CAL_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:calscl" "calscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:calsda" "calsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRCS" "DDRCS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRDMAEN" "DDRDMAEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRFIFO_RE" "DDRFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRFULL" "DDRFULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRMEMFIFO_RE" "DDRMEMFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRMEMFIFOEMPTY" "DDRMEMFIFOEMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRMEMFIFOFULL" "DDRMEMFIFOFULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRREN" "DDRREN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRSEL" "DDRSEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRSET" "DDRSET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRTEMPFIFOEMPTY" "DDRTEMPFIFOEMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRTEMPFIFOFULL" "DDRTEMPFIFOFULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRWEN" "DDRWEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ewm" "ewm" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ewm_enable" "ewm_enable" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HCLK" "PREAMPSPI_1:PCLK" "SPI_KEY_0:PCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "HRESETN" "PREAMPSPI_1:PRESETN" "SPI_KEY_0:PRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_0:SPISS[0]" "HV_PREAMP_CE0n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_0:SPISS[1]" "HV_PREAMP_CE1n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_0:SPISDI" "HV_PREAMP_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_0:SPISDO" "HV_PREAMP_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_0:SPISCLKO" "HV_PREAMP_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hvscl" "hvscl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:hvsda" "hvsda" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:B" "INV_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PCLK" "TVS_Interface_0:clk" "TVS_Interface_0:R_CLK" "UARTapb_0:PCLK" "PREAMPSPI_0:PCLK" "counter32_0:clk" "GPIO_0:PCLK" "pwm_0:PCLK" "Registers_0:PCLK" "SPI0_0:PCLK" "SPI0_1:PCLK" "sysservices_0:CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PREAMPSPI_1:SPISCLKO" "MX2_0:A" "INV_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRESETN" "UARTapb_0:PRESETN" "PREAMPSPI_0:PRESETN" "GPIO_0:PRESETN" "pwm_0:PRESETN" "Registers_0:PRESETn" "SPI0_0:PRESETN" "SPI0_1:PRESETN" "sysservices_0:RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pwm_0:PWM[0]" "PWM0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:S" "Registers_0:INVERTCALSPICLCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_0:en" "Registers_0:TIMERENABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_0:rst_n" "Registers_0:TIMERRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:reset_fifo_n" "reset_fifo_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "Registers_0:ROCRESET" "ROCRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"UARTapb_0:RX" "RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SENSOR_MCP_CEn" "PREAMPSPI_0:SPISS[2]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_EMPTY" "SERDES_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_FULL" "SERDES_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_RE" "SERDES_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re0" "serdes_re0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re1" "serdes_re1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re2" "serdes_re2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_re3" "serdes_re3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_RESET" "SERDES_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISS[0]" "SPI0_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISS[1]" "SPI0_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISS[2]" "SPI0_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISDI" "SPI0_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISDO" "SPI0_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_0:SPISCLKO" "SPI0_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISS[0]" "SPI1_ADC0_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISS[1]" "SPI1_ADC1_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISS[2]" "SPI1_ADC2_CEn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISDI" "SPI1_MISO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISDO" "SPI1_MOSI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_1:SPISCLKO" "SPI1_SCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_ADC0_CEn" "SPI_KEY_0:SPISS[0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_MISO" "SPI_KEY_0:SPISDI" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_MOSI" "SPI_KEY_0:SPISDO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_SCLK" "SPI_KEY_0:SPISCLKO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:tracker_clk" "tracker_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"UARTapb_0:TX" "TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:write_to_fifo" "write_to_fifo" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_0:cnt" "Registers_0:TIMERCOUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRDIAG0" "Registers_0:DDRDIAG0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRDIAG1" "Registers_0:DDRDIAG1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRIN" "Registers_0:DDRIN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRMEMFIFODATA0" "Registers_0:DDRMEMFIFODATA0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRMEMFIFODATA1" "Registers_0:DDRMEMFIFODATA1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:DDRNHITS" "DDRNHITS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDROFFSET" "Registers_0:DDROFFSET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRPAGENO" "Registers_0:DDRPAGENO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRPAGERD" "Registers_0:DDRPAGERD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRPAGEWR" "Registers_0:DDRPAGEWR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRPATTRN" "Registers_0:DDRPATTRN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dummy_status_address" "Registers_0:dummy_status_address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dummy_status_out0" "Registers_0:dummy_status_out0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dummy_status_out1" "Registers_0:dummy_status_out1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dummy_status_out2" "Registers_0:dummy_status_out2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dummy_status_out3" "Registers_0:dummy_status_out3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_window_early_cut" "Registers_0:event_window_early_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_window_late_cut" "Registers_0:event_window_late_cut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewm_delay" "Registers_0:ewm_delay" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_0:GPIO_OUT" "GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ROCTVS_ADDR" "TVS_Interface_0:R_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"remote_token0" "Registers_0:remote_token0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"remote_token1" "Registers_0:remote_token1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"remote_token2" "Registers_0:remote_token2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"remote_token3" "Registers_0:remote_token3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_aligned" "serdes_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_DATA" "SERDES_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data0" "serdes_data0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data1" "serdes_data1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data2" "serdes_data2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:serdes_data3" "serdes_data3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_HOWMANY" "SERDES_HOWMANY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:SERDES_RDCNT" "SERDES_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_rdcnt0" "Registers_0:serdes_rdcnt0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_rdcnt1" "Registers_0:serdes_rdcnt1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_rdcnt2" "Registers_0:serdes_rdcnt2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"serdes_rdcnt3" "Registers_0:serdes_rdcnt3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Registers_0:ROCTVS_VAL" "TVS_Interface_0:R_DATA" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave0" "GPIO_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave1" "pwm_0:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave2" "Registers_0:BIF_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave3" "UARTapb_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave4" "SPI0_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave5" "SPI0_1:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave6" "PREAMPSPI_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave7" "PREAMPSPI_1:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"sysservices_0:APBSlave" "APB3_0:APBmslave8" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APBmslave9" "SPI_KEY_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB3_0:APB3mmaster" "APB3mmaster" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign SLOWCONTROLS
generate_component -component_name ${sd_name}
