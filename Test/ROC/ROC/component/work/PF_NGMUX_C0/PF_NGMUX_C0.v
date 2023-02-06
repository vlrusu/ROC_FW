//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  6 12:21:38 2023
// Version: 2022.3 2022.3.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PF_NGMUX_C0 to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component PF_NGMUX_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_NGMUX:1.0.101} -component_name {PF_NGMUX_C0} -params {\
"ENABLE_NON_TOGGLING_CLK_SWITCH_SUPPORT:false"   }
# Exporting Component Description of PF_NGMUX_C0 to TCL done
*/

// PF_NGMUX_C0
module PF_NGMUX_C0(
    // Inputs
    CLK0,
    CLK1,
    SEL,
    // Outputs
    CLK_OUT
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  CLK0;
input  CLK1;
input  SEL;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output CLK_OUT;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   CLK0;
wire   CLK1;
wire   CLK_OUT_net_0;
wire   SEL;
wire   CLK_OUT_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign CLK_OUT_net_1 = CLK_OUT_net_0;
assign CLK_OUT       = CLK_OUT_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_NGMUX_C0_PF_NGMUX_C0_0_PF_NGMUX   -   Actel:SgCore:PF_NGMUX:1.0.101
PF_NGMUX_C0_PF_NGMUX_C0_0_PF_NGMUX PF_NGMUX_C0_0(
        // Inputs
        .CLK0    ( CLK0 ),
        .CLK1    ( CLK1 ),
        .SEL     ( SEL ),
        // Outputs
        .CLK_OUT ( CLK_OUT_net_0 ) 
        );


endmodule
