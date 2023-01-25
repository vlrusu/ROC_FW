///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: edge_generator.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module edge_generator( 
   input clk,
   input resetn,
   input gate,
   output reg  risingEdge,
   output reg  fallingEdge
);
//<statements>

reg   gate_reg, gate_latch, gate_sync;
always@(posedge clk, negedge resetn)
begin
   if(resetn == 1'b0)
   begin
      risingEdge <= 1'b0;
      fallingEdge <= 1'b0;
   end
   else
   begin
      gate_reg    <= gate;
      gate_latch  <= gate_reg;
      gate_sync   <= gate_latch;
      
      risingEdge  <= gate_latch && ~gate_sync;
      fallingEdge <= ~gate_latch && gate_sync;
   end
end

endmodule

