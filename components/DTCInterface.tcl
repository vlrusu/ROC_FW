# Creating SmartDesign DTCInterface
set sd_name {DTCInterface}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ON_SPILL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALIGN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {SIM_START} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {BLK_WEN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DTC_SEL} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {KCHAR_TO_TX} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATA_TO_TX} -port_direction {OUT} -port_range {[15:0]}
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



# Add mux_xcvr_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {mux_xcvr} -hdl_file {hdl\mux_xcvr.v} -instance_name {mux_xcvr_0}



# Add PACKET_FIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PACKET_FIFO} -instance_name {PACKET_FIFO_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:ALIGN" "ALIGN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "MARKER_Simulator_0:start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:Y" "DTC_simulator_0:start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:W_EN" "BLK_WEN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "INV_0:A" "mux_xcvr_0:DTC_SEL" "DTC_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:R_EN" "DTC_simulator_0:RAM_RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:TO_FIFO_RE" "PACKET_FIFO_0:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:TO_FIFO_WE" "PACKET_FIFO_0:WE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:CLK" "DTC_simulator_0:HCLK" "MARKER_Simulator_0:HCLK" "PACKET_FIFO_0:WCLOCK" "HCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:HRESETN" "MARKER_Simulator_0:HRESETN" "PACKET_FIFO_0:RESET" "HRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_1:B" "INV_0:Y" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:ON_SPILL" "ON_SPILL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_AE" "PACKET_FIFO_0:AEMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_EMPTY" "PACKET_FIFO_0:EMPTY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:FROM_FIFO_FULL" "PACKET_FIFO_0:FULL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:RX_CLK" "MARKER_Simulator_0:RX_CLK" "mux_xcvr_0:RX_CLK" "PACKET_FIFO_0:RCLOCK" "RX_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:RX_RESETN" "MARKER_Simulator_0:RX_RESETN" "mux_xcvr_0:RX_RESETN" "RX_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "AND2_1:A" "SIM_START" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:ADDR" "ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:W_ADDR" "BLK_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:W_DATA" "BLK_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:R_DATA" "DTC_simulator_0:RAM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:BLOCK_CNT" "BLOCK_CNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mux_xcvr_0:TX_DATA" "DATA_TO_TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:DATA_TO_TX" "mux_xcvr_0:DTC_SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:KCHAR_TO_TX" "mux_xcvr_0:DTC_SIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BLK_TPSRAM_0:R_ADDR" "DTC_simulator_0:RAM_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:TO_FIFO_IN" "PACKET_FIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:EVENT_MODE" "EVENT_MODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:EVENT_WINDOW_TAG" "EVENT_WINDOW_TAG" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"mux_xcvr_0:TX_KCHAR" "KCHAR_TO_TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:DATA_TO_TX" "mux_xcvr_0:MARKER_SIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:KCHAR_TO_TX" "mux_xcvr_0:MARKER_SIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:MARKER_TYPE" "MARKER_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:MODULE_ID" "MODULE_ID" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:OP_CODE" "OP_CODE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:Q" "DTC_simulator_0:FROM_FIFO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:RDCNT" "DTC_simulator_0:FROM_FIFO_RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PACKET_FIFO_0:WRCNT" "DTC_simulator_0:FROM_FIFO_WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:PACKET_TYPE" "PACKET_TYPE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:RF_MARKER" "RF_MARKER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MARKER_Simulator_0:SEQ_NUM" "SEQ_NUM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTC_simulator_0:WDATA" "WDATA" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign DTCInterface
generate_component -component_name ${sd_name}