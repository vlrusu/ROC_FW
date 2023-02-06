//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  6 12:22:28 2023
// Version: 2022.3 2022.3.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PF_URAM_C0 to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component PF_URAM_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_URAM:1.1.107} -component_name {PF_URAM_C0} -params {\
"BLK_PN:BLK_EN"  \
"BLK_POLARITY:2"  \
"BUSY_FLAG:0"  \
"CASCADE:0"  \
"CLKS:2"  \
"CLOCK_PN:CLK"  \
"IMPORT_FILE:"  \
"INIT_RAM:F"  \
"LPMTYPE:LPM_URAM"  \
"R_ADDR_ARST_PN:R_ADDR_ARST_N"  \
"R_ADDR_ARST_POLARITY:2"  \
"R_ADDR_EN_PN:R_ADDR_EN"  \
"R_ADDR_EN_POLARITY:2"  \
"R_ADDR_LAT:0"  \
"R_ADDR_PN:R_ADDR"  \
"R_ADDR_SRST_PN:R_ADDR_SRST_N"  \
"R_ADDR_SRST_POLARITY:2"  \
"R_CLK_EDGE:RISE"  \
"R_CLK_PN:R_CLK"  \
"R_DATA_ARST_PN:R_DATA_ARST_N"  \
"R_DATA_ARST_POLARITY:2"  \
"R_DATA_EN_PN:R_DATA_EN"  \
"R_DATA_EN_POLARITY:2"  \
"R_DATA_LAT:0"  \
"R_DATA_PN:R_DATA"  \
"R_DATA_SRST_PN:R_DATA_SRST_N"  \
"R_DATA_SRST_POLARITY:2"  \
"RDEPTH:4"  \
"RESET_POLARITY:2"  \
"RWIDTH:16"  \
"SII_LOCK:0"  \
"W_ADDR_PN:W_ADDR"  \
"W_CLK_EDGE:RISE"  \
"W_CLK_PN:W_CLK"  \
"W_DATA_PN:W_DATA"  \
"W_EN_PN:W_EN"  \
"W_EN_POLARITY:1"  \
"WDEPTH:4"  \
"WWIDTH:16"   }
# Exporting Component Description of PF_URAM_C0 to TCL done
*/

// PF_URAM_C0
module PF_URAM_C0(
    // Inputs
    R_ADDR,
    R_CLK,
    W_ADDR,
    W_CLK,
    W_DATA,
    W_EN,
    // Outputs
    R_DATA
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [1:0]  R_ADDR;
input         R_CLK;
input  [1:0]  W_ADDR;
input         W_CLK;
input  [15:0] W_DATA;
input         W_EN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [15:0] R_DATA;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [1:0]  R_ADDR;
wire          R_CLK;
wire   [15:0] R_DATA_net_0;
wire   [1:0]  W_ADDR;
wire          W_CLK;
wire   [15:0] W_DATA;
wire          W_EN;
wire   [15:0] R_DATA_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign R_DATA_net_1 = R_DATA_net_0;
assign R_DATA[15:0] = R_DATA_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_URAM_C0_PF_URAM_C0_0_PF_URAM   -   Actel:SgCore:PF_URAM:1.1.107
PF_URAM_C0_PF_URAM_C0_0_PF_URAM PF_URAM_C0_0(
        // Inputs
        .W_DATA ( W_DATA ),
        .R_ADDR ( R_ADDR ),
        .W_ADDR ( W_ADDR ),
        .W_EN   ( W_EN ),
        .R_CLK  ( R_CLK ),
        .W_CLK  ( W_CLK ),
        // Outputs
        .R_DATA ( R_DATA_net_0 ) 
        );


endmodule
