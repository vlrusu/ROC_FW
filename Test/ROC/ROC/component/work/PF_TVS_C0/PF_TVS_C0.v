//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  6 12:22:25 2023
// Version: 2022.3 2022.3.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PF_TVS_C0 to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component PF_TVS_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_TVS:1.0.110} -component_name {PF_TVS_C0} -params {\
"TVS_CONTROL_ENABLE_1P8V_CHANNEL:true"  \
"TVS_CONTROL_ENABLE_1V_CHANNEL:true"  \
"TVS_CONTROL_ENABLE_2P5V_CHANNEL:true"  \
"TVS_CONTROL_ENABLE_TEMP_CHANNEL:true"  \
"TVS_CONTROL_RATE:60"  \
"TVS_CONTROL_RATE_IN_US:1920"  \
"TVS_TRIGGER_HIGH:0"  \
"TVS_TRIGGER_LOW:0"   }
# Exporting Component Description of PF_TVS_C0 to TCL done
*/

// PF_TVS_C0
module PF_TVS_C0(
    // Inputs
    ENABLE_18V,
    ENABLE_1V,
    ENABLE_25V,
    ENABLE_TEMP,
    TEMP_HIGH_CLEAR,
    TEMP_LOW_CLEAR,
    // Outputs
    ACTIVE,
    CHANNEL,
    TEMP_HIGH,
    TEMP_LOW,
    VALID,
    VALUE
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ENABLE_18V;
input         ENABLE_1V;
input         ENABLE_25V;
input         ENABLE_TEMP;
input         TEMP_HIGH_CLEAR;
input         TEMP_LOW_CLEAR;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        ACTIVE;
output [1:0]  CHANNEL;
output        TEMP_HIGH;
output        TEMP_LOW;
output        VALID;
output [15:0] VALUE;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ACTIVE_net_0;
wire   [1:0]  CHANNEL_net_0;
wire          ENABLE_1V;
wire          ENABLE_18V;
wire          ENABLE_25V;
wire          ENABLE_TEMP;
wire          TEMP_HIGH_net_0;
wire          TEMP_HIGH_CLEAR;
wire          TEMP_LOW_net_0;
wire          TEMP_LOW_CLEAR;
wire          VALID_net_0;
wire   [15:0] VALUE_net_0;
wire          TEMP_HIGH_net_1;
wire          TEMP_LOW_net_1;
wire   [15:0] VALUE_net_1;
wire   [1:0]  CHANNEL_net_1;
wire          VALID_net_1;
wire          ACTIVE_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign TEMP_HIGH_net_1 = TEMP_HIGH_net_0;
assign TEMP_HIGH       = TEMP_HIGH_net_1;
assign TEMP_LOW_net_1  = TEMP_LOW_net_0;
assign TEMP_LOW        = TEMP_LOW_net_1;
assign VALUE_net_1     = VALUE_net_0;
assign VALUE[15:0]     = VALUE_net_1;
assign CHANNEL_net_1   = CHANNEL_net_0;
assign CHANNEL[1:0]    = CHANNEL_net_1;
assign VALID_net_1     = VALID_net_0;
assign VALID           = VALID_net_1;
assign ACTIVE_net_1    = ACTIVE_net_0;
assign ACTIVE          = ACTIVE_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_TVS_C0_PF_TVS_C0_0_PF_TVS   -   Actel:SgCore:PF_TVS:1.0.110
PF_TVS_C0_PF_TVS_C0_0_PF_TVS PF_TVS_C0_0(
        // Inputs
        .TEMP_HIGH_CLEAR ( TEMP_HIGH_CLEAR ),
        .TEMP_LOW_CLEAR  ( TEMP_LOW_CLEAR ),
        .ENABLE_1V       ( ENABLE_1V ),
        .ENABLE_18V      ( ENABLE_18V ),
        .ENABLE_25V      ( ENABLE_25V ),
        .ENABLE_TEMP     ( ENABLE_TEMP ),
        // Outputs
        .TEMP_HIGH       ( TEMP_HIGH_net_0 ),
        .TEMP_LOW        ( TEMP_LOW_net_0 ),
        .VALUE           ( VALUE_net_0 ),
        .CHANNEL         ( CHANNEL_net_0 ),
        .VALID           ( VALID_net_0 ),
        .ACTIVE          ( ACTIVE_net_0 ) 
        );


endmodule
