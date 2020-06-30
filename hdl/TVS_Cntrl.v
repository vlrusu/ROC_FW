///////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: TVS_Cntrl.v
// 
// Description: 
//
// <The module writes the values from PF_TVS to URAM>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Yongyi Wu>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 


module TVS_Cntrl(

 //clock and reset
 input  wire        clk,
 input  wire        resetn_i,

 //TVS IF
 input  wire        valid_i,
 input  wire [15:0] value_i,
 input  wire [1:0]  channel_i,

 output reg  [15:0] value_o,
 output reg  [1:0]  channel_o,
 output wire        w_en_o
);

reg         tvs_valid_delay1;
reg         tvs_valid_delay2;

assign w_en_o = tvs_valid_delay1 & (!tvs_valid_delay2);

always@(posedge clk, negedge resetn_i)
begin
   if(!resetn_i)
   begin
      value_o          <=   0;
      channel_o        <=   0;
      tvs_valid_delay1 <=   0;
      tvs_valid_delay2 <=   0;
   end
   else
   begin
      tvs_valid_delay1 <=   valid_i;
      tvs_valid_delay2 <=   tvs_valid_delay1;
      value_o     <=   value_i;
      channel_o   <=   channel_i;
   end
end

endmodule


