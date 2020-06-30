# Creating SmartDesign TOP_SERDES
set sd_name {TOP_SERDES}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {STAMP_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {STAMP_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DAQFifo_re} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dbgSerialFifo_full} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dbgSerialFifo_empty} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DAQFifo_we} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALGO_CLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_RE_FIFO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_START_EVENT_REQ} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_DATA_READY_FLAG} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_LAST_WORD_FLAG} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {dbgSerialFifo_dataIn} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DAQFifo_DataOut} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dbgSerialFifo_rdCnt} -port_direction {IN} -port_range {[10:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_EVENT_WINDOW_TAG_2} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_EVENT_WINDOW_TAG_1} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_STATUS} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_PACKETS_IN_EVENT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_DATA_REQ_REPLY} -port_direction {IN} -port_range {[63:0]}

# Add ALGO_CLK_PLL_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ALGO_CLK_PLL_0} -instance_name {ALGO_CLK_PLL_1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ALGO_CLK_PLL_1:PLL_LOCK_0}



# Add Clock40Mhz_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {Clock40Mhz} -hdl_file {hdl\Clk_40Mhz_RisingEdgeOnly.vhd} -instance_name {Clock40Mhz_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Clock40Mhz_0:RESET_TSMGR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Clock40Mhz_0:alignedToMarker}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Clock40Mhz_0:counterMisalignedMarker}



# Add CommandHandler_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {CommandHandler} -instance_name {CommandHandler_0}
# Exporting Parameters of instance CommandHandler_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {CommandHandler_0} -params {\
"ALGO_LOC_ADDR:0" \
"DATAREQ_DWIDTH:64" \
"DATAREQ_EVENT_WINDOW_SIZE:48" \
"gAPB_AWIDTH:16" \
"gAPB_DWIDTH:16" \
"gENDEC_DWIDTH:16" \
"gSERDES_DWIDTH:20" \
"IO_SIZE:2" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {CommandHandler_0}
sd_create_pin_group -sd_name ${sd_name} -group_name {TRACKER_INTERFACE_IN} -instance_name {CommandHandler_0} -pin_names {"DATAREQ_LAST_WORD_FLAG" "DATAREQ_DATA_REQ_REPLY" "DATAREQ_STATUS" "DATAREQ_DATA_READY_FLAG" }
sd_create_pin_group -sd_name ${sd_name} -group_name {TRACKER_INTERFACE_OUT} -instance_name {CommandHandler_0} -pin_names {"DATAREQ_RE_FIFO" "DATAREQ_EVENT_WINDOW_TAG_2" "DATAREQ_EVENT_WINDOW_TAG_1" "DATAREQ_START_EVENT_REQ" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:INTERNAL_RESET} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CommandHandler_0:dbgSerialFifo_re}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CommandHandler_0:dbgSerialFifo_rst}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:dbgSerialFifo_full} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:dbgSerialFifo_empty} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:dbgSerialFifo_rdCnt} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:dbgSerialFifo_data} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:SEU_SRAM_ERRS} -value {0000000000000000}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:SEU_SRAM_RLOOPS} -value {0000000000000000}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:SEU_SRAM_BAD_LOC} -value {00000000000000000000000000000000}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:SEU_DDR3_ERRS} -value {0000000000000000}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:SEU_DDR3_RLOOPS} -value {0000000000000000}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CommandHandler_0:SEU_DDR3_BAD_LOC} -value {00000000000000000000000000000000}



# Add Ctrl_clk_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {Ctrl_clk} -instance_name {Ctrl_clk_0}



# Add DCS_RCV_FIFO instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DCS_FIFO} -instance_name {DCS_RCV_FIFO}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCS_RCV_FIFO:RDCNT}



# Add DCS_RESP_FIFO instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DCS_FIFO} -instance_name {DCS_RESP_FIFO}



# Add Debug_Latch_Counter_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {Debug_Latch_Counter} -hdl_file {hdl\DebugLatchCounter.vhd} -instance_name {Debug_Latch_Counter_0}



# Add DebugPacketSender_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DebugPacketSender} -hdl_file {hdl\DebuggerPacketSender.vhd} -instance_name {DebugPacketSender_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DebugPacketSender_0:ERROR}



# Add Forward instance
sd_instantiate_component -sd_name ${sd_name} -component_name {FIFO} -instance_name {Forward}



# Add ForwardDetector_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {ForwardDetector} -instance_name {ForwardDetector_0}
# Exporting Parameters of instance ForwardDetector_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {ForwardDetector_0} -params {\
"ALGO_LOC_ADDR:0" \
"gAPB_AWIDTH:16" \
"gAPB_DWIDTH:16" \
"gENDEC_DWIDTH:16" \
"gSERDES_DWIDTH:20" \
"IO_SIZE:2" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {ForwardDetector_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ForwardDetector_0:ERROREVENTALIGNMENT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ForwardDetector_0:ERRORLOOPBACKALIGNMENT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ForwardDetector_0:ERRORCLOCKALIGNMENT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ForwardDetector_0:ERROR_FLAG_FW}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ForwardDetector_0:ERROR_CODE_FW}



# Add INBUF_DIFF_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INBUF_DIFF} -instance_name {INBUF_DIFF_0}



# Add OR2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_0}
sd_invert_pins -sd_name ${sd_name} -pin_names {OR2_0:B}
sd_invert_pins -sd_name ${sd_name} -pin_names {OR2_0:Y}



# Add OR2_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_2}



# Add OR2_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_3}



# Add OR2_4 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_4}
sd_invert_pins -sd_name ${sd_name} -pin_names {OR2_4:B}
sd_invert_pins -sd_name ${sd_name} -pin_names {OR2_4:Y}



# Add OR3_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR3} -instance_name {OR3_0}



# Add OR3_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR3} -instance_name {OR3_1}



# Add Oscillator1_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {Oscillator1} -instance_name {Oscillator1_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Oscillator1_0:RCOSC_160MHZ_GL}



# Add PacketSender_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {PacketSender} -instance_name {PacketSender_0}
# Exporting Parameters of instance PacketSender_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {PacketSender_0} -params {\
"ALGO_LOC_ADDR:0" \
"gAPB_AWIDTH:16" \
"gAPB_DWIDTH:16" \
"gENDEC_DWIDTH:16" \
"gSERDES_DWIDTH:20" \
"IO_SIZE:2" \
"NORMAL_FIFO_ADDR_SIZE:9" \
"NUM_OF_TCLK_IN_40:5" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {PacketSender_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PacketSender_0:RETRANSMIT_RAM_RE}



# Add Receive instance
sd_instantiate_component -sd_name ${sd_name} -component_name {FIFO} -instance_name {Receive}



# Add ResetController_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ResetController} -instance_name {ResetController_0}



# Add Response instance
sd_instantiate_component -sd_name ${sd_name} -component_name {FIFO_Response} -instance_name {Response}



# Add Retransmit_RAM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {Retransmit_RAM} -instance_name {Retransmit_RAM_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Retransmit_RAM_0:B_WEN} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Retransmit_RAM_0:B_DIN} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Retransmit_RAM_0:A_DOUT}



# Add RocMonitor_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {RocMonitor} -instance_name {RocMonitor_0}
# Exporting Parameters of instance RocMonitor_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {RocMonitor_0} -params {\
"ALGO_LOC_ADDR:0" \
"gAPB_AWIDTH:16" \
"gAPB_DWIDTH:16" \
"gENDEC_DWIDTH:16" \
"gSERDES_DWIDTH:20" \
"IO_SIZE:2" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {RocMonitor_0}
sd_create_pin_group -sd_name ${sd_name} -group_name {DDR} -instance_name {RocMonitor_0} -pin_names {"DDR_DBG_RDONE" "DIGI_CLK_LOCK" "DDR_CLK" "DDR_READY" "DDR_RSTROBE" "DDR_WSTROBE" "DDR_DBG_AXI_BUSY" "DDR_DBG_WDONE" "DDR_RDATA" "DDR_WINDEX" "DDR_RINDEX" }
sd_create_pin_group -sd_name ${sd_name} -group_name {CorePCS} -instance_name {RocMonitor_0} -pin_names {"INVALID_K_0" "RX_EPCS_DATA_0" "RD_ERR_0" "B_CERR_0" "RX_K_CHAR_0" "CODE_ERR_N_0" "RX_DATA_0" }
sd_create_pin_group -sd_name ${sd_name} -group_name {DDR3} -instance_name {RocMonitor_0} -pin_names {"DDR_RST_N" "DDR_WE" "DDR_RE" "DDR_WADDR" "DDR_WDATA" "DDR_RADDR" "DDR_WLEN" "DDR_RLEN" }
sd_create_pin_group -sd_name ${sd_name} -group_name {SEU} -instance_name {RocMonitor_0} -pin_names {"SEU_DDR3_BAD_LOC" "SEU_RADDR" "SEU_WADDR" "SEU_WDATA" "SEU_SRAM_ERRS" "SEU_SRAM_RLOOPS" "SEU_SRAM_BAD_LOC" "SEU_DDR3_ERRS" "SEU_DDR3_RLOOPS" "SEU_WE" }
sd_create_pin_group -sd_name ${sd_name} -group_name {SEU_Group} -instance_name {RocMonitor_0} -pin_names {"SEU_RDATA" }
sd_create_pin_group -sd_name ${sd_name} -group_name {XCVR_TX} -instance_name {RocMonitor_0} -pin_names {"TX_DATA_0" "TX_EPCS_DATA_0" "FORCE_DISP_0" "TX_K_CHAR_0" "DISP_SEL_0" "TX_EPCS_SEL_0" }
sd_create_pin_group -sd_name ${sd_name} -group_name {DIGI_O} -instance_name {RocMonitor_0} -pin_names {"DIGI_DATA_OUT" "DIGI_EXT_RST" "DIGI_RST" "DIGI_FIFO_WE_OUT" }
sd_create_pin_group -sd_name ${sd_name} -group_name {RESET} -instance_name {RocMonitor_0} -pin_names {"ALGO_RESET" }
sd_create_pin_group -sd_name ${sd_name} -group_name {UNUSED_ALGO_O} -instance_name {RocMonitor_0} -pin_names {"PREADY" "PRDATA" "ALGO_ADDR" "ALGO_WDATA" "RegOut" "PSLVERR" "RESET_EPCS_MUX_SEL_0" }
sd_create_pin_group -sd_name ${sd_name} -group_name {DIGI_I} -instance_name {RocMonitor_0} -pin_names {"DIGI_SYNC_IN" "DIGI_DATA_IN" "DIGI_FIFO_WE" "DIGI_CLK" }
sd_create_pin_group -sd_name ${sd_name} -group_name {UNUSED_ALGO_I} -instance_name {RocMonitor_0} -pin_names {"PWDATA" "PRESETn" "PENABLE" "PSEL" "PWRITE" "PADDR" "ALGO_RDATA" "refclk_lock" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:PENABLE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:PSEL} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:PWRITE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PREADY}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PSLVERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:TX_EPCS_SEL_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:RESET_EPCS_MUX_SEL_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_CLK} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_SYNC_IN} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_FIFO_WE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_CLK_LOCK} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_FIFO_WE_OUT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_RST}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_EXT_RST}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_CLK} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_READY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_WSTROBE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_RSTROBE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_RST_N}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_WE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_RE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_DBG_AXI_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_DBG_WDONE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_DBG_RDONE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:TCLK_TIMESTAMP_RESET}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PLL_START_PHASE_SHIFT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PLL_PHASE_DIRECTION}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PLL_RESET_PHASE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PLL_PhaseShift_Enable}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:FinePhase_Enable}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_WE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:refclk_lock} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:PADDR} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:PWDATA} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PRDATA}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:RX_EPCS_DATA_0} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:TX_EPCS_DATA_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:TX_DATA_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:TX_K_CHAR_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:FORCE_DISP_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DISP_SEL_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:EVENT_START_COARSE_40}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DIGI_DATA_OUT}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_RDATA} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_RINDEX} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_WADDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_WDATA}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_RADDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_WLEN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_RLEN}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DDR_WINDEX} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:PLL_TICK_COUNT}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_RADDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_WADDR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_WDATA}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_RDATA} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_SRAM_ERRS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_SRAM_RLOOPS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_SRAM_BAD_LOC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_DDR3_ERRS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_DDR3_RLOOPS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:SEU_DDR3_BAD_LOC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DEBUG_REG_0} -value {0001001000110100}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DEBUG_REG_2} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {RocMonitor_0:DEBUG_REG_3} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {RocMonitor_0:RegOut}



# Add RX_ForwardDetector instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {RX_ForwardDetector}



# Add timeStamp_IF_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {timeStamp_IF} -hdl_file {hdl\TimeStamp_IF_TEST.vhd} -instance_name {timeStamp_IF_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timeStamp_IF_0:WE}



# Add timestamp_manager_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {timeStamp_Manager} -hdl_file {hdl\TimeStampManager.vhd} -instance_name {timestamp_manager_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {timestamp_manager_0:ENABLE_LOOPBACK_DELAY} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:TIMESTAMP_RESET}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:TIMESTAMP_OF}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:TCLK_ALIGNED}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:EVENTEARLYERROR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:EVENT_WINDOW_TAG}



# Add TX_PacketSender instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {TX_PacketSender}



# Add XCVR_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_Block} -instance_name {XCVR_Block_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"Debug_Latch_Counter_0:ALGO_CLK" "DCS_RESP_FIFO:RCLOCK" "DCS_RESP_FIFO:WCLOCK" "ALGO_CLK_PLL_1:OUT0_0" "CommandHandler_0:ALGO_CLK" "ALGO_CLK" "RocMonitor_0:algo_clk" "Response:WCLOCK" "Receive:RCLOCK" "DCS_RCV_FIFO:WCLOCK" "DCS_RCV_FIFO:RCLOCK" "ForwardDetector_0:ALGO_CLK" "PacketSender_0:ALGO_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Clock40Mhz_0:Clk_40Mhz" "ForwardDetector_0:CLK40_GEN" "PacketSender_0:CLK40_GEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RCV_FIFO_WE" "DCS_RCV_FIFO:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RESET_FIFOS" "OR2_2:B" "OR2_3:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:RE" "CommandHandler_0:DCS_RESP_FIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RCV_FIFO_RE_0" "Receive:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RCV_FIFO_RESET_0" "OR3_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RESP_FIFO_RESET_0" "OR3_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RESP_FIFO_WE_0" "Response:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RESET_CLK" "ResetController_0:SLOW_CLK" "Ctrl_clk_0:CLK_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFifo_re" "RocMonitor_0:dbgSerialFifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DAQFifo_we" "RocMonitor_0:dbgSerialFifo_we" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_DATA_READY_FLAG" "DATAREQ_DATA_READY_FLAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_LAST_WORD_FLAG" "DATAREQ_LAST_WORD_FLAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_RE_FIFO" "DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_START_EVENT_REQ" "DATAREQ_START_EVENT_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dbgSerialFifo_empty" "RocMonitor_0:dbgSerialFifo_empty" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dbgSerialFifo_full" "RocMonitor_0:dbgSerialFifo_full" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RCV_FIFO_EMPTY" "RocMonitor_0:DCS_RCV_FIFO_EMPTY" "DCS_RCV_FIFO:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RCV_FIFO_FULL" "RocMonitor_0:DCS_RCV_FIFO_FULL" "DCS_RCV_FIFO:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:EMPTY" "CommandHandler_0:DCS_RESP_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:FULL" "CommandHandler_0:DCS_RESP_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:EMPTY" "PacketSender_0:FWD_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:FULL" "ForwardDetector_0:FWD_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Clock40Mhz_0:CLOCKMARKER" "ForwardDetector_0:CLOCKMARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:CRC_EN" "ForwardDetector_0:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:RST" "ForwardDetector_0:CRC_RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Clock40Mhz_0:EVENTMARKER" "timestamp_manager_0:EVENTMARKER_40" "ForwardDetector_0:EVENTMARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:RESET" "ForwardDetector_0:FWD_FIFO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:WE" "ForwardDetector_0:FWD_FIFO_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:LOOPBACKMODE_40" "ForwardDetector_0:LOOPBACKMODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ForwardDetector_0:RCV_FIFO_RESET" "OR2_0:A" "OR3_0:B" "OR2_4:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:WE" "ForwardDetector_0:RCV_FIFO_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ForwardDetector_0:RETRANSMIT_DETECTED" "PacketSender_0:RETRANSMIT_DETECTED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timeStamp_IF_0:RECORDTIMESTAMP" "INBUF_DIFF_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INIT_DONE" "XCVR_Block_0:INIT_DONE" "ResetController_0:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "XCVR_Block_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "XCVR_Block_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "XCVR_Block_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "XCVR_Block_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_0:Y" "PacketSender_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:RESET" "OR2_2:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RCV_FIFO:RESET" "OR2_3:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RESET_N" "OR2_4:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:RESET" "OR3_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:RESET" "OR3_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Ctrl_clk_0:CLK_IN" "Oscillator1_0:RCOSC_160MHZ_CLK_DIV" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:CRC_EN" "PacketSender_0:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:RST" "PacketSender_0:CRC_RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:RE" "PacketSender_0:FWD_FIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:RE" "PacketSender_0:RESP_FIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR3_1:B" "PacketSender_0:RESP_FIFO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Retransmit_RAM_0:A_WEN" "PacketSender_0:RETRANSMIT_RAM_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RCV_FIFO_EMPTY_0" "Receive:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:FULL" "ForwardDetector_0:RCV_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "XCVR_Block_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "XCVR_Block_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Clock40Mhz_0:RESET_N" "ResetController_0:RESET_40CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_CH_N" "OR2_4:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_DCSRECV" "OR2_3:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_DCSRESP" "OR2_2:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_FWD_N" "ForwardDetector_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DebugPacketSender_0:RESET_N" "ResetController_0:RESET_PS_N" "OR2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_RCV" "OR3_0:C" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Debug_Latch_Counter_0:RESET_N" "RocMonitor_0:PRESETn" "ResetController_0:RESET_RM_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_RSP" "OR3_1:C" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:RESET_N" "ResetController_0:RESET_TS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:EMPTY" "PacketSender_0:RESP_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RESP_FIFO_FULL_0" "Response:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:ALGO_RESET" "RocMonitor_0:ALGO_RESET" "ForwardDetector_0:ALGO_RESET" "PacketSender_0:ALGO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:ALIGNMENT_REQ" "RocMonitor_0:DCS_ALIGNMENT_REQ" "ForwardDetector_0:ALIGNMENT_REQ" "PacketSender_0:ALIGNMENT_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:DCS_RCV_FIFO_RE" "DCS_RCV_FIFO:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:WE" "RocMonitor_0:DCS_RESP_FIFO_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Debug_Latch_Counter_0:DEBUG_PULSE" "RocMonitor_0:DEBUG_PREREAD_PULSE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RESET_XCVR_ERRORS" "RocMonitor_0:RESET_XCVR_ERRORS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:SEL_RST" "ResetController_0:SEL_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"STAMP_N" "INBUF_DIFF_0:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"STAMP_P" "INBUF_DIFF_0:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:LOOPBACKMARKER_OUT" "PacketSender_0:LOOPBACKMARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:ALIGNED" "RocMonitor_0:ALIGNED_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:WCLOCK" "ALGO_CLK_PLL_1:REF_CLK_0" "Clock40Mhz_0:Clk_200Mhz" "XCVR_Block_0:LANE0_RX_CLK_R" "timeStamp_IF_0:TCLK" "timestamp_manager_0:TCLK" "RX_ForwardDetector:CLK" "Receive:WCLOCK" "ForwardDetector_0:EPCS_RXCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RX_VAL" "ForwardDetector_0:RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DebugPacketSender_0:EPCS_TXCLK" "Forward:RCLOCK" "TX_PacketSender:CLK" "XCVR_Block_0:LANE0_TX_CLK_R" "Retransmit_RAM_0:CLK" "Response:RCLOCK" "PacketSender_0:EPCS_TXCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DebugPacketSender_0:TX_CLK_STABLE" "XCVR_Block_0:LANE0_TX_CLK_STABLE" "RocMonitor_0:EPCS_0_TX_CLK_STABLE" "PacketSender_0:TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:XCVR_LOCK" "ForwardDetector_0:XCVR_LOCK" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RCV_FIFO_DATA" "DCS_RCV_FIFO:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:HEARTBEAT_EVENT_WINDOW_TAG" "CommandHandler_0:HEARTBEAT_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:DATA" "CommandHandler_0:RESP_FIFO_DATA_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:dbgSerialFifo_dataOut" "DAQFifo_DataOut" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_DATA_REQ_REPLY" "DATAREQ_DATA_REQ_REPLY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_EVENT_WINDOW_TAG_1" "CommandHandler_0:DATAREQ_EVENT_WINDOW_TAG_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_EVENT_WINDOW_TAG_2" "DATAREQ_EVENT_WINDOW_TAG_2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_PACKETS_IN_EVENT" "CommandHandler_0:DATAREQ_PACKETS_IN_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_STATUS" "DATAREQ_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"dbgSerialFifo_dataIn" "RocMonitor_0:dbgSerialFifo_dataIn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:dbgSerialFifo_rdCnt" "dbgSerialFifo_rdCnt" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RCV_FIFO:Q" "RocMonitor_0:DCS_RCV_FIFO_Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:Q" "CommandHandler_0:DCS_RESP_FIFO_Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:RDCNT" "CommandHandler_0:DCS_RESP_FIFO_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Debug_Latch_Counter_0:DEBUG_COUNTER_16" "RocMonitor_0:DEBUG_REG_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:FWD_FIFO_Q" "Forward:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:DATA_IN" "ForwardDetector_0:CRC_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:DATA" "ForwardDetector_0:FWD_FIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:DATA" "ForwardDetector_0:RCV_FIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:RETRANSMIT_SEQUENCE_REQ" "ForwardDetector_0:RETRANSMIT_SEQUENCE_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:ALGO_RDATA" "RocMonitor_0:ALGO_RDATA" "CommandHandler_0:ALGO_RDATA" "PacketSender_0:ALGO_RDATA" "ForwardDetector_0:ALGO_RDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:DATA_IN" "PacketSender_0:CRC_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:DISP_SEL" "PacketSender_0:DISP_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:FORCE_DISP" "PacketSender_0:FORCE_DISP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Retransmit_RAM_0:A_DIN" "PacketSender_0:RETRANSMIT_DOUT_TO_RAM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Retransmit_RAM_0:B_ADDR" "PacketSender_0:RETRANSMIT_RAM_RADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Retransmit_RAM_0:A_ADDR" "PacketSender_0:RETRANSMIT_RAM_WADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:TX_DATA" "PacketSender_0:TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DebugPacketSender_0:TX_K_CHAR" "XCVR_Block_0:TX_K_CHAR" "PacketSender_0:TX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:Q" "CommandHandler_0:RCV_FIFO_Q_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:Q" "PacketSender_0:RESP_FIFO_Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:RDCNT" "PacketSender_0:RESP_FIFO_COUNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Retransmit_RAM_0:B_DOUT" "PacketSender_0:RETRANSMIT_DOUT_FROM_RAM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:ALGO_ADDR" "CommandHandler_0:ALGO_ADDR" "XCVR_Block_0:ALGO_ADDR" "PacketSender_0:ALGO_ADDR" "ForwardDetector_0:ALGO_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:ALGO_WDATA" "CommandHandler_0:ALGO_WDATA" "XCVR_Block_0:ALGO_WDATA" "PacketSender_0:ALGO_WDATA" "ForwardDetector_0:ALGO_WDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:DATA" "RocMonitor_0:DCS_RESP_FIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:EVENT_START_DELAY_FINE_TCLK" "timestamp_manager_0:EVENT_START_DELAY_FINE_TCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:SEL_RST_CNTL" "ResetController_0:SEL_RST_CNTL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:CRC_OUT" "ForwardDetector_0:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:DIGI_DATA_IN" "timeStamp_IF_0:TIMESTAMP_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:TIMESTAMP" "timeStamp_IF_0:TIMESTAMP_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:CRC_OUT" "PacketSender_0:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:B_CERR" "RocMonitor_0:B_CERR_0" "ForwardDetector_0:B_CERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:CODE_ERR_N" "RocMonitor_0:CODE_ERR_N_0" "ForwardDetector_0:CODE_ERR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:INVALID_K" "RocMonitor_0:INVALID_K_0" "ForwardDetector_0:INVALID_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RD_ERR" "RocMonitor_0:RD_ERR_0" "ForwardDetector_0:RD_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_DATA" "RocMonitor_0:RX_DATA_0" "ForwardDetector_0:RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_K_CHAR" "RocMonitor_0:RX_K_CHAR_0" "ForwardDetector_0:RX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RocMonitor_0:XCVR_LOSS_COUNTER" "XCVR_Block_0:XCVR_LOSS_COUNTER" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TOP_SERDES
generate_component -component_name ${sd_name}
