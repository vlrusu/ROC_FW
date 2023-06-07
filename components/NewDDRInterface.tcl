# Creating SmartDesign NewDDRInterface
set sd_name {NewDDRInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_pattern_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_BANK_CALIB} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGI_curr_ewfifo_wr} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGI_ew_done} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGI_ew_fifo_we} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGI_ew_ovfl} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_RST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEM_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {NEWSPILL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ONSPILL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RXCLK_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_pattern_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dreqclk_resetn} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dreqclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {et_fifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {event_start} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hb_null_valid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hb_valid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_rd_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_wr_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {pref_valid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {resetn_serdesclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {serdesclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {set_serial_offset} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {start_fetch} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {ACT_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {BG} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CKE} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRLR_READY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_FIFO_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_FIFO_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ODT} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD1} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD2} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD3} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {WE_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {axi_start_on_serdesclk} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {data_error} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {data_ready} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {event_error} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_DDR_wrap} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_fifo_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {header1_error} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {header2_error} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {last_word} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_read_done} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_test_err} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_write_done} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGI_ew_fifo_data} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGI_ew_size} -port_direction {IN} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGI_ew_tag} -port_direction {IN} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {blk_no} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_fetch} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_start} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {run_offset} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serial_offset} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {spill_hbtag_in} -port_direction {IN} -port_range {[19:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range {[13:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range {[1:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM_N} -port_direction {OUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {data_expc} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {data_seen} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {datareq_state} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {err_loc} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {error_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {et_fifo_rdata} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {et_pckts} -port_direction {OUT} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {evt_expc} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {evt_seen} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_fifo_emptied_count} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_offset_out} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_state} -port_direction {OUT} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_cnt} -port_direction {OUT} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_event_tag} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_pos_cnt} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_state_cnt} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_empty_overlap_count} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_null_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_seen_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr1_expc} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr1_seen} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr2_expc} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hdr2_seen} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {next_read_event_tag} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {pref_seen_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {start_tag_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {store_cnt} -port_direction {OUT} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {store_pos_cnt} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_done_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_error_count} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_null_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_sent_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {tag_valid_count} -port_direction {OUT} -port_range {[15:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ} -port_direction {INOUT} -port_range {[31:0]} -port_is_pad {1}

sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DREQ_FIFO_EMPTY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DREQ_FIFO_FULL} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {axi_start_on_serdesclk} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {data_error} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {data_ready} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {event_error} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ew_DDR_wrap} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ew_fifo_full} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {header1_error} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {header2_error} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {last_word} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {data_expc} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {data_seen} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {datareq_state} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {et_fifo_rdata} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {et_pckts} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {evt_expc} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {evt_seen} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ew_fifo_emptied_count} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ewtag_offset_out} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ewtag_state} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {fetch_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {fetch_event_tag} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {fetch_pos_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {fetch_state_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hb_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hb_empty_overlap_count} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hb_null_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hb_seen_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hdr1_expc} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hdr1_seen} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hdr2_expc} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {hdr2_seen} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {next_read_event_tag} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pref_seen_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {start_tag_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {store_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {store_pos_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {tag_done_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {tag_error_count} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {tag_null_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {tag_sent_cnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {tag_valid_count} -value {GND}
# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AXI4_Interconnect_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {AXI4_Interconnect} -instance_name {AXI4_Interconnect_0}



# Add DDR4_Cntrl_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DDR4_Cntrl} -instance_name {DDR4_Cntrl_0}



# Add pattern_gen_checker_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {pattern_gen_checker} -instance_name {pattern_gen_checker_0}
# Exporting Parameters of instance pattern_gen_checker_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {pattern_gen_checker_0} -params {\
"BURST_LENGTH:127" \
"BURST_SIZE:3" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {pattern_gen_checker_0}
sd_update_instance -sd_name ${sd_name} -instance_name {pattern_gen_checker_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pattern_gen_checker_0:pattern_i} -value {GND}



# Add SYSCLKReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {SYSCLKReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SYSCLKReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SYSCLKReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SYSCLKReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SYSCLKReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SYSCLKReset:PLL_POWERDOWN_B}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ACT_N" "DDR4_Cntrl_0:ACT_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "DDR_BANK_CALIB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "EXT_RST_N" "SYSCLKReset:EXT_RST_N" "pattern_gen_checker_0:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "DDR4_Cntrl_0:SYS_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:ACLK" "DDR4_Cntrl_0:SYS_CLK" "SYSCLKReset:CLK" "pattern_gen_checker_0:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:ARESETN" "SYSCLKReset:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BG" "DDR4_Cntrl_0:BG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N" "DDR4_Cntrl_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0" "DDR4_Cntrl_0:CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0_N" "DDR4_Cntrl_0:CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "DDR4_Cntrl_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS_N" "DDR4_Cntrl_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRLR_READY" "DDR4_Cntrl_0:CTRLR_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:ODT" "ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:PLL_LOCK" "SYSCLKReset:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:PLL_REF_CLK" "MEM_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:RAS_N" "RAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:RESET_N" "RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:SHIELD0" "SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:SHIELD1" "SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:SHIELD2" "SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:SHIELD3" "SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:WE_N" "WE_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FPGA_POR_N" "SYSCLKReset:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INIT_DONE" "SYSCLKReset:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_rd_en" "pattern_gen_checker_0:mem_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_read_done" "pattern_gen_checker_0:mem_read_done_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_test_err" "pattern_gen_checker_0:mem_test_err_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_wr_en" "pattern_gen_checker_0:mem_wr_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_write_done" "pattern_gen_checker_0:mem_write_done_o" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"A" "DDR4_Cntrl_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BA" "DDR4_Cntrl_0:BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DM_N" "DM_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DQ" "DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DQS" "DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DQS_N" "DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"blk_no" "pattern_gen_checker_0:blk_no_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"err_loc" "pattern_gen_checker_0:err_loc_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"error_cnt" "pattern_gen_checker_0:error_cnt_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_start" "pattern_gen_checker_0:mem_start" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mmaster0" "pattern_gen_checker_0:AXI4_M" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mslave0" "DDR4_Cntrl_0:AXI4slave0" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign NewDDRInterface
generate_component -component_name ${sd_name}
