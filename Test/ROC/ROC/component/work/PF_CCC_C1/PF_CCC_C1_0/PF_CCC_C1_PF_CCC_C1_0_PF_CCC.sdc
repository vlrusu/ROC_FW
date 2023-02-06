set_component PF_CCC_C1_PF_CCC_C1_0_PF_CCC
# Microsemi Corp.
# Date: 2023-Feb-06 12:21:34
#

# Base clock for PLL #0
create_clock -period 5 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -divide_by 1 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]
create_generated_clock -divide_by 5 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT1 } ]
