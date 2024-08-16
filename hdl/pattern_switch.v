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
 
   input    serdesclk,  	    // on 150 MHz clock
   input    resetn_serdesclk,
    
   input    pattern_en,           // select between DIGIFIFO inputs (if 0) vs PATTERN inputs (if 1) to EW_FIFO_controller 

   input    DIGI_curr_ewfifo_wr,
   input    DIGI_ew_done,
   input    DIGI_ew_ovfl,
   input    DIGI_ew_fifo_we,
   input    DIGI_ew_tag_error,
   input    DIGI_tag_sync_error,
   input    [`DIGI_BITS-1:0]        DIGI_ew_fifo_data,
   input    [`EVENT_SIZE_BITS-1:0]  DIGI_ew_size, // in units of 64-bit BEATS
   input    [`SPILL_TAG_BITS-1:0]   DIGI_ew_tag,
   input    PATTRN_curr_ewfifo_wr,
   input    PATTRN_ew_done,
   input    PATTRN_ew_ovfl,
   input    PATTRN_ew_fifo_we,
   input    PATTRN_ew_tag_error,
   input    PATTRN_tag_sync_error,
   input    [`DIGI_BITS-1:0]        PATTRN_ew_fifo_data,
   input    [`EVENT_SIZE_BITS-1:0]  PATTRN_ew_size, // in units of 64-bit BEATS
   input    [`SPILL_TAG_BITS-1:0]   PATTRN_ew_tag,
   output reg   curr_ewfifo_wr,
   output reg   ew_done,
   output reg   ew_ovfl,
   output reg   ew_fifo_we,
   output reg   ew_tag_error,
   output reg   tag_sync_error,
   output reg   [`DIGI_BITS-1:0] ew_fifo_data,
   output reg   [`EVENT_SIZE_BITS-1:0] ew_size, // in units of 64-bit BEATS
   output reg   [`SPILL_TAG_BITS-1:0] ew_tag,
   
   input    axi_start_on_serdesclk,
   output reg   DIGI_axi_start_on_serdesclk,
   output reg   PATTRN_axi_start_on_serdesclk
);

//<statements>
   //assign curr_ewfifo_wr   = (pattern_en) ?  PATTRN_curr_ewfifo_wr   : DIGI_curr_ewfifo_wr;
   //assign ew_done          = (pattern_en) ?  PATTRN_ew_done          : DIGI_ew_done;
   //assign ew_ovfl          = (pattern_en) ?  PATTRN_ew_ovfl          : DIGI_ew_ovfl;
   //assign ew_fifo_we       = (pattern_en) ?  PATTRN_ew_fifo_we       : DIGI_ew_fifo_we;
   //assign ew_fifo_data     = (pattern_en) ?  PATTRN_ew_fifo_data     : DIGI_ew_fifo_data;
   //assign ew_size          = (pattern_en) ?  PATTRN_ew_size          : DIGI_ew_size;
   //assign ew_tag           = (pattern_en) ?  PATTRN_ew_tag           : DIGI_ew_tag;
////   assign ew_tag           = (pattern_en) ?  PATTRN_ew_tag           : (DIGI_ew_tag+1);
   //
   //assign DIGI_axi_start_on_serdesclk     =  axi_start_on_serdesclk & ~pattern_en;
   //assign PATTRN_axi_start_on_serdesclk   =  axi_start_on_serdesclk &  pattern_en;
    always@(posedge serdesclk, negedge resetn_serdesclk)
    begin
        if(resetn_serdesclk == 1'b0) 
        begin
            curr_ewfifo_wr  <= 1'b0;
            ew_done         <= 1'b0;
            ew_ovfl         <= 1'b0;
            ew_fifo_we      <= 1'b0;
            ew_tag_error    <= 1'b0;
            tag_sync_error  <= 1'b0;
            ew_fifo_data    <= 0;
            ew_size         <= 0;
            ew_tag          <= 0;
            
            DIGI_axi_start_on_serdesclk     <= 1'b0;
            PATTRN_axi_start_on_serdesclk   <= 1'b0;
        end	
        else
        begin
            curr_ewfifo_wr  <= (pattern_en) ?  PATTRN_curr_ewfifo_wr    : DIGI_curr_ewfifo_wr;
            ew_done         <= (pattern_en) ?  PATTRN_ew_done           : DIGI_ew_done;
            ew_ovfl         <= (pattern_en) ?  PATTRN_ew_ovfl           : DIGI_ew_ovfl;
            ew_fifo_we      <= (pattern_en) ?  PATTRN_ew_fifo_we        : DIGI_ew_fifo_we;
            ew_tag_error    <= (pattern_en) ?  PATTRN_ew_tag_error      : DIGI_ew_tag_error;
            tag_sync_error  <= (pattern_en) ?  PATTRN_tag_sync_error    : DIGI_tag_sync_error;
            ew_fifo_data    <= (pattern_en) ?  PATTRN_ew_fifo_data      : DIGI_ew_fifo_data;
            ew_size         <= (pattern_en) ?  PATTRN_ew_size           : DIGI_ew_size;
            ew_tag          <= (pattern_en) ?  PATTRN_ew_tag            : DIGI_ew_tag;
            
            DIGI_axi_start_on_serdesclk     <=  axi_start_on_serdesclk & ~pattern_en;
            PATTRN_axi_start_on_serdesclk   <=  axi_start_on_serdesclk &  pattern_en;
        end
    end    

endmodule

