// tracker_params.vh
// define PARAMETERS used by multiple verilog functions
//
`ifndef _trk_params_h
`define _trk_params_h
   `define  EVENT_TAG_BITS	  48    // max. Event Window count for duration of experiment 
   `define  SPILL_TAG_BITS    20    // EWTAG counter for duration of SPILL	
   `define  TRK_HIT_BITS      8     // max. no of tracker hits per Event Window (or 2**8-1 = 255)	
   `define  EVENT_SIZE_BITS   10    // max. tracker Event size in units of 64-bit AXI beats (or 2**10 - 1 = 1023)
   `define  DDR_ADDRESS_BITS  20    // max. no of 1 kB blocks in 8 Gb DDR memory (or 2**20 - 1 = 1048575)
   `define  MAX_STEP_BITS     3     // number of 1kB blocks needed to fit the maximum trackers event size (or 2**3 + 1 = 9 blocks) 
   `define  DIGI_BITS         32    // number of 1kB blocks needed to fit the maximum trackers event size (or 2**3 + 1 = 9 blocks) 
   `define  AXI_BITS          64    // AXI beat size
   `define  ROCFIFO_DEPTH     17    // for 65K deep ROCFIFOs
`endif
