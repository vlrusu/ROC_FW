# Exporting core RxFIFO to TCL
# Exporting Create design command for core RxFIFO
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:2.7.105} -component_name {RxFIFO} -params {\
"AE_STATIC_EN:false"  \
"AEVAL:4"  \
"AF_STATIC_EN:false"  \
"AFVAL:1020"  \
"CTRL_TYPE:2"  \
"ECC:0"  \
"ESTOP:true"  \
"FSTOP:true"  \
"FWFT:false"  \
"NUM_STAGES:2"  \
"OVERFLOW_EN:false"  \
"PIPE:1"  \
"PREFETCH:false"  \
"RCLK_EDGE:1"  \
"RDCNT_EN:true"  \
"RDEPTH:4096"  \
"RE_POLARITY:0"  \
"READ_DVALID:false"  \
"RESET_POLARITY:0"  \
"RWIDTH:32"  \
"SYNC:0"  \
"UNDERFLOW_EN:false"  \
"WCLK_EDGE:1"  \
"WDEPTH:4096"  \
"WE_POLARITY:0"  \
"WRCNT_EN:false"  \
"WRITE_ACK:false"  \
"WWIDTH:32"   }
# Exporting core RxFIFO to TCL done
