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
//    v2.0		:  12/2020   Change "data valid" logic to be data driven for VST using  "data_in_rdcnt >= 17'h100"   
//    v3.0     :  01/2021   Added latching of "tempfifo_empty" and "last_write" to avoid timing violations
//
// Hierarchy   :
//               FIFO_converter_32to64b.v            <-- This module
//                           
//-------------------------------------------------------------------------

module FIFO_converter_32to64b(
//global signals
	input				digiclk_i,  		// DIGIFIFO clock
	input				resetn_i,

	input				data_in_empty,		// DIGIFIFO has some data   - unused
	input				data_in_full,		// DIGIFIFO is FULL         - unused
	input	[16:0]	data_in_rdcnt,		// data written to DIGIFIFO 
	input	[31:0]	data_in_32bit,		// data from DIGIFIFO 
	input				tempfifo_empty,	// TEMPFIFO empty
	input				tempfifo_full,		// TEMPFIFO almost full (to give time to stop DIGIFIFO read)
	input				last_write,     	// disable reading data from DIGIFIFO when this condition is met
	input				fifo_write_mem_en,// start data transfer to memory
 
	output			digififo_re,		// DIGIFIFO read enable
	output reg		tempfifo_we,		// TEMPFIFO write enable
	output [63:0] 	tempfifo_64bit		// data to TEMPFIFO
);

assign  reset = ~resetn_i;

reg	[1:0]		conv_state;
reg	[31:0] 	read_in1, read_in2;

//
// logic to disable data transfer from DIGIFIFO when TEMPFIFO is full until TEMPFIFO is empty
reg	tempfifo_empty_latch;
always@(posedge digiclk_i) tempfifo_empty_latch <= tempfifo_empty;

reg   disable_re;
always@(posedge digiclk_i, posedge reset)
begin
	if(reset == 1'b1)					disable_re <= 1'b0;
   else 
   begin
      if      (tempfifo_full)			disable_re <= 1'b1;
      else if (tempfifo_empty_latch)disable_re <= 1'b0;
   end
end

//
// use 3 distinct signals to control start and end of data-driven transfer of DIGI data to TEMPFIFO
// 1)  DAQ_READY = 1   from "reset" to "last_write" to memory: this allow for reading of DIGI from start of run (ie after a reset) to memory all readout
// 2)  DATA_READY = 1  when DATA_IN_RDCNT >= 0x100 IF tempfifo is available to receive data and DAQ is ready to receive data to DDR3 memory
//        (NB: we will use the register version of this signal to start 32-to-64 bit state machine to make sure is aligns with DIGIFIFO_RE
// 3)  DATA_VALID = 1  from DATA_IN_RDCNT>= 0x100 to TEMPFIFO_FULL. Drives DIGIFIFO_RE, withough being affected by DATA_IN_RDCNT going < 0x100
//
// start write to TEMPFIFO only when at least 1kB in DIGIFIFO
// stop write to TEMPFIFO when "daq_ready" is cleared, ie "last_write" is seen ("ddr_full" not needed
//   because it uses "last_write" int its logic)
// NB:  "data_valid" used in "digififo_re" enable cannot start BEFORE "last_write" is checked for previous 1kB block!
// NB:  "daq_ready" connected to reset, issued when all DDRs have been fully read 
reg	last_write_latch;
always@(posedge digiclk_i)last_write_latch <= last_write;

reg   daq_ready;
reg	data_ready_reg, data_ready_latch;
always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)		daq_ready <= 1'b0;
   else 
	begin
		if (fifo_write_mem_en)		daq_ready <= 1'b1;
		else if (last_write_latch)	daq_ready <= 1'b0;
	end
end

always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)	
	begin
		data_ready_latch 	<= 1'b0;
		data_ready_reg 	<= 1'b0;
	end
	else
	begin
		data_ready_latch 	<= data_ready;
		data_ready_reg		<= data_ready_latch;
	end
end

// used to enable 32-to-64 bit converter data-driven state machine 
wire		data_ready;
assign	data_ready   = (data_in_rdcnt >= 17'h100 && ~disable_re && daq_ready)  ? 1'b1 : 1'b0;


// logic used to start SM: it delays DATA_READY by 1-clk to ensures "digififo_re" is asserted together with the SM machine start
wire		data_start;
assign	data_start = data_ready_latch && ~data_ready_reg;


// "digififo_re": must be level starting with "data_ready" and end with tempfifo_full (TEMPFIFO_AF)
//  N.B. This logic ensures that it is not cleared by "data_in_rdcnt" <= 0x100 !!  
reg	data_valid;
always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)		data_valid <= 1'b0;
   else 
	begin
		if (data_ready)				data_valid <= 1'b1;
      else if (tempfifo_full) 	data_valid <= 1'b0;
	end
end

assign 	digififo_re 	= data_valid && ~tempfifo_full;
assign 	tempfifo_64bit = {read_in2[31:0],read_in1[31:0]};

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
      tempfifo_we		<=  1'b0;
      read_in1			<=  32'b0;
      read_in2			<=  32'b0;
      conv_state		<=  idle;
   end
   else
   begin

   case(conv_state)   
   idle:
   begin
      tempfifo_we  	<=  1'b0;
      read_in1   	   <=  32'hF0F0_F0F0;
      read_in2			<=  32'hF0F0_F0F0;
      if(data_start) 
      begin
         conv_state	<=  start;
	  end
   end

   //set first 32-bit word from DIGIFIFO 
   start:
   begin            
		read_in1			<=  data_in_32bit;
		read_in2			<=  read_in2;
		tempfifo_we		<=  1'b0;
		conv_state    	<=  read;
   end

   //word ready for TEMPFIFO; decide if last read is necessary to empty DIGIFIFO
   read:
   begin
		read_in1			<=  read_in1;
		read_in2			<=  data_in_32bit;
		tempfifo_we		<=  1'b1;
		if(digififo_re) 
        conv_state	<=  write;
		else
        conv_state	<=  idle;
   end

   write:
   begin
		read_in1			<=  data_in_32bit;
		read_in2			<=  read_in2;
		tempfifo_we		<=  1'b0;
		conv_state		<=  read;
   end
   
   default:
   begin
		tempfifo_we		<=  1'b0;
		read_in1			<=  32'HF0F0_F0F0;
		read_in2			<=  32'HF0F0_F0F0;
		conv_state		<=  idle;
   end

   endcase

   end
end

endmodule