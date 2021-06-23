///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: memdata_switch.v
// File history:
//      v1.0: 12/05/2020: First version
//      v2.0: 12/10/2020: Added DDR3_Full as enable to MEMFIFO_DATA_PCTKS output
//      v3.0: 12/18/2020: Delay DDR3_Full enable to avoid missing last page from memory
//      v4.0: 03/05/2021: Eliminate simulate DDR packet via SIM_MEMFIFO
//
// Old Description (before v3): 
// 	Drives input to TOP_SERDES in Data Request protocol depending on SIM_MEMFIFO value:
//			if SIM_MEMFIFO = 0:  data-driven A inputs to outputs 
//			if SIM_MEMFIFO = 1:  simulated B inputs for testing of data request to outputs 
// New Description (after v3)
// 	Drives inputs to TOP_SERDES in Data Request protocol depending on status of DDR3_FULL (via EN)
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module memdata_switch(    
	input 	EN,				// connected to DDR3_FULL: if not high, set expected packets to zero

   input          DDR_DATA_READY,
   input [15:0]   DDR_DATA_PCKTS,
   input [63:0]   DDR_DATA,
   output         MEMFIFO_DATA_READY,
   output [63:0]  MEMFIFO_DATA,
   output [15:0]  MEMFIFO_DATA_PCKTS
);

   assign MEMFIFO_DATA_READY  = DDR_DATA_READY;
   assign MEMFIFO_DATA        = DDR_DATA;
	
	assign MEMFIFO_DATA_PCKTS	= (EN==1'b1)	? DDR_DATA_PCKTS  : 16'b0;

endmodule


