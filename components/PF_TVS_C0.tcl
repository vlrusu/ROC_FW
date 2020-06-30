# Exporting core PF_TVS_C0 to TCL
# Exporting Create design command for core PF_TVS_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_TVS:1.0.110} -component_name {PF_TVS_C0} -params {\
"TVS_CONTROL_ENABLE_1P8V_CHANNEL:true"  \
"TVS_CONTROL_ENABLE_1V_CHANNEL:true"  \
"TVS_CONTROL_ENABLE_2P5V_CHANNEL:true"  \
"TVS_CONTROL_ENABLE_TEMP_CHANNEL:true"  \
"TVS_CONTROL_RATE:60"  \
"TVS_CONTROL_RATE_IN_US:1920"  \
"TVS_TRIGGER_HIGH:0"  \
"TVS_TRIGGER_LOW:0"   }
# Exporting core PF_TVS_C0 to TCL done
