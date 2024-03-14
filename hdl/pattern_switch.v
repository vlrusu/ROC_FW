///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pattern_switch.v
// File history:
//      <v1>: <02/03/24> Remove DIGI_EW_TAG correction after fixing PATTERN_INIT logic
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

module pattern_switch(
 
   input    pattern_en,           // select between DIGIFIFO inputs (if 0) vs PATTERN inputs (if 1) to EW_FIFO_controller 

   input    DIGI_curr_ewfifo_wr,
   input    DIGI_ew_done,
   input    DIGI_ew_ovfl,
   input    DIGI_ew_fifo_we,
   input    [`DIGI_BITS-1:0]        DIGI_ew_fifo_data,
   input    [`EVENT_SIZE_BITS-1:0]  DIGI_ew_size, // in units of 64-bit BEATS
   input    [`SPILL_TAG_BITS-1:0]   DIGI_ew_tag,
   input    PATTRN_curr_ewfifo_wr,
   input    PATTRN_ew_done,
   input    PATTRN_ew_ovfl,
   input    PATTRN_ew_fifo_we,
   input    [`DIGI_BITS-1:0]        PATTRN_ew_fifo_data,
   input    [`EVENT_SIZE_BITS-1:0]  PATTRN_ew_size, // in units of 64-bit BEATS
   input    [`SPILL_TAG_BITS-1:0]   PATTRN_ew_tag,
   output   curr_ewfifo_wr,
   output   ew_done,
   output   ew_ovfl,
   output   ew_fifo_we,
   output   [`DIGI_BITS-1:0] ew_fifo_data,
   output   [`EVENT_SIZE_BITS-1:0] ew_size, // in units of 64-bit BEATS
   output   [`SPILL_TAG_BITS-1:0] ew_tag,
   
   input    axi_start_on_serdesclk,
   output   DIGI_axi_start_on_serdesclk,
   output   PATTRN_axi_start_on_serdesclk
);

//<statements>
   assign curr_ewfifo_wr   = (pattern_en) ?  PATTRN_curr_ewfifo_wr   : DIGI_curr_ewfifo_wr;
   assign ew_done          = (pattern_en) ?  PATTRN_ew_done          : DIGI_ew_done;
   assign ew_ovfl          = (pattern_en) ?  PATTRN_ew_ovfl          : DIGI_ew_ovfl;
   assign ew_fifo_we       = (pattern_en) ?  PATTRN_ew_fifo_we       : DIGI_ew_fifo_we;
   assign ew_fifo_data     = (pattern_en) ?  PATTRN_ew_fifo_data     : DIGI_ew_fifo_data;
   assign ew_size          = (pattern_en) ?  PATTRN_ew_size          : DIGI_ew_size;
   assign ew_tag           = (pattern_en) ?  PATTRN_ew_tag           : DIGI_ew_tag;
//   assign ew_tag           = (pattern_en) ?  PATTRN_ew_tag           : (DIGI_ew_tag+1);
   
   assign DIGI_axi_start_on_serdesclk     =  axi_start_on_serdesclk & ~pattern_en;
   assign PATTRN_axi_start_on_serdesclk   =  axi_start_on_serdesclk &  pattern_en;

endmodule

