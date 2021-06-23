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
//               selected pattern. It performs 256 beat burst AXI read/write operations 
//                 
//      v2.0 MT	02/2021	Added pseudo-andon pattern as as pattern 3
//                        	Added hold on awvalid=1 or arvalid=1 if trying to do someting on an address actively being read or written
//      v3.0 MT	03/2021	Added timer and error FIFOs 
//      v4.0 MT 04/2021 Added prgrammable first data block to write to TPSRAM
//
				
// Hierarchy   :	pattern_gen_checker.v            <-- This module
//                           
//-------------------------------------------------------------------------

module pattern_gen_checker #(
//    parameter [7:0]     BURST_LENGTH= 8'hFF,    // burst length of 256 beats (AXI defines number beats to pass to AWLEN/ARLEN as: no-of-beats-1 )
    parameter [1:0]     BURST_SIZE  = 2'b11     // 8 bytes for beat (AXI defines bit in a beat as: 2**BURST_SIZE)
) (
//global signals
 input		clk_i,
 input		resetn_i,

// mem ctrl input signals
 input			pattern_en   /*synthesis syn_preserve=1 */, 	// if 0: PATTERN_GENERATOR and DIGIFIFo send to DDR3; 
																				// if 1: PATTERN_FIFO send to DDR3  
 input [1:0]	pattern_i,		//pattern generator type: 0=>+1, 1=>-1, 2=>A's,  3=>5's
 input			mem_write_i,	// same as mem_init_i
 input			mem_read_i,
 input			mem_test_i,
 input [31:0]	mem_offset,		// maximum number of starting memory address in units of block size
										// for smallest block-zise( or BURST_LENGHT=0x3 => 4x64-bits = 256 bits blocks ), it is calculated as 
										// 		1GB (2**30) of addresses for 8GB data => 2**27 starting address for 64-bit beats (0, 8, 16...)
										// 2**25 max no. of starting address for BURST_LENGHT=0x3 => 16x64-bits = 1/8 kb blocks (or addr. 0x0, 0x20, 0x40, 0x60...)
										// 2**23 max no. of starting address for BURST_LENGHT=0xF => 16x64-bits = 1kb blocks    (or addr. 0x0, 0x80, 0x100, 0x180...)
										// 2**20 max no. of starting address for BURST_LENGHT=0x7F => 128x64-bits = 1kB blocks  (or addr. 0x0, 0x200, 0x400, 0x600...)
										// 2**19 max no. of starting address for BURST_LENGHT=0xFF => 256x64-bits = 2kB blocks  (or addr. 0x0, 0x400, 0x800, 0xC00...)
 input [31:0]	loc_offset,		// this is in units of AXI-bursts and thus an absolute number for a given memory size once BURST_SIZE is set:
                              //  ex: in 8 Gb memory, there are 1Gb address but 1Gb/8 memory location offsets for 8 byte AXI-burst
										// Used to program the starting address of the DDR3 read-data to be save in TPSRAM
// mem size input signals
 input [7:0]	BURST_LENGTH,	// burst lenght in unit of beats. Determine block size. 
										//		ex: 0xFF => 256x(2**BURST_SIZE)bytes = 2**11 = 2 kB
										// Other examples (assuming BURST_SIZE=3):  
										//		0x7F => 128 => 1 kB;  0xF => 16x8 bytes = 2**7 bytes = 1 kb;   0x3 => 4x64 bits = 256 bits
 input [31:0]	hit_no,			// number of block reads/writes (in units of block size)
										// memory block size is determined by BURST_OFFSET: 
										//    ex: BURST_SIZE=3 (8-byte/beat) and BURST_LENGTH=127 (128-beat burst)
										//		 	corresponds to AXI burst size of 8Kb or 1KB (=> 128 beats x 64 bits/beat)

 output reg  [31:0] mem_err_cnt,  	// memory errors counter   
 input              fifo_clk,
 input              write_ren,
 input              read_ren,
 input              err_ren,
 input              ram_ren,
 output	 			  write_full, 
 output             write_empty,
 output				  read_full,
 output				  read_empty,
 output[31:0] 		  write_out,
 output[31:0] 		  read_out,
 output 				  error_full, 
 output				  error_empty,
 output[31:0]  	  error_out,
 output				  true_full, 	
 output				  true_empty,
 output 				  expc_full, 	
 output				  expc_empty,
 output[63:0]  	  true_out, 	
 output[63:0]  	  expc_out,

 input      [31:0]  ram_addr_i, 	//to read from RAM latest DDR read values
 output     [31:0]  ram_data_o, 	//RAM data to serial

 output reg [31:0]	wrb_cnt,  // contains DDR WR-data burst counter, until reset or state machine leaving idle on new MEM_WRITE_I
 output reg [31:0]	rdb_cnt,  // contains DDR RD-data burst counter, until reset or state machine leaving idle on new MEM_TEST_I

 //AXI Master IF
 // Write Address Channel 
 output		[3:0]	awid_o, 
 output reg	[31:0]awaddr_o, 
 output		[7:0]	awlen_o, 
 output		[1:0]	awsize_o, 
 output		[1:0]	awburst_o, 
 output reg			awvalid_o,  
 input				awready_i,  
 // Write Data Channel  
 output		[7:0]	wstrb_o,
 output reg			wlast_o,
 output reg			wvalid_o,
 output reg [63:0]wdata_o, 
 input        		wready_i, 	
 // Write Response Channel
 input		[3:0]	bid_i,
 input		[1:0]	bresp_i,  
 input				bvalid_i,	
 output				bready_o,
 // Read Address Channel 
 output		[3:0]	arid_o, 
 output reg	[31:0]araddr_o, 
 output		[7:0]	arlen_o, 
 output		[1:0]	arsize_o, 
 output		[1:0]	arburst_o, 
 output reg			arvalid_o, 
 input				arready_i, 
 // Read Data Channel
 input		[3:0]	rid_i,
 input		[63:0]rdata_i, 
 input		[1:0]	rresp_i,
 input				rlast_i,
 input				rvalid_i,
 output reg			rready_o
 );

///////////////////////////////////////////////////////////////////////////////
// pattern types
///////////////////////////////////////////////////////////////////////////////
// 0. Incremental
// 1. Decremental
// 2. A's & 5's
// 3. 32-bit  PRBS

///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
//AXI write/read channel states
reg [2:0]	waddr_state;
reg [2:0]	wdata_state;
reg [2:0]	raddr_state;
reg [2:0]	rdata_state;
//AXI write burst,transaction counters
reg [31:0]	wburst_cnt;
reg [31:0]	wdburst_cnt;
reg [7:0]	wdata_cnt;
//registers for AXI write data
wire [63:0] wdata_int; 
reg [32:0]	wdata_int_u /* synthesis syn_preserve=1 */; 
reg [32:0]	wdata_int_l /* synthesis syn_preserve=1 */;
//registers for comparing AXI read data
reg [63:0]	rdata_int;
reg [32:0]	rdata_int_u /* synthesis syn_preserve=1 */;
reg [32:0]	rdata_int_l /* synthesis syn_preserve=1 */;
reg [31:0]	int_loc;		// this is in units of AXI-bursts (or ++2**BURST_SIZE address/burst) 
								//    ie range for 8 Gb memory: 0 - 0x800_0000
								// Used to report error location
//AXI wriread burst,transaction counters
reg [31:0]	rdburst_cnt;
reg [31:0]	rburst_cnt;
//to buffer AXI read data
reg [63:0]	wdata_ram;
reg [7:0]	waddr_ram;
reg			wen_ram;
reg			ram_start, ram_full;
// other misc logic
reg			err_wen;
reg			rlast_pulse;

// this generates a data offset to make the pattern unique for every block, counting for the address offset 
//    BURST_LENGHT + 1 has to be doubled because the 64-bits in every transaction are the concatenations of two 32-bit counters
wire [31:0]	offset_data;
assign		offset_data	=	mem_offset*(BURST_LENGTH+1)*2;   

// this generate an address offset for each data burst
wire [31:0]	offset_addr;
assign		offset_addr	=	mem_offset*BURST_OFFSET;           

///////////////////////////////////////////////////////////////////////////////
// AXI state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]  axi_idle		=	3'b000,
                  axi_valid	=	3'b001,
                  axi_done		=	3'b010,	axi_mem_read	=	3'b010,
                  axi_next		=	3'b011,	axi_pattern		=	3'b011; 

// MEMORY fixed assignments: this is the offset for the next burst in units of bytes: burst length in beats x bytes per beat
// this generates a 0x400(0x20) offset to make the data unique every 1kB page(256-bit hit), ie 1024(32) in units of memory address)
//localparam [11:0]  BURST_OFFSET = (2**BURST_SIZE) * (BURST_LENGTH+1);	// fails if an input
wire [31:0] BURST_OFFSET;
assign      BURST_OFFSET = (2**BURST_SIZE) * (BURST_LENGTH+1); 

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

assign wdata_int = {wdata_int_u[31:0],wdata_int_l[31:0]};

reg         mem_write_done_o; 	// pulse signalling end of DDR Write speed test
reg         mem_read_done_o;  	// pulse signalling end of DDR Read-only speed test 
reg         mem_test_done_o;		// pulse signalling end of DDR Read in simultaneous DDR WR&RD speed test
reg         mem_test_err_o;		// pulse signalling DDR read error

// errors measurements
reg [31:0]	error_data;
reg [63:0]	true_data,	expc_data;
//
// timer for timing measurements
reg [31:0] 	timer;
reg [31:0] 	write_timer, read_timer;

always@(posedge clk_i, negedge resetn_i)
begin
   if(resetn_i == 1'b0) 										timer <= 0;
   else if (mem_write_i || mem_test_i || mem_read_i) 	timer <= 0;
	else																timer <= timer + 1'b1;
end

//
// PRBG pattern: x**32+x**22+x**2+x**1+1 polinomial with max length 429,496,265 states
reg [31:0] 	wr_prbg, rd_prbg;
wire 			w1, w2, w3;
wire 			r1, r2, r3;
assign	w1 = 	wr_prbg[31]^wr_prbg[21];
assign	w2 =  			w1^wr_prbg[1];
assign	w3 =  			w2^wr_prbg[0];
assign	r1 = 	rd_prbg[31]^rd_prbg[21];
assign	r2 =  			r1^rd_prbg[1];
assign	r3 =  			r2^rd_prbg[0];

//write address channel
always@(posedge clk_i, negedge resetn_i)
begin
   if(resetn_i == 1'b0)
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
      awaddr_o                <=   offset_addr;
      wburst_cnt              <=   0;
      if(mem_write_i && pattern_en == 1'b0)             
         waddr_state          <=  axi_valid;
   end

   //Initiate AXI write 
   axi_valid:
   begin 
		// either not same RD/WR address or RADDR state machine if waiting is waiting to make "arvalid" decision
		if ( (awaddr_o != araddr_o) || (raddr_state == axi_idle || raddr_state == axi_valid) ) 
		begin
			awvalid_o               <=  1'b1;
			if(awready_i)
			begin
				wburst_cnt           <=  wburst_cnt + 1'b1;
				waddr_state          <=  axi_done;   
			end
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

   //perform next AXI write if selected memory size 
   //initialization is not completed
   axi_next:
   begin
      if(wburst_cnt == hit_no)            
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
always@(posedge clk_i, negedge resetn_i)
begin
   if(resetn_i == 1'b0)
   begin
      wlast_o					<=	0;
      wvalid_o					<=	0;
      wdata_o					<=	0;
      mem_write_done_o		<=	0;
      wdata_cnt				<=	0;
      wdburst_cnt				<=	0;
      wrb_cnt					<=	0;
		wr_prbg 					<= 1;
      wdata_state 			<=	axi_idle;
   end
   else
   begin
    
   case(wdata_state)

   //wait for AXI IF ready
   axi_idle:
   begin
      wdata_o				<=	wdata_int;
      wdburst_cnt			<=	0;
      wdata_cnt			<=	0;
      mem_write_done_o	<=	1'b0;
		wr_prbg				<= 1;
		write_timer			<= 0;
      if(awvalid_o && awready_i && pattern_en == 1'b0) 
         wdata_state		<=   axi_valid;
   end

   //perform AXI burst write
   axi_valid:
   begin        
		wrb_cnt				<= wdburst_cnt;
      mem_write_done_o	<=	1'b0;
      wvalid_o				<=	1'b1;
      if(wready_i)
      begin
         wdata_cnt		<=   wdata_cnt + 1'b1;
         if(wdata_cnt == BURST_LENGTH)
         begin
            wlast_o			<=   1'b1;
            wdburst_cnt		<=   wdburst_cnt + 1'b1;
				write_timer		<=   timer;
            wdata_state		<=   axi_done;
         end
		 
         if(pattern_i == 2'b00)//incremental data
         begin
             wdata_o[63:32]	<=    wdata_o[63:32] + 2'b10;
             wdata_o[31:0]		<=    wdata_o[31:0]  + 2'b10;
         end
         else if(pattern_i == 2'b01)//decremental data
         begin
             wdata_o[63:32]	<=    wdata_o[63:32] - 2'b10;
             wdata_o[31:0]		<=    wdata_o[31:0]  - 2'b10;
         end
         else if(pattern_i == 2'b10)//alternate A's & 5's
         begin
             wdata_o				<=    (wdata_o << 1);
             if (wdata_o[0]==0) 		wdata_o[0]	<=	1'b1;
         end
			else if(pattern_i == 2'b11)  // 32-bit PRBS
         begin
             wdata_o[63:32]	<=	wr_prbg;
             wdata_o[31:0]		<= wr_prbg;
             wr_prbg				<=	{w3, wr_prbg[31:1]};
         end
      end  
   end      // axi_valid state

   //generate memory initialization complete
   axi_done:
   begin 
		wrb_cnt						<= wdburst_cnt;
      if(wready_i)
      begin
         wvalid_o              <=   1'b0;
         wlast_o               <=   1'b0;
         wdata_cnt             <=   0;   // MT added for multiple bursts
         if(wdburst_cnt == hit_no)
         begin
            mem_write_done_o   <=   1'b1;
            wdata_state        <=   axi_idle;
         end
         else
            wdata_state        <=   axi_next;
      end
   end

   //next AXI burst write operation
   axi_next:
   begin
		wrb_cnt				<= wdburst_cnt;
      if(awvalid_o)
         wdata_state		<=   axi_valid;
   end

   default:
   begin
      wdata_state			<=   axi_idle;
   end

   endcase

   end
end

///////////////////////////////////////////////////////////////////////////////
//pattern selection
// 0 Incremental
// 1 Decremental
// 2 All A's
// 3 All 5's
///////////////////////////////////////////////////////////////////////////////
always@(posedge clk_i, negedge resetn_i)
begin
   if(resetn_i == 1'b0)
   begin
      wdata_int_u		<=	0;
      wdata_int_l		<=	0;
   end
   else
   begin
      case(pattern_i)

      2'h0://incremental
      begin
         wdata_int_u		<=   offset_data - 1'b1;
         wdata_int_l		<=   offset_data - 2'b10;
      end

      2'h1://decremental. Start from maximum count. Remember we use a 32-bit counters, ie a beat of 64 bits has 2 counts!! 
      begin
         wdata_int_u		<=   33'h1_0000_0000 - offset_data;
         wdata_int_l		<=   33'h1_0000_0001 - offset_data;
      end

      2'h2:		// alternating A'5 and 5': start with A's
      begin
         wdata_int_u[31:0]     <=   {8{4'hA}};
         wdata_int_l[31:0]     <=   {8{4'hA}};
      end

      2'h3:  //  pseudo-random bit generator seed
      begin
         wdata_int_u		<=	1;
         wdata_int_l		<=	1;
      end
				
      default:
      begin
         wdata_int_u		<=	0;
         wdata_int_l		<=	0;
      end

      endcase
   end
end

//read address channel
always@(posedge clk_i, negedge resetn_i)
begin
   if(resetn_i == 1'b0)
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
      araddr_o                 <=   offset_addr;
      if((mem_test_i || mem_read_i) && pattern_en == 1'b0)
         raddr_state           <=   axi_valid;
   end

   //monitor read memory count
   axi_valid:
   begin
		// either not same RD/WR address or WADDR state machine is waiting to make "awvalid" decision
		if ( (awaddr_o != araddr_o) || (waddr_state == axi_idle || waddr_state == axi_valid) ) 
		begin
			arvalid_o				<=	1'b1;
			if(arready_i)
			begin
				rburst_cnt			<=	rburst_cnt + 1'b1;
				raddr_state			<=	axi_done; 
			end
     end
   end

   //next AXI read operation
   axi_done:
   begin
      arvalid_o                 <=   1'b0;      
      if(rburst_cnt == hit_no)            
         raddr_state            <=   axi_idle;
      else if(rvalid_i && rlast_i)
      begin
         //Address for next AXI write														  
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
always@(posedge clk_i, negedge resetn_i)
begin
   if(resetn_i == 1'b0)
   begin
      rdata_int			<=	0;
      rdata_int_u			<=	0;
      rdata_int_l			<=	0;
      rready_o				<=	0;
      rdburst_cnt			<=	0;
		rdb_cnt				<= 0;
      mem_test_err_o 	<=	0;
      mem_test_done_o 	<=	0;
      mem_read_done_o 	<=	0;
      int_loc 				<=	0;    
      waddr_ram 			<=	0;
      wdata_ram 			<=	0;
      wen_ram 				<=	0; 
      err_wen 				<=	0; 
      mem_err_cnt 		<=	0;    
      error_data	 		<=	0;
      expc_data	 		<=	0;
      true_data 			<=	0;
		rlast_pulse			<= 0;
		read_timer			<= 0;
		rd_prbg 				<= 32'h8000_0000;  // next random pattenr if seed = 1
      rdata_state			<=	axi_idle;
   end
   else
   begin

   case(rdata_state)

   //start memory test
   axi_idle:
   begin        
      rdburst_cnt			<=	0;      
		rready_o				<=	1'b0;
      mem_read_done_o	<=	0;
      mem_test_done_o	<=	0;
      mem_test_err_o		<=	0;
      int_loc 				<=	0;
      waddr_ram			<=	{8{1'b1}};//RAM last location
      wen_ram 				<=	0;       
		ram_start 			<= 0;
		ram_full 			<= 0;
      err_wen  			<=	0;       
		rlast_pulse			<= 0;
		read_timer			<= 0;
		rd_prbg 				<= 32'h8000_0000;  // next random pattenr if seed = 1
		
      if(mem_test_i && pattern_en == 1'b0)//memory pattern check
      begin         
         //rready_o		<=   1'b0;  // moved out of IF and set high on next state
         rdata_state		<=   axi_pattern;
         if(pattern_i == 2'b00)//incremental
         begin
            rdata_int_u	<= wdata_int[63:32] + 2'b10;
            rdata_int_l	<= wdata_int[31:0]  + 2'b10;
         end
         else if(pattern_i == 2'b01)//decremental
         begin
            rdata_int_u	<=	wdata_int[63:32] - 2'b10;
            rdata_int_l	<=	wdata_int[31:0]  - 2'b10;
         end
         else if(pattern_i == 2'b10)//alternating A's and 5's: starts with 5's to have A's to compare first
         begin
				rdata_int_u[31:0]	<=	{8{4'h5}};
				rdata_int_l[31:0]	<=	{8{4'h5}};
         end
         else if(pattern_i == 2'b11)//pseudo-random pattern: start at first pattern after seed 
         begin
				rdata_int_u[31:0]	<= 1;
				rdata_int_l[31:0]	<= 1;
			end
      end
// MT added for READ ONLY in simultaneous RD/WR (skipping pattern test)
      else if (mem_read_i)  		//memory read only
      begin
         //rready_o			<=   1'b1;  // moved out of IF and set high on next state
         rdata_state			<=   axi_mem_read;
      end
   end

   //initial data as per pattern
   axi_pattern:
   begin
		rdb_cnt				<=	rdburst_cnt;
      rready_o				<=	1'b1;
      rdata_int[63:32]	<=	rdata_int_u[31:0];
      rdata_int[31:0]	<=	rdata_int_l[31:0];
      rdata_state 		<=	axi_valid;
   end

   //check AXI read data against selected pattern
   axi_valid:
   begin
		rdb_cnt				<= rdburst_cnt;		
      if(rdburst_cnt == hit_no)
      begin
         mem_test_done_o	<=	1'b1;
			err_wen				<=	1'b0;
         rdata_state			<=	axi_idle;
      end
      else
      begin
         if(rvalid_i)
         begin
				int_loc		<=	int_loc + 1'b1;
				
				// just keep track of errors
            if(rdata_i != rdata_int)
            begin
               mem_test_err_o	<=	1'b1;
					error_data		<=	int_loc;
					expc_data		<=  rdata_int;
					true_data		<=  rdata_i;
					err_wen			<=	1'b1;
            end
				else  
				begin
					mem_test_err_o	<=	1'b0;
					err_wen			<=	1'b0;
				end	
				
            if(pattern_i == 2'b00)//incremental
            begin
                rdata_int[63:32]	<=	rdata_int[63:32] + 2'b10;
                rdata_int[31:0]	<=	rdata_int[31:0]  + 2'b10;
            end
            else if(pattern_i == 2'b01)//decremental
            begin
                rdata_int[63:32]	<=	rdata_int[63:32] - 2'b10;
                rdata_int[31:0]	<=	rdata_int[31:0]  - 2'b10;
            end
            else if(pattern_i == 2'b10)//alternate 5's and A's
				begin
					rdata_int[63:32]	<=	(rdata_int[63:32]<<1);
					rdata_int[31:0]	<=	(rdata_int[31:0]<<1);
					if (rdata_int[32]==0)	rdata_int[32] <= 1'b1;
					if (rdata_int[0]==0)		rdata_int[0]  <= 1'b1;
				end
				else if(pattern_i == 2'b11)//pseudo-random pattern
				begin
					rdata_int[63:32]	<=	rd_prbg;
					rdata_int[31:0]	<=	rd_prbg;
					rd_prbg			 	<= {r3, rd_prbg[31:1]};
				end
            //else    
				//rdata_int		<=	rdata_int;

				// write to TPSRAM 256x64-bit data starting at a specific address until full
				// do not use ARADDR because "raddr_state" will go back to IDLE (and zero ARADDR) before
			   // the "rdata_state" machine kicks in	
				if ( int_loc >= loc_offset && ram_full == 1'b0 ) 
				begin
				   ram_start		<= 1'b1;	
					wdata_ram		<=	rdata_i;
					waddr_ram		<=	waddr_ram + 1;
					wen_ram      	<=	1'b1;
					if (ram_start == 1'b1 && waddr_ram == 8'HFE) ram_full <= 1'b1;
				end				

         end
         else  // rvalid_i=0
			begin
            wen_ram			<=	1'b0;
            err_wen			<=	1'b0;
			end
      end

      if(rlast_i && rvalid_i)
		begin
			rlast_pulse		<= 1;
			read_timer		<= timer;
			rdburst_cnt		<=	rdburst_cnt + 1'b1;
		end
		else // rvalid_i=0 or rlast_i=0
			rlast_pulse		<= 0;
   end

   //read memory only (without checking pattern)
   axi_mem_read:
   begin
		rdb_cnt				<=	rdburst_cnt;
      rready_o				<=   1'b1;		
      if(rdburst_cnt == hit_no)
      begin
         mem_read_done_o<=	1'b1;
         rdata_state		<=	axi_idle;
      end
		
      if(rlast_i && rvalid_i)
		begin
			rlast_pulse		<= 1;
			read_timer		<=	timer;
			rdburst_cnt		<=	rdburst_cnt + 1'b1;
		end
		else 
			rlast_pulse		<= 0;
   end

   default:
   begin
      rdata_state	<=   axi_idle;
   end

   endcase

   end
end


//4k dual-port LSRAM to store DDR read data and read-back via CORTEX
TPSRAM tpsram_0(
    // Inputs
    .R_ADDR(ram_addr_i[8:0]),
    .R_CLK(fifo_clk),
    .R_EN(ram_ren),
    .W_ADDR(waddr_ram),
    .W_CLK(clk_i),
    .W_DATA(wdata_ram),
    .W_EN(wen_ram),
    // Outputs
    .R_DATA(ram_data_o)
);

// instantiate FIFO for time of DDR WRITE transaction, 32b x 1024
WRITE_FIFO write_fifo_0(
    // Inputs
	 .DATA(write_timer), 		// [31:0]
	 .RCLOCK(fifo_clk),
	 .RE(write_ren),
	 .RESET(resetn_i),			// neg. logic
	 .WCLOCK(clk_i),
	 .WE(wlast_o),
	 //Output
	 .EMPTY(write_empty),
	 .FULL(write_full),
	 .Q(write_out)				// [31:0]
);
	 
// instantiate FIFO for time of DDR READ transaction, 32b x 1024
READ_FIFO read_fifo_0(
    // Inputs
	 .DATA(read_timer), 		// [31:0]
	 .RCLOCK(fifo_clk),
	 .RE(read_ren),
	 .RESET(resetn_i),			// neg. logic
	 .WCLOCK(clk_i),
	 .WE(rlast_pulse),
	 //Output
	 .EMPTY(read_empty),
	 .FULL(read_full),
	 .Q(read_out)				// [31:0]
);

// instantiate FIFO for DATA READ from DDR when error is observed, 64b x 1024
DATA_TRUE data_true_0(
    // Inputs
	 .DATA(true_data), 		// [63:0]
	 .RCLOCK(fifo_clk),
	 .RE(err_ren),
	 .RESET(resetn_i),			// neg. logic
	 .WCLOCK(clk_i),
	 .WE(err_wen),
	 //Output
	 .EMPTY(true_empty),
	 .FULL(true_full),
	 .Q(true_out)				// [63:0]
);

// instantiate FIFO for DATA EXPECTED from DDR when error is observed, 64b x 1024
DATA_EXPC data_expc_0(
    // Inputs
	 .DATA(expc_data), 		// [63:0]
	 .RCLOCK(fifo_clk),
	 .RE(err_ren),
	 .RESET(resetn_i),			// neg. logic
	 .WCLOCK(clk_i),
	 .WE(err_wen),
	 //Output
	 .EMPTY(expc_empty),
	 .FULL(expc_full),
	 .Q(expc_out)				// [63:0]
);

// instantiate FIFO for location error (addr/8) of DDR when error is observed, 32b x 1024
DATA_ERR data_err_0(
    // Inputs
	 .DATA(error_data), 		// [31:0]
	 .RCLOCK(fifo_clk),
	 .RE(err_ren),
	 .RESET(resetn_i),			// neg. logic
	 .WCLOCK(clk_i),
	 .WE(err_wen),
	 //Output
	 .EMPTY(error_empty),
	 .FULL(error_full),
	 .Q(error_out),	 // [31:0]
	 .WRCNT(mem_err_cnt[10:0])  // [10:0]
);

endmodule