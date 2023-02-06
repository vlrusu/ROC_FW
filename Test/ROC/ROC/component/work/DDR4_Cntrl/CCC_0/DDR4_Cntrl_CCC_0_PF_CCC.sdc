set_component DDR4_Cntrl_CCC_0_PF_CCC
# Microsemi Corp.
# Date: 2023-Feb-06 12:20:30
#

# Base clock for PLL #0
create_clock -period 9.00001 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -multiply_by 6 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]
create_generated_clock -multiply_by 3 -divide_by 2 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT1 } ]
create_generated_clock -multiply_by 6 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT2 } ]
create_generated_clock -multiply_by 6 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT3 } ]
