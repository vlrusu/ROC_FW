# Creating SmartDesign TOP_SERDES
set sd_name {TOP_SERDES}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_DATA_READY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_LAST_WORD} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_DDR3_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DTCSIM_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ENABLE_ALIGNMENT} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PLL_LOCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_FULL} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CLOCK_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_RE_FIFO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_START_EVENT} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DDRRESET} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DREQ_SEL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_MEMFIFO_REN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_PATTERN_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_READ_MEM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_WRITE_MEM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCS_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TX_RESETN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {eventwindowmarker} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {word_aligned} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_DATA} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_PACKETS_IN_EVENT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_STATUS} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DTCSIM_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DTCSIM_KCHAR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {FIFO_RD_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEM_RD_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEM_WR_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRBS_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRBS_KCHAR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {address} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_expected} -port_direction {IN} -port_range {[15:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {ALIGNMENT_LOSS_COUNTER} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_EVENT_WINDOW_TAG1} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_EVENT_WINDOW_TAG2} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_PATTERN} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_WRITE_PAGE_NO} -port_direction {OUT} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DTCDATA_OUT} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {counter_out} -port_direction {OUT} -port_range {[7:0]}


# Add crc_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {crc_0}



# Add crc_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {crc_1}



# Add DCSClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {DCSClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCSClkReset:PLL_POWERDOWN_B}



# Add DCSProcessor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DCSProcessor} -hdl_file {hdl\DCSProcessor.vhd} -instance_name {DCSProcessor_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCSProcessor_0:state_count}



# Add DRACRegisters_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DRACRegisters} -hdl_file {hdl\DRACRegisters.vhd} -instance_name {DRACRegisters_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DRACRegisters_0:PREREAD_PULSE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DRACRegisters_0:DEBUG_REG_0} -value {0001001000110100}



# Add DReqClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {DReqClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DReqClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DReqClkReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DReqClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DReqClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DReqClkReset:PLL_POWERDOWN_B}



# Add DREQProcessor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DREQProcessor} -hdl_file {hdl\DREQProcessor.vhd} -instance_name {DREQProcessor_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DREQProcessor_0:DATAREQ_EVENT_WINDOW_TAG2}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DREQProcessor_0:dreq_state_count}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add pulse_stretcher_SELRST instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_SELRST}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_SELRST:polarity_i} -value {VCC}



# Add RXClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {RXClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RXClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RXClkReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RXClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RXClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RXClkReset:PLL_POWERDOWN_B}



# Add RxPacketFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxPacketFIFO} -instance_name {RxPacketFIFO_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:DATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:DATA} -pin_slices {[19:16]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:DATA[19:16]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:Q} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_0:Q} -pin_slices {[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:Q[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_0:EMPTY}



# Add RxPacketFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxPacketFIFO} -instance_name {RxPacketFIFO_1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:DATA} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:DATA} -pin_slices {[19:18]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxPacketFIFO_1:DATA[19:18]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:Q} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_1:Q} -pin_slices {[19:18]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_1:Q[19:18]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_1:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_1:EMPTY}



# Add RxPacketFIFO_2 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxPacketFIFO} -instance_name {RxPacketFIFO_2}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_2:DATA} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_2:DATA} -pin_slices {[19:16]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxPacketFIFO_2:DATA[19:16]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_2:Q} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_2:Q} -pin_slices {[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_2:Q[19:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_2:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_2:EMPTY}



# Add RxPacketFIFO_3 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RxPacketFIFO} -instance_name {RxPacketFIFO_3}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_3:DATA} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_3:DATA} -pin_slices {[19:18]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RxPacketFIFO_3:DATA[19:18]} -value {GND}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_3:Q} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketFIFO_3:Q} -pin_slices {[19:18]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_3:Q[19:18]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_3:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketFIFO_3:EMPTY}



# Add RxPacketReader_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {RxPacketReader} -hdl_file {hdl\RxPacketReader.vhd} -instance_name {RxPacketReader_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:clockmarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:loopmarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:othermarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:retrmarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:HEARTBEAT_EVENT_WINDOW_TAG}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:retr_seq}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:event_marker_count}



# Add TXClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {TXClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TXClkReset:PLL_POWERDOWN_B}



# Add TxPacketWriter_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {TxPacketWriter} -hdl_file {hdl\TxPacketWriter.vhd} -instance_name {TxPacketWriter_0}



# Add XCVR_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_Block} -instance_name {XCVR_Block_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:LANE0_RX_VAL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:B_CERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:RD_ERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:CODE_ERR_N}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_Block_0:INVALID_K}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "XCVR_Block_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "XCVR_Block_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:DATAREQ_DATA_READY" "DATAREQ_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:DATAREQ_LAST_WORD" "DATAREQ_LAST_WORD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:DATAREQ_RE_FIFO" "DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:DATAREQ_START_EVENT" "DATAREQ_START_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_stretcher_SELRST:clk_i" "RxPacketFIFO_0:RCLOCK" "RxPacketFIFO_1:WCLOCK" "crc_0:CLK" "DCSClkReset:CLK" "DCSProcessor_0:clk" "DCS_CLK" "DRACRegisters_0:DCS_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:Y" "RXClkReset:EXT_RST_N" "DCSClkReset:EXT_RST_N" "DReqClkReset:EXT_RST_N" "TXClkReset:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSClkReset:FABRIC_RESET_N" "DCSProcessor_0:reset_n" "DRACRegisters_0:RESET_N" "RxPacketFIFO_0:RRESET_N" "RxPacketFIFO_1:WRESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXClkReset:FPGA_POR_N" "DCSClkReset:FPGA_POR_N" "DReqClkReset:FPGA_POR_N" "FPGA_POR_N" "TXClkReset:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXClkReset:INIT_DONE" "DCSClkReset:INIT_DONE" "DReqClkReset:INIT_DONE" "INIT_DONE" "TXClkReset:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSClkReset:PLL_LOCK" "PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_en" "crc_0:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_rst" "crc_0:RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_re" "RxPacketFIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_we" "RxPacketFIFO_1:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:read_reg" "DRACRegisters_0:READ_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:ready_reg" "DRACRegisters_0:READY_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:write_reg" "DRACRegisters_0:WRITE_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DDRRESET" "DRACRegisters_0:DCS_DDRRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQ_SEL" "DRACRegisters_0:DCS_DREQ_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_MEMFIFO_REN" "DRACRegisters_0:DCS_MEMFIFO_REN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_PATTERN_EN" "DRACRegisters_0:DCS_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_READ_MEM_EN" "DRACRegisters_0:DCS_READ_MEM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_WRITE_MEM_EN" "DRACRegisters_0:DCS_WRITE_MEM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_DDR3_FULL" "DRACRegisters_0:DDR_DDR3_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_EMPTY" "DRACRegisters_0:MEMFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_FULL" "DRACRegisters_0:MEMFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_stretcher_SELRST:pulse_i" "DRACRegisters_0:SEL_RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TEMPFIFO_EMPTY" "DRACRegisters_0:TEMPFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TEMPFIFO_FULL" "DRACRegisters_0:TEMPFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:RCLOCK" "RxPacketFIFO_3:WCLOCK" "crc_1:CLK" "DReqClkReset:CLK" "DREQProcessor_0:clk" "DREQ_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_1:CRC_EN" "DREQProcessor_0:crc_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_1:RST" "DREQProcessor_0:crc_rst" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:RE" "DREQProcessor_0:dreq_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:WE" "DREQProcessor_0:dreq_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:reset_n" "DReqClkReset:FABRIC_RESET_N" "RxPacketFIFO_2:RRESET_N" "RxPacketFIFO_3:WRESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXClkReset:PLL_LOCK" "DReqClkReset:PLL_LOCK" "XCVR_Block_0:LANE0_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSIM_EN" "XCVR_Block_0:DTCSIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ENABLE_ALIGNMENT" "XCVR_Block_0:ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:A" "pulse_stretcher_SELRST:gate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:WCLOCK" "RXClkReset:CLK" "RxPacketFIFO_0:WCLOCK" "LANE0_RX_CLK_R" "XCVR_Block_0:LANE0_RX_CLK_R" "RxPacketReader_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:RCLOCK" "RxPacketFIFO_1:RCLOCK" "LANE0_TX_CLK_R" "TXClkReset:CLK" "TxPacketWriter_0:clk" "XCVR_Block_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PCS_ALIGNED" "XCVR_Block_0:PCS_ALIGNED" "RxPacketReader_0:aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_EN" "XCVR_Block_0:PRBS_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_stretcher_SELRST:resetn_i" "RESET_N" "XCVR_Block_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXClkReset:FABRIC_RESET_N" "RxPacketFIFO_0:WRESET_N" "RxPacketFIFO_2:WRESET_N" "RxPacketReader_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:WE" "RxPacketReader_0:rx_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:RE" "TxPacketWriter_0:dcs_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:RRESET_N" "RxPacketFIFO_3:RRESET_N" "TXClkReset:FABRIC_RESET_N" "TX_RESETN" "TxPacketWriter_0:reset_n" "XCVR_Block_0:TX_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:WE" "RxPacketReader_0:req_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:RE" "TxPacketWriter_0:dreq_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"eventwindowmarker" "XCVR_Block_0:ewm" "RxPacketReader_0:eventmarker" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TXClkReset:PLL_LOCK" "XCVR_Block_0:LANE0_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:word_aligned" "word_aligned" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNMENT_LOSS_COUNTER" "XCVR_Block_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:DATAREQ_DATA" "DATAREQ_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_EVENT_WINDOW_TAG1" "DREQProcessor_0:DATAREQ_EVENT_WINDOW_TAG1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_EVENT_WINDOW_TAG2" "RxPacketReader_0:PREFETCH_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:DATAREQ_PACKETS_IN_EVENT" "DATAREQ_PACKETS_IN_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_STATUS" "DREQProcessor_0:DATAREQ_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_data_in" "crc_0:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_data_out" "crc_0:DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:rx_crc_error" "DCSProcessor_0:error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:Q[15:0]" "DCSProcessor_0:fifo_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_data_out" "RxPacketFIFO_1:DATA[17:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:RDCNT" "DCSProcessor_0:fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:reg_address" "DRACRegisters_0:ADDR_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:reg_data_in" "DRACRegisters_0:DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:reg_data_out" "DRACRegisters_0:DATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_PATTERN" "DRACRegisters_0:DCS_PATTERN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_WRITE_PAGE_NO" "DRACRegisters_0:DCS_WRITE_PAGE_NO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_RD_CNT" "DRACRegisters_0:FIFO_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEM_RD_CNT" "DRACRegisters_0:MEM_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEM_WR_CNT" "DRACRegisters_0:MEM_WR_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_1:CRC_OUT" "DREQProcessor_0:crc_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"crc_1:DATA_IN" "DREQProcessor_0:crc_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_error_count" "XCVR_Block_0:dreq_crc_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:Q[15:0]" "DREQProcessor_0:dreq_fifo_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_fifo_out" "RxPacketFIFO_3:DATA[17:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:RDCNT" "DREQProcessor_0:dreq_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCDATA_OUT" "XCVR_Block_0:DTCDATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSIM_DATA" "XCVR_Block_0:DTCSIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSIM_KCHAR" "XCVR_Block_0:DTCSIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_DATA" "XCVR_Block_0:PRBS_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_KCHAR" "XCVR_Block_0:PRBS_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:DATA[15:0]" "RxPacketFIFO_0:DATA[15:0]" "RxPacketReader_0:rx_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:Q[17:0]" "TxPacketWriter_0:dcs_fifo_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:RDCNT" "TxPacketWriter_0:dcs_fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:Q[17:0]" "TxPacketWriter_0:dreq_fifo_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:RDCNT" "TxPacketWriter_0:dreq_fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:marker_error" "RxPacketReader_0:marker_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_DATA" "RxPacketReader_0:rx_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:rx_packet_error" "RxPacketReader_0:rx_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_K_CHAR" "RxPacketReader_0:rx_kchar_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:dtc_seq_error" "RxPacketReader_0:seq_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:TX_DATA" "TxPacketWriter_0:tx_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:TX_K_CHAR" "TxPacketWriter_0:tx_kchar_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"address" "XCVR_Block_0:address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter_out" "XCVR_Block_0:counter_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_window_expected" "XCVR_Block_0:event_window_expected" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TOP_SERDES
generate_component -component_name ${sd_name}
