# Exporting core Registers to TCL
# Exporting Create HDL core command for module Registers
create_hdl_core -file {hdl/Registers.vhd} -module {Registers} -library {work} -package {}
# Exporting BIF information of  HDL core command for module Registers
hdl_core_add_bif -hdl_core_name {Registers} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {BIF_1} -signal_map {\
"PADDR:PADDR" \
"PENABLE:PENABLE" \
"PWRITE:PWRITE" \
"PRDATA:PRDATA" \
"PWDATA:PWDATA" \
"PREADY:PREADY" \
"PSLVERR:PSLVERR" \
"PSELx:PSEL" }
