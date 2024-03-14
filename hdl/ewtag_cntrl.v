///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: ewtag_cntrl.v
// File history:
//      11/18/2021 : first implementation
//      11/27/2021 : add ONSPILL and SPILL_EWTAG
//      02/16/2022 : increase depth of SPILLTAG FIFO to allow for events with very large hit no (up to overflow)
//      02/20/2022 : merged with DATAREQ_CNTRL, for which
//      02/03/2022 : add SM to control DATAREQ protocol after introducing PREFETCH on-demand
//                    (add input EVENT_START driven by DATAREQ_START_EVENT)
//      07/19/2023 : use START_SPILL to change handling of EWTAG_OFFSET on NEWSPILL 
//      17/02/2024 : removed SERIAL OFFSET input
//      28/02/2024 : add HB_TAG_FIFO and DREQ_FIFO
//      02/03/2024 : fixed PATTERN_INIT logic and EWTAG offset logic
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
    input   xcvrclk,                // 200 MHz XVCR RX clock
    input   resetn_xcvrclk,
	input	serdesclk,              // 150 MHz SERDES clock                           
	input	resetn_serdesclk,
	input	dreqclk,                // 80 MHz DREQ clock                            
	input	resetn_dreqclk,
    input   resetn_fifo,            // straigth from EXR_RST_N
    
    input   sysclk,
    input   sysclk_resetn,
    input   ew_we_store,                            // pulse on sysclk at start of DDR write
    output  [`EVENT_TAG_BITS-1:0]   hb_tag_out,     // HB tag for second DDR header word
    
    // exchanged with TOP SERDES on XCVR CLK
    input   evm_valid,              // pulse after (second) pair of HB+EVM is seen
    input   hb_valid,               // pulse on XCVR CLK when HB has been decoded
	input	[`SPILL_TAG_BITS-1:0]   spill_hbtag_in,	    // local SPILL EWTAG counter
	input   [`EVENT_TAG_BITS-1:0]   hb_event_window,    // current EWTAG from HB
        
    // on SERDES clock
	input	ew_fifo_emptied,    // at least one of the EWT_FIFOs can take data 
                                // cleaned of spurious pulses at EXT_RST and aligned with SERDESCLK 
        
    // to PATTERN_FIFO_FILLER
    output  reg  pattern_init,						    //  read next simulated cluster size
	output  reg  [`SPILL_TAG_BITS-1:0] spill_ewtag_out, //  SPILL EWTAG to be passed to EWT_FIFO
   
    // exchanged with TOP_SERDES on DREQCLK
    input   start_spill,        // pulse on NEWSPILL rising edge 
	input	start_fetch,        // FETCH observed (can be PREFETCH or DREQ)
    input   event_start,        // semaphone for DATA_READY!!
	input	[`EVENT_TAG_BITS-1:0]	event_window_fetch, // EWTAG on fetch (can be PREFETCH or DREQ)
	output reg	data_ready,     // level for the length of DREQ readout
	output reg	last_word,      // signals last packet send (unused in TOP_SERDES)
 
    input   start_read,
  	input	[`EVENT_TAG_BITS-1:0]	dreq_tag,      // DREQ event tag (not PREFETCH!)
  	output	[`EVENT_TAG_BITS-1:0]	dreq_tag_out,  // DREQ event tag (not PREFETCH!) on SYSCLK
  
    // exchanged with EW_FIFO_CONTROLLER
	input    tag_sent,			//	REQTAG has been sent to EVT_FIFOs
	input    tag_null,			//	REQTAG had no hits to send to EVT_FIFOs
	input    tag_done,			// EVT_FIFO has been emptied
    output  reg  ewtag_offset_seen,                    // to EW_FIFO_CNTRL: local spill EWTAG counter has restarted, ie first HB has been seen
	output  [`EVENT_TAG_BITS-1:0] ewtag_offset_out,    //                 : EWTAG_OFFSET updated with first HB of new spill
        
	// exchanged with EW_SIZE_STORE_AND_FETCH
	input	    tag_valid,		   // REQTAG (or PREFTAG) has been serviced in EW_SIZE_STORE_AND_FETCH_CNTRL
	output reg	tag_fetch,     // REQTAG (or PREFTAG) seen 	-> drive ew_size_store_and_fetch_cntrl/FETCH
    output reg  [`EVENT_TAG_BITS-1:0]	evt_tag_fetch,	// request window tag
        
    // diagnostics counters to DRACRegisters
    output  reg [31:0]  hb_cnt_onhold,
    output  reg [31:0]  hb_cnt,
    output  reg [31:0]  evm_end_cnt,
    output  reg [31:0]  dreq_cnt,
	output  reg [31:0]  start_fetch_cnt,
	output  reg [31:0]  tag_done_cnt,
	output  reg [31:0]  tag_null_cnt,
	output  reg [31:0]  tag_sent_cnt,
   
    output  reg[2:0]    ewtag_state,
    output  reg[1:0]    datareq_state,
    output  reg[15:0]   hb_empty_overlap_count,
    output  reg[15:0]   ew_fifo_emptied_count,
    output  reg[15:0]   tag_valid_count,
    output  reg[15:0]   tag_error_count,
    
    input   dreq_full,
    output  reg [`EVENT_TAG_BITS-1:0]   ewtag_dreq_full
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
reg     ewtag_offset_en, ewtag_offset_en1, ewtag_offset_en2, ewtag_offset_en3;
reg     ewtag_offset_re;

///////////////////////////////////////////////////////////////////////////////
// DATAREQ_STATE encoding (on DREQCLK)
///////////////////////////////////////////////////////////////////////////////
localparam [1:0]  IDLE  =  2'b00,
                  VALID =  2'b01,
                  LAST  =  2'b11;
                  
//reg   [1:0] datareq_state;
reg     tag_sent_hold;
reg     tag_null_hold;

reg	    is_first_spill;      // identifies very first spill at the beginning of the run
reg     ewtag_offset_valid;  // delayed copy of pulse on start of new SPILL
reg	    [`EVENT_TAG_BITS-1:0]	ewtag_offset_in;  // buffer for external register TAG or last TAG from PREFETCH/DREQ

//// for diagnostics
reg     tag_error;
reg     tag_error_reg;
reg     tag_valid_reg;

// for timing cross-domain FIFOs
wire    spilltag_full, spilltag_empty;
wire    [`SPILL_TAG_BITS-1:0]	spilltag_rdata;
wire    ewtag_offset_full, ewtag_offset_empty;

wire    hb_tag_full,    hb_tag_empty;
wire    dreq_tag_full,  dreq_tag_empty;
//
// CDC (Cross-Domain Clock) handshake for HB_VALID and EVM
// 1) start REQ on clk_fast signal and clear on "synchronized ACKNOWLEDGE"
// 2) synchronize REQ on clk_slow => REQ_SYNC
// 3) feed-back REQ_SYNC as acknowlegde => ACK_SYNC 
// 4) generate BUSY until ACKOWLEDGE is cleared
reg     hb_on_serdesclk;
reg     req, ack_req, ack_sync;
reg     req_latch, req_sync;
wire    busy;

reg     evm_on_serdesclk;
reg     reqE, ack_reqE, ack_syncE;
reg     req_latchE, req_syncE;
wire    busyE;

always@(posedge xcvrclk, negedge resetn_xcvrclk)
begin
    if(resetn_xcvrclk == 1'b0) 
    begin
        req     <= 0;
        reqE    <= 0;
        hb_cnt      <= 0;
        evm_end_cnt <= 0;
    end
    else
    begin
        ack_req	<= req_sync;
        ack_sync	<=	ack_req;
            
        if (hb_valid && !busy)	req <= 1'b1;
        else if (ack_sync)		req <= 1'b0;

        ack_reqE	<= req_syncE;
        ack_syncE	<=	ack_reqE;
            
        if (evm_valid && !busyE)	reqE <= 1'b1;
        else if (ack_syncE)		    reqE <= 1'b0;
        
        if (evm_valid)   evm_end_cnt <= evm_end_cnt + 1;
        if (hb_valid)    hb_cnt <= hb_cnt + 1;
    end
end	

assign 	busy    = req  || ack_sync;
assign 	busyE   = reqE || ack_syncE;

// synchronize the request on slow clock
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
    if(resetn_serdesclk == 1'b0) 
    begin   
        hb_on_serdesclk	<= 0;
        evm_on_serdesclk<= 0;
    end
	else
	begin
        hb_on_serdesclk <=	req_latch && !req_sync;
			
        req_latch   <=  req;
        req_sync    <=  req_latch;
            
        evm_on_serdesclk <=	req_latchE && !req_syncE;
			
        req_latchE   <=  reqE;
        req_syncE    <=  req_latchE;
 end
end


always@(posedge serdesclk, negedge resetn_serdesclk)
begin
   if(resetn_serdesclk == 1'b0)
   begin
		hb_cnt_onhold   <= 0;
		hb_error        <= 1'b0;
		ew_fifo_emptied_pulse   <= 1'b0;
		hold_ew_fifo_emptied	<= 1'b0;
      
		pattern_init   <= 1'b0;
		spilltag_re	   <= 1'b0;
		ewtag_state	   <= WAIT;
      
		ewtag_offset_en     <= 1'b0;
		ewtag_offset_en1    <= 1'b0;
		ewtag_offset_en2    <= 1'b0;
		ewtag_offset_en3    <= 1'b0;
		ewtag_offset_seen   <= 1'b0;
        ewtag_offset_re     <= 1'b0;
        
        hb_empty_overlap_count  <= 16'b0;
        ew_fifo_emptied_count   <= 16'b0;
	end
	else
	begin

		// HB counter rules:
		// - increase count on HEARTBEAT, decrease on EW_FIFO being emptied
		// - if simultaneous, give priority to HEARTBEAT
		// ** Use HB_ERROR to mark when HB_CNT_ONHOLD goes over size of SPILLTAG_FIFO **
		if(hb_cnt_onhold >= 65536)  hb_error <= 1'b1;
		else                        hb_error <= 1'b0;
		
        ew_fifo_emptied_pulse     <= ew_fifo_emptied;
      
		//if (hb_on_serdesclk && ew_fifo_emptied_pulse) hold_ew_fifo_emptied <= 1;
		if (evm_on_serdesclk && ew_fifo_emptied_pulse) hold_ew_fifo_emptied <= 1;
		hold_ew_fifo_emptied <= 0;
        
        if (ew_fifo_emptied == 1'b1)        ew_fifo_emptied_count  <= ew_fifo_emptied_count + 1'b1;
        if (hold_ew_fifo_emptied == 1'b1)   hb_empty_overlap_count <= hb_empty_overlap_count + 1'b1;
		
		//if (hb_on_serdesclk) 					                hb_cnt_onhold <= hb_cnt_onhold + 1;
		if (evm_on_serdesclk) 					                hb_cnt_onhold <= hb_cnt_onhold + 1;
		else if (ew_fifo_emptied_pulse || hold_ew_fifo_emptied) hb_cnt_onhold <= hb_cnt_onhold - 1;
      
        //
        // State Machine to control REN of SPILLTAG_FIFO and FIFOs WEN 
		case(ewtag_state)
      
        // at least one HB has been received
		WAIT:
		begin
			spilltag_re	<= 0;
            ewtag_offset_en <= 0;
            // MUST wait for (second) HB+EW to define a data window
			if (hb_cnt_onhold>0) ewtag_state <= READ;
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
		
		// start sto imulate event tag while waiting for SPILLTAG output to settle
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
            //if (spilltag_rdata == 20'b1) ewtag_offset_en <= 1;
            // use IS_FIRST_SPILL to enable EWTAG_OFFSET_EN
            if (is_first_spill) ewtag_offset_en<= 1;
            
			if (ew_fifo_emptied_pulse) ewtag_state <= WAIT;
		end
		
        default:
        begin
            ewtag_state	<=	WAIT;
        end
      
        endcase
      
        // read EWTAG_OFFSET after FIFO empty goes low and
        // generate EWTAG_OFFSET latch after waiting for EWTAG_OFFSET_OUT to settle
        ewtag_offset_en1    <= (ewtag_offset_en && !ewtag_offset_empty);
        ewtag_offset_en2    <= ewtag_offset_en1;
        ewtag_offset_en3    <= ewtag_offset_en2;
        ewtag_offset_seen   <= ewtag_offset_en3;
      
        ewtag_offset_re     <= ewtag_offset_en1 && !ewtag_offset_en2;
	end
end

// register EWT on DREQ_FULL
reg dreq_full_reg, dreq_full_latch, dreq_full_first;
always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)
    begin
        dreq_full_reg   <= 1'b0;
        dreq_full_latch <= 1'b0;
        dreq_full_first <= 1'b0;
        ewtag_dreq_full <= 0;
    end 
    else    
    begin
        dreq_full_reg   <= dreq_full;
        dreq_full_latch <= dreq_full_reg;
        // save only first TAG with DREQ full 
        if (dreq_full_first == 1'b0 && dreq_full_reg == 1'b1 && dreq_full_latch == 1'b0) begin
            ewtag_dreq_full  <= hb_tag_out;
            dreq_full_first <= 1'b1;
        end
    end
end


always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)
    begin
        is_first_spill      <= 1'b0;		
        ewtag_offset_valid  <= 1'b0;
		ewtag_offset_in     <= 0;
      
		tag_fetch       <=	1'b0;
        evt_tag_fetch	<=	0;
      
		data_ready	    <= 1'b0;
		last_word	    <= 1'b0;
		
        tag_error       <= 1'b0;
        dreq_cnt        <= 0;
        start_fetch_cnt   <= 0;
        tag_done_cnt    <= 0; 
        tag_null_cnt    <= 0; 
        tag_sent_cnt    <= 0; 
      
        tag_sent_hold   <= 1'b0;
        tag_null_hold   <= 1'b0;
        datareq_state   <= IDLE;
        
        tag_valid_reg   <= 1'b0;
        tag_error_reg   <= 1'b0;
        
        tag_valid_count <= 16'b0;
        tag_error_count <= 16'b0;
    end
    else
    begin
         
        if (ewtag_offset_en) is_first_spill <= 1'b0;
         
        // handle EWTAG offset at the start of SPILL using IS_FIRST_SPILL (cleared after it is used)
        // and the TAG od the first HB at start of a NEW SPILL
        if (start_spill) 
        begin
            is_first_spill    <= 1'b1;
            //ewtag_offset_in   <= (hb_event_window-1);
            ewtag_offset_in   <= hb_event_window;
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
            start_fetch_cnt<= start_fetch_cnt + 1'b1; 
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
            if (event_start)  begin
                datareq_state   <= VALID;
                dreq_cnt        <= dreq_cnt + 1;
            end
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
            if (tag_sent_cnt != start_fetch_cnt) tag_error <= 1'b1;
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
	.RE		(ewtag_offset_re),
	// Outputs
	.EMPTY	(ewtag_offset_empty),
	.FULL		(ewtag_offset_full),
	.Q			(ewtag_offset_out)	
);

//
// Cross time domain FIFO (48bit x 1024) for HB_TAG to be used in DDR header
LARGE_TAG_FIFO	hb_tag_fifo (
	.WCLOCK	(xcvrclk),
	.WRESET_N(resetn_fifo),
	.DATA	(hb_event_window),
	.WE		(hb_valid),
	.RCLOCK	(sysclk),
	.RRESET_N(resetn_fifo),
	.RE		(ew_we_store),
	// Outputs
	.EMPTY	(hb_tag_empty),
	.FULL	(hb_tag_full),
	.Q		(hb_tag_out)	
);

//
// Cross time domain FIFO (48bit x 64) for DREQ_TAG to be used in DDR header
EWTAG_FIFO	dreq_tag_fifo (
	.WCLOCK	(dreqclk),
	.WRESET_N(resetn_fifo),
	.DATA	(dreq_tag),
	.WE		(event_start),
	.RCLOCK	(sysclk),
	.RRESET_N(resetn_fifo),
	.RE		(start_read),
	// Outputs
	.EMPTY	(dreq_tag_empty),
	.FULL	(dreq_tag_full),
	.Q		(dreq_tag_out)	
);


endmodule

