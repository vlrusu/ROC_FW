# Exporting Component Description of EVM_DELAY_FIFO to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component EVM_DELAY_FIFO
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:3.0.101} -component_name {EVM_DELAY_FIFO} -params {\
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
"RDCNT_EN:false"  \
"RDEPTH:2048"  \
"RE_POLARITY:0"  \
"READ_DVALID:false"  \
"RWIDTH:1"  \
"SYNC:1"  \
"SYNC_RESET:0"  \
"UNDERFLOW_EN:false"  \
"WDEPTH:2048"  \
"WE_POLARITY:0"  \
"WRCNT_EN:false"  \
"WRITE_ACK:false"  \
"WWIDTH:1"   }
# Exporting Component Description of EVM_DELAY_FIFO to TCL done
