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
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_PACKETS_OVFL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_TAG_ERROR} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DATA_ERR} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DREQ_FIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DREQ_FIFO_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_EVT_ERR} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_HDR1_ERR} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_HDR2_ERR} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_RX_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_RX_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_TX_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_TX_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DTCALIGN_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ENABLE_ALIGNMENT} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ERROR_CLEAR} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ERROR_IN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_RST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PLL_LOCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_cal_busy} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_hv_busy} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CLOCK_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CMD_IN_WE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_RE_FIFO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_START_EVENT} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DDRRESET} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DIGI_SIM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DLYD_EVM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_ENABLE_CLOCK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_ENABLE_MARKER} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_FORCE_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_INT_EVM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_PATTERN_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_PATTERN_TYPE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_RESETFIFO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_TX_RE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {END_EVM_SEEN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EWM} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FETCH_START} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FIRST_HB_SEEN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HALTRUN_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HEARTBEAT_SEEN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LAST_EWM} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {NEWRUN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ONSPILL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCS_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_LOCK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_ON} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RXCLK_RESETN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TAG_SYNC} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_cal_init} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dcs_hv_init} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_DATA} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_PACKETS_IN_EVT} -port_direction {IN} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_CMD_STATUS} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_DIAG_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_DREQCNT} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_DREQNULL} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_DREQREAD} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_DREQSENT} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_EVMCNT} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_FETCH_CNT} -port_direction {IN} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_FETCH_POS} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_FULLTAG} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_HBONHOLD} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_LANE_EMPTY} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_LANE_FULL} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_OFFSETTAG} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_RX_WRCNT} -port_direction {IN} -port_range {[10:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_SIM_LANE_EMPTY} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_SIM_LANE_FULL} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_STORE_CNT} -port_direction {IN} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_STORE_POS} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_TX_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_TX_WRCNT} -port_direction {IN} -port_range {[10:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {address_counter} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {data_expc} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {data_seen} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {datareq_state} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_cal_data_out} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_hv_data_out} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dreq_full_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {evt_expc} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {evt_seen} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_fifo_emptied_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewm_out_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_state} -port_direction {IN} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_event_tag} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_missing_TAG} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_missing_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_runover_TAG} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_runover_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_state} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_timeout_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_dreq_err_cnt} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_empty_overlap_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_tag_err_cnt} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_tag_full_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr1_expc} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr1_seen} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr2_expc} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr2_seen} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {next_read_event_tag} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {rocfifocntrl_state} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {skipped_DREQ_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {skipped_DREQ_tag} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {spilltag_full_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {start_fetch_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_error_counter} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_sync_err_cnt} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_valid_counter} -port_direction {IN} -port_range {[15:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {CMD_IN_DATA} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_EVENT_WINDOW_TAG} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_SIM_HIT} -port_direction {OUT} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_TAG_OFFSET} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_USE_LANE} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {FETCH_EVENT_WINDOW_TAG} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {HEARTBEAT_EVENT_WINDOW_TAG} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRBS_ERROR_COUNT} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PREFETCH_EVENT_WINDOW_TAG} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SPILL_EVENT_WINDOW_TAG} -port_direction {OUT} -port_range {[39:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {counter_out} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_cal_addr} -port_direction {OUT} -port_range {[8:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_cal_data} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_hv_addr} -port_direction {OUT} -port_range {[8:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dcs_hv_data} -port_direction {OUT} -port_range {[15:0]}


# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND2_0_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0_0}



# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add crc_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {crc_0}



# Add crc_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {crc_1}



# Add crc_2 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {crc_2}



# Add DCSClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {DCSClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DCSClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCSClkReset:PLL_POWERDOWN_B}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCSClkReset:FABRIC_RESET_N}



# Add DCSProcessor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DCSProcessor} -hdl_file {hdl\DCSProcessor.vhd} -instance_name {DCSProcessor_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCSProcessor_0:end_dcs_ops}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCSProcessor_0:blk_cnt_reg}



# Add DCSReadCMDProcessor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DCSReadCMDProcessor} -hdl_file {hdl\DCSReadCMDProcessor.vhd} -instance_name {DCSReadCMDProcessor_0}



# Add DCSWriteCMDProcessor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DCSWriteCMDProcessor} -hdl_file {hdl\DCSWriteCMDProcessor.vhd} -instance_name {DCSWriteCMDProcessor_0}



# Add delay_sreg_1bit_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {delay_sreg_1bit} -hdl_file {hdl\delay_sreg_1bit.vhd} -instance_name {delay_sreg_1bit_0}



# Add delay_sreg_1bit_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {delay_sreg_1bit} -hdl_file {hdl\delay_sreg_1bit.vhd} -instance_name {delay_sreg_1bit_1}



# Add delay_sreg_1bit_2 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {delay_sreg_1bit} -hdl_file {hdl\delay_sreg_1bit.vhd} -instance_name {delay_sreg_1bit_2}



# Add delay_sreg_1bit_3 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {delay_sreg_1bit} -hdl_file {hdl\delay_sreg_1bit.vhd} -instance_name {delay_sreg_1bit_3}



# Add DRACRegisters_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DRACRegisters} -hdl_file {hdl\DRACRegisters.vhd} -instance_name {DRACRegisters_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DRACRegisters_0:PREREAD_PULSE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DRACRegisters_0:DEBUG_REG_0} -value {0001001000110100}



# Add DREQProcessor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DREQProcessor} -hdl_file {hdl\DREQProcessor.vhd} -instance_name {DREQProcessor_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DREQProcessor_0:DATAREQ_STATUS} -value {GND}



# Add ErrorCounter_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {ErrorCounter} -hdl_file {hdl\ErrorCounter.vhd} -instance_name {ErrorCounter_0}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add INV_0_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0_0}



# Add PBRS_checker_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {PBRS_checker} -hdl_file {hdl\PBRS_checker.v} -instance_name {PBRS_checker_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PBRS_checker_0:ERROR_OUT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PBRS_checker_0:ERROR_DATA}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PBRS_checker_0:PATTERN_DATA}



# Add PRBS_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {PRBS_generator} -hdl_file {hdl\PRBS_generator.v} -instance_name {PRBS_generator_0}



# Add pulse_stretcher_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_0:polarity_i} -value {VCC}



# Add pulse_stretcher_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_stretcher} -hdl_file {hdl\pulse_stretcher.v} -instance_name {pulse_stretcher_1}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pulse_stretcher_1:polarity_i} -value {VCC}



# Add pulse_time_crossing_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_time_crossing} -hdl_file {hdl\pulse_time_crossing.v} -instance_name {pulse_time_crossing_0}



# Add req_err_switch_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {req_err_switch} -hdl_file {hdl\req_err_switch.v} -instance_name {req_err_switch_0}



# Add RXClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {RXClkReset}
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
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketReader_0:SPILL_EVENT_WINDOW_TAG} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketReader_0:rx_loopmarker_out} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {RxPacketReader_0:rx_loopmarker_out} -pin_slices {[17:16]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:HEARTBEAT_INVALID}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:clockmarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:othermarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:retrmarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:EVT_MODE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:RF_MARKER}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RxPacketReader_0:retr_seq}



# Add TXClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {TXClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TXClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TXClkReset:PLL_POWERDOWN_B}



# Add TxPacketWriter_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {TxPacketWriter} -hdl_file {hdl\TxPacketWriter.vhd} -instance_name {TxPacketWriter_0}



# Add XCVR_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_Block} -instance_name {XCVR_Block_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "INV_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "AND2_0_0:B" "DCSClkReset:EXT_RST_N" "DCSProcessor_0:reset_n" "DCSReadCMDProcessor_0:RESET_N" "DCSWriteCMDProcessor_0:RESET_N" "DRACRegisters_0:EXT_RST_N" "DREQProcessor_0:reset_n" "EXT_RST_N" "PBRS_checker_0:RESETCN" "PRBS_generator_0:RESETGN" "RXClkReset:EXT_RST_N" "RxPacketFIFO_1:RRESET_N" "RxPacketFIFO_1:WRESET_N" "RxPacketFIFO_3:RRESET_N" "RxPacketFIFO_3:WRESET_N" "RxPacketReader_0:roc_resetn" "TXClkReset:EXT_RST_N" "delay_sreg_1bit_0:resetn" "delay_sreg_1bit_1:resetn" "delay_sreg_1bit_2:resetn" "delay_sreg_1bit_3:resetn" "pulse_stretcher_0:resetn_i" "pulse_stretcher_1:resetn_i" "pulse_time_crossing_0:resetn_in" "pulse_time_crossing_0:resetn_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "RxPacketFIFO_0:RRESET_N" "RxPacketFIFO_0:WRESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0_0:A" "INV_0_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0_0:Y" "RxPacketFIFO_2:RRESET_N" "RxPacketFIFO_2:WRESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:A" "DRACRegisters_0:HRESETN" "HRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:B" "DTCALIGN_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:Y" "XCVR_Block_0:ALIGN_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "XCVR_Block_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_IN_WE" "DCSWriteCMDProcessor_0:CMD_IN_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_ARST_N" "ErrorCounter_0:CTRL_RESET_N" "XCVR_Block_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "ErrorCounter_0:CTRL_CLK" "XCVR_Block_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_DATA_READY" "DREQProcessor_0:DATAREQ_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_LAST_WORD" "DREQProcessor_0:DATAREQ_LAST_WORD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_PACKETS_OVFL" "DREQProcessor_0:DATAREQ_PACKETS_OVFL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_RE_FIFO" "DREQProcessor_0:DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_START_EVENT" "DREQProcessor_0:DATAREQ_START_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_TAG_ERROR" "DREQProcessor_0:DATAREQ_TAG_ERROR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSClkReset:CLK" "DCSProcessor_0:clk" "DCSReadCMDProcessor_0:DCS_CLK" "DCSWriteCMDProcessor_0:DCS_CLK" "DCS_CLK" "DRACRegisters_0:DCS_CLK" "RxPacketFIFO_0:RCLOCK" "RxPacketFIFO_1:WCLOCK" "crc_0:CLK" "pulse_stretcher_0:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSClkReset:FPGA_POR_N" "FPGA_POR_N" "RXClkReset:FPGA_POR_N" "TXClkReset:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSClkReset:INIT_DONE" "INIT_DONE" "RXClkReset:INIT_DONE" "TXClkReset:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSClkReset:PLL_LOCK" "PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:blk_read_req" "DCSReadCMDProcessor_0:BLK_READ_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:blk_reg" "DCSWriteCMDProcessor_0:BLOCK_CMD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:blk_start" "DCSReadCMDProcessor_0:BLOCK_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_en" "crc_0:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_rst" "crc_0:RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:data_we" "DCSWriteCMDProcessor_0:NEXT_WRITE_CMD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:data_we_ack" "DCSWriteCMDProcessor_0:NEXT_WRITE_ACK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:dcs_done" "DCSReadCMDProcessor_0:DCS_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_re" "RxPacketFIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_we" "RxPacketFIFO_1:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:first_blk" "DCSReadCMDProcessor_0:FIRST_BLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:is_cmd_reg" "DCSReadCMDProcessor_0:IS_CMD_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:is_drac_reg" "DRACRegisters_0:IS_DRAC_REGISTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:pckt_done" "DCSReadCMDProcessor_0:PKT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:read_proc" "DCSReadCMDProcessor_0:READ_CMD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:read_reg" "DRACRegisters_0:READ_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:ready_from_cmd" "DCSReadCMDProcessor_0:READY_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:ready_from_drac" "DRACRegisters_0:READY_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:reset_dcs_logic" "pulse_stretcher_0:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:write_proc" "DCSWriteCMDProcessor_0:WRITE_CMD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:write_reg" "DRACRegisters_0:WRITE_REG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSReadCMDProcessor_0:DCS_TX_RE" "DCS_TX_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DATA_ERR" "DRACRegisters_0:DCS_DATA_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DDRRESET" "DRACRegisters_0:DCS_DDRRESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DIGI_SIM_EN" "DRACRegisters_0:DCS_DIGI_SIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DLYD_EVM_EN" "DRACRegisters_0:DCS_DLYD_EVM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQ_FIFO_EMPTY" "DRACRegisters_0:DCS_DREQ_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQ_FIFO_FULL" "DRACRegisters_0:DCS_DREQ_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_ENABLE_CLOCK" "DRACRegisters_0:DCS_ENABLE_CLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_ENABLE_MARKER" "DRACRegisters_0:DCS_ENABLE_MARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_EVT_ERR" "DRACRegisters_0:DCS_EVT_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_FORCE_FULL" "DRACRegisters_0:DCS_FORCE_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_HDR1_ERR" "DRACRegisters_0:DCS_HDR1_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_HDR2_ERR" "DRACRegisters_0:DCS_HDR2_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_INT_EVM_EN" "DRACRegisters_0:DCS_INT_EVM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_PATTERN_EN" "DRACRegisters_0:DCS_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_PATTERN_TYPE" "DRACRegisters_0:DCS_PATTERN_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESETFIFO" "DRACRegisters_0:DCS_RESETFIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RX_EMPTY" "DRACRegisters_0:DCS_RX_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RX_FULL" "DRACRegisters_0:DCS_RX_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TX_EMPTY" "DRACRegisters_0:DCS_TX_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TX_FULL" "DRACRegisters_0:DCS_TX_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_ERROR_EN" "ErrorCounter_0:dcs_error_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:HALTRUN_EN" "HALTRUN_EN" "RxPacketReader_0:haltrun_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_cal_busy" "dcs_cal_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_cal_init" "dcs_cal_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_hv_busy" "dcs_hv_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_hv_init" "dcs_hv_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:FETCH_START" "FETCH_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:clk" "DREQ_CLK" "RxPacketFIFO_2:RCLOCK" "RxPacketFIFO_3:WCLOCK" "crc_1:CLK" "pulse_stretcher_1:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:crc_en" "crc_1:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:crc_rst" "crc_1:RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_fifo_re" "RxPacketFIFO_2:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_fifo_we" "RxPacketFIFO_3:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:reset_dreq_logic" "pulse_stretcher_1:pulse_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ENABLE_ALIGNMENT" "XCVR_Block_0:ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"END_EVM_SEEN" "ErrorCounter_0:end_ewm" "RxPacketReader_0:END_EVM_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ERROR_CLEAR" "PBRS_checker_0:ERROR_CLEAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ERROR_IN" "PRBS_generator_0:ERROR_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EWM" "delay_sreg_1bit_0:sr_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:aligned" "PCS_ALIGNED" "RxPacketReader_0:aligned" "XCVR_Block_0:PCS_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:clk" "LANE0_RX_CLK_R" "PBRS_checker_0:CLK" "RXClkReset:CLK" "RxPacketFIFO_0:WCLOCK" "RxPacketFIFO_2:WCLOCK" "RxPacketReader_0:clk" "XCVR_Block_0:LANE0_RX_CLK_R" "crc_2:CLK" "delay_sreg_1bit_0:clk" "delay_sreg_1bit_1:clk" "delay_sreg_1bit_2:clk" "delay_sreg_1bit_3:clk" "pulse_time_crossing_0:clk_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:reset_n" "XCVR_Block_0:resetn_align" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:rx_err" "XCVR_Block_0:EPCS_RxERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:rx_val" "PBRS_checker_0:RX_VAL_IN" "XCVR_Block_0:LANE0_RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIRST_HB_SEEN" "RxPacketReader_0:FIRST_HB_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HEARTBEAT_SEEN" "RxPacketReader_0:HEARTBEAT_SEEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:A" "pulse_stretcher_0:gate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0_0:A" "pulse_stretcher_1:gate_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "XCVR_Block_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "XCVR_Block_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "XCVR_Block_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "XCVR_Block_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LAST_EWM" "delay_sreg_1bit_1:sr_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NEWRUN" "RxPacketReader_0:NEWRUN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ONSPILL" "delay_sreg_1bit_2:sr_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PBRS_checker_0:PRBS_ON" "PRBS_ON" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PBRS_checker_0:RX_VAL_OUT" "PRBS_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PBRS_checker_0:START" "PRBS_EN" "PRBS_generator_0:START" "XCVR_Block_0:PRBS_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_generator_0:CLK" "RxPacketFIFO_1:RCLOCK" "RxPacketFIFO_3:RCLOCK" "TXClkReset:CLK" "TxPacketWriter_0:clk" "XCVR_Block_0:LANE0_TX_CLK_R" "pulse_time_crossing_0:clock_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "XCVR_Block_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "XCVR_Block_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXCLK_RESETN" "RXClkReset:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXClkReset:PLL_LOCK" "XCVR_Block_0:LANE0_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:WE" "RxPacketReader_0:rx_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:RE" "TxPacketWriter_0:dcs_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_2:WE" "RxPacketReader_0:req_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:RE" "TxPacketWriter_0:dreq_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:LAST_EWM" "delay_sreg_1bit_1:sr_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:ONSPILL" "delay_sreg_1bit_2:sr_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:TAG_SYNC" "delay_sreg_1bit_3:sr_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:crc_en" "crc_2:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:crc_rst" "crc_2:RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:eventmarker" "delay_sreg_1bit_0:sr_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:loopmarker" "pulse_time_crossing_0:pulse_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TAG_SYNC" "delay_sreg_1bit_3:sr_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TXClkReset:FABRIC_RESET_N" "TxPacketWriter_0:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TXClkReset:PLL_LOCK" "XCVR_Block_0:LANE0_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:MARKER_EN" "pulse_time_crossing_0:pulse_out" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CMD_IN_DATA" "DCSWriteCMDProcessor_0:CMD_IN_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_DATA" "DREQProcessor_0:DATAREQ_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_EVENT_WINDOW_TAG" "DRACRegisters_0:DCS_DREQTAG" "DREQProcessor_0:DATAREQ_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_PACKETS_IN_EVT" "DREQProcessor_0:DATAREQ_PACKETS_IN_EVT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:address_reg" "DCSReadCMDProcessor_0:ADDR_IN" "DCSWriteCMDProcessor_0:ADDR_IN" "DRACRegisters_0:ADDR_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:blk_size" "DCSWriteCMDProcessor_0:BLOCK_SIZE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_data_in" "crc_0:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:crc_data_out" "crc_0:DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:data_reg" "DCSWriteCMDProcessor_0:DATA_IN" "DRACRegisters_0:DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:dcs_error_count" "ErrorCounter_0:rx_crc_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:dcs_state_count" "ErrorCounter_0:dcs_proc_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_data_in" "RxPacketFIFO_0:Q[15:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_data_out" "RxPacketFIFO_1:DATA[17:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:fifo_rdcnt" "RxPacketFIFO_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:reg_from_cmd" "DCSReadCMDProcessor_0:DATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:reg_from_drac" "DRACRegisters_0:DATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSProcessor_0:roc_id" "RxPacketReader_0:roc_id" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSReadCMDProcessor_0:DCS_TX_DATA" "DCS_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSReadCMDProcessor_0:DCS_TX_WRCNT" "DCS_TX_WRCNT" "DRACRegisters_0:DCS_TX_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSReadCMDProcessor_0:dcsrd_state_count" "ErrorCounter_0:dcs_rx_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCSWriteCMDProcessor_0:dcswr_state_count" "ErrorCounter_0:dcs_tx_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_CMD_STATUS" "DRACRegisters_0:DCS_CMD_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DIAG_DATA" "DRACRegisters_0:DCS_DIAG_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQCNT" "DRACRegisters_0:DCS_DREQCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQNULL" "DRACRegisters_0:DCS_DREQNULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQREAD" "DRACRegisters_0:DCS_DREQREAD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQSENT" "DRACRegisters_0:DCS_DREQSENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_EVMCNT" "DRACRegisters_0:DCS_EVMCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_FETCH_CNT" "DRACRegisters_0:DCS_FETCH_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_FETCH_POS" "DRACRegisters_0:DCS_FETCH_POS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_FULLTAG" "DRACRegisters_0:DCS_FULLTAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_HBONHOLD" "DRACRegisters_0:DCS_HBONHOLD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_LANE_EMPTY" "DRACRegisters_0:DCS_LANE_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_LANE_FULL" "DRACRegisters_0:DCS_LANE_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_OFFSETTAG" "DRACRegisters_0:DCS_OFFSETTAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RX_WRCNT" "DRACRegisters_0:DCS_RX_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_SIM_HIT" "DRACRegisters_0:DCS_SIM_HIT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_SIM_LANE_EMPTY" "DRACRegisters_0:DCS_SIM_LANE_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_SIM_LANE_FULL" "DRACRegisters_0:DCS_SIM_LANE_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_STORE_CNT" "DRACRegisters_0:DCS_STORE_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_STORE_POS" "DRACRegisters_0:DCS_STORE_POS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_TAG_OFFSET" "DRACRegisters_0:DCS_TAG_OFFSET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_USE_LANE" "DRACRegisters_0:DCS_USE_LANE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:BAD_MARKER_CNT" "ErrorCounter_0:bad_marker_cnt" "RxPacketReader_0:bad_marker_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DATAREQ_CNT" "RxPacketReader_0:datareq_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_ERROR_ADDR" "ErrorCounter_0:dcs_address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_ERROR_DATA" "ErrorCounter_0:counter_out" "counter_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_ERR_EXPC" "req_err_switch_0:expc_err" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_ERR_REQ" "req_err_switch_0:err_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_ERR_SEEN" "req_err_switch_0:seen_err" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_FETCHTAG" "DREQProcessor_0:FETCH_EVENT_WINDOW_TAG" "FETCH_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_HBCNT" "RxPacketReader_0:hb_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_HBTAG" "HEARTBEAT_EVENT_WINDOW_TAG" "RxPacketReader_0:HEARTBEAT_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_LOOPBACK_COARSE_DELAY" "delay_sreg_1bit_0:sr_delay" "delay_sreg_1bit_1:sr_delay" "delay_sreg_1bit_2:sr_delay" "delay_sreg_1bit_3:sr_delay" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_NULLHBCNT" "RxPacketReader_0:null_hb_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_PREFCNT" "RxPacketReader_0:pref_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_PREFTAG" "PREFETCH_EVENT_WINDOW_TAG" "RxPacketReader_0:PREFETCH_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_SPILLCNT" "RxPacketReader_0:SPILL_EVENT_WINDOW_TAG[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:DCS_TAG_LOST" "RxPacketReader_0:TAG_LOST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:EVENT_MARKER_CNT" "RxPacketReader_0:event_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:IS_SKIPPED_DREQ_CNT" "ErrorCounter_0:is_skipped_dreq_cnt" "RxPacketReader_0:is_skipped_dreq_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:LOSS_OF_LOCK_CNT" "XCVR_Block_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_cal_addr" "dcs_cal_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_cal_data" "dcs_cal_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_cal_data_out" "dcs_cal_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_format_vrs" "DREQProcessor_0:DATAREQ_FORMAT_VRS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_hv_addr" "dcs_hv_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_hv_data" "dcs_hv_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:dcs_hv_data_out" "dcs_hv_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:evm_lost_cnt" "RxPacketReader_0:evm_lost_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:hb_dreq_err_cnt" "hb_dreq_err_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:hb_lost_cnt" "RxPacketReader_0:hb_lost_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:hb_tag_err_cnt" "hb_tag_err_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DRACRegisters_0:tag_sync_err_cnt" "tag_sync_err_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:crc_data_in" "crc_1:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:crc_data_out" "crc_1:DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_error_count" "ErrorCounter_0:dreq_crc_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_fifo_in" "RxPacketFIFO_2:Q[15:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_fifo_out" "RxPacketFIFO_3:DATA[17:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_rdcnt" "RxPacketFIFO_2:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_state_count" "ErrorCounter_0:dreq_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:dreq_timeout_count" "ErrorCounter_0:dreq_timeout_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:fetchEventWindowTag_debug" "ErrorCounter_0:fetchEventWindowTag_debug" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:reqEventWindowTag_debug" "ErrorCounter_0:reqEventWindowTag_debug" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQProcessor_0:reqType_debug" "ErrorCounter_0:reqType_debug" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:any_marker_counter" "RxPacketReader_0:any_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:b_cerr" "XCVR_Block_0:B_CERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:clock_marker_counter" "RxPacketReader_0:clock_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:code_err_n" "XCVR_Block_0:CODE_ERR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:comma_error_counter" "RxPacketReader_0:comma_err_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:datareq_state" "datareq_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:dcs_counter" "RxPacketReader_0:dcsreq_end_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:dreq_full_counter" "dreq_full_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:ew_fifo_emptied_counter" "ew_fifo_emptied_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:ewm_out_counter" "ewm_out_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:ewtag_state" "ewtag_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:fetch_event_tag" "fetch_event_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:fetch_missing_TAG" "fetch_missing_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:fetch_missing_counter" "fetch_missing_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:fetch_runover_TAG" "fetch_runover_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:fetch_runover_counter" "fetch_runover_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:fetch_state" "fetch_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:fetch_timeout_counter" "fetch_timeout_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:hb_bad_crc_counter" "RxPacketReader_0:hb_bad_crc_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:hb_empty_overlap_counter" "hb_empty_overlap_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:hb_tag_full_counter" "hb_tag_full_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:invalid_hb_counter" "RxPacketReader_0:invalid_hb_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:invalid_k" "XCVR_Block_0:INVALID_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:loop_marker_counter" "RxPacketReader_0:loop_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:marker_error" "RxPacketReader_0:marker_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:next_read_event_tag" "next_read_event_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:other_marker_counter" "RxPacketReader_0:other_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:rd_err" "XCVR_Block_0:RD_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:retr_marker_counter" "RxPacketReader_0:retr_marker_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:rocfifocntrl_state" "rocfifocntrl_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:rx_packet_error" "RxPacketReader_0:rx_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:seq_error_counter" "RxPacketReader_0:seq_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:serial_address" "address_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:skipped_DREQ_counter" "skipped_DREQ_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:skipped_DREQ_tag" "skipped_DREQ_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:spilltag_full_counter" "spilltag_full_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:start_fetch_counter" "start_fetch_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:tag_error_counter" "tag_error_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ErrorCounter_0:tag_valid_counter" "tag_valid_counter" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PBRS_checker_0:CHAR_IN" "RxPacketReader_0:rx_kchar_in" "XCVR_Block_0:RX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PBRS_checker_0:DATA_IN" "RxPacketReader_0:rx_data_in" "XCVR_Block_0:RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PBRS_checker_0:ERROR_COUNT" "PRBS_ERROR_COUNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_generator_0:CHAR_OUT" "XCVR_Block_0:PRBS_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRBS_generator_0:DATA_OUT" "XCVR_Block_0:PRBS_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_0:DATA[15:0]" "RxPacketFIFO_2:DATA[15:0]" "RxPacketReader_0:rx_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:Q[17:0]" "TxPacketWriter_0:dcs_fifo_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_1:RDCNT" "TxPacketWriter_0:dcs_fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:Q[17:0]" "TxPacketWriter_0:dreq_fifo_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketFIFO_3:RDCNT" "TxPacketWriter_0:dreq_fifo_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:SPILL_EVENT_WINDOW_TAG" "SPILL_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:crc_data_in" "crc_2:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:crc_data_out" "crc_2:DATA_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:rx_loopmarker_out[15:0]" "XCVR_Block_0:MARKER_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RxPacketReader_0:rx_loopmarker_out[17:16]" "XCVR_Block_0:MARKER_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:tx_data_out" "XCVR_Block_0:TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TxPacketWriter_0:tx_kchar_out" "XCVR_Block_0:TX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"data_expc" "req_err_switch_0:data_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"data_seen" "req_err_switch_0:data_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"evt_expc" "req_err_switch_0:evt_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"evt_seen" "req_err_switch_0:evt_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hdr1_expc" "req_err_switch_0:hdr1_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hdr1_seen" "req_err_switch_0:hdr1_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hdr2_expc" "req_err_switch_0:hdr2_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hdr2_seen" "req_err_switch_0:hdr2_seen" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TOP_SERDES
generate_component -component_name ${sd_name}
