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
// Title       : <pattern_gen_checker>
// Created     : <August 2017>
// Description : This module initilizes the memory with AXI interface with
//               different patterns and checks the memory against the 
//               selected pattern. It performs 256 beat burst AXI read/write 
//               operations  
//
// Hierarchy   :
//               pattern_gen_checker.v            <-- This module
//                           
//-------------------------------------------------------------------------

module fifo_mem_cntrl #(
    parameter [7:0]     BLOCK_DEPTH= 8'h80,     // DDR block depth (128 => 1kB)
    parameter [7:0]     BURST_LENGTH= 8'hFF,    // burst length of 256 beats (AXI defines number beats to pass to AWLEN/ARLEN as: no-of-beats-1 ) 
    parameter [1:0]     BURST_SIZE  = 2'b11     // 8 bytes for beat (AXI defines bit in a beat as: 2**BURST_SIZE)
) (
//global signals
 input              sysclk_i,
 input              resetn_i,

// input from/to FIFO_CONV
// input              FIFO_CONV_full,
 input              FIFO_CONV_empty,
 input      [63:0]  FIFO_CONV_DATA,
 input       [7:0]  FIFO_CONV_RDCNT,
 input       [7:0]  FIFO_CONV_WRCNT,
 output             FIFO_CONV_RE,

 output reg [63:0]  MEMFIFO_DATA,
 output reg         MEMFIFO_WE,
 //output             reset_DIGIFIFO,

//control signals
 input              fifo_read_mem_i,
 input              fifo_write_mem_i,
 input       [31:0] mem_address_i,
 input       [31:0] write_page_no,     // really the number of 1KB pages to be written to DDR3 memory
 input       [31:0] read_page_no,       //size in multiples of 1KB 
 
 output reg         fifo_read_done_o, 
 output reg         fifo_write_done_o,
 output reg         DDR3_full,          // this is true when no of 1kB pages written to DDR3 reaches WRITE_PAGE_NO until all are read out
 output             last_write,         // when number of 1KB-page written reaches WRITE_PAGE_NO
 output reg  [31:0] mem_wr_cnt,         // no. of 1KB pages written to DR3 memory
 output reg  [31:0] mem_rd_cnt,         // no. of 1KB pages read from DR3 memory 

 //AXI Master IF
 // Write Address Channel 
 output      [3:0]  awid_o,
 output reg  [31:0] awaddr_o, 
 output      [7:0]  awlen_o, 
 output      [1:0]  awsize_o, 
 output      [1:0]  awburst_o, 
 output reg         awvalid_o,  
 input              awready_i,  
 // Write Data Channel  
 output      [7:0]  wstrb_o,
 output reg         wlast_o,
 output reg         wvalid_o,
 output reg [63:0]  wdata_o, 
 input              wready_i, 	
 // Write Response Channel
 input      [3:0]   bid_i,
 input      [1:0]   bresp_i,  
 input              bvalid_i,	
 output             bready_o,
 // Read Address Channel 
 output     [3:0]   arid_o, 
 output reg [31:0]  araddr_o, 
 output     [7:0]   arlen_o, 
 output     [1:0]   arsize_o, 
 output     [1:0]   arburst_o, 
 output reg         arvalid_o, 
 input              arready_i, 
 // Read Data Channel
 input      [3:0]   rid_i,
 input      [63:0]  rdata_i, 
 input      [1:0]   rresp_i,
 input              rlast_i,
 input              rvalid_i,
 output reg         rready_o
 );


///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
//AXI write/read channel states
reg [2:0]  waddr_state;
reg [2:0]  wdata_state;
reg [2:0]  raddr_state;
reg [2:0]  rdata_state;
//AXI write burst,transaction counters
reg [7:0]  wburst_cnt;
reg [7:0]  wdburst_cnt;
reg [7:0]  wdata_cnt;
//registers for AXI write data
wire [63:0] wdata_int; 
//AXI read burst,transaction counters
reg [7:0] rdburst_cnt;
reg [7:0] rburst_cnt;

///////////////////////////////////////////////////////////////////////////////
// AXI state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]  axi_idle    =   3'b000,
                  axi_valid   =   3'b001,
                  axi_done    =   3'b010, axi_mem_read = 3'b010,
                  axi_next    =   3'b011, axi_pattern  = 3'b011; 

localparam [11:0]  BURST_OFFSET = (2**BURST_SIZE) * (BURST_LENGTH+1); // this is the offset for the next burst in units of bytes: burst length in beats x bytes per beat

//AXI fixed assignments
assign  awid_o    =   0;
assign  awlen_o   =   BURST_LENGTH;  
assign  awburst_o =   1;     //INCR burst
assign  awsize_o  =   BURST_SIZE; 
assign  wstrb_o   =   8'hFF; //number of bytes to write: all 1s for 8 bytes
assign  bready_o  =   1;     //AXI write response channel is always ready
assign  arid_o    =   0;
assign  arlen_o   =   BURST_LENGTH; 
assign  arburst_o =   1;     //INCR burst
assign  arsize_o  =   BURST_SIZE; //64-bit read


// read FIFO_CONV data in chunks of 128x64-bits (since BURST_LENGTH is passed as 127)
wire    [7:0]   wburst_no;
//assign          wburst_no = write_page_no;
// with one 1KB page to DDR3 at the time, we have to count the numbers of FIFO_MEM_WRITE_I
assign          wburst_no = 8'b1;


wire    reset;
assign  reset = ~resetn_i;

//
// DDR3 full logic:
//  - set by no.of 1KB pages fully written equal(programmable) WRITE_PAGE_NO
//  - reset by no.of 1KB pages read equal(programmable) WRITE_PAGE_NO
wire    resetn_DIGIFIFO;

always@(posedge sysclk_i, posedge reset)
begin
    if ( reset || reset_DIGIFIFO)                           DDR3_full <= 1'b0;
    //else if(mem_wr_cnt==write_page_no && fifo_write_done_o) DDR3_full <= 1'b1;
    else if(mem_wr_cnt==write_page_no_saved && fifo_write_done_o) DDR3_full <= 1'b1;
end

//assign last_write = (mem_wr_cnt==write_page_no);
assign last_write = (mem_wr_cnt==write_page_no_saved);


reg     DDR3_full_reg;
always@(posedge sysclk_i) 
begin 
   DDR3_full_reg <= DDR3_full;
end

wire    DDR3_full_reached;
assign  DDR3_full_reached = DDR3_full && ~DDR3_full_reg;

//
// Save changes in WRITE_PAGE_NO until DDR write is done, unless it is the very first value
reg         first_saved = 1'b0;
reg [31:0]	write_page_no_saved = 32'b0;
reg [31:0]	write_page_no_old = 32'b0;

always@(posedge sysclk_i, posedge reset)
begin
   if (reset) begin
      write_page_no_old     <= write_page_no;
      write_page_no_saved   <= write_page_no;
      first_saved           <= 1'b0;
   end
   else if (write_page_no != write_page_no_old) begin
      write_page_no_old     <= write_page_no;
// set  WRITE_PAGE_NO_SAVED for the first time so that DDR3_FULL logic can happen
      if (!first_saved)     write_page_no_saved   <= write_page_no;
      first_saved           <= 1'b1;
   end
   else if (DDR3_full_reached)  begin
      write_page_no_saved   <= write_page_no_old;
   end
end


//
// After the read is done, reset the value to compare the read page counter, in case it changed between memory reads.
reg [31:0]	write_page_no_reached;
always@(posedge sysclk_i, posedge reset)
begin
   if (reset)                   write_page_no_reached <= 32'b0;
//   else if (DDR3_full_reached)  write_page_no_reached <= write_page_no;
   else if (DDR3_full_reached)  begin
      write_page_no_reached <= write_page_no_saved;
//      write_page_no_saved   <= write_page_no_old;
   end
end

//
// Memory writes counter to decide write start address
// and when all memory 1kB pages have been written (ie DDR3_full has been reached)
always@(posedge sysclk_i, posedge reset)
begin
    if ( reset || reset_DIGIFIFO)       mem_wr_cnt <= 32'b0;
    else if(fifo_write_mem_i)           mem_wr_cnt <= mem_wr_cnt + 1'b1;
end

//
// Memory reads counter to decide read start adress
// and when all memory 1kB pages have been read
always@(posedge sysclk_i, posedge reset)
begin
//    if ( reset || reset_DIGIFIFO)       mem_rd_cnt <= 32'b0;
    if ( reset || reset_fifos)          mem_rd_cnt <= 32'b0;
    else if(fifo_read_mem_i)            mem_rd_cnt <= mem_rd_cnt + 1'b1;
end

//
// when all written memory pages are read out, generate reset to clear DDR3_full and written/read page no 
// Use falling edge of RESET_FIFOS, set for the duration of the last page read.
reg  reset_fifos, reset_fifos_reg;
always@(posedge sysclk_i, posedge reset)
begin
    if ( reset || fifo_read_done_o)         	                                reset_fifos     <= 1'b0;
//    else if(mem_rd_cnt == write_page_no_reached)	reset_fifos     <= 1'b1;
    else if(write_page_no_reached > 0 && mem_rd_cnt == write_page_no_reached)	reset_fifos     <= 1'b1;
end


always@(posedge sysclk_i) reset_fifos_reg <= reset_fifos;
assign  reset_DIGIFIFO = ~reset_fifos && reset_fifos_reg;

//
// Logic to control FIFO_CONV read enable:
// 1) write address seen and last write not received
// 2) write data confirmed
// 3) DDR3 not full   
reg     ENABLE_RD_FIFO;
always@(posedge sysclk_i, posedge wlast_o)
begin
    if ( reset || wlast_o)              ENABLE_RD_FIFO <= 1'b0;
    else if (awvalid_o && awready_i)    ENABLE_RD_FIFO <= 1'b1;
end
//assign FIFO_CONV_RE = (~FIFO_CONV_empty && wready_i && ENABLE_RD_FIFO); 
assign FIFO_CONV_RE = (~FIFO_CONV_empty && wready_i && ENABLE_RD_FIFO && ~DDR3_full); 



//write address channel
always@(posedge sysclk_i, posedge reset)
begin
   if(reset == 1'b1)
   begin
      awaddr_o               <=   0;
      awvalid_o              <=   0;
      wburst_cnt             <=   0;
      waddr_state            <=   axi_idle;
   end
   else
   begin

   case(waddr_state)

   //wait for memory init command/signal
   axi_idle:
   begin
//      awaddr_o                <=   mem_address_i;
      awaddr_o                <=   mem_address_i + BURST_OFFSET*mem_wr_cnt;
      wburst_cnt              <=   0;
//      if(fifo_write_mem_i) 
      if(fifo_write_mem_i && ~DDR3_full) 
// Start DDR3 write on FIFO_CONV having some data. 
// Stop when max. no of pages have been written.           
//      if(~FIFO_CONV_empty && ~DDR3_full)            
         waddr_state          <=  axi_valid;
   end

   //Initiate AXI write 
   axi_valid:
   begin            
      awvalid_o               <=  1'b1;
      if(awready_i)
      begin
         wburst_cnt           <=  wburst_cnt + 1'b1;
         waddr_state          <=  axi_done;   
      end
   end

   //wait for AXI write completion
   axi_done:
   begin
      awvalid_o               <=   1'b0;
      if(bvalid_i)
      begin
         //Address for next AXI write 
         awaddr_o             <=   awaddr_o  + BURST_OFFSET;
         waddr_state          <=   axi_next;
      end
   end

   //perform next AXI write if selected number of word from FIFO_CONV is reached
   //initialization is not completed
   axi_next:
   begin
      if(wburst_cnt == wburst_no)            
         waddr_state           <=   axi_idle;
      else
         waddr_state           <=   axi_valid;
   end
    
   default:
   begin
      waddr_state            <=   axi_idle;
   end

   endcase

   end
end

//write data channel     
always@(posedge sysclk_i, posedge reset)
begin
   if(reset == 1'b1)
   begin
      wlast_o                  <=   0;
      wvalid_o                 <=   0;
      wdata_o                  <=   0;
      fifo_write_done_o        <=   0;
      wdata_cnt                <=   0;
      wdburst_cnt              <=   0;
      wdata_state              <=   axi_idle;
   end
   else
   begin
    
   case(wdata_state)

   //wait for AXI IF ready
   axi_idle:
   begin
      wdata_o                  <=   64'b0;
      wdburst_cnt              <=   0;
      wdata_cnt                <=   0;
      fifo_write_done_o        <=   1'b0;
      if(awvalid_o && awready_i) 
      begin
         wdata_state <=   axi_valid;
      end
   end


   //perform AXI burst write
   axi_valid:
   begin        
	  fifo_write_done_o     <=   1'b0;
//      wvalid_o              <=   1'b1;
// must prevent further AXI writes if FIFO_CONV is starved...
      if(~FIFO_CONV_empty)
      begin
         wvalid_o              <=   1'b1;

         if(wready_i)
// this generate lost writes!! If WVALID is issued, WREADY must be listened to!
//      if(wready_i && ~FIFO_CONV_empty)
         begin
            wdata_cnt          <=   wdata_cnt + 1'b1;
            wdata_o            <=   FIFO_CONV_DATA;

            if(wdata_cnt == BURST_LENGTH)
            begin
               wlast_o         <=   1'b1;
               wdburst_cnt     <=   wdburst_cnt + 1'b1;
               wdata_state     <=   axi_done;
            end
		 
         end
      end
   end      // axi_valid state

   //generate memory initialization complete
   axi_done:
   begin 
      if(wready_i)
      begin
         wvalid_o              <=   1'b0;
         wlast_o               <=   1'b0;
         wdata_cnt             <=   0;   // MT added for multiple bursts
		 wdata_o               <=    wdata_o;
         if(wdburst_cnt == wburst_no)
         begin
            fifo_write_done_o  <=   1'b1;
            wdata_state        <=   axi_idle;
         end
         else
		 begin
            fifo_write_done_o  <=   1'b0;
            wdata_state        <=   axi_next;
		 end
      end
   end

   //next AXI burst write operation
   axi_next:
   begin
      if(awvalid_o)
         wdata_state           <=   axi_valid;
   end

   default:
   begin
      wdata_state              <=   axi_idle;
   end

   endcase

   end
end


//read address channel
always@(posedge sysclk_i, posedge reset)
begin
   if(reset == 1'b1)
   begin
      araddr_o                 <=   0;
      arvalid_o                <=   0;
      rburst_cnt               <=   0;
      raddr_state              <=   axi_idle;
   end
   else
   begin
    
   case(raddr_state)
   
   //start AXI burst read operation
   axi_idle:
   begin
      rburst_cnt               <=   0;
//      araddr_o                 <=   mem_address_i;
      araddr_o                 <=   mem_address_i + BURST_OFFSET*mem_rd_cnt;
      if(fifo_read_mem_i)
         raddr_state           <=   axi_valid;
   end

   //monitor read memory count
   axi_valid:
   begin
      arvalid_o                <=   1'b1;
      if(arready_i)
      begin
         rburst_cnt            <=   rburst_cnt + 1'b1;
         raddr_state           <=   axi_done;   
     end
   end

   //next AXI read operation
   axi_done:
   begin
      arvalid_o                 <=   1'b0;      
      if(rburst_cnt == read_page_no)            
         raddr_state            <=   axi_idle;
      else if(rvalid_i && rlast_i)
      begin
         // Address for next AXI write
         araddr_o               <=   araddr_o + BURST_OFFSET;
         raddr_state            <=   axi_valid;
      end
   end

   default:
   begin
      raddr_state               <=   axi_idle;
   end

   endcase
end
end

//read data channel
always@(posedge sysclk_i, posedge reset)
begin
   if(reset == 1'b1)
   begin
      rready_o                  <=   0;
      rdburst_cnt               <=   0;
      fifo_read_done_o          <=   0;
      MEMFIFO_DATA              <=   64'b0;
      MEMFIFO_WE                <=   0; 
      rdata_state               <=   axi_idle;
   end
   else
   begin

   case(rdata_state)

   //start memory test
   axi_idle:
   begin        
      rdburst_cnt               <=   1'b0;      
      fifo_read_done_o          <=   1'b0;
	  MEMFIFO_DATA        	    <=   {64{1'b1}};
      MEMFIFO_WE                <=   1'b0; 
      if(fifo_read_mem_i)  //memory pattern check
      begin         
         rready_o               <=   1'b0;
         rdata_state            <=   axi_pattern; // maybe can skip??
      end
   end

   //initial data as per pattern
   axi_pattern:
   begin
      rready_o                  <=   1'b1;
	  MEMFIFO_DATA      		<=   rdata_i;
	  MEMFIFO_WE          		<=   1'b0; 
      rdata_state               <=   axi_valid;
   end

   //check AXI read data against selected pattern
   axi_valid:
   begin
      if(rdburst_cnt == read_page_no)
      begin
         fifo_read_done_o       <=   1'b1;
         rdata_state            <=   axi_idle;
      end
      else
      begin
         if(rvalid_i)
         begin
			MEMFIFO_DATA        <=   rdata_i;
			MEMFIFO_WE          <=   1'b1; 
         end
		 else
			MEMFIFO_WE          <=   1'b0; 		 
      end
      if(rlast_i && rvalid_i)
         rdburst_cnt            <=   rdburst_cnt + 1'b1;
   end

   default:
   begin
      rdata_state               <=   axi_idle;
   end

   endcase

   end
end

endmodule