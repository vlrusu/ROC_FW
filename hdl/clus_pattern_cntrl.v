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

module clus_pattern_cntrl #( 
	parameter 	NROCFIFO    =	1     // no. of ROCFIFOs
)(
//global signals
    input	serdesclk,
    input   serdesclk_resetn,
    
    input   newspill_reset,
    input   haltrun_en,             // gate set by addr=8 bit[13]

    input   pattern_init,						//	Event Window and Event payload start
	input	ddr_done,					        //	event has been read from EW_FIFO and written to DDR
//   input	[`TRK_HIT_BITS-1:0]		hit_in,	        // simulated tracker bit number from HIT_NO_TPSRAM 
    input	[9:0]		            hit_in,	        // allow more hits to check for overflow condition (0x200 hits fills header[31:20]!)
	input	[`SPILL_TAG_BITS-1:0]   ewtag_in,       // SPILLTAG from SPILLTAG_FIFO
    input   pattern_type,                           // if 0 => use 32-bit counter pattern; if 1 => use alternating 5s&As

    output pattern_we0,   
    //output pattern_we1,   
    //output pattern_we2,   
    //output pattern_we3,   
   
    output [`DIGI_BITS-1:0]  pattern_data0,     // SIM_ROC_FIFO0 input data
    //output [DIGI_BITS-1:0]   pattern_data1,     // SIM_ROC_FIFO1 input data
    //output [DIGI_BITS-1:0]   pattern_data2,     // SIM_ROC_FIFO2 input data
    //output [DIGI_BITS-1:0]   pattern_data3,     // SIM_ROC_FIFO3 input data

    output reg  hit_re,         	// read enable to   HIT_NO_TPSRAM
    output reg  [5:0] hit_rdaddr,   // read address to  HIT_NO_TPSRAM
	// diagnostics outputs (for now)
	output reg  hit_over,			// too many HIT_FILLED
	output reg	hit_under,			// too many DDR_DONE
	output reg	hit_error			// HIT_CNT is at 3 (only 0 thru 2 allowed)	
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

reg   is_shared;

reg   is_header;
reg   [`DIGI_BITS-1:0]   counter_data; 

reg   pattern_index;  // to switch between non-counter pattern; 

reg [NROCFIFO-1:0]  pattern_we;
assign pattern_we0 = pattern_we[0];
//assign pattern_we1 = pattern_we[1];
//assign pattern_we2 = pattern_we[2];
//assign pattern_we3 = pattern_we[3];

reg   [`DIGI_BITS-1:0]   header_data[NROCFIFO-1:0];
reg   [`DIGI_BITS-1:0]   payload_data[NROCFIFO-1:0];

assign pattern_data0 = (is_header == 1'b1) ? header_data[0]  : payload_data[0];
//assign pattern_data1 = (is_header == 1'b1) ? header_data[1]  : payload_data[1];
//assign pattern_data2 = (is_header == 1'b1) ? header_data[2]  : payload_data[2];
//assign pattern_data3 = (is_header == 1'b1) ? header_data[3]  : payload_data[3];

integer index;          // index for current SIM_ROC_FIFO
integer event_index;    // index for bouncing writing payload between SIM_ROC_FIFO
//pattern output state machine
always@(posedge serdesclk, negedge serdesclk_resetn, posedge newspill_reset)
begin
    if(serdesclk_resetn == 1'b0)
    begin
        index       = 0;
        event_index = 0;
        pattern_we  <=  0;
        is_header   <=  0;
        is_shared   <=  0;
		header_data[0]  <=  0;
		//header_data[1] <= 0;
		//header_data[2] <= 0;
		//header_data[3] <= 0;
		payload_data[0] <=  0;
		//payload_data[1]<=	0;
		//payload_data[2]<=	0;
		//payload_data[3]<=	0;
        
		counter_data<=  -1'b1;
        pattern_index   <= 1'b0;
        hit_filled  <=	0;
        hit_re     	<=	0;
        hit_rdaddr 	<=	0; 
		hit_cnt		<=  0;
		hit_under	<=  0;
		hit_over	<=  0;
		hit_error	<=  0;
        word_cnt    <=	0;
        wr_state    <=	IDLE;
    end
    
    // do NOT reset data payload counter or 64-events sequence in HATLRUN mode
    else if (newspill_reset == 1'b1)
    begin
        index       = 0;
        event_index = 0;
        pattern_we  <=  0;
        is_header   <=  0;
        is_shared   <=  0;
		header_data[0]  <=  0;
        payload_data[0] <=  0;
        
		if (!haltrun_en) counter_data<=  -1'b1;
        pattern_index   <= 1'b0;
        hit_filled  <=	0;
        hit_re     	<=	0;
        if (!haltrun_en) hit_rdaddr 	<=	0; 
		hit_cnt		<=  0;
		hit_under	<=  0;
		hit_over	<=  0;
		hit_error	<=  0;
        word_cnt    <=	0;
        wr_state    <=	IDLE;
    end

    else
    begin
        hit_re      <=	0;
        hit_filled  <=	0;
        pattern_we  <=	0;
        word_cnt    <=	0;
		
		// diagnostic for logic errors
		if (ddr_done && hit_cnt==0)	    hit_under	<= 1;
		if (hit_filled && hit_cnt==2)	hit_over    <= 1;
		if (hit_cnt==3) 				hit_error   <= 1;
		
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
            pattern_we[index]   <=  0;
            word_cnt            <=  0;
            wr_state            <=	WAIT1;
        end
      
        // add extra wait to ease timing
        WAIT1:
        begin
            pattern_we[index]   <=	0;
            word_cnt            <=  0;
            wr_state            <=	HEADER;
        end
      
        // generate header word with SIZE in units of packets
        HEADER:
        begin
            is_header           <= 1;
            pattern_we[index]   <=	1;
            
            // handle special case of hit sharing for event with 32(512) hits
            //if (hit_in==32)  
            if (hit_in==512) 
            begin
                is_shared <= 1;
                header_data[index][`SPILL_TAG_BITS-1:0] <= ewtag_in;
                if (NROCFIFO==1)        header_data[index][31:20] <= hit_in*8;
                else if (NROCFIFO==2)   header_data[index][31:20] <= hit_in*4; 
                else if (NROCFIFO==4)   header_data[index][31:20] <= hit_in*2;
            end
            else
            begin
                is_shared <= 0;
                header_data[index][`SPILL_TAG_BITS-1:0] <= ewtag_in;
                if (index == event_index)   header_data[index][31:20] <= hit_in*8;
                else                        header_data[index][31:20] <= 0;	
            end
         
            wr_state<= WRITE;
        end
         
        // generate and write pattern data for event payload to SIM_ROC_FIFO      
        WRITE:
        begin
            is_header   <= 0;
         
            //if (hit_in==32)  
            if (hit_in==512) 
            begin
                
                if ((NROCFIFO==1 && word_cnt < hit_in*8) || 
                    (NROCFIFO==2 && word_cnt < hit_in*4) ||                   
                    (NROCFIFO==4 && word_cnt < hit_in*2)   )
                begin
                    word_cnt	        <=	word_cnt + 1;
                    counter_data        <=	counter_data + 1'b1;
                    if ( pattern_type == 1'b0 ) begin
                        payload_data[index] <=  counter_data + 1'b1;
                    end   else  begin
                        pattern_index <= ~pattern_index;
                        payload_data[index] <= (pattern_index == 1'b0) ? 32'H55555555 : 32'HAAAAAAAA;
                    end;
                    pattern_we[index]   <=  1;
                end
                else // SIM_ROC_FIFO has been filled: update INDEX and go to next state
                begin
                    if (index < (NROCFIFO-1) )
                    begin
                        index   = index + 1;
                        wr_state<= WAIT;
                    end
                    else  // last INDEX
                    begin
                        index   = 0;
                        wr_state<=	READ;
                    end
                end
            end
                
            else  // any other HIT_IN value
            begin
                
                if (index == event_index)  // write PAYLOAD to SIM_ROC_FIFO on a rotation basis
                begin
                    if (word_cnt < hit_in*8)
                    begin
                        word_cnt	        <=	word_cnt + 1;
                        counter_data        <=	counter_data + 1'b1;
                        if ( pattern_type == 1'b0 ) begin
                            payload_data[index] <=  counter_data + 1'b1;
                        end   else  begin
                            pattern_index <= ~pattern_index;
                            payload_data[index] <= (pattern_index == 1'b0) ? 32'H55555555 : 32'HAAAAAAAA;
                        end;
                         pattern_we[index]   <=  1;
                    end
                    else // SIM_ROC_FIFO has been filled: update INDEX and go to next state
                    begin
                        if (index < (NROCFIFO-1) )
                        begin
                            index   = index + 1;
                            wr_state<= WAIT;
                        end
                        else  // last INDEX
                        begin
                            index   = 0;
                            wr_state<=	READ;
                        end
                    end
                end
                else  // not the SIM_ROC_FIFO to fill for this event
                begin
                    if (index < (NROCFIFO-1) )
                    begin
                        index   = index + 1;
                        wr_state<= WAIT;
                    end
                    else  // last INDEX
                    begin
                        index   = 0;
                        wr_state<=	READ;
                    end
                end
            end
        end
      
        // declare cluster done and prepare for next RAM read
        READ:
        begin
            hit_filled  <= 1;
            hit_rdaddr  <= hit_rdaddr + 1;
            
            pattern_we[index] <=	0;
            word_cnt          <=	0;
         
            // increase event index
            if (event_index == (NROCFIFO-1)) event_index = 0;
            else                             event_index = event_index + 1;
         
            is_shared   <= 0;
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

