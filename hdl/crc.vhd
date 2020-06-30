-------------------------------------------------------------------------------
--
-- Title       : crc
-- Design      : roc_algo
-- Author      : jberlioz
-- Company     : Fermilab
--
-------------------------------------------------------------------------------
	 -------------------------------------------------------------------------------
-- Copyright (C) 2009 OutputLogic.com
-- This source file may be used and distributed without restriction
-- provided that this copyright statement is not removed from the file
-- and that any derivative work contains the original copyright notice
-- and the associated disclaimer.
--
-- THIS SOURCE FILE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
-- OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
-- WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
-------------------------------------------------------------------------------
-- CRC module for data[15:0] ,   crc[15:0]=1+x^3+x^7+x^12+x^14+x^16;
-------------------------------------------------------------------------------	

-- found CRC code generator on:
-- crc-gen-verilog.sourceforge.net
-- outputlogic.com/?page_id=321
-- also downloaded executable version
--									 
-- Rewritten for vhdl (due to license limitations with Active-HDL)
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity crc is	
	port(	
	CLK		:	IN	 STD_LOGIC;
	RST		:	IN	 STD_LOGIC;  
	CRC_EN	:	IN	 STD_LOGIC;
	DATA_IN :	IN	 STD_LOGIC_VECTOR(15 DOWNTO 0);	
			 
 	CRC_OUT	:	OUT	 STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
end crc;

--}} End of automatically maintained section

architecture crc_behavior of crc is	

	signal lfsr_q, lfsr_c	: std_logic_vector(15 downto 0);

begin

	crc_out <= lfsr_q;

    lfsr_c(0) 	<= lfsr_q(0) XOR lfsr_q(2) XOR lfsr_q(6) XOR lfsr_q(8) XOR lfsr_q(9) XOR lfsr_q(12) XOR lfsr_q(14) XOR data_in(0) XOR data_in(2) XOR data_in(6) XOR data_in(8) XOR data_in(9) XOR data_in(12) XOR data_in(14);
    lfsr_c(1) 	<= lfsr_q(1) XOR lfsr_q(3) XOR lfsr_q(7) XOR lfsr_q(9) XOR lfsr_q(10) XOR lfsr_q(13) XOR lfsr_q(15) XOR data_in(1) XOR data_in(3) XOR data_in(7) XOR data_in(9) XOR data_in(10) XOR data_in(13) XOR data_in(15);
    lfsr_c(2) 	<= lfsr_q(2) XOR lfsr_q(4) XOR lfsr_q(8) XOR lfsr_q(10) XOR lfsr_q(11) XOR lfsr_q(14) XOR data_in(2) XOR data_in(4) XOR data_in(8) XOR data_in(10) XOR data_in(11) XOR data_in(14);
    lfsr_c(3) 	<= lfsr_q(0) XOR lfsr_q(2) XOR lfsr_q(3) XOR lfsr_q(5) XOR lfsr_q(6) XOR lfsr_q(8) XOR lfsr_q(11) XOR lfsr_q(14) XOR lfsr_q(15) XOR data_in(0) XOR data_in(2) XOR data_in(3) XOR data_in(5) XOR data_in(6) XOR data_in(8) XOR data_in(11) XOR data_in(14) XOR data_in(15);
    lfsr_c(4) 	<= lfsr_q(1) XOR lfsr_q(3) XOR lfsr_q(4) XOR lfsr_q(6) XOR lfsr_q(7) XOR lfsr_q(9) XOR lfsr_q(12) XOR lfsr_q(15) XOR data_in(1) XOR data_in(3) XOR data_in(4) XOR data_in(6) XOR data_in(7) XOR data_in(9) XOR data_in(12) XOR data_in(15);
    lfsr_c(5) 	<= lfsr_q(2) XOR lfsr_q(4) XOR lfsr_q(5) XOR lfsr_q(7) XOR lfsr_q(8) XOR lfsr_q(10) XOR lfsr_q(13) XOR data_in(2) XOR data_in(4) XOR data_in(5) XOR data_in(7) XOR data_in(8) XOR data_in(10) XOR data_in(13);
    lfsr_c(6) 	<= lfsr_q(3) XOR lfsr_q(5) XOR lfsr_q(6) XOR lfsr_q(8) XOR lfsr_q(9) XOR lfsr_q(11) XOR lfsr_q(14) XOR data_in(3) XOR data_in(5) XOR data_in(6) XOR data_in(8) XOR data_in(9) XOR data_in(11) XOR data_in(14);
    lfsr_c(7) 	<= lfsr_q(0) XOR lfsr_q(2) XOR lfsr_q(4) XOR lfsr_q(7) XOR lfsr_q(8) XOR lfsr_q(10) XOR lfsr_q(14) XOR lfsr_q(15) XOR data_in(0) XOR data_in(2) XOR data_in(4) XOR data_in(7) XOR data_in(8) XOR data_in(10) XOR data_in(14) XOR data_in(15);
    lfsr_c(8) 	<= lfsr_q(1) XOR lfsr_q(3) XOR lfsr_q(5) XOR lfsr_q(8) XOR lfsr_q(9) XOR lfsr_q(11) XOR lfsr_q(15) XOR data_in(1) XOR data_in(3) XOR data_in(5) XOR data_in(8) XOR data_in(9) XOR data_in(11) XOR data_in(15);
    lfsr_c(9) 	<= lfsr_q(2) XOR lfsr_q(4) XOR lfsr_q(6) XOR lfsr_q(9) XOR lfsr_q(10) XOR lfsr_q(12) XOR data_in(2) XOR data_in(4) XOR data_in(6) XOR data_in(9) XOR data_in(10) XOR data_in(12);
    lfsr_c(10) 	<= lfsr_q(3) XOR lfsr_q(5) XOR lfsr_q(7) XOR lfsr_q(10) XOR lfsr_q(11) XOR lfsr_q(13) XOR data_in(3) XOR data_in(5) XOR data_in(7) XOR data_in(10) XOR data_in(11) XOR data_in(13);
    lfsr_c(11) 	<= lfsr_q(4) XOR lfsr_q(6) XOR lfsr_q(8) XOR lfsr_q(11) XOR lfsr_q(12) XOR lfsr_q(14) XOR data_in(4) XOR data_in(6) XOR data_in(8) XOR data_in(11) XOR data_in(12) XOR data_in(14);
    lfsr_c(12) 	<= lfsr_q(0) XOR lfsr_q(2) XOR lfsr_q(5) XOR lfsr_q(6) XOR lfsr_q(7) XOR lfsr_q(8) XOR lfsr_q(13) XOR lfsr_q(14) XOR lfsr_q(15) XOR data_in(0) XOR data_in(2) XOR data_in(5) XOR data_in(6) XOR data_in(7) XOR data_in(8) XOR data_in(13) XOR data_in(14) XOR data_in(15);
    lfsr_c(13) 	<= lfsr_q(1) XOR lfsr_q(3) XOR lfsr_q(6) XOR lfsr_q(7) XOR lfsr_q(8) XOR lfsr_q(9) XOR lfsr_q(14) XOR lfsr_q(15) XOR data_in(1) XOR data_in(3) XOR data_in(6) XOR data_in(7) XOR data_in(8) XOR data_in(9) XOR data_in(14) XOR data_in(15);
    lfsr_c(14) 	<= lfsr_q(0) XOR lfsr_q(4) XOR lfsr_q(6) XOR lfsr_q(7) XOR lfsr_q(10) XOR lfsr_q(12) XOR lfsr_q(14) XOR lfsr_q(15) XOR data_in(0) XOR data_in(4) XOR data_in(6) XOR data_in(7) XOR data_in(10) XOR data_in(12) XOR data_in(14) XOR data_in(15);
    lfsr_c(15) 	<= lfsr_q(1) XOR lfsr_q(5) XOR lfsr_q(7) XOR lfsr_q(8) XOR lfsr_q(11) XOR lfsr_q(13) XOR lfsr_q(15) XOR data_in(1) XOR data_in(5) XOR data_in(7) XOR data_in(8) XOR data_in(11) XOR data_in(13) XOR data_in(15);

	crc: process(CLK)
	begin
		if(rising_edge(CLK)) THEN	  
			if (crc_en = '1') then	
				lfsr_q <= lfsr_c; 
			elsif (RST = '1') then
				lfsr_q <= x"FFFF";		 	 
		 	end if;
		end if;		   
	end process;

end crc_behavior;
