///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: DTC_simulator.v
// File history:
//      v0:  Aug. 21, 2020: first version
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//    DTC Packet simulator as per DocDb 4914.
//    It can simulate only Requests, either DCS/DCSBlock or Hearbeat/DataRequest,
//    plus the sequence of packets needed for a RD/WR Module Request.
//    Generated packet is buffered in PACKET_FIFO and sent on XCVR RX_CLK when ready.
//    No double RD/WR operations supported. 
//    Block operations, either FIFO or RAM, require writing data to external BLK_TPSRAM first. 
//
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module DTC_simulator( 
   input                RX_CLK,
   input                RX_RESETN,
   input                HCLK,
   input                HRESETN,
   input                ALIGN,
   input                start,
   input        [3:0]   PACKET_TYPE,   // 0: DCSReq, 1: Heartbeat, 2: DATAReq, 7:DCSBlockReq 
   input        [5:0]   OP_CODE,       // 0) Single RD   1) Single WR   2) Block (FIFO) RD     3) Block (FIFO) WR     
                                       // 4) Block (RAM) RD      5) Block (RAM) WR      6) Module RD   7) Module WR   
                                       // 6) Module RD   7) Module WR   4) Block (RAM) RD (0x12)     5) Block (RAM) WR (0x13) 
                                       //  NB: This is not the OP_CODE specified in Docdb 4914, but it will be translated to that inside logic below
                                       //      It includes the reserved bit[5].
   input        [15:0]  BLOCK_CNT,
   input        [7:0]   MODULE_ID,      //  7: Forward Detector, 9: Command Handler 10: Packet Sender 12: XCVR
   input        [15:0]  ADDR,           //  operation address
   input        [15:0]  WDATA,          //  operation data (ignore if RD)
   input        [47:0]  EVENT_WINDOW_TAG,   
   input        [31:0]  EVENT_MODE,
   input                ON_SPILL,       // 0 if off-spill
   input        [7:0]   RF_MARKER,      // prediction for Delivery Ring Marker offset wrt to Event Window start (in unit of 1.25 ns). Zero for off=spill.
   output reg   [15:0]  DATA_TO_TX,
   output reg   [1:0]   KCHAR_TO_TX,
   // FIFO I/Os
   input        [17:0]  FROM_FIFO_OUT,
   input                FROM_FIFO_EMPTY,
   input                FROM_FIFO_FULL,
   input                FROM_FIFO_AE,
   input        [7:0]   FROM_FIFO_WRCNT,
   input        [7:0]   FROM_FIFO_RDCNT,
   output reg           TO_FIFO_WE,
   output reg   [17:0]  TO_FIFO_IN,
   output reg           TO_FIFO_RE,
    // external RAM I/Os
   input       [15:0]   RAM_DATA,
   output reg           RAM_RE,
   output reg  [6:0]    RAM_ADDR
);

//*******************************************************************
//********************* Signal Declaration     **********************
//*******************************************************************
parameter [5:0] STATE_0 = 6'b00_0000;
parameter [5:0] STATE_1 = 6'b00_0001;
parameter [5:0] STATE_2 = 6'b00_0010;
parameter [5:0] STATE_3 = 6'b00_0011;
parameter [5:0] STATE_4 = 6'b00_0100;
parameter [5:0] STATE_5 = 6'b00_0101;
parameter [5:0] STATE_6 = 6'b00_0110;
parameter [5:0] STATE_7 = 6'b00_0111;
parameter [5:0] STATE_8 = 6'b00_1000;
parameter [5:0] STATE_9 = 6'b00_1001;
parameter [5:0] STATE_10 = 6'b00_1010;
parameter [5:0] STATE_11 = 6'b00_1011;
parameter [5:0] STATE_12 = 6'b00_1100;
parameter [5:0] STATE_13 = 6'b00_1101;
parameter [5:0] STATE_14 = 6'b00_1110;
parameter [5:0] STATE_15 = 6'b00_1111;
parameter [5:0] STATE_16 = 6'b01_0000;
parameter [5:0] STATE_17 = 6'b01_0001;
parameter [5:0] STATE_18 = 6'b01_0010;
parameter [5:0] STATE_19 = 6'b01_0011;
parameter [5:0] STATE_20 = 6'b01_0100;
parameter [5:0] STATE_21 = 6'b01_0101;
parameter [5:0] STATE_22 = 6'b01_0110;
parameter [5:0] STATE_23 = 6'b01_0111;
parameter [5:0] STATE_24 = 6'b01_1000;
parameter [5:0] STATE_25 = 6'b01_1001;
parameter [5:0] STATE_26 = 6'b01_1010;
parameter [5:0] STATE_27 = 6'b01_1011;
parameter [5:0] STATE_28 = 6'b01_1100;
parameter [5:0] STATE_29 = 6'b01_1101;
parameter [5:0] STATE_30 = 6'b01_1110;
parameter [5:0] STATE_31 = 6'b01_1111;
parameter [5:0] STATE_32 = 6'b10_0000;
parameter [5:0] STATE_33 = 6'b10_0001;
parameter [5:0] STATE_34 = 6'b10_0010;
parameter [5:0] STATE_35 = 6'b10_0011;
parameter [5:0] STATE_36 = 6'b10_0100;
parameter [5:0] STATE_37 = 6'b10_0101;
parameter [5:0] STATE_38 = 6'b10_0110;
parameter [5:0] STATE_39 = 6'b10_0111;
parameter [5:0] STATE_40 = 6'b10_1000;
parameter [5:0] STATE_41 = 6'b10_1001;
parameter [5:0] STATE_42 = 6'b10_1010;
parameter [5:0] STATE_43 = 6'b10_1011;
parameter [5:0] STATE_44 = 6'b10_1100;
parameter [5:0] STATE_45 = 6'b10_1101;
parameter [5:0] STATE_46 = 6'b10_1110;
parameter [5:0] STATE_47 = 6'b10_1111;
parameter [5:0] STATE_48 = 6'b11_0000;
parameter [5:0] STATE_49 = 6'b11_0001;
parameter [5:0] STATE_50 = 6'b11_0010;
parameter [5:0] STATE_51 = 6'b11_0011;
parameter [5:0] STATE_52 = 6'b11_0100;
parameter [5:0] STATE_53 = 6'b11_0101;
parameter [5:0] STATE_54 = 6'b11_0110;
parameter [5:0] STATE_55 = 6'b11_0111;
parameter [5:0] STATE_56 = 6'b11_1000;
parameter [5:0] STATE_57 = 6'b11_1001;
parameter [5:0] STATE_58 = 6'b11_1010;
parameter [5:0] STATE_59 = 6'b11_1011;
parameter [5:0] STATE_60 = 6'b11_1100;
parameter [5:0] STATE_61 = 6'b11_1101;
parameter [5:0] STATE_62 = 6'b11_1110;
parameter [5:0] STATE_63 = 6'b11_1111;


parameter [1:0] IDLE = 2'b00;
parameter [1:0] READ = 2'b01;

parameter 	[15:0]      Comma				   = 16'hBC3C;	//k28.5 k28.1
parameter	[15:0]		DCSRequestK			= 16'h1C00;	//K28.0 D00.0
parameter	[15:0]		HeartbeatK			= 16'h1C01;	//K28.0 D01.0
parameter	[15:0]		DataRequestK		= 16'h1C02;	//K28.0 D02.0
parameter	[15:0]		DCSReplyK			= 16'h1C04;	//K28.0 D04.0
parameter	[15:0]		DataHeaderK			= 16'h1C05;	//K28.0 D05.0
parameter	[15:0]		DataK				   = 16'h1C06;	//K28.0 D06.0
parameter 	[15:0]		DCSBlockRequestK	= 16'h1C07;	//K28.0 D07.0
parameter 	[15:0]		DCSBlockReplyK		= 16'h1C08;	//K28.0 D08.0
parameter	[15:0]		DMAByteCount		= 16'h0010;	// constant - ignored

parameter  [1:0] KChar = 2'b11;
parameter  [1:0] KCmd  = 2'b10;
parameter  [1:0] KWord = 2'b00;

reg         fifo_we;
reg [17:0]  fifo_in;

reg [1:0]   f_count;
reg [7:0]   fifo_rd_cnt;
reg         fifo_ae;

reg [5:0]   s_count;       // number of SM states
reg [7:0]   word_count, comma_count;
reg [2:0]   ring_count;
reg         first_packet;
reg [9:0]   packet_count; // this is the additional packet count
reg [15:0]  encoded_addr;
reg [15:0]  encoded_data;
reg [5:0]   encoded_opcode; // bit[5] is reserved and should always be 0

reg			CRC_EN, CRC_RST;
reg			CRC_READY;
wire [15:0] CRC;

//reg  [6:0]  RAM_ADDR;
//wire [7:0]  RAM_DATA;

reg         start_latch;

//<statements>
always@(posedge HCLK,negedge HRESETN)
begin
  if (HRESETN == 1'b0) start_latch <= 1'b0;
  else                  start_latch <= start;
end

//packet builder
always @ (posedge HCLK or negedge HRESETN) 
begin
   if (HRESETN == 1'b0)
   begin
      fifo_in        <= {KChar, Comma};   //comma by default
      fifo_we        <= 1'b0;
      first_packet   <= 1'b1;
      packet_count   <= 10'b0;
      encoded_addr   <= 16'b0;
      encoded_data   <= 16'b0;
      encoded_opcode <= 6'b0;
      word_count     <= 8'b0;
      comma_count    <= 8'b0;
      ring_count     <= 3'b0;
      CRC_EN		   <= 1'b0;
      CRC_RST		   <= 1'b1;
      CRC_READY	   <= 1'b0;
      s_count        <= 6'b0;
      RAM_RE         <= 1'b0;
      RAM_ADDR       <= 7'b0;
   end
   
   else
   
   begin
   case (s_count)

   STATE_0:
   begin
      fifo_in  	   <= {KChar, Comma};   //comma until start command
      fifo_we        <= 0;
      first_packet   <= 1'b1;
      packet_count   <= 10'b0;
      encoded_addr   <= 16'b0;
      encoded_data   <= 16'b0;
      encoded_opcode <= 6'b0;
      word_count     <= 8'b0;
      comma_count    <= 8'b0;
      CRC_EN		   <= 1'b0;
      CRC_RST		   <= 1'b1;
      CRC_READY	   <= 1'b0;
      RAM_RE         <= 1'b0;
      RAM_ADDR       <= 7'b0;
      if(start_latch) s_count <= STATE_1;
   end
   
   //always start with 6 comma words
   STATE_1:
   begin
      fifo_in     <= {KChar, Comma};   //comma for 6 words
      fifo_we     <= 1'b1;
      CRC_EN      <= 1'b0;
      CRC_RST		<= 1'b1;
      CRC_READY   <= 1'b0;
      comma_count <= comma_count+1;
      RAM_ADDR    <= 7'b0;
      RAM_RE      <= 1'b0;
      if (comma_count > 5)	s_count <= STATE_2;
   end

   // start with packet header depending on packet type
   STATE_2:
   begin
      case (PACKET_TYPE)
         4'd0: fifo_in <= {KCmd, DCSRequestK};
         4'd1: fifo_in <= {KCmd, HeartbeatK};
         4'd2: fifo_in <= {KCmd, DataRequestK};
         4'd4: fifo_in <= {KCmd, DCSReplyK};
         4'd5: fifo_in <= {KCmd, DataHeaderK};
         4'd6: fifo_in <= {KCmd, DataK};
         4'd7: fifo_in <= {KCmd, DCSBlockRequestK};
         4'd8: fifo_in <= {KCmd, DCSBlockReplyK};
         default: fifo_in  <= {KChar, Comma};
      endcase
      
      fifo_in[7:5]   <= ring_count; // add ring packet count
      ring_count     <= ring_count + 1;
      fifo_we        <= 1'b1;
      CRC_RST		   <= 1'b0;
      comma_count    <= 8'b0;
      // branch-off DCS Requests (0) vs Heartbeat(1)/Data Requests(2)
      // NB: DCSBlkRequest starts as a DCS Request....
      if      (PACKET_TYPE==0)                      s_count <= STATE_3;
      else if (PACKET_TYPE==1 || PACKET_TYPE==2)    s_count <= STATE_29;
   end
   
   // add DMA count (always 16'h0010) and start CRC calculation
   STATE_3:
   begin
      fifo_in  	<= {KWord, DMAByteCount};   
      fifo_we     <= 1'b1;
      CRC_EN      <= 1'b1;
      word_count  <= word_count + 1;
      // branch-off for block (2-5) and module (6-7) operations
      if (OP_CODE==2 || OP_CODE==3 || OP_CODE==4 || OP_CODE==5)  s_count <= STATE_18;
      else if (OP_CODE==6 || OP_CODE==7)    s_count <= STATE_10;
      else                                  s_count <= STATE_4; // default is single RD/WR requests
   end

   ////////////////////////////////////////////////////////////
   ////    build single WR/RD packet   ////
   // add Valid word[15] and packet type[7:4] (Reserved[14:11], ROC Link[10:8] and Hop Count[3:0] always zero!)
   STATE_4:
   begin
      fifo_in     <= {KWord, 8'h80, PACKET_TYPE, 4'h0};   
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      encoded_opcode <= OP_CODE;
      s_count     <= STATE_5;
   end   

   // add Additional Packet Count [15:6], Reserved[5] and OP_CODE[4:0]
   STATE_5:
   begin
      fifo_in     <= {KWord, packet_count, encoded_opcode};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      encoded_addr<= ADDR;
      s_count     <= STATE_6;
   end

   // add first operation address
   STATE_6:
   begin
      fifo_in     <= {KWord, encoded_addr};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      encoded_data<= WDATA;
      s_count     <= STATE_7;
   end

   // add first operation data
   STATE_7:
   begin
      fifo_in     <= {KWord, encoded_data};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_8;
   end   

   // finish packet
   STATE_8:
   begin
      fifo_in     <= {KWord, 16'b0};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      if (word_count==7) s_count <= STATE_9;
   end
   
   // add CRC 
   STATE_9:
   begin
      fifo_in     <= {KWord, CRC};   
      fifo_we     <= 1'b1;
      CRC_READY   <= 1'b1;
      CRC_EN		<= 1'b0;
      comma_count <= 8'b0;
      s_count     <= STATE_0;
   end

   ////////////////////////////////////////////////////////////   
   /////  build module WR/RD packet   ////
   // add Valid word[15] and packet type[7:4] (Reserved[14:11], ROC Link[10:8] and Hop Count[3:0] always zero!)
   // Make decision on packet_count and ENCODED_OPCODE
   STATE_10:
   begin
      fifo_in     <= {KWord, 8'h80, PACKET_TYPE, 4'h0};   
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_11;
      
      // determine how many additional packet to be expected 
      if (first_packet)
      begin
         encoded_opcode <= 5;  // all start with a double write
         if (OP_CODE == 6) packet_count <= 2; // module read requires two packet next
         else              packet_count <= 1; // module write requires one packet next
      end
      else 
      // we have already determined we need an extra packet: 
      //  - module read needs a single-read followed by a single write
      //  - module write needs only a second single-write
      begin
         if (OP_CODE == 6)                              
         begin
            if      (packet_count == 1) encoded_opcode <= 0; 
            else if (packet_count == 0) encoded_opcode <= 1;
         end
         else                           encoded_opcode <= 1;   
      end
   end

   // add Additional Packet Count [15:6], Reserved[5] and OP_CODE[4:0]
   //    NB: these are still single packets: "packet_count" is used only for internal module request packet building purposes
   // Made decision on ENCODED_ADDRESS
   STATE_11:
   begin
      fifo_in     <= {KWord, 10'h0, encoded_opcode};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_12;
      
      // module read/write need a first write to DracMonitor 0x2
      if (first_packet)
      begin
         encoded_addr <= 16'h0002;
      end
      else 
      // we have already determined we need an extra packet:
      //  - module read needs a single read to DRACMonitor address 0x1, followed by a single-write to DRACMonitor adress 0x3 to disable WR_EN
      //  - module write needs single-write to DRACMonitor address 0x3 to disable WR_EN
      begin
         if (OP_CODE == 6 && packet_count == 1) encoded_addr <= 16'h0001;
         else                                   encoded_addr <= 16'h0003;
      end
   end

   // add first operation address
   // Make decision on ENCODED_DATA
   STATE_12:
   begin
      fifo_in     <= {KWord, encoded_addr};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_13;
      
      if (first_packet)
      begin
         if      (OP_CODE == 6)  encoded_data <= { 8'h00, MODULE_ID};
         else if (OP_CODE == 7)  encoded_data <= { ADDR[6:0], MODULE_ID};
      end
      else 
      // we have already determined we need an extra packet 
      //  - module read needs to pass nothing to second packet and clear WR_EN on last write
      //  - module write needs to clear WR_EN on last write
      begin
         if      (OP_CODE == 6 && packet_count == 1) encoded_data <= 16'h0000;
         else if (OP_CODE == 6 && packet_count == 0) encoded_data <= {1'b0, ADDR[14:0]};
         else if (OP_CODE == 7)                      encoded_data <= {1'b0, WDATA[14:0]};
      end
   end

   // add first operation data
   // Made decision on next ENCODED_ADDRESS
   STATE_13:
   begin
      fifo_in     <= {KWord, encoded_data};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_14;
      
      if (first_packet) encoded_addr <= 16'h0003;
      else              encoded_addr <= 16'h0000;   // any extra packets are single operations
   end

   // add second operation address if needed
   // Make decision on ENCODED_DATA
   STATE_14:
   begin
      fifo_in     <= {KWord, encoded_addr};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_15;
      
      if (first_packet)  // need to enable WR_EN for both
      begin
         if     (OP_CODE == 6)  encoded_data <= { 1'b1,  ADDR[14:0]};    // pass address we want to read
         else                   encoded_data <= { 1'b1,  WDATA[14:0]};   // pass data we want to write
      end
      else                      encoded_data <= 16'h0000;               // any extra packets are single operations
   end

   // add second operation data if needed
   STATE_15:
   begin
      fifo_in     <= {KWord, encoded_data};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_16;
   end

   // add last 16-bit words in the packet
   STATE_16:
   begin
      fifo_in     <= {KWord, 16'h0000};   
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_17;
   end

   // add CRC and decide if another packet is needed 
   STATE_17:
   begin
      fifo_in     <= {KWord, CRC};   
      fifo_we     <= 1'b1;
      CRC_READY	<= 1'b1;
      CRC_EN		<= 1'b0;
      first_packet<= 1'b0;
      comma_count  <= 8'b0;
      if  (packet_count > 0)   packet_count  <= packet_count - 1;
      if  (packet_count == 0)  s_count <= STATE_0;
      else                     s_count <= STATE_1;
   end

   ////////////////////////////////////////////////////////////
   ////    build block WR/RD packet   ////
   // add Valid word[15] and packet type[7:4] (Reserved[14:11], ROC Link[10:8] and Hop Count[3:0] always zero!)
   // Make decision on packet_count and ENCODED_OPCODE
   STATE_18:
   begin
      fifo_in     <= {KWord, 8'h80, PACKET_TYPE, 4'h0};   
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_19;
      
      // determine how many additional packet to be expected (for block and module operations)
      if (OP_CODE==3 || OP_CODE==5 ) packet_count <= (BLOCK_CNT - 3)/8;   // block write might require extra packets
         
      if (OP_CODE == 4)         encoded_opcode <= 6'h12;        // RAM block need bit(4)=1
      else if (OP_CODE == 5)    encoded_opcode <= 6'h13;        // RAM block need bit(4)=1
      else                      encoded_opcode <= OP_CODE;
   end

   // add Additional Packet Count [15:6], Reserved[5] and OP_CODE[4:0]
   STATE_19:
   begin
      fifo_in     <= {KWord, packet_count, encoded_opcode};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_20;
   end
   
   // add block operation starting address
   //  for RAM block operation, address is incremented by 1 starting from this
   STATE_20:
   begin
      fifo_in     <= {KWord, ADDR};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_21;
   end
   
   // add block operation block word count
   STATE_21:
   begin
      fifo_in     <= {KWord, BLOCK_CNT};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      RAM_ADDR    <= RAM_ADDR+1;
      RAM_RE      <= 1'b1;
      s_count     <= STATE_22;
   end
   
   // add block write first data (does not apply to block read)
   // NB: simulation assumes data to be passed in the block are written to an EXTERNAL RAM first
   STATE_22:
   begin
      if (OP_CODE == 3 || OP_CODE==5)   fifo_in <= {KWord, RAM_DATA};
      else                              fifo_in <= {KWord, 16'b0};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      RAM_ADDR    <= RAM_ADDR+1;
      RAM_RE      <= 1'b1;
      s_count     <= STATE_23;
   end
   
   // add block write second data (NA for block read)
   STATE_23:
   begin
      if (OP_CODE == 3 || OP_CODE==5)   fifo_in <= {KWord, RAM_DATA};
      else                              fifo_in <= {KWord, 16'b0};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      RAM_ADDR    <= RAM_ADDR+1;
      RAM_RE      <= 1'b1;
      s_count     <= STATE_24;
   end
   
   // add block write third data (NA for block read)
   STATE_24:
   begin
      if (OP_CODE == 3 || OP_CODE==5)   fifo_in <= {KWord, RAM_DATA};
      else                              fifo_in <= {KWord, 16'b0};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      RAM_RE      <= 1'b0;
      s_count     <= STATE_25;
   end

   // add CRC and decide if another packet is needed 
   STATE_25:
   begin
      fifo_in     <= {KWord, CRC};   
      fifo_we     <= 1'b1;
      CRC_READY   <= 1'b1;
      CRC_EN		<= 1'b0;
      first_packet<= 1'b0;
      if (packet_count > 0) packet_count  <= packet_count - 1;
      comma_count <= 8'b0;
      RAM_RE      <= 1'b0;
      if (packet_count == 0) s_count <= STATE_0;
      else                   s_count <= STATE_26;
   end
   
   //add 6 comma words
   STATE_26:
   begin
      fifo_in     <= {KChar, Comma};   //comma for 6 words
      fifo_we     <= 1'b1;
      CRC_EN      <= 1'b0;
      CRC_RST     <= 1'b1;
      CRC_READY   <= 1'b0;
      comma_count <= comma_count+1;
      if (comma_count > 5)	s_count <= STATE_27;
   end

   // start with additional Block DCSRequest packet header
   STATE_27:
   begin
      //fifo_in        <= {KCmd, DCSRequestK};
      fifo_in        <= {KCmd, DCSBlockRequestK};
      fifo_in[7:5]   <= ring_count; // add ring packet count
      ring_count     <= ring_count + 1;
      fifo_we        <= 1'b1;
      CRC_RST		   <= 1'b0;
      comma_count    <= 8'b0;
      RAM_ADDR       <= RAM_ADDR+1;
      RAM_RE         <= 1'b1;
      s_count        <= STATE_28;
   end
   
   // fill packet with just remaining data words in block (should get here only for block write with BLOCK_CNT>3!!)
   // send back to CRC calculation, where check on extra packets is done
   STATE_28:
   begin
      fifo_in     <= {KWord, RAM_DATA};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      if( (word_count%8) < 7) 
      begin
         RAM_ADDR    <= RAM_ADDR+1; // stop increasing RAM_ADDR at the last word in the block
         RAM_RE      <= 1'b1;
      end
      if( (word_count%8) == 7)  s_count <= STATE_25;
   end

   ////////////////////////////////////////////////////////////
   ////    build block hearbeat and Data Request packets   ////
   // add DMA count (always 16'h0010) and start CRC calculation
   STATE_29:
   begin
      fifo_in     <= {KWord, DMAByteCount};   
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_30;
   end

   // add Valid word[15] and packet type[7:4] (Reserved[14:11], ROC Link[10:8] and Hop Count[3:0] always zero!)
   STATE_30:
   begin
      fifo_in     <= {KWord, 8'h80, PACKET_TYPE, 4'h0};   
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_31;
   end   

   // add Event Window Tag over next three 16-bit words
   STATE_31:
   begin
      fifo_in     <= {KWord, EVENT_WINDOW_TAG[15:0]};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_32;
   end

   STATE_32:
   begin
      fifo_in     <= {KWord, EVENT_WINDOW_TAG[31:16]};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_33;
   end

   STATE_33:
   begin
      fifo_in     <= {KWord, EVENT_WINDOW_TAG[47:32]};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      // branch-off for Heartbeat vs Data Request
      if (PACKET_TYPE==1)       s_count <= STATE_34;
      else if (PACKET_TYPE==2)  s_count <= STATE_38;
   end

   //// finish Heartbeat packet ////
   // add Event Mode over next two 16-bit words
   STATE_34:
   begin
      fifo_in     <= {KWord, EVENT_MODE[15:0]};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_35;
   end

   STATE_35:
   begin
      fifo_in     <= {KWord, EVENT_MODE[31:16]};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_36;
   end

   // add Delivery Ring Marker offset and on/off spill bit
   STATE_36:
   begin
      fifo_in     <= {KWord, RF_MARKER, 7'b0, ON_SPILL};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_37;
   end

   // add CRC
   STATE_37:
   begin
      fifo_in     <= {KWord, CRC};   
      fifo_we     <= 1'b1;
      CRC_READY   <= 1'b1;
      CRC_EN		<= 1'b0;
      comma_count <= 8'b0;
      s_count     <= STATE_0;
   end

   //// finish Data Request packet with 3 reserved words ////
   STATE_38:
   begin
      fifo_in     <= {KWord, 16'b0};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_39;
   end

   STATE_39:
   begin
      fifo_in     <= {KWord, 16'b0};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_40;
   end

   STATE_40:
   begin
      fifo_in     <= {KWord, 16'b0};
      fifo_we     <= 1'b1;
      CRC_EN		<= 1'b1;
      word_count 	<= word_count + 1;
      s_count     <= STATE_37;   // go to CRC 
   end

   
   default:
   begin
      fifo_in  	   <= {KChar, Comma};   //comma until start command
      fifo_we        <= 0;
      word_count     <= 8'b0;
      comma_count    <= 8'b0;
      packet_count   <= 10'b0;
      first_packet   <= 1'b1;
      encoded_addr   <= 1'b0;
      encoded_data   <= 16'b0;
      encoded_opcode <= 6'b0;
      CRC_EN		   <= 1'b0;
      CRC_RST		   <= 1'b1;
      CRC_READY	   <= 1'b0;
      RAM_ADDR       <= 7'b0;
      RAM_RE         <= 1'b0;
      s_count        <= STATE_0;
   end
   
   endcase
   end
end

// overwrite fifo input with CRC
always@(posedge HCLK, negedge HRESETN)
begin
   if (HRESETN == 1'b0)
   begin
      TO_FIFO_WE <= 1'b0;
      TO_FIFO_IN <= {KChar, Comma};
   end
   else
   begin
      TO_FIFO_WE <= fifo_we;
      if (CRC_READY)   TO_FIFO_IN <= {KWord,CRC}; 
      else             TO_FIFO_IN <= fifo_in;
   end
end

//
// on RX_CLK domain
// read fifo when at least one packet is in by checking FIFO almost empty
always@(posedge RX_CLK, negedge ALIGN)
begin
   if (ALIGN == 1'b0) 
   begin
      TO_FIFO_RE    <= 1'b0;
      fifo_rd_cnt   <= 0;
      fifo_ae       <= 1'b1;
      f_count       <= IDLE;
   end
   
   else  
   
   begin 
      fifo_ae   <= FROM_FIFO_AE;
      
      case(f_count)
   
      IDLE: 
      begin
         TO_FIFO_RE <= 1'b0;
         fifo_rd_cnt<= 0;
         if (fifo_ae == 1'b0) f_count <= READ;
      end
   
      READ:
      begin
         TO_FIFO_RE     <= 1'b1;
         fifo_rd_cnt    <= fifo_rd_cnt + 1;
         if (fifo_rd_cnt == 16) f_count <= IDLE;
      end
   
      default:
      begin
         TO_FIFO_RE     <= 1'b0;
         fifo_rd_cnt    <= 0;
         f_count        <= IDLE;
      end
   
      endcase
   end
end

//
// on RX_CLK domain
// send data to XVCR. Keep comma word unless data are coming out of the FIFO
always@(posedge RX_CLK, negedge RX_RESETN, negedge ALIGN)
 begin
   if (RX_RESETN == 1'b0 || ALIGN == 1'b0)
   begin
      DATA_TO_TX  <= Comma;
      KCHAR_TO_TX <= KChar; 
   end
   else
   begin
      if(TO_FIFO_RE == 1'b1)
      begin
         DATA_TO_TX  <= FROM_FIFO_OUT[15:0]; 
         KCHAR_TO_TX <= FROM_FIFO_OUT[17:16]; 
      end
      else
      begin
         DATA_TO_TX  <= Comma;
         KCHAR_TO_TX <= KChar; 
      end
   end
end

// instantiate crc module
crc_ver crc_ver_inst(
  .data_in	(fifo_in),
  .crc_en  	(CRC_EN),
  .crc_out  (CRC),
  .rst		(CRC_RST),
  .clk 		(HCLK) );


//// instantiate example RAM, 8b x 128 deep  
//sync_ram input_ram ( 
   //.clock(HCLK),
   //.we(1'b0),  // we only need to read the RAM
   //.address(RAM_ADDR),
   //.datain(8'b0),
   //.dataout(RAM_DATA) 
//);

endmodule

