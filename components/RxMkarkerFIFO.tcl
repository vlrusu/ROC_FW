# Exporting Component Description of RxMkarkerFIFO to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component RxMkarkerFIFO
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:3.0.101} -component_name {RxMkarkerFIFO} -params {\
"AE_STATIC_EN:false"  \
"AEVAL:4"  \
"AF_STATIC_EN:false"  \
"AFVAL:1020"  \
"CTRL_TYPE:2"  \
"DIE_SIZE:15"  \
"ECC:0"  \
"ESTOP:true"  \
"FSTOP:true"  \
"FWFT:false"  \
"NUM_STAGES:2"  \
"OVERFLOW_EN:false"  \
"PIPE:1"  \
"PREFETCH:false"  \
"RAM_OPT:0"  \
"RDCNT_EN:true"  \
"RDEPTH:1024"  \
"RE_POLARITY:0"  \
"READ_DVALID:false"  \
"RWIDTH:18"  \
"SYNC:0"  \
"SYNC_RESET:0"  \
"UNDERFLOW_EN:false"  \
"WDEPTH:1024"  \
"WE_POLARITY:0"  \
"WRCNT_EN:false"  \
"WRITE_ACK:false"  \
"WWIDTH:18"   }
# Exporting Component Description of RxMkarkerFIFO to TCL done
