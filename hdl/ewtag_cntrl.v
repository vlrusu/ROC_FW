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
//      02/17/2024 : removed SERIAL OFFSET input
//      02/28/2024 : add HB_TAG_FIFO and DREQ_FIFO
//      03/02/2024 : fixed PATTERN_INIT logic by changing HB_CNT_ONHOLD count up only after full event window is seen. 
//                   Also adjust EWTAG_OFFSET_IN definition to be in sync with HB_EVENT_WINDOW
//      06/20/2024 : fixed HOLD_EW_FIFO_EMPTIED logic
//      07/02/2024 : add START_SPILL on fiber clock
//      07/16/2024 : rename START_SPILL to NEW_SPILL_ON_SERDESCLK. Use to simplify EWTAG_OFFSET_EN logic.
//      07/18/2024 : Allow EW_FIFO_EMPTIED to be simultaneous with EWM
//      07/24/2024 : Use FIRST_HB_SEEN to write to EWTAG_FIFO_OFFSET
//      08/01/2024 : Add SPILL_TAG_ROLLOVER
//      08/06/2024 : Fix HB_CNT_ONHOLD count down logic: use HOLD_EW_FIFO_EMPTIED to count down after count up has happened
//      08/08/2024 : Fix SPILLTAG_FIFO write enable to use END_EVM_SEEN
//      03/24/2025 : Register RE of LARGE_TAG_FIFO to help timing. Remove HB_ON_SERDESCLK logic. Changed W_EN of SPILLTAG_ROLLOVER FIFO
//      08/28/2025 : Eliminate NEWSPILL edge reset logic
//      10/30/2025 : Anticipate WE of EWTAG FIFO from EVENT_START to START_FETCH to avoid hb_tag_errors
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
    input   resetn_sysclk,
    input   ew_we_store,                            // pulse on sysclk at start of DDR write
    output  [`EVENT_TAG_BITS-1:0]   hb_tag_out,     // HB tag for second DDR header word
    
    // exchanged with TOP SERDES on XCVR CLK
    input   end_evm_seen,           // pulse after (second) pair of EVM is seen
    input   hb_seen,                // pulse on XCVR CLK when HB has been decoded
    input   first_hb_seen,          // pulse on XCVR CLK when first HB of a spill has been decoded
	input	[`SPILL_TAG_BITS-1:0]   spill_hbtag_in,	    // local SPILL EWTAG counter
	input   [`EVENT_TAG_BITS-1:0]   hb_event_window,    // current EWTAG from HB

    input   [`SPILL_TAG_BITS-1:0]   spill_hbtag_rollover_in, // 20 MSB of local SPILL EWTAG counter
    
    // on SERDES clock
    input   new_spill_on_serdesclk,   // pulse on NEWSPILL rising edge 
	input	ew_fifo_emptied,    // at least one of the EWT_FIFOs can take data 
                                // cleaned of spurious pulses at EXT_RST and aligned with SERDESCLK 
        
    // to PATTERN_FIFO_FILLER
    output  reg  pattern_init,						    //  read next simulated cluster size
	output  reg  [`SPILL_TAG_BITS-1:0] spill_ewtag_out, //  SPILL EWTAG to be passed to EWT_FIFO
   
    // exchanged with TOP_SERDES on DREQCLK
	input	start_fetch,            // FETCH observed (can be PREFETCH or DREQ)
    input   event_start,            // semaphone for DATA_READY!!
	input	[`EVENT_TAG_BITS-1:0]	event_window_fetch, // EWTAG on fetch (can be PREFETCH or DREQ)
	output reg	data_ready,         // level for the length of DREQ readout
	output reg	last_word,          // signals last packet send (unused in TOP_SERDES)
 
    input   start_read,
  	input	[`EVENT_TAG_BITS-1:0]	dreq_tag,      // DREQ event tag (not PREFETCH!)
  	output	[`EVENT_TAG_BITS-1:0]	dreq_tag_out,  // DREQ event tag (not PREFETCH!) on SYSCLK
  
    // exchanged with EW_FIFO_CONTROLLER
	input    tag_sent,			//	REQTAG has been sent to EVT_FIFOs
	input    tag_null,			//	REQTAG had no hits to send to EVT_FIFOs
	input    tag_done,			// EVT_FIFO has been emptied
    output  reg  ewtag_offset_seen,                    // to EW_FIFO_CNTRL: local spill EWTAG counter has restarted, ie first HB has been seen
	output  [`EVENT_TAG_BITS-1:0] ewtag_offset_out,    //                 : EWTAG_OFFSET updated with first HB of new spill
        
    input   ew_empty_ren,       // use to read SPILLTAG_ROLLOVER FIFO 
    output  [`SPILL_TAG_BITS-1:0]   spill_hbtag_rollover_out, // 20 MSB of local SPILL EWTAG counter 
    
	// exchanged with EW_SIZE_STORE_AND_FETCH
	input	    tag_valid,		    // REQTAG (or PREFTAG) has been serviced in EW_SIZE_STORE_AND_FETCH_CNTRL
	output reg	tag_fetch,          // REQTAG (or PREFTAG) seen 	-> drive ew_size_store_and_fetch_cntrl/FETCH
    output reg  [`EVENT_TAG_BITS-1:0]	evt_tag_fetch,	// request window tag
        
    // diagnostics counters to DRACRegisters
    output  reg [31:0]  hb_cnt_onhold,
    output  reg [31:0]  evm_end_cnt,
    output  reg [31:0]  dreq_cnt,
	output  reg [31:0]  start_fetch_cnt,
	output  reg [31:0]  tag_done_cnt,
	output  reg [31:0]  tag_null_cnt,
	output  reg [31:0]  tag_sent_cnt,
   
    output  reg[2:0]    ewtag_state,
    output  reg[1:0]    datareq_state,
    output  reg[15:0]   hb_empty_overlap_count, // counter of event with simultaneous up and down count of HB_CNT_ONHOLD
    output  reg[15:0]   ew_fifo_emptied_count,  // counter of ALL events writtent to DDR
    output  reg[15:0]   tag_valid_count,
    output  reg[15:0]   tag_error_count,
    
    input   dreq_full,
    output  reg[15:0]   dreq_full_count,
    output  reg [`EVENT_TAG_BITS-1:0]   ewtag_dreq_full,
    
    output  reg[15:0]   hb_tag_full_count,
    output  reg[15:0]   spilltag_full_count
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
reg     hold_ew_fifo_emptied;
reg     ewtag_offset_en, ewtag_offset_latch, ewtag_offset_reg;
reg     ewtag_offset_re;
reg[1:0]     ewtag_state_cnt;

///////////////////////////////////////////////////////////////////////////////
// DATAREQ_STATE encoding (on DREQCLK)
///////////////////////////////////////////////////////////////////////////////
localparam [1:0]  IDLE  =  2'b00,
                  VALID =  2'b01,
                  LAST  =  2'b11;
                  
reg[1:0]    datareq_state_cnt;
reg     tag_sent_hold;
reg     tag_null_hold;

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

wire    spilltag_rollover_full, spilltag_rollover_empty;    

//
// CDC (Cross-Domain Clock) handshake for hb_seen and EVM
// 1) start REQ on clk_fast signal and clear on "synchronized ACKNOWLEDGE"
// 2) synchronize REQ on clk_slow => REQ_SYNC
// 3) feed-back REQ_SYNC as acknowlegde => ACK_SYNC 
// 4) generate BUSY until ACKOWLEDGE is cleared
reg     evm_on_serdesclk;
reg     reqE, ack_reqE, ack_syncE, ack_syncE2;
reg     req_latchE, req_syncE, req_syncE2;
wire    busyE;

always@(posedge xcvrclk, negedge resetn_xcvrclk)
begin
    if(resetn_xcvrclk == 1'b0) 
    begin
        reqE    <= 0;
        evm_end_cnt <= 0;
    end
    else
    begin
        ack_reqE	<= req_syncE2;
        ack_syncE	<=	ack_reqE;
        ack_syncE2	<=	ack_syncE;
            
        if (end_evm_seen && !busyE)	reqE <= 1'b1;
        else if (ack_syncE2)		reqE <= 1'b0;
        
        if (end_evm_seen)   evm_end_cnt <= evm_end_cnt + 1;
    end
end	

assign 	busyE   = reqE || ack_syncE2;

// synchronize the request on slow clock
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
    if(resetn_serdesclk == 1'b0) 
    begin   
        evm_on_serdesclk<= 0;
    end
	else
	begin
        evm_on_serdesclk <=	req_syncE && !req_syncE2;
			
        req_latchE   <=  reqE;
        req_syncE    <=  req_latchE;
        req_syncE2   <= req_syncE;
 end
end

// DREQ_FULL diagnostic logic on SYSCLK
// save number of DREQ_FULL rising edge and first DDR TAG at which is happens
reg dreq_full_reg, dreq_full_latch, dreq_full_first;
reg cnt_fifo_re, hb_tag_fifo_re;
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        cnt_fifo_re     <= 0;
        hb_tag_fifo_re  <= 0;
        
        dreq_full_reg   <= 1'b0;
        dreq_full_latch <= 1'b0;
        dreq_full_first <= 1'b0;
        ewtag_dreq_full <= 0;
        dreq_full_count <= 0;
    end 
    else    
    begin
        
        cnt_fifo_re     <= ew_empty_ren;
        hb_tag_fifo_re  <= ew_we_store;
        dreq_full_latch <= dreq_full;
        dreq_full_reg   <= dreq_full_latch;
        // save only first TAG with DREQ full 
        if (dreq_full_latch == 1'b1 && dreq_full_reg == 1'b0) begin
            dreq_full_count <= dreq_full_count + 1;
            
            if (dreq_full_first == 1'b0) begin
                dreq_full_first <= 1'b1;
                ewtag_dreq_full <= hb_tag_out;
            end
        end
    end
end



always@(posedge serdesclk, negedge resetn_serdesclk)
begin
   if(resetn_serdesclk == 1'b0)
   begin
		hb_cnt_onhold   <= 32'b0;
		hb_error        <= 1'b0;
		hold_ew_fifo_emptied<= 1'b0;
      
		pattern_init   <= 1'b0;
		spilltag_re	   <= 1'b0;
		ewtag_state	   <= WAIT;
      
		ewtag_offset_en     <= 1'b0;
		ewtag_offset_latch  <= 1'b0;
		ewtag_offset_reg    <= 1'b0;
		ewtag_offset_seen   <= 1'b0;
        ewtag_offset_re     <= 1'b0;
        ewtag_state_cnt     <= 2'b0;
        
        ew_fifo_emptied_count   <= 16'b0;
        hb_empty_overlap_count  <= 16'b0;
	end
	else
	begin
        
		// HB counter rules:
		// - increase count on END OF EVENT WINDOW seen, decrease on EW_FIFO being emptied
		// - if simultaneous, give priority to END OF EVENT WINDOW
		// ** Use HB_ERROR to mark when HB_CNT_ONHOLD goes over size of SPILLTAG_FIFO **
		if(hb_cnt_onhold >= 65536)  hb_error <= 1'b1;
		else                        hb_error <= 1'b0;
        
        // generate HOLD_EW_FIF0_EMPTIED when simultaneous signals detected
		hold_ew_fifo_emptied <= 0;
 		if (evm_on_serdesclk && ew_fifo_emptied) hold_ew_fifo_emptied<= 1;
        
        if (ew_fifo_emptied == 1'b1)        ew_fifo_emptied_count  <= ew_fifo_emptied_count + 1'b1;
        if (hold_ew_fifo_emptied == 1'b1)   hb_empty_overlap_count <= hb_empty_overlap_count + 1'b1;
		
        // when the two signals are simultaneous, end-of-window will have priority to count up
        // delayed version of EW_FIFO_EMPTIED will be used to count down in place of regular signal
		if (evm_on_serdesclk)   
        begin
            hb_cnt_onhold <= hb_cnt_onhold + 1;
        end
        else  
        begin
            if (hold_ew_fifo_emptied)   hb_cnt_onhold <= hb_cnt_onhold - 1;
            else if (ew_fifo_emptied)   hb_cnt_onhold <= hb_cnt_onhold - 1;
        end
        
        // generate enable for EWTAG_OFFSET_FIFO read. Clear after read is issued
        if (new_spill_on_serdesclk) ewtag_offset_en <= 1'b1;
        else if (ewtag_offset_re)   ewtag_offset_en <= 1'b0;
        
        // wait for EWTAG_OFFSET_FIFO empty and generate FIFO read on the edge  
        // generate EWTAG_OFFSET latch after waiting for EWTAG_OFFSET_OUT to settle
        ewtag_offset_latch  <= (ewtag_offset_en && !ewtag_offset_empty);
        ewtag_offset_reg    <= ewtag_offset_latch;
        ewtag_offset_re     <= ewtag_offset_latch && !ewtag_offset_reg;
        
        ewtag_offset_seen   <= ewtag_offset_reg;
      
        
        //
        // State Machine to control REN of SPILLTAG_FIFO and FIFOs WEN 
		case(ewtag_state)
      
        // at least one event window has been seen
		WAIT:
		begin
            ewtag_state_cnt <= 0;
			spilltag_re	<= 0;
            // MUST wait for (second) HB+EW to define a data window
			if (hb_cnt_onhold>0) ewtag_state <= READ;
		end

		// read SPILLTAG FIFO
        READ:
		begin
            ewtag_state_cnt <= 1;
			if(!spilltag_empty) 
            begin
                spilltag_re <= 1;
                ewtag_state <= START;
            end
		end
		
		// start to simulate event tag while waiting for SPILLTAG output to settle
		// (CLUS_PATTERN_CNTRL reads it one clock after seeing PATTERN_INIT anyway...)
		START:
		begin
            ewtag_state_cnt<= 2;
			spilltag_re    <= 0;
            pattern_init   <= 1;
            ewtag_state    <= HOLD;
		end
		
        // Pass SPILLTAG output to simulated tag logic. 
        // Use restart of local tag count to mark start of new spill and generate latch for EWTAG offset 
        HOLD:
		begin
            ewtag_state_cnt<= 3;
			pattern_init   <= 0;
			spill_ewtag_out<= spilltag_rdata;
            
            if (ew_fifo_emptied) ewtag_state <= WAIT;
		end
		
        default:
        begin
            ewtag_state_cnt <= 0;
            ewtag_state	<=	WAIT;
        end
      
        endcase      
	end
end


always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)
    begin
		tag_fetch       <=	1'b0;
        evt_tag_fetch	<=	0;
      
		data_ready	    <= 1'b0;
		last_word	    <= 1'b0;
		
        tag_error       <= 1'b0;
        dreq_cnt        <= 32'b0;
        start_fetch_cnt <= 32'b0;
        tag_done_cnt    <= 32'b0; 
        tag_null_cnt    <= 32'b0; 
        tag_sent_cnt    <= 32'b0; 
      
        tag_sent_hold   <= 1'b0;
        tag_null_hold   <= 1'b0;
        datareq_state   <= IDLE;
        
        tag_valid_reg   <= 1'b0;
        tag_error_reg   <= 1'b0;
        
        tag_valid_count <= 16'b0;
        tag_error_count <= 16'b0;
        
        datareq_state_cnt <= 2'b0;
    end
    else
    begin
        
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
            datareq_state_cnt <= 0;
            if (event_start)  begin
                datareq_state   <= VALID;
                dreq_cnt        <= dreq_cnt + 1;
            end
        end
      
        // use (buffered) TAG_SENT to issue DATAREQ_DATA_VALID
        VALID:
        begin
            datareq_state_cnt <= 1;
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
            datareq_state_cnt <= 2;
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
// SPILLTAG_FIFOs (20bx4K) to buffer local EWTAG counter to be used in DDR pattern for duration of the SPILL
SPILLTAG_FIFO	spilltag_fifo0 (
	.WCLOCK	    (xcvrclk),
	.WRESET_N   (resetn_fifo),
	.DATA	    (spill_hbtag_in),
	.WE		    (end_evm_seen),
	.RCLOCK	    (serdesclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (spilltag_re),
	// Outputs
	.EMPTY	    (spilltag_empty),
	.FULL	    (spilltag_full ),
	.Q          (spilltag_rdata)
);

reg     spilltag_full_reg, spilltag_full_latch;
always@(posedge xcvrclk, negedge resetn_xcvrclk)
begin
    if(resetn_xcvrclk == 1'b0) 
    begin
        spilltag_full_latch   <= 1'b0;
        spilltag_full_reg     <= 1'b0;
        spilltag_full_count   <= 16'b0;
    end
    else
    begin
        spilltag_full_latch   <= spilltag_full;
        spilltag_full_reg     <= spilltag_full_latch;
        
        if (spilltag_full_latch == 1'b1 && spilltag_full_reg == 1'b0) spilltag_full_count <= spilltag_full_count + 1;
    end
end

//
// CNT_FIFO is 20b x 64, enough to buffer SPILLTAG_ROLLOVER bus which contains the 20 MBS of local tag counter until we pass it to EW_FIFO_Controller.
// Written to FIFO at the same time as 20 LSB (SPILL_HBTAG_IN), read from FIFO on registered EW_EMPTY_REN from EW_FIFO_Controller
CNT_FIFO	cnt_fifo0 (
	.WCLOCK	    (xcvrclk),
	.WRESET_N   (resetn_fifo),
	.DATA		(spill_hbtag_rollover_in),
	.WE		    (end_evm_seen),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	//.RE		    (ew_empty_ren),
	.RE		    (cnt_fifo_re),
	// Outputs
	.EMPTY	    (spilltag_rollover_empty),
	.FULL		(spilltag_rollover_full),
	.Q			(spill_hbtag_rollover_out)	
);


//
// Cross time domain FIFO (48bit x 64) for EWTAG_OFFSET bus at the start of SPILL
EWTAG_FIFO	ewtag_fifo_offset (
	.WCLOCK	    (xcvrclk),
	.WRESET_N   (resetn_fifo),
	.DATA	    (hb_event_window),
	.WE		    (first_hb_seen),
	.RCLOCK	    (serdesclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (ewtag_offset_re),
	// Outputs
	.EMPTY	    (ewtag_offset_empty),
	.FULL	    (ewtag_offset_full),
	.Q		    (ewtag_offset_out)	
);

//
// Cross time domain FIFO (48bit x 1024) for HB_TAG to be used in DDR header
LARGE_TAG_FIFO	hb_tag_fifo (
	.WCLOCK	    (xcvrclk),
	.WRESET_N   (resetn_fifo),
	.DATA	    (hb_event_window),
	.WE		    (hb_seen),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	//.RE		    (ew_we_store),
    .RE		    (hb_tag_fifo_re),
	// Outputs
	.EMPTY	    (hb_tag_empty),
	.FULL	    (hb_tag_full),
	.Q		    (hb_tag_out)	
);

reg     hb_tag_full_reg, hb_tag_full_latch;
always@(posedge xcvrclk, negedge resetn_xcvrclk)
begin
    if(resetn_xcvrclk == 1'b0) 
    begin
        hb_tag_full_latch   <= 1'b0;
        hb_tag_full_reg     <= 1'b0;
        hb_tag_full_count   <= 16'b0;
    end
    else
    begin
        hb_tag_full_latch   <= hb_tag_full;
        hb_tag_full_reg     <= hb_tag_full_latch;
        
        if (hb_tag_full_latch == 1'b1 && hb_tag_full_reg == 1'b0) hb_tag_full_count <= hb_tag_full_count + 1;
    end
end

// Cross time domain FIFO (48bit x 64) for DREQ_TAG to be used in DDR header
EWTAG_FIFO	dreq_tag_fifo (
	.WCLOCK	(dreqclk),
	.WRESET_N(resetn_fifo),
	.DATA	(dreq_tag),
//	.WE		(event_start),
	.WE		(start_fetch),
	.RCLOCK	(sysclk),
	.RRESET_N(resetn_fifo),
	.RE		(start_read),
	// Outputs
	.EMPTY	(dreq_tag_empty),
	.FULL	(dreq_tag_full),
	.Q		(dreq_tag_out)	
);

endmodule

