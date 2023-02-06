set_component PF_CCC_111_PF_CCC_111_0_PF_CCC
# Microsemi Corp.
# Date: 2023-Feb-06 12:21:29
#

# Base clock for PLL #0
create_clock -period 20 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -multiply_by 4 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]
create_generated_clock -multiply_by 20 -divide_by 9 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT1 } ]
