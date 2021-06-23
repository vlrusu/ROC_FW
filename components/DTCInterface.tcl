# Creating SmartDesign DTCInterface
set sd_name {DTCInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {HRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ON_SPILL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALIGN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SIM_START} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {BLK_WEN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MARKER_SEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {XCVR_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {XCVR_RESETN} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {RF_MARKER} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PACKET_TYPE} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {OP_CODE} -port_direction {IN} -port_range {[5:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BLOCK_CNT} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MODULE_ID} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ADDR} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {WDATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {EVENT_WINDOW_TAG} -port_direction {IN} -port_range {[47:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {EVENT_MODE} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SEQ_NUM} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {MARKER_TYPE} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BLK_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BLK_ADDR} -port_direction {IN} -port_range {[6:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DCS_PACKET_CNT} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DTC_MARKER_CNT} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_TX_KCHAR} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {SIM_TX_DATA} -port_direction {OUT} -port_range {[15:0]}

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add AND2_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_1}



# Add BLK_TPSRAM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {BLK_TPSRAM} -instance_name {BLK_TPSRAM_0}



# Add DTC_simulator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {DTC_simulator} -hdl_file {hdl\DTC_simulator.v} -instance_name {DTC_simulator_0}



# Add INV_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {INV} -instance_name {INV_0}



# Add MARKER_Simulator_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {MARKER_Simulator} -hdl_file {hdl\MARKER_Simulator.v} -instance_name {MARKER_Simulator_0}



# Add mux_to_xcvr_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {mux_to_xcvr} -hdl_file {hdl\mux_to_xcvr.vhd} -instance_name {mux_to_xcvr_0}



# Add PACKET_FIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PACKET_FIFO} -instance_name {PACKET_FIFO_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:ALIGN" "ALIGN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:start" "AND2_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:Y" "DTC_simulator_0:start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:W_EN" "BLK_WEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:R_EN" "DTC_simulator_0:RAM_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:RE" "DTC_simulator_0:TO_FIFO_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:WE" "DTC_simulator_0:TO_FIFO_WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:WCLOCK" "MARKER_Simulator_0:HCLK" "BLK_TPSRAM_0:CLK" "DTC_simulator_0:HCLK" "HCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:RESET" "MARKER_Simulator_0:HRESETN" "DTC_simulator_0:HRESETN" "HRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:Y" "AND2_1:B" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INV_0:A" "mux_to_xcvr_0:MARKER_SEL" "AND2_0:B" "MARKER_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:XCVR_RESETN" "mux_to_xcvr_0:XCVR_RESETN" "DTC_simulator_0:XCVR_RESETN" "XCVR_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:ON_SPILL" "ON_SPILL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:AEMPTY" "DTC_simulator_0:FROM_FIFO_AE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:EMPTY" "DTC_simulator_0:FROM_FIFO_EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:FULL" "DTC_simulator_0:FROM_FIFO_FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "AND2_1:A" "SIM_START" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:XCVR_CLK" "PACKET_FIFO_0:RCLOCK" "mux_to_xcvr_0:XCVR_CLK" "DTC_simulator_0:XCVR_CLK" "XCVR_CLK" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:ADDR" "ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:W_ADDR" "BLK_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:W_DATA" "BLK_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:RAM_DATA" "BLK_TPSRAM_0:R_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:BLOCK_CNT" "BLOCK_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:DCS_PACKET_CNT" "DCS_PACKET_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:DTC_MARKER_CNT" "DTC_MARKER_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:DATA_TO_TX" "mux_to_xcvr_0:DTC_SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:KCHAR_TO_TX" "mux_to_xcvr_0:DTC_SIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:RAM_ADDR" "BLK_TPSRAM_0:R_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:DATA" "DTC_simulator_0:TO_FIFO_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:EVENT_MODE" "EVENT_MODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:EVENT_WINDOW_TAG" "EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:DATA_TO_TX" "mux_to_xcvr_0:MARKER_SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:KCHAR_TO_TX" "mux_to_xcvr_0:MARKER_SIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:MARKER_TYPE" "MARKER_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:MODULE_ID" "MODULE_ID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:OP_CODE" "OP_CODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:Q" "DTC_simulator_0:FROM_FIFO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:RDCNT" "DTC_simulator_0:FROM_FIFO_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:WRCNT" "DTC_simulator_0:FROM_FIFO_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:PACKET_TYPE" "PACKET_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:RF_MARKER" "RF_MARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:SEQ_NUM" "SEQ_NUM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mux_to_xcvr_0:SIM_TX_DATA" "SIM_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mux_to_xcvr_0:SIM_TX_KCHAR" "SIM_TX_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:WDATA" "WDATA" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DTCInterface
generate_component -component_name ${sd_name}
