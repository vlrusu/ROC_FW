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
 input             clk_i,

// from Register module 
 input             mem_wr_en    /*synthesis syn_preserve=1 */,  // to start WR to memory (either DDR3 or SRAM)
 input             mem_rd_en    /*synthesis syn_preserve=1 */,  // to start RD to memory (either DDR3 or SRAM)
 input             fifo_write_mem_en   /*synthesis syn_preserve=1 */,   // to start DIGIFIFO transfer to DDR3
 input             fifo_read_mem_en   /*synthesis syn_preserve=1 */,    // to start DDR3 read to MEMFIFO 

 //to Pattern generator/checker interface
 output         mem_init_o,
 output         mem_test_o,
 output         fifo_write_mem_o,
 output         fifo_read_mem_o
);


//make enables into pulses
reg     mem_wr_en_reg, mem_rd_en_reg;
reg     mem_wr_en_del, mem_rd_en_del;
reg     fifo_write_mem_reg, fifo_write_mem_del;
reg     fifo_read_mem_reg,  fifo_read_mem_del;

always@(posedge clk_i)
begin
      mem_wr_en_reg  <= mem_wr_en;
      mem_wr_en_del  <= mem_wr_en_reg;

      mem_rd_en_reg  <= mem_rd_en;
      mem_rd_en_del  <= mem_rd_en_reg;

      fifo_write_mem_reg  <= fifo_write_mem_en;
      fifo_write_mem_del  <= fifo_write_mem_reg;

      fifo_read_mem_reg  <= fifo_read_mem_en;
      fifo_read_mem_del  <= fifo_read_mem_reg;
end

assign  mem_init_o = mem_wr_en_reg & (~mem_wr_en_del);
assign  mem_test_o = mem_rd_en_reg & (~mem_rd_en_del);

assign  fifo_write_mem_o= fifo_write_mem_reg& (~fifo_write_mem_del);  
assign  fifo_read_mem_o = fifo_read_mem_reg & (~fifo_read_mem_del);  

endmodule