///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: mem_read_cntrl.v
// File history:
//      v1.0: 02/20/2025: Forst version
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// This module reads 1kB of memory at a given address and writes it to an internal FIFO
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG484>
// Author: MT
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module mem_read_cntrl #(
	parameter [7:0]     BURST_LENGTH   = 8'h7F,	// burst length of 256 beats (AXI defines number beats to pass to AWLEN/ARLEN as: no-of-beats-1 ) 
                                                // Changed from 127(0x7F) for 1KB blocks in Configurator BURST_LENGHT field
    parameter [1:0]     BURST_SIZE  = 2'b11     // 8 bytes for beat (AXI defines bit in a beat as: 2**BURST_SIZE)
) (
//global signals
    input		sysclk,     // DDR clock to read from memory and write to FIFO 
    input		resetn_sysclk,
    input       dcsclk,     // 200 MHZ clock to read FIFO and pass it to DCSProcessor
    input		resetn_dcsclk,
 
// signals on DCS clock
    input       mem_read,   // start DDR read
    input       ddr_fifo_ren,
    input [19:0]mem_offset, // for BURST_LENGHT=0x7F, is 128x64-bits = 1kB blocks => 2**20 max no. of starting address (at addr. offset 0x0, 0x200, 0x400, 0x600...)
    output      ddr_fifo_full,
    output      ddr_fifo_empty,
    output reg [15:0]   ddr_data_out,
    output reg [9:0]    ddr_fifo_rdcnt,
    output reg [7:0]    ddr_fifo_wrcnt,
    
//AXI Master IF
// Write Address Channel 
    output		[3:0]	awid_o, 
    output reg	[31:0]  awaddr_o, 
    output		[7:0]	awlen_o, 
    output		[1:0]	awsize_o, 
    output		[1:0]	awburst_o, 
    output reg			awvalid_o,  
    input				awready_i,  
 // Write Data Channel  
    output		[7:0]	wstrb_o,
    output reg			wlast_o,
    output reg			wvalid_o,
    output reg [63:0]   wdata_o, 
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

//<statements>
///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
//AXI write/read channel states
reg [2:0]	raddr_state;
reg [2:0]	rdata_state;
wire [31:0] BURST_OFFSET;
assign      BURST_OFFSET = (2**BURST_SIZE) * (BURST_LENGTH+1); 

// this generate an address offset for each data burst
wire [31:0]	offset_addr;
assign		offset_addr	=	mem_offset*BURST_OFFSET;           

///////////////////////////////////////////////////////////////////////////////
// AXI state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]    axi_idle    =	3'b000,
                    axi_valid	=	3'b001,
                    axi_done	=	3'b010,
                    axi_next	=	3'b011,	
                    axi_set 	=	3'b100; 
                    
//AXI fixed assignments
assign  awid_o    =   0;
assign  awaddr_o  =   0;
assign  awvalid_o =   0;
assign  awlen_o   =   BURST_LENGTH;  
assign  awburst_o =   1;     //INCR burst
assign  awsize_o  =   BURST_SIZE; 
assign  wstrb_o   =   8'hFF; //number of bytes to write: all 1s for 8 bytes
assign  wvalid_o  =   0;
assign  wlast_o   =   0;
assign  wdata_o   =   0;
assign  bready_o  =   1;     //AXI write response channel is always ready
assign  arid_o    =   0;
assign  arlen_o   =   BURST_LENGTH; 
assign  arburst_o =   1;     //INCR burst
assign  arsize_o  =   BURST_SIZE; //64-bit read

//AXI burst,transaction counters
reg [31:0]	rdburst_cnt;
reg [31:0]	rburst_cnt;

reg         read_valid;
reg         mem_read_reg;
reg [63:0]  ddr_data_in;
reg         ddr_fifo_wen;  

//
//read address channel
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
        begin
            read_valid  <=  1'b0;
            mem_read_reg<=  1'b0;
            araddr_o    <=  32'b0;
            arvalid_o   <=  1'b0;
            rburst_cnt  <=  8'b0;
            raddr_state <=  axi_idle;
        end
    else
        begin
        
        mem_read_reg    <= mem_read;
        
        case(raddr_state)
        
        //start AXI burst read operation
        axi_idle:
        begin
            read_valid  <=  1'b0;
            rburst_cnt  <=  8'b0;
            if(mem_read & !mem_read_reg)    raddr_state <=  axi_set;   
            else                            raddr_state <=  axi_idle;
        end
        
        axi_set:
        begin
            araddr_o    <=  offset_addr;
            raddr_state <=  axi_valid;
        end
        
        //monitor read memory count
        axi_valid:
        begin
            arvalid_o		<=	1'b1;
            if(arready_i)
            begin
                read_valid  <=  1'b1;
                rburst_cnt	<=	rburst_cnt + 1'b1;
                raddr_state	<=	axi_done; 
            end
            else
            begin
                raddr_state	<=	axi_valid; 
            end
        end
        
        //next AXI read operation
        axi_done:
        begin
            arvalid_o       <=   1'b0;      
            if(rburst_cnt == 1)            
                raddr_state <=   axi_idle;
            else if(rvalid_i && rlast_i)
            begin
                //Address for next AXI write														  
                read_valid  <=  1'b0;
                araddr_o    <=   araddr_o + BURST_OFFSET;
                raddr_state <=   axi_valid;
            end
            else
            begin
                raddr_state <=   axi_done;
            end
        end
        
        default:
        begin
            raddr_state<=   axi_idle;
        end
        
        endcase
    end
end

//read data channel
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
        begin
            rready_o        <=	1'b0;
            rdburst_cnt     <=	8'b0;
            ddr_fifo_wen    <=  1'b0;
            ddr_data_in     <=  64'b0;
            rdata_state	    <=	axi_idle;
        end
    else
        begin
        
        ddr_fifo_wen    <=  1'b0;
        
        case(rdata_state)
        
        //start memory test
        axi_idle:
        begin        
            rdburst_cnt	<=	8'b0;      
            ddr_data_in	<=	{64{1'b1}};
            
            if (read_valid)  		//memory read only
            begin
                //rready_o  <=   1'b1;  // moved out of IF and set high on next state
                rdata_state	<=	axi_set;
            end
            else
            begin
                rdata_state	<=	axi_idle;
            end
        end
        
        axi_set:
        begin
            rready_o    <=   1'b1;  // moved out of IF and set high on next state
            rdata_state <=   axi_valid;
        end
        
        //read memory only (without checking pattern)
        axi_valid:
        begin
            if(rdburst_cnt == 8'b1)
            begin
                rready_o    <=   1'b0;
                rdata_state <=	axi_idle;
            end
            else
            begin
                if (rvalid_i)
                begin
                    ddr_fifo_wen    <=  1;
                    ddr_data_in     <= rdata_i;
                end
                rdata_state <=	axi_valid;
            end
                
            if(rlast_i && rvalid_i)
            begin
                rdburst_cnt		<=	rdburst_cnt + 1'b1;
            end
        end
        
        default:
        begin
            rdata_state	<=   axi_idle;
        end
        
        endcase
        
    end
end

//dual-port LSRAM to store 1kB of DDR data to be read via fiber: 64bx128 input, 16bx512 output
DDR1KB_FIFO ddr_fifo_0(
    // Inputs
    .DATA(ddr_data_in), 		 // [63:0]
    .RCLOCK(dcsclk),
    .RE(ddr_fifo_ren),
    .RRESET_N(resetn_dcsclk),	  // neg. logic
    .WCLOCK(sysclk),
    .WE(ddr_fifo_wen),
    .WRESET_N(resetn_sysclk),	  // neg. logic
    //Output
    .EMPTY(ddr_fifo_empty),
    .FULL(ddr_fifo_full),
    .Q(ddr_data_out),	          // [15:0]
    .RDCNT(ddr_fifo_rdcnt),        // [9:0]
    .WRCNT(ddr_fifo_wrcnt)        // [7:0]
);

endmodule

