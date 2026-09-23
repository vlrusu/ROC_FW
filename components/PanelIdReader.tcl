create_hdl_core -file {hdl/PanelIdReader.vhd} -module {PanelIdReader} -library {work} -package {}
hdl_core_add_bif -hdl_core_name {PanelIdReader} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {CPU_APB} -signal_map {\
"PADDR:S_PADDR" \
"PENABLE:S_PENABLE" \
"PWRITE:S_PWRITE" \
"PRDATA:S_PRDATA" \
"PWDATA:S_PWDATA" \
"PREADY:S_PREADY" \
"PSLVERR:S_PSLVERR" \
"PSELx:S_PSEL" }
hdl_core_add_bif -hdl_core_name {PanelIdReader} -bif_definition {APB:AMBA:AMBA2:master} -bif_name {SERVICE_APB} -signal_map {\
"PADDR:M_PADDR" \
"PENABLE:M_PENABLE" \
"PWRITE:M_PWRITE" \
"PRDATA:M_PRDATA" \
"PWDATA:M_PWDATA" \
"PREADY:M_PREADY" \
"PSLVERR:M_PSLVERR" \
"PSELx:M_PSEL" }
