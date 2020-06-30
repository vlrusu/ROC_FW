# Exporting core TEMPFIFO to TCL
# Exporting Create design command for core TEMPFIFO
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:2.7.105} -component_name {TEMPFIFO} -params {\
"AE_STATIC_EN:false"  \
"AEVAL:4"  \
"AF_STATIC_EN:true"  \
"AFVAL:127"  \
"CTRL_TYPE:2"  \
"ECC:0"  \
"ESTOP:true"  \
"FSTOP:true"  \
"FWFT:true"  \
"NUM_STAGES:2"  \
"OVERFLOW_EN:false"  \
"PIPE:1"  \
"PREFETCH:false"  \
"RCLK_EDGE:1"  \
"RDCNT_EN:true"  \
"RDEPTH:128"  \
"RE_POLARITY:0"  \
"READ_DVALID:false"  \
"RESET_POLARITY:0"  \
"RWIDTH:64"  \
"SYNC:0"  \
"UNDERFLOW_EN:false"  \
"WCLK_EDGE:1"  \
"WDEPTH:128"  \
"WE_POLARITY:0"  \
"WRCNT_EN:true"  \
"WRITE_ACK:false"  \
"WWIDTH:64"   }
# Exporting core TEMPFIFO to TCL done
