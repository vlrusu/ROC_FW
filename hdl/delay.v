///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: delay.v
// File history:
//      v1.0: 12/19/2020:  Delay copy of input by DELAY_CLK
//      v2.0: 02/09/2021:  Must delay DDR3_FULL longer to keep DATA_PKTS = 0x40 until Data Header is made inside CommandHandler
//
// Description: 
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: MT
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module delay(
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
   reg [15:0] tmp;
   always @(posedge clk, negedge rst_n)
   begin
		if (rst_n == 1'b0)	tmp	<= 16'b0;
		else		
		begin
			tmp 	<= tmp << 1;
			tmp[0]<= sig_in;
		end
   end
   
   assign sig_out = tmp[8];

endmodule