///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: mux_rxout.v
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

module mux_rxout( 
   input            RX_CLK,
   input            RX_RSTN,
   input            SIM_EN,
   input    [15:0]  SIM_DATA,
   input    [1:0]   SIM_K_CHAR,
   input    [1:0]   SIM_INVALID,
   input    [1:0]   SIM_CODE_ERR_N,
   input    [1:0]   SIM_B_CERR,
   input    [1:0]   SIM_RD_ERR,
   input            SIM_ALIGNED,
   input            SIM_RX_VALID,
   input    [15:0]  DTC_DATA,
   input    [1:0]   DTC_K_CHAR,
   input    [1:0]   DTC_INVALID,
   input    [1:0]   DTC_CODE_ERR_N,
   input    [1:0]   DTC_B_CERR,
   input    [1:0]   DTC_RD_ERR,
   input            DTC_ALIGNED,
   input            DTC_RX_VALID,
   output reg  [15:0]   RX_DATA,
   output reg  [1:0]    RX_K_CHAR,
   output reg  [1:0]    INVALID_K,
   output reg  [1:0]    CODE_ERR_N,
   output reg  [1:0]    B_CERR,
   output reg  [1:0]    RD_ERR,
   output reg           ALIGNED,
   output reg           RX_VALID
  );


//<statements>
   parameter [15:0]     Comma	= 16'hBC3C;	//k28.5 k28.1
   parameter  [1:0]     KChar   = 2'b11;

   always @ (posedge RX_CLK or negedge RX_RSTN)
   begin
      if (RX_RSTN == 1'b0)
      begin
         RX_DATA    <=  Comma;   
         RX_K_CHAR  <=  KChar;
         INVALID_K  <=  2'b00;
         CODE_ERR_N <=  2'b11;
         B_CERR     <=  2'b00;
         RD_ERR     <=  2'b00;
         ALIGNED    <=  1'b0;
         RX_VALID   <=  1'b0;
      end
      
      else
      begin
         RX_DATA 	<= (SIM_EN==1'b1) ?  SIM_DATA       : DTC_DATA;
         RX_K_CHAR	<= (SIM_EN==1'b1) ?  SIM_K_CHAR     : DTC_K_CHAR;
         INVALID_K  <= (SIM_EN==1'b1) ?  SIM_INVALID    : DTC_INVALID;
         CODE_ERR_N <= (SIM_EN==1'b1) ?  SIM_CODE_ERR_N : DTC_CODE_ERR_N;
         B_CERR 	<= (SIM_EN==1'b1) ?  SIM_B_CERR     : DTC_B_CERR;
         RD_ERR 	<= (SIM_EN==1'b1) ?  SIM_RD_ERR     : DTC_RD_ERR;
         ALIGNED	<= (SIM_EN==1'b1) ?  SIM_ALIGNED    : DTC_ALIGNED;
         RX_VALID	<= (SIM_EN==1'b1) ?  SIM_RX_VALID   : DTC_RX_VALID;
      end
   end
   
endmodule

