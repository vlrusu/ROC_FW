# Exporting core fifo_mem_cntrl to TCL
# Exporting Create HDL core command for module fifo_mem_cntrl
create_hdl_core -file {hdl/FIFO_MEM_CNTRL.v} -module {fifo_mem_cntrl} -library {work} -package {}
# Exporting BIF information of  HDL core command for module fifo_mem_cntrl
hdl_core_add_bif -hdl_core_name {fifo_mem_cntrl} -bif_definition {AXI4:AMBA:AMBA4:master} -bif_name {AXI4_M} -signal_map {\
"AWID:awid_o" \
"AWADDR:awaddr_o" \
"AWLEN:awlen_o" \
"AWSIZE:awsize_o" \
"AWBURST:awburst_o" \
"AWVALID:awvalid_o" \
"AWREADY:awready_i" \
"WDATA:wdata_o" \
"WSTRB:wstrb_o" \
"WLAST:wlast_o" \
"WVALID:wvalid_o" \
"WREADY:wready_i" \
"BID:bid_i" \
"BRESP:bresp_i" \
"BVALID:bvalid_i" \
"BREADY:bready_o" \
"ARID:arid_o" \
"ARADDR:araddr_o" \
"ARLEN:arlen_o" \
"ARSIZE:arsize_o" \
"ARBURST:arburst_o" \
"ARVALID:arvalid_o" \
"ARREADY:arready_i" \
"RID:rid_i" \
"RDATA:rdata_i" \
"RRESP:rresp_i" \
"RLAST:rlast_i" \
"RVALID:rvalid_i" \
"RREADY:rready_o" }
