///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: MARKER_Simulator.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module MARKER_Simulator(
   input                RX_CLK,
   input                RX_RESETN,
   input                HCLK,
   input                HRESETN,
   input                start,
   input        [3:0]   MARKER_TYPE,   // 0: good (double) Clock Marker, 1: good (double) Event Marker, 2: good (single) Loopback, 3: good sequence Retransmission, 
                                       // 4: good (single) Diagnostic marker,  5: good (single) Timeout marker, 
                                       // 6: single DCSRequest (not a marker) 7: single legal undefined marker
                                       //// bit(3)=1  is to simulation something illegal
                                       // 8: bad (single) Clock Marker,  9: bad (single) Event Marker, 10: bad (double) Loopback, 11: bad sequence Retransmission,
                                       // 12: bad off-by-1bit (double) Clock Marker,13: bad repeated(double) Event Marker, 
                                       // 14: bad missing sequence Retransmission, 15: bad illegal command words 
    input        [3:0]   SEQ_NUM,       // packet sequence to be retransmitted    

   output reg   [15:0]  DATA_TO_TX,
   output reg   [1:0]   KCHAR_TO_TX
);

//*******************************************************************
//********************* Signal Declaration     **********************
//*******************************************************************
parameter [3:0] STATE_0 = 4'b0000;
parameter [3:0] STATE_1 = 4'b0001;
parameter [3:0] STATE_2 = 4'b0010;
parameter [3:0] STATE_3 = 4'b0011;
parameter [3:0] STATE_4 = 4'b0100;
parameter [3:0] STATE_5 = 4'b0101;
parameter [3:0] STATE_6 = 4'b0110;
parameter [3:0] STATE_7 = 4'b0111;
parameter [3:0] STATE_8 = 4'b1000;
parameter [3:0] STATE_9 = 4'b1001;
parameter [3:0] STATE_10 = 4'b1010;
parameter [3:0] STATE_11 = 4'b1011;
parameter [3:0] STATE_12 = 4'b1100;
parameter [3:0] STATE_13 = 4'b1101;
parameter [3:0] STATE_14 = 4'b1110;
parameter [3:0] STATE_15 = 4'b1111;

parameter 	[15:0]      Comma				   = 16'hBC3C;	//k28.5 k28.1
parameter	[15:0]		EventStartK 		= 16'h1C10;	//K28.0 D16.0
parameter	[15:0]		EventStartKn		= 16'h1CEF;	//K28.0 D15.7
parameter	[15:0]		Clock40MHzMarkerK	= 16'h1C11;	//K28.0 D11.0
parameter	[15:0]		Clock40MHzMarkerKn= 16'h1CEE;	//K28.0 D14.7
parameter	[15:0]		DelayMeasureK		= 16'h1C12;	//K28.0 D18.0
parameter	[15:0]		DelayMeasureKn		= 16'h1CED;	//unused     K28.0 D13.7  
parameter	[15:0]		DiagnosticK			= 16'h1C13;	//K28.0 D18.0
parameter	[15:0]		DCSTimeoutK			= 16'h1C14;	//K28.0 D20.0
parameter	[15:0]		RetransK			   = 16'h1C15;	//K28.0 D21.0
parameter	[15:0]		RetransKn			= 16'h1CEA;	//K28.0 D10.7
parameter	[15:0]		DCSRequestK			= 16'h1C00;	//legal but not a marker   K28.0 D00.0
parameter	[15:0]		UnusedK			   = 16'h1C20;	//legal command but not a defined   
parameter	[15:0]		IllegalK			   = 16'h1234;	//illegal command   

parameter  [1:0] KChar = 2'b11;
parameter  [1:0] KCmd  = 2'b10;
parameter  [1:0] KWord = 2'b00;
//---------------------------------------------

reg         start_latch;
reg [3:0]   s_count;       // number of SM states
reg [7:0]   comma_count;

//<statements>
always@(posedge HCLK, negedge HRESETN)
begin
  if (HRESETN == 1'b0) start_latch <= 1'b0;
  else                  start_latch <= start;
end

//marker builder
always @ (posedge RX_CLK or negedge RX_RESETN) 
begin
   if (RX_RESETN == 1'b0)
   begin
      DATA_TO_TX      <= Comma;
      KCHAR_TO_TX     <= KChar;
      comma_count   <= 8'b0;
   end
   
   else
   
   begin
   case (s_count)

   STATE_0:
   begin
      DATA_TO_TX    <= Comma;
      KCHAR_TO_TX   <= KChar;
      comma_count   <= 8'b0;
      if(start_latch) s_count <= STATE_1;
   end
   
    //always start with 6 comma words
   STATE_1:
   begin
      DATA_TO_TX    <= Comma;
      KCHAR_TO_TX   <= KChar;
      comma_count   <= comma_count+1;
      if (comma_count > 5)	s_count <= STATE_2;
  end

   // deal with packet type 10 and above (0/1/2 are reserved for DTC packets)
   STATE_2:
   begin
      comma_count   <= 8'b0;
      case (MARKER_TYPE)
         4'd0: begin
            DATA_TO_TX  <= Clock40MHzMarkerK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_3;
         end 
         4'd1: begin
            DATA_TO_TX  <= EventStartK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_4;
         end 
         4'd2: begin
            DATA_TO_TX  <= DelayMeasureK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         4'd3: begin
            DATA_TO_TX  <= RetransK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_5;
         end 
         4'd4: begin
            DATA_TO_TX  <= DiagnosticK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         4'd5: begin
            DATA_TO_TX  <= DCSTimeoutK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         4'd6: begin
            DATA_TO_TX  <= DCSRequestK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         4'd7: begin
            DATA_TO_TX  <= UnusedK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         4'd8: begin
            DATA_TO_TX  <= Clock40MHzMarkerK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         4'd9: begin
            DATA_TO_TX  <= EventStartKn;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         4'd10: begin
            DATA_TO_TX  <= DelayMeasureK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_7;
         end 
         4'd11: begin
            DATA_TO_TX  <= RetransK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_8;
         end 
         4'd12: begin
            DATA_TO_TX  <= Clock40MHzMarkerK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_4;
         end 
         4'd13: begin
            DATA_TO_TX  <= EventStartK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_10;
         end 
         4'd14: begin
            DATA_TO_TX  <= RetransK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_11;
         end 
         4'd15: begin
            DATA_TO_TX  <= IllegalK;
            KCHAR_TO_TX <= KCmd;
            s_count     <= STATE_0;
         end 
         default: begin
            DATA_TO_TX  <= Comma;
            KCHAR_TO_TX <= KChar;
            s_count     <= STATE_0;
         end 
      endcase
   end

   STATE_3:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= Clock40MHzMarkerKn;
      KCHAR_TO_TX   <= KCmd;
      s_count       <= STATE_0;
   end
      
   STATE_4:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= EventStartKn;
      KCHAR_TO_TX   <= KCmd;
      s_count       <= STATE_0;
   end

   STATE_5:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= RetransKn;
      KCHAR_TO_TX   <= KCmd;
      s_count       <= STATE_6;
   end

   STATE_6:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= {SEQ_NUM, SEQ_NUM, SEQ_NUM, SEQ_NUM};
      KCHAR_TO_TX   <= KWord;
      s_count       <= STATE_0;
   end

   STATE_7:  // this still works because first part is OK....
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= DelayMeasureKn;
      KCHAR_TO_TX   <= KCmd;
      s_count       <= STATE_0;
   end

   STATE_8:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= RetransKn;
      KCHAR_TO_TX   <= KCmd;
      s_count       <= STATE_9;
   end

   STATE_9:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= {SEQ_NUM, 4'b0, SEQ_NUM, SEQ_NUM};
      KCHAR_TO_TX   <= KWord;
      s_count       <= STATE_0;
   end

   STATE_10:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= EventStartK;
      KCHAR_TO_TX   <= KCmd;
      s_count       <= STATE_0;
   end
   
   STATE_11:
   begin
      comma_count   <= 8'b0;
      DATA_TO_TX    <= RetransKn;
      KCHAR_TO_TX   <= KCmd;
      s_count       <= STATE_0;
   end

   default:
   begin
      DATA_TO_TX    <= Comma;
      KCHAR_TO_TX   <= KChar;
      comma_count   <= 8'b0;
      s_count       <= STATE_0;
   end
   
   endcase
   end
end

endmodule

