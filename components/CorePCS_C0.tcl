# Exporting core CorePCS_C0 to TCL
# Exporting Create design command for core CorePCS_C0
create_and_configure_core -core_vlnv {Actel:DirectCore:CorePCS:3.5.106} -component_name {CorePCS_C0} -params {\
"COMMA_DETECT_SEL:0"  \
"EPCS_DWIDTH:20"  \
"LANE_MODE:2"  \
"NO_OF_COMMAS:1"  \
"PROG_COMMA_EN:1"  \
"SHIFT_EN:false"   }
# Exporting core CorePCS_C0 to TCL done
