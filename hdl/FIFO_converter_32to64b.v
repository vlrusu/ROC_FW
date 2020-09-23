///////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------
//                                                                 
//  Microsemi Corporation Proprietary and Confidential
//  Copyright 2017 Microsemi Corporation. All rights reserved.
//                                                                  
//  ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
//  ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED 
//  IN ADVANCE IN WRITING.
//
//-------------------------------------------------------------------------
// Title       : <FIFO_converter_32to64b>
// Created     : <April 2019>
// Description : This module reads data from the 32-bit DIGIFIFO and
//               sends it to a 64-bit FWFT TEMPFIFO to be used to write 
//               data to the DDR3 Memory. Use 2-clks of SM to keep up with data writing to DIGIFIFO.
//
// Hierarchy   :
//               FIFO_converter_32to64b.v            <-- This module
//                           
//-------------------------------------------------------------------------

module FIFO_converter_32to64b(
//global signals
 input              digiclk_i,  		// DIGIFIFO clock
 input              resetn_i,

 input              data_in_empty,	// DIGIFIFO has some data   - unused
 input              data_in_full,	// DIGIFIFO is FULL         - unused
 input       [16:0] data_in_rdcnt,	// data written to DIGIFIFO 
 input       [31:0] data_in_32bit,	// data from DIGIFIFO 
 input              tempfifo_empty, // TEMPFIFO empty
 input              tempfifo_full,  // TEMPFIFO almost full (to give time to stop DIGIFIFO read)
 input              last_write,     // disable reading data from DIGIFIFO when this condition is met

 input              ddr_start,      // DDR ready to be written, sent via fifo_write_mem_en command
 input              ddr_stop,       // DDR not ready to be written, via DDR3_FULL
 output             digififo_re,	// DIGIFIFO read enable
 output reg         tempfifo_we,	// TEMPFIFO write enable
 output 	 [63:0] tempfifo_64bit 	// data to TEMPFIFO
);

assign  reset = ~resetn_i;

reg	[1:0]  conv_state;
reg	[31:0] read_in1, read_in2;

//
// logic to disable data transfer from DIGIFIFO when TEMPFIFO is full 
reg    disable_re;
always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)           disable_re <= 1'b0;
   else 
   begin
      if      (tempfifo_full)   disable_re <= 1'b1;
      else if (tempfifo_empty)  disable_re <= 1'b0;
   end
end

//
// logic to disable data transfer from DIGIFIFO until we declare DDR3 memory ready to take data
reg    ddr_ready;
always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)        ddr_ready <= 1'b0;
   else 
   begin
      if      (ddr_start)   ddr_ready <= 1'b1;
      else if (ddr_stop)    ddr_ready <= 1'b0;
   end
end

//
// make LAST_WRITE run on the same clock as DIGIFIFO read 
reg last_write_reg;
always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)    last_write_reg <= 1'b0;
   else                 last_write_reg <= last_write;
end


// make sure we have at least two words are in DIGIFIFO, 
// that TEMPFIFO is empty and that memory is not full
wire	   data_valid;  // to start 
assign	   data_valid   = (data_in_rdcnt > 1 && ~disable_re && ~last_write_reg && ddr_ready)  ? 1'b1 : 1'b0;

// to read, need at least two words in DIGIFIFO
// plus requirement that FIFO_CONV not be full
assign digififo_re = data_valid && ~tempfifo_full;
assign tempfifo_64bit = {read_in2[31:0],read_in1[31:0]};

///////////////////////////////////////////////////////////////////////////////
// AXI state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [1:0]  idle    =   2'b00,
                  start   =   2'b01,
                  read    =   2'b10,
                  write   =   2'b11;
 

// SM starts when at least two 32-bit words are in DIGIFIFO
// works with DIGIFIFO in FWFT or in DEFAULT configuration!!
always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)
   begin
      tempfifo_we  		<=  1'b0;
      read_in1			<=  32'b0;
      read_in2			<=  32'b0;
      conv_state      	<=  idle;
   end
   else
   begin

   case(conv_state)   
   idle:
   begin
      tempfifo_we  		<=  1'b0;
      read_in1   	    <=  32'hF0F0_F0F0;
      read_in2			<=  32'hF0F0_F0F0;
      if(data_valid) 
      begin
         conv_state    	<=  start;
	  end
   end

   //set first 32-bit word from DIGIFIFO 
   start:
   begin            
	  read_in1   	    <=  data_in_32bit;
	  read_in2   	    <=  read_in2;
      tempfifo_we  		<=  1'b0;
	  conv_state    	<=  read;
   end

   //word ready for TEMPFIFO; decide if last read is necessary to empty DIGIFIFO
   read:
   begin
     read_in1   	    <=  read_in1;
	 read_in2   	    <=  data_in_32bit;
     tempfifo_we   	    <=  1'b1;
     if(digififo_re) 
        conv_state    	<=  write;
 	 else
        conv_state    	<=  idle;
   end

   write:
   begin
     read_in1   	    <=  data_in_32bit;
	 read_in2   	    <=  read_in2;
     tempfifo_we   	    <=  1'b0;
     conv_state    	    <=  read;
   end
   
   default:
   begin
	 tempfifo_we   		<=  1'b0;
     read_in1   	    <=  32'HF0F0_F0F0;
     read_in2			<=  32'HF0F0_F0F0;
	 conv_state    		<=  idle;
   end

   endcase

   end
end

endmodule