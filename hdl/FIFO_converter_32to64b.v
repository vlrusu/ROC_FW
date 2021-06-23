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
//    v4.0     :  02/2021   Simplified CONV_DATA state machine controls with DIGI_READ_STATE state machine
//                          TEMPFIFO_FULL input neeeds to change from AF to FULL-2 
//    							 Added DDR3_FULL input to avoid spurious "FIFO_WRITE_MEM_EN" when DDR is still being read out
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
	input				last_write,     	// disable reading data from DIGIFIFO until this condition is met
	input				DDR3_full,     	// disable reading data from DIGIFIFO until this condition is met
	input				fifo_write_mem_en,// start data transfer to memory
 
	output reg		digififo_re,		// DIGIFIFO read enable
	output reg		tempfifo_we,		// TEMPFIFO write enable
	output [63:0] 	tempfifo_64bit		// data to TEMPFIFO
);

assign  reset = ~resetn_i;

wire 	data_ready;
reg	daq_ready;
reg	disable_re;

reg	[2:0]		digi_read_state;
reg	[2:0]		conv_state;
reg	[31:0] 	read_in1, read_in2;

///////////////////////////////////////////////////////////////////////////////
// state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]  idle	=   3'b000,
                  start	=   3'b001,
						stop	=   3'b011,
                  hold	=   3'b010,
                  read	=   3'b110,
						write	=   3'b100;
						
// DIGI_READ_STATE SM:
// 1) starts if enough data in DIGIFIFO and FIFO_WRITE_MEM signal is seen => generate DIGIFIFO_RE
// 2) stops when TEMPFIFO is about to get full and issue DISABLE_RE to prevent DIGIFIFO_RE
// 3) wait until TEMPFIFO_EMPTY to go back to IDLE

always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)		daq_ready <= 1'b0;
   else 
	begin
//		if (fifo_write_mem_en)	daq_ready <= 1'b1;
		if (fifo_write_mem_en && ~DDR3_full)	daq_ready <= 1'b1;
		else if (last_write)		daq_ready <= 1'b0;
	end
end

assign	data_ready   = (data_in_rdcnt >= 17'h100 && !disable_re && daq_ready);


always@(posedge digiclk_i, posedge reset)
begin
   if(reset == 1'b1)
   begin
      digififo_re		<=  1'b0;
		disable_re		<=  1'b0;
      digi_read_state<=  idle;
   end
   else
	
   begin
   case(digi_read_state)
   
   idle:
   begin
		disable_re		<= 1'b0;
      if(data_ready) 
		begin
			digi_read_state	<= start;
			digififo_re			<= 1'b1;  // must start here to allow enough time for first 32-bit data to exit DIGIFIFO before conversion
		end
   end

	start:
   begin
      if(tempfifo_full) 
		begin
			digi_read_state<=  stop;
			disable_re		<= 1'b1;
			digififo_re		<= 1'b1;
		end
   end

	stop:
   begin
		digififo_re		<= 1'b0;
      if(tempfifo_empty) digi_read_state	<=  idle;
   end

	default:
   begin
		digififo_re		<= 1'b0;
		disable_re		<= 1'b0;
      digi_read_state<= idle;
   end

	endcase
	end
end


// CONV_STATE SM: starts when at least 0x100 32-bit words are in DIGIFIFO
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
      if(data_ready) conv_state	<=  start;
   end

   // hold one cycle for data from DIGIFIO to arrive 
   start:
   begin            
		read_in1			<=  read_in1;
		read_in2			<=  read_in2;
		tempfifo_we		<=  1'b0;
		conv_state    	<=  hold;
   end

   // latch first 32-bit word from DIGIFIFO 
   hold:
   begin            
		read_in1			<=  data_in_32bit;
		read_in2			<=  read_in2;
		tempfifo_we		<=  1'b0;
		conv_state    	<=  read;
   end

   // second 32-bit latched => word ready for TEMPFIFO
   read:
   begin
		read_in1			<=  read_in1;
		read_in2			<=  data_in_32bit;
		tempfifo_we		<=  1'b1;
		if(digififo_re)  // decide if last read is necessary to empty DIGIFIFO
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

assign 	tempfifo_64bit = {read_in2[31:0],read_in1[31:0]};

endmodule