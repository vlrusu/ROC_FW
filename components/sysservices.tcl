# Exporting core sysservices to TCL
# Exporting Create design command for core sysservices
create_and_configure_core -core_vlnv {Actel:SgCore:PF_SYSTEM_SERVICES:3.0.100} -component_name {sysservices} -params {\
"AUTHBITSTREAM:false"  \
"AUTHIAPIMG:false"  \
"DCSERVICE:false"  \
"DIGESTCHECK:false"  \
"DIGSIGSERVICE:false"  \
"DVSERVICE:true"  \
"FF_MAILBOX_ADDR:0x100"  \
"FF_MAILBOX_ADDR_HEX_RANGE:32"  \
"FF_TIMEOUT_VAL:0x20000000"  \
"FF_TIMEOUT_VAL_HEX_RANGE:32"  \
"FFSERVICE:false"  \
"IAPAUTOUPD:false"  \
"IAPSERVICE:false"  \
"NONCESERVICE:false"  \
"OSC_2MHZ_ON:false"  \
"PUFEMSERVICE:false"  \
"QUERYSECSERVICE:false"  \
"RDDEBUGINFO:false"  \
"RDDIGEST:false"  \
"SECNVMRD:false"  \
"SECNVMWR:false"  \
"SNSERVICE:true"  \
"UCSERVICE:true"   }
# Exporting core sysservices to TCL done
