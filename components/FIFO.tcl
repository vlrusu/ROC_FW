# Exporting core FIFO to TCL
# Exporting Create design command for core FIFO
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:2.7.105} -component_name {FIFO} -params {\
"AE_STATIC_EN:false"  \
"AEVAL:4"  \
"AF_STATIC_EN:false"  \
"AFVAL:60"  \
"CTRL_TYPE:3"  \
"ECC:0"  \
"ESTOP:true"  \
"FSTOP:true"  \
"FWFT:false"  \
"NUM_STAGES:2"  \
"OVERFLOW_EN:false"  \
"PIPE:0"  \
"PREFETCH:false"  \
"RCLK_EDGE:1"  \
"RDCNT_EN:false"  \
"RDEPTH:48"  \
"RE_POLARITY:0"  \
"READ_DVALID:false"  \
"RESET_POLARITY:1"  \
"RWIDTH:16"  \
"SYNC:0"  \
"UNDERFLOW_EN:false"  \
"WCLK_EDGE:1"  \
"WDEPTH:48"  \
"WE_POLARITY:0"  \
"WRCNT_EN:false"  \
"WRITE_ACK:false"  \
"WWIDTH:16"   }
# Exporting core FIFO to TCL done
