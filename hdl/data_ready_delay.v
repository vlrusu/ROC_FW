///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: data_ready_delay.v
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

module data_ready_delay#(
      //==============================
      // Top level block parameters
      //==============================
      parameter DELAY_CNT  = 4,                // number of delay cycles
      parameter GATE_WIDTH = 60                // gate length in delay cycles: 4 offset + 7*(no_packet*2) 
   ) (
      //===============
      // Input Ports
      //===============
      input clk,
      input sig_in,
      input rst_n,
      
      //===============
      // Output Ports
      //===============
      output reg sig_out
   );

   reg [7:0] cnt;
   // Synchronous logic, active low reset
   always @(posedge clk, negedge rst_n)
   begin
      if (rst_n == 1'b0)
      begin
         cnt     <= 8'b0;
         sig_out <= 0;
      end
      else
      begin
         if (sig_in == 1 || cnt > 0) cnt <= cnt + 1;
         if ( cnt > DELAY_CNT )
         begin
            sig_out <= 1;
            if ( cnt > GATE_WIDTH+DELAY_CNT )  cnt <= 8'b0;
         end
         if (cnt == 0) sig_out <= 0;
      end
   end
   
   

endmodule

