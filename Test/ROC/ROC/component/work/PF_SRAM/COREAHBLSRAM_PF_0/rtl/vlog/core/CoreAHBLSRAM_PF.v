// ********************************************************************/
// Actel Corporation Proprietary and Confidential
//  Copyright 2011 Actel Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
// IN ADVANCE IN WRITING.
//
// Description:  CoreAHBLSRAM
//               The Core IP provides AHB interface to embedded Large/micro SRAM.
//
//
// Revision Information:
// Date     Description
//
// SVN Revision Information:
// SVN $Revision: 4805 $
// SVN $Date: 2008-11-27 17:48:48 +0530 (Thu, 13 APR 2013) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ********************************************************************/

`timescale 1ns/100ps

module PF_SRAM_COREAHBLSRAM_PF_0_COREAHBLSRAM_PF (
                     HCLK,
                     HRESETN,
                     HSEL,
                     HREADYIN,
                     HSIZE,
                     HTRANS,
                     HBURST,
                     HADDR,
                     HWRITE,
                     HWDATA,
                     HREADYOUT,
                     HRDATA,
                     HRESP,
		     // To fabric SRAM memory
		     mem_rdata,
		     // To fabric SRAM memory
		     mem_ren,
		     mem_wen,
                     mem_addr,
		     mem_byteen,
		     mem_wdata
			 
			 // mem_rdata_arst_n,
			 // mem_rdata_en,
			 // mem_rdata_srst_n,
			 // mem_sb_correct,
			 // mem_db_detect,		 
                     );

////////////////////////////////////////////////////////////////////////////////
// Parameter Declarations
////////////////////////////////////////////////////////////////////////////////
   parameter FAMILY = 26;
   parameter MEM_DEPTH = 65536;
   parameter SEL_SRAM_TYPE = 1;
   //parameter SYNC_RESET = (FAMILY == 25) ? 1 : 0;
   parameter SYNC_RESET =  0;
   parameter ECC     = 0;
   parameter PIPE     = 1;


////////////////////////////////////////////////////////////////////////////////
//   Function to calculate  the ceiling value //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

      function [31:0] ceil_log2;
	input integer x;
	integer tmp, res;
	begin
		tmp = 1;
		res = 0;
		while(tmp < x) begin
			tmp = tmp * 2;
			res = res + 1;
		end
		ceil_log2 = res;
	end
     endfunction
     

////////////////////////////////////////////////////////////////////////////////
// Local declarations
////////////////////////////////////////////////////////////////////////////////
localparam MEM_AWIDTH = (SEL_SRAM_TYPE == 0) ? ceil_log2(MEM_DEPTH) : ceil_log2(MEM_DEPTH); 
localparam AHB_DWIDTH = 32;
localparam AHB_AWIDTH = 32;
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// I/O Declarations
////////////////////////////////////////////////////////////////////////////////
   // Inputs
   input     HCLK;
   input     HRESETN;
   input     HSEL;
   input     HREADYIN;
   input [1:0] HTRANS;
   input [2:0] HBURST;
   input [2:0] HSIZE;
   input [AHB_DWIDTH - 1:0] HWDATA;
   input [AHB_AWIDTH - 1:0] HADDR;
   input                    HWRITE;
   input [AHB_DWIDTH - 1:0] mem_rdata;   
   // Outputs
   output [AHB_DWIDTH - 1:0] HRDATA;
   output [1:0]              HRESP;
   output                    HREADYOUT;
   // To fabric SRAM Memory
   output        mem_ren;
   output        mem_wen;
   output [MEM_AWIDTH-1:0] mem_addr;
   output [3:0]  mem_byteen;
   output [AHB_DWIDTH - 1:0] mem_wdata; 
   
   // output mem_rdata_arst_n;
   // output mem_rdata_en;
   // output mem_rdata_srst_n;
   // input  mem_sb_correct;
   // input  mem_db_detect;		

////////////////////////////////////////////////////////////////////////////////
// Register Declarations
////////////////////////////////////////////////////////////////////////////////
   wire [AHB_AWIDTH-1:0]                HADDR_cal;
   
////////////////////////////////////////////////////////////////////////////////
// Wire Declarations
////////////////////////////////////////////////////////////////////////////////
   wire                      mem_ren;
   wire                      mem_wen;
   wire [MEM_AWIDTH-1:0]     mem_addr;
   wire [3:0]                mem_byteen;
   wire [AHB_DWIDTH - 1:0]   mem_wdata;   
////////////////////////////////////////////////////////////////////////////////
// Constant declarations
////////////////////////////////////////////////////////////////////////////////

   
////////////////////////////////////////////////////////////////////////////////
// Code starts here
////////////////////////////////////////////////////////////////////////////////

  assign  HADDR_cal = HADDR[AHB_AWIDTH-1:0];

   
////////////////////////////////////////////////////////////////////////////////
// Instantiations
////////////////////////////////////////////////////////////////////////////////

// AHBL-SRAM interface & control
generate
    
        if(ECC == 0)
            PF_SRAM_COREAHBLSRAM_PF_0_CoreAHBLSRAM_AHBLSram  #( .SYNC_RESET(SYNC_RESET),
                                    .MEM_DEPTH(MEM_DEPTH),
                                    .SEL_SRAM_TYPE(SEL_SRAM_TYPE),
                                    .MEM_AWIDTH(MEM_AWIDTH),
                                    .PIPE (PIPE)
                                    //.ECC (ECC)
                                    ) U_PF_SRAM_COREAHBLSRAM_PF_0_AHBLSram (
                                    .HCLK          (HCLK),
                                    .HRESETN       (HRESETN),
                                    .HSEL          (HSEL),
                                    .HTRANS        (HTRANS),
                                    .HBURST        (HBURST),
                                    .HWRITE        (HWRITE),
                                    .HWDATA        (HWDATA),
                                    .HSIZE         (HSIZE),
                                    .HADDR         (HADDR_cal),
                                    .HREADYIN      (HREADYIN),
            
                                    // outputs
                                    .HREADYOUT     (HREADYOUT),
                                    .HRESP         (HRESP),
                                    // To SRAM Control signals
                                    .HRDATA        (HRDATA),
                                    .BUSY          (BUSY),
                            // From Top
                                    .mem_rdata          (mem_rdata),
                            // To Top
                                    .mem_wen          (mem_wen),
                                    .mem_ren          (mem_ren),
                                    .mem_wdata          (mem_wdata),
                                    .mem_addr          (mem_addr),
                                    .mem_byteen          (mem_byteen)
                                    );
        else
            PF_SRAM_COREAHBLSRAM_PF_0_CoreAHBLSRAM_AHBLSram_ECC  #( 
			                        .FAMILY    (FAMILY),
									.SYNC_RESET(SYNC_RESET),
                                    .MEM_DEPTH(MEM_DEPTH),
                                    .SEL_SRAM_TYPE(SEL_SRAM_TYPE),
                                    .MEM_AWIDTH(MEM_AWIDTH),
                                    .PIPE (PIPE),
                                    .ECC (ECC)
                                    ) U_PF_SRAM_COREAHBLSRAM_PF_0_AHBLSramECC (
                                    .HCLK          (HCLK),
                                    .HRESETN       (HRESETN),
                                    .HSEL          (HSEL),
                                    .HTRANS        (HTRANS),
                                    .HBURST        (HBURST),
                                    .HWRITE        (HWRITE),
                                    .HWDATA        (HWDATA),
                                    .HSIZE         (HSIZE),
                                    .HADDR         (HADDR_cal),
                                    .HREADYIN      (HREADYIN),
            
                                    // outputs
                                    .HREADYOUT     (HREADYOUT),
                                    .HRESP         (HRESP),
                                    // To SRAM Control signals
                                    .HRDATA        (HRDATA),
                                    .BUSY          (BUSY),
                            // From Top
                                    .mem_rdata          (mem_rdata),
                            // To Top
                                    .mem_wen          (mem_wen),
                                    .mem_ren          (mem_ren),
                                    .mem_wdata          (mem_wdata),
                                    .mem_addr          (mem_addr),
                                    .mem_byteen          (mem_byteen)
                                    );
endgenerate

endmodule // CoreAHBLSRAM
////////////////////////////////////////////////////////////////////////////////
//                            End-of-file
////////////////////////////////////////////////////////////////////////////////
