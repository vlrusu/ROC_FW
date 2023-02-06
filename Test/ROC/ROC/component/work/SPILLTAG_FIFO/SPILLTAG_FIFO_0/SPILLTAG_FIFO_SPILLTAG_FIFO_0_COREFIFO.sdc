set_component SPILLTAG_FIFO_SPILLTAG_FIFO_0_COREFIFO
set_false_path  -to [ get_cells { genblk*.U_corefifo_async/*/shift_reg* } ]