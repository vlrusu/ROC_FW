//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  6 12:22:15 2023
// Version: 2022.3 2022.3.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PF_SYSTEM_SERVICES_C0 to TCL
# Family: PolarFire
# Part Number: MPF300TS-FCG484I
# Create and Configure the core component PF_SYSTEM_SERVICES_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_SYSTEM_SERVICES:3.0.101} -component_name {PF_SYSTEM_SERVICES_C0} -params {\
"AUTHBITSTREAM:false"  \
"AUTHIAPIMG:false"  \
"DCSERVICE:false"  \
"DIGESTCHECK:false"  \
"DIGSIGSERVICE:false"  \
"DVSERVICE:true"  \
"FF_MAILBOX_ADDR:0x100"  \
"FF_MAILBOX_ADDR_HEX_RANGE:32"  \
"FF_TIMEOUT_VAL:0x20000000"  \
"FF_TIMEOUT_VAL_HEX_RANGE:32"  \
"FFSERVICE:false"  \
"IAPAUTOUPD:false"  \
"IAPSERVICE:true"  \
"NONCESERVICE:false"  \
"OSC_2MHZ_ON:false"  \
"PUFEMSERVICE:false"  \
"QUERYSECSERVICE:false"  \
"RDDEBUGINFO:false"  \
"RDDIGEST:false"  \
"RDENVMPARAMETERS:false"  \
"SECNVMRD:false"  \
"SECNVMWR:false"  \
"SNSERVICE:true"  \
"UCSERVICE:false"   }
# Exporting Component Description of PF_SYSTEM_SERVICES_C0 to TCL done
*/

// PF_SYSTEM_SERVICES_C0
module PF_SYSTEM_SERVICES_C0(
    // Inputs
    APBS_PADDR,
    APBS_PENABLE,
    APBS_PSEL,
    APBS_PWDATA,
    APBS_PWRITE,
    CLK,
    RESETN,
    // Outputs
    APBS_PRDATA,
    APBS_PREADY,
    APBS_PSLVERR,
    SS_BUSY,
    SYSSERV_INIT_REQ,
    USR_BUSY,
    USR_CMD_ERROR,
    USR_RDVLD
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APBS_PADDR;
input         APBS_PENABLE;
input         APBS_PSEL;
input  [31:0] APBS_PWDATA;
input         APBS_PWRITE;
input         CLK;
input         RESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APBS_PRDATA;
output        APBS_PREADY;
output        APBS_PSLVERR;
output        SS_BUSY;
output        SYSSERV_INIT_REQ;
output        USR_BUSY;
output        USR_CMD_ERROR;
output        USR_RDVLD;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APBS_PADDR;
wire          APBS_PENABLE;
wire   [31:0] APBSlave_PRDATA;
wire          APBSlave_PREADY;
wire          APBS_PSEL;
wire          APBSlave_PSLVERR;
wire   [31:0] APBS_PWDATA;
wire          APBS_PWRITE;
wire          CLK;
wire          RESETN;
wire          SS_BUSY_net_0;
wire          SYSSERV_INIT_REQ_net_0;
wire          USR_BUSY_net_0;
wire          USR_CMD_ERROR_net_0;
wire          USR_RDVLD_net_0;
wire          USR_CMD_ERROR_net_1;
wire          USR_BUSY_net_1;
wire          SS_BUSY_net_1;
wire          USR_RDVLD_net_1;
wire          SYSSERV_INIT_REQ_net_1;
wire   [31:0] APBSlave_PRDATA_net_0;
wire          APBSlave_PREADY_net_0;
wire          APBSlave_PSLVERR_net_0;
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
assign USR_CMD_ERROR_net_1    = USR_CMD_ERROR_net_0;
assign USR_CMD_ERROR          = USR_CMD_ERROR_net_1;
assign USR_BUSY_net_1         = USR_BUSY_net_0;
assign USR_BUSY               = USR_BUSY_net_1;
assign SS_BUSY_net_1          = SS_BUSY_net_0;
assign SS_BUSY                = SS_BUSY_net_1;
assign USR_RDVLD_net_1        = USR_RDVLD_net_0;
assign USR_RDVLD              = USR_RDVLD_net_1;
assign SYSSERV_INIT_REQ_net_1 = SYSSERV_INIT_REQ_net_0;
assign SYSSERV_INIT_REQ       = SYSSERV_INIT_REQ_net_1;
assign APBSlave_PRDATA_net_0  = APBSlave_PRDATA;
assign APBS_PRDATA[31:0]      = APBSlave_PRDATA_net_0;
assign APBSlave_PREADY_net_0  = APBSlave_PREADY;
assign APBS_PREADY            = APBSlave_PREADY_net_0;
assign APBSlave_PSLVERR_net_0 = APBSlave_PSLVERR;
assign APBS_PSLVERR           = APBSlave_PSLVERR_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_SYSTEM_SERVICES_C0_PF_SYSTEM_SERVICES_C0_0_PF_SYSTEM_SERVICES   -   Actel:SgCore:PF_SYSTEM_SERVICES:3.0.101
PF_SYSTEM_SERVICES_C0_PF_SYSTEM_SERVICES_C0_0_PF_SYSTEM_SERVICES #( 
        .AUTHBITSTREAM    ( 0 ),
        .AUTHIAPIMG       ( 0 ),
        .DCSERVICE        ( 0 ),
        .DIGESTCHECK      ( 0 ),
        .DIGSIGSERVICE    ( 0 ),
        .DVSERVICE        ( 1 ),
        .FAMILY           ( 26 ),
        .FF_MAILBOX_ADDR  ( 'h100 ),
        .FF_TIMEOUT_VAL   ( 'h20000000 ),
        .FFSERVICE        ( 0 ),
        .IAPAUTOUPD       ( 0 ),
        .IAPSERVICE       ( 1 ),
        .NONCESERVICE     ( 0 ),
        .OSC_2MHZ_ON      ( 0 ),
        .PUFEMSERVICE     ( 0 ),
        .QUERYSECSERVICE  ( 0 ),
        .RDDEBUGINFO      ( 0 ),
        .RDDIGEST         ( 0 ),
        .RDENVMPARAMETERS ( 0 ),
        .SECNVMRD         ( 0 ),
        .SECNVMWR         ( 0 ),
        .SNSERVICE        ( 1 ),
        .UCSERVICE        ( 0 ) )
PF_SYSTEM_SERVICES_C0_0(
        // Inputs
        .CLK               ( CLK ),
        .RESETN            ( RESETN ),
        .APBS_PSEL         ( APBS_PSEL ),
        .APBS_PENABLE      ( APBS_PENABLE ),
        .APBS_PWRITE       ( APBS_PWRITE ),
        .APBS_PADDR        ( APBS_PADDR ),
        .APBS_PWDATA       ( APBS_PWDATA ),
        .FF_NONTIMED_ENTRY ( GND_net ), // tied to 1'b0 from definition
        .FF_TIMED_ENTRY    ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .APBS_PRDATA       ( APBSlave_PRDATA ),
        .APBS_PREADY       ( APBSlave_PREADY ),
        .APBS_PSLVERR      ( APBSlave_PSLVERR ),
        .USR_CMD_ERROR     ( USR_CMD_ERROR_net_0 ),
        .USR_BUSY          ( USR_BUSY_net_0 ),
        .SS_BUSY           ( SS_BUSY_net_0 ),
        .USR_RDVLD         ( USR_RDVLD_net_0 ),
        .SYSSERV_INIT_REQ  ( SYSSERV_INIT_REQ_net_0 ),
        .FF_INIT_REQ       (  ),
        .FF_EXIT_STATUS    (  ),
        .FF_US_RESTORE     (  ),
        .FF_OSC2MHZ_ON     (  ) 
        );


endmodule
