set_component XCVR_PLL_0_XCVR_PLL_0_0_PF_TX_PLL
# Microsemi Corp.
# Date: 2023-Feb-06 12:24:03
#

create_clock -period 10 [ get_pins { txpll_isnt_0/REF_CLK_P } ]
create_clock -period 8 [ get_pins { txpll_isnt_0/DIV_CLK } ]
