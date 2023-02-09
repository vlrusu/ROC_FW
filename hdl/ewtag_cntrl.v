///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: ewtag_cntrl.v
// File history:
//      11/18/2021 : first implementation
//      11/27/2021 : add ONSPILL and SPILL_EWTAG
//      02/16/2022 : increase depth of SPILLTAG FIFO to allow for events with very large hit no (up to overflow)
//      02/20/2022 : merged with DATAREQ_CNTRL, for which
//             v2:  02/03/2022: add SM to control DATAREQ protocol after introducing PREFETCH on-demand
//                               (add input EVENT_START driven by DATAREQ_START_EVENT)
//             v3:  02/08/2022: add handling of EWTAG_OFFSET on ONSPILL rising edge
//
// Description: 
//
// 
// Implement SPILLTAG_FIFO for local spill counter of HeartBeat requests that cannot be processed 
// because previous event tags are still being processed plus
// state machine to control the WEN/REN of the SPILLTAG_FIFO,
// as well PATTERN_INIT signal to simulated tags.
// Save EWTAG_OFFSET at the start of new SPILL and use EWTAG_FIFO to cross time domain boundaries.
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: Monica Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

`include "tracker_params.vh"

module ewtag_cntrl(
//global signals
    input xcvrclk,                               // XVCR RX clock
    input resetn_xcvrclk,
    input hb_valid,					               // pulse on XCVR CLK when HB has been decoded
    input hb_null_valid,					            // pulse on XCVR CLK when null HB has been decoded
    input pref_valid,					               // pulse on XCVR CLK when PREFETCH has been decoded
	input	[`SPILL_TAG_BITS-1:0] spill_hbtag_in,	// local SPILL EWTAG counter

// on 150 MHz SERDES clock
	input	serdesclk,                            
	input	resetn_serdesclk,
   
	input	ew_fifo_emptied,     // at least one of the EWT_FIFOs can take data 
                              // cleaned of spurious pulses at EXT_RST and aligned with SERDESCLK 
	
    output reg  pattern_init,						         // to PATTERN_FIFO_FILLER/CLUS_PATTERN_CNTRL: read next simulated cluster size
	output reg  [`SPILL_TAG_BITS-1:0] spill_ewtag_out,  //                                            SPILL EWTAG to be passed to EWT_FIFO
    output reg  ewtag_offset_latch,                    // to EW_FIFO_CNTRL: local spill EWTAG counter has restarted, ie first HB has been seen
	output      [`EVENT_TAG_BITS-1:0] ewtag_offset_out, //                   EWTAG_OFFSET updated with first HB of new spill
   
// on DREQCLK clk:
	input	dreqclk,                            
	input	resetn_dreqclk,
	input	[`EVENT_TAG_BITS-1:0] reg_ewtag_offset,	   // EW offset from external register
    
    input   resetn_fifo,        // straigth from EXR_RST_N
   
   // exchanged with TOP_SERDES
	input		start_fetch,                           // FETCH observed (can be PREFETCH or DREQ)
	input	[`EVENT_TAG_BITS-1:0]	event_window_fetch,  // EWTAG on fetch (can be PREFETCH or DREQ)
    input    event_start,      // semaphone for DATA_READY!!
    input    start_spill,      // pulse on SPILL rising edge	
	output reg	data_ready, // level for the length of DREQ readout
	output reg	last_word,  // signals last packet send (unused in TOP_SERDES)
	 
	// exchanged with EW_FIFO_CONTROLLER
	input    tag_sent,			//	REQTAG has been sent to EVT_FIFOs
	input    tag_null,			//	REQTAG had no hits to send to EVT_FIFOs
	input    tag_done,			// EVT_FIFO has been emptied
   
    // diagnostics counters
    output  reg [31:0]  hb_cnt,
    output  reg [31:0]  hb_seen_cnt,
    output  reg [31:0]  hb_null_cnt,
    output  reg [31:0]  pref_seen_cnt,
	output  reg [31:0]  start_tag_cnt,
	output  reg [31:0]  tag_done_cnt,
	output  reg [31:0]  tag_null_cnt,
	output  reg [31:0]  tag_sent_cnt,
   
    output  reg[2:0]    ewtag_state,
    output  reg[1:0]    datareq_state,
    output  reg[15:0]   hb_empty_overlap_count,
    output  reg[15:0]   ew_fifo_emptied_count,
    output  reg[15:0]   tag_valid_count,
    output  reg[15:0]   tag_error_count,

	// exchanged with EW_SIZE_STORE_AND_FETCH
	input	    tag_valid,		   // REQTAG (or PREFTAG) has been serviced in EW_SIZE_STORE_AND_FETCH_CNTRL
	output reg	tag_fetch,     // REQTAG (or PREFTAG) seen 	-> drive ew_size_store_and_fetch_cntrl/FETCH
    output reg  [`EVENT_TAG_BITS-1:0]	evt_tag_fetch	// request window tag
);

///////////////////////////////////////////////////////////////////////////////
// EWTAG_STATE encoding (on SERDESCLK)
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]    WAIT	=	3'b000,
                    READ	=	3'b001,	
                    START	=	3'b010, 
                    HOLD	=	3'b011; 

//reg	[2:0]   ewtag_state;
reg     hb_error;
reg     spilltag_re;
reg     ew_fifo_emptied_reg, ew_fifo_emptied_pulse;
reg     hold_ew_fifo_emptied;
reg     ewtag_offset_re, ewtag_offset_re1, ewtag_offset_re2, ewtag_offset_re3;
reg     ewtag_offset_pulse;

///////////////////////////////////////////////////////////////////////////////
// DATAREQ_STATE encoding (on DREQCLK)
///////////////////////////////////////////////////////////////////////////////
localparam [1:0]  IDLE  =  2'b00,
                  VALID =  2'b01,
                  LAST  =  2'b11;
                  
//reg   [1:0] datareq_state;
reg   tag_sent_hold;
reg   tag_null_hold;

reg	is_first_spill;      // identifies very first spill at the beginning of the run
reg   ewtag_offset_valid;  // delayed copy of pulse on start of new SPILL
reg	[`EVENT_TAG_BITS-1:0]	ewtag_offset_in;  // buffer for external register TAG or last TAG from PREFETCH/DREQ

//// for diagnostics
reg tag_error;
reg tag_error_reg;
reg tag_valid_reg;

// for timing cross-domain FIFOs
wire  spilltag_full, spilltag_empty;
wire  [`SPILL_TAG_BITS-1:0]	spilltag_rdata;
wire  ewtag_offset_full, ewtag_offset_empty;
//
// CDC (Cross-Domain Clock) handshake for HB_VALID
// 1) start REQ on clk_fast signal and clear on "synchronized ACKNOWLEDGE"
// 2) synchronize REQ on clk_slow => REQ_SYNC
// 3) feed-back REQ_SYNC as acknowlegde => ACK_SYNC 
// 4) generate BUSY until ACKOWLEDGE is cleared
reg   hb_on_serdesclk;
reg   req, ack_req, ack_sync;
reg   req_latch, req_sync;
wire	busy;

always@(posedge xcvrclk, negedge resetn_xcvrclk)
begin
   if(resetn_xcvrclk == 1'b0) 
   begin
      req <= 0;
      hb_seen_cnt    <= 0;
      hb_null_cnt    <= 0;
      pref_seen_cnt  <= 0;
   end
   else
   begin
      ack_req	<= req_sync;
      ack_sync	<=	ack_req;
	 
      if (hb_valid && !busy)	req <= 1'b1;
      else if (ack_sync)		req <= 1'b0;
      
      if (hb_valid)     hb_seen_cnt    <= hb_seen_cnt + 1;
      if (hb_null_valid)hb_null_cnt    <= hb_null_cnt + 1;
      if (pref_valid)   pref_seen_cnt  <= pref_seen_cnt + 1;
   end
end	

assign 	busy = req || ack_sync;

// synchronize the request on slow clock
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
   if(resetn_serdesclk == 1'b0) hb_on_serdesclk	<= 0;
	else
	begin
		hb_on_serdesclk	<=	req_latch && !req_sync;
			
		req_latch<= req;
		req_sync	<=	req_latch;
	end
end


always@(posedge serdesclk, negedge resetn_serdesclk)
begin
   if(resetn_serdesclk == 1'b0)
   begin
		hb_cnt		<= 0;
		hb_error    <= 1'b0;
		ew_fifo_emptied_pulse   <= 1'b0;
		hold_ew_fifo_emptied	<= 1'b0;
      
		pattern_init   <= 1'b0;
		spilltag_re	   <= 1'b0;
		ewtag_state	   <= WAIT;
      
		ewtag_offset_re   <= 1'b0;
		ewtag_offset_re1  <= 1'b0;
		ewtag_offset_re2  <= 1'b0;
		ewtag_offset_re3  <= 1'b0;
		ewtag_offset_latch<= 1'b0;
        ewtag_offset_pulse<= 1'b0;
        
        hb_empty_overlap_count <= 16'b0;
        ew_fifo_emptied_count <= 16'b0;
	end
	else
	begin

		// HB counter rules:
		// - increase count on HEARTBEAT, decrease on EW_FIFO being emptied
		// - if simultaneous, give priority to HEARTBEAT
		// ** Use HB_ERROR to mark when HB_CNT goes over size of SPILLTAG_FIFO **
		if(hb_cnt >= 65536)  hb_error <= 1'b1;
		else                 hb_error <= 1'b0;
		
        ew_fifo_emptied_pulse     <= ew_fifo_emptied;
      
		hold_ew_fifo_emptied <= 0;
		if (hb_on_serdesclk && ew_fifo_emptied_pulse) hold_ew_fifo_emptied <= 1;
        
        if (ew_fifo_emptied == 1'b1)        ew_fifo_emptied_count  <= ew_fifo_emptied_count + 1'b1;
        if (hold_ew_fifo_emptied == 1'b1)   hb_empty_overlap_count <= hb_empty_overlap_count + 1'b1;
		
		if (hb_on_serdesclk) 					                hb_cnt <= hb_cnt + 1;
		else if (ew_fifo_emptied_pulse || hold_ew_fifo_emptied) hb_cnt <= hb_cnt - 1;
      
        // diagnostic counters
        if (ew_fifo_emptied == 1'b1)        ew_fifo_emptied_count  <= ew_fifo_emptied_count + 1'b1;
        if (hold_ew_fifo_emptied == 1'b1)   hb_empty_overlap_count <= hb_empty_overlap_count + 1'b1;
		
        //
        // State Machine to control REN of SPILLTAG_FIFO and FIFOs WEN 
		case(ewtag_state)
      
        // at least one HB has been received
		WAIT:
		begin
			spilltag_re	<= 0;
            ewtag_offset_re <= 0;
			if (hb_cnt>0) ewtag_state <= READ;
		end

		// read SPILLTAG FIFO
        READ:
		begin
			if(!spilltag_empty) 
            begin
                spilltag_re <= 1;
                ewtag_state <= START;
            end
		end
		
		// start simulate event tag while waiting for SPILLTAG output to settle
		// (CLUS_PATTERN_CNTRL reads it one clock after seeing PATTERN_INIT anyway...)
		START:
		begin
			spilltag_re    <= 0;
			pattern_init   <= 1;
			ewtag_state    <= HOLD;
		end
		
        // Pass SPILLTAG output to simulated tag logic. 
        // Use restart of local tag count to mark start of new spill and generate latch for EWTAG offset 
        HOLD:
		begin
			pattern_init   <= 0;
			spill_ewtag_out<= spilltag_rdata;
            if (spilltag_rdata == 20'b1) ewtag_offset_re <= 1;
			if (ew_fifo_emptied_pulse) ewtag_state <= WAIT;
		end
		
        default:
        begin
            ewtag_state	<=	WAIT;
        end
      
        endcase
      
        // read EWTAG_OFFSET after FIFO empty goes low and
        // generate EWTAG_OFFSET latch after waiting for EWTAG_OFFSET_OUT to settle
        ewtag_offset_re1     <= (ewtag_offset_re && !ewtag_offset_empty);
        ewtag_offset_re2     <= ewtag_offset_re1;
        ewtag_offset_re3     <= ewtag_offset_re2;
        ewtag_offset_latch   <= ewtag_offset_re3;
      
        ewtag_offset_pulse   <= ewtag_offset_re1 && !ewtag_offset_re2;
	end
end


always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)
    begin
        is_first_spill    <= 1'b1;		
        ewtag_offset_valid<= 1'b0;
		ewtag_offset_in   <= 0;
      
		tag_fetch	   <=	1'b0;
        evt_tag_fetch	<=	0;
      
		data_ready	   <= 1'b0;
		last_word	   <= 1'b0;
		
        tag_error      <= 1'b0;
        start_tag_cnt  <= 0;
        tag_done_cnt   <= 0; 
        tag_null_cnt   <= 0; 
        tag_sent_cnt   <= 0; 
      
        tag_sent_hold  <= 1'b0;
        tag_null_hold  <= 1'b0;
        datareq_state  <= IDLE;
        
        tag_valid_reg   <= 1'b0;
        tag_error_reg   <= 1'b0;
        
        tag_valid_count <= 16'b0;
        tag_error_count <= 16'b0;
    end
    else
    begin
         
        // handle EWTAG offset at the start of SPILL:
        // can be from outside register, on very first spill of a run, OR from last DATAREQ
        if (start_spill) 
        begin
            if (is_first_spill)
            begin  
                is_first_spill    <= 1'b0;
                ewtag_offset_in   <= reg_ewtag_offset;
            end
        end
        // wait for EWTAG_OFFSET to settle: used as latch for EWTAG_OFFSET in EW_FIFO_CNTRL
        ewtag_offset_valid   <= start_spill;  
      
        //
        // generate FETCH TAG and its latch for EW_SIZE_AND_STORE_CNTRL
        // (can be either DATAREQ or PREFETCH)
        if (start_fetch)
        begin
            tag_fetch      <= 1'b1;
            evt_tag_fetch  <= event_window_fetch;
            start_tag_cnt  <= start_tag_cnt + 1'b1; 
        end
        else if (tag_valid) tag_fetch    <= 1'b0;
        
        //
        // buffer any TAG_SENT and TAG_NULL from EW_FIFO_CNTRL
        // (they can come early when using PREFETCH)
        if (tag_sent)  tag_sent_hold <= 1'b1;
        if (tag_null)  tag_null_hold <= 1'b1;
      
        //
        // DATAREQ protocol state machine
        last_word   <= 1'b0;
        tag_error   <= 1'b0;
        
        // diagnostic counters
        tag_valid_reg   <= tag_valid;
        if (tag_valid == 1'b1 && tag_valid_reg == 1'b0) tag_valid_count <= tag_valid_count + 1'b1;
        tag_error_reg   <= tag_error;  
        if (tag_error == 1'b1 && tag_error_reg == 1'b0) tag_error_count <= tag_error_count + 1'b1;
      
        case(datareq_state)
      
        // wait for DATAREQ_EVENT_START to proceed
        IDLE:
        begin
            if (event_start)  datareq_state <= VALID;
        end
      
        // use (buffered) TAG_SENT to issue DATAREQ_DATA_VALID
        VALID:
        begin
            if (tag_sent_hold) 
            begin
                data_ready     <= 1'b1;
                tag_sent_hold  <= 1'b0;
                tag_sent_cnt   <= tag_sent_cnt + 1'b1;   
                datareq_state  <= LAST;
            end
        end
      
        // wait for TAG_DONE or (buffered) TAG_NULL to clear DATAREQ_DATA_VALID and issue DATAREQ_LAST_WORD
        LAST:
        begin
            if (tag_sent_cnt != start_tag_cnt) tag_error <= 1'b1;
            if (tag_done || tag_null_hold) 
            begin
                data_ready     <= 1'b0;
                last_word      <= 1'b1;
                tag_null_hold  <= 1'b0;
                datareq_state  <= IDLE;
                
                // for diagnostics
                if (tag_done)  tag_done_cnt<= tag_done_cnt + 1'b1;
                
                if (tag_null_hold)  
                begin
                    tag_done_cnt<= tag_done_cnt + 1'b1;
                    tag_null_cnt<= tag_null_cnt + 1'b1;
                end
            end
        end
      
        endcase
	end
end	


//
// SPILLTAG_FIFOs (20bx4K) to buffer local EWTAG counter for duration of the SPILL
SPILLTAG_FIFO	spilltag_fifo0 (
	.WCLOCK	(xcvrclk),
	.WRESET_N(resetn_fifo),
	.DATA	   (spill_hbtag_in),
	.WE		(hb_valid),
	.RCLOCK	(serdesclk),
	.RRESET_N(resetn_fifo),
	.RE		(spilltag_re),
	// Outputs
	.EMPTY	(spilltag_empty),
	.FULL	   (spilltag_full ),
	.Q       (spilltag_rdata)
);

//
// Cross time domain FIFO (48bit x 64) for EWTAG_OFFSET bus at the start of SPILL
EWTAG_FIFO	ewtag_fifo_offset (
	.WCLOCK	(dreqclk),
	.WRESET_N(resetn_fifo),
	.DATA		(ewtag_offset_in),
	.WE		(ewtag_offset_valid),
	.RCLOCK	(serdesclk),
	.RRESET_N(resetn_fifo),
	.RE		(ewtag_offset_pulse),
	// Outputs
	.EMPTY	(ewtag_offset_empty),
	.FULL		(ewtag_offset_full),
	.Q			(ewtag_offset_out)	
);


endmodule

