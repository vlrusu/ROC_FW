///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: delay.v
// File history:
//      v1.0: 12/19/2020:  Delay copy of input by DELAY_CLK
//
// Description: 
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module delay#(
      //==============================
      // Top level block parameters
      //==============================
      parameter DELAY_CLK  = 5              // number of delay cycles + 1
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
      output sig_out
   );

	
   // Synchronous logic, active low reset
   reg [7:0] tmp;
   always @(posedge clk, negedge rst_n)
   begin
		if (rst_n == 1'b0)	tmp	<= 8'b0;
		else		
		begin
			tmp 	<= tmp << 1;
			tmp[0]<= sig_in;
		end
   end
   
   assign sig_out = tmp[DELAY_CLK];

endmodule