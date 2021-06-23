///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: SIM_CNTRL.v
// File history:
//      <v1.0>: <02/26/2021>: first version
//      <v2.0>: <05/10/2021>: made DCS signals always output UNLESS Serial DDRCS is set. DracMonitor bit[4] unused.
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// Controller for signals that can come either via DCS or SERIAL.
// They assume DDR_EN (via DDR_CS) to be a level.
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module SIM_CNTRL( 
// latches driven  
   input				SERIAL_EN,
// inputs	
	input				DCS_MEM_WEN,
	input				DCS_PATTERN_EN,	
   input	[1:0]		DCS_PATTERN,
   input	[31:0]   DCS_WRITE_PAGE_NO,
	
	input				SERIAL_MEM_WEN,
	input				SERIAL_PATTERN_EN,	
   input	[1:0]		SERIAL_PATTERN,
   input	[31:0]   SERIAL_WRITE_PAGE_NO,
// outputs	
	output reg			MEM_WEN,
	output reg			PATTERN_EN,	
   output reg[1:0]	PATTERN,
   output reg[31:0]	WRITE_PAGE_NO
);

always @ (*)
   begin
		MEM_WEN 			<= (SERIAL_EN==1'b1) ? SERIAL_MEM_WEN			: DCS_MEM_WEN;
		PATTERN_EN		<= (SERIAL_EN==1'b1) ? SERIAL_PATTERN_EN  	: DCS_PATTERN_EN;
		PATTERN			<= (SERIAL_EN==1'b1) ? SERIAL_PATTERN	  		: DCS_PATTERN;
		WRITE_PAGE_NO	<= (SERIAL_EN==1'b1) ? SERIAL_WRITE_PAGE_NO	: DCS_WRITE_PAGE_NO;
	end

endmodule

