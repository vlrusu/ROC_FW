///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: counter32.v
//
// Description: 
//      32-bit count up counter
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>
module counter32 (
      //===============
      // Input Ports
      //===============
      input clk,
      input en,
      input rst_n,
      
      //===============
      // Output Ports
      //===============
      output reg [31:0] cnt
);

   // Synchronous logic, active low reset
   always @(posedge clk, negedge rst_n)
   begin
      if (rst_n == 1'b0)
         cnt <= 32'b0;
      else
      begin
         if (en == 1)
         begin
            cnt <= cnt + 1'b1;
         end
      end
   end

endmodule

