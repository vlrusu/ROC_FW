///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pattern_switch.v
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

module pattern_switch( 
   input         pattern_en,           // select between DIGIFIFO input (if 0) vs PATTERN input (if 1) to DDR 

   input    DIGIFIFO_empty,
   input    DIGIFIFO_full,
   input    PATTERN_empty,
   input    PATTERN_full,
   input    [31:0]  DIGIFIFO_q,
   input    [16:0]  DIGIFIFO_rdcnt,
   input    [31:0]  PATTERN_q,
   input    [16:0]  PATTERN_rdcnt,
   output   CONVERTER_empty,
   output   CONVERTER_full,
   output [31:0] CONVERTER_q,
   output [16:0] CONVERTER_rdcnt
);

//<statements>
   assign CONVERTER_empty   = (pattern_en==1'b1) ?  PATTERN_empty   : DIGIFIFO_empty;
   assign CONVERTER_full    = (pattern_en==1'b1) ?  PATTERN_full    : DIGIFIFO_full;
   assign CONVERTER_q       = (pattern_en==1'b1) ?  PATTERN_q       : DIGIFIFO_q;
   assign CONVERTER_rdcnt   = (pattern_en==1'b1) ?  PATTERN_rdcnt   : DIGIFIFO_rdcnt;

endmodule

