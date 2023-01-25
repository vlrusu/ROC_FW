///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: offset_switch.v
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

module offset_switch(    
	input           serial_en,      // select between SERIAL driven (=1) vs DCS drives (=0) Event Window offset 
	input   [`EVENT_TAG_BITS-1:0]    serial_offset,  // select between Event Window offset 
	input   [`EVENT_TAG_BITS-1:0]    run_offset,     // HB tag at start of SPILL 
	output  [`EVENT_TAG_BITS-1:0]	ewtag_offset
);

// statements
assign ewtag_offset = (serial_en) ? serial_offset: (run_offset-1);

endmodule


