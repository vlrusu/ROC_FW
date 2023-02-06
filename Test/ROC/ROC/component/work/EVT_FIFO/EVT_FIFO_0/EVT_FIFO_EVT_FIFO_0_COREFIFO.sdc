set_component EVT_FIFO_EVT_FIFO_0_COREFIFO
set_false_path  -to [ get_cells { genblk*.U_corefifo_async/*/shift_reg* } ]