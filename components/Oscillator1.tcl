# Exporting core Oscillator1 to TCL
# Exporting Create design command for core Oscillator1
create_and_configure_core -core_vlnv {Actel:SgCore:PF_OSC:1.0.102} -component_name {Oscillator1} -params {\
"RCOSC_2MHZ_CLK_DIV_EN:false"  \
"RCOSC_2MHZ_GL_EN:false"  \
"RCOSC_2MHZ_NGMUX_EN:false"  \
"RCOSC_160MHZ_CLK_DIV_EN:true"  \
"RCOSC_160MHZ_GL_EN:true"  \
"RCOSC_160MHZ_NGMUX_EN:false"   }
# Exporting core Oscillator1 to TCL done
