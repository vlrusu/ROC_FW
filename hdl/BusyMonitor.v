///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: BusyMonitor.v
// File history:
//      v1: Aug. 14, 2020: first version for Evaluation board
//
// Description:  
//  This module issues a BUSY signal during DTC Requests or Retransmission Marker request to drive processor interrupt.
//  It is clocked by fast XCVR_TX_CLK. BUSY_START sets to 1 and BUSY_CLEAR to 0.
// 
//  BUSY_START is driven by ForwardDetector, which processes any DTC Request (either DCS or Data Request) or Retransmission Marker
//  BUSY_CLEAR is OR of multiple signals (implemented as AND since they Are are all negative logic):
//      1) initial board reset (RESET_N)
//      2) last DCS Reply or Data Payload or end of Retransmission is seen by PacketSender (BUSY_STOP) 
//      3) DracMonitor is reading data from DCS_RCV_FIFO (BUSY_WRITE). This condition is needed to clear BUSY after a DCS write request 
//         since it is not followed by any DCS reply. Retrigger this clear condition if new pulse is seen within 1 us of previous one to cover block writes.   
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: Monica Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module BusyMonitor( 
   input    clk,
   input    reset_n,
   input    busy_start,
   input    busy_stop,
   input    busy_write,
   output reg  BUSY
);

wire    CLR;
assign  CLR = reset_n && !busy_delay && !busy_write_done;

// delay BUSY_STOP by 1 us
wire    busy_delay;
assign  busy_delay = (busy_cnt == 8'hFF) ? 1'b1 : 1'b0;

reg [7:0]   busy_cnt;
always @ (posedge clk or negedge reset_n)
begin
   if (reset_n == 1'b0) 
      begin    
         busy_cnt  <= 8'h0;
      end
   else
   begin
      if        (busy_stop == 1'b1)     busy_cnt <= 8'h1;
      else if   (busy_cnt > 8'h0)       busy_cnt <= busy_cnt + 1;
   end
end

// delay last BUSY_WRITE by ~1us
wire    busy_write_done;
assign  busy_write_done = (busy_write_cnt == 8'hFF) ? 1'b1 : 1'b0;

reg [7:0]   busy_write_cnt;
always @ (posedge clk or negedge reset_n)
begin
   if (reset_n == 1'b0) 
      begin    
         busy_write_cnt  <= 8'h0;
      end
   else
   begin
      if        (busy_write == 1'b1)    busy_write_cnt <= 8'h1;
      else if   (busy_write_cnt > 8'h0) busy_write_cnt <= busy_write_cnt + 1;
   end
end


always @ (posedge clk or negedge CLR)
begin
   if       (CLR == 1'b0)   BUSY <= 1'b0;
   else if  (busy_start)    BUSY <= 1'b1;
end

//<statements>

endmodule

