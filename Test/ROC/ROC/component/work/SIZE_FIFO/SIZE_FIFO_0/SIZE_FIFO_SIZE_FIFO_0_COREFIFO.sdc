set_component SIZE_FIFO_SIZE_FIFO_0_COREFIFO
set_false_path  -to [ get_cells { genblk*.U_corefifo_async/*/shift_reg* } ]