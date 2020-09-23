///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: mux_16bit.v
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

module mux_xcvr( 
   input            RX_CLK,
   input            RX_RESETN,
   input            DTC_SEL,  // if 0, DTC Packet out;  if 1, Marker out
   input    [15:0]  MARKER_SIM_DATA,
   input    [15:0]  DTC_SIM_DATA,
   input    [1:0]   MARKER_SIM_KCHAR,
   input    [1:0]   DTC_SIM_KCHAR,
   output reg  [15:0]  TX_DATA,
   output reg  [1:0]   TX_KCHAR
  );

   parameter [15:0]     Comma	= 16'hBC3C;	//k28.5 k28.1
   parameter  [1:0]     KChar   = 2'b11;

   always @ (posedge RX_CLK or negedge RX_RESETN)
   begin
      if (RX_RESETN == 1'b0)
      begin
         TX_DATA    <=  Comma;   
         TX_KCHAR   <=  KChar;
      end
      
      else
      begin
         TX_DATA 	   <= (DTC_SEL==1'b1) ? MARKER_SIM_DATA  : DTC_SIM_DATA;
         TX_KCHAR    <= (DTC_SEL==1'b1) ? MARKER_SIM_KCHAR : DTC_SIM_KCHAR;
      end
   end
  
endmodule

