# Exporting core PF_CLK_DIV_C0 to TCL
# Exporting Create design command for core PF_CLK_DIV_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_CLK_DIV:1.0.103} -component_name {PF_CLK_DIV_C0} -params {\
"DIVIDER:4"  \
"ENABLE_BIT_SLIP:false"  \
"ENABLE_SRESET:false"   }
# Exporting core PF_CLK_DIV_C0 to TCL done
