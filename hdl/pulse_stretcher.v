///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pulse_stretcher.v
// File history:
//      v1 : 06/21	Added polarity input to deal with negative logic signals
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
 input	polarity_i,		// if 1/0, input is positive/negative login
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
reg         pulse_seen;
reg [N:0]   pulse_cnt;

wire			pulse;
assign		pulse = (polarity_i == 1'b1) ? pulse_i : !pulse_i;

 
always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
        pulse_seen <= 0;
        pulse_cnt <= { N {1'b0} };;
    end
    else
    begin
        if(pulse)						pulse_seen <= 1; 
        else if (pulse_cnt[N])	pulse_seen <= 0;

        if(pulse_seen)	pulse_cnt <= pulse_cnt + 1'b1;
        else				pulse_cnt <= { N {1'b0} };;
    end
end

assign gate_o = pulse_seen;   

endmodule
