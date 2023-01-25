# Exporting Component Description of PACKET_FIFO to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component PACKET_FIFO
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:3.0.101} -component_name {PACKET_FIFO} -params {\
"AE_STATIC_EN:true"  \
"AEVAL:11"  \
"AF_STATIC_EN:false"  \
"AFVAL:60"  \
"CTRL_TYPE:3"  \
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
"RDEPTH:128"  \
"RE_POLARITY:0"  \
"READ_DVALID:false"  \
"RWIDTH:24"  \
"SYNC:0"  \
"SYNC_RESET:0"  \
"UNDERFLOW_EN:false"  \
"WDEPTH:128"  \
"WE_POLARITY:0"  \
"WRCNT_EN:true"  \
"WRITE_ACK:false"  \
"WWIDTH:24"   }
# Exporting Component Description of PACKET_FIFO to TCL done
