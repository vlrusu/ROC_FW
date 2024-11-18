///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: EW_FIFO_controller.v
// File history:
//      v1.0: <Aug. 2021>: first version
//      v2.0: <Dec. 2021>: change DIGIFIFo output to 64-bits and read on SYSCLK. Remove 32-to-64 bit conversion. 
//      v3.0: <Jan. 2022>: add time-domani crossing FIFOs (SIZE_FIFOs, EWTAG_FIFOs, CNT_FIFOs)
//      v4.0: <Feb. 2022>: add logic to keep track of ET_FIFO usage when PREFETCH is used 
//      v5.0: <Mar. 2022>: clear up difference between 64-bit (AXI) beat units and 128-bit (DTC) packet units: 
//                         EW_SIZE and derived variables are [EVENT_SIZE_BITS-1:0], ie in units of beats
//      v6.0: <July,2023>: added NEWSPILL rising edge on appropriate clock to clear all signals used in bouncing between EW_FIFOs  and ET_FIFOs 
//      v7.0: <Feb.,2024>: added ET_PKTS_OVFL output to be used in data header status 
//      v8.0: <Feb.,2024>: added HB_TAG_IN to and DREQ_TAG_IN to second DDR header word 
//      v9.0: <Jul.,2024>: added TAG_ERROR (tag sync or inconsistent tag accross serdes lanes) and passed it to ET_PKTS_ERR output to be used in data header status  
//      v10.0:<Nov.5,2024>: changed some internal signals names and changed definition of EVENT/HEADER1/HEADER2/DATA_ERROR (set on first error onset).
//      v11.0:<Nov.5,2024>: added DDR_WRITE_ON condition in logic avoiding writing and reasding from same DDR address
//
//
// Description:
//
//   Based on EW_DONE and EW_SIZE (on Serdes Clock domain):
//    0) register cluster number for Event Window for at least two EW_DONEs before waiting for at least first of them entering AXI Write SM (use EW_FIFO_WE semaphore) 
//    1) start read of 32-bit ROCFIFOs on SERDESCLK domain
//    2) writes 32-bit data to one of two EW_FIFOs using (on SERDESCLK domain)
//    3) end of ROCFIFO data read for EW_SIZE clusters releases AXI-stream Write to DDR (on SYSCLK domain)
//    4)  pass data to EW_SIZE_STORE_AND_FETCH_CONTROLLER
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 
//`timescale <time_units> / <precision>

`include "tracker_params.vh"

module EW_FIFO_controller #(
	parameter [7:0]   BURST_LENGTH   = 8'hFF,	// burst length of 256 beats (AXI defines number beats to pass to AWLEN/ARLEN as: no-of-beats-1 ) 
                                                // Changed from 127(0x7F) for 1KB blocks in Configurator BURST_LENGHT field
	parameter [1:0]	BURST_SIZE     = 2'b11	    // 8 bytes for beat (AXI defines bit in a beat as: 2**BURST_SIZE)
) (
    input   resetn_fifo,        // straigth from EXR_RST_N
//global signals
    input   sysclk,             // on DDR SYS clock
    input   resetn_sysclk,
    input   newspill_on_sysclk, // rising edge of NEWSPILL
    input   dreqclk,            // on DREQ clock
    input   resetn_dreqclk,
    input   newspill_on_dreqclk,// rising edge of NEWSPILL
    input   serdesclk,  	    // on 150 MHz clock
    input	resetn_serdesclk,
    
 // signals on SYSCLK exchanged with EWTAG_CNTRL   
    input   [`EVENT_TAG_BITS-1:0]   hb_tag_in,
    input   [`EVENT_TAG_BITS-1:0]   dreq_tag_in,
    input   [`SPILL_TAG_BITS-1:0]   spill_tag_rollover,
    output  reg     start_read_pulse,
    output  reg     ew_empty_ren,
    
// signals exchanged with ROC_FIFO_CNTRL on SERDESCLK time domain 
    input   curr_ewfifo_wr,    // when 0/1, current EW_FIFO to write is EW_FIFO0/1
    input   ew_done,           // Event Window Tag has been processed and loaded into DIGIFIFO
    input   ew_fifo_we,        // WR data from ROCFIFO into current EWFIFO
	input   ew_ovfl,           // packet size has reached maximum allowed of 1023 in units of 64-bit AXI_beats
	input   ew_error,          // event has error (tag sync or inconsistent tag accross serdes lanes)
    input   [`DIGI_BITS-1:0]        ew_data,    // EW data from ROCFIFO controller
	input	[`EVENT_SIZE_BITS-1:0]  ew_size,    // beats max size is [9:0] from ROCFIFO controller in units of 64-bit AXI_beats
	input	[`SPILL_TAG_BITS-1:0]   ew_tag,     // EW tag counter within SPILL	
    input   ewtag_offset_seen,                  // gate while first tag of new spill is processed
	input   [`EVENT_TAG_BITS-1:0]   ewtag_offset_in,	// EW offset 
	output  reg	axi_start_on_serdesclk,         // curr EW is being written to DDR 
	output  reg	ddr_done_on_serdesclk,	  	    // EW has been written to DDR 
	output  reg    ew_fifo_emptied,	            // pulse on any EW_FIFOs being emptied
    output          ew_fifo_full,
// signals exchanged with EW_SIZE_STORE_AND_FETCH_CNTRL on SYSCLK time domain 
	output  reg   ew_we_store,		            // EW_SIZE_FIFO read enable
	output  reg   ew_ovfl_to_store,             // SIZE has overflown
	output  reg   ew_err_to_store,              // TAG has event has error (tag sync or inconsistent tag accross serdes lanes)
    output  reg   ew_DDRwrap_to_store,          // DDR address has to wrap around 
	output  reg [`EVENT_SIZE_BITS-1:0]	ew_size_to_store,   // in 128-bit DTC packets unit 
	output  reg [`EVENT_TAG_BITS-1:0]	ew_tag_to_store,    // EW Event Tag 
// signals exchanged with EW_SIZE_STORE_AND_FETCH_CNTRL on DREQCLK time domain
	input   tag_valid,                          // EVTAG size is ready
	input   tag_ovfl,                           // EVTAG size overflow: used for error diagnostics
	input   tag_error,                          // EVTAG has event has error (tag sync or inconsistent tag accross serdes lanes)r
	input   [`EVENT_SIZE_BITS-1:0]	tag_size,	// EVTAG size in 128-bit DTC packets unit
	input   [`DDR_ADDRESS_BITS-1:0]	tag_addr,   // EVTAG count: set the DDR address
	input   [`EVENT_TAG_BITS-1:0]   tag_evt,    // EVTAG tag  
// signals exchanged with TOP_SERDES on DREQCLK	
	input   et_fifo_re,                        // DATAREQ_RE_FIFO 
    input   last_word,                         // DATAREQ_LAST_WORD 
	output  [`AXI_BITS-1:0]            et_fifo_rdata,	// DATAREQ_DATA (1/2 DTC packet per line)
	output  reg [`EVENT_SIZE_BITS-1:0] et_pckts,        // DATAREQ_PACKETS_IN_EVENT (in units of 128-bit DTC packets)
    output  reg     et_pckts_ovfl,                      // event with over max number of packets 
    output  reg     et_pckts_err,                       // event has error (tag sync or inconsistent tag accross serdes lanes)
	output  reg     tag_sent,                   // DDR read is done
	output  reg	    tag_null,                   // DDR read is done for event with no hits
	output  reg     et_fifo_emptied,            // pulse on EVT_FIFO becoming available: used to clear DATA_READY and generate LAST_WORD
    output          et_fifo_full,               // current ET FIFO is almost full (ie has 511 hits)
// diagnostics
	output  reg[7:0]    DDR_error_mask,
	output  reg  [`AXI_BITS-1:0]  hdr1_expc,  hdr1_seen,												   
	output  reg  [`AXI_BITS-1:0]  hdr2_expc,  hdr2_seen,												   
	output  reg  [`AXI_BITS-1:0]  evt_expc,   evt_seen,												   
	output  reg  [`AXI_BITS-1:0]  data_expc,  data_seen,	
	output  reg  [`AXI_BITS-1:0]  tag_expc,     tag_seen,	

    output  reg  [15:0]   hb_dreq_error_cnt,
    output  reg  [15:0]   hb_tag_err_cnt,
    

//AXI Master IF - on DDR SYS CLK
// Write Address Channel 
   output      [3:0]  awid_o,
   output reg  [31:0] awaddr_o, 
   output      [7:0]  awlen_o, 
   output      [1:0]  awsize_o, 
   output      [1:0]  awburst_o, 
   output reg         awvalid_o,  
   input              awready_i,  
// Write Data Channel  
   output      [7:0]  wstrb_o,
   output reg         wlast_o,
   output reg         wvalid_o,
   output reg [63:0]  wdata_o, 
   input              wready_i, 	
// Write Response Channel
   input      [3:0]   bid_i,
   input      [1:0]   bresp_i,  
   input              bvalid_i,	
   output             bready_o,
// Read Address Channel 
   output     [3:0]   arid_o, 
   output reg [31:0]  araddr_o, 
   output     [7:0]   arlen_o, 
   output     [1:0]   arsize_o, 
   output     [1:0]   arburst_o, 
   output reg         arvalid_o, 
   input              arready_i, 
// Read Data Channel
   input      [3:0]   rid_i,
   input      [63:0]  rdata_i, 
   input      [1:0]   rresp_i,
   input              rlast_i,
   input              rvalid_i,
   output reg         rready_o
);

///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////

// maximum number of 1kB blocks in 8Gb memory
localparam 	[`DDR_ADDRESS_BITS-1:0]	MAX_DDR_ADDR = 2**`DDR_ADDRESS_BITS - 1;

// WRAP_DDR_ADDR is set to prevent worst-case scenario 
// of incoming event spreading over enough blocks to go over MAX_DDR_ADDR
localparam	[`DDR_ADDRESS_BITS-1:0]	WRAP_DDR_ADDR = MAX_DDR_ADDR - (2**`MAX_STEP_BITS + 1);


// set wait longer period longer than ~1 us after an EXT_RST
localparam  [7:0] WAIT_FOR_RST =  8'hF0; 
      
// EWFIFOs WRITE signals on SERDESCLK time domain  
wire	ew_fifo0_we,   ew_fifo1_we;		// EW_FIFO write enable
wire	ew_fifo0_full, ew_fifo1_full;   // EW_FIFO almost full (to give time to stop DIGIFIFO read)
wire    [`DIGI_BITS-1:0] ew_fifo0_wdata, ew_fifo1_wdata, ew_fifo_wdata;	    // data to EW_FIFOs

// EWFIFOs READ signals on SYSCLK time domain     
reg     curr_ewfifo_rd;     // when 0/1, address EW_fifo0/1
reg     ew_fifo_re;         // EW_FIFO read enable
wire	ew_fifo0_re,	ew_fifo1_re;
wire	ew_fifo0_empty, ew_fifo1_empty, ew_fifo_empty;	                // EW_FIFO empty
wire    [`AXI_BITS-1:0] ew_fifo0_rdata, ew_fifo1_rdata,  ew_fifo_rdata;	// data from EW_FIFOs
reg     ew_fifo0_empty_pulse,  ew_fifo1_empty_pulse;

// EVTFIFOs WRITE signals on SYSCLK time domain     
reg     curr_etfifo_wr;  	            // when 0/1, when EVT_fifo0/1 is being written
reg     et_fifo_we;
wire	et_fifo0_we,	et_fifo1_we;	// EVT_FIFO write enable
wire	et_fifo0_full, et_fifo1_full;   // EVT_FIFO full (ie 511 hits in event)
reg     [`AXI_BITS-1:0] et_fifo_wdata;
wire    [`AXI_BITS-1:0] et_fifo0_wdata, et_fifo1_wdata;	    // data to EVT_FIFOs

reg     hb_dreq_error, hb_tag_err;

// EVTFIFOs signals on DREQCLK time domain     
reg     curr_etfifo_rd;                 // when 0/1, when EVT_fifo0/1 is being read
wire	et_fifo0_re, et_fifo1_re;	    // EVT_FFO read enable
wire	et_fifo0_empty, et_fifo1_empty, et_fifo_empty;	    // EVT_FIFO empty
wire    [`AXI_BITS-1:0]  et_fifo0_rdata, et_fifo1_rdata;    // data from EVT_FIFOs
reg     et_pctk_empty_ren;

// signals on SYSCLK to control AXI WR/RD semaphores
reg	    ew_fifo0_toDDR, ew_fifo1_toDDR, DDR_to_write;
reg	    ew_fifo0_clr, ew_fifo1_clr;
reg	    ew_err0_to_store,   ew_err1_to_store; 
reg	    ew_ovfl0_to_store, ew_ovfl1_to_store; 
reg     [`EVENT_SIZE_BITS-1:0]      ew_size0_to_store, ew_size1_to_store; 
reg  	[`EVENT_TAG_BITS-1:0]       ew_evtag0_to_store, ew_evtag1_to_store;

reg	    first_ew_ready;
reg     ddr_write_done_latch, ddr_write_done_reg;

reg	    [7:0]   ew_blk0_to_store, ew_blk1_to_store, ew_blk_to_store; 
reg	    [7:0]   ew_pckt_to_do;      // max value is 127
reg	    [`EVENT_SIZE_BITS-1:0] 	ew_left_to_do;
reg	    [`DDR_ADDRESS_BITS-1:0]	next_write_addr;

reg	    first_axi_read;
reg     DDR_write_on;
reg     start_read, start_read_reg;
reg	    prev_read_done;
reg     axi_read_done;
reg	    et_fifo0_fromDDR, et_fifo1_fromDDR, DDR_to_read;
reg	    et_fifo0_clr, et_fifo1_clr;
reg	    [`EVENT_SIZE_BITS-1:0] 	et_fifo0_size, et_fifo1_size;
reg	    [`EVENT_SIZE_BITS-1:0] 	et_size;
reg	    [`DDR_ADDRESS_BITS-1:0] et_fifo0_addr,  et_fifo1_addr;
reg	    [`DDR_ADDRESS_BITS-1:0] et_addr;
reg	    [`EVENT_TAG_BITS-1:0] 	et_fifo0_evt,  et_fifo1_evt;
reg	    [`EVENT_TAG_BITS-1:0] 	et_evt;

reg	    et_err0, et_err1, et_err, save_et_err;
reg     et_err_to_we, et_err_hold;
reg	    et_ovfl0, et_ovfl1, et_ovfl, save_et_ovfl;
reg     et_ovfl_to_we, et_ovfl_hold;
reg 	[7:0]   et_blk0, et_blk1, et_blk;
reg	    [7:0]   et_pckt_to_do;      // max value is 127
reg     [`EVENT_SIZE_BITS-1:0] 	et_left_to_do;

// added when PREFETCH enabled: must prevent signals generated on DDR read to proceed 
// if the EWTAG data is still buffered inside the other EVTFIFOs while DTC reads 
reg	    et_fifo0_toDTC, et_fifo1_toDTC;     // semaphore high from AXI_READ_DONE to LAST_WORD
reg     last_word_reg, last_word_latch, last_word_sync;
wire    last_word_start;
reg     axi_read_sem, axi_read_to_we;
reg	    [`EVENT_SIZE_BITS-1:0] 	et_packets;
reg	    [`EVENT_SIZE_BITS-1:0] 	et_packets_to_we, et_packets_hold;

reg	    ew_fifo_starved;
reg	    [1:0]   hdr_cnt;    // needs to count only up to 2
reg	    [63:0]  first_wr_hdr, second_wr_hdr;
reg	    [63:0]  first_rd_hdr, second_rd_hdr;

// DDR read data diagnostics (on SYSCLK) assuming all events are readout
reg 	[63:0] next_word;
reg	    [31:0] word32_offset;
reg	    [`EVENT_TAG_BITS-1:0] current_evt;

// signals for  spurious EW_FIFO EMPTY at reset
reg     [7:0]   wait_cnt;
reg		wait_after_rst;
reg     ew_fifo0_empty_reg,    ew_fifo1_empty_reg;
reg     ew_fifo0_empty_latch,  ew_fifo1_empty_latch;
reg     ew_fifo0_empty_sync,   ew_fifo1_empty_sync;

// signals for  spurious EVT_FIFO EMPTY at reset
reg     [7:0] wait_cnt_dreq;
reg		wait_after_dreqrst;
reg     et_fifo0_empty_reg,    et_fifo1_empty_reg;
reg     et_fifo0_empty_latch,  et_fifo1_empty_latch;
reg     et_fifo0_empty_sync,   et_fifo1_empty_sync;

// signals for SIZE_FIFO2 (time domain crossing FIFO for bus from DTCINTERFACE)
wire    et_pckt_empty;
wire	[`EVENT_SIZE_BITS+1:0] 	et_packets_sync;
reg     et_pckt_empty_reg, et_pckt_empty_latch, et_pckt_empty_sync; 

// signals for SIZE_FIFO1 and CNT_FIFO1 (time domain crossing FIFO for buses from PATTERN_FIFO_FILLER)
wire    ew_size_empty, ew_size_full;
wire    [`EVENT_SIZE_BITS+1:0]  ew_size_sync;           // contains ew_size[9:0] + ew_ovfl[10] + ew_error[11]
wire    ew_tag_empty, ew_tag_full;
wire 	[`SPILL_TAG_BITS-1:0]   ewtag_sync;
reg     ew_empty_all, ew_empty_reg, ew_empty_latch;
//reg     ew_empty_ren;
reg     ew_empty_ren_dly;


// signals for SIZE_FIFO0, CNT_FIFO0 and EWTAG_FIFO0 (time domain crossing FIFOs for buses from EW_SIZE_STORE_AND_FETCH_CONTROLLER)
wire    tag_size_empty, tag_addr_empty, tag_evt_empty;
wire    tag_size_full, tag_addr_full, tag_evt_full;
wire    [`EVENT_SIZE_BITS+1:0]   tag_size_sync;         // contains tag_size[9:0] + tag_ovfl[10] + tag_error[11] 
wire	[`DDR_ADDRESS_BITS-1:0]  tag_addr_sync;
wire 	[`EVENT_TAG_BITS-1:0]    tag_evt_sync;

reg     tag_empty_all, tag_empty_reg;
reg     tag_empty_ren, tag_empty_ren_dly;

// signals for CDC (Cross-Domain Clock) handshake of EWTAG_OFFSET from DTCINTERFACE
reg	    ewtag_offset_reg, ewtag_offset_latch, ewtag_offset_delay;
reg     ewtag_offset_pulse;
reg     [`EVENT_TAG_BITS-1:0] ewtag_offset_sync;  

// DDR read vs write inconsistencies
reg	    header1_error, header2_error;
reg	    data_error, event_error, dtctag_error;


///////////////////////////////////////////////////////////////////////////////
// AXI Internal signals
///////////////////////////////////////////////////////////////////////////////
//AXI write/read channel states
reg [2:0]  waddr_state;
reg [2:0]  wdata_state;
reg [2:0]  raddr_state;
reg [2:0]  rdata_state;
//AXI write burst,transaction counters
reg [7:0]  wburst_cnt;
//reg [7:0]  wdburst_cnt;  -- unused
reg [7:0]  wdata_cnt;
//registers for AXI write data
wire [63:0] wdata_int; 
//AXI read burst,transaction counters
reg [7:0]  rburst_cnt; // unused
reg [7:0]  rdburst_cnt;

///////////////////////////////////////////////////////////////////////////////
// state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]    IDLE	=  3'b000,
                    VALID   =  3'b001, 
                    DONE    =  3'b011,
                    SET  	=  3'b010,
                    CHECK	=  3'b110,
                    WAIT    =  3'b100,
                    NEXT	=  3'b101;
						
// this is the offset for the next burst in units of bytes: 
//     bytes-per-beat * burst length in beats
localparam [11:0]  BURST_OFFSET = (2**BURST_SIZE) * (BURST_LENGTH+1); 


wire    [7:0]  wr_burst_length, rd_burst_length;
// after enabling multiple blocks per AXI transcations
assign   wr_burst_length = ew_pckt_to_do + 1;
assign   rd_burst_length = et_pckt_to_do + 1;


//AXI fixed assignments
assign  awid_o    =   0;
assign  awlen_o   =   wr_burst_length;  
assign  awburst_o =   1;     //INCR burst
assign  awsize_o  =   BURST_SIZE; 
assign  wstrb_o   =   8'hFF; //number of bytes to write: all 1s for 8 bytes
assign  bready_o  =   1;     //AXI write response channel is always ready
assign  arid_o    =   0;
assign  arlen_o   =   rd_burst_length; 
assign  arburst_o =   1;     //INCR burst
assign  arsize_o  =   BURST_SIZE; //64-bit read

//
//AXI write/read channel states
assign ew_fifo0_we   = (curr_ewfifo_wr == 1'b0) ?  ew_fifo_we  : 0;   
assign ew_fifo0_wdata= (curr_ewfifo_wr == 1'b0) ?  ew_data     : 0;   
assign ew_fifo1_we   = (curr_ewfifo_wr == 1'b1) ?  ew_fifo_we  : 0; 
assign ew_fifo1_wdata= (curr_ewfifo_wr == 1'b1) ?  ew_data     : 0;   
assign ew_fifo_full  = (curr_ewfifo_wr == 1'b0) ?  ew_fifo0_full  : ew_fifo1_full; 


// diagnostic signals
reg     empty_write_event;
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
    if(resetn_serdesclk == 1'b0)    empty_write_event <= 0;
    else begin
        if (ew_done == 1'b1 && ew_size == 0)    empty_write_event <= 1;
        else                                    empty_write_event <= 0;
    end
end

reg     empty_read_event;
always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)      empty_read_event <= 0;
    else begin
        if (tag_valid == 1'b1 && tag_size == 0) empty_read_event <= 1;
        else                                    empty_read_event <= 0;
    end
end

//
// CDC (Cross-Domain Clock) handshake for DDR_WRITE_DONE
// 1) start REQ on clk_fast signal and clear on "synchronized ACKNOWLEDGE"
// 2) synchronize REQ on clk_slow => REQ_SYNC
// 3) feed-back REQ_SYNC as acknowlegde => ACK_SYNC 
// 4) generate BUSY until ACKOWLEDGE is cleared
reg	    ddr_write_done;
reg	    req, ack_req, ack_sync;
reg	    req_latch, req_sync;
wire	busy;

always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        req <= 0;
    end
    else
    begin
        ack_req <= req_sync;
        ack_sync<=	ack_req;
      
        if (ddr_write_done && !busy)	req <= 1'b1;
        else if (ack_sync)	            req <= 1'b0;
    end
end	

assign 	busy = req || ack_sync;

// synchronize the request on slow clock
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
    if(resetn_serdesclk == 1'b0) 
    begin 
        ddr_done_on_serdesclk	<= 0;
    end
	else
	begin
		req_latch   <= req;
		req_sync    <=	req_latch;
      
		ddr_done_on_serdesclk	<=	req_latch && !req_sync;
	end
end

// CDC (Cross-Domain Clock) handshake for start of DDR Write (from EW_WE_STORE)
//  or end of DDR Write with no hits (from WLAST_o)
reg	    req2, ack_req2, ack_sync2;
reg	    req_latch2, req_sync2;
wire	busy2;
reg	    axi_done_on_serdesclk;
reg	    req2W, ack_req2W, ack_sync2W;
reg	    req_latch2W, req_sync2W;
wire	busy2W;

always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        req2     <= 0;
        req2W    <= 0;
    end
    else
    begin
        ack_req2    <=  req_sync2;
        ack_sync2   <=  ack_req2;
         
        if (ew_we_store && !busy2)	req2 <= 1'b1;
        else if (ack_sync2)			req2 <= 1'b0;
      
        ack_req2W	<=  req_sync2W;
        ack_sync2W  <=	ack_req2W;
      
        if ((wlast_o && ew_size_to_store==0) && !busy2W)    req2W <= 1'b1;
        else if (ack_sync2W)							    req2W <= 1'b0;
    end
end	

assign 	busy2 = req2 || ack_sync2;
assign 	busy2W= req2W|| ack_sync2W;


// synchronize the request on slow clock
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
   if(resetn_serdesclk == 1'b0) 
	begin
		axi_start_on_serdesclk <= 0;
		axi_done_on_serdesclk	<= 0;
	end	
	else
	begin
		axi_start_on_serdesclk <=	req_latch2 && !req_sync2;
			
		req_latch2	<= req2;
		req_sync2	<=	req_latch2;
		
		axi_done_on_serdesclk  <=	req_latch2W && !req_sync2W;
			
		req_latch2W	<= req2W;
		req_sync2W	<=	req_latch2W;
	end
end

//
// CDC (Cross-Domain Clock) handshake for EW_FIFO_EMPTY_PULSE
//  from fast SYSCLK to slow SERDESCLK
reg	    reqE0, ack_reqE0, ack_syncE0;
reg	    reqE0_latch, reqE0_sync, reqE0_reg;
wire	busyE0;
reg	    ew_fifo0_empty_pulse_on_serdesclk;
reg	    reqE1, ack_reqE1, ack_syncE1;
reg	    reqE1_latch, reqE1_sync, reqE1_reg;
wire	busyE1;
reg	    ew_fifo1_empty_pulse_on_serdesclk;

always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        reqE0       <= 0;
        reqE1       <= 0;
    end
    else
    begin
        ack_reqE0	<= reqE0_sync;
        ack_syncE0  <=	ack_reqE0;
      
        if (ew_fifo0_empty_pulse && !busyE0)reqE0 <= 1'b1;
        else if (ack_syncE0)                reqE0 <= 1'b0;
      
        ack_reqE1	<= reqE1_sync;
        ack_syncE1  <=	ack_reqE1;
      
        if (ew_fifo1_empty_pulse && !busyE1)reqE1 <= 1'b1;
        else if (ack_syncE1)                reqE1 <= 1'b0;
    end    
end	

assign 	busyE0 = reqE0 || ack_syncE0;
assign 	busyE1 = reqE1 || ack_syncE1;

// synchronize the request on slow clock
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
    if(resetn_serdesclk == 1'b0) 
	begin
		ew_fifo0_empty_pulse_on_serdesclk   <= 0;
		ew_fifo1_empty_pulse_on_serdesclk   <= 0;
	end	
	else
	begin
		reqE0_latch	<=  reqE0;
		reqE0_sync	<=  reqE0_latch;
		reqE0_reg	<=  reqE0_sync;
		
		ew_fifo0_empty_pulse_on_serdesclk   <= reqE0_sync && !reqE0_reg;
			
		reqE1_latch	<=  reqE1;
		reqE1_sync	<=  reqE1_latch;
		reqE1_reg	<=  reqE1_sync;
		
		ew_fifo1_empty_pulse_on_serdesclk   <= reqE1_sync && !reqE1_reg;
	end
end


always@(posedge sysclk, negedge resetn_sysclk)
begin
   if(resetn_sysclk == 1'b0) 
    begin
        ewtag_offset_reg     <= 1'b0;
        ewtag_offset_latch   <= 1'b0;
        ewtag_offset_delay   <= 1'b0;
        ewtag_offset_pulse   <= 1'b0;
      
        ewtag_offset_sync    <= 0;
    end
	else
	begin
		ewtag_offset_reg     <= ewtag_offset_seen;
		ewtag_offset_latch   <= ewtag_offset_reg;
		ewtag_offset_delay   <= ewtag_offset_latch;
      
        ewtag_offset_pulse   <= (ewtag_offset_latch && ~ewtag_offset_delay);
      
        if (ewtag_offset_pulse) ewtag_offset_sync <= ewtag_offset_in;
	end
end

//
// capture EW_FIFO rising edge (EW_FIFO available to receive a new event!)
// on SERDES_CLK as single clock pulse
always@(posedge serdesclk, negedge resetn_serdesclk)
begin
    if(resetn_serdesclk == 1'b0)  
        ew_fifo_emptied	<= 1'b0;
	else
	begin
		ew_fifo_emptied	<= 0;
		// EW_FIFO_EMPTIED is driven by either one of the EW_FIFO getting emptied
		// OR by the end of a DDR write with zero size 
        if (	ew_fifo0_empty_pulse_on_serdesclk || 
                ew_fifo1_empty_pulse_on_serdesclk || 
                axi_done_on_serdesclk	) 	ew_fifo_emptied	<= 1'b1;
    end
end


//
// latch data to be used when writing beats to memory AFTER EW_FIFO has written full event
// but wait until the end of DDR write to switch EW_FIFO to read 
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        first_ew_ready      <=  1;
        curr_ewfifo_rd      <=  0; 
        
        ddr_write_done_latch<=  0;
        ddr_write_done_reg  <=  0;
		ew_fifo0_toDDR		<=  0;
		ew_fifo1_toDDR		<=  0;
		ew_err0_to_store	<=  0;
		ew_err1_to_store	<=	0;
		ew_ovfl0_to_store	<=  0;
		ew_ovfl1_to_store	<=	0;
        ew_blk0_to_store	<=  0;
        ew_blk1_to_store	<=  0;
        ew_size0_to_store	<=  0;
        ew_size1_to_store	<=  0;
        ew_evtag0_to_store	<=  0;
        ew_evtag1_to_store	<=  0;
    end
    else
    begin
        
        if (newspill_on_sysclk)   begin
            first_ew_ready  <=  1;
            curr_ewfifo_rd  <=  0; 
        end
        
        // pulse indicating that EW_FIFOs have full event and EW_SIZE signals have been properly latched
        if (ew_empty_ren_dly) 
        begin
            first_ew_ready 	<= ~first_ew_ready;
				
         // allow for two 64-bit header words, plus 126 beats, in each 128x64-bit (1kB) block.
         // For event windows with more than max number of allowed hits (1023), save only up to maximum (at which point EW_FIFO gets full)
         // but keep track of overflow in bit[63] of first header word
			if(first_ew_ready)	
			begin
				ew_fifo0_toDDR      <= 1;
                ew_blk0_to_store    <= blk_of_size(ew_size_sync[`EVENT_SIZE_BITS-1:0]);
				ew_err0_to_store	<= ew_size_sync[`EVENT_SIZE_BITS+1];
				ew_ovfl0_to_store	<= ew_size_sync[`EVENT_SIZE_BITS];
				ew_size0_to_store	<= ew_size_sync[`EVENT_SIZE_BITS-1:0];
//				ew_evtag0_to_store  <= {28'b0,ewtag_sync} + ewtag_offset_sync;
				ew_evtag0_to_store  <= {8'b0,spill_tag_rollover, ewtag_sync} + ewtag_offset_sync;
			end
			else
			begin
				ew_fifo1_toDDR      <= 1;
                ew_blk1_to_store    <= blk_of_size(ew_size_sync[`EVENT_SIZE_BITS-1:0]);
				ew_err1_to_store	<= ew_size_sync[`EVENT_SIZE_BITS+1];
				ew_ovfl1_to_store	<= ew_size_sync[`EVENT_SIZE_BITS];
				ew_size1_to_store	<= ew_size_sync[`EVENT_SIZE_BITS-1:0];
//				ew_evtag1_to_store  <= {28'b0,ewtag_sync} + ewtag_offset_sync;
				ew_evtag1_to_store  <= {8'b0,spill_tag_rollover, ewtag_sync} + ewtag_offset_sync;
			end
				
        end
			
		if (ew_fifo0_clr) ew_fifo0_toDDR	<= 0;
		if (ew_fifo1_clr) ew_fifo1_toDDR	<= 0;
			
		//  AXI write done: now switch out of EW_FIFO to read 
		ddr_write_done_latch  <= ddr_write_done;
		ddr_write_done_reg    <= ddr_write_done_latch;
        if (ddr_write_done_latch && !ddr_write_done_reg)    curr_ewfifo_rd  <= ~curr_ewfifo_rd;
			
    end
end


assign ew_fifo0_re  = (curr_ewfifo_rd == 1'b0)  ? ew_fifo_re  : 1'b0;   
assign ew_fifo1_re  = (curr_ewfifo_rd == 1'b1)  ? ew_fifo_re  : 1'b0; 
assign ew_fifo_rdata= (curr_ewfifo_rd == 1'b0)  ? ew_fifo0_rdata   : ew_fifo1_rdata;  
assign ew_fifo_empty= (curr_ewfifo_rd == 1'b0)  ? ew_fifo0_empty   : ew_fifo1_empty; 
  
//
// logic to control current EVT_FIFO I/Os bouncing between EVTTAG and PRETAG
// neeed to use TAG_VALID egde because it is a pulse on DREQCLK
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        curr_etfifo_wr  <= 1'b1;
     
		et_fifo0_fromDDR<= 0;
		et_fifo1_fromDDR<= 0;
		et_err0         <=	0;
		et_err1		    <=	0;
		et_ovfl0        <=	0;
		et_ovfl1		<=	0;
		et_blk0			<= 0;
		et_blk1			<= 0;
		et_fifo0_size	<= 0;
		et_fifo1_size	<= 0;
		et_fifo0_addr   <= 0;
		et_fifo1_addr   <= 0;
		et_fifo0_evt    <= 0;
		et_fifo1_evt	<= 0;
    end
    else
    begin
        
        if (newspill_on_sysclk)   begin
            curr_etfifo_wr  <=  1'b1; 
        end
        
        // at this point TAG bus signals have been properly latched.
        // Make a copy for the next ET_FIFO to use and 
        // generate "et_fifo_fromDDDR" signals used in starting DDR read state machine 
        if (tag_empty_ren_dly) 
        begin
            curr_etfifo_wr <= ~curr_etfifo_wr;
				
			if(curr_etfifo_wr == 1'b1)	
			begin
				et_fifo0_fromDDR<= 1;
                et_blk0         <= blk_of_size(tag_size_sync[`EVENT_SIZE_BITS-1:0]);
				et_ovfl0        <= tag_size_sync[`EVENT_SIZE_BITS];
				et_err0         <= tag_size_sync[`EVENT_SIZE_BITS+1];
				et_fifo0_size   <= tag_size_sync[`EVENT_SIZE_BITS-1:0];
				et_fifo0_addr   <= tag_addr_sync;
				et_fifo0_evt    <= tag_evt_sync;
			end
			else
			begin
				et_fifo1_fromDDR<= 1;
                et_blk1         <= blk_of_size(tag_size_sync[`EVENT_SIZE_BITS-1:0]);
				et_ovfl1        <= tag_size_sync[`EVENT_SIZE_BITS];
				et_err1         <= tag_size_sync[`EVENT_SIZE_BITS+1];
				et_fifo1_size   <= tag_size_sync[`EVENT_SIZE_BITS-1:0];
				et_fifo1_addr   <= tag_addr_sync;
				et_fifo1_evt    <= tag_evt_sync;
			end
				
        end
		
		if (et_fifo0_clr) et_fifo0_fromDDR	<= 0;
		if (et_fifo1_clr) et_fifo1_fromDDR	<= 0;
    end
end

assign et_fifo0_we      = (curr_etfifo_wr == 1'b0) ?  et_fifo_we     : 0;   
assign et_fifo0_wdata   = (curr_etfifo_wr == 1'b0) ?  et_fifo_wdata  : 0;   
assign et_fifo1_we      = (curr_etfifo_wr == 1'b1) ?  et_fifo_we     : 0; 
assign et_fifo1_wdata   = (curr_etfifo_wr == 1'b1) ?  et_fifo_wdata  : 0;   
assign et_fifo_full     = (curr_etfifo_wr == 1'b0) ?  et_fifo0_full  : et_fifo1_full; 


always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)
    begin
        curr_etfifo_rd  <= 1;
        et_pckts_err    <= 0;
        et_pckts_ovfl   <= 0;
		et_pckts        <= 0;
        tag_sent        <= 0;
        tag_null        <= 0;
    end
    else
    begin
        tag_sent <= et_pctk_empty_ren;
        tag_null <= 1'b0;
        
        if (newspill_on_dreqclk)   begin
            curr_etfifo_rd  <=  1; 
        end
        
        if (tag_sent) // this is generated by end of AXI read and it is on DREQCLK
        begin
            curr_etfifo_rd  <= ~curr_etfifo_rd;
			et_pckts 		<= et_packets_sync[`EVENT_SIZE_BITS-1:0];
			et_pckts_ovfl	<= et_packets_sync[`EVENT_SIZE_BITS];
			et_pckts_err	<= et_packets_sync[`EVENT_SIZE_BITS+1];
            
            if (et_packets_sync == 0) tag_null <= 1'b1;
        end
    end
end

assign  et_fifo0_re     = (curr_etfifo_rd == 1'b0) ?  et_fifo_re     : 1'b0;   
assign  et_fifo1_re     = (curr_etfifo_rd == 1'b1) ?  et_fifo_re     : 1'b0; 
assign  et_fifo_rdata   = (curr_etfifo_rd == 1'b0) ?  et_fifo0_rdata : et_fifo1_rdata;  
// NB:  For null size events, this does not tobble (ie ET_FIFO stay always empty.
//      Must use LAST_WORD, that is isuees for EVERY ETG, to makr end of ET_FIFO being read
assign  et_fifo_empty   = (curr_etfifo_rd == 1'b0) ?  et_fifo0_empty : et_fifo1_empty;

//
// capture rising edge of LAST_WORD (generated on DREQCLK) as a pulse of SYSCLK
// and use to clear semaphore used to prevent PREFETC tag to be processed until previous tag is still being read by DTC
reg     [15:0] axi_read_done_cnt;
reg     [15:0] axi_read_we_cnt;
reg     [15:0] last_word_cnt;

assign last_word_start = last_word_latch && ~last_word_sync;
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        last_word_reg  <= 1'b0;
        last_word_latch<= 1'b0;
        last_word_sync <= 1'b0;      
        et_fifo0_toDTC <= 1'b0;
        et_fifo1_toDTC <= 1'b0;
      
        axi_read_sem	<= 1'b0;		// one clock pulse copy of  AXI_READ_DONE 
        axi_read_to_we  <= 1'b0;
        et_packets_hold   <= 0;
        et_packets_to_we  <= 0;
        et_ovfl_hold    <= 0;
        et_ovfl_to_we   <= 0;
        et_err_hold     <= 0;
        et_err_to_we    <= 0;
      
        axi_read_done_cnt <= 0;
        axi_read_we_cnt <= 0;
        last_word_cnt <= 0;
        
    end
    else
    begin
      
        last_word_reg  <= last_word;
        last_word_latch<= last_word_reg;
        last_word_sync <= last_word_latch;
        
        // Create semaphore for AXI_READ_DONE (and TAG_SENT) so we will not miss end of DDR read generated by a 
        // PREFECT if the previous event is still being held in the other ET_FIFO while waiting for DATAREQ protocol.
        if (axi_read_done) 
        begin
            if (curr_etfifo_wr == 0) et_fifo0_toDTC   <= 1'b1;
            else                     et_fifo1_toDTC   <= 1'b1;
        end
      
        if (last_word_start)
        begin
            if (curr_etfifo_rd == 0) et_fifo0_toDTC   <= 1'b0;
            else                     et_fifo1_toDTC   <= 1'b0;
        end
      
        axi_read_to_we <= 1'b0;
        // current ET_FIFO_toDTC is still low on AXI_READ_DONE pulse...
        // If one is set, it must be from the previous Data Request
        if (axi_read_done)
        begin
            if (et_fifo0_toDTC || et_fifo1_toDTC)
            begin
                axi_read_sem    <= 1'b1;
                et_packets_hold <= et_packets;
                et_ovfl_hold    <= save_et_ovfl;
                et_err_hold     <= save_et_err;
            end
            else
            begin
                axi_read_to_we  <= 1'b1;
                et_packets_to_we<= et_packets;
                et_ovfl_to_we   <= save_et_ovfl;
                et_err_to_we    <= save_et_err;
            end
        end
      
        // release AXI_READ_DONE on clearing of previous ET_FIFO_TODTC
        if (axi_read_sem && (et_fifo0_toDTC ^ et_fifo1_toDTC))
        begin
            axi_read_sem    <= 1'b0; 
            axi_read_to_we  <= 1'b1;
            et_packets_to_we<= et_packets_hold;
            et_ovfl_to_we   <= et_ovfl_hold;
            et_err_to_we    <= et_err_hold;
        end      
      
        if (axi_read_done)      axi_read_done_cnt   <= axi_read_done_cnt + 1'b1; 
        if (axi_read_to_we)     axi_read_we_cnt     <= axi_read_we_cnt + 1'b1; 
        if (last_word_start)    last_word_cnt       <= last_word_cnt + 1'b1; 
    end
end
  
//write address channel
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
		DDR_to_write	<= 0;
        DDR_write_on    <= 0;
        
        awaddr_o        <=	0;
        awvalid_o  		<=	0;
        wburst_cnt		<=	0;
		ew_we_store		<=	0;
		ew_DDRwrap_to_store <=	0;
        ew_blk_to_store <= 0;
        ew_pckt_to_do   <= 0;
		ew_left_to_do   <= 0;
		ew_err_to_store <= 0;
		ew_ovfl_to_store<= 0;
		ew_size_to_store<= 0;
		ew_tag_to_store <= 0;
		next_write_addr	<= 0;
		first_wr_hdr	<= 0;
		second_wr_hdr	<= 0;
        waddr_state 	<=	IDLE;
        
        hb_tag_err      <= 1'b0;
        hb_tag_err_cnt  <= 16'b0;
    end
        
    else
   
    begin
		
        ew_we_store		<=	0;
        ew_fifo0_clr	<=	0;
        ew_fifo1_clr	<=	0;
        ddr_write_done	<= 0;
        hb_tag_err      <= 0;
        
        if (newspill_on_sysclk)
        begin   
            DDR_to_write    <= 0;
        end
        
        case(waddr_state)
        
        //wait for memory init command/signal
        IDLE:
        begin
            wburst_cnt		<=	0;
            first_wr_hdr	<= 0;
            second_wr_hdr	<= 0;
            // Start DDR write on EW fully written to EW_FIFO 
            if (DDR_to_write == 0 && ew_fifo0_toDDR == 1)
            begin
                DDR_to_write	<=	1;
                ew_fifo0_clr	<=	1;
                ew_we_store		<=	1;
                ew_blk_to_store	<=  ew_blk0_to_store;
                ew_err_to_store <=  ew_err0_to_store;
                ew_ovfl_to_store<=  ew_ovfl0_to_store;
                ew_size_to_store<=  ew_size0_to_store;
                ew_tag_to_store <=  ew_evtag0_to_store;
                ew_left_to_do	<=  ew_size0_to_store;
             
                if (next_write_addr	> WRAP_DDR_ADDR)	ew_DDRwrap_to_store <=	1;
                else									ew_DDRwrap_to_store <=	0;
                
                waddr_state			<=	SET;
            end
            else if (DDR_to_write == 1 && ew_fifo1_toDDR == 1)
            begin
                DDR_to_write	<=	0;
                ew_fifo1_clr	<=	1;
                ew_we_store		<=	1;
                ew_blk_to_store	<=  ew_blk1_to_store;
                ew_err_to_store <=  ew_err1_to_store;
                ew_ovfl_to_store<=  ew_ovfl1_to_store;
                ew_size_to_store<=  ew_size1_to_store;
                ew_tag_to_store <=  ew_evtag1_to_store;
                ew_left_to_do	<=  ew_size1_to_store;
                
                if ( next_write_addr	> WRAP_DDR_ADDR)	ew_DDRwrap_to_store <=	1;
                else										ew_DDRwrap_to_store <=	0;
                
                waddr_state			<=	SET;
            end
        end
        
        // Set length of remaining write burst
        SET:
        begin
            DDR_write_on    <= 1;
                
            // must leave space for header words!!!
            if (ew_left_to_do > 126)	ew_pckt_to_do <= 126;
            else						ew_pckt_to_do <= ew_left_to_do[7:0];	
            
            waddr_state	<=	VALID;   
        end
        
        //Initiate AXI write 
        //Set start of next DDR address block to write to, depending on the size of the current event
        VALID:
        begin            
            first_wr_hdr	<=  {2'b0, ew_err_to_store, ew_ovfl_to_store, 2'b0, ew_size_to_store, ew_tag_to_store};
//            second_wr_hdr	<=	{16'b0, 8'b0, ew_pckt_to_do,	8'b0,	ew_blk_to_store, 8'b0, (wburst_cnt + 1'b1)}; 
            second_wr_hdr	<=	{ew_pckt_to_do,	ew_blk_to_store, (wburst_cnt + 1'b1), hb_tag_in[39:0]}; 
            
            if ( ew_tag_to_store != hb_tag_in ) begin
                hb_tag_err <= 1;
                hb_tag_err_cnt <= hb_tag_err_cnt + 1;
            end
            
            awvalid_o		<=	1'b1;
            if(awready_i)
            begin
                // commented after moving zeroeing of write address to NEXT state
                //if(ew_DDRwrap_to_store == 1)    next_write_addr	<= 0;
                //else                            next_write_addr	<=	next_write_addr + 1;
                next_write_addr	<=	next_write_addr + 1;
                
                wburst_cnt	<=	wburst_cnt + 1'b1;
                waddr_state	<=	DONE;   
            end
        end
        
        //wait for AXI write completion
        DONE:
        begin
            awvalid_o	<=	1'b0;
            if(bvalid_i)
            begin
                DDR_write_on    <= 0;
                
                // commented after moving zeroeing of write address to NEXT state
                // Address for next AXI write 
                //if(ew_DDRwrap_to_store == 1)    awaddr_o	<= 0;
                //else                            awaddr_o	<=	awaddr_o  + BURST_OFFSET;
                awaddr_o	<=	awaddr_o  + BURST_OFFSET;
                
                waddr_state	<=	NEXT;
            end
        end
        
        //perform next AXI write if data size is over 1 kB
        NEXT:
        begin
            if(wburst_cnt == ew_blk_to_store)
            begin
                ddr_write_done	<= 1;
                // delay write address zeroing until full event with multiple blocks has been written out
                if(ew_DDRwrap_to_store == 1)    
                begin
                    awaddr_o	    <= 0;
                    next_write_addr	<= 0;
                end    
                waddr_state	<=	IDLE;
            end
            else
            begin
                ew_left_to_do <= ew_left_to_do - ew_pckt_to_do;
                waddr_state	<= SET;
            end
        end
        
        default:
        begin
            waddr_state	<=	IDLE;
        end
      
        endcase
    end
end

//write data channel     
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        ew_fifo_starved <= 1'b0;
        ew_fifo_re  <=  1'b0;
        wlast_o		<=	1'b0;
        wvalid_o    <=	1'b0;
        wdata_o		<=  0;
        wdata_cnt	<=  0;
        //wdburst_cnt	<=  0;
        wdata_state <=	IDLE;
    end
    else
    begin
        // With EW_FIFO not FWFT, EW_FIFO will get empty on the last EW_FIFO_RE clock
        // (and together with WLAST_O becoming high). If otherwise, flag as an error
        ew_fifo_starved <= 1'b0;
        if (ew_fifo_re && ew_fifo_empty) ew_fifo_starved <= 1'b1; 
    
        ew_fifo_re  <= 1'b0;
      
        case(wdata_state)
      
        //wait for AXI IF ready
        IDLE:
        begin
            wlast_o		<=	1'b0;
            wvalid_o	<=	1'b0;
            wdata_o		<= 0;
            wdata_cnt	<= 0;
            //wdburst_cnt	<= 0;
            
            if(awvalid_o && awready_i) wdata_state <=   VALID;
        end
       
        //perform AXI burst write
        VALID:
        begin
            wvalid_o	<=	1'b1;
            if(wready_i)
            begin
                wdata_cnt	<=	wdata_cnt + 1'b1;
                
                if (wdata_cnt == 0) 		wdata_o	<=	first_wr_hdr;
                else if (wdata_cnt == 1)	wdata_o	<=	second_wr_hdr; 
                else						wdata_o	<=	ew_fifo_rdata;
             
                // if there is something to read in the EW_FIFO for this event (ie not null size)
                // need to anticipate EW_FIFO_RE by one clock now that EW_FIFO is not FWFT
                if (ew_size_to_store > 0   &&    wdata_cnt < (wr_burst_length-1) )  ew_fifo_re  <= 1'b1;
                
                if(wdata_cnt == wr_burst_length)
                begin
                    wlast_o			<=	1'b1;
                    //wdburst_cnt		<=	wdburst_cnt + 1'b1;
                    wdata_state		<=	DONE;
                end
            end
        end      // VALID state
        
        //generate memory initialization complete
        DONE:
        begin 
                
            if(wready_i)
            begin				
                wvalid_o	<=	1'b0;
                wlast_o		<=	1'b0;
                wdata_cnt	<=	0;   
                wdata_o    <=	wdata_o;
                if(wburst_cnt == ew_blk_to_store)   wdata_state	<=	IDLE;			
                else						        wdata_state	<=	NEXT;
            end
        end
        
        //next AXI burst write operation
        NEXT:
        begin
            if(awvalid_o)	wdata_state	<=	VALID;
        end
        
        default:
        begin
            wlast_o			<=	1'b0;
            wvalid_o		<=	1'b0;
            wdata_o			<=  0;
            wdata_cnt		<=  0;
            wdata_state		<=	IDLE;
        end
      
        endcase
    end
end


//read address channel
// NB:  execute DDR read even if event has null size so that other signals in the ET_FIFO protocols are generated
//      but generate a special flag (TAG_NULL) to tag this case
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
		first_axi_read	<= 1;
        DDR_to_read		<= 0;		// ET_FIFO toggle control
        
        araddr_o		<=	0;
        arvalid_o		<=	0;
        rburst_cnt		<=  0;
		et_fifo0_clr	<= 0;
		et_fifo1_clr	<= 0;
		et_err			<= 0;
		et_ovfl			<= 0;
		et_blk			<= 0;
		et_size			<= 0;
		et_addr		    <= 0;
		et_evt			<= 0;
		et_left_to_do	<= 0;
		et_pckt_to_do	<= 0;
		start_read		<= 0;		// semaphore for read data state machine
        start_read_reg  <= 0;
        raddr_state		<=	IDLE;
    end
    else
    begin
	
        et_fifo0_clr	<=	0;
        et_fifo1_clr	<=	0;
        if (newspill_on_sysclk)   begin
            first_axi_read <= 1;
            DDR_to_read    <= 0;
        end
        
        start_read_reg  <= start_read;
        start_read_pulse<= start_read && !start_read_reg;
        
        case(raddr_state)
        
        //start AXI burst read operation
        IDLE:
        begin
            rburst_cnt		<=	0;
            // Ensure that DDR read:
            //	1) starts on valid tag signal being received
            // 2) waits until previous read is finished (unless very first read)
            // 3) gets data from toggling ET_FIFOs
            if ( (first_axi_read || prev_read_done) && DDR_to_read == 0 && et_fifo0_fromDDR == 1)
            begin
                DDR_to_read		<=	1;
                first_axi_read	<=  0;
                start_read		<=  1;  // needed to start RDATA state machine
                et_fifo0_clr	<=	1;
                et_err			<=  et_err0;
                et_ovfl			<=  et_ovfl0;
                et_blk			<=  et_blk0;
                et_left_to_do	<=  et_fifo0_size;
                et_size			<=  et_fifo0_size;
                et_addr		    <=	et_fifo0_addr;
                et_evt			<=  et_fifo0_evt;
                raddr_state		<=	SET;
            end
            else if (prev_read_done & DDR_to_read == 1 && et_fifo1_fromDDR == 1)
            begin
                DDR_to_read		<=	0;
                start_read		<=  1;
                et_fifo1_clr	<=	1;
                et_err			<=  et_err1;
                et_ovfl			<=  et_ovfl1;
                et_blk			<=  et_blk1;
                et_left_to_do	<=  et_fifo1_size;
                et_size			<=  et_fifo1_size;
                et_addr		    <=	et_fifo1_addr;
                et_evt			<=	et_fifo1_evt;
                raddr_state		<=	SET;
            end
        end
	
        // set inital address based on ET_ADDR, which is a local counter based on ET_SIZE within the spill
        // now that START_READ
        SET:
        begin
            araddr_o	<=	BURST_OFFSET*et_addr;
            raddr_state	<=	CHECK;
        end
        
        // Start loop if more than one DDR block has to be read
        // Set length of remaining write burst (126=0xFE)
        CHECK:
        begin            
            if (et_left_to_do >126) et_pckt_to_do <= 126;
            else				    et_pckt_to_do <= et_left_to_do;			
            raddr_state	<=	WAIT;   
        end
        
        // wait until the write to that address is done
        WAIT:
        begin
            // this condition can halt the state machine if write to DDR is MUCH FASTER than read
            // and AWADDR_O catches up to ARADDR_O after wrapping
            // if (araddr_o != awaddr_o) raddr_state	<=	VALID;
            if (araddr_o != awaddr_o || DDR_write_on == 1'b0) raddr_state	<=	VALID;
        end
        
        //monitor read memory count
        VALID:
        begin
            arvalid_o		<=	1'b1;
            if(arready_i)
            begin
                start_read	<= 0;
                rburst_cnt	<=	rburst_cnt + 1'b1;
                raddr_state	<=	DONE;   
            end
        end
        
        // simplify logic since only single burst allowed
        // start logic for next DDR read is controlled in IDLE state
        DONE:
        begin
            arvalid_o	<=	1'b0;
            if (rburst_cnt == et_blk) 
                raddr_state	<=	IDLE;
            else if(rvalid_i && rlast_i)
            begin
                et_left_to_do <= et_left_to_do - et_pckt_to_do;
                // Address for next AXI write
                araddr_o    <=   araddr_o + BURST_OFFSET;
                raddr_state	<=  CHECK;
            end
        end
        
        default:
        begin
            raddr_state	<=	IDLE;
        end

   endcase
	end
end

//read data channel
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0) begin
        rready_o        <=	1'b0;
        rdburst_cnt		<=	8'b0;
        prev_read_done	<=	1'b0;		// level started by end or RBURST and ended by START_READ
		axi_read_done	<= 1'b0;		// pulse at the end of DDR read after RVALID is cleared
        et_fifo_wdata	<=	64'b0;
        et_fifo_we		<=	1'b0; 
		et_packets		<= 0;
		first_rd_hdr	<= 0;
		second_rd_hdr	<= 0;
        header1_error	<=	1'b0;
        header2_error	<=	1'b0;
        dtctag_error    <=	1'b0;
        data_error      <=	1'b0;
        event_error     <=	1'b0;
		hdr_cnt			<= 0;
		save_et_err	    <= 0;
		save_et_ovfl	<= 0;
		word32_offset	<= -1;
		current_evt		<= 0;
		next_word		<= 0;
	  
        DDR_error_mask  <= 0;
        hdr1_expc       <= 0;
        hdr1_seen       <= 0;
        hdr2_expc       <= 0;
        hdr2_seen       <= 0;
        evt_expc        <= 0;
        evt_seen        <= 0;
        data_expc       <= 0;
        data_seen       <= 0;
        tag_expc        <= 0;
        tag_seen        <= 0;
        
        hb_dreq_error  <= 1'b0;
        hb_dreq_error_cnt   <= 16'b0;
      
        rdata_state		<=	IDLE;
    end
	
    else begin

        et_fifo_we		<=	1'b0; 
        axi_read_done	<= 1'b0;	
        hb_dreq_error   <= 1'b0;      
        
        case(rdata_state)
        
        IDLE:
        begin
            
            rdburst_cnt		<=	8'b0;      
            et_fifo_wdata	<=	{64{1'b1}};
            et_fifo_we		<=	1'b0; 
            first_rd_hdr	<= 0;
            second_rd_hdr	<= 0;
            // by commenting them, the first error of each kind will drive the relative ERROR forever
            header1_error	<=	1'b0;
            header2_error	<=	1'b0;
            dtctag_error    <=	1'b0;
            data_error      <=	1'b0;
            event_error     <=	1'b0;
			
            // start of read data state machine AFTER read address state machine has set the address
            if (start_read && (araddr_o != awaddr_o) ) begin
                prev_read_done	<=  1'b0;
                rready_o		<=	1'b0;
                rdata_state		<=	SET; 
            end
        end
        
        // set RREADY, wait for RVALID
        // detect condition for fixing DATA_ERROR logic
        SET:
        begin
            current_evt			<= et_evt;            
            save_et_err		    <= et_err;            
            save_et_ovfl		<= et_ovfl;
            
            rready_o			<=	1'b1;
            rdata_state			<=	VALID;
        end
        
        //save read data to ET_FIFO input and check eventheader words
        VALID:
        begin
            if(rdburst_cnt == et_blk)   begin
                axi_read_done	<= 1'b1;			
                et_packets		<= et_size; // change from 64-bit beat units to 128-bit packet units
                prev_read_done	<=	1'b1;	// level from end of read to start of next one
                rready_o		<=	1'b0;
                rdata_state		<=	IDLE;
            end
            else begin
                if(rvalid_i) begin
                    
                    // stop here so first and second_rd_hdr are not overwritten
                    if (hdr_cnt < 3)	hdr_cnt	<= hdr_cnt + 1; 
                    
                    // Start error checking:
                    // 1) EVENT_ERROR   (DDR_error_mask[0]=1) if local event tag in data from DDR does not agree with current event tag
                    // 2) HEADER1_ERROR (DDR_error_mask[1]=1) if event size in data from DDR does not agree with current event size
                    // 3) HEADER2_ERROR (DDR_error_mask[2]=1) if event block in data from DDR does not agree with current event block
                    // 4) DATA_ERROR    (DDR_error_mask[3]=1) if event err/ovfl in data from DDR does not agree with current err/ovfl
                    // 5) DTC_ERROR     (DDR_error_mask[4]=1) if DREQ event tag does not agree with save HB event tag
                    // Save seen and expected ONLY for first error occurence.
                    if (hdr_cnt == 1)   begin
                    
                        if (first_rd_hdr[`EVENT_TAG_BITS-1:0] != current_evt) begin
                            event_error         <= 1;
                            // save only first occurence
                            if (DDR_error_mask[0] == 1'b0)  begin
                                DDR_error_mask[0]   <= 1'b1;
                                evt_expc    <= {2'b0, et_err, et_ovfl, 2'b0, et_size, current_evt};
                                evt_seen    <= first_rd_hdr;
                            end
                        end
                        
                        if  (first_rd_hdr[48+`EVENT_SIZE_BITS-1 : 48] != et_size) begin
                            header1_error       <= 1;
                            // save only first occurence
                            if (DDR_error_mask[1] == 1'b0) begin
                                DDR_error_mask[1]   <= 1'b1;
                                hdr1_expc   <= {2'b0, et_err, et_ovfl, 2'b0, et_size, current_evt};
                                hdr1_seen   <= first_rd_hdr;
                            end
                        end
                        
                        if  (first_rd_hdr[63] != et_err || first_rd_hdr[62] != et_ovfl ) begin
                            data_error          <= 1;
                            // save only first occurence
                            if (DDR_error_mask[3] == 1'b0) begin
                                DDR_error_mask[3]   <= 1'b1;
                                data_expc   <= {2'b0, et_err, et_ovfl, 2'b0, et_size, current_evt};
                                data_seen   <= first_rd_hdr;
                            end
                        end
                    end
                    
                    if (hdr_cnt == 2) begin
                        
                        if (second_rd_hdr[39:0] != dreq_tag_in[39:0] ) begin
                            hb_dreq_error   <= 1'b1;
                            hb_dreq_error_cnt <= hb_dreq_error_cnt + 1;
                            dtctag_error        <= 1;
                            // save only first occurence
                            if (DDR_error_mask[4] == 1'b0) begin
                                DDR_error_mask[4]   <= 1'b1;
                                tag_expc    <= {16'b0, dreq_tag_in};
                                tag_seen    <= second_rd_hdr;
                            end
                        end;
                        
                        if  (   second_rd_hdr[63:56] != et_pckt_to_do  ||  
                                second_rd_hdr[55:48] != et_blk  || 
                                second_rd_hdr[47:40] != (rdburst_cnt+1) ) begin
                            header2_error       <= 1;
                            // save only first occurence
                            if (DDR_error_mask[2] == 1'b0) begin
                                DDR_error_mask[2]   <= 1'b1;
                                hdr2_expc   <= {et_pckt_to_do, et_blk, rdburst_cnt+1, second_rd_hdr[39:0]};
                                hdr2_seen   <= second_rd_hdr;
                            end
                        end
                    end
                    
                    if (hdr_cnt == 0)	begin
                        first_rd_hdr	<= rdata_i;
                    end	
                    else if (hdr_cnt == 1)	begin
                        second_rd_hdr	<= rdata_i;
                        // prepare word for data pattern check
                        // update ONLY if no zero size cluster
                        next_word	<= {word32_offset + 2, word32_offset + 1};
                        if (et_size>0) word32_offset	<= word32_offset + 2;
                    end	
                    else begin
                        et_fifo_wdata	<=	rdata_i;
                        et_fifo_we		<=	1'b1; 
                        
                        // update ONLY if no zero size cluster
                        next_word	<= {word32_offset + 2, word32_offset + 1};
                        if (et_size>0) word32_offset	<= word32_offset + 2;
                        
                        //// check on data pattern
                        //if (data_error == 0 && next_word != rdata_i) begin
                            //data_error <= 1; 
                            //data_expc <= next_word;
                            //data_seen <= rdata_i;
                        //end
				  
                        //
                        // fix error detection and overwrite error if overflow was detected for previous event
                        if (hdr_cnt==2) begin
                            word32_offset	<= rdata_i[63:32] + 2;
                            next_word		<= {rdata_i[63:32] + 2, rdata_i[31:0] + 2};
                            //data_error		<=	0;
                        end
                    end
                end
            end
            
            // increment read burst number and save word for next event check
            if(rlast_i && rvalid_i) begin
                hdr_cnt 		<= 0;	
                if (et_size>0) word32_offset	<= rdata_i[63:32];  
                rdburst_cnt	<=	rdburst_cnt + 1'b1;
            end
        end
        
        default:
        begin
            rready_o    <=	1'b0;
            rdata_state	<=	IDLE;
        end
        
        endcase
        
    end
end


// EW_FIFOs 32x2048 WR/64x1024 RD to allow up to 512(256) packets(hits) per window to DDR
//  These FIFOs have with ALMOST_FULL = (WIDTH-1)
EW_FIFO	ew_fifo0 (
	.WCLOCK	    (serdesclk),
	.WRESET_N   (resetn_fifo),
	.DATA		(ew_fifo0_wdata),
	.WE		    (ew_fifo0_we),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (ew_fifo0_re),
	// Outputs
	.EMPTY	    (ew_fifo0_empty),
	.FULL		( ),
	.AFULL	    (ew_fifo0_full),
	.Q			(ew_fifo0_rdata)
);

EW_FIFO	ew_fifo1 (
	.WCLOCK	    (serdesclk),
	.WRESET_N   (resetn_fifo),
	.DATA		(ew_fifo1_wdata),
	.WE		    (ew_fifo1_we),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (ew_fifo1_re),
	// Outputs
	.EMPTY	    (ew_fifo1_empty),
	.FULL		( ),
	.AFULL	    (ew_fifo1_full),
	.Q			(ew_fifo1_rdata)
);

//
// logic to clean spurious EW_FIFO_EMPTY at reset
// and latch EW_FIFO_EMPTY rising edge
always@(posedge sysclk, negedge resetn_sysclk)
begin
   if(resetn_sysclk == 1'b0)
	begin
		ew_fifo0_empty_reg   <= 1'b0;
		ew_fifo1_empty_reg   <= 1'b0;
		ew_fifo0_empty_latch <= 1'b0;
		ew_fifo1_empty_latch <= 1'b0;
		ew_fifo0_empty_sync  <= 1'b0;
		ew_fifo1_empty_sync  <= 1'b0;
		ew_fifo0_empty_pulse <= 1'b0;
		ew_fifo1_empty_pulse <= 1'b0;
      
		wait_after_rst		<= 1;
		wait_cnt				<= 0;
	end	
	else
	begin
		ew_fifo0_empty_reg   <= ew_fifo0_empty;
		ew_fifo0_empty_latch <= ew_fifo0_empty_reg;
		ew_fifo0_empty_sync  <= ew_fifo0_empty_latch;
      
		ew_fifo1_empty_reg   <= ew_fifo1_empty;
		ew_fifo1_empty_latch <= ew_fifo1_empty_reg;
		ew_fifo1_empty_sync  <= ew_fifo1_empty_latch;
		
		// count some clocks after a reset to avoid spurious EW_FIFO_EMPTY_PULSE
		if (wait_after_rst)	wait_cnt	<=	wait_cnt + 1;
      
		if (wait_cnt > WAIT_FOR_RST) begin
         wait_after_rst	<=	0;
         ew_fifo0_empty_pulse <= ew_fifo0_empty_latch & !ew_fifo0_empty_sync;
         ew_fifo1_empty_pulse <= ew_fifo1_empty_latch & !ew_fifo1_empty_sync;
      end
	end
end

//
// EVT_FIFOs (64x1024) to allow up to 512(256) packets(hits) per window from DDR
//  These FIFOs have ALMOST_FULL=1024 to tag max. no of hits (255) 
EVT_FIFO		evt_fifo0 (
	.WCLOCK	(sysclk),
	.WRESET_N(resetn_fifo),
	.DATA		(et_fifo0_wdata),
	.WE		(et_fifo0_we),
	.RCLOCK	(dreqclk),
	.RRESET_N(resetn_fifo),
	.RE		(et_fifo0_re),
	// Outputs
	.EMPTY	(et_fifo0_empty),
//	.AEMPTY	(	),
	.FULL		( ),
	.AFULL		(et_fifo0_full),
	.Q			(et_fifo0_rdata)
);
	
EVT_FIFO		evt_fifo1 (
	.WCLOCK	(sysclk),
	.WRESET_N(resetn_fifo),
	.DATA		(et_fifo1_wdata),
	.WE		(et_fifo1_we),
	.RCLOCK	(dreqclk),
	.RRESET_N(resetn_fifo),
	.RE		(et_fifo1_re),
	// Outputs
	.EMPTY	(et_fifo1_empty),
//	.AEMPTY	(	),
	.FULL		( ),
	.AFULL		(et_fifo1_full),
	.Q			(et_fifo1_rdata)	
);

//
// logic to clean spurious ET_FIFO_EMPTY at reset and 
// align with DREQCLK
always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)
    begin
        wait_after_dreqrst<= 1;
		wait_cnt_dreq     <= 0;
      
        et_fifo0_empty_reg   <= 0;
        et_fifo0_empty_latch <= 0;
        et_fifo0_empty_sync  <= 0;
        et_fifo1_empty_reg   <= 0;
        et_fifo1_empty_latch <= 0;
        et_fifo1_empty_sync  <= 0;
      
        // single SERDES_CLK pulse capturing SIZE_FIFO0 becoming available to receive a new event
        // N.B. It relies on SIZE_FIFO0 writing something for each tag, even if of NULL SIZE
        //      AND SIZE_FIFO0 being written again only after being read out (via AXI_READ_SEM)
        et_fifo_emptied	<= 1'b0;
    end
    else
    begin
        if (wait_after_dreqrst) wait_cnt_dreq	<=	wait_cnt_dreq + 1;
        if (wait_cnt_dreq > WAIT_FOR_RST) wait_after_dreqrst   <= 0;
      
        et_fifo0_empty_reg   <= et_fifo0_empty;
        et_fifo0_empty_latch <= et_fifo0_empty_reg;
        et_fifo0_empty_sync  <= et_fifo0_empty_latch;
        et_fifo1_empty_reg   <= et_fifo1_empty;
        et_fifo1_empty_latch <= et_fifo1_empty_reg;
        et_fifo1_empty_sync  <= et_fifo1_empty_latch;
      
		et_fifo_emptied	<= 0;
        // ET_FIFO_EMPTIED is driven by either one of the ET_FIFO getting emptied
		if (wait_cnt_dreq > WAIT_FOR_RST)
		begin
			if (	(et_fifo0_empty_latch && !et_fifo0_empty_sync) 	|| 
					(et_fifo1_empty_latch && !et_fifo1_empty_sync)) et_fifo_emptied	<= 1'b1;
		end
        
    end
end

//
// time domain crossing FIFO for ET_PACKETS output bus 
// to be passed to TOP_SERDES from SYSCLK to DREQCLK
// SIZE_FIFO is 12b x 64 (natural uSRAM size)
SIZE_FIFO   size_fifo2 (
	.WCLOCK	(sysclk),
	.WRESET_N(resetn_fifo),
//	.DATA   ({1'b0, et_ovfl_to_we, et_packets_to_we}),
	.DATA   ({et_err_to_we, et_ovfl_to_we, et_packets_to_we}),
	.WE		(axi_read_to_we),
	.RCLOCK	(dreqclk),
	.RRESET_N(resetn_fifo),
	.RE		(et_pctk_empty_ren),
	// Outputs
	.EMPTY	(et_pckt_empty),
	.FULL	(),
	.Q		(et_packets_sync)	
);

// logic to clean spurious ET_PCKT_EMPTY at reset
always@(posedge dreqclk, negedge resetn_dreqclk)
begin
    if(resetn_dreqclk == 1'b0)
    begin
        et_pckt_empty_reg   <= 0;
        et_pckt_empty_latch <= 0;
        et_pckt_empty_sync  <= 0;
        et_pctk_empty_ren   <= 0;
    end
    else
    begin
        et_pckt_empty_reg   <= ~et_pckt_empty;
        et_pckt_empty_latch <= et_pckt_empty_reg;
        et_pckt_empty_sync  <= et_pckt_empty_latch;
      
        if (wait_cnt_dreq  > WAIT_FOR_RST) 
        begin
            et_pctk_empty_ren <= et_pckt_empty_latch && ~et_pckt_empty_sync;
        end
    end
end


//
// time domain crossing FIFO for "pattern_fifo_filler"
// (SIZE_FIFO is 12b x 64)
// EW bus input signals from SERDESCLK to SYSCLK
SIZE_FIFO   size_fifo1 (
	.WCLOCK	    (serdesclk),
	.WRESET_N   (resetn_fifo),
//	.DATA	    ({1'b0, ew_ovfl, ew_size}),
	.DATA	    ({ew_error, ew_ovfl, ew_size}),
	.WE		    (ew_done),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (ew_empty_ren),
	// Outputs
	.EMPTY	    (ew_size_empty),
	.FULL		(ew_size_full),
	.Q			(ew_size_sync)	
);

// CNT_FIFO is 20b x 64 since
// EW_TAG bus is only 20 bits (local counter within a spill)
CNT_FIFO	cnt_fifo1 (
	.WCLOCK	    (serdesclk),
	.WRESET_N   (resetn_fifo),
	.DATA		(ew_tag),
	.WE		    (ew_done),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (ew_empty_ren),
	// Outputs
	.EMPTY	    (ew_tag_empty),
	.FULL		(ew_tag_full),
	.Q			(ewtag_sync)	
);

//
// logic to clean spurious EW_SIZE_EMPTY at reset
// and latch EW_SIZE_EMPTY rising edge
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        ew_empty_all   <= 0;
        ew_empty_reg   <= 0;
        ew_empty_ren   <= 0;
        ew_empty_ren_dly    <= 0;
    end
    else
    begin
        if (wait_cnt  > WAIT_FOR_RST) 
        begin
            ew_empty_all <= (!(ew_size_empty || ew_tag_empty)) ? 1'b1: 1'b0;
        end
      
        ew_empty_reg   <= ew_empty_all;
      
        ew_empty_ren    <= ew_empty_all && ~ew_empty_reg;
        ew_empty_ren_dly<= ew_empty_ren;
    end  
end 

//
// set time domain crossing FIFOs for "ew_size_store_and_fetch_controller"
// TAG bus input signals from from DREQCLK to SYSCLK
// SIZE_FIFO is 12b x 64
SIZE_FIFO   size_fifo0 (
	.WCLOCK	    (dreqclk),
	.WRESET_N   (resetn_fifo),
//	.DATA		({1'b0, tag_ovfl, tag_size}),
	.DATA		({tag_err, tag_ovfl, tag_size}),
	.WE		    (tag_valid),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (tag_empty_ren),
	// Outputs
	.EMPTY	    (tag_size_empty),
	.FULL		(tag_size_full),
	.Q			(tag_size_sync)	
);

// CNT_FIFO is 20b x 64 
CNT_FIFO   cnt_fifo0 (
	.WCLOCK	    (dreqclk),
	.WRESET_N   (resetn_fifo),
	.DATA		(tag_addr),
	.WE		    (tag_valid),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (tag_empty_ren),
	// Outputs
	.EMPTY	    (tag_addr_empty),
	.FULL		(tag_addr_full),
	.Q			(tag_addr_sync)	
);

// EWTAG_FIFO is 48bx64
EWTAG_FIFO	ewtag_fifo0 (
	.WCLOCK	    (dreqclk),
	.WRESET_N   (resetn_fifo),
	.DATA		(tag_evt),
	.WE		    (tag_valid),
	.RCLOCK	    (sysclk),
	.RRESET_N   (resetn_fifo),
	.RE		    (tag_empty_ren),
	// Outputs
	.EMPTY	    (tag_evt_empty),
	.FULL		(tag_evt_full),
	.Q			(tag_evt_sync)	
);

//
// logic to clean spurious TAG_EMPTYs at reset
// and latch TAG_EMPTYs rising edge
always@(posedge sysclk, negedge resetn_sysclk)
begin
    if(resetn_sysclk == 1'b0)
    begin
        tag_empty_all    <= 0;
        tag_empty_reg    <=  0;
        tag_empty_ren    <=  0;
        tag_empty_ren_dly<=  0;
    end
    else
    begin
        // TAG_EMPTY_ALL  is set when all TAG FIFOs have seen data and are NOT empty
        if (wait_cnt  > WAIT_FOR_RST) 
            tag_empty_all   <= (!(tag_size_empty || tag_addr_empty || tag_evt_empty)) ? 1'b1: 1'b0;
         
        tag_empty_reg  <= tag_empty_all;
        
        // generate pulse, and a delayed version, at TAG_EMPTY_ALL rising edge 
        tag_empty_ren       <= tag_empty_all && ~tag_empty_reg;
        tag_empty_ren_dly   <= tag_empty_ren;
    end
end   

//
// function to calculate number of 1kB memory block needed to fit a given number of
// tracker hits, after accounting for the two 64-bit headers in each block
// (0.5 hit => 128-bit => 2 beats)
function automatic [7:0] blk_of_size;
    input	[`EVENT_SIZE_BITS-1:0]	size;
    begin
        if 	   (size > 1008)            blk_of_size	= 9;  // >=1008 beats (252 trackers hits)  
        else if 	(size > (896-14))   blk_of_size	= 8;	// >= 882 beats (220.5 trackers hits)  
        else if 	(size > (768-12))   blk_of_size	= 7;	// >= 756 beats (189 trackers hits)  
        else if 	(size > (640-10))   blk_of_size	= 6;	// >= 630 beats (157.5 trackers hits)  
        else if 	(size > (512-8))    blk_of_size	= 5;	// >= 504 beats (126 trackers hits)  
        else if 	(size > (384-6))    blk_of_size	= 4;	// >= 378 beats (94.5 trackers hits)  
        else if 	(size > (256-4))    blk_of_size	= 3;	// >= 252 beats (63   trackers hits)  
        else if 	(size > (128-2))    blk_of_size	= 2;	// >= 126 beats (31.5 trackers hits)
        else						    blk_of_size	= 1;
    end
endfunction

endmodule

