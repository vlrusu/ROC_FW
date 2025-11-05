///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: clus_pattern_cntrl.v
// File history:
//    v1.0: 10/2021:  first version
//    v2.0: 12/2021:  added event header word as:
//                            [31:20]  = event size (in units of 32-bit words)
//                            [19:0]   = event tag as counter from start of SPILL  
//    v3.0: 01/2022:  added generation of data to multiple SIM_ROC_FIFOs on a rotating basis                 
//    v4.0: 07/2024:  added PATTERN_TYPE input                 
//    v5.0: 08/2024:  added NEWSPILL_RESET and HALTRUN_EN input                 
//    v6.0: 03/2025:  remove 4 SIM_FIFO simulation                
//    v7.0: 08/2025:  remove HALTRUN_EN and NEWSPILL_RESET inputs              
//
// Description: 
//
//		Simulates variable data size per event window by reading no. of clusters from HIT_NO_TPSRAM 
//		and generating 8x32-bit patterns per cluster with an increasing 32-bit counter.
//      Use DDR_DONE as semaphore to control one EW_FIFO filling up with data while the other is written to DDR.   
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author:Monica Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>
`include "tracker_params.vh"

module clus_pattern_cntrl
(
//global signals
    input	serdesclk,
    input   serdesclk_resetn,
    
    input   pattern_init,						//	Event Window and Event payload start
	input	ddr_done,					        //	event has been read from EW_FIFO and written to DDR
//   input	[`TRK_HIT_BITS-1:0]		hit_in,	        // simulated tracker bit number from HIT_NO_TPSRAM 
    input	[9:0]		            hit_in,	        // allow more hits to check for overflow condition (0x200 hits fills header[31:20]!)
	input	[`SPILL_TAG_BITS-1:0]   ewtag_in,       // SPILLTAG from SPILLTAG_FIFO
    input   pattern_type,                           // if 0 => use 32-bit counter pattern; if 1 => use alternating 5s&As

    output reg  pattern_we,   
   
    output [`DIGI_BITS-1:0]  pattern_data,     // SIM_ROC_FIFO0 input data

    output reg  hit_re,         	// read enable to   HIT_NO_TPSRAM
    output reg  [5:0] hit_rdaddr    // read address to  HIT_NO_TPSRAM
);
//<statements>

// state machine
localparam [2:0]    IDLE  =  3'b000,
                    VALID =  3'b001,
                    WAIT  =  3'b010,
                    HEADER=  3'b011, 
                    WRITE =  3'b100,
                    READ  =  3'b101, 
                    COUNT =  3'b110, 
                    WAIT1 =  3'b111;
                  
reg [2:0]   wr_state;
reg [15:0]  word_cnt;
reg	[1:0]	hit_cnt;
reg			hit_filled;

//reg   is_shared;

reg   is_header;
reg   [`DIGI_BITS-1:0]   counter_data; 

reg   pttrn_index;  // to switch between non-counter pattern; 

reg   [`DIGI_BITS-1:0]   header_data;
reg   [`DIGI_BITS-1:0]   payload_data;
assign pattern_data = (is_header == 1'b1) ? header_data  : payload_data;


//pattern output state machine
always@(posedge serdesclk, negedge serdesclk_resetn)
begin
    if(serdesclk_resetn == 1'b0)
    begin
        //index       = 0;
        //event_index = 0;
        pattern_we  <=  0;
        is_header   <=  0;
		header_data  <=  0;
        payload_data <=  0;
        
		counter_data<=  -1'b1;
        pttrn_index <= 1'b0;
        hit_filled  <=	0;
        hit_re     	<=	0;
        hit_rdaddr 	<=	0; 
		hit_cnt		<=  0;
        word_cnt    <=	0;
        wr_state    <=	IDLE;
    end
    
    else
    
    begin
        hit_re      <=	0;
        hit_filled  <=	0;
        pattern_we  <=	0;
        word_cnt    <=	0;
        		
		// if HIT_FILLED is simultaneous to DDR_DONE, retrigger it so we don't miss it.
		if (ddr_done && hit_filled) 	hit_filled   <= 1;	
		
		// give priority to DDR_DONE because it is generated externally (by the end of AXI DDR write)
		if	(ddr_done && hit_cnt>0) 	hit_cnt  <= hit_cnt - 1'b1;
		else if (hit_filled) 			hit_cnt  <=	hit_cnt	+ 1'b1;
      
        case(wr_state)
        
        //wait for PATTERN_INIT command
        IDLE:
        begin
            if(pattern_init)  wr_state <= VALID;
        end
       
        // read RAM
        VALID:
        begin
            if (hit_cnt < 2)
            begin
                hit_re	<=	1'b1;
                wr_state<=	WAIT;
            end
        end
      
        // wait for no. of hits in event from RAM data
        WAIT:
        begin
            pattern_we  <=  0;
            word_cnt            <=  0;
            wr_state            <=	WAIT1;
        end
      
        // add extra wait to ease timing
        WAIT1:
        begin
            pattern_we  <=  0;
            word_cnt            <=  0;
            wr_state            <=	HEADER;
        end
      
        // generate header word with SIZE in units of packets
        HEADER:
        begin
            is_header   <= 1;
            pattern_we  <=	1;
            
            header_data[`SPILL_TAG_BITS-1:0]<= ewtag_in;
            header_data[31:20]              <= hit_in*8;
            
            wr_state<= WRITE;
        end
         
        // generate and write pattern data for event payload to SIM_ROC_FIFO      
        WRITE:
        begin
            is_header   <= 0;
            
            if (word_cnt < hit_in*8)
            begin
                word_cnt    <=	word_cnt + 1;
                counter_data<=	counter_data + 1'b1;
                pattern_we  <=	1;
                if ( pattern_type == 1'b0 ) begin
                    payload_data <=  counter_data + 1'b1;
                end   
                else  
                begin
                    pttrn_index <= ~pttrn_index;
                    payload_data <= (pttrn_index == 1'b0) ? 32'H55555555 : 32'HAAAAAAAA;
                end;
            end
            else
            // SIM_ROC_FIFO has been filled: go to next state
            begin
                wr_state<=	READ;
            end
        end
               
        // declare cluster done and prepare for next RAM read
        READ:
        begin
            hit_filled  <= 1;
            hit_rdaddr  <= hit_rdaddr + 1;
            
            pattern_we  <= 0;
            word_cnt          <=	0;
         
            wr_state    <= IDLE;
        end
		
        default:
        begin
            is_header   <= 0;
            hit_rdaddr	<=	0; 
            wr_state	<=	IDLE;
        end
      
        endcase
    end  
end

endmodule

