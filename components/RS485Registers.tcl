# Exporting core RS485Registers to TCL
# Exporting Create HDL core command for module RS485Registers
create_hdl_core -file {hdl/RS485Registers.vhd} -module {RS485Registers} -library {work} -package {}
# Exporting BIF information of  HDL core command for module RS485Registers
hdl_core_add_bif -hdl_core_name {RS485Registers} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {BIF_1} -signal_map {\
"PADDR:PADDR" \
"PENABLE:PENABLE" \
"PWRITE:PWRITE" \
"PRDATA:PRDATA" \
"PWDATA:PWDATA" \
"PREADY:PREADY" \
"PSLVERR:PSLVERR" \
"PSELx:PSEL" }
