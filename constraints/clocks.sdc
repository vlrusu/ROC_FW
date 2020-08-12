#JTAG_tck_constraints
create_clock -name {SWCLKTCK} -period 33.33 -waveform {0 16.665 } [ get_ports { SWCLKTCK } ]
#set_clock_groups -name {jtagclk} -asynchronous -group [ get_clocks {SWCLKTCK} ]

set_clock_groups -name {slowclk} -asynchronous -group [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT0 } ] 
#set_clock_groups -name {fastreadclk} -asynchronous -group [ get_clocks { CCC_0/ROC_CCC_0/pll_inst_0/OUT3 } ]  
set_clock_groups -name {serdes0_0} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE0/RX_CLK_R   DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_groups -name {serdes1_0} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE0/RX_CLK_R   DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE0/TX_CLK_R } ]
set_clock_groups -name {serdes0_1} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE1/RX_CLK_R   DIGIINTERFACE_0/serdes_0/TransceiverIF_0/I_XCVR/LANE1/TX_CLK_R } ]
set_clock_groups -name {serdes1_1} -asynchronous -group [ get_clocks { DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE1/RX_CLK_R   DIGIINTERFACE_0/serdes_1/TransceiverIF_0/I_XCVR/LANE1/TX_CLK_R } ]
