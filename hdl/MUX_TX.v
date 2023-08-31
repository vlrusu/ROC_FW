///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: MUX_TX.v
// File history:
//      v1.0: Jan. 2020,  drives DTCEmulator data to loopback via CorePCS if enabled
//      v1.0: Mar. 2020   drives PRBS (highest priority) or DTCEmulator data to loopback via CorePCS if enabled
//      v3.0: Aug. 2023   remove PRBS data and subsitute DTCEmulator data with (loopback) MARKER data
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

module MUX_TX(   
	input            TX_CLK,
   //input            PRBS_EN,  // if 1, PRBS data to TX (highest priority) else others
   //input    [15:0]  PRBS_DATA,
   //input    [1:0]   PRBS_KCHAR,
   //input            DTCSIM_EN,  // if 0, TxPacketWriter data to TX;  if 1, DTC Emulator data to TX
   //input    [15:0]  DTCSIM_DATA,
   //input    [1:0]   DTCSIM_KCHAR,
    input            MARKER_EN,  // if 0, TxPacketWriter data to TX;  if 1, DTC Emulator data to TX
    input    [15:0]  MARKER_DATA,
    input    [1:0]   MARKER_KCHAR,
    input    [15:0]  FIBER_DATA,
    input    [1:0]   FIBER_KCHAR,
    output reg  [15:0]  TX_DATA,
    output reg  [1:0]   TX_KCHAR
);

   always @ (posedge TX_CLK)
    begin
        //TX_DATA 	<= (PRBS_EN==1'b1) ? PRBS_DATA  : 	((DTCSIM_EN==1'b1) ? DTCSIM_DATA  : FIBER_DATA);
		//TX_KCHAR    <= (PRBS_EN==1'b1) ? PRBS_KCHAR :	((DTCSIM_EN==1'b1) ? DTCSIM_KCHAR : FIBER_KCHAR);
		TX_DATA     <= (MARKER_EN==1'b1) ? MARKER_DATA  : FIBER_DATA;
		TX_KCHAR    <= (MARKER_EN==1'b1) ? MARKER_KCHAR : FIBER_KCHAR;
    end
  
endmodule


