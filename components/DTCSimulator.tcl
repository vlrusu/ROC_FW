# Creating SmartDesign DTCSimulator
set sd_name {DTCSimulator}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALIGN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DATAREQ_LAST_WORD} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQCLK_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DREQ_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EXT_RST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MARKER_SEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ON_SPILL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RXCLK_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDESCLK_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERDES_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_CFO_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_CFO_PREF_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SERIAL_CFO_START} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SIM_START} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TXCLK_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TX_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {dreq_start} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {hb_start} -port_direction {IN}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {ADDR} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BLOCK_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {EVENT_MODE} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {EVENT_WINDOW_TAG} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MARKER_TYPE} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MODULE_ID} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {OP_CODE} -port_direction {IN} -port_range {[5:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PACKET_TYPE} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RF_MARKER} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SEQ_NUM} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERIAL_DELTAHB} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERIAL_NUMBERHB} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SERIAL_OFFSETHB} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {WDATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dreq_ewtag} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {hb_ewtag} -port_direction {IN} -port_range {[47:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_TX_DATA} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_TX_KCHAR} -port_direction {OUT} -port_range {[1:0]}


# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add cfo_emulator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cfo_emulator} -hdl_file {hdl\cfo_emulator.v} -instance_name {cfo_emulator_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {cfo_emulator_0:OFFSETHB} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {cfo_emulator_0:OFFSETHB} -pin_slices {[47:32]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {cfo_emulator_0:OFFSETHB[47:32]} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {cfo_emulator_0:datareq_good}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {cfo_emulator_0:Spill_EWtag}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {cfo_emulator_0:EWtag_offset}



# Add cfo_emulator_switch_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {cfo_emulator_switch} -hdl_file {hdl\cfo_emulator_switch.v} -instance_name {cfo_emulator_switch_0}



# Add DTC_simulator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DTC_simulator} -hdl_file {hdl\DTC_simulator.v} -instance_name {DTC_simulator_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTC_simulator_0:EVENT_WINDOW_OFFSET} -pin_slices {[31:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {DTC_simulator_0:EVENT_WINDOW_OFFSET} -pin_slices {[47:32]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DTC_simulator_0:EVENT_WINDOW_OFFSET[47:32]} -value {GND}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add INV_0_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0_0}



# Add INV_0_0_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0_0_0}



# Add MARKER_Simulator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {MARKER_Simulator} -hdl_file {hdl\MARKER_Simulator.v} -instance_name {MARKER_Simulator_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MARKER_Simulator_0:KCHAR_TO_TX} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MARKER_Simulator_0:KCHAR_TO_TX} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MARKER_Simulator_0:KCHAR_TO_TX_REG} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {MARKER_Simulator_0:KCHAR_TO_TX_REG} -pin_slices {[1:1]}



# Add mux_to_xcvr_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {mux_to_xcvr} -hdl_file {hdl\mux_to_xcvr.vhd} -instance_name {mux_to_xcvr_0}



# Add OR2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_0}



# Add OR2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {OR2} -instance_name {OR2_1}



# Add PACKET_FIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PACKET_FIFO} -instance_name {PACKET_FIFO_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PACKET_FIFO_0:DATA} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PACKET_FIFO_0:DATA} -pin_slices {[23:18]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PACKET_FIFO_0:DATA[23:18]} -value {000000}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PACKET_FIFO_0:Q} -pin_slices {[17:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {PACKET_FIFO_0:Q} -pin_slices {[23:18]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PACKET_FIFO_0:Q[23:18]}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGN" "DTC_simulator_0:ALIGN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "AND2_1:A" "SIM_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "INV_0:A" "MARKER_SEL" "cfo_emulator_switch_0:serial_MARKER_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "OR2_0:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:B" "INV_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:Y" "OR2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATAREQ_LAST_WORD" "DTC_simulator_0:DATAREQ_LAST_WORD" "cfo_emulator_0:datareq_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQCLK_RESETN" "cfo_emulator_0:dreqclk_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DREQ_CLK" "cfo_emulator_0:dreqclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_EMPTY" "PACKET_FIFO_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_FULL" "PACKET_FIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:MARKER_ON" "INV_0_0_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:ON_SPILL" "ON_SPILL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:SERDES_CLK" "PACKET_FIFO_0:WCLOCK" "SERDES_CLK" "cfo_emulator_0:serdesclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:SERDES_RESETN" "SERDESCLK_RESETN" "cfo_emulator_0:serdesclk_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:TO_FIFO_RE" "PACKET_FIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:TO_FIFO_WE" "PACKET_FIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:XCVR_CLK" "MARKER_Simulator_0:XCVR_CLK" "PACKET_FIFO_0:RCLOCK" "TX_CLK" "mux_to_xcvr_0:XCVR_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:XCVR_RESETN" "MARKER_Simulator_0:XCVR_RESETN" "TXCLK_RESETN" "mux_to_xcvr_0:XCVR_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:cfo_emul_en" "SERIAL_CFO_EN" "cfo_emulator_switch_0:cfo_emul_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:start" "OR2_1:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EXT_RST_N" "PACKET_FIFO_0:RRESET_N" "PACKET_FIFO_0:WRESET_N" "cfo_emulator_0:fifo_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0_0:A" "MARKER_Simulator_0:KCHAR_TO_TX_REG[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0_0:Y" "cfo_emulator_switch_0:cfo_emul_MARKER_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0_0_0:A" "MARKER_Simulator_0:KCHAR_TO_TX[0:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:START" "OR2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_0:A" "cfo_emulator_0:startEWM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"OR2_1:A" "cfo_emulator_0:startCFO" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RXCLK_RESETN" "cfo_emulator_0:xcvrclk_resetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_CLK" "cfo_emulator_0:xcvrclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_CFO_PREF_EN" "cfo_emulator_0:prefetch_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_CFO_START" "cfo_emulator_0:start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_0:dreq_start" "dreq_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_0:hb_start" "hb_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_switch_0:MARKER_SEL" "mux_to_xcvr_0:MARKER_SEL" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ADDR" "DTC_simulator_0:ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLOCK_CNT" "DTC_simulator_0:BLOCK_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:DATA_TO_TX" "mux_to_xcvr_0:DTC_SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:EVENT_MODE" "cfo_emulator_switch_0:EVENT_MODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:EVENT_WINDOW_OFFSET[31:0]" "SERIAL_OFFSETHB" "cfo_emulator_0:OFFSETHB[31:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:EVENT_WINDOW_TAG" "cfo_emulator_switch_0:EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_OUT" "PACKET_FIFO_0:Q[17:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_RDCNT" "PACKET_FIFO_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_WRCNT" "PACKET_FIFO_0:WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:KCHAR_TO_TX" "mux_to_xcvr_0:DTC_SIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:MODULE_ID" "MODULE_ID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:OP_CODE" "OP_CODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:PACKET_TYPE" "cfo_emulator_switch_0:PACKET_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:RF_MARKER" "RF_MARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:TO_FIFO_IN" "PACKET_FIFO_0:DATA[17:0]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:WDATA" "WDATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EVENT_MODE" "cfo_emulator_switch_0:serial_EVENT_MODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"EVENT_WINDOW_TAG" "cfo_emulator_switch_0:serial_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:DATA_TO_TX_REG" "mux_to_xcvr_0:MARKER_SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:KCHAR_TO_TX_REG" "mux_to_xcvr_0:MARKER_SIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:MARKER_TYPE" "MARKER_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:SEQ_NUM" "SEQ_NUM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_TYPE" "cfo_emulator_switch_0:serial_PACKET_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_DELTAHB" "cfo_emulator_0:DELTAHB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SERIAL_NUMBERHB" "cfo_emulator_0:NUMBERHB" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_TX_DATA" "mux_to_xcvr_0:SIM_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SIM_TX_KCHAR" "mux_to_xcvr_0:SIM_TX_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_0:CFO_packet_type" "cfo_emulator_switch_0:cfo_emul_PACKET_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_0:EWtag" "cfo_emulator_switch_0:cfo_emul_EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_0:dreq_ewtag" "dreq_ewtag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_0:event_mode" "cfo_emulator_switch_0:cfo_emul_EVENT_MODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"cfo_emulator_0:hb_ewtag" "hb_ewtag" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DTCSimulator
generate_component -component_name ${sd_name}
