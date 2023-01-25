///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: rocfifo_cntrl.v
// File history:
//      v1.0: <Aug. 2021>: first version
//      v2.0: <Jan. 2022>: added multiple ROCs handling
//      v3.0: <Feb. 2022>: added logic to deal with tag with overflow hits (ie more than 512 hits -> 2047 64-bit words)
//      v4.0: <Mar. 2022>: change EW_SIZE output dimensions to [EVENT_SIZE_BITS:0] => MAX allowed value is 4096
//
// Description: 
//
//    This modules controls the data flow from N x ROCFIFOs to EW_FIFO_CNTRL
//       N.B: It is important that ROCFIFOs are FWFT (First-Word Fall-Through) for this logic to work!!!
//            Also SIM_ROC_FIFO need to handle only one tag at the time -> 32bit x 4096 deep is all it needs to be.
//    Runs on 150 MHz SERDESCLK:
//    Waits for first 32-bit header word containing EW size (MSB 12-bit) and SPILL_EWTAG info (LSB 20-bit). 
//    Then reads as needed if WR_CNT > 0 until EW_SIZE is reached. Move to next ROC_FIFO if it exists.
//    Generates CURR_EWFIFO_WR, EWTAG and EW_SIZE for the event window data readout into DDR memory when all ROCFIFOs are read.
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>
`include "tracker_params.vh"

module rocfifo_cntrl#(
	parameter 			NROCFIFO       =	1     // no. of ROCFIFO
) (
//global signals
   input    serdesclk,        // on 200 MHz input serdes clock
   input    resetn_serdesclk,

	input	rocfifo0_full,         // ROCFIFO0 is FULL
   input	[`DIGI_BITS-1:0] rocfifo0_data,  // data from ROCFIFO0 
	input	rocfifo0_empty,         // ROCFIFO0 has some data
   input	[`ROCFIFO_DEPTH-1:0] rocfifo0_wrcnt,  // WRCNT from ROCFIFO0 - unused 

   //input	rocfifo1_full,      
   //input	[`DIGI_BITS-1:0] rocfifo1_data,  
	//input	rocfifo1_empty,     
   //input	[`ROCFIFO_DEPTH-1:0] rocfifo1_wrcnt, 
//
   //input	rocfifo2_full,      
   //input	[`DIGI_BITS-1:0] rocfifo2_data,  
	//input	rocfifo2_empty,     
   //input	[`ROCFIFO_DEPTH-1:0] rocfifo2_wrcnt, 
//
   //input	rocfifo3_full,      
   //input	[`DIGI_BITS-1:0] rocfifo3_data,  
	//input	rocfifo3_empty,     
   //input	[`ROCFIFO_DEPTH-1:0] rocfifo3_wrcnt, 

   input axi_start_on_serdesclk,  // ROCFIFO data is being written to DDR. Can start processing next HB.

	output rocfifo0_re,	   // ROCFIFO0 read enable
	//output rocfifo1_re,	   
	//output rocfifo2_re,	   
	//output rocfifo3_re,	   
   
   output reg  curr_ewfifo_wr,
   output reg  ew_done,                         // full event payload read from N x ROC_FIFO
   output reg  ew_fifo_we,                      // EW_FIFOs write enable
   output reg  ew_ovfl,                         // size overflow
	output reg  [`DIGI_BITS-1:0]    ew_data,	   // data to EW_FIFOs
	output reg  [`EVENT_SIZE_BITS-1:0]  ew_size,    // EW size in units of 64-bits AXI beats
	output reg  [`SPILL_TAG_BITS-1:0] ew_tag      // EW SPILL TAG
);

///////////////////////////////////////////////////////////////////////////////
// Internal signals
///////////////////////////////////////////////////////////////////////////////
//
localparam  MAX_BEATS   = (2**`TRK_HIT_BITS-1)*4;

wire  [NROCFIFO-1:0] rocfifo_full;          // ROCFIFO is FULL
wire  [NROCFIFO-1:0] rocfifo_empty;         // ROCFIFO has some data
wire  [`DIGI_BITS-1:0] rocfifo_data[NROCFIFO-1:0] ;  // data from ROCFIFO 
wire  [`ROCFIFO_DEPTH-1:0]  rocfifo_wrcnt[NROCFIFO-1:0];  // WRCNT from ROCFIFO 
reg   [NROCFIFO-1:0] rocfifo_re;
   
assign rocfifo_full[0]  = rocfifo0_full;
//assign rocfifo_full[1]  = rocfifo1_full;
//assign rocfifo_full[2]  = rocfifo2_full;
//assign rocfifo_full[3]  = rocfifo3_full;

assign rocfifo_empty[0] = rocfifo0_empty;
//assign rocfifo_empty[1] = rocfifo1_empty;
//assign rocfifo_empty[2] = rocfifo2_empty;
//assign rocfifo_empty[3] = rocfifo3_empty;

assign rocfifo_data[0]  = rocfifo0_data;
//assign rocfifo_data[1]  = rocfifo1_data;
//assign rocfifo_data[2]  = rocfifo2_data;
//assign rocfifo_data[3]  = rocfifo3_data;

assign rocfifo_wrcnt[0] = rocfifo0_wrcnt;
//assign rocfifo_wrcnt[1] = rocfifo1_wrcnt;
//assign rocfifo_wrcnt[2] = rocfifo2_wrcnt;
//assign rocfifo_wrcnt[3] = rocfifo3_wrcnt;

assign rocfifo0_re   =  rocfifo_re[0];
//assign rocfifo1_re   =  rocfifo_re[1];
//assign rocfifo2_re   =  rocfifo_re[2];
//assign rocfifo3_re   =  rocfifo_re[3];

reg   ew_tag_error;
reg [11:0]  curr_size;  // size for current ROCFIFO in units of 32-bits
reg [11:0]  full_size;  // event window size in units of packets (64-bits) to allow for meaningful overflow condition
reg [15:0]     rd_cnt;	      // counter for single FIFO
reg [15:0]     full_rd_cnt;	// counter for full event


reg [2:0]  data_state;
///////////////////////////////////////////////////////////////////////////////
// state machine encoding
///////////////////////////////////////////////////////////////////////////////
localparam [2:0]  IDLE	=   3'b000,
                  CHECK	=   3'b001,
						COUNT	=   3'b010,
                  STOP	=   3'b011,
                  UPDATE=   3'b100,
                  HOLD	=   3'b101,
                  RESET =   3'b111;

integer  index;
reg[7:0] wait_cnt;
reg      timeout_en;
reg[15:0]timeout_cnt;

always@(posedge serdesclk, negedge resetn_serdesclk)
begin
   if(resetn_serdesclk == 1'b0)
	begin
      index       = 0;
      curr_ewfifo_wr <= 1'b1;
      rocfifo_re  <= 0;
      ew_fifo_we  <= 1'b0;
      ew_done	   <= 1'b0;
      ew_ovfl     <= 1'b0;
      ew_data     <= 0;
      ew_size     <= 0;
      ew_tag      <= 0;
      ew_tag_error<= 1'b0;
      curr_size   <= 0;
      full_size   <= 0;
      rd_cnt      <= 0;
      full_rd_cnt <= 0;
		wait_cnt    <= 0;
      timeout_en  <= 0;
      timeout_cnt <= 0;
      data_state  <= RESET;
   end
   
   else
   begin
   
      ew_fifo_we  <= 1'b0;
      
      case(data_state)
       
      // avoid spurious ROCFIFO_EMPTY pulses during a FIFO reset
      RESET:
      begin
         wait_cnt	<=	wait_cnt + 1;
         if (wait_cnt > 8'hF0 ) data_state  <= IDLE;
      end

      // when ROCFIFO not empty, decode header word
      IDLE:
      begin
         
         ew_done     <= 1'b0;
         
         if (rocfifo_empty[index] == 1'b0)
         begin
            // set which EW_FIFO has to receive the data
            if ( index==0 )  curr_ewfifo_wr <= ~curr_ewfifo_wr;
            
            // diagnostics: all ROCFIFOs should report data header from same TAG
            if ( index==0 )  ew_tag   <= rocfifo_data[index][19:0];
            else if ( rocfifo_data[index][19:0] != ew_tag)  ew_tag_error <= 1'b1;
            
            curr_size <= rocfifo_data[index][31:20];              // size from current ROCFIFO in units of 32-bit words
            full_size <= full_size + rocfifo_data[index][31:21];  // total no. of packets (64-bit) for current event window
            ew_size  <= ew_size + rocfifo_data[index][31:21];     // size summed over all ROCFIFOs in units of packets, or 64-bit words
            
            // read at least header word
            rocfifo_re[index] <= 1'b1;
          
            data_state  <= CHECK;
         end
      end
          
      // check on event size and send to COUNT or jump to UPDATE if size is null
      CHECK:
      begin
         // set size and check on overflow condition
         // if overflow found, save first 1020 packets (or 255 tracker hits)
         ew_size  <= (full_size > MAX_BEATS) ? MAX_BEATS  : ew_size; 
         ew_ovfl  <= (full_size > MAX_BEATS) ? 1'b1  : 1'b0 ;
          
         if ( curr_size > 0 )
         begin
            // REDUNDANT (unless ROCFIFO write speed is less than read speed)
            //if ( rocfifo_wrcnt[index] > 0 )
            //begin
               rocfifo_re[index] <= 1'b1;
               rd_cnt 			   <= rd_cnt + 1'b1;
               full_rd_cnt       <= full_rd_cnt + 1'b1;
               data_state        <= COUNT;
            //end
         end
         else
         begin
            rocfifo_re[index] <= 1'b0;
            data_state        <= UPDATE;  // go to UPDATE where index is updated
         end
      end
          
      // read out everything from PATTERN_FIFOs using CURR_SIZE 
      // BUT write out to EW_DATA only until EW_SIZE is reached (in case an overflow condition is detected)
      COUNT:
      begin
         rocfifo_re[index] <= 1'b0;
         
         // fill data and read next 32-bit word if in ROCFIFO
         // REDUNDANT (unless ROCFIFO write speed is less than read speed)
         //if ( rocfifo_wrcnt[index] > 0)
         //begin
            rocfifo_re[index] <= 1'b1;
            rd_cnt 			   <= rd_cnt + 1'b1;
            
            full_rd_cnt   <= full_rd_cnt + 1'b1;
            if (full_rd_cnt <= ew_size*2) 
            begin
               ew_data     <= rocfifo_data[index]; 
               ew_fifo_we  <= 1'b1;
            end
            
            if(rd_cnt == (curr_size-1)) data_state  <= STOP;
         //end
      end
      
      // write out one last 32-bit word, unless EW_SIZE is already reached 
      STOP:
      begin
         rocfifo_re[index] <= 1'b0;
         rd_cnt            <= 0;
            
         if (full_rd_cnt <= ew_size*2) 
         begin
            ew_data     <= rocfifo_data[index]; 
            ew_fifo_we  <= 1'b1;
         end
          
         data_state        <= UPDATE;
      end
      
      // update INDEX and issue EW_DONE 
      UPDATE:
      begin
         if (index<(NROCFIFO-1)) 
         begin
            index       = index + 1;
            data_state  <= IDLE;
         end
         else
         begin
            index       = 0;
            full_rd_cnt <= 0;
            ew_done     <= 1'b1;
            data_state  <= HOLD;
         end
      end
      
      // clear EW_DONE
      // wait to reset size and to start next Event Window until DDR start
      HOLD:
      begin
         ew_done     <= 1'b0;
         if(axi_start_on_serdesclk) 
         begin
            ew_ovfl     <= 0;
            ew_size     <= 0;    
            full_size   <= 0;    
            data_state  <= IDLE;
         end
      end
         
      default:
      begin
         data_state  <= IDLE;
      end
         
      endcase;
         
   end     // not reset
end

endmodule

