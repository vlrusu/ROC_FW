# Exporting core Registers to TCL
# Exporting Create HDL core command for module Registers
create_hdl_core -file {hdl/DCSRegisters.vhd} -module {DCSRegisters} -library {work} -package {}
# Exporting BIF information of  HDL core command for module Registers
hdl_core_add_bif -hdl_core_name {DCSRegisters} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {BIF_1} -signal_map {\
"PADDR:PADDR" \
"PENABLE:PENABLE" \
"PWRITE:PWRITE" \
"PRDATA:PRDATA" \
"PWDATA:PWDATA" \
"PREADY:PREADY" \
"PSLVERR:PSLVERR" \
"PSELx:PSEL" }
