///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: data_valid_generator.v
// File history:
//      <1.0>: <05/2019>: MT   First version
//      <2.0>: <12/2020>: MT   make sure START_I crosses time domain 
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//    Generate gate from MEM_FIFO_FULL (start_i), validated by DDR3_FULL, to MEM_FIFO_EMPTY (end_i)
// 
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: M. Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module dvl_generator(
 input   clk_start, 
 input   clk_stop, 
 input   resetn_i, 
 input   start_i,	 
 input   end_i,
 output  reg data_valid 
);

reg 	start_latch1, start_latch2, start_latch3;
wire 	start_seen;
assign start_seen = start_i || start_latch1 || start_latch2 || start_latch3;
always@(posedge clk_start)
begin
	start_latch1 <= start_i;
	start_latch2 <= start_latch1;
	start_latch3 <= start_latch2;
end


always@(posedge clk_stop, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        data_valid 	<= 1'b0;
    end
    else
    begin
		if(start_seen) 	data_valid 	<= 1'b1;
		else if (end_i) 	data_valid 	<= 1'b0;
    end
end

endmodule
