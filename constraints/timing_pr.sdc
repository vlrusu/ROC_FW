
set_false_path -from [ get_pins { SLOWCONTROLS_0/Registers_0/enable_fiber_clock/CLK SLOWCONTROLS_0/Registers_0/enable_fiber_marker/CLK } ]
#set_false_path -from [ get_pins { TOP_SERDES_0/ForwardDetector_0/fifo_rst/CLK } ]

create_generated_clock -name {hv_clk_out2} -divide_by 1 -source [ get_pins { PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ] [ get_ports { HV_CLK_OUT2_P } ]
set_output_delay -0.1 -min  -clock { hv_clk_out2 } [ get_ports { ewm_hv } ]
set_output_delay 2.6 -max  -clock { hv_clk_out2 } [ get_ports { ewm_hv } ]
create_generated_clock -name {cal_clk_out2} -divide_by 1 -source [ get_pins { PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ] [ get_ports { CAL_CLK_OUT2_P } ]
set_output_delay -0.1 -min  -clock { cal_clk_out2 } [ get_ports { ewm_cal } ]
set_output_delay 2.6 -max  -clock { cal_clk_out2 } [ get_ports { ewm_cal } ]