//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  6 12:21:36 2023
// Version: 2022.3 2022.3.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PF_CLK_DIV_C0 to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component PF_CLK_DIV_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_CLK_DIV:1.0.103} -component_name {PF_CLK_DIV_C0} -params {\
"DIVIDER:4"  \
"ENABLE_BIT_SLIP:false"  \
"ENABLE_SRESET:false"   }
# Exporting Component Description of PF_CLK_DIV_C0 to TCL done
*/

// PF_CLK_DIV_C0
module PF_CLK_DIV_C0(
    // Inputs
    CLK_IN,
    // Outputs
    CLK_OUT
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  CLK_IN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output CLK_OUT;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   CLK_IN;
wire   CLK_OUT_net_0;
wire   CLK_OUT_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign CLK_OUT_net_1 = CLK_OUT_net_0;
assign CLK_OUT       = CLK_OUT_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_CLK_DIV_C0_PF_CLK_DIV_C0_0_PF_CLK_DIV   -   Actel:SgCore:PF_CLK_DIV:1.0.103
PF_CLK_DIV_C0_PF_CLK_DIV_C0_0_PF_CLK_DIV PF_CLK_DIV_C0_0(
        // Inputs
        .CLK_IN  ( CLK_IN ),
        // Outputs
        .CLK_OUT ( CLK_OUT_net_0 ) 
        );


endmodule
