# Exporting core Ctrl_clk to TCL
# Exporting Create design command for core Ctrl_clk
create_and_configure_core -core_vlnv {Actel:SgCore:PF_CLK_DIV:1.0.103} -component_name {Ctrl_clk} -params {\
"DIVIDER:4"  \
"ENABLE_BIT_SLIP:false"  \
"ENABLE_SRESET:false"   }
# Exporting core Ctrl_clk to TCL done
