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
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALGO_CLK} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_RE_FIFO} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_START_EVENT_REQ} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_DATA_READY_FLAG} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_LAST_WORD_FLAG} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {BUSY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SIM_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_RST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {OSC_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_RESETN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DDR_DDR3_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TEMPFIFO_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_EMPTY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MEMFIFO_FULL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_SIM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_SIM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_ROCRESETN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_WRITE_MEM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_READ_MEM_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_MEMFIFO_RDEN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DCS_PATTERN_EN} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EVENTMARKER} -port_direction {OUT}

sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_EVENT_WINDOW_TAG_2} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_EVENT_WINDOW_TAG_1} -port_direction {OUT} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_STATUS} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_PACKETS_IN_EVENT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATAREQ_DATA_REQ_REPLY} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_K_CHAR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {TX_DATA_OUT} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {FIFO_RD_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEM_WR_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MEM_RD_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_WRITE_PAGE_NO} -port_direction {OUT} -port_range {[19:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_PATTERN} -port_direction {OUT} -port_range {[1:0]}

# Add ALGO_CLK_PLL_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ALGO_CLK_PLL_0} -instance_name {ALGO_CLK_PLL_1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ALGO_CLK_PLL_1:PLL_LOCK_0}



# Add BusyMonitor_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {BusyMonitor} -hdl_file {hdl\BusyMonitor.v} -instance_name {BusyMonitor_0}



# Add Clock40Mhz_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {Clock40Mhz} -hdl_file {hdl\Clk_40Mhz_RisingEdgeOnly.vhd} -instance_name {Clock40Mhz_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Clock40Mhz_0:alignedToMarker}



# Add CommandHandler_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {CommandHandler} -instance_name {CommandHandler_0}
# Exporting Parameters of instance CommandHandler_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {CommandHandler_0} -params {\
"ALGO_LOC_ADDR:9" \
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



# Add DCS_RCV_FIFO instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DCS_FIFO} -instance_name {DCS_RCV_FIFO}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DCS_RCV_FIFO:RDCNT}



# Add DCS_RESP_FIFO instance
sd_instantiate_component -sd_name ${sd_name} -component_name {DCS_FIFO} -instance_name {DCS_RESP_FIFO}



# Add DracMonitor_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {DracMonitor} -instance_name {DracMonitor_0}
# Exporting Parameters of instance DracMonitor_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {DracMonitor_0} -params {\
"gAPB_AWIDTH:16" \
"gAPB_DWIDTH:16" \
"gENDEC_DWIDTH:16" \
"gSERDES_DWIDTH:20" \
"IO_SIZE:2" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {DracMonitor_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DracMonitor_0:PREREAD_PULSE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DracMonitor_0:DEBUG_REG_0} -value {0001001000110100}



# Add Forward instance
sd_instantiate_component -sd_name ${sd_name} -component_name {FIFO} -instance_name {Forward}



# Add ForwardDetector_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {ForwardDetector} -instance_name {ForwardDetector_0}
# Exporting Parameters of instance ForwardDetector_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {ForwardDetector_0} -params {\
"ALGO_LOC_ADDR:7" \
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



# Add PacketSender_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {PacketSender} -instance_name {PacketSender_0}
# Exporting Parameters of instance PacketSender_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {PacketSender_0} -params {\
"ALGO_LOC_ADDR:10" \
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



# Add RX_ForwardDetector instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {RX_ForwardDetector}



# Add timeStamp_IF_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {timeStamp_IF} -hdl_file {hdl\TimeStamp_IF_TEST.vhd} -instance_name {timeStamp_IF_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timeStamp_IF_0:WE}



# Add timestamp_manager_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {timeStamp_Manager} -hdl_file {hdl\TimeStampManager.vhd} -instance_name {timestamp_manager_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:TIMESTAMP_RESET}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:TCLK_ALIGNED}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:TIMESTAMP_OF}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {timestamp_manager_0:EVENT_WINDOW_TAG}



# Add TX_PacketSender instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {crc} -hdl_file {hdl\crc.vhd} -instance_name {TX_PacketSender}



# Add XCVR_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_Block} -instance_name {XCVR_Block_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:ALGO_CLK" "ForwardDetector_0:ALGO_CLK" "ALGO_CLK" "ALGO_CLK_PLL_1:OUT1_FABCLK_0" "DCS_RCV_FIFO:CLK" "DCS_RESP_FIFO:CLK" "DracMonitor_0:ALGO_CLK" "CommandHandler_0:ALGO_CLK" "XCVR_Block_0:ALGO_CLK" "Receive:RCLOCK" "Response:WCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALGO_CLK_PLL_1:OUT0_FABCLK_0" "XCVR_Block_0:CLK200" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BusyMonitor_0:BUSY" "BUSY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Clock40Mhz_0:Clk_40Mhz" "PacketSender_0:CLK40_GEN" "ForwardDetector_0:CLK40_GEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RCV_FIFO_WE_0" "DCS_RCV_FIFO:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RESET_FIFOS_0" "OR2_2:B" "OR2_3:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RESP_FIFO_RE_0" "DCS_RESP_FIFO:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:RE" "CommandHandler_0:RCV_FIFO_RE_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RCV_FIFO_RESET_0" "OR3_0:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RESP_FIFO_RESET_0" "OR3_1:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:WE" "CommandHandler_0:RESP_FIFO_WE_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:CTRL_ARST_N" "CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:SLOW_CLK" "XCVR_Block_0:CTRL_CLK" "CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_DATA_READY_FLAG" "DATAREQ_DATA_READY_FLAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_LAST_WORD_FLAG" "DATAREQ_LAST_WORD_FLAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_RE_FIFO" "DATAREQ_RE_FIFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_START_EVENT_REQ" "DATAREQ_START_EVENT_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DCS_MEMFIFO_RDEN" "DCS_MEMFIFO_RDEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DCS_PATTERN_EN" "DCS_PATTERN_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RCV_FIFO:EMPTY" "DracMonitor_0:DCS_RCV_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RCV_FIFO:FULL" "DracMonitor_0:DCS_RCV_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DCS_READ_MEM_EN" "DCS_READ_MEM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RESP_FIFO_EMPTY_0" "DCS_RESP_FIFO:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RESP_FIFO_FULL_0" "DCS_RESP_FIFO:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DCS_ROCRESETN" "DCS_ROCRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DCS_SIM_EN" "DCS_SIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DCS_WRITE_MEM_EN" "DCS_WRITE_MEM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DDR_DDR3_FULL" "DDR_DDR3_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:ALGO_RESET" "CommandHandler_0:ALGO_RESET" "PacketSender_0:ALGO_RESET" "ForwardDetector_0:ALGO_RESET" "DracMonitor_0:ALGO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:ALIGNMENT_REQ" "PacketSender_0:ALIGNMENT_REQ" "ForwardDetector_0:ALIGNMENT_REQ" "DracMonitor_0:DCS_ALIGNMENT_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BusyMonitor_0:busy_write" "DCS_RCV_FIFO:RE" "DracMonitor_0:DCS_RCV_FIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:WE" "DracMonitor_0:DCS_RESP_FIFO_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:ENABLE_FINE_LOOPBACK_DELAY" "DracMonitor_0:EVENT_START_DELAY_FINE_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RESET_XCVR_ERRORS" "DracMonitor_0:RESET_XCVR_ERRORS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:SEL_RESET" "DracMonitor_0:SEL_RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DREQ_SIM_EN" "DREQ_SIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Clock40Mhz_0:EVENTMARKER" "timestamp_manager_0:EVENTMARKER_40" "ForwardDetector_0:EVENTMARKER" "EVENTMARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EXT_RST_N" "XCVR_Block_0:EXT_RST_N" "ResetController_0:EXT_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:FWD_FIFO_EMPTY" "Forward:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ForwardDetector_0:FWD_FIFO_FULL" "Forward:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BusyMonitor_0:busy_start" "ForwardDetector_0:BUSY_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Clock40Mhz_0:CLOCKMARKER" "ForwardDetector_0:CLOCKMARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:CRC_EN" "ForwardDetector_0:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:RST" "ForwardDetector_0:CRC_RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ForwardDetector_0:FWD_FIFO_RESET" "Forward:RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ForwardDetector_0:FWD_FIFO_WE" "Forward:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:LOOPBACKMODE_40" "ForwardDetector_0:LOOPBACKMODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_0:A" "OR2_4:A" "OR3_0:B" "ForwardDetector_0:RCV_FIFO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:WE" "ForwardDetector_0:RCV_FIFO_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:RETRANSMIT_DETECTED" "ForwardDetector_0:RETRANSMIT_DETECTED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timeStamp_IF_0:RECORDTIMESTAMP" "INBUF_DIFF_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:INIT_DONE" "XCVR_Block_0:INIT_DONE" "INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Forward:WCLOCK" "ForwardDetector_0:EPCS_RXCLK" "timeStamp_IF_0:TCLK" "timestamp_manager_0:TCLK" "LANE0_RX_CLK_R" "Clock40Mhz_0:Clk_200Mhz" "XCVR_Block_0:LANE0_RX_CLK_R" "Receive:WCLOCK" "RX_ForwardDetector:CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_N" "LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RXD_P" "LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_N" "LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TXD_P" "LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:MEMFIFO_EMPTY" "MEMFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:MEMFIFO_FULL" "MEMFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_0:Y" "PacketSender_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:RESET" "OR2_2:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BusyMonitor_0:reset_n" "DCS_RCV_FIFO:RESET" "OR2_3:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:RESET_N" "OR2_4:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:RESET" "OR3_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:RESET" "OR3_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OSC_CLK" "ALGO_CLK_PLL_1:REF_CLK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BusyMonitor_0:busy_stop" "PacketSender_0:BUSY_STOP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:CRC_EN" "PacketSender_0:CRC_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:RST" "PacketSender_0:CRC_RST" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:FWD_FIFO_RE" "Forward:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:RE" "PacketSender_0:RESP_FIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR3_1:B" "PacketSender_0:RESP_FIFO_RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Retransmit_RAM_0:A_WEN" "PacketSender_0:RETRANSMIT_RAM_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:EMPTY" "CommandHandler_0:RCV_FIFO_EMPTY_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:FULL" "ForwardDetector_0:RCV_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_40CLK_N" "Clock40Mhz_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_CH_N" "OR2_4:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_DCSRECV" "OR2_3:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_DCSRESP" "OR2_2:A" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_FWD_N" "ForwardDetector_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_PS_N" "OR2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_RCV" "OR3_0:C" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_RM_N" "DracMonitor_0:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:RESET_RSP" "OR3_1:C" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:RESET_N" "ResetController_0:RESET_TS_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:EMPTY" "PacketSender_0:RESP_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:FULL" "CommandHandler_0:RESP_FIFO_FULL_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:ALIGNED" "RX_ALIGNED" "DracMonitor_0:ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_RESETN" "XCVR_Block_0:RX_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:SIM_EN" "SIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"STAMP_N" "INBUF_DIFF_0:PADN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"STAMP_P" "INBUF_DIFF_0:PADP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:TEMPFIFO_EMPTY" "TEMPFIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:TEMPFIFO_FULL" "TEMPFIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:LOOPBACKMARKER_OUT" "PacketSender_0:LOOPBACKMARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_RX_VAL" "ForwardDetector_0:RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:RCLOCK" "Retransmit_RAM_0:CLK" "XCVR_Block_0:LANE0_TX_CLK_R" "TX_PacketSender:CLK" "BusyMonitor_0:clk" "PacketSender_0:EPCS_TXCLK" "Forward:RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:LANE0_TX_CLK_STABLE" "PacketSender_0:TX_CLK_STABLE" "DracMonitor_0:TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:XCVR_LOCK" "ForwardDetector_0:XCVR_LOCK" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RCV_FIFO_DATA_0" "DCS_RCV_FIFO:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:HEARTBEAT_EVENT_WINDOW_TAG" "timestamp_manager_0:HEARTBEAT_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:DATA" "CommandHandler_0:RESP_FIFO_DATA_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_DATA_REQ_REPLY" "CommandHandler_0:DATAREQ_DATA_REQ_REPLY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_EVENT_WINDOW_TAG_1" "DATAREQ_EVENT_WINDOW_TAG_1" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DATAREQ_EVENT_WINDOW_TAG_2" "DATAREQ_EVENT_WINDOW_TAG_2" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_PACKETS_IN_EVENT" "CommandHandler_0:DATAREQ_PACKETS_IN_EVENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_STATUS" "CommandHandler_0:DATAREQ_STATUS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:DCS_PATTERN" "DCS_PATTERN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RCV_FIFO:Q" "DracMonitor_0:DCS_RCV_FIFO_Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RESP_FIFO_Q_0" "DCS_RESP_FIFO:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:DCS_RESP_FIFO_RD_CNT_0" "DCS_RESP_FIFO:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_WRITE_PAGE_NO" "DracMonitor_0:DCS_WRITE_PAGE_NO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:ALGO_ADDR" "XCVR_Block_0:ALGO_ADDR" "ForwardDetector_0:ALGO_ADDR" "PacketSender_0:ALGO_ADDR" "DracMonitor_0:ALGO_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:ALGO_WDATA" "XCVR_Block_0:ALGO_WDATA" "ForwardDetector_0:ALGO_WDATA" "PacketSender_0:ALGO_WDATA" "DracMonitor_0:ALGO_WDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DCS_RESP_FIFO:DATA" "DracMonitor_0:DCS_RESP_FIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timestamp_manager_0:EVENT_START_DELAY_FINE" "DracMonitor_0:EVENT_START_DELAY_FINE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ResetController_0:SEL_RST_CNTL" "DracMonitor_0:SEL_RST_CNTL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:FIFO_RD_CNT" "FIFO_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:FWD_FIFO_Q" "Forward:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:DATA_IN" "ForwardDetector_0:CRC_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ForwardDetector_0:FWD_FIFO_DATA" "Forward:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ForwardDetector_0:LINK_ID" "PacketSender_0:LINK_ID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:DATA" "ForwardDetector_0:RCV_FIFO_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:RETRANSMIT_SEQUENCE_REQ" "ForwardDetector_0:RETRANSMIT_SEQUENCE_REQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:MEM_RD_CNT" "MEM_RD_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DracMonitor_0:MEM_WR_CNT" "MEM_WR_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CommandHandler_0:ALGO_RDATA" "XCVR_Block_0:ALGO_RDATA" "ForwardDetector_0:ALGO_RDATA" "PacketSender_0:ALGO_RDATA" "DracMonitor_0:ALGO_RDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:DATA_IN" "PacketSender_0:CRC_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:DISP_SEL" "PacketSender_0:DISP_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:FORCE_DISP" "PacketSender_0:FORCE_DISP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:RETRANSMIT_DOUT_TO_RAM" "Retransmit_RAM_0:A_DIN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:RETRANSMIT_RAM_RADDR" "Retransmit_RAM_0:B_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:RETRANSMIT_RAM_WADDR" "Retransmit_RAM_0:A_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:TX_DATA" "PacketSender_0:TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:TX_K_CHAR" "PacketSender_0:TX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Receive:Q" "CommandHandler_0:RCV_FIFO_Q_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:Q" "PacketSender_0:RESP_FIFO_Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Response:RDCNT" "PacketSender_0:RESP_FIFO_COUNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PacketSender_0:RETRANSMIT_DOUT_FROM_RAM" "Retransmit_RAM_0:B_DOUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_ForwardDetector:CRC_OUT" "ForwardDetector_0:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_DATA" "XCVR_Block_0:SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_K_CHAR" "XCVR_Block_0:SIM_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timeStamp_IF_0:TIMESTAMP_OUT" "DracMonitor_0:TIMESTAMP_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"timeStamp_IF_0:TIMESTAMP_IN" "timestamp_manager_0:TIMESTAMP" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_DATA_OUT" "XCVR_Block_0:TX_DATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TX_PacketSender:CRC_OUT" "PacketSender_0:CRC_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:B_CERR" "ForwardDetector_0:B_CERR" "DracMonitor_0:B_CERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:CODE_ERR_N" "ForwardDetector_0:CODE_ERR_N" "DracMonitor_0:CODE_ERR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:INVALID_K" "ForwardDetector_0:INVALID_K" "DracMonitor_0:INVALID_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RD_ERR" "ForwardDetector_0:RD_ERR" "DracMonitor_0:RD_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_DATA" "ForwardDetector_0:RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:RX_K_CHAR" "ForwardDetector_0:RX_K_CHAR" "DracMonitor_0:RX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_Block_0:XCVR_LOSS_COUNTER" "DracMonitor_0:XCVR_LOSS_COUNTER" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign TOP_SERDES
generate_component -component_name ${sd_name}
