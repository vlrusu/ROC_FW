# Exporting Component Description of PREAMPSPI to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component PREAMPSPI
create_and_configure_core -core_vlnv {Actel:DirectCore:CORESPI:5.2.104} -component_name {PREAMPSPI} -params {\
"APB_DWIDTH:32"  \
"CFG_CLK:2"  \
"CFG_FIFO_DEPTH:4"  \
"CFG_FRAME_SIZE:8"  \
"CFG_MODE:0"  \
"CFG_MOT_MODE:0"  \
"CFG_MOT_SSEL:true"  \
"CFG_NSC_OPERATION:0"  \
"CFG_TI_JMB_FRAMES:false"  \
"CFG_TI_NSC_CUSTOM:0"  \
"CFG_TI_NSC_FRC:false"   }
# Exporting Component Description of PREAMPSPI to TCL done
