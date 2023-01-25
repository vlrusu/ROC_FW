///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: cfo_emulator.v
// File history:
//      03/2022: First release 
//      04/2022: Fixed to allow multiple retriggering without a reset
//
// Description: 
//    Generates Heartbeat packet (HB), Event Window Marker (EWM) and Data Request packet (DREQ) on 150 MHz SERDES clock
//    
//    Emulates CFO simulator and mu2Util command parameters:
//    -  DELTAHB input     simulates -D parameter (times between HB)
//    -  NUMBERHB input    simulates -n parameter (number of non-null HB with Event Mode bits = 0x1)
//    -  OFFSETHB input    simulated -o parameter (starting event window tag)
//    N.B. Always OFFSPILL mode (ie ONSPILL = 0)
//         Send 1 null HB at start with Event Mode bits = 0x0
//         EWM just "before" next HB
//         DREQ after data is available (also avoiding HB or EWM)
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

`include "tracker_params.vh"

module cfo_emulator(
    input       fifo_resetn,        // straigth from EXR_RST_N
//global signals
   input		serdesclk,                 // SERDES clk (150 MHz)
   input		serdesclk_resetn,
   input		xcvrclk,                   // DAQ RX recovered clock (200 MHz)
   input		xcvrclk_resetn,
   input		dreqclk,                   // DREQ clock (use 80 MHz)
   input		dreqclk_resetn,

   input		start,                     //	external DAQ generator start
   input    prefetch_en,               // externally enable for on-demand PREFETCH

   // 
   input [31:0]               DELTAHB,    //  time between HBs (in units of 150 MHz clock)
   input [31:0]               NUMBERHB,   //  number of HBs
   input	[`EVENT_TAG_BITS-1:0] OFFSETHB,  // external EWTAG offset: set on firmware reset
   
   // on XCVRCLK: HB start and number from TOP_SERDES
   input    hb_start,
   input	[`EVENT_TAG_BITS-1:0] hb_ewtag,     
 
   
   // on DREQCLK; DREQ start and number and DATAREQ last seen word from TOP_SERDES
   input    dreq_start,
   input	[`EVENT_TAG_BITS-1:0] dreq_ewtag,   
   input    datareq_done,                    // DATAREQ has seen LAST_WORD (on DREQCLK)

   
   // on SERDESCLK
   output   reg         startCFO,            // start DTC simulation with CFO simulated paramenters
   output   reg [3:0]   CFO_packet_type,     // set PACKERT_TYPE for HB vs PREFETCH vs DataREQ
   
   output reg  startEWM,                     //	start of Event Window Marker
   output reg  [31:0] event_mode,            // differentiate null vs non-null HB
	output reg	[`SPILL_TAG_BITS-1:0]   Spill_EWtag,	// EWTAG counter for duration of SPILL 
	output reg	[`EVENT_TAG_BITS-1:0]   EWtag,			// EWTAG to simulate
	output reg	[`EVENT_TAG_BITS-1:0]   EWtag_offset,	// EWTAG offset: start with TAG_OFFSET, updated every NEW SPILL and at end of run

   // diagnostics registers
   output reg  datareq_good  // no. of DREQs and HBs are the same and reached NUMBERHB
);

//<statements>
localparam  [7:0] WAIT_FOR_RST =  8'hF0;      // this insures a wait period longer than 1 us after an EXT_RST

//
// logic for time domain crossing FIFOs (to ease timing constraints)
// Use WAIT_CNT to ignore spurious .EMPTY and .Q outputs while an EXT_RST is issued 
reg   wait_for_rst;
reg   [7:0] wait_cnt;

reg   hb_ewtag_en, dreq_ewtag_en;
reg   hb_ewtag_empty_reg,  hb_ewtag_empty_latch,   hb_ewtag_empty_pulse;   
reg   dreq_ewtag_empty_reg, dreq_ewtag_empty_latch, dreq_ewtag_empty_pulse;   
reg  [`EVENT_TAG_BITS-1:0] hb_ewtag_sync;      
reg  [`EVENT_TAG_BITS-1:0] dreq_ewtag_sync;  

wire  hb_ewtag_empty, dreq_ewtag_empty; 
wire  [`EVENT_TAG_BITS-1:0] hb_ewtag_out, dreq_ewtag_out;      
  
always@(posedge serdesclk, negedge serdesclk_resetn)
begin
	if (serdesclk_resetn == 1'b0) 
	begin
      wait_for_rst<= 1'b1;
      wait_cnt    <= 0;
      
      hb_ewtag_en          <= 1'b0;   
      hb_ewtag_empty_reg   <= 1'b0;
      hb_ewtag_empty_latch <= 1'b0;
      hb_ewtag_empty_pulse <= 1'b0;
      hb_ewtag_sync        <= 0;
      
      dreq_ewtag_en           <= 1'b0;   
      dreq_ewtag_empty_reg    <= 1'b0;
      dreq_ewtag_empty_latch  <= 1'b0;
      dreq_ewtag_empty_pulse  <= 1'b0;
      dreq_ewtag_sync         <= 0;
      
   end
   else
   begin
      
      hb_ewtag_empty_reg      <= ~hb_ewtag_empty;
      hb_ewtag_empty_latch    <= hb_ewtag_empty_reg;
      
      dreq_ewtag_empty_reg   <= ~dreq_ewtag_empty;
      dreq_ewtag_empty_latch <= dreq_ewtag_empty_reg;
      
      if (wait_for_rst) wait_cnt <= wait_cnt + 1'b1;
      
      if (wait_cnt > WAIT_FOR_RST) 
      begin
         wait_for_rst <= 1'b0;
         
         hb_ewtag_empty_pulse    <= hb_ewtag_empty_reg && ~hb_ewtag_empty_latch;
         if (hb_ewtag_empty_pulse)  hb_ewtag_en <= 1'b1;
         
         dreq_ewtag_empty_pulse  <= dreq_ewtag_empty_reg && ~dreq_ewtag_empty_latch;
         if (dreq_ewtag_empty_pulse)dreq_ewtag_en  <= 1'b1;
      end
      
      if (hb_ewtag_en)     hb_ewtag_sync  <= hb_ewtag_out;
      if (dreq_ewtag_en)   dreq_ewtag_sync<= dreq_ewtag_out;
      
   end
end

// EWTAG_FIFO is 48bx64
EWTAG_FIFO	ewtag_fifo_dreq (
	.WCLOCK	(dreqclk),
	.WRESET_N(fifo_resetn),
	.DATA		(dreq_ewtag),
	.WE		(dreq_start),
	.RCLOCK	(serdesclk),
	.RRESET_N(fifo_resetn),
	.RE		(dreq_ewtag_empty_pulse),
	// Outputs
	.EMPTY	(dreq_ewtag_empty),
	.FULL		(),
	.Q			(dreq_ewtag_out)	
);

EWTAG_FIFO	ewtag_fifo_hb (
	.WCLOCK	(xcvrclk),
	.WRESET_N(fifo_resetn),
	.DATA		(hb_ewtag),
	.WE		(hb_start),
	.RCLOCK	(serdesclk),
	.RRESET_N(fifo_resetn),
	.RE		(hb_ewtag_empty_pulse),
	// Outputs
	.EMPTY	(hb_ewtag_empty),
	.FULL		(),
	.Q			(hb_ewtag_out)	
);

//
// start logic controlling HB Window Tag
reg   start_reg, start_latch, start_pulse;
reg	newEWtag;
reg	countEWtag;
reg [15:0] timerEWtag;

reg [31:0] cntHB;       // local counter withinh each CFO emulation
reg [31:0] cntDREQ;     // local counter withinh each CFO emulation

reg   new_spill;
reg   countNullHB;  
reg [5:0] timerNullHB;

reg   datareq_reg, datareq_latch, datareq_sync;
reg   datareq_released, datareq_done_hold, datareq_cleared;  
reg   countNoDREQ;  
reg [5:0] timerNoDREQ;

reg   countPREF;
reg   prefetch_hold, prefetch_released, prefetch_cleared;
reg [7:0] timerPREF;

reg   countFirst;
reg [7:0] timerFirst;

reg   isPrefetch;               // internally generated signal to simulate PREFETCH on some events

reg  startHB;     //	start of HeartBeat packet
reg  startDREQ;   //	start of DREQ packet
reg  startPREF;   //	start of PREFETCH packet

always@(posedge serdesclk, negedge serdesclk_resetn)
begin
	if (serdesclk_resetn == 1'b0) 
	begin
      start_reg   <= 1'b0;
      start_latch <= 1'b0;
      start_pulse <= 1'b0;
      
      cntHB       <= 32'b0;
      cntDREQ     <= 32'b0;

      new_spill   <= 1'b1;
      event_mode  <= 32'b0;
      startHB     <= 1'b0;
      startEWM    <= 1'b0;
      startDREQ   <= 1'b0;
      startPREF   <= 1'b0;
      isPrefetch  <= 1'b0;
      
      countNullHB <= 1'b0;
      timerNullHB <= 6'b0;
      
      countNoDREQ <= 1'b0;
      timerNoDREQ <= 6'b0;
      
		newEWtag	   <= 1'b0;
		countEWtag	<= 1'b0;
		timerEWtag	<= 16'b0;
      
		Spill_EWtag	<= 20'b0;
		EWtag 		<= 48'b0;
		EWtag_offset<= 48'b0;
         
      countFirst  <= 1'b0;
      timerFirst  <= 8'b0;
         
      countPREF   <= 1'b0;
      timerPREF   <= 8'b0;
         
      datareq_reg    <= 1'b0;
      datareq_latch  <= 1'b0;
      datareq_sync   <= 1'b0;
         
      prefetch_hold     <= 1'b0; 
      prefetch_released <= 1'b0; 
      prefetch_cleared  <= 1'b0; 
         
      datareq_released  <= 1'b0;
      datareq_cleared   <= 1'b0;
      datareq_done_hold <= 1'b0;
         
      startCFO       <= 1'b0;
      CFO_packet_type <= 4'b0;
      
      datareq_good<= 1'b0;
	end
	else  
	begin
      // drive 1-clk outputs
      startHB     <= 1'b0;
      startEWM    <= 1'b0;
      startPREF   <= 1'b0;   
      startDREQ   <= 1'b0;   
      
      // make sure START is a single clock pulse
		start_reg	<= start;
		start_latch <= start_reg;
		start_pulse	<=	start_reg && !start_latch;
         
      //
      // after a reset, ie at start of a new spill,
      // generate one null HB followed by NUMBERHB heartbeats
      // Otherwise just generate NUMBERHB heartbeats as requested
		if (start_pulse)
		begin
         cntHB          <= 32'b0;
         cntDREQ        <= 32'b0;
         EWtag_offset   <= OFFSETHB;
         
         if (new_spill)
         begin
            startHB     <= 1'b1; 
            new_spill   <= 1'b0;
            countNullHB <= 1'b1;
         end
         else
         // no need to enable COUNTFIRST because DATAREQ_RELEASED is left high and 
         // ready to trigger new DREQ the moment HB_EWTAG_SYNC goes ahead of DREQ_EWTAG_SYNC 
         begin
            countEWtag	<= 1'b1;
            countNoDREQ <= 1'b1;  
         end
      end
      
      //
      // wait for null-HB to be processed, before starting regular HB generation (via startHB)
      // use COUNTFIRST to force PREFETCH or DATAREQ after non-null HB
      if (countNullHB)  timerNullHB <= timerNullHB + 1'b1;
      if (timerNullHB == 30)
      begin
         startHB     <= 1'b1;         
         countNullHB <= 1'b0;
         countFirst  <= 1'b1;
         countEWtag	<= 1'b1;
      end
      
      //
      // set EVENT_MODE for null and regular HB
      // and count HBs/increase EWT only after null-HB
      if (startHB) 
      begin
         if (countNullHB) 
         begin
            event_mode  <= 32'b0;
            Spill_EWtag <= 20'b0;
            EWtag       <= EWtag_offset;
         end
         else
         begin
            event_mode  <= 32'b1;
            cntHB       <= cntHB + 1;
            Spill_EWtag <= Spill_EWtag + 1'b1;
            EWtag	      <= EWtag_offset + {28'b0,Spill_EWtag} + 1'b1;
         end
      end

      //
      // for FIRST event after a reset, ie first event of a new SPILL:
      // - generate DataReq right after first HB 
      // - if Prefetch enabled, generate PREF right after first HB, followed by DREQ
      if (countFirst) timerFirst <= timerFirst + 1'b1;
      
      if (timerFirst == 30) 
      begin
         if (isPrefetch)         // generate PREF, followed by DREQ
         begin
            startPREF   <= 1'b1;
         end
         else                    // generate only DREQ and disable TIMEFIRST
         begin
            startDREQ   <= 1'b1;
            countFirst  <= 1'b0;
         end
      end
      else if (timerFirst == 60) // generate DREQ after PREF and disable TIMEFIRST
      begin
         startDREQ   <= 1'b1;
         countFirst  <= 1'b0;
      end
      
      //
      // HeartBeat every DELTAHB always takes priority by generating a DREQ disable window  
      // thus avoiding START of HB simulated packet to come while a DREQ packet is being generated
      if (countNoDREQ)  timerNoDREQ <= timerNoDREQ + 1'b1;
         
      if      (timerNoDREQ == 26)   startHB  <= 1'b1;   
      else if (timerNoDREQ == 51) 
      begin
         countNoDREQ <= 1'b0;
         timerNoDREQ <= 6'b0;
      end
         
 		if (countEWtag)   timerEWtag  <= timerEWtag + 1'b1;		
      
      // Event Window Tag is generated 50 clock ticks (~335 ns) BEFORE new HB
		if (timerEWtag == (DELTAHB-50)) 
         startEWM <= 1'b1;
		else if (timerEWtag >= DELTAHB) 
		begin
			if (cntHB < NUMBERHB)  newEWtag	   <= 1'b1;
			countEWtag 	<= 1'b0;
			timerEWtag	<= 16'b0;
		end
		
		// control EWTag duration during the SPILL 
		if (newEWtag)	
		begin
			newEWtag	   <= 1'b0;
			countEWtag	<= 1'b1;
         countNoDREQ <= 1'b1;
		end

      //
      // after FIRST event is taken care of, generate new Data Request when:
      // 1) Heartbeat Event Window tag is ahead
      // 2) DATAREQ_DONE is seen and is far away from HeartBeat (DATAREQ_RELEASE, DATAREQ_HOLD)
      // PREFETCH, if enabled, is then sent after a fix delay from Data Request, unless there is a Hearbeat on the way
      datareq_reg    <= datareq_done;
      datareq_latch  <= datareq_reg;
      datareq_sync   <= datareq_latch;
      
      if (datareq_latch && ~datareq_sync)
      begin
         if (countNoDREQ)  datareq_done_hold <= 1'b1; 
         else              datareq_released  <= 1'b1;  
      end
         
      if (datareq_done_hold)
      begin
         if (countNoDREQ)  datareq_done_hold <= 1'b1;
         else              
         begin
            datareq_done_hold <= 1'b0;
            datareq_cleared   <= 1'b1;
         end
      end
      
      if ( (hb_ewtag_sync > dreq_ewtag_sync) && (datareq_released || datareq_cleared) ) 
      begin
         startDREQ         <= 1'b1;
         datareq_released  <= 1'b0; 
         datareq_cleared   <= 1'b0; 
         // logic to control PREFETCH every 4 data request
         if ( prefetch_en && ((dreq_ewtag_sync + 1)%4)==0 )  isPrefetch   <= 1'b1;
       end
      
      if (isPrefetch)  
      begin
         countPREF<= 1'b1;
         isPrefetch <= 1'b0;
      end

      //
      // generate PREFETCH packet after DREQ unless Hearbeat is about to happen...
      if (countPREF) timerPREF   <= timerPREF + 1'b1;
      if (timerPREF >= 30) 
      begin
         if (countNoDREQ)  prefetch_hold <= 1'b1;
         else              prefetch_released  <= 1'b1;
         
         if(prefetch_hold)
         begin
            if (countNoDREQ)  prefetch_hold <= 1'b1;
            else              
            begin
               prefetch_hold     <= 1'b0;
               prefetch_cleared  <= 1'b1;
            end
         end
         
         if (prefetch_released || prefetch_cleared) 
         begin
            startPREF   <= 1'b1;
            prefetch_released  <= 1'b0; 
            prefetch_cleared   <= 1'b0; 
            countPREF   <= 1'b0;
            timerPREF   <= 8'b0;
         end
      end
      
      //
      // CFO emulation controls 
      startCFO <= startHB || startDREQ || startPREF;
      
      if       (startHB)  CFO_packet_type  <= 1;
      else if  (startDREQ)CFO_packet_type  <= 2;
      else if  (startPREF)CFO_packet_type  <= 3;

      // some diagnostics
      if (dreq_ewtag_empty_pulse) cntDREQ <= cntDREQ + 1;
      
      if (cntDREQ == NUMBERHB)   datareq_good<= 1'b1;
      else                       datareq_good<= 1'b0;
      
      
	end
end

endmodule

