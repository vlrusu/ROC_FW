///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pulse_generator.v
// File history:
//      <1.0>: <12/2018>: MT   First version
//      <2.0>: <02/2021>: MT   Add time domain crossing capability
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
 input   clk_o, 
 input   resetn_i, 
 input   gate_i,	 
 output  pulse_up,
 output  pulse_dn 
);
   
// generate pulse on rising/falling edge using clk_o
reg	gate_latch, gate_reg, gate_sync;
always@(posedge clk_o)
begin
	gate_latch 	<= gate_i;
	gate_sync  	<=	gate_latch; // this is the first not-metastable register step 
	gate_reg  	<=	gate_sync; 
end

assign pulse_up = gate_sync && ~gate_reg;   
assign pulse_dn = ~gate_sync && gate_reg;

endmodule