// ********************************************************************/
// Actel Corporation Proprietary and Confidential
//  Copyright 2011 Actel Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
// IN ADVANCE IN WRITING.
//
// Description:  PF_SRAM_COREAHBLSRAM_PF_0_AHBLSramIf
//               Provides AHB interface to embedded Large SRAM.
//
//
// Revision Information:
// Date     Description
//
// SVN Revision Information:
// SVN $Revision: 4805 $
// SVN $Date: 2008-11-27 17:48:48 +0530 (Thu, 27 Nov 2008) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ********************************************************************/

`timescale 1ns/100ps

module PF_SRAM_COREAHBLSRAM_PF_0_CoreAHBLSRAM_AHBLSram (
                   HCLK,
                   HRESETN,
                   HSEL,
                   HTRANS,
                   HBURST,
                   HWRITE,
                   HSIZE,
                   HADDR,
                   HWDATA,
                   HREADYIN,
                   // Outputs
                   HRESP,
                   HREADYOUT,
                   HRDATA,
                   // SRAM Control signals
                   BUSY,
				   // To TOP
                   mem_wen,      
                   mem_ren,      
                   mem_wdata,      
                   mem_addr,      
                   mem_byteen,      
                   mem_rdata   
                         
                   );

   

////////////////////////////////////////////////////////////////////////////////
// Parameter Declarations
////////////////////////////////////////////////////////////////////////////////

   parameter SYNC_RESET = 0;
   parameter MEM_AWIDTH = 19;
   parameter PIPE = 1;
   //parameter ECC  = 0;
   
   parameter SEL_SRAM_TYPE = 1;
   parameter MEM_DEPTH = 512;
      
   // State Machine parameters
   localparam IDLE   = 2'b00;
   localparam AHB_WR = 2'b01;
   localparam AHB_RD = 2'b10;


   localparam AHB_DWIDTH = 32;
   localparam AHB_AWIDTH = 32;
   
   localparam RESP_OKAY = 2'b00;
   localparam RESP_ERROR = 2'b01;

   // AHB HTRANS definition
   localparam TRN_IDLE = 2'b00;
   localparam TRN_BUSY = 2'b01;
   localparam TRN_SEQ  = 2'b11;
   localparam TRN_NONSEQ = 2'b10;

   localparam SINGLE = 3'b000;
   localparam INCR = 3'b001;
   localparam WRAP4 = 3'b010;
   localparam INCR4 = 3'b011;
   localparam WRAP8 = 3'b100;
   localparam INCR8 = 3'b101;
   localparam WRAP16 = 3'b110;
   localparam INCR16 = 3'b111;
   
   
////////////////////////////////////////////////////////////////////////////////
// I/O Declarations
////////////////////////////////////////////////////////////////////////////////
// Inputs
   input HCLK;
   input HRESETN;
   input HSEL;
   input HREADYIN;
   input [1:0] HTRANS;
   input [2:0] HBURST;
   input [2:0] HSIZE;
   input [AHB_AWIDTH - 1:0] HADDR;
   input [AHB_DWIDTH - 1:0] HWDATA;
   input                    HWRITE;

   output                    BUSY;
   
// Outputs
   output                    HREADYOUT;
   output [1:0]              HRESP;
   output [AHB_DWIDTH - 1:0] HRDATA;
   
   //From Top
   input [AHB_DWIDTH - 1:0]    mem_rdata;
   // To Top
   output                      mem_ren;
   output                      mem_wen;
   output [MEM_AWIDTH-1:0]     mem_addr;
   output [3:0]                mem_byteen;
   output [AHB_DWIDTH - 1:0]   mem_wdata;  
   
////////////////////////////////////////////////////////////////////////////////
// Register Declarations
////////////////////////////////////////////////////////////////////////////////
   reg [2:0]              HSIZE_d;
   reg [2:0]              HBURST_d;
   reg [MEM_AWIDTH - 1:0] HADDR_d;
   reg                    HWRITE_d;
   reg [1:0]              ahbcurr_state;
   reg [1:0]              ahbnext_state;

   reg                    latchahbcmd;
   reg [AHB_DWIDTH - 1:0] HRDATA;
   reg [AHB_DWIDTH - 1:0] ahbsram_wdata_usram;
   reg [AHB_DWIDTH - 1:0] ahbsram_wdata_usram_d;

   reg [4:0]  burst_count;
   reg [4:0]  burst_count_reg;
   reg [4:0]  count;

   reg [3:0]                   sram_wen_mem;
   reg                         sram_wen;
   reg                         sram_ren;
   reg                         sramahb_ack_int;
   reg                         sram_ren_d;
   reg                         sram_ren_d2;
   reg                         sram_ren_d3;
   reg                         sram_done;   
   reg [AHB_DWIDTH - 1 : 0]    sramahb_rdata;

   reg [AHB_DWIDTH-1:0]        ahbsram_wdata_upd_r;
   reg [AHB_DWIDTH-1:0]        u_ahbsram_wdata_upd_r;
   reg [1:0] HTRANS_d;
   reg [AHB_AWIDTH - 1:0] raddr_c ;
   reg [AHB_AWIDTH - 1:0] raddr_c_r ;
   reg [4:0]                    beat_cnt;
   reg                          single_beat;
   reg                          single_beat_d;
   reg                          first_busy_det;
   reg                          busy_detect_d;
   reg                          beat_cnt_dec_en;

////////////////////////////////////////////////////////////////////////////////
// Wire Declarations
////////////////////////////////////////////////////////////////////////////////
   reg                    HREADYOUT;
   reg                    newreadtrans;
   reg                    newreadtrans_d;
   reg                    newreadtrans_d2;
   reg                    busy_detect;
   wire                   validahbcmd;
   wire [1:0]             HRESP;
   wire [2:0]             ahbsram_size;
   wire [MEM_AWIDTH-1:0]  ahbsram_addr;  
   reg  [MEM_AWIDTH-1:0]  ahbsram_addr_t;
   wire [MEM_AWIDTH-1:0]  ahbsram_addr_mem;
   wire                   aresetn;
   wire                   sresetn; 
   
   wire [AHB_DWIDTH - 1:0]     ahbsram_wdata;
   wire [AHB_DWIDTH - 1:0]     ram_rdata;
   wire                        u_BUSY_all_0;
   wire                        u_BUSY_all_1;
   wire                        u_BUSY_all_2;
   wire                        u_BUSY_all_3;
   wire                        l_BUSY_all_0;
   wire                        l_BUSY_all_1;
   wire                        l_BUSY_all_2;
   wire                        l_BUSY_all_3;
   wire                        BUSY; 
   wire [AHB_DWIDTH - 1:0]     sram_wdata;
   
   wire                        ahb_write;
   reg                         ahb_write_d;
   reg                         ahb_write_det;
   reg                         ahb_write_det_d1;
   reg                         ahb_write_det_d2;
   reg                         ahb_write_det_d3;
   reg [AHB_DWIDTH - 1:0]      ram_rdata_d;
   wire                        hready_ctrl;
   
   assign aresetn = (SYNC_RESET==1) ? 1'b1 : HRESETN;
   assign sresetn = (SYNC_RESET==1) ? HRESETN : 1'b1;

////////////////////////////////////////////////////////////////////////////////
// Main body of code
////////////////////////////////////////////////////////////////////////////////


// Generation of valid AHB Command which triggers the AHB Slave State Machine
   assign validahbcmd = HREADYIN & HREADYOUT & HSEL & (HTRANS == TRN_NONSEQ);


// Generation of HRESP
   assign HRESP = RESP_OKAY;

   
// Latch all the AHB signals
   always @(posedge HCLK or negedge aresetn) begin
      if((aresetn == 1'b0) || (sresetn == 1'b0)) begin
         HADDR_d    <= {MEM_AWIDTH{1'b0}};
      end
      else begin
         HADDR_d    <= HADDR[MEM_AWIDTH-1:0];
      end
    end
   
   always @(posedge HCLK or negedge aresetn) begin
      if((aresetn == 1'b0) || (sresetn == 1'b0)) begin
         HSIZE_d    <= 2'b00;
         HWRITE_d   <= 1'b0;
      end
      else if(validahbcmd & HREADYOUT) begin
            HSIZE_d    <= HSIZE;
            HWRITE_d   <= HWRITE;         
      end
    end   
    
    always @(posedge HCLK or negedge aresetn) begin
      if((aresetn == 1'b0) || (sresetn == 1'b0)) begin
         HBURST_d    <= 3'b000;
      end
      else if(validahbcmd & HREADYOUT) begin
            HBURST_d    <= HBURST;
      end
    end 


    
// Current State generation
   always @(posedge HCLK or negedge aresetn) begin
      if((aresetn == 1'b0) || (sresetn == 1'b0)) begin
         ahbcurr_state <= IDLE;
      end
      else begin
         ahbcurr_state <= ahbnext_state;
      end
   end
   
// Next State and output decoder logic
   always @(*) begin
      case (ahbcurr_state)
        IDLE : begin
         if(validahbcmd) begin
             if(HWRITE == 1'b1) begin
                ahbnext_state = AHB_WR;           
             end 
             else begin
                ahbnext_state = AHB_RD;           
             end
         end 
         else begin
                ahbnext_state = IDLE;           
         end
        end
        AHB_WR : begin
			if ((HTRANS == TRN_IDLE | (HTRANS == TRN_NONSEQ & ~HSEL)) ) begin
               ahbnext_state = IDLE;
            end 
            else if(validahbcmd & ~HWRITE) begin
               ahbnext_state = AHB_RD;
            end
            else begin
               ahbnext_state = AHB_WR;
            end
        end
        AHB_RD : begin
			if ((HTRANS == TRN_IDLE | (HTRANS == TRN_NONSEQ & ~HSEL)) ) begin
               ahbnext_state = IDLE;
            end 
            else if(validahbcmd & HWRITE) begin
               ahbnext_state = AHB_WR;
            end
            else begin
               ahbnext_state = AHB_RD;
            end
        end
        default : begin
           ahbnext_state = IDLE;
        end
      endcase // case (ahbcurr_state) 
   end

   always @(*) begin
      case (ahbcurr_state)
        IDLE : begin
         sram_wen = 1'b0;
         sram_ren = 1'b0;
        end
        AHB_WR : begin
           sram_wen = 1'b1;
           sram_ren = 1'b0;
		end
		AHB_RD : begin
           sram_wen = 1'b0;
           sram_ren = 1'b1;
		end
		default : begin
		  sram_wen = 1'b0;
          sram_ren = 1'b0;
        end
      endcase // case (ahbcurr_state)
   end



////////////////////////////////////////////////////////////////////////////
/////////// LOGIC FOR BURST COUNT //////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

always@(*) begin
    burst_count = burst_count_reg;
    if (validahbcmd & HREADYOUT) begin
           case (HBURST)
             SINGLE        : burst_count = 5'b00001;
             WRAP4,INCR4   : burst_count = 5'b00100;
             WRAP8,INCR8   : burst_count = 5'b01000;
             WRAP16,INCR16 : burst_count = 5'b10000;
             default  : burst_count = 5'b00001;
           endcase
    end
end

always@(posedge HCLK or negedge aresetn) begin
    if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
      burst_count_reg <= 'h0;
    end else begin
      burst_count_reg <= burst_count;
    end
end

//Delayed HTRANS by one clock cycle 

always@(posedge HCLK or negedge aresetn) begin
    if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
      HTRANS_d <= 'h0;
    end else begin
      HTRANS_d <= HTRANS;
    end
end

// Logic to detect new read transaction. Signal will be asserted when NON SEQUENTIAL transaction is accepted. 
// Also when PIPELINE mode is enabled,if master inserts BUSY transaction then to adjust two clock cycle delay of memory, 
// next SEQUENTIAL transaction will be treated as new transaction.     

always@(posedge HCLK or negedge aresetn) begin
    if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
      newreadtrans <= 'b0;
    end else if(PIPE == 2) begin
      newreadtrans <= ((HTRANS == TRN_NONSEQ & HREADYOUT & ~HWRITE & HSEL) | (HTRANS == TRN_SEQ & busy_detect & ~HWRITE));        
    end else begin 
      newreadtrans <= ((HTRANS == TRN_NONSEQ & HREADYOUT & ~HWRITE & HSEL));        
    end 
    
end

//Delayed newreadtrans by one clock cycle

always@(posedge HCLK or negedge aresetn) begin
    if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
      newreadtrans_d <= 'h0;
    end else begin
      newreadtrans_d <= newreadtrans;
    end
end

//Delayed newreadtrans by two clock cycle

always@(posedge HCLK or negedge aresetn) begin
    if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
      newreadtrans_d2 <= 'h0;
    end else begin
      newreadtrans_d2 <= newreadtrans_d;
    end
end

   

// single_beat - to detect a Single Burst or an Undefined burst of single beat 
always@(*)
    single_beat = (HTRANS == TRN_IDLE & HTRANS_d == TRN_NONSEQ);

//single_beat_d
always@(posedge HCLK or negedge aresetn) begin
    if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
      single_beat_d <= 'h0;
    end else begin
      single_beat_d <= single_beat;
    end
end

//first_busy_det
always@(posedge HCLK or negedge aresetn) begin
    if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
      first_busy_det <= 'h0;
    end 
    else if(HTRANS == TRN_BUSY & HTRANS_d == TRN_NONSEQ) begin
      first_busy_det <= 1;
    end
    else if (~busy_detect & busy_detect_d) begin
      first_busy_det <= 0;
    end
end

// HREADYOUT control logic. For Asynchronous Mode and during write operation, HREADYOUT is always 1
// When NON-PIPELINE mode is enabled, to adust one clock cycle delay of the memory, HREADYOUT is driven low for one clock cycle
// after detecting NON-SEQUENTIAL read transaction. 
// When PIEPLINE mode is enabled, to adjust two clock cycle delay of the memory, HREADYOUT is driven low for two clock cycle 
// after detecting NON-SEQUENTIAL read transaction. 
   
always@(*) begin
    if (PIPE == 0)
        HREADYOUT = 1'b1;
    else if (PIPE == 1)
        HREADYOUT = ~(newreadtrans);  
    else if (PIPE == 2) begin
        if((single_beat | single_beat_d))
            HREADYOUT = 1'b0;
        else 
            HREADYOUT = ~((newreadtrans_d | newreadtrans) & (HTRANS != TRN_IDLE  | HBURST_d == INCR) ); //Added by KA
    end
    else
        HREADYOUT = 1'b1;
end

   
// Generation of signals required for SRAM
   assign ahbsram_wdata = HWDATA;     
   assign ahbsram_size = HSIZE_d; 

   assign ahbsram_addr = {2'b00,HADDR_d[MEM_AWIDTH-1:2]}; 
   assign ahbsram_addr_mem = ahbsram_addr_t;

   always@(*) begin
      if(HWRITE | PIPE == 0)
          ahbsram_addr_t = HADDR_d[MEM_AWIDTH-1:0];
      else 
          ahbsram_addr_t = raddr_c[MEM_AWIDTH-1:0];
   end
  
// HRDATA generation   
   always @(*) begin
      HRDATA = ram_rdata;
      
      // synthesis translate_off
      if(ram_rdata === {AHB_DWIDTH{1'bx}})
        HRDATA = 0;
      // synthesis translate_on
   end   
   
   //Logic to detect busy transaction is asserted by master. This signal is used only if PIPELINE mode is enabled.
   
   always @(posedge HCLK or negedge aresetn) begin
      if((aresetn == 1'b0) || (sresetn == 1'b0)) begin
         busy_detect <= 1'b0;
      end
      else if(HTRANS == TRN_BUSY & PIPE == 2)begin
         busy_detect <= 1'b1;
      end
      else 
         busy_detect <= 1'b0;
   end

   always @(posedge HCLK or negedge aresetn) begin
      if((aresetn == 1'b0) || (sresetn == 1'b0)) begin
         busy_detect_d <= 1'b0;
      end
      else 
         busy_detect_d <= busy_detect;
   end

//////////////////////////////////////////////////////////////
//
//
//SramCtrlIf
//
//
///////////////////////////////////////////////////////////////
   
   
   
   assign sram_wdata = ahbsram_wdata;
   assign ram_rdata  = mem_rdata; 

   // Assignments for Top outputs
   assign mem_ren    = (PIPE != 0 & HBURST_d == 0 & ~HWRITE_d) ? newreadtrans : sram_ren ;
   
   assign mem_wen    = sram_wen & (HTRANS_d != TRN_BUSY);
   assign mem_wdata  = sram_wdata;
   assign mem_addr   = ({2'b00,ahbsram_addr_mem[MEM_AWIDTH - 1 : 2]});
   assign mem_byteen = sram_wen_mem;

////////////////////////////////////////////////////////////////////////////////
// Main body of code
////////////////////////////////////////////////////////////////////////////////




   generate
      if(PIPE == 1 || PIPE == 2) begin         
		 reg hreadyout_d;
         reg [10:0] wrap_cond;
         reg        wrap_en;
         reg [10:0] last_nibble;
         reg [7:0]  haddr_incr;
         		 
         always @(posedge HCLK or negedge aresetn) begin
		 	if((aresetn == 1'b0) || (sresetn == 1'b0)) begin
		 		hreadyout_d <= 1'b0;
		 	end
		 	else begin
		 		hreadyout_d <= HREADYOUT;
		 	end
		 end
         
         //Logic to detect boundary condition for wrap operation. It depends on HBURST and HSIZE. For example, when HBURST 
		 //is configured to INCR4 and HSIZE is configured to HALF WORD then boudary condition for wrap operation will be 
		 //2^HBURST - 2^HSIZE i.e 14.
		 
         always @ (posedge HCLK or negedge aresetn) begin 
            if(aresetn == 1'b0 || sresetn == 1'b0)
                wrap_cond <= 0;
            else if(validahbcmd)
                wrap_cond <= (((2 << HBURST[2:1]) << HSIZE) - (1 << (HSIZE)));
         end
		 
		 //When NON-PIPELINE and PIEPLINE mode is enabled, memory address controlled internally i.e not used from the AHB Master
		 //to improve the performance. It includes wrap address generation logic as well. 
         
         always @ (posedge HCLK or negedge aresetn) begin 
            if (aresetn == 1'b0 || sresetn == 1'b0) begin 
                raddr_c  <= 'h0;
            end
			else if(PIPE == 1)
			  begin 
                if(validahbcmd)
                    raddr_c <= HADDR;
                else if (HTRANS == TRN_SEQ | (HTRANS == TRN_BUSY & ((HREADYOUT & ~hreadyout_d )| newreadtrans_d))) begin
                    if ((raddr_c[10:0] & wrap_cond) == (wrap_cond & last_nibble) & wrap_en) begin
                        raddr_c <= {raddr_c[31:11], (raddr_c[10:0] & ~wrap_cond)};	
                    end		
                    else
                        raddr_c <= raddr_c + haddr_incr;	
                end
		      end
			else //Added by KA
			  begin 
                if(validahbcmd | (HTRANS == TRN_SEQ & busy_detect))
                    raddr_c <= HADDR;
                else if (((beat_cnt != burst_count)|(HBURST == 1)) & ((HTRANS == TRN_SEQ) | ((HTRANS == TRN_BUSY) & (HTRANS_d != TRN_BUSY) & newreadtrans))) begin
                    if ((raddr_c[10:0] & wrap_cond) == (wrap_cond & last_nibble) & wrap_en) begin
                        raddr_c <= {raddr_c[31:11], (raddr_c[10:0] & ~wrap_cond)};	
                    end		
                    else
                        raddr_c <= raddr_c + haddr_incr;	
                end
			  end 
         end
         
		 //Counter to count number of beat read from the memory. This counter is used to control internally generated address (raddr_c)
		 
         always @ (posedge HCLK or negedge aresetn) begin 
            if(~aresetn | ~sresetn)
                beat_cnt <= 0;
            else if(validahbcmd)
                beat_cnt <= 1;
            else if(~HWRITE)
            begin 
                if((HTRANS == TRN_SEQ & busy_detect & ~first_busy_det )) begin
                    if(~beat_cnt_dec_en)
                        beat_cnt <= beat_cnt - 1'b1;
                end
                else if((beat_cnt != burst_count) & ((HTRANS == TRN_SEQ & ~first_busy_det) | ((HTRANS == TRN_BUSY) & (HTRANS_d != TRN_BUSY) & newreadtrans)))
                    beat_cnt <= beat_cnt + 1'b1;
            end
         end

        //the beat_cnt should be decremented when busy is detected for only one clock. If it is detected for more than one clock the beat_cnt should be retained.
        always@(posedge HCLK or negedge aresetn) begin
            if ((aresetn == 1'b0) || (sresetn == 1'b0)) begin
              beat_cnt_dec_en <= 1'b0;
            end 
            else if(busy_detect & ~busy_detect_d & (HTRANS == TRN_BUSY) & ~HWRITE) begin
              beat_cnt_dec_en <= 1'b1;	
            end
            else if(~busy_detect) begin
              beat_cnt_dec_en <= 1'b0;
            end
        end
         
		 //Logic to detect wrap transaction. 
		 
         always @ (posedge HCLK or negedge aresetn) begin 
            if(~aresetn | ~sresetn)
                wrap_en <= 1'b0;
            else if(validahbcmd)
                case (HBURST)
                    2,4,6   : wrap_en <= 1'b1;
                    default : wrap_en <= 1'b0;
                endcase
         end
         
		 //Logic to decide increment factor based on HSIZE value.This will decide increment factor for interanlly generated 
		 //memory address(raddr_c)
		 
         always @ (posedge HCLK or negedge aresetn) begin 
            if(~aresetn | ~sresetn)
                haddr_incr <= 8'h0; 
            else if(validahbcmd)    
                case (HSIZE)
                    3'b000  : haddr_incr  <= 8'h1;
                    3'b001  : haddr_incr  <= 8'h2;
                    3'b010  : haddr_incr  <= 8'h4;
                    3'b011  : haddr_incr  <= 8'h8;
                    3'b100  : haddr_incr  <= 8'h10;
                    3'b101  : haddr_incr  <= 8'h20;
                    3'b110  : haddr_incr  <= 8'h40;
                    3'b111  : haddr_incr  <= 8'h80;
                    default : haddr_incr <= 8'h00;
                endcase
         end
         
         //Logic to detect last nibble based on HSIZE. This signal will be used to generate wrap address.    
			 
         always @ (posedge HCLK or negedge aresetn)
         begin 
         if(~aresetn | ~sresetn)
             last_nibble <= 0;
         else if(validahbcmd)
         case (HSIZE)
             3'b000 : last_nibble <= 11'h00F;
             3'b001 : last_nibble <= 11'h1E;
             3'b010 : last_nibble <= 11'h3C;
             3'b011 : last_nibble <= 11'h78;
             3'b100 : last_nibble <= 11'hF0;
             3'b101 : last_nibble <= 11'h1E0;
             3'b110 : last_nibble <= 11'h3C0;
             3'b111 : last_nibble <= 11'h780;
             default : last_nibble <= 0;
         endcase
         end

      end // if (PIPE == 1 || PIPE == 2)
   endgenerate
 
   always @(*) begin
      sram_wen_mem = 4'b0000;
      if(ahbsram_size == 3'b010) begin
         sram_wen_mem = {4{mem_wen}};
      end
      else if(ahbsram_size == 3'b001) begin
         case(ahbsram_addr_mem[1])
           1'b0: begin
              sram_wen_mem[0] = mem_wen;
              sram_wen_mem[1] = mem_wen;
              sram_wen_mem[2] = 1'b0;
              sram_wen_mem[3] = 1'b0;
           end
           1'b1: begin
              sram_wen_mem[0] = 1'b0;
              sram_wen_mem[1] = 1'b0;
              sram_wen_mem[2] = mem_wen;
              sram_wen_mem[3] = mem_wen;
           end
         endcase // case (ahbsram_addr_mem[1])         
      end // if (ahbsram_size == 3'b001)      
      else if(ahbsram_size == 3'b000) begin
         case(ahbsram_addr_mem[1:0])
           2'b00: begin
              sram_wen_mem[0] = mem_wen;
              sram_wen_mem[1] = 1'b0;
              sram_wen_mem[2] = 1'b0;
              sram_wen_mem[3] = 1'b0;
           end
           2'b01: begin
              sram_wen_mem[0] = 1'b0;
              sram_wen_mem[1] = mem_wen;
              sram_wen_mem[2] = 1'b0;
              sram_wen_mem[3] = 1'b0;
           end
           2'b10: begin
              sram_wen_mem[0] = 1'b0;
              sram_wen_mem[1] = 1'b0;
              sram_wen_mem[2] = mem_wen;
              sram_wen_mem[3] = 1'b0;
           end
           2'b11: begin
              sram_wen_mem[0] = 1'b0;
              sram_wen_mem[1] = 1'b0;
              sram_wen_mem[2] = 1'b0;
              sram_wen_mem[3] = mem_wen;
           end
         endcase // case (ahbsram_addr_mem[1:0])         
      end // else: !if(ahbsram_size == 3'b000)
      else begin
         sram_wen_mem = {4{mem_wen}};
      end             
   end // always @ (*)


////////////////////////////////////////////////////////////////////////////////

   assign BUSY = SEL_SRAM_TYPE ? (u_BUSY_all_0 | u_BUSY_all_1 | u_BUSY_all_2 | u_BUSY_all_3)  : (l_BUSY_all_0 | l_BUSY_all_1 | l_BUSY_all_2 | l_BUSY_all_3);
   

endmodule // PF_SRAM_COREAHBLSRAM_PF_0_CoreAHBLSRAM_AHBLSram


