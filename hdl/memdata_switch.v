///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: memdata_switch.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module memdata_switch(    
   input    SIM_MEMFIFO,           // select between DDR data out(0) vs DTC simulated data out (1) to TOP_SERDES 

   input          A_DDR_DATA_READY,
   input [15:0]   A_DDR_DATA_PCKTS,
   input [63:0]   A_DDR_DATA,
   input          B_SIM_DATA_READY,
   input [15:0]   B_SIM_DATA_PCKTS,
   input [63:0]   B_SIM_DATA,
   output         MEMFIFO_DATA_READY,
   output [15:0]  MEMFIFO_DATA_PCKTS,
   output [63:0]  MEMFIFO_DATA
);

//<statements>
   assign MEMFIFO_DATA_READY  = (SIM_MEMFIFO==1'b1) ?  B_SIM_DATA_READY  : A_DDR_DATA_READY;
   assign MEMFIFO_DATA_PCKTS  = (SIM_MEMFIFO==1'b1) ?  B_SIM_DATA_PCKTS  : A_DDR_DATA_PCKTS;
   assign MEMFIFO_DATA        = (SIM_MEMFIFO==1'b1) ?  B_SIM_DATA        : A_DDR_DATA;

endmodule


