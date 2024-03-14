///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pulse_time_crossing.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// CDC (Cross-Domain Clock) handshake for DDR_WRITE_DONE
// 1) start REQ on clk_fast signal and clear on "synchronized ACKNOWLEDGE"
// 2) synchronize REQ on clk_slow => REQ_SYNC
// 3) feed-back REQ_SYNC as acknowlegde => ACK_SYNC 
// 4) generate BUSY until ACKOWLEDGE is cleared
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG484>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pulse_time_crossing( 
   input clk_in,
   input resetn_in,
   input pulse_in,  // pulse on clk_in
   
   input clock_out,
   input resetn_out,
   output reg pulse_out  // pulse on clk_out
);

//<statements>
reg	    req, ack_req, ack_sync;
reg	    req_latch, req_sync;
wire	busy;

always@(posedge clk_in, negedge resetn_in)
begin
    if(resetn_in == 1'b0)
    begin
        req <= 0;
    end
    else
    begin
        ack_req <= req_sync;
        ack_sync<=	ack_req;
      
        if (pulse_in && !busy)	req <= 1'b1;
        else if (ack_sync)	    req <= 1'b0;
    end
end	

assign 	busy = req || ack_sync;

// synchronize the request on slow clock
always@(posedge clock_out, negedge resetn_out)
begin
    if(resetn_out == 1'b0) 
    begin 
        pulse_out   <= 0;
    end
	else
	begin
		req_latch   <= req;
		req_sync    <=	req_latch;
      
		pulse_out	<=	req_latch && !req_sync;
	end
end

endmodule

