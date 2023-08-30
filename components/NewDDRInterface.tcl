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
sd_create_scalar_port -sd_name ${sd_name} -port_name {et_fifo_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {event_error} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_DDR_wrap} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ew_fifo_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {header1_error} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {header2_error} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {last_word} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGI_ew_fifo_data} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGI_ew_size} -port_direction {IN} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGI_ew_tag} -port_direction {IN} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {event_window_fetch} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_event_window} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {serial_offset} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {spill_hbtag_in} -port_direction {IN} -port_range {[19:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range {[13:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range {[1:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM_N} -port_direction {OUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DREQ_WRCNT} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {data_expc} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {data_seen} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {datareq_state} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {et_fifo_rdata} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {et_pckts} -port_direction {OUT} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {evt_expc} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {evt_seen} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ew_fifo_emptied_count} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_dreq_full} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_offset_out} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ewtag_state} -port_direction {OUT} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_cnt} -port_direction {OUT} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_event_tag} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_pos_cnt} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fetch_state_cnt} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_cnt_onhold} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_empty_overlap_count} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_null_cnt} -port_direction {OUT} -port_range {[31:0]}
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

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AXI4_Interconnect_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {AXI4_Interconnect} -instance_name {AXI4_Interconnect_0}



# Add DDR4_Cntrl_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DDR4_Cntrl} -instance_name {DDR4_Cntrl_0}



# Add DREQ_FIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DREQ_FIFO} -instance_name {DREQ_FIFO_1}



# Add edge_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {edge_generator} -hdl_file {hdl\edge_generator.v} -instance_name {edge_generator_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {edge_generator_0:fallingEdge}



# Add edge_generator_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {edge_generator} -hdl_file {hdl\edge_generator.v} -instance_name {edge_generator_1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {edge_generator_1:fallingEdge}



# Add edge_generator_2 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {edge_generator} -hdl_file {hdl\edge_generator.v} -instance_name {edge_generator_2}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {edge_generator_2:fallingEdge}



# Add EW_FIFO_controller_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {EW_FIFO_controller} -instance_name {EW_FIFO_controller_0}
# Exporting Parameters of instance EW_FIFO_controller_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {EW_FIFO_controller_0} -params {\
"BURST_LENGTH:127" \
"BURST_SIZE:3" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {EW_FIFO_controller_0}
sd_update_instance -sd_name ${sd_name} -instance_name {EW_FIFO_controller_0}



# Add ew_size_store_and_fetch_controller_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {ew_size_store_and_fetch_controller} -hdl_file {hdl\ew_size_store_and_fetch_controller.vhd} -instance_name {ew_size_store_and_fetch_controller_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ew_size_store_and_fetch_controller_0:fetch_timeout_error}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ew_size_store_and_fetch_controller_0:fetch_missing_error}



# Add ewtag_cntrl_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {ewtag_cntrl} -hdl_file {hdl\ewtag_cntrl.v} -instance_name {ewtag_cntrl_0}



# Add OR2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {OR2_0:Y}



# Add OR2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_1}



# Add pattern_FIFO_filler_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {pattern_FIFO_filler} -instance_name {pattern_FIFO_filler_0}



# Add pattern_switch_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pattern_switch} -hdl_file {hdl\pattern_switch.v} -instance_name {pattern_switch_0}



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
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "DREQ_FIFO_1:RRESET_N" "DREQ_FIFO_1:WRESET_N" "EW_FIFO_controller_0:resetn_fifo" "EXT_RST_N" "SYSCLKReset:EXT_RST_N" "ewtag_cntrl_0:resetn_fifo" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "DDR4_Cntrl_0:SYS_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:ACLK" "DDR4_Cntrl_0:SYS_CLK" "DREQ_FIFO_1:WCLOCK" "EW_FIFO_controller_0:sysclk" "SYSCLKReset:CLK" "edge_generator_2:clk" "ew_size_store_and_fetch_controller_0:wclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:ARESETN" "EW_FIFO_controller_0:resetn_sysclk" "SYSCLKReset:FABRIC_RESET_N" "edge_generator_2:resetn" "ew_size_store_and_fetch_controller_0:wreset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BG" "DDR4_Cntrl_0:BG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N" "DDR4_Cntrl_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0" "DDR4_Cntrl_0:CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0_N" "DDR4_Cntrl_0:CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "DDR4_Cntrl_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS_N" "DDR4_Cntrl_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRLR_READY" "DDR4_Cntrl_0:CTRLR_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_pattern_en" "OR2_1:B" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGI_curr_ewfifo_wr" "pattern_switch_0:DIGI_curr_ewfifo_wr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGI_ew_done" "pattern_switch_0:DIGI_ew_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGI_ew_fifo_we" "pattern_switch_0:DIGI_ew_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGI_ew_ovfl" "pattern_switch_0:DIGI_ew_ovfl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:EMPTY" "DREQ_FIFO_EMPTY" "ew_size_store_and_fetch_controller_0:size_fifo_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:FULL" "DREQ_FIFO_FULL" "ewtag_cntrl_0:dreq_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:RCLOCK" "EW_FIFO_controller_0:dreqclk" "dreqclk" "edge_generator_0:clk" "ew_size_store_and_fetch_controller_0:rclk" "ewtag_cntrl_0:dreqclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:RE" "ew_size_store_and_fetch_controller_0:fetch_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:WE" "ew_size_store_and_fetch_controller_0:store_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:axi_start_on_serdesclk" "pattern_switch_0:axi_start_on_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:curr_ewfifo_wr" "pattern_switch_0:curr_ewfifo_wr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:data_error" "data_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ddr_done_on_serdesclk" "pattern_FIFO_filler_0:ddr_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:et_fifo_emptied" "ewtag_cntrl_0:tag_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:et_fifo_full" "et_fifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:et_fifo_re" "et_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:event_error" "event_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_DDRwrap_to_store" "ew_DDR_wrap" "ew_size_store_and_fetch_controller_0:store_event_wraparound" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_done" "pattern_switch_0:ew_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_fifo_emptied" "ewtag_cntrl_0:ew_fifo_emptied" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_fifo_full" "ew_fifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_fifo_we" "pattern_switch_0:ew_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_ovfl" "pattern_switch_0:ew_ovfl" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_ovfl_to_store" "ew_size_store_and_fetch_controller_0:store_overflow" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_we_store" "ew_size_store_and_fetch_controller_0:store_event_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ewtag_offset_seen" "ewtag_cntrl_0:ewtag_offset_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:header1_error" "header1_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:header2_error" "header2_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:last_word" "ewtag_cntrl_0:last_word" "last_word" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:newspill_on_dreqclk" "edge_generator_0:risingEdge" "ew_size_store_and_fetch_controller_0:fetch_newspill" "ewtag_cntrl_0:start_spill" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:newspill_on_sysclk" "edge_generator_2:risingEdge" "ew_size_store_and_fetch_controller_0:store_newspill" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:resetn_dreqclk" "dreqclk_resetn" "edge_generator_0:resetn" "ew_size_store_and_fetch_controller_0:rreset_n" "ewtag_cntrl_0:resetn_dreqclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:resetn_serdesclk" "edge_generator_1:resetn" "ewtag_cntrl_0:resetn_serdesclk" "pattern_FIFO_filler_0:resetn_serdesclk" "resetn_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:serdesclk" "edge_generator_1:clk" "ewtag_cntrl_0:serdesclk" "pattern_FIFO_filler_0:serdesclk" "serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:tag_null" "ewtag_cntrl_0:tag_null" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:tag_ovfl" "ew_size_store_and_fetch_controller_0:fetch_overflow" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:tag_sent" "ewtag_cntrl_0:tag_sent" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:tag_valid" "ew_size_store_and_fetch_controller_0:fetch_address_valid" "ewtag_cntrl_0:tag_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FPGA_POR_N" "SYSCLKReset:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INIT_DONE" "SYSCLKReset:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"NEWSPILL" "OR2_0:B" "edge_generator_0:gate" "edge_generator_1:gate" "edge_generator_2:gate" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ONSPILL" "OR2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_1:A" "SERIAL_pattern_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_1:Y" "pattern_switch_0:pattern_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXCLK_RESETN" "ewtag_cntrl_0:resetn_xcvrclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_CLK" "ewtag_cntrl_0:xcvrclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"axi_start_on_serdesclk" "pattern_switch_0:DIGI_axi_start_on_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"data_ready" "ewtag_cntrl_0:data_ready" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"edge_generator_1:risingEdge" "pattern_FIFO_filler_0:newspill_reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_start" "ewtag_cntrl_0:event_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:fetch" "ewtag_cntrl_0:tag_fetch" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:hb_null_valid" "hb_null_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:hb_valid" "hb_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:pattern_init" "pattern_FIFO_filler_0:pattern_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:pref_valid" "pref_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:serial_en" "set_serial_offset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:start_fetch" "start_fetch" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:axi_start_on_serdesclk" "pattern_switch_0:PATTRN_axi_start_on_serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:curr_ewfifo_wr" "pattern_switch_0:PATTRN_curr_ewfifo_wr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:ew_done" "pattern_switch_0:PATTRN_ew_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:ew_fifo_we" "pattern_switch_0:PATTRN_ew_fifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:ew_ovfl" "pattern_switch_0:PATTRN_ew_ovfl" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"A" "DDR4_Cntrl_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BA" "DDR4_Cntrl_0:BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DM_N" "DM_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DQ" "DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DQS" "DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR4_Cntrl_0:DQS_N" "DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGI_ew_fifo_data" "pattern_switch_0:DIGI_ew_fifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGI_ew_size" "pattern_switch_0:DIGI_ew_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGI_ew_tag" "pattern_switch_0:DIGI_ew_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:DATA" "ew_size_store_and_fetch_controller_0:store_word" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:Q" "ew_size_store_and_fetch_controller_0:size_fifo_rdata" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_FIFO_1:WRCNT" "DREQ_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:data_expc" "data_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:data_seen" "data_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:et_fifo_rdata" "et_fifo_rdata" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:et_pckts" "et_pckts" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:evt_expc" "evt_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:evt_seen" "evt_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_data" "pattern_switch_0:ew_fifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_size" "pattern_switch_0:ew_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_size_to_store" "ew_size_store_and_fetch_controller_0:store_event_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_tag" "pattern_switch_0:ew_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ew_tag_to_store" "ew_size_store_and_fetch_controller_0:store_event_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:ewtag_offset_in" "ewtag_cntrl_0:ewtag_offset_out" "ewtag_offset_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:hdr1_expc" "hdr1_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:hdr1_seen" "hdr1_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:hdr2_expc" "hdr2_expc" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:hdr2_seen" "hdr2_seen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:tag_cnt" "ew_size_store_and_fetch_controller_0:fetch_ddr_address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:tag_evt" "ew_size_store_and_fetch_controller_0:fetch_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EW_FIFO_controller_0:tag_size" "ew_size_store_and_fetch_controller_0:fetch_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"datareq_state" "ewtag_cntrl_0:datareq_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"event_window_fetch" "ewtag_cntrl_0:event_window_fetch" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_fifo_emptied_count" "ewtag_cntrl_0:ew_fifo_emptied_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:fetch_cnt" "fetch_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:fetch_event_tag" "ewtag_cntrl_0:evt_tag_fetch" "fetch_event_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:fetch_pos_cnt" "fetch_pos_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:fetch_state_cnt" "fetch_state_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:next_read_event_tag" "next_read_event_tag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:store_cnt" "store_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ew_size_store_and_fetch_controller_0:store_pos_cnt" "store_pos_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:ewtag_dreq_full" "ewtag_dreq_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:ewtag_state" "ewtag_state" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:hb_cnt" "hb_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:hb_cnt_onhold" "hb_cnt_onhold" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:hb_empty_overlap_count" "hb_empty_overlap_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:hb_event_window" "hb_event_window" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:hb_null_cnt" "hb_null_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:pref_seen_cnt" "pref_seen_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:serial_offset" "serial_offset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:spill_ewtag_out" "pattern_FIFO_filler_0:ewtag_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:spill_hbtag_in" "spill_hbtag_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:start_tag_cnt" "start_tag_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:tag_done_cnt" "tag_done_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:tag_error_count" "tag_error_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:tag_null_cnt" "tag_null_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:tag_sent_cnt" "tag_sent_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ewtag_cntrl_0:tag_valid_count" "tag_valid_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:ew_data" "pattern_switch_0:PATTRN_ew_fifo_data" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:ew_size" "pattern_switch_0:PATTRN_ew_size" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_FIFO_filler_0:ew_tag" "pattern_switch_0:PATTRN_ew_tag" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mmaster0" "EW_FIFO_controller_0:AXI4_M" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mslave0" "DDR4_Cntrl_0:AXI4slave0" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign NewDDRInterface
generate_component -component_name ${sd_name}
