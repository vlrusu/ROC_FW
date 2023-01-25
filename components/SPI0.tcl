# Exporting Component Description of SPI0 to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component SPI0
create_and_configure_core -core_vlnv {Actel:DirectCore:CORESPI:5.2.104} -component_name {SPI0} -params {\
"APB_DWIDTH:32"  \
"CFG_CLK:7"  \
"CFG_FIFO_DEPTH:4"  \
"CFG_FRAME_SIZE:16"  \
"CFG_MODE:0"  \
"CFG_MOT_MODE:0"  \
"CFG_MOT_SSEL:false"  \
"CFG_NSC_OPERATION:0"  \
"CFG_TI_JMB_FRAMES:false"  \
"CFG_TI_NSC_CUSTOM:0"  \
"CFG_TI_NSC_FRC:false"   }
# Exporting Component Description of SPI0 to TCL done
