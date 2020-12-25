///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pulse_stretcher.v
// File history:
//      <1.0>: <12/2018>: MT   First version
//      <2.0>: <12/2020>: MT   Add time domain crossing capability, assuming clk_i is faster than clk_o
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//    Generate 1-clk_o long pulse on "gate_i" rising or falling edge.
// 
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: M. Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pulse_generator(
 input   clk_i, 
 input   clk_o, 
 input   resetn_i, 
 input   gate_i,	 
 output  pulse_up,
 output  pulse_dn 
);
   
// stretch "gae_i" to make sure it is seen by clk_o
reg gate_latch1, gate_latch2, gate_latch3;
always@(posedge clk_i)
begin
	gate_latch1	<= gate_i;
	gate_latch2	<= gate_latch1;
	gate_latch3	<= gate_latch2;
end

wire		gate;
assign 	gate = gate_i || gate_latch1 || gate_latch2 || gate_latch3;

// generate pulse on rising/falling edge using clk_o
reg	gate_seen, gate_reg;
always@(posedge clk_o, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        gate_seen 	<= 1'b0;
        gate_reg 	<= 1'b0;
    end
    else
    begin
		gate_seen 	<= gate;
		gate_reg  	<=	gate_seen; 
    end
end

assign pulse_up = gate_seen && ~gate_reg;   
assign pulse_dn = ~gate_seen && gate_reg;

endmodule