--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: mux_to_xcvr.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 

library work;
use work.algorithm_constants.all; 

entity mux_to_xcvr is
port (
	XCVR_CLK             : in std_logic;      -- TX Serdes Clock
	XCVR_RESETN          : in std_logic;	   

	MARKER_SEL           : in std_logic;	 	-- if 0, DTC Packet out;  if 1, Marker out  	   
	DTC_SIM_KCHAR   		: in std_logic_vector(1 DOWNTO 0);	
	DTC_SIM_DATA			: in std_logic_vector(15 DOWNTO 0);  
	MARKER_SIM_KCHAR   	: in std_logic_vector(1 DOWNTO 0);	
	MARKER_SIM_DATA		: in std_logic_vector(15 DOWNTO 0);  

	SIM_TX_KCHAR   		: out std_logic_vector(1 DOWNTO 0);	
	SIM_TX_DATA				: out std_logic_vector(15 DOWNTO 0)  
);
end mux_to_xcvr;

architecture architecture_mux_to_xcvr of mux_to_xcvr is

	signal data				: std_logic_vector(15 downto 0);
	signal char				: std_logic_vector( 1 downto 0);
	
	constant	Comma			: std_logic_vector(15 downto 0)	:= x"BC3C";	-- k28.5 k28.1  0xBC3C
	constant	Kchar			: std_logic_vector(1 downto 0) 	:=	"11";
	
   -- architecture body
begin

	domainTransfer: process( XCVR_CLK )  															    	
	begin 					 
		if rising_edge(XCVR_CLK) then		
				
			SIM_TX_DATA	<= data;
			SIM_TX_KCHAR<= char;
				
			if (XCVR_RESETN = '0') then
				
				data	<=  Comma;   
				char	<=  KChar;
				
			else
				
				data	<= MARKER_SIM_DATA 	when MARKER_SEL= '1'		else 	DTC_SIM_DATA; 
				char	<= MARKER_SIM_KCHAR 	when MARKER_SEL= '1'		else 	DTC_SIM_KCHAR;
				
			end if;
		end if;
	end process;
	
end architecture_mux_to_xcvr;
