///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: MUX_DIGI_DATA.v
// File history:
//      <v0>: <03/08/2024>  first version
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//     MUX for real vd simulated DIGI signals
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG484>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>
`include "tracker_params.vh"

module MUX_DIGI_DATA( 

    input en_digi_sim,
    
    input lane0_re,
    input lane1_re,
    input lane2_re,
    input lane3_re,
    
    output digi_lane0_re,
    output digi_lane1_re,
    output digi_lane2_re,
    output digi_lane3_re,
    
    output sim_lane0_re,
    output sim_lane1_re,
    output sim_lane2_re,
    output sim_lane3_re,
    
    input digi_lane0_empty,
    input digi_lane1_empty,
    input digi_lane2_empty,
    input digi_lane3_empty,

    input sim_lane0_empty,
    input sim_lane1_empty,
    input sim_lane2_empty,
    input sim_lane3_empty,
    
    output lane0_empty,
    output lane1_empty,
    output lane2_empty,
    output lane3_empty,

    input [`DIGI_BITS-1:0]  lane0_digi_data,
    input [`DIGI_BITS-1:0]  lane1_digi_data,
    input [`DIGI_BITS-1:0]  lane2_digi_data,
    input [`DIGI_BITS-1:0]  lane3_digi_data,

    input [`DIGI_BITS-1:0]  lane0_sim_data,
    input [`DIGI_BITS-1:0]  lane1_sim_data,
    input [`DIGI_BITS-1:0]  lane2_sim_data,
    input [`DIGI_BITS-1:0]  lane3_sim_data,
    
    output [`DIGI_BITS-1:0]  lane0_data,
    output [`DIGI_BITS-1:0]  lane1_data,
    output [`DIGI_BITS-1:0]  lane2_data,
    output [`DIGI_BITS-1:0]  lane3_data
);

//<statements>
   assign digi_lane0_re = !en_digi_sim && lane0_re;
   assign digi_lane1_re = !en_digi_sim && lane1_re;
   assign digi_lane2_re = !en_digi_sim && lane2_re;
   assign digi_lane3_re = !en_digi_sim && lane3_re;
   
   assign sim_lane0_re  =  en_digi_sim && lane0_re;
   assign sim_lane1_re  =  en_digi_sim && lane1_re;
   assign sim_lane2_re  =  en_digi_sim && lane2_re;
   assign sim_lane3_re  =  en_digi_sim && lane3_re;
   
   assign lane0_empty = (en_digi_sim) ?  sim_lane0_empty : digi_lane0_empty;
   assign lane1_empty = (en_digi_sim) ?  sim_lane1_empty : digi_lane1_empty;
   assign lane2_empty = (en_digi_sim) ?  sim_lane2_empty : digi_lane2_empty;
   assign lane3_empty = (en_digi_sim) ?  sim_lane3_empty : digi_lane3_empty;
   
   assign lane0_data = (en_digi_sim) ?  lane0_sim_data : lane0_digi_data;
   assign lane1_data = (en_digi_sim) ?  lane1_sim_data : lane1_digi_data;
   assign lane2_data = (en_digi_sim) ?  lane2_sim_data : lane2_digi_data;
   assign lane3_data = (en_digi_sim) ?  lane3_sim_data : lane3_digi_data;

endmodule

