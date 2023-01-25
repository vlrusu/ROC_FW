# Creating SmartDesign XCVR_Block
set sd_name {XCVR_Block}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ALIGN_RESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CTRL_CLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {DTCSIM_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ENABLE_ALIGNMENT} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRBS_EN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TX_RESETN} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CLOCK_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {EPCS_RxERR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_READY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RX_VAL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TX_CLK_R} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TX_CLK_STABLE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCS_ALIGNED} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {resetn_align} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {word_aligned} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {DTCSIM_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DTCSIM_KCHAR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRBS_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {PRBS_KCHAR} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {TX_DATA} -port_direction {IN} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {TX_K_CHAR} -port_direction {IN} -port_range {[1:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {ALIGNMENT_LOSS_COUNTER} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {B_CERR} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CODE_ERR_N} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DTCDATA_OUT} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {INVALID_K} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RD_ERR} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RX_DATA} -port_direction {OUT} -port_range {[15:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RX_K_CHAR} -port_direction {OUT} -port_range {[1:0]}


# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add ClockAligner_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {ClockAligner} -hdl_file {hdl\ClockAligner.vhd} -instance_name {ClockAligner_0}



# Add Core_PCS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CorePCS_C0} -instance_name {Core_PCS_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_PWRDN}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_TXOOB}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_TxRSTn} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Core_PCS_0:EPCS_TxVAL}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Core_PCS_0:FORCE_DISP} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Core_PCS_0:DISP_SEL} -value {GND}



# Add MUX_TX_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {MUX_TX} -hdl_file {hdl\MUX_TX.v} -instance_name {MUX_TX_0}



# Add ReplyPktDecoder_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {ReplyPktDecoder} -hdl_file {hdl\ReplyPktDecoder.v} -instance_name {ReplyPktDecoder_0}



# Add WordAligner_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {WordAligner} -hdl_file {hdl\WordAligner.vhd} -instance_name {WordAligner_0}



# Add WordFlipper_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {WordFlipper} -hdl_file {hdl\WordFlipper.vhd} -instance_name {WordFlipper_0}



# Add WordFlipper_1 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {WordFlipper} -hdl_file {hdl\WordFlipper.vhd} -instance_name {WordFlipper_1}



# Add XCVR_CLK_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_REF_CLK_C0} -instance_name {XCVR_CLK_0}



# Add XCVR_IF_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_ERM_C0} -instance_name {XCVR_IF_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_IF_0:LANE0_RX_SLIP} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_IF_0:LANE0_RX_BYPASS_DATA}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {XCVR_IF_0:LANE0_LOS} -value {GND}



# Add XCVR_PLL_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {XCVR_PLL_0} -instance_name {XCVR_PLL_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {XCVR_PLL_0:PLL_LOCK}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGN_RESETN" "AND2_0:A" "ClockAligner_0:RX_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "ClockAligner_0:ALIGNMENT_RESET_N" "Core_PCS_0:WA_RSTn" "XCVR_IF_0:LANE0_PCS_ARST_N" "XCVR_IF_0:LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "Core_PCS_0:RESET_N" "WordAligner_0:reset_n" "resetn_align" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCK_ALIGNED" "ClockAligner_0:CLOCK_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_ARST_N" "ClockAligner_0:CTRL_RESET_N" "XCVR_IF_0:CTRL_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CTRL_CLK" "ClockAligner_0:CTRL_CLK" "XCVR_IF_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ClockAligner_0:ENABLE_ALIGNMENT" "ENABLE_ALIGNMENT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ClockAligner_0:PCS_ALIGNED" "Core_PCS_0:ALIGNED" "PCS_ALIGNED" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ClockAligner_0:RX_CLK" "Core_PCS_0:EPCS_RxCLK" "LANE0_RX_CLK_R" "WordAligner_0:clk" "XCVR_IF_0:LANE0_RX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ClockAligner_0:RX_VAL" "Core_PCS_0:EPCS_RxRSTn" "Core_PCS_0:EPCS_RxVAL" "LANE0_RX_VAL" "XCVR_IF_0:LANE0_RX_VAL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_READY" "LANE0_RX_READY" "XCVR_IF_0:LANE0_RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxERR" "EPCS_RxERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_RxIDLE" "XCVR_IF_0:LANE0_RX_IDLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_TxCLK" "LANE0_TX_CLK_R" "MUX_TX_0:TX_CLK" "ReplyPktDecoder_0:TX_CLK" "XCVR_IF_0:LANE0_TX_CLK_R" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSIM_EN" "MUX_TX_0:DTCSIM_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "XCVR_IF_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "XCVR_IF_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "XCVR_IF_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "XCVR_IF_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TX_CLK_STABLE" "XCVR_IF_0:LANE0_TX_CLK_STABLE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_TX_0:PRBS_EN" "PRBS_EN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_N" "XCVR_CLK_0:REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REF_CLK_PAD_P" "XCVR_CLK_0:REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ReplyPktDecoder_0:TX_RESETN" "TX_RESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WordAligner_0:word_aligned" "word_aligned" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_CLK_0:REF_CLK" "XCVR_IF_0:LANE0_CDR_REF_CLK_0" "XCVR_PLL_0:REF_CLK" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ALIGNMENT_LOSS_COUNTER" "ClockAligner_0:ALIGNMENT_LOSS_COUNTER" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"B_CERR" "Core_PCS_0:B_CERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CODE_ERR_N" "Core_PCS_0:CODE_ERR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ClockAligner_0:RX_DATA" "Core_PCS_0:EPCS_RxDATA" "XCVR_IF_0:LANE0_RX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:EPCS_TxDATA" "XCVR_IF_0:LANE0_TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:INVALID_K" "INVALID_K" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RD_ERR" "RD_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RX_DATA" "WordFlipper_0:data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:RX_K_CHAR" "WordFlipper_0:k_char_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:TX_DATA" "WordFlipper_1:data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Core_PCS_0:TX_K_CHAR" "WordFlipper_1:k_char_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCDATA_OUT" "ReplyPktDecoder_0:TX_DATA_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSIM_DATA" "MUX_TX_0:DTCSIM_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DTCSIM_KCHAR" "MUX_TX_0:DTCSIM_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_TX_0:FIBER_DATA" "ReplyPktDecoder_0:data_in" "TX_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_TX_0:FIBER_KCHAR" "ReplyPktDecoder_0:kchar_in" "TX_K_CHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_TX_0:PRBS_DATA" "PRBS_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_TX_0:PRBS_KCHAR" "PRBS_KCHAR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_TX_0:TX_DATA" "WordFlipper_1:data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MUX_TX_0:TX_KCHAR" "WordFlipper_1:k_char_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_DATA" "WordAligner_0:data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RX_K_CHAR" "WordAligner_0:k_char_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WordAligner_0:data_in" "WordFlipper_0:data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WordAligner_0:k_char_in" "WordFlipper_0:k_char_out" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"XCVR_IF_0:CLKS_FROM_TXPLL_0" "XCVR_PLL_0:CLKS_TO_XCVR" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign XCVR_Block
generate_component -component_name ${sd_name}
