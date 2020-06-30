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
 
 output             data_out_re,	// DIGIFIFO read enable
 output reg         data_out_we,	// TEMPFIFO write enable
 output 	 [63:0] data_out_64bit 	// data to TEMPFIFO
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
// make LAST_WRITE run on the same clock as DIGIFIFO read 
reg last_write_reg;
always@(posedge digiclk_i) last_write_reg <= last_write;


wire	   data_valid;  // to start at least two words are in DIGIFIFO
// make sure we have an even number of words left to read...
assign	   data_valid   = (data_in_rdcnt > 2 && ~disable_re && ~last_write_reg)  ? 1'b1 : 1'b0;

///////////////////////////////////////////////////////////////////////////////
// AXI state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [1:0]  idle    =   2'b00,
                  read    =   2'b01,
                  write   =   2'b10;
 

// to read, need at least two words in DIGIFIFO
//assign data_out_re = data_valid;
// add requirement that FIFO_CONV be not full
assign data_out_re = data_valid && ~tempfifo_full;
assign data_out_64bit = {read_in1[31:0],read_in2[31:0]};

// SM starting when at least two 32-bit words are in DIGIFIFO
// skip IDLE until at least one 32-bit words is in DIGIFIFO
// workds with DIGIFIFO in FWFT or in DEFAULT configuration!!
always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)
   begin
      data_out_we  		<=  1'b0;
      read_in1			<=  32'b0;
      read_in2			<=  32'b0;
      conv_state      	<=  idle;
   end
   else
   begin

   case(conv_state)   
   idle:
   begin
      data_out_we  		<=  1'b0;
      read_in2			<=  32'hFFFF_FFFF;
      if(data_valid) 
	  begin
        read_in1   	    <=  data_in_32bit;
		conv_state    	<=  read;
	  end
	  else
      begin
        read_in1   	    <=  32'hFFFF_FFFF;
		conv_state    	<=  idle;
	  end
   end

   //set first 32-bit word from DIGIFIFO 
   read:
   begin            
	  read_in1   	    <=  read_in1;
	  read_in2   	    <=  data_in_32bit;
      data_out_we  		<=  1'b0;
	  conv_state    	<=  write;
   end

   //write word to TEMPFIFO; decide if last write is necessary
   write:
   begin
     read_in1   	    <=  data_in_32bit;
	 read_in2   	    <=  read_in2;
     data_out_we   	    <=  1'b1;
//     if(data_valid) 
//     if(data_valid && ~tempfifo_full) 
     if(data_out_re) 
        conv_state    	<=  read;
 	 else
        conv_state    	<=  idle;
   end

   
   default:
   begin
	 data_out_we   		<=  1'b0;
     read_in1   	    <=  32'HFFFF_FFFF;
     read_in2			<=  32'HFFFF_FFFF;
	 conv_state    		<=  idle;
   end

   endcase

   end
end


endmodule