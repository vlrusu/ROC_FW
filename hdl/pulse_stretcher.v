///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pulse_stretcher.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//    Extend pulse to gate of N clks length
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pulse_stretcher(
 input   clk_i, 
 input   resetn_i, 
 input   pulse_i,	 
 output  gate_o							
);
///////////////////////////////////////////////////////////////////////////////
// Parameters
///////////////////////////////////////////////////////////////////////////////
parameter N = 4;

///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
reg         pulse_i_seen;
reg [N:0]   pulse_i_cnt;

assign gate_o = pulse_i_seen;   

 
always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        pulse_i_seen <= 0;
        pulse_i_cnt <= { N {1'b0} };;
    end
    else
    begin
        if(pulse_i)                	pulse_i_seen <= 1; 
        else if (pulse_i_cnt[N])    pulse_i_seen <= 0;

        if(pulse_i_seen)        pulse_i_cnt <= pulse_i_cnt + 1'b1;
        else                    pulse_i_cnt <= { N {1'b0} };;
    end
end

endmodule
