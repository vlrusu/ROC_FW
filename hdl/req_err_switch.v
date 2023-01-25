///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: req_err_switch.v
// File history:
//      v1.0: <Mar. 2022> : first version
//
// Description: 
//
// Enable one of four expected or observed 64-bit inputs as set by ERR_EN[1:0]
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module req_err_switch(
   input [1:0] err_en,
   input [63:0] evt_expc,
   input [63:0] evt_seen,
   input [63:0] hdr1_expc,
   input [63:0] hdr1_seen,
   input [63:0] hdr2_expc,
   input [63:0] hdr2_seen,
   input [63:0] data_expc,
   input [63:0] data_seen,
   
   output reg [63:0] expc_err,
   output reg [63:0] seen_err
);

//<statements>
   always @(err_en) begin
   
      case(err_en)
   
      3'b00:
         begin
            expc_err = evt_expc;
            seen_err = evt_seen;
         end
         
      3'b01:
         begin
            expc_err = hdr1_expc;
            seen_err = hdr1_seen;
         end
         
      3'b10:
         begin
            expc_err = hdr2_expc;
            seen_err = hdr2_seen;
         end
         
      3'b11:
         begin
            expc_err = data_expc;
            seen_err = data_seen;
         end
         
      default:
         begin
            expc_err = 64'b0;
            seen_err = 64'b0;
         end
         
      endcase
   end

endmodule

