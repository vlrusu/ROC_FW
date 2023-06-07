///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pattern_gen_checker.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Title       : <pattern_gen_checker>
// Created     : <August 2017>
// Description : This module initilizes the memory with AXI interface with
//               different patterns and checks the memory against the 
//               selected pattern. It performs 256 beat burst AXI read/write 
//               operations  
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG484>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pattern_gen_checker #(
    parameter [7:0]     BURST_LENGTH= 8'h7F,    // burst length of 128 beats (AXI defines number beats to pass to AWLEN/ARLEN as: no-of-beats-1 ) 
    parameter [1:0]     BURST_SIZE  = 2'b11     // 8 bytes for beat (AXI defines bit in a beat as: 2**BURST_SIZE)
) (
//global signals
 input  clk_i,
 input  resetn_i,

 // from Register module 
 input  mem_wr_en    /*synthesis syn_preserve=1 */,  // to start WR to memory (either DDR3 or SRAM)
 input  mem_rd_en    /*synthesis syn_preserve=1 */,  // to start RD to memory (either DDR3 or SRAM)

//mem test signals
 input      [31:0]  blk_no_i,       // memory block size in multiples of BURST_OFFSET
 input       [1:0]  pattern_i,      //pattern generator type: 0=>+1, 1=>-1, 2=>A's,  3=>5's
 input      [31:0]  mem_start,      // memory offset (in units of BURST_OFFSET*BLK_SIZE)
 output reg         mem_write_done_o, 
 output reg         mem_read_done_o,
 output reg         mem_test_err_o,
 output reg  [31:0] err_loc_o, 
 output reg  [31:0] error_cnt_o, 

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
// pattern types
///////////////////////////////////////////////////////////////////////////////
// 0. Incremental
// 1. Decremental
// 2. All A's
// 3. All 5's

///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
//AXI write/read channel states
reg [2:0]  waddr_state;
reg [2:0]  wdata_state;
reg [2:0]  raddr_state;
reg [2:0]  rdata_state;
//AXI write burst,transaction counters
reg [31:0] wburst_cnt;
reg [31:0] wdburst_cnt;
reg [7:0]  wdata_cnt;
//registers for AXI write data
wire [63:0] wdata_int; 
reg [32:0] wdata_int_u /* synthesis syn_preserve=1 */; 
reg [32:0] wdata_int_l /* synthesis syn_preserve=1 */;
//registers for comaparing AXI read data
reg [63:0] rdata_int;
reg [32:0] rdata_int_u /* synthesis syn_preserve=1 */;
reg [32:0] rdata_int_l /* synthesis syn_preserve=1 */;
reg [31:0] err_int_loc;
//AXI wriread burst,transaction counters
reg [31:0] rdburst_cnt;
reg [31:0] rburst_cnt;

///////////////////////////////////////////////////////////////////////////////
// AXI state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]  axi_idle    =   3'b000,
                  axi_valid   =   3'b001,
                  axi_done    =   3'b010, axi_mem_read = 3'b010,
                  axi_next    =   3'b011, axi_pattern  = 3'b011; 


//AXI fixed assignments
assign  awid_o    =   0;
//assign  awlen_o   =   8'hFF; //256 burst length
assign  awlen_o   =   BURST_LENGTH;  
assign  awburst_o =   1;     //INCR burst
//assign  awsize_o  =   2'b11; //64-bit write
assign  awsize_o  =   BURST_SIZE; 
assign  wstrb_o   =   8'hFF; //number of bytes to write: all 1s for 8 bytes
assign  bready_o  =   1;     //AXI write response channel is always ready
assign  arid_o    =   0;
//assign  arlen_o   =   8'hFF; //256 burst length
assign  arlen_o   =   BURST_LENGTH; 
assign  arburst_o =   1;     //INCR burst
//assign  arsize_o  =   2'b11; //64-bit read
assign  arsize_o  =   BURST_SIZE; //64-bit read

assign wdata_int = {wdata_int_u[31:0],wdata_int_l[31:0]};

// MEMORY fixed assignments
localparam [11:0]  BURST_OFFSET = (2**BURST_SIZE) * (BURST_LENGTH+1); // this is the offset for the next burst in units of bytes: burst length in beats x bytes per beat

//make commands into pulses
reg     mem_wr_en_reg, mem_rd_en_reg;
reg     mem_wr_en_del, mem_rd_en_del;
wire    mem_init_i, mem_test_i;

always@(posedge clk_i)
begin
    mem_wr_en_reg  <= mem_wr_en;
    mem_wr_en_del  <= mem_wr_en_reg;
        
    mem_rd_en_reg  <= mem_rd_en;
    mem_rd_en_del  <= mem_rd_en_reg;
end

assign  mem_init_i = mem_wr_en_reg & (~mem_wr_en_del);
assign  mem_test_i = mem_rd_en_reg & (~mem_rd_en_del);


// this generates a 0x400 offset to make the data unique for every 1kB of increasing 1 written to data (ie pattern = 0) 

wire    [31:0]  offset_data_i;
assign  offset_data_i   =  {mem_start[21:10],10'b0};               

//write address channel
always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        awaddr_o    <=   0;
        awvalid_o   <=   0;
        wburst_cnt  <=   0;
        waddr_state <=   axi_idle;
    end
    
    else begin

        case(waddr_state)
        
        //wait for memory init command/signal
        axi_idle:
        begin
            awaddr_o    <=   mem_start*BURST_OFFSET;
            wburst_cnt  <=   0;
            if(mem_init_i) waddr_state <=  axi_valid;
        end
        
        //Initiate AXI write 
        axi_valid:
        begin            
            awvalid_o   <=  1'b1;
            if(awready_i)   
            begin
                wburst_cnt  <=  wburst_cnt + 1'b1;
                waddr_state <=  axi_done;   
            end
        end

        //wait for AXI write completion
        axi_done:
        begin
            awvalid_o   <=   1'b0;
            if(bvalid_i)
            begin
                //Address for next AXI write 
                awaddr_o    <=   awaddr_o  + BURST_OFFSET;
                waddr_state <=   axi_next;
            end
        end

        //perform next AXI write if selected memory size 
        //initialization is not completed
        axi_next:
        begin
            if(wburst_cnt == blk_no_i)waddr_state <=   axi_idle;
            else                        waddr_state <=   axi_valid;
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
        wlast_o         <=   0;
        wvalid_o        <=   0;
        wdata_o         <=   0;
        mem_write_done_o<=   0;
        wdata_cnt       <=   0;
        wdburst_cnt     <=   0;
        wdata_state     <=   axi_idle;
    end
    
    else
    begin
    
        case(wdata_state)
        
        //wait for AXI IF ready
        axi_idle:
        begin
            wdata_o         <=   wdata_int;
            wdburst_cnt     <=   0;
            wdata_cnt       <=   0;
            mem_write_done_o<=   1'b0;
            if(awvalid_o && awready_i) wdata_state    <=   axi_valid;
        end
        
        //perform AXI burst write
        axi_valid:
        begin        
            mem_write_done_o<=   1'b1;   // high for duration of WRITE to AXI
            wvalid_o        <=   1'b1;
            
            if(wready_i)
            begin
                wdata_cnt   <=   wdata_cnt + 1'b1;
                
                if(wdata_cnt == BURST_LENGTH)
                begin
                    wlast_o         <=   1'b1;
                    wdburst_cnt     <=   wdburst_cnt + 1'b1;
                    wdata_state     <=   axi_done;
                end
		 
                if(pattern_i == 2'b00)//incremental data
                begin
                    wdata_o[63:32]  <=    wdata_o[63:32] + 2'b10;
                    wdata_o[31:0]   <=    wdata_o[31:0]  + 2'b10;
                end
                else if(pattern_i == 2'b01)//decremental data
                begin
                    wdata_o[63:32]  <=    wdata_o[63:32] - 2'b10;
                    wdata_o[31:0]   <=    wdata_o[31:0]  - 2'b10;
                end
            else
                wdata_o <=    wdata_o;
            end  
        end      // axi_valid state
        
        //generate memory initialization complete
        axi_done:
        begin 
            if(wready_i)
            begin
                wvalid_o    <=   1'b0;
                wlast_o     <=   1'b0;
                wdata_cnt   <=   0;   // MT added for multiple bursts
                if(wdburst_cnt == blk_no_i)
                begin
                    wdata_state     <=   axi_idle;
                end
                else
                    wdata_state     <=   axi_next;
            end
        end
        
        //next AXI burst write operation
        axi_next:
        begin
            if(awvalid_o)   wdata_state <=   axi_valid;
        end
        
        default:
        begin
            wdata_state              <=   axi_idle;
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
        wdata_int_u     <=   0;
        wdata_int_l     <=   0;
    end
    else
    begin
        case(pattern_i)
        
        2'h0://incremental
        begin
            wdata_int_u[31:0]   <=   {4'h0, offset_data_i[27:0]} - 1'b1;
            wdata_int_l[31:0]   <=   {4'h0, offset_data_i[27:0]} - 2'b10;
        end
        
        2'h1://decremental
        begin
            wdata_int_u     <=   {4'h0, offset_data_i[27:0]} + 9'h101;
            wdata_int_l     <=   {4'h0, offset_data_i[27:0]} + 9'h102;
        end
            
        2'h2://A's
        begin
            wdata_int_u[31:0]   <=   {8{4'hA}};
            wdata_int_l[31:0]   <=   {8{4'hA}};
        end
            
        2'h3://5's
        begin
            wdata_int_u[31:0]   <=   {8{4'h5}};
            wdata_int_l[31:0]   <=   {8{4'h5}};
        end
        
        default:
        begin
            wdata_int_u     <=   0;
            wdata_int_l     <=   0;
        end
        
        endcase
    end
end

//read address channel
always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        araddr_o    <=   0;
        arvalid_o   <=   0;
        rburst_cnt  <=   0;
        raddr_state <=   axi_idle;
    end
    else
    begin
    
    case(raddr_state)
   
        //start AXI burst read operation
        axi_idle:
        begin
            rburst_cnt      <=   0;
            araddr_o        <=   mem_start*BURST_OFFSET;
            if(mem_test_i)  raddr_state    <=   axi_valid;
        end
        
        //monitor read memory count
        axi_valid:
        begin
            arvalid_o       <=   1'b1;
            if(arready_i)
            begin
                rburst_cnt  <=   rburst_cnt + 1'b1;
                raddr_state <=   axi_done;   
            end
        end
        
        //next AXI read operation
        axi_done:
        begin
            arvalid_o       <=   1'b0;      
            if(rburst_cnt == blk_no_i)
                raddr_state <=   axi_idle;
            else if(rvalid_i && rlast_i)
            begin
                //Address for next 2KB AXI write
                araddr_o    <=   araddr_o + BURST_OFFSET;
                raddr_state <=   axi_valid;
            end
        end
        
        default:
        begin
            raddr_state <=   axi_idle;
        end
        
        endcase
    end
end

//read data channel
always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        rdata_int       <=   0;
        rdata_int_u     <=   0;
        rdata_int_l     <=   0;
        rready_o        <=   0;
        rdburst_cnt     <=   0;
        mem_test_err_o  <=   0;
        mem_read_done_o <=   0;
        err_int_loc     <=   0;    
        err_loc_o       <=   0;  
        error_cnt_o     <=   0;
        rdata_state     <=   axi_idle;
    end
    else
    begin
        
        case(rdata_state)
        
        //start memory test
        axi_idle:
        begin        
            rdburst_cnt               <=   0;      
            rready_o                  <=   1'b0;            
            mem_read_done_o           <=   1'b0;
            err_int_loc               <=   mem_start*BURST_OFFSET;
            if(mem_test_i)//memory pattern check
            begin         
                //rready_o		<=   1'b0;  // moved out of IF and set high on next state
                rdata_state            <=   axi_pattern;
                err_loc_o              <=   32'b0;
                if(pattern_i == 2'b00)//incremental
                begin
                    rdata_int_u         <=    wdata_int[63:32] + 2'b10;
                    rdata_int_l         <=    wdata_int[31:0]  + 2'b10;
                end
                else if(pattern_i == 2'b01)//decremental
                begin
                    rdata_int_u[31:0]   <=    wdata_int[63:32] - 2'b10;
                    rdata_int_l[31:0]   <=    wdata_int[31:0]  - 2'b10;
                end
                else
                begin
                    rdata_int_u[31:0]   <=    wdata_int[63:32];
                    rdata_int_l[31:0]   <=    wdata_int[31:0];
                end
            end
        end
        
        //initial data as per pattern
        axi_pattern:
        begin
            mem_read_done_o           <=   1'b1;  // high for duration of READ via AXI
            rready_o                  <=   1'b1;
            rdata_int[63:32]          <=   rdata_int_u[31:0];
            rdata_int[31:0]           <=   rdata_int_l[31:0];
            rdata_state               <=   axi_valid;
        end
        
        //check AXI read data against selected pattern
        axi_valid:
        begin
            if(rdburst_cnt == blk_no_i)
            begin
                rdata_state            <=   axi_idle;
            end
            else
            begin
                if(rvalid_i)
                begin
                    if(rdata_i != rdata_int)
                    begin
                        mem_test_err_o  <=  1;                              // high until RESET
                        error_cnt_o     <=  error_cnt_o + 1;                // errors counter
                        if (error_cnt_o == 0) err_loc_o <=  err_int_loc;    // location of first error
                    end
                    
                    err_int_loc      <=   err_int_loc + 4'h8;
                    
                    if(pattern_i == 2'b00)//incremental
                    begin
                        rdata_int[63:32]    <=    rdata_int[63:32] + 2'b10;
                        rdata_int[31:0]     <=    rdata_int[31:0]  + 2'b10;
                    end
                    else if(pattern_i == 2'b01)//decremental
                    begin
                        rdata_int[63:32]    <=    rdata_int[63:32] - 2'b10;
                        rdata_int[31:0]     <=    rdata_int[31:0]  - 2'b10;
                    end
                    else    
                        rdata_int   <=   rdata_int;
                end
            end
                
            if(rlast_i && rvalid_i) rdburst_cnt <=   rdburst_cnt + 1'b1;
        end
        
        default:
        begin
            rdata_state     <=   axi_idle;
        end
        
        endcase
        
    end
end

endmodule


