# Exporting core FIFO_Response to TCL
# Exporting Create design command for core FIFO_Response
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:2.7.105} -component_name {FIFO_Response} -params {\
"AE_STATIC_EN:false"  \
"AEVAL:4"  \
"AF_STATIC_EN:false"  \
"AFVAL:60"  \
"CTRL_TYPE:3"  \
"ECC:0"  \
"ESTOP:true"  \
"FSTOP:true"  \
"FWFT:false"  \
"NUM_STAGES:4"  \
"OVERFLOW_EN:false"  \
"PIPE:0"  \
"PREFETCH:false"  \
"RCLK_EDGE:1"  \
"RDCNT_EN:true"  \
"RDEPTH:512"  \
"RE_POLARITY:0"  \
"READ_DVALID:false"  \
"RESET_POLARITY:1"  \
"RWIDTH:16"  \
"SYNC:0"  \
"UNDERFLOW_EN:false"  \
"WCLK_EDGE:1"  \
"WDEPTH:512"  \
"WE_POLARITY:0"  \
"WRCNT_EN:false"  \
"WRITE_ACK:false"  \
"WWIDTH:16"   }
# Exporting core FIFO_Response to TCL done
