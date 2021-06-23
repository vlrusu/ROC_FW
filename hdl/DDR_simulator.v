///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: new_DDR_simulator.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module DDR_simulator(

	input 			readout_clk,				// 40 MHz ALGO_CLK
	input				resetn,						// connected to DCS_ROCRESET
	
	input 			fifo_write_mem_en,		// from DRACMonitor write addr 0xB
	input 			fifo_read_mem_en,			// driven by DATAREQ_START_EVENT_REQ
	input       	memfifo_re,					// driven by DATAREQ_RE_FIFO
	input	[31:0]	write_page_no,				// from DRACMonitor write addr 0x9
	
	output reg			DDR3_full,				// to DRACMonitor read addr 0x11
	output reg[31:0]	mem_wr_cnt,				// to DRACMonitor read addr 0x13
	output reg[31:0]	mem_rd_cnt,				// to DRACMonitor read addr 0x14
	output reg[31:0]	memfifo_rd_cnt,		// to DRACMonitor read addr 0x15
	output reg			memfifo_data_ready,	// drives DATAREQ_DATA_READY_FLAG
	output reg			memfifo_last_word,	// drives DATAREQ_LAST_WORD_FLAG
	output reg[15:0]  memfifo_data_pckts,	// drives DATAREQ_PACKETS_IN_EVENT
	output [63:0]		memfifo_data			// drives DATAREQ_DATA_REQ_REPLY
);

//<statements>
localparam [15:0]	MEM_BLOCK_SIZE = 16'h40;   // simulates 1KB memory page
//localparam [15:0]	MEM_BLOCK_SIZE = 16'h4;

localparam [2:0]  idle    =   3'b000,
                  start   =   3'b001,
                  run     =   3'b010,
                  last    =   3'b011, 
                  done    =   3'b100; 

reg[2:0]		state;

reg [31:0]	page_no_for_write   = 32'b0;
reg [31:0]	page_no_for_read    = 32'b0;

reg         new_start       	= 1'b0;
reg         new_start_latch 	= 1'b0;
reg         new_start_delay 	= 1'b0;
reg         DDR3_full_latch 	= 1'b0;

reg			DDR3_empty			= 1'b0;
reg [3:0]	ddr3_empty_cnt		= 4'b0;
reg			fifo_read_latch	= 1'b0;
reg			memfifo_re_latch	= 1'b0;
reg			mem_wr_en			= 1'b0;
reg			memfifo_has_data 	= 1'b0;
reg[7:0]		memfifo_cnt			= 8'b0;
reg[31:0]	temp_data			= 32'b0;

wire			new_start_pulse;
wire        DDR3_pulse;
wire			fifo_rd_pulse;
wire			memfifo_re_pulse;


//
// generate edge sensitive signals
always@(posedge readout_clk)
begin
   new_start_latch	<= new_start;
   new_start_delay	<= new_start_latch;
   DDR3_full_latch	<= DDR3_full;
	fifo_read_latch	<= fifo_read_mem_en;
	memfifo_re_latch	<=	memfifo_re;
//	memfifo_cnt_done_latch	<= memfifo_cnt_done;
end

assign  	new_start_pulse	= 	new_start_latch && ~new_start_delay;	// end of memory read
assign  	DDR3_pulse     	= 	DDR3_full && ~DDR3_full_latch;			// end of memory write
assign	fifo_rd_pulse		=	fifo_read_mem_en && ~fifo_read_latch;	// start of Data Request
assign	memfifo_re_pulse	=	memfifo_re && ~memfifo_re_latch;			//	start of 128-bit payload request

//
// generate DDR3_empty signal: used to reply to a Data Request with no data in DDR3 Memory.
// In turn it drives the MEMFIFO_DATA_PCKTS and MEMFIFO_DATA_READY
always@(posedge readout_clk)
begin
	memfifo_data_pckts	<=	(DDR3_empty) ? 16'b0 : MEM_BLOCK_SIZE;					// zero only while DDR3_empty is set (which is also the duration of 
	memfifo_data_ready	<= DDR3_empty || memfifo_has_data;
end

//
// WRITE/READ PAGE_NO control logic:
//  - save number of pages for write based on requested value: to be used in DDR3_FULL logic
//  - save number of pages for read the moment DDR3 is full: to be used in NEW_START logic 
//
always@(posedge readout_clk, negedge resetn)
begin										 
   if (resetn==1'b0)
   begin
      page_no_for_write  <= 32'hFFFF_FFFF;	 // to avoid DDR3_FULL glitch at reset 
      page_no_for_read   <= 32'hFFFF_FFFF;	
   end  
   else 
   begin
		if (write_page_no > 0)	page_no_for_write <= write_page_no;  // need check on non null value to avoid DDR3_FULL instability before writing WRITE_PAGE_NO
      if (DDR3_pulse)			page_no_for_read	<= page_no_for_write;
   end
end

//
// Control outputs logic
//  LAST_WRITE/READ: when number of written/read back pages reaches requested value 
//  DDR3_FULL: set by end of last write to memory, cleared by end of last read from memory
//  NEW_START: signal end of last read from memory

always@(posedge readout_clk, negedge resetn)
begin										 
   if (resetn==1'b0)
	begin 
		DDR3_full 	<= 1'b0;
		new_start 	<= 1'b0;
	end	
   else
   begin

      if 		(new_start_pulse)               	DDR3_full <= 1'b0;
      else if 	(mem_wr_cnt==page_no_for_write)	DDR3_full <= 1'b1;

		if 		(new_start_pulse)						new_start <= 1'b0;
		else if 	(mem_rd_cnt == page_no_for_read)	new_start <= 1'b1;
		
	end
end

//
// Memory writes/reads counter:
// - MEM_WR_CNT => counter enabled by FIFO_WRITE_MEM_EN until PAGE_NO_FOR_WRITE reached(if not already DDR3_FULL)
// - MEM_RD_CNT => counter enable by DATAREQ_START_EVENT, ie FIFO_READ_MEM_EN(if already DDR3_FULL)
always@(posedge readout_clk, negedge resetn, posedge new_start_pulse)
begin
   if (resetn==1'b0 || new_start_pulse) 
	begin
		mem_wr_cnt 	<= 32'b0;
		mem_rd_cnt 	<= 32'b0;
		
		mem_wr_en	<= 1'b0;
	end
   else 
	begin
	
		if(fifo_write_mem_en && !DDR3_full)  		mem_wr_en	<=	1'b1;
		else if(mem_wr_cnt == page_no_for_write)	mem_wr_en	<=	1'b0;
		
		if (mem_wr_en && mem_wr_cnt < page_no_for_write)	mem_wr_cnt <= mem_wr_cnt + 1'b1;  // need check on PAGE_NO_FOR_WRITE to avoid increasing MEM_WR_CNT one time too many
		
      if(fifo_rd_pulse && DDR3_full) 		mem_rd_cnt <= mem_rd_cnt + 1'b1; // NB: this goes up at the beginning of the read
	end
end

//
// state machine for the exchange of DATAREQ signals
always@(posedge readout_clk, negedge resetn)
begin
   if(resetn == 1'b0)
   begin
      memfifo_has_data	<= 1'b0;
		memfifo_rd_cnt 	<= 32'b0;
		memfifo_cnt			<=	8'b0;
		memfifo_last_word	<= 1'b0;
		DDR3_empty			<= 1'b0;
		ddr3_empty_cnt		<= 4'b0;
		temp_data			<= 32'HFFFF_FFFE; // this makes it so the first count to be passed is 0!
      state					<=	idle;
   end
	
   else
	
   begin

   case(state)

   //wait for memory init command/signal
   idle:
   begin
		ddr3_empty_cnt		<= 4'b0;
      if(fifo_read_mem_en)  
		begin
			if (~DDR3_full)	
			begin
				DDR3_empty 	<= 1'b1;
				state			<= done;
			end
			else
			begin
				memfifo_has_data	<= 1'b1;
				state					<= start;
			end
		end
   end
	
	start:
	begin
		if(memfifo_re_pulse)
		begin
			temp_data		<= temp_data + 2'b10;
			memfifo_rd_cnt	<= memfifo_rd_cnt + 1'b1;
			memfifo_cnt		<=	memfifo_cnt	+ 1'b1;
		end
		if ( memfifo_cnt == (MEM_BLOCK_SIZE[6:0]<<1) )
		begin
			memfifo_last_word	<= 1'b1;
			state					<= last;
		end	
	end
	
	last:
	begin
		memfifo_last_word	<= 1'b0;
		memfifo_has_data 	<= 1'b0;
		memfifo_cnt			<=	8'b0;
		state					<= idle;
	end

	done:
	begin
		ddr3_empty_cnt	<= ddr3_empty_cnt + 1'b1;
		if (ddr3_empty_cnt == 4'd7) 
		begin
			DDR3_empty 		<= 1'b0;
			state				<= idle;
		end
	end
	
	default:
	begin
		memfifo_has_data	<= 1'b0;
		memfifo_last_word	<= 1'b0;
		memfifo_cnt			<=	8'b0;
		memfifo_last_word	<= 1'b0;
		DDR3_empty			<= 1'b0;
		ddr3_empty_cnt		<= 4'b0;
		temp_data			<= 32'HFFFF_FFFE; // this makes it so the first count to be passed is 0!
		state					<= idle;
	end

	endcase
	
	end
end

assign memfifo_data 			= {(temp_data + 1'b1), temp_data};

endmodule

