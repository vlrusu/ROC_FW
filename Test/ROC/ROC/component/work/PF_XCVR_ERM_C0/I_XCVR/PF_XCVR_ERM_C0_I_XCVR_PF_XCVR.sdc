set_component PF_XCVR_ERM_C0_I_XCVR_PF_XCVR
# Microsemi Corp.
# Date: 2023-Feb-06 12:23:59
#

create_clock -period 10 [ get_pins { LANE0/REF_CLK_P } ]
create_clock -period 5 [ get_pins { LANE0/TX_CLK_R } ]
create_clock -period 5 [ get_pins { LANE0/RX_CLK_R } ]
