///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: REG_CTRL.v
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

module REG_CTRL( 

//global signals
 input             digiclk_i,
 input             algoclk_i,

// from Register module 
 input      [1:0]  pattern_i, 
 input             chip_sel     /*synthesis syn_preserve=1 */,  // 0 for DDR3;  1 for LSRAM
 input             mem_wr_en    /*synthesis syn_preserve=1 */,  // to start WR to memory (either DDR3 or SRAM)
 input             mem_rd_en    /*synthesis syn_preserve=1 */,  // to start RD to memory (either DDR3 or SRAM)
 input             mem_dma_en   /*synthesis syn_preserve=1 */,  // to start DMA read from LSRAM to DDR3 
 input             fifo_write_mem_en   /*synthesis syn_preserve=1 */,   // to start DIGIFIFO transfer to DDR3
 input             fifo_read_mem_en   /*synthesis syn_preserve=1 */,    // to start DDR3 read to MEMFIFO 
 input             dtc_fifo_read_mem_en   /*synthesis syn_preserve=1 */,    // to start DDR3 read to MEMFIFO from TOP_SERDES
 input      [7:0]  hit_no       /*synthesis syn_preserve=1 */,  // no of DMA bursts = no of hits
 input     [15:0]  mem_start,       // memory offset (in units of 16 hits => 32x16 = 512 bytes)
 input      [3:0]  dma_mem_start,   // memory offset in units of 2kB


 //to Pattern generator/checker interface
 output         mem_init_o,
 output         mem_test_o,
 output         fifo_write_mem_o,
 output         fifo_read_mem_o,
 output         dtc_fifo_read_mem_o,
 output  [1:0]  pattern_o,   //pattern to generator logic
 output  [7:0]  mem_size_o    /*synthesis syn_preserve=1 */,     // multiples of DMA bursts 
 output [31:0]  mem_address_o /*synthesis syn_preserve=1 */,     // memory RD/WR start
 output [31:0]  offset_data_o /*synthesis syn_preserve=1 */,     // data offset (mem_start << 12)


 //COREAXI4DMA control signals 
 input    [1:0] coredma_int_i,                                       // interrupt from CoreDMA
 output  [15:0] coredma_size_o /*synthesis syn_preserve=1 */,        // multiple of 2kB
 output  [23:0] coredma_addr_o /*synthesis syn_preserve=1 */,        // address offset for DDR3: multiple of 2kB (0x800)
 output         coredma_ch0_type_o  /*synthesis syn_preserve=1 */,   // for DDR3->LSRAM DMA transfers
 output         coredma_ch1_type_o  /*synthesis syn_preserve=1 */    // for LSRAM->DDR3 DMA transfers
);

//<statements>
localparam [3:0] LSRAM_ADDR_BASE  = 4'h1,
                 DDR3_ADDR_BASE   = 4'h2;

wire    [3:0]   ADDR_BASE;
assign          ADDR_BASE = (chip_sel) ? LSRAM_ADDR_BASE :  DDR3_ADDR_BASE;


//make enables into pulses
reg     mem_wr_en_reg, mem_rd_en_reg, mem_dma_en_reg;
reg     mem_wr_en_del, mem_rd_en_del, mem_dma_en_del;
reg     fifo_write_mem_reg, fifo_read_mem_reg, dtc_fifo_read_mem_reg;
reg     fifo_write_mem_del, fifo_read_mem_del, dtc_fifo_read_mem_del;

always@(posedge digiclk_i)
begin
      mem_wr_en_reg  <= mem_wr_en;
      mem_wr_en_del  <= mem_wr_en_reg;

      mem_rd_en_reg  <= mem_rd_en;
      mem_rd_en_del  <= mem_rd_en_reg;

      mem_dma_en_reg <= mem_dma_en;
      mem_dma_en_del <= mem_dma_en_reg;

      fifo_write_mem_reg  <= fifo_write_mem_en;
      fifo_write_mem_del  <= fifo_write_mem_reg;

      fifo_read_mem_reg  <= fifo_read_mem_en;
      fifo_read_mem_del  <= fifo_read_mem_reg;
end

assign  mem_init_o = mem_wr_en_reg & (~mem_wr_en_del);
assign  mem_test_o = mem_rd_en_reg & (~mem_rd_en_del);

assign  fifo_write_mem_o = fifo_write_mem_reg & (~fifo_write_mem_del);
assign  fifo_read_mem_o  = fifo_read_mem_reg  & (~fifo_read_mem_del);


always@(posedge algoclk_i)
begin
      dtc_fifo_read_mem_reg  <= dtc_fifo_read_mem_en;
      dtc_fifo_read_mem_del  <= dtc_fifo_read_mem_reg;
end
assign  dtc_fifo_read_mem_o  = dtc_fifo_read_mem_reg  & (~dtc_fifo_read_mem_del);


assign  pattern_o       =  pattern_i;
assign  mem_size_o      =  hit_no;              // in multiples of 32 hits of 64x4=256 bits each (DMA AXI burst size => 8Kb or 1KB => 128 beats)
                                                // assume PATTERN_GENERATOR Configurator with BURST_SIZE=3 (8-byte beat) and BURST_LENGTH=127 (128-beat burst) 
assign  mem_address_o   =  {ADDR_BASE, 2'b0, mem_start, 10'b0}; // this is in 1KB units
assign  offset_data_o   =  {4'b0,mem_start,12'b0};        // this generates a data offset based on the starting address


assign  coredma_ch0_type_o  =  1'b0;
assign  coredma_ch1_type_o  = mem_dma_en_reg & (~mem_dma_en_del);
assign  coredma_size_o      =  16'h400;                       // this 1kB of data  => 128 beats of 64-bit each ( i.e 128 x 8B = 0x80 x 8 addresses)
assign  coredma_addr_o      =  {2'b0,dma_mem_start,10'b0};    // memory block in in 1kB units


endmodule

