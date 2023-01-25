///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: cfo_emulator_switch.v
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

`include "tracker_params.vh"

module cfo_emulator_switch(  
   input    cfo_emul_en,           // select between DIGIFIFO inputs (if 0) vs PATTERN inputs (if 1) to EW_FIFO_controller 

   input          cfo_emul_MARKER_SEL,
   input [3:0]    cfo_emul_PACKET_TYPE,   // 0: DCSReq, 1: Heartbeat, 2: DATAReq, 3: PREFetch 
   input [31:0]   cfo_emul_EVENT_MODE,
   input [47:0]   cfo_emul_EVENT_WINDOW_TAG,

   input          serial_MARKER_SEL,
   input [3:0]    serial_PACKET_TYPE,  
   input [31:0]   serial_EVENT_MODE,
   input [47:0]   serial_EVENT_WINDOW_TAG,
   
   output         MARKER_SEL,
   output [3:0]   PACKET_TYPE,
   output [31:0]  EVENT_MODE,
   output [47:0]  EVENT_WINDOW_TAG

);
//<statements>

assign   MARKER_SEL  = (cfo_emul_en == 1'b1) ? cfo_emul_MARKER_SEL   : serial_MARKER_SEL;
assign   PACKET_TYPE = (cfo_emul_en == 1'b1) ? cfo_emul_PACKET_TYPE  : serial_PACKET_TYPE;
assign   EVENT_MODE  = (cfo_emul_en == 1'b1) ? cfo_emul_EVENT_MODE   : serial_EVENT_MODE;
assign   EVENT_WINDOW_TAG  = (cfo_emul_en == 1'b1) ? cfo_emul_EVENT_WINDOW_TAG   : serial_EVENT_WINDOW_TAG;

endmodule

