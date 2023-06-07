///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: PBRS_checker.v
// File history:
//      v0: 11/24/2020 : First version
//      v1: 06/06/2023 : version for DRAC Test firmware: it assumes that BITE SWAP is done in XCVR_BLOCK/Word_Aligner
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

module PBRS_checker( 
	input   CLK,
	input   RESETCN,
	input   START,
	input   ERROR_CLEAR,
	input   RX_VAL_IN,
	input	 [15:0] DATA_IN,
	input   [1:0] CHAR_IN,
	output reg ERROR_OUT,  	// used as FIFO write enable
	output reg RX_VAL_OUT,  // return status of fiber LOCK
	output reg PRBS_ON,		// used to indicate that data comparision has started
	output reg [31:0] ERROR_COUNT,
	output reg [15:0] ERROR_DATA,
	output reg [15:0] PATTERN_DATA
);
//
// latch commands
reg 	clear_latch, start_reg, start_latch;

//
// generate pattern and compare logic
reg  [1:0]  char_latch;
reg [15:0] 	data_latch;
reg [15:0] 	qc;
reg [15:0]	data_aligned;
//reg			byte_flip;
wire w1, w2, w3;

assign w1 	=  qc[13]^qc[15];
assign w2 	=      w1^qc[12];
assign w3 	=      w2^qc[10];

//
// error logic and latch of diagnostics to FIFO
reg			det_err;
reg [31:0] 	error_cnt;
reg [15:0] 	error_data;
reg [15:0] 	error_pattern;

always@(posedge CLK or negedge RESETCN)
begin										 
    if (RESETCN == 1'b0)
    begin
		clear_latch	<= 1'b0;
		start_reg	<= 1'b0;
		start_latch	<= 1'b0;
        
		char_latch		<= 2'b0;
		data_latch		<= 16'h0;
		data_aligned	<= 16'h0;
        qc 				<= 16'hBC3C;		//k28.5 k28.1;
        
        det_err 		<= 1'b0;
		error_cnt		<= 32'h0;
		error_data		<= 16'h0;
		error_pattern	<= 16'h0;
//		byte_flip 		<= 1'b0;

		PRBS_ON			<= 1'b0;
		ERROR_OUT		<= 1'b0;
		RX_VAL_OUT		<= 1'b0;
		ERROR_COUNT		<= 32'h0;
		ERROR_DATA		<= 16'h0;
		PATTERN_DATA	<= 16'h0;
        
    end  
    else 
    begin
		clear_latch	<= ERROR_CLEAR;
		start_reg	<= START;
        
		char_latch	<= CHAR_IN;
		data_latch	<= DATA_IN;
        
		// when we see 0x3CBC exiting XCVR (or byte_flip=1), it means we shifted ahead by one byte 
		// and MSB byte of "aligned word" is LSB byte of previous one
        // THIS IS DONE IN WORD_ALIGNER NOW!!!
//		data_aligned<= (byte_flip == 1'b1) ? {data_latch[7:0],DATA_IN[15:8]} : DATA_IN;
		
        // wait until non comma words is seen to start sequence check
        if (start_reg == 1'b1 && char_latch == 2'b00) start_latch <= 1'b1; 
        else                                          start_latch <= 1'b0;
        
		if(char_latch == 2'b11) begin
            qc          <= 16'hBC3C;
            data_aligned<= 16'h0;
        end else begin
            qc          <= {w3, qc[15:1]};
            data_aligned<= data_latch; 
        end
        
        // drive sequence checking and error counts
		if (clear_latch)
        begin
            error_cnt	<= 32'h0;
        end
		else
        begin
            if (start_latch == 1'b1)
            begin
                if (qc != data_aligned)
                begin
                    det_err 		<= 1'b1;
                    error_cnt		<= error_cnt + 1'b1;
                    error_data		<= data_aligned;
                    error_pattern	<= qc;
                end
                else
                begin
                    det_err 		<= 1'b0;
                    error_data		<= 16'h0;
                    error_pattern	<= 16'h0;
                end
            end
        end
        
        // drive outputs
		if(start_latch) PRBS_ON <= 1'b1;
		else		    PRBS_ON	<= 1'b0;
		ERROR_OUT		<= det_err;
		RX_VAL_OUT		<= RX_VAL_IN;
		ERROR_COUNT		<= error_cnt;
		ERROR_DATA		<= error_data;
		PATTERN_DATA	<= error_pattern;
        
    end
end

endmodule

