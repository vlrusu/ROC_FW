--------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: PacketSender.vhd
-- File history:
--      v00: Feb 25, 2015: Birthday
--
-- Description: 
-- PacketSender reads out own ForwardFifo (top priority) and own ResponseFifo
--	to SERDES.
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S050T> <Package::896 FBGA>
-- Author: Ryan Rivera
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 
				   		   
library work;
use work.algorithm_constants.all; 

entity DebugPacketSender is                          	
		port(			   
                EPCS_TXCLK              	: in std_logic;    		 
                RESET_N		              	: in std_logic;  
				                        								 	 
                ERROR		              	: out std_logic;  
				-- 8b10b CorePCS Interface					  									
                TX_CLK_STABLE          		: IN std_logic;	   								  	
			    TX_K_CHAR     	   			: IN std_logic_vector(1 DOWNTO 0)
				                        					 
                                        	
        );                              	
end DebugPacketSender;                       	
                                        	                                                           
                                        	
architecture arch of DebugPacketSender is    	       

	signal countOfData, countOfDataLatch : unsigned (4 downto 0);	
	signal kLatch : std_logic_vector (1 downto 0);
begin	  
	
	process(EPCS_TXCLK)
	begin		
		if ( rising_edge(EPCS_TXCLK) ) then	  
			
			kLatch <= TX_K_CHAR;
			
			--when no longer data, latch data count
			if(TX_CLK_STABLE = '1') then						   
				--tx_kchar changes from packet (0) to other (1,2,3)
				if(kLatch = "00" and TX_K_CHAR /= "00" ) then 
					countOfDataLatch <=  countOfData;	--store the last count
				end if;
				
				-- count data
				if(TX_K_CHAR /= "00") then
					countOfData <= (others => '0');	   
				else	 	 
					if(countOfData /= "11111") then
						countOfData <= countOfData + 1;
					end if;
					
				end if;		 
			end if;
			
			
			if( RESET_N = '0') then 
				ERROR <= '0'; 
				countOfDataLatch <= (others => '0');
			else
				
				if(countOfDataLatch > 0 and countOfDataLatch /= 9) then	   
					ERROR <= '1';
				end if;
				
			end if;
				
			
			
		end if;
		
	end process;
	
	
end architecture;