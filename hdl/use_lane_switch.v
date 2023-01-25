///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: use_lane_switch.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>   Prioritize USE_LANE from DTC when driven to a non-zero value.
//                      Else USE_LANE from SlowControls when driven to a non-zero value. 
//                      If neither is set, drive USE_LANE to zero.
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module use_lane_switch(
   //input    SERIAL_EN,           // SERIAL lane assignment over DCS lane assignment
   //input    SERIAL_pattern_en,   // PATTERN to DDR is set via SERIAL: ignore lanes 
   //input    DCS_pattern_en,      // PATTERN to DDR is set via DCS: ignore lanes

   input [3:0]    SERIAL_use_lane,  // USE_LANE from SlowControls
   input [3:0]    DCS_use_lane,     // USE_LANE from DTC
   output [3:0]   use_lane
);

   assign   use_lane = (DCS_use_lane>0) ? DCS_use_lane : ((SERIAL_use_lane>0) ? SERIAL_use_lane : 4'h0);
   
endmodule

