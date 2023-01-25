#MT changed during 1152 to 484 FPGA translation
create_generated_clock -name {hv_clk_out} -divide_by 1 -source [ get_pins { PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ] [ get_ports { ROCtoHV_CLK0_P } ]
set_output_delay -0.1 -min  -clock { hv_clk_out } [ get_ports { ROC_HV_LVDS0_P } ]
set_output_delay 2.6 -max  -clock { hv_clk_out } [ get_ports { ROC_HV_LVDS0_P } ]
create_generated_clock -name {cal_clk_out} -divide_by 1 -source [ get_pins { PF_CCC_C1_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ] [ get_ports { ROCtoCAL_CLK0_P } ]
set_output_delay -0.1 -min  -clock { cal_clk_out } [ get_ports { ROC_CAL_LVDS0_P } ]
set_output_delay 2.6 -max  -clock { cal_clk_out } [ get_ports { ROC_CAL_LVDS0_P } ]

set_false_path -from [ get_pins { SLOWCONTROLS_0/Registers_0/enable_fiber_clock/CLK SLOWCONTROLS_0/Registers_0/enable_fiber_marker/CLK } ]
#set_false_path -from [ get_pins { DTCInterface_0/ForwardDetector_0/fifo_rst/CLK } ]