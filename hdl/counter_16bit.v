///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: counter_16bit.v
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

module counter_16bit (
      //===============
      // Input Ports
      //===============
      input clk,
      input en,
      input rst_n,
      
      //===============
      // Output Ports
      //===============
      output reg [15:0] cnt
);

   // Synchronous logic, active low reset
   always @(posedge clk, negedge rst_n)
   begin
      if (rst_n == 1'b0)
         cnt <= 16'b0;
      else
      begin
         if (en == 1)
         begin
            cnt <= cnt + 1'b1;
         end
      end
   end

endmodule

