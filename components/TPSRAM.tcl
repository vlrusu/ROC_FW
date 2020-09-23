# Exporting core TPSRAM to TCL
# Exporting Create design command for core TPSRAM
create_and_configure_core -core_vlnv {Actel:SgCore:PF_TPSRAM:1.1.108} -component_name {TPSRAM} -params {\
"A_DOUT_EN_PN:R_DATA_EN"  \
"A_DOUT_EN_POLARITY:2"  \
"A_DOUT_SRST_PN:R_DATA_SRST_N"  \
"A_DOUT_SRST_POLARITY:2"  \
"A_WBYTE_EN_PN:WBYTE_EN"  \
"BUSY_FLAG:0"  \
"BYTE_ENABLE_WIDTH:0"  \
"BYTEENABLES:0"  \
"CASCADE:0"  \
"CLK_EDGE:RISE"  \
"CLKS:2"  \
"CLOCK_PN:CLK"  \
"DATA_IN_PN:W_DATA"  \
"DATA_OUT_PN:R_DATA"  \
"ECC:0"  \
"IMPORT_FILE:"  \
"INIT_RAM:F"  \
"LPM_HINT:0"  \
"LPMTYPE:LPM_RAM"  \
"PMODE2:0"  \
"PTYPE:1"  \
"RADDRESS_PN:R_ADDR"  \
"RCLK_EDGE:RISE"  \
"RCLOCK_PN:R_CLK"  \
"RDEPTH:512"  \
"RE_PN:R_EN"  \
"RE_POLARITY:1"  \
"RESET_PN:R_DATA_ARST_N"  \
"RESET_POLARITY:2"  \
"RWIDTH:32"  \
"SII_LOCK:0"  \
"WADDRESS_PN:W_ADDR"  \
"WCLK_EDGE:RISE"  \
"WCLOCK_PN:W_CLK"  \
"WDEPTH:256"  \
"WE_PN:W_EN"  \
"WE_POLARITY:1"  \
"WWIDTH:64"   }
# Exporting core TPSRAM to TCL done
