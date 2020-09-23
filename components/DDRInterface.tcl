# Creating SmartDesign DDRInterface
set sd_name {DDRInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEM_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_wr_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_rd_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ram_ren} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_read_mem_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_write_mem_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_RE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {READOUT_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR3_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_LAST_WORD} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_DTCSIM} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRFIFO_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRMEMFIFO_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SYS_RESET_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {pattern_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_test_err_o} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_CLK} -port_direction {IN}
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
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEM_OUT_DISABLE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_DATA_READY} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {pattern_i} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hit_no} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ram_addr_i} -port_direction {IN} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGIFIFO_DATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGIFIFO_RDCNT} -port_direction {IN} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ddr_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {memfifo_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_wr_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ram_data_o} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {err_loc_o} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CONVERTER_q} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CONVERTER_rdcnt} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_start} -port_direction {IN} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {write_page_no} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {read_page_no} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ} -port_direction {INOUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS} -port_direction {INOUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range {[14:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEMFIFO_DATA} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEMFIFO_DATA_PCKTS} -port_direction {OUT} -port_range {[15:0]}

# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add AND2_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_2}



# Add AXI4_Interconnect_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {AXI4_Interconnect} -instance_name {AXI4_Interconnect_0}



# Add counter32_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_0}



# Add counter32_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_1}



# Add data_ready_delay_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {data_ready_delay} -hdl_file {hdl\data_ready_delay.v} -instance_name {data_ready_delay_0}



# Add DDR3_Cntrl_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DDR3_Cntrl} -instance_name {DDR3_Cntrl_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDR3_Cntrl_0:PLL_LOCK}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDR3_Cntrl_0:CTRLR_READY}



# Add dvl_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {dvl_generator} -hdl_file {hdl\data_valid_generator.v} -instance_name {dvl_generator_0}



# Add FIFO_converter_32to64b_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {FIFO_converter_32to64b} -hdl_file {hdl\FIFO_converter_32to64b.v} -instance_name {FIFO_converter_32to64b_0}



# Add fifo_mem_cntrl_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {fifo_mem_cntrl} -instance_name {fifo_mem_cntrl_0}
# Exporting Parameters of instance fifo_mem_cntrl_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {fifo_mem_cntrl_0} -params {\
"BURST_LENGTH:127" \
"BURST_SIZE:3" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {fifo_mem_cntrl_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {fifo_mem_cntrl_0:fifo_read_done_o}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {fifo_mem_cntrl_0:fifo_write_done_o}



# Add memdata_switch_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {memdata_switch} -hdl_file {hdl\memdata_switch.v} -instance_name {memdata_switch_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {memdata_switch_0:DDR_DATA_PCKTS} -value {0000000001000000}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {memdata_switch_0:SIM_DATA_PCKTS} -value {0000000000000100}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {memdata_switch_0:SIM_DATA} -value {0001001000110100010101100111100010101011101110101101111010101101}



# Add MEMFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MEMFIFO} -instance_name {MEMFIFO_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MEMFIFO_0:RDCNT}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add MX2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_1}



# Add pattern_FIFO_filler_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {pattern_FIFO_filler} -instance_name {pattern_FIFO_filler_0}



# Add pattern_gen_checker_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {pattern_gen_checker} -instance_name {pattern_gen_checker_0}
# Exporting Parameters of instance pattern_gen_checker_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {pattern_gen_checker_0} -params {\
"BURST_LENGTH:127" \
"BURST_SIZE:3" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {pattern_gen_checker_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pattern_gen_checker_0:mem_init_done_o}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pattern_gen_checker_0:mem_test_done_o}



# Add pattern_switch_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pattern_switch} -hdl_file {hdl\pattern_switch.v} -instance_name {pattern_switch_0}



# Add pulse_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_generator} -hdl_file {hdl\pulse_generator.v} -instance_name {pulse_generator_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pulse_generator_0:pulse_dn}



# Add pulse_generator_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_generator} -hdl_file {hdl\pulse_generator.v} -instance_name {pulse_generator_1}



# Add pulse_generator_2 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_generator} -hdl_file {hdl\pulse_generator.v} -instance_name {pulse_generator_2}



# Add REG_CTRL_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {REG_CTRL} -hdl_file {hdl\REG_CTRL.v} -instance_name {REG_CTRL_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {REG_CTRL_0:fifo_write_mem_o}



# Add TEMPFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TEMPFIFO} -instance_name {TEMPFIFO_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:start_i" "AND2_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"data_ready_delay_0:rst_n" "counter32_0:rst_n" "fifo_mem_cntrl_0:resetn_i" "dvl_generator_0:resetn_i" "FIFO_converter_32to64b_0:resetn_i" "counter32_1:rst_n" "AND2_2:Y" "AXI4_Interconnect_0:ARESETN" "pulse_generator_1:resetn_i" "pulse_generator_0:resetn_i" "pulse_generator_2:resetn_i" "TEMPFIFO_0:RESET" "MEMFIFO_0:RESET" "pattern_FIFO_filler_0:resetn" "pattern_gen_checker_0:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N" "DDR3_Cntrl_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0" "DDR3_Cntrl_0:CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0_N" "DDR3_Cntrl_0:CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "DDR3_Cntrl_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS_N" "DDR3_Cntrl_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"data_ready_delay_0:sig_out" "memdata_switch_0:SIM_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:sysclk_i" "DDR3_Cntrl_0:SYS_CLK" "counter32_1:clk" "AXI4_Interconnect_0:ACLK" "REG_CTRL_0:clk_i" "TEMPFIFO_0:RCLOCK" "pulse_generator_0:clk_i" "MEMFIFO_0:WCLOCK" "pattern_gen_checker_0:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:DDR3_full" "FIFO_converter_32to64b_0:ddr_stop" "DDR3_full" "AND2_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_DTCSIM" "MX2_0:S" "MX2_1:S" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRFIFO_RE" "MX2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRMEMFIFO_RE" "MX2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:digiclk_i" "DIGIFIFO_CLK" "TEMPFIFO_0:WCLOCK" "pattern_FIFO_filler_0:digiclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_EMPTY" "pattern_switch_0:DIGIFIFO_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_FULL" "pattern_switch_0:DIGIFIFO_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:digififo_re" "DIGIFIFO_RE" "pattern_FIFO_filler_0:fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:data_valid" "memdata_switch_0:DDR_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_we" "TEMPFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:last_write" "FIFO_converter_32to64b_0:last_write" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:MEMFIFO_WE" "MEMFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:tempfifo_re" "TEMPFIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"data_ready_delay_0:sig_in" "fifo_read_mem_en" "MX2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:ddr_start" "fifo_write_mem_en" "REG_CTRL_0:fifo_write_mem_en" "pattern_FIFO_filler_0:pattern_init" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HRESETN" "AND2_2:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEM_CLK" "DDR3_Cntrl_0:PLL_REF_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"memdata_switch_0:MEM_OUT_DISABLE" "MEM_OUT_DISABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_rd_en" "REG_CTRL_0:mem_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_test_err_o" "pattern_gen_checker_0:mem_test_err_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_wr_en" "REG_CTRL_0:mem_wr_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_generator_1:gate_i" "MEMFIFO_0:AEMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_DATA_READY" "memdata_switch_0:MEMFIFO_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:end_i" "MEMFIFO_EMPTY" "MEMFIFO_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_FULL" "AND2_1:B" "MEMFIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_LAST_WORD" "pulse_generator_1:pulse_up" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_RE" "MX2_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:fifo_read_mem_en" "MX2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_generator_2:gate_i" "MX2_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT" "DDR3_Cntrl_0:ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_en" "pattern_switch_0:pattern_en" "pattern_gen_checker_0:pattern_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_empty" "pattern_FIFO_filler_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_full" "pattern_FIFO_filler_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_empty" "pattern_switch_0:CONVERTER_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_full" "pattern_switch_0:CONVERTER_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:fifo_write_mem_i" "pulse_generator_0:pulse_up" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_0:en" "pulse_generator_2:pulse_up" "MEMFIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ram_ren" "pattern_gen_checker_0:ram_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RAS_N" "DDR3_Cntrl_0:RAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"data_ready_delay_0:clk" "counter32_0:clk" "dvl_generator_0:clk_i" "READOUT_CLK" "pulse_generator_1:clk_i" "pulse_generator_2:clk_i" "MEMFIFO_0:RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:fifo_read_mem_i" "counter32_1:en" "REG_CTRL_0:fifo_read_mem_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_init_o" "pattern_gen_checker_0:mem_init_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_test_o" "pattern_gen_checker_0:mem_test_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "DDR3_Cntrl_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCRESETN" "AND2_2:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_CLK" "pattern_gen_checker_0:ram_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD0" "DDR3_Cntrl_0:SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD1" "DDR3_Cntrl_0:SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD2" "DDR3_Cntrl_0:SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD3" "DDR3_Cntrl_0:SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SYS_RESET_N" "DDR3_Cntrl_0:SYS_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_full" "TEMPFIFO_0:AFULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:FIFO_CONV_empty" "FIFO_converter_32to64b_0:tempfifo_empty" "TEMPFIFO_EMPTY" "TEMPFIFO_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TEMPFIFO_FULL" "pulse_generator_0:gate_i" "TEMPFIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WE_N" "DDR3_Cntrl_0:WE_N" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:A" "A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:BA" "BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CONVERTER_q" "FIFO_converter_32to64b_0:data_in_32bit" "pattern_switch_0:CONVERTER_q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CONVERTER_rdcnt" "FIFO_converter_32to64b_0:data_in_rdcnt" "pattern_switch_0:CONVERTER_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ddr_rd_cnt" "counter32_1:cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_DATA" "pattern_switch_0:DIGIFIFO_q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_RDCNT" "pattern_switch_0:DIGIFIFO_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DM" "DM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DQ" "DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DQS" "DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DQS_N" "DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"err_loc_o" "pattern_gen_checker_0:err_loc_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_64bit" "TEMPFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:MEMFIFO_DATA" "MEMFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hit_no" "pattern_gen_checker_0:blk_size_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_rd_cnt" "fifo_mem_cntrl_0:mem_rd_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:mem_start" "mem_start" "pattern_gen_checker_0:mem_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_wr_cnt" "fifo_mem_cntrl_0:mem_wr_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_0:Q" "memdata_switch_0:DDR_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_DATA" "memdata_switch_0:MEMFIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_DATA_PCKTS" "memdata_switch_0:MEMFIFO_DATA_PCKTS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"memfifo_rd_cnt" "counter32_0:cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_q" "pattern_FIFO_filler_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_rdcnt" "pattern_FIFO_filler_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_i" "pattern_FIFO_filler_0:pattern" "pattern_gen_checker_0:pattern_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ram_addr_i" "pattern_gen_checker_0:ram_addr_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ram_data_o" "pattern_gen_checker_0:ram_data_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:read_page_no" "read_page_no" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:FIFO_CONV_DATA" "TEMPFIFO_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:FIFO_CONV_RDCNT" "TEMPFIFO_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:FIFO_CONV_WRCNT" "TEMPFIFO_0:WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:write_page_no" "write_page_no" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mslave0" "DDR3_Cntrl_0:AXI4slave0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mmaster1" "fifo_mem_cntrl_0:AXI4_M" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mmaster0" "pattern_gen_checker_0:AXI4_M" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DDRInterface
generate_component -component_name ${sd_name}