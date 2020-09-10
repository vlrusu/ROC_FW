# Creating SmartDesign SerdesIF
set sd_name {SerdesIF}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {write_words} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {init_reset_n} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_P} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_RXD_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_P} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE1_TXD_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {init_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_reset_n} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fifo_rclk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane0_fifo_re} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {lane1_fifo_re} -port_direction {IN}

sd_create_bus_port -sd_name ${sd_name} -port_name {write_count} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {dummy_address} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_dummy_out} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_dummy_out} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_fifo_data_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_fifo_data_out} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane0_rdcnt} -port_direction {OUT} -port_range {[12:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {lane1_rdcnt} -port_direction {OUT} -port_range {[12:0]}

# Add LiteFastRXwrapper_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {LiteFastRXwrapper} -instance_name {LiteFastRXwrapper_0}



# Add LiteFastRXwrapper_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {LiteFastRXwrapper} -instance_name {LiteFastRXwrapper_1}



# Add LiteFastTXwrapper_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {LiteFastTXwrapper} -instance_name {LiteFastTXwrapper_0}



# Add LiteFastTXwrapper_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {LiteFastTXwrapper} -instance_name {LiteFastTXwrapper_1}



# Add ROCFIFO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO} -instance_name {ROCFIFO_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ROCFIFO_0:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ROCFIFO_0:EMPTY}



# Add ROCFIFO_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {ROCFIFO} -instance_name {ROCFIFO_1}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ROCFIFO_1:FULL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {ROCFIFO_1:EMPTY}



# Add SerdesInitializer_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {SerdesInitializer} -hdl_file {hdl\SerdesInitializer.vhd} -instance_name {SerdesInitializer_0}



# Add SerdesInitializer_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {SerdesInitializer} -hdl_file {hdl\SerdesInitializer.vhd} -instance_name {SerdesInitializer_1}



# Add SerdesStatus_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {SerdesStatus} -hdl_file {hdl\SerdesStatus.vhd} -instance_name {SerdesStatus_0}



# Add SerdesStatus_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {SerdesStatus} -hdl_file {hdl\SerdesStatus.vhd} -instance_name {SerdesStatus_1}



# Add TransceiverIF_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TransceiverIF} -instance_name {TransceiverIF_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TransceiverIF_0:LANE0_TX_DISPFNC} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TransceiverIF_0:LANE1_TX_DISPFNC} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TransceiverIF_0:LANE0_LOS} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {TransceiverIF_0:LANE1_LOS} -value {GND}



# Add TxPLL_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TxPLL} -instance_name {TxPLL_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {TxPLL_0:PLL_LOCK}



# Add TxRefClk_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {TxRefCLK} -instance_name {TxRefClk_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_ARST_N" "TransceiverIF_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "TransceiverIF_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:RCLOCK" "fifo_rclk" "ROCFIFO_1:RCLOCK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:RESET" "fifo_reset_n" "ROCFIFO_1:RESET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:clk" "SerdesStatus_0:clk" "init_clk" "SerdesInitializer_0:clk" "SerdesStatus_1:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:reset_n" "SerdesStatus_0:reset_n" "init_reset_n" "SerdesInitializer_0:reset_n" "SerdesStatus_1:reset_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:RE" "lane0_fifo_re" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "TransceiverIF_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "TransceiverIF_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "TransceiverIF_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "TransceiverIF_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane1_fifo_re" "ROCFIFO_1:RE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_N" "TransceiverIF_0:LANE1_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_RXD_P" "TransceiverIF_0:LANE1_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_N" "TransceiverIF_0:LANE1_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE1_TXD_P" "TransceiverIF_0:LANE1_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:block_aligned_rx_o" "SerdesStatus_0:block_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:crc_err_rx_o" "SerdesStatus_0:crc_err_rx" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:lane_aligned_rx_o" "LiteFastTXwrapper_0:lane_aligned" "SerdesInitializer_0:litefast_aligned" "SerdesStatus_0:lane_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:WE" "LiteFastRXwrapper_0:usr_data_val_rx_o" "SerdesStatus_0:usr_data_val" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:block_aligned_rx_o" "SerdesStatus_1:block_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:crc_err_rx_o" "SerdesStatus_1:crc_err_rx" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:lane_aligned" "LiteFastRXwrapper_1:lane_aligned_rx_o" "SerdesInitializer_1:litefast_aligned" "SerdesStatus_1:lane_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:usr_data_val_rx_o" "ROCFIFO_1:WE" "SerdesStatus_1:usr_data_val" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "TxRefClk_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "TxRefClk_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:pcs_reset_n" "TransceiverIF_0:LANE0_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:pma_reset_n" "TransceiverIF_0:LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:stable_lock" "SerdesStatus_0:stable_lock" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:pcs_reset_n" "TransceiverIF_0:LANE1_PCS_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:pma_reset_n" "TransceiverIF_0:LANE1_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:stable_lock" "SerdesStatus_1:stable_lock" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ROCFIFO_0:WCLOCK" "LiteFastRXwrapper_0:rx_clk" "TransceiverIF_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesStatus_0:rx_idle" "TransceiverIF_0:LANE0_RX_IDLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesStatus_0:rx_ready" "TransceiverIF_0:LANE0_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:rx_val" "LiteFastTXwrapper_0:rst_n_tx_i" "SerdesInitializer_0:rx_val" "SerdesStatus_0:rx_val" "TransceiverIF_0:LANE0_RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:tx_clk" "LiteFastTXwrapper_0:clk_tx_i" "TransceiverIF_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesStatus_0:tx_clk_stable" "TransceiverIF_0:LANE0_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:rx_clk" "ROCFIFO_1:WCLOCK" "TransceiverIF_0:LANE1_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesStatus_1:rx_idle" "TransceiverIF_0:LANE1_RX_IDLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesStatus_1:rx_ready" "TransceiverIF_0:LANE1_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:rst_n_tx_i" "LiteFastRXwrapper_1:rx_val" "SerdesInitializer_1:rx_val" "SerdesStatus_1:rx_val" "TransceiverIF_0:LANE1_RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:clk_tx_i" "LiteFastRXwrapper_1:tx_clk" "TransceiverIF_0:LANE1_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesStatus_1:tx_clk_stable" "TransceiverIF_0:LANE1_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"TransceiverIF_0:LANE0_CDR_REF_CLK_0" "TransceiverIF_0:LANE1_CDR_REF_CLK_0" "TxPLL_0:REF_CLK" "TxRefClk_0:REF_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:write_words" "LiteFastTXwrapper_0:write_words" "write_words" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"dummy_address" "SerdesStatus_1:address" "SerdesStatus_0:address" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane0_dummy_out" "SerdesStatus_0:registered_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane0_fifo_data_out" "ROCFIFO_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane0_rdcnt" "ROCFIFO_0:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane1_dummy_out" "SerdesStatus_1:registered_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane1_fifo_data_out" "ROCFIFO_1:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"lane1_rdcnt" "ROCFIFO_1:RDCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:local_token" "LiteFastTXwrapper_0:local_token_tx_i" "SerdesStatus_0:local_token" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:remote_token" "LiteFastTXwrapper_0:remote_token_tx_i" "SerdesStatus_0:remote_token" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:usr_data_rx_o" "ROCFIFO_0:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:local_token_tx_i" "LiteFastRXwrapper_1:local_token" "SerdesStatus_1:local_token" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:remote_token_tx_i" "LiteFastRXwrapper_1:remote_token" "SerdesStatus_1:remote_token" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:usr_data_rx_o" "ROCFIFO_1:DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_0:LiteFast_data_tx_o" "TransceiverIF_0:LANE0_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_0:LiteFast_k_tx_o" "TransceiverIF_0:LANE0_8B10B_TX_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:LiteFast_data_tx_o" "TransceiverIF_0:LANE1_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_1:LiteFast_k_tx_o" "TransceiverIF_0:LANE1_8B10B_TX_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:wrcnt" "ROCFIFO_0:WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:wrcnt" "ROCFIFO_1:WRCNT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:litefast_unaligned_cycle_count" "SerdesStatus_0:litefast_unaligned_cycle_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:reset_cycle_count" "SerdesStatus_0:reset_cycle_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:rx_notval_cycle_count" "SerdesStatus_0:rx_notval_cycle_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:litefast_unaligned_cycle_count" "SerdesStatus_1:litefast_unaligned_cycle_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:reset_cycle_count" "SerdesStatus_1:reset_cycle_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:rx_notval_cycle_count" "SerdesStatus_1:rx_notval_cycle_count" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:lane_k_rx_i" "TransceiverIF_0:LANE0_8B10B_RX_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:code_violation" "SerdesStatus_0:code_violation" "TransceiverIF_0:LANE0_RX_CODE_VIOLATION" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_0:lane_data_rx_i" "TransceiverIF_0:LANE0_RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_0:disp_error" "SerdesStatus_0:disparity_error" "TransceiverIF_0:LANE0_RX_DISPARITY_ERROR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:lane_k_rx_i" "TransceiverIF_0:LANE1_8B10B_RX_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:code_violation" "SerdesStatus_1:code_violation" "TransceiverIF_0:LANE1_RX_CODE_VIOLATION" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastRXwrapper_1:lane_data_rx_i" "TransceiverIF_0:LANE1_RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"SerdesInitializer_1:disp_error" "SerdesStatus_1:disparity_error" "TransceiverIF_0:LANE1_RX_DISPARITY_ERROR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LiteFastTXwrapper_0:write_count" "LiteFastTXwrapper_1:write_count" "write_count" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"TransceiverIF_0:CLKS_FROM_TXPLL_0" "TxPLL_0:CLKS_TO_XCVR" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign SerdesIF
generate_component -component_name ${sd_name}
