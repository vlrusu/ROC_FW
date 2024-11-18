///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pulse_stretcher.v
// File history:
//      v1 : 06/21	Added polarity input to deal with negative logic signals
//      v2 : 11/24	Added negative polarity output
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//    Extend pulse to gate of N clks length.
//    NB: Output is ALWAYS positive logic!
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pulse_stretcher(
 input  clk_i, 
 input  polarity_i,		// if 1/0, input is positive/negative logic
 input  resetn_i, 
 input  pulse_i,	 
 output gate_o,							
 output ngate_o							
);
///////////////////////////////////////////////////////////////////////////////
// Parameters
///////////////////////////////////////////////////////////////////////////////
parameter N = 4;

// signals to ignore PULSE on initial reset
localparam  [7:0] WAIT_FOR_RST =  8'hF0; 
reg[7:0] wait_cnt;
reg		wait_after_rst;

///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
reg         pulse_seen;
reg [N:0]   pulse_cnt;

wire		pulse;
assign		pulse = (polarity_i == 1'b1) ? pulse_i : !pulse_i;

always@(posedge clk_i, negedge resetn_i)
begin
    if(resetn_i == 1'b0)
    begin
		wait_after_rst  <= 1'b1;
		wait_cnt	    <= 1'b0;
        
        pulse_seen      <= 1'b0;
        pulse_cnt       <= { N {1'b0} };;
    end
    else
    begin
		// count some clocks after a reset to picking up PULSE too soon
		if (wait_after_rst)	wait_cnt    <=	wait_cnt + 1;
      
		if (wait_cnt > WAIT_FOR_RST) begin
            wait_after_rst	<=	0;
            
            if  (pulse) pulse_seen <= 1'b1; 
            else if (pulse_cnt[N])	pulse_seen <= 1'b0;
            
            if(pulse_seen)	pulse_cnt <= pulse_cnt + 1'b1;
            else			pulse_cnt <= { N {1'b0} };;
        end
    end
end

assign gate_o   = pulse_seen;   
assign ngate_o  = !pulse_seen;   

endmodule
