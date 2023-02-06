//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  6 12:23:48 2023
// Version: 2022.3 2022.3.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of CorePCS_C0 to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component CorePCS_C0
create_and_configure_core -core_vlnv {Actel:DirectCore:CorePCS:3.6.103} -component_name {CorePCS_C0} -params {\
"COMMA_DETECT_SEL:0"  \
"ENDEC_DWIDTH:16"  \
"EPCS_DWIDTH:20"  \
"IO_SIZE:1"  \
"LANE_MODE:2"  \
"NO_OF_COMMAS:1"  \
"PROG_COMMA_EN:1"  \
"SHIFT_EN:false"   }
# Exporting Component Description of CorePCS_C0 to TCL done
*/

// CorePCS_C0
module CorePCS_C0(
    // Inputs
    DISP_SEL,
    EPCS_READY,
    EPCS_RxCLK,
    EPCS_RxDATA,
    EPCS_RxIDLE,
    EPCS_RxRSTn,
    EPCS_RxVAL,
    EPCS_TxCLK,
    EPCS_TxRSTn,
    FORCE_DISP,
    RESET_N,
    TX_DATA,
    TX_K_CHAR,
    WA_RSTn,
    // Outputs
    ALIGNED,
    B_CERR,
    CODE_ERR_N,
    EPCS_PWRDN,
    EPCS_RxERR,
    EPCS_TXOOB,
    EPCS_TxDATA,
    EPCS_TxVAL,
    INVALID_K,
    RD_ERR,
    RX_DATA,
    RX_K_CHAR
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [1:0]  DISP_SEL;
input         EPCS_READY;
input         EPCS_RxCLK;
input  [19:0] EPCS_RxDATA;
input         EPCS_RxIDLE;
input         EPCS_RxRSTn;
input         EPCS_RxVAL;
input         EPCS_TxCLK;
input         EPCS_TxRSTn;
input  [1:0]  FORCE_DISP;
input         RESET_N;
input  [15:0] TX_DATA;
input  [1:0]  TX_K_CHAR;
input         WA_RSTn;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        ALIGNED;
output [1:0]  B_CERR;
output [1:0]  CODE_ERR_N;
output        EPCS_PWRDN;
output        EPCS_RxERR;
output        EPCS_TXOOB;
output [19:0] EPCS_TxDATA;
output        EPCS_TxVAL;
output [1:0]  INVALID_K;
output [1:0]  RD_ERR;
output [15:0] RX_DATA;
output [1:0]  RX_K_CHAR;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ALIGNED_net_0;
wire   [1:0]  B_CERR_net_0;
wire   [1:0]  CODE_ERR_N_net_0;
wire   [1:0]  DISP_SEL;
wire          EPCS_PWRDN_net_0;
wire          EPCS_READY;
wire          EPCS_RxCLK;
wire   [19:0] EPCS_RxDATA;
wire          EPCS_RxERR_net_0;
wire          EPCS_RxIDLE;
wire          EPCS_RxRSTn;
wire          EPCS_RxVAL;
wire          EPCS_TxCLK;
wire   [19:0] EPCS_TxDATA_net_0;
wire          EPCS_TXOOB_net_0;
wire          EPCS_TxRSTn;
wire          EPCS_TxVAL_net_0;
wire   [1:0]  FORCE_DISP;
wire   [1:0]  INVALID_K_net_0;
wire   [1:0]  RD_ERR_net_0;
wire          RESET_N;
wire   [15:0] RX_DATA_net_0;
wire   [1:0]  RX_K_CHAR_net_0;
wire   [15:0] TX_DATA;
wire   [1:0]  TX_K_CHAR;
wire          WA_RSTn;
wire          EPCS_PWRDN_net_1;
wire          EPCS_TXOOB_net_1;
wire          EPCS_TxVAL_net_1;
wire   [19:0] EPCS_TxDATA_net_1;
wire          EPCS_RxERR_net_1;
wire   [1:0]  INVALID_K_net_1;
wire   [15:0] RX_DATA_net_1;
wire   [1:0]  CODE_ERR_N_net_1;
wire   [1:0]  RX_K_CHAR_net_1;
wire   [1:0]  B_CERR_net_1;
wire   [1:0]  RD_ERR_net_1;
wire          ALIGNED_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign EPCS_PWRDN_net_1  = EPCS_PWRDN_net_0;
assign EPCS_PWRDN        = EPCS_PWRDN_net_1;
assign EPCS_TXOOB_net_1  = EPCS_TXOOB_net_0;
assign EPCS_TXOOB        = EPCS_TXOOB_net_1;
assign EPCS_TxVAL_net_1  = EPCS_TxVAL_net_0;
assign EPCS_TxVAL        = EPCS_TxVAL_net_1;
assign EPCS_TxDATA_net_1 = EPCS_TxDATA_net_0;
assign EPCS_TxDATA[19:0] = EPCS_TxDATA_net_1;
assign EPCS_RxERR_net_1  = EPCS_RxERR_net_0;
assign EPCS_RxERR        = EPCS_RxERR_net_1;
assign INVALID_K_net_1   = INVALID_K_net_0;
assign INVALID_K[1:0]    = INVALID_K_net_1;
assign RX_DATA_net_1     = RX_DATA_net_0;
assign RX_DATA[15:0]     = RX_DATA_net_1;
assign CODE_ERR_N_net_1  = CODE_ERR_N_net_0;
assign CODE_ERR_N[1:0]   = CODE_ERR_N_net_1;
assign RX_K_CHAR_net_1   = RX_K_CHAR_net_0;
assign RX_K_CHAR[1:0]    = RX_K_CHAR_net_1;
assign B_CERR_net_1      = B_CERR_net_0;
assign B_CERR[1:0]       = B_CERR_net_1;
assign RD_ERR_net_1      = RD_ERR_net_0;
assign RD_ERR[1:0]       = RD_ERR_net_1;
assign ALIGNED_net_1     = ALIGNED_net_0;
assign ALIGNED           = ALIGNED_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CorePCS   -   Actel:DirectCore:CorePCS:3.6.103
CorePCS #( 
        .COMMA_DETECT_SEL      ( 0 ),
        .ENDEC_DWIDTH          ( 16 ),
        .EPCS_DWIDTH           ( 20 ),
        .FAMILY                ( 19 ),
        .IO_SIZE               ( 1 ),
        .LANE_MODE             ( 2 ),
        .NO_OF_COMMAS          ( 1 ),
        .PROG_COMMA_EN         ( 1 ),
        .SHIFT_EN              ( 0 ),
        .TGIGEN_DISPLAY_SYMBOL ( 1 ) )
CorePCS_C0_0(
        // Inputs
        .RESET_N     ( RESET_N ),
        .EPCS_READY  ( EPCS_READY ),
        .EPCS_TxRSTn ( EPCS_TxRSTn ),
        .EPCS_TxCLK  ( EPCS_TxCLK ),
        .EPCS_RxRSTn ( EPCS_RxRSTn ),
        .EPCS_RxCLK  ( EPCS_RxCLK ),
        .EPCS_RxVAL  ( EPCS_RxVAL ),
        .EPCS_RxDATA ( EPCS_RxDATA ),
        .EPCS_RxIDLE ( EPCS_RxIDLE ),
        .TX_DATA     ( TX_DATA ),
        .TX_K_CHAR   ( TX_K_CHAR ),
        .WA_RSTn     ( WA_RSTn ),
        .FORCE_DISP  ( FORCE_DISP ),
        .DISP_SEL    ( DISP_SEL ),
        // Outputs
        .EPCS_PWRDN  ( EPCS_PWRDN_net_0 ),
        .EPCS_TXOOB  ( EPCS_TXOOB_net_0 ),
        .EPCS_TxVAL  ( EPCS_TxVAL_net_0 ),
        .EPCS_TxDATA ( EPCS_TxDATA_net_0 ),
        .EPCS_RxERR  ( EPCS_RxERR_net_0 ),
        .INVALID_K   ( INVALID_K_net_0 ),
        .RX_DATA     ( RX_DATA_net_0 ),
        .CODE_ERR_N  ( CODE_ERR_N_net_0 ),
        .RX_K_CHAR   ( RX_K_CHAR_net_0 ),
        .B_CERR      ( B_CERR_net_0 ),
        .RD_ERR      ( RD_ERR_net_0 ),
        .ALIGNED     ( ALIGNED_net_0 ) 
        );


endmodule
