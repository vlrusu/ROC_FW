///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: mux_dcs_sim.v
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

module mux_dcs_sim(

   input				DCS_SIM_EN,
	
	input				A_MEM_WEN,
	input				A_PATTERN_EN,	
   input	[1:0]		A_PATTERN,
   input	[31:0]   A_WRITE_PAGE_NO,
	
	input				B_MEM_WEN,
	input				B_PATTERN_EN,	
   input	[1:0]		B_PATTERN,
   input	[31:0]   B_WRITE_PAGE_NO,
	
	output			MEM_WEN,
	output			PATTERN_EN,	
   output[1:0]		PATTERN,
   output[31:0]	WRITE_PAGE_NO

  );

//<statements>
	assign PATTERN_EN	= 	(DCS_SIM_EN==1'b1) ? 	B_PATTERN_EN 	:	A_PATTERN_EN;
	assign PATTERN		= 	(DCS_SIM_EN==1'b1) ? 	B_PATTERN	 	:	A_PATTERN;
	assign WRITE_PAGE_NO=(DCS_SIM_EN==1'b1) ? 	B_WRITE_PAGE_NO:	A_WRITE_PAGE_NO;
	assign MEM_WEN		= 	(DCS_SIM_EN==1'b1) ? 	B_MEM_WEN 		: 	A_MEM_WEN;

endmodule

