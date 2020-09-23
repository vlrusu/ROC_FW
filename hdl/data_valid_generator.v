///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: data_valid_generator.v
// File history:
//      <1.0>: <05/2019>: MT   First version
//      <Revision number>: <Date>: <Comments>
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
 input   clk_i, 
 input   resetn_i, 
 input   start_i,	 
 input   end_i,
 output  reg data_valid 
);


always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        data_valid 	<= 1'b0;
    end
    else
    begin
		if(start_i) 	data_valid 	<= 1'b1;
		else if (end_i) data_valid 	<= 1'b0;
    end
end

endmodule
