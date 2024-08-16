///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: clus_pattern_sim.v
// File history:
//    v1.0: 07/2024:  first version
//    v2.0: 08/2024:  added NEWSPILL_RESET and HALTRUN_EN input                
//
// Description: 
//
//      Based on CLUS_PATTERN_CNTRL driving 4 ROCFIFOs simultaneously.
//		Simulates fixed-size data per event window by reading no. of clusters from external register.  
//		Generates 8x32-bit increasing counter (one hit covers 8 counts) REPEATED for every lane.
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author:Monica Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>
`include "tracker_params.vh"

module clus_pattern_sim( 
//global signals
    input	fifoclk,
    input	fifoclk_resetn,

    input   newspill_reset,
    input   haltrun_en,             // gate set by addr=8 bit[13]

    input	pattern_init,						    //	Event Window and Event payload start
    input   pattern_type,                           // if 0 => use 32-bit counter pattern; if 1 => use alternating 5s&As
//   input	[`TRK_HIT_BITS-1:0]		hit_in,	        // simulated tracker bit number from HIT_NO_TPSRAM [7:0]
    input	[9:0]		            hit_in,	        // allow more hits to check for overflow condition (0x200 hits fills header[31:20]!)
	input	[`SPILL_TAG_BITS-1:0]   ewtag_in,       // SPILLTAG from SPILLTAG_FIFO

    output reg pattern_we,   
   
    output reg [`DIGI_BITS-1:0]  pattern_data     // input data for ROCFIFO_SIM    
);
//<statements>

// state machine
localparam [2:0]    IDLE        =  3'b000,
                    SET_HEADER  =  3'b001, 
                    WRITE_HEADER=  3'b010, 
                    SET_DATA    =  3'b011, 
                    WRITE_DATA  =  3'b100, 
                    DONE        =  3'b101;
                  
reg [2:0]   wr_state;
reg [15:0]  word_cnt;
reg	[1:0]	hit_cnt;
reg			hit_filled;

reg   pattern_index;  // to switch between non-counter pattern; 

reg   [`DIGI_BITS-1:0]   counter_data; 

reg   [`DIGI_BITS-1:0]   header_data;
reg   [`DIGI_BITS-1:0]   payload_data;

//pattern output state machine
always@(posedge fifoclk, negedge fifoclk_resetn, posedge newspill_reset)
begin
    if(fifoclk_resetn == 1'b0)
    begin
        pattern_we  <=  0;
        pattern_data<=  0;
		counter_data<=  0;
        pattern_index   <= 1'b0;
        hit_filled  <=	0;
        word_cnt    <=	0;
        wr_state    <=	IDLE;
    end

    // do NOT reset data payload counter or 64-events sequence
    else if (newspill_reset == 1'b1)
    begin
        pattern_we  <=  0;
        pattern_data<=  0;
		if (!haltrun_en) counter_data<=  0;
        pattern_index   <= 1'b0;
        hit_filled  <=	0;
        word_cnt    <=	0;
        wr_state    <=	IDLE;
    end
    
    else
    begin

        hit_filled  <=	0;
        pattern_we  <=	0;
        
        case(wr_state)
        
        //wait for PATTERN_INIT command
        IDLE:
        begin
            if(pattern_init)wr_state <= SET_HEADER;
            else            wr_state <=	IDLE;
        end
            
        // generate header word with
        //    bit [31:20]  = event size (in units of DTC packer i.e. 128-bit words)
        //    bit [19:0]   = event tag as counter from start of SPILL  
        SET_HEADER:
        begin
            pattern_data[`SPILL_TAG_BITS-1:0]<= ewtag_in;
            pattern_data[31:20]              <= hit_in*2;
         
            wr_state<= WRITE_HEADER;
        end
         
        // write header word to ROCFIFO_SIM
        WRITE_HEADER:
        begin
        pattern_we  <=	1;         
            wr_state<= SET_DATA;
        end
         
        // set payload word (32-bit increasing counter)
        SET_DATA:
        begin
            word_cnt    <=	word_cnt + 1;
            if ( pattern_type == 1'b0 ) begin
                pattern_data<=  counter_data;
            end   else  begin
                pattern_index <= ~pattern_index;
                pattern_data<= (pattern_index == 1'b0) ? 32'H55555555 : 32'HAAAAAAAA;
            end;
//            pattern_data<=  counter_data;
            if (hit_in > 0) wr_state<=	WRITE_DATA;
            else            wr_state<=	DONE;
        end
        
        // generate and write pattern data for event payload to ROCFIFO_SIM      
        WRITE_DATA:
        begin
            pattern_we  <=	1; 
            if (word_cnt < hit_in*8)
            begin
                counter_data<=	counter_data + 1'b1;
                wr_state<=	SET_DATA;
            end
            else // ROCFIFO has been filled
            begin
                wr_state<=	DONE;
            end
        end
      
        // declare hit done and prepare for next RAM read
        DONE:
        begin
            hit_filled  <= 1;
            word_cnt    <=	0;
            counter_data<=	counter_data + 1'b1;
            wr_state    <= IDLE;
        end
		
        default:
        begin
            wr_state	<=	IDLE;
        end
      
        endcase
    end  
end

endmodule

