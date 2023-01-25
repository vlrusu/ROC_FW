///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pattern_err_switch.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pattern_err_switch( 
   input [1:0] err_en,
   input [63:0] evt_expc,
   input [63:0] evt_seen,
   input [63:0] hdr1_expc,
   input [63:0] hdr1_seen,
   input [63:0] hdr2_expc,
   input [63:0] hdr2_seen,
   input [63:0] data_expc,
   input [63:0] data_seen,
   
   output reg [63:0] err_expc,
   output reg [63:0] err_seen
   );

//<statements>
   always @(err_en) begin
   
      case(err_en)
   
      2'b00:
         begin
            err_expc = evt_seen;
            err_seen = evt_expc;
         end
         
      2'b01:
         begin
            err_expc = hdr1_seen;
            err_seen = hdr1_expc;
         end
         
      2'b10:
         begin
            err_expc = hdr2_seen;
            err_seen = hdr2_expc;
         end
         
      2'b11:
         begin
            err_expc = data_seen;
            err_seen = data_expc;
         end
         
      default:
         begin
            err_expc = 64'b0;
            err_seen = 64'b0;
         end
         
      endcase
   end
   
endmodule

