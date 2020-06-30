						   					 --------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: Latch_Counter.vhd
-- File history:
--      v00: Feb 25, 2015: Birthday
--
-- Description: 
-- Counter that increments when it receives a pulse.
-- Used on DEBUG_REG_1 register in the ROCMonitor for testing readouts of changing signals.
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S050T> <Package::896 FBGA>
-- Author: Jose Berlioz
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 
								   						   
library work;
use work.algorithm_constants.all; 

entity Debug_Latch_Counter is  
		Generic (			 
            gAPB_DWIDTH     		: integer := 16;  
            gAPB_AWIDTH     		: integer := 16;	 
            gSERDES_DWIDTH  		: integer := 20; 
            gENDEC_DWIDTH   		: integer := 16;	
            IO_SIZE         		: integer := 2;
			ALGO_LOC_ADDR 			: natural := 0
		);
	    port(
	        ALGO_CLK              : in std_logic;      
	        RESET_N                 : in std_logic;	 					
			DEBUG_PULSE				: in std_logic;
			
			DEBUG_COUNTER_16		: out std_logic_vector(gAPB_AWIDTH-1 downto 0)
				
	    );
end Debug_Latch_Counter;
architecture arch of Debug_Latch_Counter is    
signal debug_counter_16_sig			: unsigned(15 downto 0);	 
signal debug_pulse_sig				: std_logic;

begin	   
	
DEBUG_COUNTER_16	<= 	std_logic_vector(debug_counter_16_sig);	

count:process(ALGO_CLK)
	begin
		if	(rising_edge(ALGO_CLK))	then   
			
			if(RESET_N = '0') then
				debug_counter_16_sig  <= (OTHERS => '0');   		
			else   
				if(DEBUG_PULSE = '1') then 
					debug_counter_16_sig	<= debug_counter_16_sig + 1;
				end if;
			end if;
		end if;		
	end process;
end architecture;

