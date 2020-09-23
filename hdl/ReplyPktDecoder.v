///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: ReplyPktDecoder.v
// File history:
//      v1: Aug. 15, 2020: first version, DCSReply packet decoding
//      v1: Aug. 25, 2020: first version, add Data Header decoding
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//  This module decodes DCSReply and Data Header packets from PacketSender
//    and saves ADDR+DATA for the first and NO.PKT+WINDOW_TAG[15:0] for the second kind of packkets.
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: Monica Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module ReplyPktDecoder(
    TX_CLK       ,
    TX_RESETN   ,		
    data_in    ,
    kchar_in,
    TX_DATA_OUT
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

parameter  g_DATA_WID = 16;
parameter  g_KCHAR_WID = 2;

parameter 	[15:0]      Comma				   = 16'hBC3C;	//k28.5 k28.1

parameter   [7:0]    K28zero        = 8'h1C;  // K28.0

parameter	[3:0]		DCSRequest		   = 4'h0;	//D00.0
parameter	[3:0]		Heartbeat			= 4'h1;	//D01.0
parameter	[3:0]		DataRequestK		= 4'h2;	//D02.0
parameter	[3:0]		DCSReplyK			= 4'h4;	//D04.0
parameter	[3:0]		DataHeaderK			= 4'h5;	//D05.0
parameter	[3:0]		DataK				   = 4'h6;	//D06.0
parameter 	[3:0]		DCSBlockRequestK	= 4'h7;	//D07.0
parameter 	[3:0]		DCSBlockReplyK		= 4'h8;	//D08.0

parameter  [1:0] KChar = 2'b11;
parameter  [1:0] KCmd  = 2'b10;
parameter  [1:0] KWord = 2'b00;

input       TX_CLK;                      //input clock
input       TX_RESETN;                  //reset for logic
input [g_DATA_WID-1:0]    data_in;
input [g_KCHAR_WID-1:0]   kchar_in;    

output reg [31:0]    TX_DATA_OUT;     // data in last Reply packet

reg [g_DATA_WID-1:0]    int_data;     
reg [g_KCHAR_WID-1:0]   int_kchar;

reg [3:0]   s_count;       // number of SM states
reg [7:0]   word_count;

// swap data byte and kchar bits since TX from PacketSender has bytes swapped
always@(posedge TX_CLK,negedge TX_RESETN)
begin
   if (TX_RESETN == 1'b0)
   begin
      int_data <= Comma;
      int_kchar<= KChar;
   end
   else
   begin
      int_data[7:0]  <= data_in[15:8]; 
      int_data[15:8] <= data_in[7:0];
      int_kchar[0]   <= kchar_in[1];
      int_kchar[1]   <= kchar_in[0];
   end
end


// extract 1st data from DCS Reply packet
always@(posedge TX_CLK,negedge TX_RESETN)
begin
   if (TX_RESETN == 1'b0)
   begin
      word_count  <= 0;
      s_count     <= 0;
      TX_DATA_OUT <= 32'h0;
   end
   
   else
   begin
  
      // wait for the first non-comma word
      case (s_count)
      STATE_0:
      begin 
         word_count  <= 0;
         if (int_kchar == KCmd  && int_data != Comma) 
         begin
         // branch-off between DCSReply and Data Header packet
            if (int_data[15:8]==K28zero) 
            begin
               if       (int_data[3:0]==DCSReplyK)    s_count <= STATE_1;
               else if  (int_data[3:0]==DataHeaderK)  s_count <= STATE_6;
            end
         end
      end
      
      ////////////////////////////////////////////
      //  start decoding DCS Reply packet
      ////////////////////////////////////////////
      // check for valid word and Reply packet_type   
      STATE_1:
      begin
         if (int_kchar != KWord) s_count <= STATE_0;
         else                    word_count <= word_count + 1;  

         if (int_data[15]==1 && int_data[7:4]==DCSReplyK) s_count <= STATE_2;
      end   
      
      // check for single read packet
      STATE_2:
      begin
         if (int_kchar != KWord) s_count <= STATE_0;
         else                    word_count <= word_count + 1;  

          if (int_data[15:6]==0 && int_data[3:0]==0) s_count <= STATE_3;
      end

      // save address in MSB bits
      STATE_3:
      begin
         if (int_kchar != KWord) s_count <= STATE_0;
         else                    word_count <= word_count + 1;  

         if (word_count==3) 
         begin
            TX_DATA_OUT[31:16] <= int_data;
            s_count <= STATE_4;
         end
      end

      // save data content in LBS bits
      STATE_4:
      begin
         if (int_kchar != KWord) s_count <= STATE_0;
         else                    word_count <= word_count + 1;  

         if (word_count==4) 
         begin
            TX_DATA_OUT[15:0] <= int_data;
            s_count <= STATE_5;
         end
      end
      
      // skip to the end of packet 
      STATE_5:
      begin
         if (int_kchar == KChar) s_count <= STATE_0;
      end
      
      ////////////////////////////////////////////
      //  start decoding Data Header packet
      ////////////////////////////////////////////
      // check for valid word and Reply packet_type   
      STATE_6:
      begin
         if (int_kchar != KWord) s_count <= STATE_0;
         else                    word_count <= word_count + 1;  

         if (int_data[15]==1 && int_data[7:4]==DataHeaderK) s_count <= STATE_7;
      end   

      // save packet count in MSB bits
      STATE_7:
      begin
         if (int_kchar != KWord) s_count <= STATE_0;
         else                    word_count <= word_count + 1;  

         TX_DATA_OUT[31:16] <= int_data[15:0];
         s_count <= STATE_8;
      end

      // save event window tag in LBS bits
      STATE_8:
      begin
         if (int_kchar != KWord) s_count <= STATE_0;
         else                    word_count <= word_count + 1;  

         TX_DATA_OUT[15:0] <= int_data[15:0];
         s_count <= STATE_5;
      end

      default:
      begin
         TX_DATA_OUT <= 32'hFEFEFEFE;
         word_count  <= 0;
         s_count     <= STATE_0;
      end
      
      endcase
   end
end
      
endmodule

