///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: MEMFIFO_RE_generator.v
// File history:
//      v1.0: 12/05/2020: First version
//      v2.0: 12/22/2020: 	Lengthen start_latch to make sure it is captured on 40 MHz CLK.
//									Register PACKET_NO on enable to avoid losing last packet.
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
//   Generate PACKET_NO "memfifo_re" outputs to simulate TOP_SERDES logic after a Data_Request.
//   Start on "enable", connected to MEMFIFO_DATA_READY.
//   Each "memfifo_re" lasts one clock and it is separated CNT[DELAY_BIT] clocks from previous.
//   The first "memfifo_re" has an extra delay from EN of EXTRA_DELAY clocks.
// 
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module MEMFIFO_RE_generator#(
      //==============================
      // Top level block parameters
      //==============================
		parameter EXTRA_DELAY = 11,      // extra delay before first "memfifo_re" in units of clock ticks
      parameter DELAY_BIT  = 3         // number of delay cycles between "memfifo_re" in units of 2**DELAY_BIT cloco ticks
   ) (
      //===============
      // Input Ports
      //===============
      input clk,
		input start,
      input enable,
      input rst_n,
      input [15:0] packet_no,
      //===============
      // Output Ports
      //===============
      output memfifo_re
   );
	
	//wire [15:0] packet_to_do;	
	//assign packet_to_do = (packet_no << 1); 
	
	reg 	start_latch, start_latch1, start_latch2;
	reg	start_seen;
	reg	enable_latch;
	reg [3:0] cnt;
	reg [3:0] delay_cnt;
   reg [15:0] 	packet_cnt;
	reg [15:0] 	packet_to_do;	

   // Synchronous logic, active low reset
	always @(posedge clk, negedge rst_n)
   begin 
      if (rst_n == 1'b0)
      begin
         //start_latch <= 1'b0;
			start_seen  <= 1'b0;
			packet_to_do	<= 16'b0;
		end
		else
		//begin
			//start_latch <= start;
			//if (enable)
			//begin
				//if (start_latch) start_seen 		<= 1'b1;
				//begin
					//start_seen 		<= 1'b1;
					//packet_to_do	<= (packet_no << 1)
				//end	
			//end
			//else start_seen <= 1'b0;	
		//end
		begin
			start_latch <= start;
			start_latch1<= start_latch;
			start_latch2<= start_latch1;

			enable_latch <= enable;

			if (enable && ~enable_latch)  packet_to_do	<= (packet_no << 1);
			
			if (start_latch || start_latch1 || start_latch2) 	start_seen <= 1'b1;
			else if (packet_cnt == packet_to_do)					start_seen <= 1'b0;
		end
	end

   always @(posedge clk, negedge rst_n)
   begin
      if (rst_n == 1'b0)
      begin
         packet_cnt	<= 16'b0;
			delay_cnt	<= 4'b0;
         cnt 			<= 4'b0;
      end
      else
      begin
			if (start_seen)
			begin
				if (delay_cnt < EXTRA_DELAY) delay_cnt<= delay_cnt + 1'b1;	
				else 
				begin
					if ( packet_cnt < packet_to_do )
					begin
						cnt	<= cnt + 1'b1;
						if ( cnt[3] == 1'b1 ) 
						begin
							packet_cnt <= packet_cnt + 1'b1;
							cnt <= 4'b0;
						end	
					end
				end
			end
			else
			begin
				packet_cnt	<= 16'b0;
				delay_cnt	<= 4'b0;
				cnt 			<= 4'b0;
			end
		end	
   end

	assign memfifo_re = cnt[DELAY_BIT];
		
	endmodule

