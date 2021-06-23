///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: cdc_fast_slow.v
// File history:
//      v1.0: 01/2021: First version
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//    Pass pulse in CLK_FAST to CLOK_SLOW via acknowledge mechanism
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: Monica Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module cdc_fast_slow( 
 input   clk_fast, 
 input   clk_slow, 
 input   resetn_i, 
 input   fast_in,	 
 output  reg slow_out 
);

reg	req, req_latch, req_sync, req_sync_latch;
reg	ack_req_latch, ack_sync;
wire	busy;

// CDC (Cross-Domain Clock) handshake
// 1) send REQUEST and wait for "synchronized ACKNOWLEDGE" on clk_fast
// 2) synchronize the REQUEST on clk_slow
// 3) feed-back the "synchronized request" as ACKNOWLEDGE 
// 4) generate BUSY until ACKOWLEDGE is cleared
always@(posedge clk_fast)
begin
	if ( fast_in && !busy )	req <= 1'b1;
	else if (ack_sync)		req <= 1'b0;
end	

assign 	busy = req || ack_sync;

// synchronize the request on CLK_STOP
always@(posedge clk_slow)
begin
	req_latch		<= req;
	req_sync			<=	req_latch;
	req_sync_latch <= req_sync;
end

always@(posedge clk_fast)
begin
	ack_req_latch	<= req_sync;
	ack_sync			<=	ack_req_latch;
end



always@(posedge clk_slow, negedge resetn_i)
begin
    if(resetn_i==1'b0)	slow_out <= 1'b0;
    else						slow_out <= req_sync && !req_sync_latch;
end

endmodule

