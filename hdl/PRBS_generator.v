///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: PRBS_generator.v
// File history:
//      v0: 11/24/2020 : First version
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
//  Implementation of 16-bit Pseudo-Random-Bit-Generator with maximum length feedback polynomial (65535 length)
//  using x**16 + x**14 + x**13 + x**11 + 1 to drive the LFSR states 
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: Monica Tecchio
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module PRBS_generator( 
	input  CLK,
	input  RESETGN,
	input  START,
	input	 ERROR_IN,
	output  [1:0] CHAR_OUT,
	output [15:0] DATA_OUT
);

// latch commands
reg 	error_latch, start_latch;
always@(posedge CLK or negedge RESETGN)
begin
   if (RESETGN == 1'b0)	
	begin
		error_latch	<= 1'b0;
		start_latch	<= 1'b0;
	end 
	else 
	begin
		error_latch	<= ERROR_IN;
		start_latch	<= START;
	end	
end


reg [15:0] 	qg;
reg  [1:0] 	cg;
wire w1, w2, w3;

assign DATA_OUT  	=  (start_latch == 1'b1 && error_latch == 1'b1) ? 16'hEFFE : qg;
assign CHAR_OUT	=  cg;

assign w1 	=  qg[13]^qg[15];
assign w2 	=      w1^qg[12];
assign w3 	=      w2^qg[10];

always@(posedge CLK or negedge RESETGN)
begin										 
   if (RESETGN == 1'b0)
   begin
      qg 	<= 16'hBC3C;		//k28.5 k28.1;	
		cg		<= 2'b11;
	end  
   else	
   begin
		if (start_latch == 1'b1)
		begin
			qg  <= {w3, qg[15:1]};
			cg	<= 2'b00;
		end
		else
		begin	
			qg 	<= 16'hBC3C;		//k28.5 k28.1;	
			cg		<= 2'b11;
		end
	end	
end


endmodule

