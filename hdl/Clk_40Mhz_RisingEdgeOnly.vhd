					   --------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: Clock40Mhz.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- Module converts a 200Mhz signal to produce a 40Mhz clock with a 60% duty cycle.
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG484>
-- Author: Jose Berlioz and Ryan Rivera
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Clock40Mhz is
	  Generic (			 
            gAPB_DWIDTH     		: integer := 16;  
            gAPB_AWIDTH     		: integer := 16;	 
            gSERDES_DWIDTH  		: integer := 20; 
            gENDEC_DWIDTH   		: integer := 16;	
            IO_SIZE         		: integer := 2;
			ALGO_LOC_ADDR 			: natural := 0
		);
	port (
        CLOCKMARKER 				: IN  std_logic; -- example
        EVENTMARKER					: IN  std_logic;
        RESET_N						: IN  std_logic;
        Clk_200Mhz  				: IN  std_logic;
                                    
        Clk_40Mhz  					: OUT std_logic;
		RESET_TSMGR					: OUT std_logic;

--    --Error Detection Flags															   
		counterMisalignedMarker		: OUT std_logic_vector(10 downto 0);
        alignedToMarker				: OUT std_logic	   --Is the 40Mhz aligned to a Marker? 
);
end Clock40Mhz;
architecture architecture_Clock40Mhz of Clock40Mhz is
--==========================SIGNALS=============================
	signal errorEventAlignment_sig			: std_logic;
	signal errorClockAlignment_sig			: std_logic;
	signal eventMarkerLatch					: std_logic;
	signal polarity_edge 					: std_logic := '0'; 				  --Changes polarity to obtain 40Mhz clock
    signal counter       					: unsigned(2 downto 0)  := "000";
	signal clockMarkerLatch					: std_logic := '0';	
	signal clockMarkerRisingEdge			: std_logic;
	signal resetClock						: std_logic;  
	signal eventMarkerRisingEdge			: std_logic;	  
	signal resetLatch						: std_logic;
	signal resetFallingEdge					: std_logic;  
	
	signal launchResetTimestamp				: std_logic; 
	signal resetTimestampDetected			: std_logic;	  		
	signal counterMisalignedEvent_sig		: unsigned(10 downto 0);
	signal counterResetTimestamp			: unsigned(4 downto 0);	  
	
	signal markerOffsetPlusOne 				: unsigned (32 downto 0);	
	signal markerOffsetPlusTwo				: unsigned (32 downto 0);
	signal markerOffsetMinusOne				: unsigned (32 downto 0);
	signal markerOffsetMinusTwo				: unsigned (32 downto 0);
begin 
	
resetClock				<= 	'1' when (clockMarkerRisingEdge = '1' or eventMarkerRisingEdge = '1') ELSE		  --Reset when rising edge of CLOCKMARKER.
							'0';																 
	
eventMarkerRisingEdge	<= 	'1' when EVENTMARKER = '1' and eventMarkerLatch = '0' else
							'0';					
	
clockMarkerRisingEdge	<=  '1' when clockMarker = '1' and clockMarkerLatch = '0' else
							'0';						   
	
counterMisalignedMarker <= std_logic_vector(counterMisalignedEvent_sig);	
		
							 
--ERROREVENTALIGNMENT		<= errorEventAlignment_sig; 
--ERRORCLOCKALIGNMENT		<= errorClockAlignment_sig; 

-- ===================	   (1)TICK_40		==================
--	Produces the 40Mhz clock for domain transfers processes.
--------------------------------------------------------------	
   TICK_40: PROCESS (Clk_200Mhz) 
   begin	
	   if (rising_edge(Clk_200Mhz)) then  
		   clockMarkerLatch 			<= CLOCKMARKER;	
		   resetLatch					<= RESET_N;
            
            --(1A) MODULE RESET                     --SYSTEM RESET ASSERTED. Clock needs a clockmarker.
            if(RESET_N = '0') then
			  	Clk_40Mhz       		<= '1';		 
--			    errorClockAlignment 	<= '0';  
--				errorEventAlignment 	<= '0';  
                counter         		<= "000";
	
				
			--(1B) CLOCK RESET
            elsif(resetClock = '1') then  		   --CLOCKMARKER RECEIVED. Clock aligns to it.
                                                   --EVENT MARKERS also resets the clock if it has been system resetted before.
              --  polarity_edge  			 <= '1';
                Clk_40Mhz      			 <= '1';
                counter        			 <= "001";
                alignedToMarker			 <= '1';
				
			--(1C)CLOCK NORMAL OPERATION
            else	  
				counter					 <= counter + 1;	
				if(counter < 3) then	 			--(1C.0)CLOCK HIGH. 3 200Mhz Cycles.
					Clk_40Mhz	<= '1';
				elsif (counter >= 3 and counter < 5) then	--(1C.1) CLOCK LOW. 2 200Mhz Cycles.	
					Clk_40Mhz   <= '0';					
					if (counter = 4) then
						counter <= (others => '0');
					end if;
				end if;
				
            end if;
        end if;
   end process;  

---- ===============	(2)EVENTALIGNCHECK 	===============
----	Checks the event marker alignment to the 40Mhz clock. 
----  NOTE: Recent changes on the forward detector 
----		  give a margin of error to an ALIGNED event
-------------------------------------------------------------
--   EVENTALIGNCHECK: PROCESS (Clk_200Mhz)
--   begin		
--	    if (rising_edge(Clk_200Mhz)) then  
--		   eventMarkerLatch				<= EVENTMARKER;
--		 --(2A) MODULE RESET
--		   if RESET = '1' then		   
--			    errorEventAlignment 		<= '0';	 
--			   
--			    counterMisalignedEvent_sig		<= (others => '0');				
--			   	markerOffsetPlusOne <= (others => '0');
--				markerOffsetPlusTwo <= (others => '0');
--				markerOffsetMinusOne <= (others => '0');
--				markerOffsetMinusTwo <= (others => '0');
--		
--		--(2B)  MARKER ALIGN CHECK
--		   elsif eventMarkerRisingEdge = '1' and needAlignment = '0' then	
--			   
--			--(2B.0) EVENTMARKER ALIGN CHECK
--				if counter = 4 then				--(2B.0A) EVENT ALIGNED
--				   		 
--			   else								--(2B.0B) EVENT MISALIGNED
--				    counterMisalignedEvent_sig  <= counterMisalignedEvent_sig + 1;
--					errorEventAlignment 	<= '1'; 
--			   end if;		 
--			   
--			--(2B.1) CLOCKMARKER ALIGN CHECK 
--			elsif (clockMarkerRisingEdge = '1' and resetClock = '0') then
--				if counter = 4 then				--(2B.1A) CLOCK ALIGNED
--				 	   		 
--			   else								--(2B.1B) CLOCK MISALIGNED
--
--					errorClockAlignment 	<= '1'; 	 
--					if (counter = 3) then	
--						markerOffsetMinusOne <= markerOffsetMinusOne + 1;
--					elsif (counter = 2) then
--						markerOffsetMinusTwo <=	markerOffsetMinusTwo + 1;
--					elsif (counter = 1) then
--						markerOffsetPlusTwo <= markerOffsetPlusTwo + 1;
--					elsif (counter = 0) then
--						markerOffsetPlusOne <= markerOffsetPlusOne + 1;
--					end if;
--					
--			   end if;	   
--			end if;	
--		end if;
--   end process;   	 

------------------------END-------------------------------  
end architecture_Clock40Mhz;
