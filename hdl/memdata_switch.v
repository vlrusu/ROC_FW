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
   input    MEM_OUT_DISABLE,           // select between DDR data out(0) vs DTC simulated data out (1) to TOP_SERDES 

   input          DDR_DATA_READY,
   input [15:0]   DDR_DATA_PCKTS,
   input [63:0]   DDR_DATA,
   input          SIM_DATA_READY,
   input [15:0]   SIM_DATA_PCKTS,
   input [63:0]   SIM_DATA,
   output         MEMFIFO_DATA_READY,
   output [15:0]  MEMFIFO_DATA_PCKTS,
   output [63:0]  MEMFIFO_DATA
);

//<statements>
   assign MEMFIFO_DATA_READY  = (MEM_OUT_DISABLE==1'b1) ?  SIM_DATA_READY  : DDR_DATA_READY;
   assign MEMFIFO_DATA_PCKTS  = (MEM_OUT_DISABLE==1'b1) ?  SIM_DATA_PCKTS  : DDR_DATA_PCKTS;
   assign MEMFIFO_DATA        = (MEM_OUT_DISABLE==1'b1) ?  SIM_DATA        : DDR_DATA;

endmodule


