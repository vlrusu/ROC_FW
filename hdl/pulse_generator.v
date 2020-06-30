///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pulse_stretcher.v
// File history:
//      <1.0>: <12/2018>: MT   First version
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//    Generate 1 clock long pulse on GATE_I rising or falling edge
// 
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: M. Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pulse_generator(
 input   clk_i, 
 input   resetn_i, 
 input   gate_i,	 
 output  pulse_up,
 output  pulse_dn 
);

assign pulse_up = gate_seen && ~gate_reg;   
assign pulse_dn = ~gate_seen && gate_reg;
   
///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
reg         gate_seen, gate_reg;

always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        gate_seen 	<= 1'b0;
        gate_reg 	<= 1'b0;
    end
    else
    begin
		gate_seen 	<= 	gate_i;
		gate_reg  	<=	gate_seen; 
    end
end

endmodule
