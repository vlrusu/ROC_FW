
library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 
								   						   
library work;
use work.algorithm_constants.all; 

entity timeStamp_IF is  	       
	port(			
			TIMESTAMP_IN					:   in		std_logic_vector(31 downto 0);
			RECORDTIMESTAMP					:   in		std_logic; 
			TCLK							: 	in      std_logic;
			
			TIMESTAMP_OUT					: 	out		std_logic_vector(15 downto 0);
			WE								:  	out		std_logic
	    );														  
end timeStamp_IF;												  

architecture arch of timeStamp_IF is	
	SIGNAL recordTimestamp_Latch				 	: std_logic;
    SIGNAL recordTimestamp_Latch2                   : std_logic;

begin			 																			
	main: process(TCLK)
	begin	
		if(rising_edge(TCLK)) then	
                recordTimestamp_Latch <= RECORDTIMESTAMP;
                recordTimestamp_Latch2 <= recordTimestamp_Latch;

			if (recordTimestamp_Latch = '1' and recordTimestamp_Latch2 = '0') then
				TIMESTAMP_OUT <= TIMESTAMP_IN (15 downto 0);
				WE 				<= '1';
			else
				WE			  	<= '0';
			end if;
		end if;
	end process;		  
end architecture;