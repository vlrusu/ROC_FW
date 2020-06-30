# Exporting core axi4dma_init to TCL
# Exporting Create HDL core command for module axi4dma_init
create_hdl_core -file {hdl/AXI4DMA_INIT.v} -module {axi4dma_init} -library {work} -package {}
# Exporting BIF information of  HDL core command for module axi4dma_init
hdl_core_add_bif -hdl_core_name {axi4dma_init} -bif_definition {AXI4:AMBA:AMBA4:master} -bif_name {AXIDMA_4} -signal_map {\
"AWADDR:AWADDR_O" \
"AWVALID:AWVALID_O" \
"AWREADY:AWREADY_I" \
"WDATA:WDATA_O" \
"WSTRB:WSTRB_O" \
"WVALID:WVALID_O" \
"WREADY:WREADY_I" \
"BVALID:BVALID_I" \
"BREADY:BREADY_O" \
"ARADDR:ARADDR_O" \
"ARVALID:ARVALID_O" \
"ARREADY:ARREADY_I" \
"RDATA:RDATA_I" \
"RVALID:RVALID_I" \
"RREADY:RREADY_O" }
