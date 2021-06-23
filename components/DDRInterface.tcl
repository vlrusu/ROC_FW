# Creating SmartDesign DDRInterface
set sd_name {DDRInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEM_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_wr_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_rd_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_MEM_REN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_RE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {READOUT_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR3_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_MEMFIFO_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_LAST_WORD} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_DREQ_SEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_MEM_REN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_MEMFIFO_REN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_banks_calibrated} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CKE} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ODT} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {WE_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD1} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD2} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SHIELD3} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_DATA_READY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_RST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_DREQ_SEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_MEM_WEN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_PATTERN_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_MEM_REN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_MEMFIFO_REN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {write_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {expc_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {expc_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {true_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {true_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {error_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {error_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {read_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {read_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {write_empty} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {err_ren} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_rw_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {read_ren} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {write_ren} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ram_ren} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRSIM_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FPGA_POR_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {BANK_y_VDDI_STATUS} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PLL_LOCK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_MEM_WEN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_PATTERN_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_CLK} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {DIGIFIFO_DATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGIFIFO_RDCNT} -port_direction {IN} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ddr_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {memfifo_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_wr_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CONVERTER_q} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CONVERTER_rdcnt} -port_direction {OUT} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {read_page_no} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ} -port_direction {INOUT} -port_range {[31:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM} -port_direction {OUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range {[2:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range {[14:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEMFIFO_DATA} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEMFIFO_DATA_PCKTS} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {expc_out} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {true_out} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {error_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {read_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {write_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BURST_LENGTH} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_err_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hit_no} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_offset} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ram_data_o} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ram_addr_i} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {loc_offset} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {rdburst_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {wdburst_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_PATTERN} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_WRITE_PAGE_NO} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERIAL_WRITE_PAGE_NO} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERIAL_PATTERN} -port_direction {IN} -port_range {[1:0]}

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add AXI4_Interconnect_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {AXI4_Interconnect} -instance_name {AXI4_Interconnect_0}



# Add cdc_fast_slow_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cdc_fast_slow} -hdl_file {hdl\cdc_fast_slow.v} -instance_name {cdc_fast_slow_0}



# Add cdc_fast_slow_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cdc_fast_slow} -hdl_file {hdl\cdc_fast_slow.v} -instance_name {cdc_fast_slow_1}



# Add cdc_fast_slow_2 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cdc_fast_slow} -hdl_file {hdl\cdc_fast_slow.v} -instance_name {cdc_fast_slow_2}



# Add cdc_fast_slow_3 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cdc_fast_slow} -hdl_file {hdl\cdc_fast_slow.v} -instance_name {cdc_fast_slow_3}



# Add cdc_fast_slow_4 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cdc_fast_slow} -hdl_file {hdl\cdc_fast_slow.v} -instance_name {cdc_fast_slow_4}



# Add cdc_fast_slow_5 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cdc_fast_slow} -hdl_file {hdl\cdc_fast_slow.v} -instance_name {cdc_fast_slow_5}



# Add counter32_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_0}



# Add counter32_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_1}



# Add DDR3_Cntrl_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DDR3_Cntrl} -instance_name {DDR3_Cntrl_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDR3_Cntrl_0:CTRLR_READY}



# Add DDR_simulator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DDR_simulator} -hdl_file {hdl\DDR_simulator.v} -instance_name {DDR_simulator_0}



# Add DDRSYSCLKReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {DDRSYSCLKReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRSYSCLKReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRSYSCLKReset:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRSYSCLKReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DDRSYSCLKReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DDRSYSCLKReset:PLL_POWERDOWN_B}



# Add delay_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {delay} -hdl_file {hdl\delay.v} -instance_name {delay_0}



# Add DigiFifoClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {DigiFifoClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFifoClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFifoClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DigiFifoClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DigiFifoClkReset:PLL_POWERDOWN_B}



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
sd_update_instance -sd_name ${sd_name} -instance_name {fifo_mem_cntrl_0}



# Add memdata_switch_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {memdata_switch} -hdl_file {hdl\memdata_switch.v} -instance_name {memdata_switch_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {memdata_switch_0:DDR_DATA_PCKTS} -value {0000000001000000}



# Add MEMFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MEMFIFO} -instance_name {MEMFIFO_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MEMFIFO_0:RDCNT}



# Add MEMFIFO_RE_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {MEMFIFO_RE_generator} -hdl_file {hdl\MEMFIFO_RE_generator.v} -instance_name {MEMFIFO_RE_generator_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MEMFIFO_RE_generator_0:last_memfifo_re}



# Add MUX_DDR_simulator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {MUX_DDR_simulator} -hdl_file {hdl\MUX_DDR_simulator.v} -instance_name {MUX_DDR_simulator_0}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add MX2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_1}



# Add MX2_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_2}



# Add MX2_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_3}



# Add OR2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_0}



# Add OR2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_1}



# Add pattern_FIFO_filler_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {pattern_FIFO_filler} -instance_name {pattern_FIFO_filler_0}



# Add pattern_gen_checker_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {pattern_gen_checker} -instance_name {pattern_gen_checker_0}
# Exporting Parameters of instance pattern_gen_checker_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {pattern_gen_checker_0} -params {\
"BURST_SIZE:3" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {pattern_gen_checker_0}
sd_update_instance -sd_name ${sd_name} -instance_name {pattern_gen_checker_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pattern_gen_checker_0:mem_read_i} -value {GND}



# Add pattern_switch_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pattern_switch} -hdl_file {hdl\pattern_switch.v} -instance_name {pattern_switch_0}



# Add pulse_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_generator} -hdl_file {hdl\pulse_generator.v} -instance_name {pulse_generator_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pulse_generator_0:pulse_dn}



# Add pulse_generator_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_generator} -hdl_file {hdl\pulse_generator.v} -instance_name {pulse_generator_1}



# Add ReadoutClkReset instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C0} -instance_name {ReadoutClkReset}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ReadoutClkReset:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ReadoutClkReset:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ReadoutClkReset:FF_US_RESTORE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ReadoutClkReset:PLL_POWERDOWN_B}



# Add REG_CTRL_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {REG_CTRL} -hdl_file {hdl\REG_CTRL.v} -instance_name {REG_CTRL_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {REG_CTRL_0:fifo_write_mem_en} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {REG_CTRL_0:fifo_write_mem_o}



# Add SIM_CNTRL_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {SIM_CNTRL} -hdl_file {hdl\SIM_CNTRL.v} -instance_name {SIM_CNTRL_0}



# Add TEMPFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TEMPFIFO} -instance_name {TEMPFIFO_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "DDR3_Cntrl_0:SYS_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:start_i" "AND2_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BANK_y_VDDI_STATUS" "DigiFifoClkReset:BANK_y_VDDI_STATUS" "ReadoutClkReset:BANK_y_VDDI_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N" "DDR3_Cntrl_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_0:slow_out" "OR2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_1:slow_out" "MX2_3:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_2:slow_out" "DDR_simulator_0:fifo_write_mem_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_3:slow_out" "MX2_2:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_4:slow_out" "MEMFIFO_RE_generator_0:start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_CNTRL_0:DCS_MEM_WEN" "cdc_fast_slow_5:slow_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0" "DDR3_Cntrl_0:CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0_N" "DDR3_Cntrl_0:CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "DDR3_Cntrl_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS_N" "DDR3_Cntrl_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_3:clk_fast" "cdc_fast_slow_4:clk_fast" "DCS_CLK" "cdc_fast_slow_1:clk_fast" "cdc_fast_slow_5:clk_fast" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_DREQ_SEL" "MX2_2:S" "MX2_3:S" "OR2_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_3:fast_in" "DCS_MEM_REN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_MEM_WEN" "cdc_fast_slow_5:fast_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_4:fast_in" "DCS_MEMFIFO_REN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_PATTERN_EN" "SIM_CNTRL_0:DCS_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRSYSCLKReset:PLL_LOCK" "DDR3_Cntrl_0:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_1:clk" "fifo_mem_cntrl_0:sysclk_i" "cdc_fast_slow_0:clk_fast" "DDRSYSCLKReset:CLK" "dvl_generator_0:clk_start" "AXI4_Interconnect_0:ACLK" "MEMFIFO_0:WCLOCK" "pulse_generator_0:clk_o" "REG_CTRL_0:clk_i" "DDR3_Cntrl_0:SYS_CLK" "pattern_gen_checker_0:clk_i" "TEMPFIFO_0:RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDR3_FULL" "DDR3_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_banks_calibrated" "AND2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDRSIM_DDR3_FULL" "DDR_simulator_0:DDR3_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDRSIM_DATA_READY" "DDR_simulator_0:memfifo_data_ready" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDRSIM_LAST_WORD" "DDR_simulator_0:memfifo_last_word" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDRSIM_EN" "DDRSIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:ARESETN" "DDRSYSCLKReset:FABRIC_RESET_N" "fifo_mem_cntrl_0:resetn_i" "pulse_generator_0:resetn_i" "counter32_1:rst_n" "pattern_gen_checker_0:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"memdata_switch_0:EN" "delay_0:sig_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_CLK" "DigiFifoClkReset:CLK" "FIFO_converter_32to64b_0:digiclk_i" "pattern_FIFO_filler_0:digiclk" "TEMPFIFO_0:WCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_EMPTY" "pattern_switch_0:DIGIFIFO_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_FULL" "pattern_switch_0:DIGIFIFO_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:digififo_re" "DIGIFIFO_RE" "pattern_FIFO_filler_0:fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DigiFifoClkReset:FABRIC_RESET_N" "FIFO_converter_32to64b_0:resetn_i" "pattern_FIFO_filler_0:resetn" "TEMPFIFO_0:RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_MEM_REN" "MX2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_MEMFIFO_RE" "MX2_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:data_valid" "OR2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"err_ren" "pattern_gen_checker_0:err_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"error_empty" "pattern_gen_checker_0:error_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"error_full" "pattern_gen_checker_0:error_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"expc_empty" "pattern_gen_checker_0:expc_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"expc_full" "pattern_gen_checker_0:expc_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EXT_RST_N" "DDRSYSCLKReset:EXT_RST_N" "DigiFifoClkReset:EXT_RST_N" "AND2_0:B" "ReadoutClkReset:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_we" "TEMPFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:DDR3_empty" "cdc_fast_slow_0:fast_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDR_DDR3_FULL" "fifo_mem_cntrl_0:DDR3_full" "delay_0:sig_in" "FIFO_converter_32to64b_0:DDR3_full" "AND2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:last_write" "FIFO_converter_32to64b_0:last_write" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:MEMFIFO_WE" "MEMFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:TEMPFIFO_RE" "TEMPFIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FPGA_POR_N" "DDRSYSCLKReset:FPGA_POR_N" "DigiFifoClkReset:FPGA_POR_N" "ReadoutClkReset:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INIT_DONE" "DDRSYSCLKReset:INIT_DONE" "DigiFifoClkReset:INIT_DONE" "ReadoutClkReset:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEM_CLK" "DDR3_Cntrl_0:PLL_REF_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_rd_en" "REG_CTRL_0:mem_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_rw_en" "REG_CTRL_0:mem_rw_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_wr_en" "REG_CTRL_0:mem_wr_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_RE_generator_0:enable" "MUX_DDR_simulator_0:DDR_DATA_READY" "memdata_switch_0:MEMFIFO_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:MEMFIFO_DATA_READY" "MEMFIFO_DATA_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_EMPTY" "dvl_generator_0:end_i" "MEMFIFO_0:EMPTY" "pulse_generator_1:gate_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_FULL" "AND2_1:A" "MEMFIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:MEMFIFO_LAST_WORD" "MEMFIFO_LAST_WORD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_RE_generator_0:memfifo_re" "MX2_3:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_simulator_0:fifo_read_mem_en" "REG_CTRL_0:fifo_read_mem_en" "MX2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_0:en" "DDR_simulator_0:memfifo_re" "MEMFIFO_0:RE" "MX2_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:B" "MX2_2:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_1:B" "MX2_3:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT" "DDR3_Cntrl_0:ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"memdata_switch_0:DDR_DATA_READY" "OR2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:S" "MX2_1:S" "OR2_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_empty" "pattern_FIFO_filler_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_full" "pattern_FIFO_filler_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_empty" "pattern_switch_0:CONVERTER_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_full" "pattern_switch_0:CONVERTER_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PLL_LOCK" "DigiFifoClkReset:PLL_LOCK" "ReadoutClkReset:PLL_LOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:fifo_write_mem_i" "pulse_generator_0:pulse_up" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDR_LAST_WORD" "pulse_generator_1:pulse_up" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ram_ren" "pattern_gen_checker_0:ram_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RAS_N" "DDR3_Cntrl_0:RAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"read_empty" "pattern_gen_checker_0:read_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"read_full" "pattern_gen_checker_0:read_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"read_ren" "pattern_gen_checker_0:read_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_2:clk_slow" "cdc_fast_slow_3:clk_slow" "counter32_0:clk" "cdc_fast_slow_4:clk_slow" "MEMFIFO_RE_generator_0:clk" "MUX_DDR_simulator_0:RDOUT_CLK" "READOUT_CLK" "cdc_fast_slow_1:clk_slow" "cdc_fast_slow_0:clk_slow" "DDR_simulator_0:readout_clk" "delay_0:clk" "dvl_generator_0:clk_stop" "MEMFIFO_0:RCLOCK" "pulse_generator_1:clk_o" "ReadoutClkReset:CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_1:resetn_i" "cdc_fast_slow_3:resetn_i" "cdc_fast_slow_2:resetn_i" "cdc_fast_slow_4:resetn_i" "counter32_0:rst_n" "MEMFIFO_RE_generator_0:rst_n" "cdc_fast_slow_0:resetn_i" "DDR_simulator_0:resetn" "delay_0:rst_n" "dvl_generator_0:resetn_i" "MEMFIFO_0:RESET" "pulse_generator_1:resetn_i" "ReadoutClkReset:FABRIC_RESET_N" "cdc_fast_slow_5:resetn_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:fifo_read_mem_i" "counter32_1:en" "REG_CTRL_0:fifo_read_mem_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_test_o" "pattern_gen_checker_0:mem_test_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_wr_o" "pattern_gen_checker_0:mem_write_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "DDR3_Cntrl_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_2:clk_fast" "SERIAL_CLK" "pattern_gen_checker_0:fifo_clk" "cdc_fast_slow_5:clk_slow" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_DREQ_SEL" "OR2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_EN" "SIM_CNTRL_0:SERIAL_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_MEM_REN" "MX2_2:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_MEM_WEN" "SIM_CNTRL_0:SERIAL_MEM_WEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_1:fast_in" "SERIAL_MEMFIFO_REN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_PATTERN_EN" "SIM_CNTRL_0:SERIAL_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD0" "DDR3_Cntrl_0:SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD1" "DDR3_Cntrl_0:SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD2" "DDR3_Cntrl_0:SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SHIELD3" "DDR3_Cntrl_0:SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cdc_fast_slow_2:fast_in" "FIFO_converter_32to64b_0:fifo_write_mem_en" "pattern_FIFO_filler_0:pattern_init" "SIM_CNTRL_0:MEM_WEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:pattern_en" "pattern_gen_checker_0:pattern_en" "SIM_CNTRL_0:PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_full" "TEMPFIFO_0:AFULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:TEMPFIFO_EMPTY" "TEMPFIFO_EMPTY" "FIFO_converter_32to64b_0:tempfifo_empty" "TEMPFIFO_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TEMPFIFO_FULL" "pulse_generator_0:gate_i" "TEMPFIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"true_empty" "pattern_gen_checker_0:true_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"true_full" "pattern_gen_checker_0:true_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WE_N" "DDR3_Cntrl_0:WE_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"write_empty" "pattern_gen_checker_0:write_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"write_full" "pattern_gen_checker_0:write_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"write_ren" "pattern_gen_checker_0:write_ren" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:A" "A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:BA" "BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BURST_LENGTH" "pattern_gen_checker_0:BURST_LENGTH" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CONVERTER_q" "FIFO_converter_32to64b_0:data_in_32bit" "pattern_switch_0:CONVERTER_q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CONVERTER_rdcnt" "FIFO_converter_32to64b_0:data_in_rdcnt" "pattern_switch_0:CONVERTER_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDR_FIFO_RD_CNT" "counter32_0:cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_PATTERN" "SIM_CNTRL_0:DCS_PATTERN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_WRITE_PAGE_NO" "SIM_CNTRL_0:DCS_WRITE_PAGE_NO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ddr_rd_cnt" "counter32_1:cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_simulator_0:mem_rd_cnt" "MUX_DDR_simulator_0:DDRSIM_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_simulator_0:mem_wr_cnt" "MUX_DDR_simulator_0:DDRSIM_WR_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_simulator_0:memfifo_data" "MUX_DDR_simulator_0:DDRSIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_simulator_0:memfifo_data_pckts" "MUX_DDR_simulator_0:DDRSIM_DATA_PCKTS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_simulator_0:memfifo_rd_cnt" "MUX_DDR_simulator_0:DDRSIM_FIFO_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_DATA" "pattern_switch_0:DIGIFIFO_q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DIGIFIFO_RDCNT" "pattern_switch_0:DIGIFIFO_rdcnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DM" "DM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DQ" "DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DQS" "DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR3_Cntrl_0:DQS_N" "DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:error_out" "error_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:expc_out" "expc_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_64bit" "TEMPFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDR_RD_CNT" "fifo_mem_cntrl_0:mem_rd_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDR_WR_CNT" "fifo_mem_cntrl_0:mem_wr_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:MEMFIFO_DATA" "MEMFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"hit_no" "pattern_gen_checker_0:hit_no" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"loc_offset" "pattern_gen_checker_0:loc_offset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_err_cnt" "pattern_gen_checker_0:mem_err_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:mem_offset" "mem_offset" "fifo_mem_cntrl_0:mem_offset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_rd_cnt" "MUX_DDR_simulator_0:MEM_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_wr_cnt" "MUX_DDR_simulator_0:MEM_WR_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"memdata_switch_0:MEMFIFO_DATA" "MUX_DDR_simulator_0:DDR_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_DDR_simulator_0:DDR_DATA_PCKTS" "MEMFIFO_RE_generator_0:packet_no" "memdata_switch_0:MEMFIFO_DATA_PCKTS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_0:Q" "memdata_switch_0:DDR_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_DATA" "MUX_DDR_simulator_0:MEMFIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_DATA_PCKTS" "MUX_DDR_simulator_0:MEMFIFO_DATA_PCKTS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"memfifo_rd_cnt" "MUX_DDR_simulator_0:MEMFIFO_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_q" "pattern_FIFO_filler_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_switch_0:PATTERN_rdcnt" "pattern_FIFO_filler_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ram_addr_i" "pattern_gen_checker_0:ram_addr_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ram_data_o" "pattern_gen_checker_0:ram_data_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"rdburst_cnt" "pattern_gen_checker_0:rdb_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:read_out" "read_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:read_page_no" "read_page_no" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_PATTERN" "SIM_CNTRL_0:SERIAL_PATTERN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_WRITE_PAGE_NO" "SIM_CNTRL_0:SERIAL_WRITE_PAGE_NO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:pattern_i" "pattern_FIFO_filler_0:pattern" "SIM_CNTRL_0:PATTERN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:write_page_no" "DDR_simulator_0:write_page_no" "SIM_CNTRL_0:WRITE_PAGE_NO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:TEMPFIFO_DATA" "TEMPFIFO_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:true_out" "true_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"wdburst_cnt" "pattern_gen_checker_0:wrb_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"write_out" "pattern_gen_checker_0:write_out" }

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
