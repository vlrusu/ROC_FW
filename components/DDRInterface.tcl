# Creating SmartDesign DDRInterface
set sd_name {DDRInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ROCRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEM_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {chip_sel} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_wr_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_rd_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {mem_dma_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ram_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ram_ren} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_read_mem_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_write_mem_en} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_RE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DIGIFIFO_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {READOUT_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR3_full} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_EMPTY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_LAST_WORD} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_data_ready} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_DTCSIM} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRFIFO_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDRMEMFIFO_RE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_CLKSIM} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SYS_RESET_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_FULL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_EMPTY} -port_direction {OUT}
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

sd_create_bus_port -sd_name ${sd_name} -port_name {pattern_i} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hit_no} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_start} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dma_mem_start} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ram_addr_i} -port_direction {IN} -port_range {[9:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGIFIFO_DATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DIGIFIFO_RDCNT} -port_direction {IN} -port_range {[16:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEMFIFO_Q} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ddr_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {memfifo_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {read_page_no} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {write_page_no} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_wr_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {mem_rd_cnt} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ} -port_direction {INOUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS} -port_direction {INOUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range {[14:0]}

# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add AND2_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_2}



# Add AXI4_Interconnect_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {AXI4_Interconnect} -instance_name {AXI4_Interconnect_0}



# Add axi4dma_init_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {axi4dma_init} -instance_name {axi4dma_init_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {axi4dma_init_0:coredma_ch0_start_o}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {axi4dma_init_0:coredma_ch1_start_o}



# Add CoreAXI4_Lite_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreAXI4_Lite} -instance_name {CoreAXI4_Lite_0}



# Add CoreDMA_Controller_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreDMA_Controller} -instance_name {CoreDMA_Controller_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreDMA_Controller_0:STRTDMAOP} -value {GND}



# Add counter32_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_0}



# Add counter32_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {counter32} -hdl_file {hdl\counter32.v} -instance_name {counter32_1}



# Add dvl_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {dvl_generator} -hdl_file {hdl\data_valid_generator.v} -instance_name {dvl_generator_0}



# Add FIFO_converter_32to64b_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {FIFO_converter_32to64b} -hdl_file {hdl\FIFO_converter_32to64b.v} -instance_name {FIFO_converter_32to64b_0}



# Add fifo_mem_cntrl_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {fifo_mem_cntrl} -instance_name {fifo_mem_cntrl_0}
# Exporting Parameters of instance fifo_mem_cntrl_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {fifo_mem_cntrl_0} -params {\
"BLOCK_DEPTH:128" \
"BURST_LENGTH:127" \
"BURST_SIZE:3" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {fifo_mem_cntrl_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {fifo_mem_cntrl_0:fifo_read_done_o}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {fifo_mem_cntrl_0:fifo_write_done_o}



# Add MEMFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MEMFIFO} -instance_name {MEMFIFO_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MEMFIFO_0:RDCNT}



# Add MX2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_0}



# Add MX2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_1}



# Add MX2_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {MX2} -instance_name {MX2_2}



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
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pattern_gen_checker_0:mem_test_err_o}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pattern_gen_checker_0:err_loc_o}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pattern_gen_checker_0:ram_data_o}



# Add PF_DDR3_Cntrl_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_DDR3_Cntrl} -instance_name {PF_DDR3_Cntrl_0}



# Add pulse_generator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_generator} -hdl_file {hdl\pulse_generator.v} -instance_name {pulse_generator_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pulse_generator_0:pulse_dn}



# Add pulse_generator_2 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pulse_generator} -hdl_file {hdl\pulse_generator.v} -instance_name {pulse_generator_2}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {pulse_generator_2:pulse_dn}



# Add REG_CTRL_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {REG_CTRL} -hdl_file {hdl\REG_CTRL.v} -instance_name {REG_CTRL_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {REG_CTRL_0:fifo_write_mem_o}



# Add SRAM_AXI_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {SRAM_AXI} -instance_name {SRAM_AXI_0}



# Add TEMPFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TEMPFIFO} -instance_name {TEMPFIFO_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:start_i" "AND2_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:resetn_i" "FIFO_converter_32to64b_0:resetn_i" "fifo_mem_cntrl_0:resetn_i" "pulse_generator_2:resetn_i" "MEMFIFO_0:RESET" "AND2_2:Y" "AXI4_Interconnect_0:ARESETN" "counter32_0:rst_n" "counter32_1:rst_n" "TEMPFIFO_0:RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N" "PF_DDR3_Cntrl_0:CAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:chip_sel" "chip_sel" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_DDR3_Cntrl_0:CK0" "CK0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_DDR3_Cntrl_0:CK0_N" "CK0_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "PF_DDR3_Cntrl_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS_N" "PF_DDR3_Cntrl_0:CS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:DDR3_full" "DDR3_full" "AND2_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDR_CLKSIM" "MX2_2:S" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_0:S" "MX2_1:S" "DDR_DTCSIM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:fifo_read_mem_en" "DDRFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DDRMEMFIFO_RE" "MX2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:digiclk_i" "REG_CTRL_0:digiclk_i" "MX2_2:B" "DIGIFIFO_CLK" "TEMPFIFO_0:WCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_empty" "DIGIFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_full" "DIGIFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_out_re" "DIGIFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_out_we" "TEMPFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:FIFO_CONV_RE" "TEMPFIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:last_write" "fifo_mem_cntrl_0:last_write" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:MEMFIFO_WE" "MEMFIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:dtc_fifo_read_mem_en" "fifo_read_mem_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:fifo_write_mem_en" "fifo_write_mem_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_generator_0:resetn_i" "axi4dma_init_0:resetn_i" "CoreAXI4_Lite_0:ARESETN" "HRESETN" "CoreDMA_Controller_0:RESETN" "pattern_gen_checker_0:resetn_i" "AND2_2:B" "SRAM_AXI_0:ARESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEM_CLK" "PF_DDR3_Cntrl_0:PLL_REF_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_dma_en" "mem_dma_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_rd_en" "mem_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_wr_en" "mem_wr_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:data_valid" "MEMFIFO_data_ready" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:end_i" "MEMFIFO_0:EMPTY" "MEMFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_0:FULL" "MEMFIFO_FULL" "AND2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_0:AEMPTY" "MEMFIFO_LAST_WORD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_1:A" "MEMFIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:fifo_read_mem_i" "MX2_0:Y" "counter32_1:en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_0:RE" "MX2_1:Y" "counter32_0:en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dvl_generator_0:clk_i" "REG_CTRL_0:algoclk_i" "MEMFIFO_0:RCLOCK" "MX2_2:Y" "counter32_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT" "PF_DDR3_Cntrl_0:ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:sysclk_i" "pulse_generator_0:clk_i" "pulse_generator_2:clk_i" "axi4dma_init_0:clk_i" "CoreAXI4_Lite_0:ACLK" "CoreDMA_Controller_0:CLOCK" "MEMFIFO_0:WCLOCK" "pattern_gen_checker_0:clk_i" "AXI4_Interconnect_0:ACLK" "PF_DDR3_Cntrl_0:SYS_CLK" "counter32_1:clk" "TEMPFIFO_0:RCLOCK" "SRAM_AXI_0:ACLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:fifo_write_mem_i" "pulse_generator_0:pulse_up" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_generator_2:pulse_up" "MX2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:ram_clk" "ram_clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:ram_ren" "ram_ren" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RAS_N" "PF_DDR3_Cntrl_0:RAS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MX2_2:A" "READOUT_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:coredma_ch0_type_o" "axi4dma_init_0:coredma0_start_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:coredma_ch1_type_o" "axi4dma_init_0:coredma1_start_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:dtc_fifo_read_mem_o" "MX2_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_generator_2:gate_i" "REG_CTRL_0:fifo_read_mem_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_init_o" "pattern_gen_checker_0:mem_init_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_test_o" "pattern_gen_checker_0:mem_test_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "PF_DDR3_Cntrl_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCRESETN" "AND2_2:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_DDR3_Cntrl_0:SHIELD0" "SHIELD0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_DDR3_Cntrl_0:SHIELD1" "SHIELD1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_DDR3_Cntrl_0:SHIELD2" "SHIELD2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_DDR3_Cntrl_0:SHIELD3" "SHIELD3" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SYS_RESET_N" "PF_DDR3_Cntrl_0:SYS_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_full" "TEMPFIFO_0:AFULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:tempfifo_empty" "fifo_mem_cntrl_0:FIFO_CONV_empty" "TEMPFIFO_EMPTY" "TEMPFIFO_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pulse_generator_0:gate_i" "TEMPFIFO_FULL" "TEMPFIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WE_N" "PF_DDR3_Cntrl_0:WE_N" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_DDR3_Cntrl_0:A" "A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BA" "PF_DDR3_Cntrl_0:BA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"axi4dma_init_0:coredma_int_i" "CoreDMA_Controller_0:INTERRUPT" "REG_CTRL_0:coredma_int_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_1:cnt" "ddr_rd_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_32bit" "DIGIFIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_in_rdcnt" "DIGIFIFO_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DM" "PF_DDR3_Cntrl_0:DM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:dma_mem_start" "dma_mem_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQ" "PF_DDR3_Cntrl_0:DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS" "PF_DDR3_Cntrl_0:DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS_N" "PF_DDR3_Cntrl_0:DQS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FIFO_converter_32to64b_0:data_out_64bit" "TEMPFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_0:DATA" "fifo_mem_cntrl_0:MEMFIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:hit_no" "hit_no" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mem_rd_cnt" "fifo_mem_cntrl_0:mem_rd_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_start" "mem_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:mem_wr_cnt" "mem_wr_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MEMFIFO_0:Q" "MEMFIFO_Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"counter32_0:cnt" "memfifo_rd_cnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:pattern_i" "pattern_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:ram_addr_i" "ram_addr_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:read_page_no" "read_page_no" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"axi4dma_init_0:coredma_addr_i" "REG_CTRL_0:coredma_addr_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"axi4dma_init_0:coredma_size_i" "REG_CTRL_0:coredma_size_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_address_o" "pattern_gen_checker_0:mem_address_i" "fifo_mem_cntrl_0:mem_address_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:mem_size_o" "pattern_gen_checker_0:mem_size_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:offset_data_i" "REG_CTRL_0:offset_data_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REG_CTRL_0:pattern_o" "pattern_gen_checker_0:pattern_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TEMPFIFO_0:Q" "fifo_mem_cntrl_0:FIFO_CONV_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TEMPFIFO_0:RDCNT" "fifo_mem_cntrl_0:FIFO_CONV_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TEMPFIFO_0:WRCNT" "fifo_mem_cntrl_0:FIFO_CONV_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fifo_mem_cntrl_0:write_page_no" "write_page_no" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mslave0" "SRAM_AXI_0:AXI4_Slave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mslave1" "PF_DDR3_Cntrl_0:AXI4slave0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"axi4dma_init_0:AXIDMA_4" "CoreAXI4_Lite_0:AXI4mmaster0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAXI4_Lite_0:AXI4mslave0" "CoreDMA_Controller_0:AXI4SlaveCtrl_IF" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mmaster0" "CoreDMA_Controller_0:AXI4MasterDMA_IF" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4_Interconnect_0:AXI4mmaster2" "fifo_mem_cntrl_0:AXI4_M" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_gen_checker_0:AXI4_M" "AXI4_Interconnect_0:AXI4mmaster1" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DDRInterface
generate_component -component_name ${sd_name}
