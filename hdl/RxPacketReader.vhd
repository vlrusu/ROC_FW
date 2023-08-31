--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: RxPacketReader.vhd
-- File history:
--      <v1>: <2021>: Decode DTC packets and separate DCS Requests from Data Requests
--      <v2>: <02/2022>: Add Prefetch to Data Requests
--		<v3>: <08/2022>: Add DCS Block Write to DTC Packet definition
--      <v4>: <07/2023>: have first null HB to reset is_firstHB=1
--      <v5>: <09/2023>: add logic to drive loopback marker back to fiber via RxMarkerFifo
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
use IEEE.numeric_std.all;

library work;
use work.algorithm_constants.all; 

entity RxPacketReader is
port (	   
	reset_n : in std_logic;
	clk     : in std_logic;
    
	aligned : in std_logic;
    
	rx_data_in  : in std_logic_vector(15 downto 0);
	rx_kchar_in : in std_logic_vector(1 downto 0);
		
	rx_we       : out std_logic;
	rx_data_out : out std_logic_vector(15 downto 0);
		
	req_we      : out std_logic;
	 
	HEARTBEAT_SEEN	    :	out std_logic;
	NULL_HEARTBEAT_SEEN	:	out std_logic;
	PREFETCH_SEEN	    :	out std_logic;
	ONSPILL			    :	out std_logic;
    NEWSPILL            :  out std_logic;
	HEARTBEAT_EVENT_WINDOW_TAG	: out std_logic_vector(EVENT_TAG_BITS-1 downto 0);
	PREFETCH_EVENT_WINDOW_TAG	: out std_logic_vector(EVENT_TAG_BITS-1 downto 0);
	TAG_LOST	                : out std_logic_vector(EVENT_TAG_BITS-1 downto 0);
	SPILL_EVENT_WINDOW_TAG		: out std_logic_vector(SPILL_TAG_BITS-1 downto 0);
    EVT_MODE                    : out std_logic_vector(31 downto 0);
	 
	eventmarker	: out std_logic;
	evm_for_dreq: out std_logic;
	clockmarker : out std_logic;
	loopmarker  : out std_logic;
	othermarker : out std_logic;
	retrmarker 	: out std_logic;
	retr_seq	: out std_logic_vector(2 downto 0);

	marker_wen 	    : out std_logic;
    rx_marker_out   : out std_logic_vector(17 downto 0);
    
	event_marker_count  : out std_logic_vector(15 downto 0);
	evm_for_dreq_count  : out std_logic_vector(31 downto 0);
    hb_count 	        : out std_logic_vector(15 downto 0);
	clock_marker_count  : out std_logic_vector(15 downto 0);
	loop_marker_count   : out std_logic_vector(15 downto 0);
	other_marker_count  : out std_logic_vector(15 downto 0);
	retr_marker_count   : out std_logic_vector(15 downto 0);
	 
    comma_err_count     : out std_logic_vector(15 downto 0);
    rx_error_count 	    : out std_logic_vector(15 downto 0);
	seq_error_count     : out std_logic_vector(15 downto 0);
	marker_error_count  : out std_logic_vector(15 downto 0)
);
end RxPacketReader;

architecture architecture_RxPacketReader of RxPacketReader is
		
	signal is_DTCpacket	: std_logic;
	signal is_dcsreq 	: std_logic;
	signal is_datareq 	: std_logic;
	signal is_heartbeat	: std_logic;
	signal is_prefetch 	: std_logic;
	signal is_loadpretag: std_logic;
		
	signal is_evtmarker	    : std_logic;
	signal is_evm_for_dreq	: std_logic;
	signal is_clkmarker	    : std_logic;
	signal is_loopmarker    : std_logic;
	signal is_othermarker   : std_logic;
	signal is_retrmarker    : std_logic;
    signal is_anymarker     : std_logic;
	signal is_retrseq	    : std_logic;
	signal retr_seq_save    : std_logic_vector(2 downto 0);
	signal is_marker_error  : std_logic;
		
	signal onspill_old	    :	std_logic;
	signal is_firstHB       :   std_logic;
    signal is_valid_EWM     :   std_logic;
	signal is_non_null_HB   : std_logic;
    
	signal counter 		    : unsigned(2 downto 0);
	signal nullHB_counter   : unsigned(7 downto 0);
	signal word_count 	    : integer range 0 to 31;
	 
	signal seq_num 			: unsigned(2 downto 0);
	signal seq_num_expected	: unsigned(2 downto 0);
	 
	signal rx_data_latch : std_logic_vector(15 downto 0);
	signal rx_kchar_latch: std_logic_vector(1 downto 0);
	signal rx_data_prev1 : std_logic_vector(15 downto 0);
	signal rx_kchar_prev1: std_logic_vector(1 downto 0);
	signal rx_data_prev2 : std_logic_vector(15 downto 0);
	signal rx_kchar_prev2: std_logic_vector(1 downto 0);
	signal rx_data_prev3 : std_logic_vector(15 downto 0);
	signal rx_kchar_prev3: std_logic_vector(1 downto 0);

    -- for diagnostics to ErrorCounter
	signal rx_error_seen : std_logic;
	signal rx_comma_seen : std_logic;
    
    signal evm_lost, evm_lost_reg   : std_logic;
    signal hb_lost, hb_lost_reg     : std_logic;
    signal hb_seen_reg   : std_logic;
    
begin
	 
    process(reset_n, aligned, clk)  
	begin
	if reset_n = '0' then
		word_count      <= 0;
		rx_error_count  <= (others => '0');
		rx_we   <= '0';
		rx_data_out     <= (others => '0');
		req_we  <= '0';
			
		is_DTCpacket 	<= '0';
		is_dcsreq		<= '0';
		is_datareq		<= '0';
		is_heartbeat	<= '0';
		is_prefetch		<= '0';
		is_loadpretag	<= '0';
		is_evtmarker	<= '0';
        is_evm_for_dreq <= '0';
		is_clkmarker	<= '0';
		is_loopmarker	<= '0';
		is_othermarker	<= '0';
		is_retrmarker	<= '0';
        is_anymarker	<= '0';	
        is_retrseq		<= '0';
        
        marker_wen      <= '0';
		rx_marker_out   <= B"11" & X"BC3C";
        
		onspill_old		<= '0';
        is_firstHB      <= '1';
        is_valid_EWM    <= '0';
        is_non_null_HB  <= '0';
        
		retr_seq			<= (others=> '0');
		retr_seq_save	    <= (others=> '0');
		seq_num 			<= (others => '0');
		seq_num_expected 	<= (others => '0');
		seq_error_count 	<= (others => '0');
		
		HEARTBEAT_SEEN	    <= '0';
		NULL_HEARTBEAT_SEEN	<= '0';
		PREFETCH_SEEN	    <= '0';
		ONSPILL			    <= '0';
		NEWSPILL			<= '0';
		SPILL_EVENT_WINDOW_TAG	    <= (others => '0');	
        EVT_MODE                    <= (others => '0');
		HEARTBEAT_EVENT_WINDOW_TAG	<= (others => '0');	
		PREFETCH_EVENT_WINDOW_TAG	<= (others => '0');	
		
		is_marker_error	    <= '0';
		marker_error_count  <= (others => '0');
		  
		counter <= (others => '1');
		nullHB_counter      <= (others => '0');
		event_marker_count  <= (others => '0');
        evm_for_dreq_count  <= (others => '0');
		clock_marker_count  <= (others => '0');
		loop_marker_count   <= (others => '0');
		other_marker_count  <= (others => '0');
		retr_marker_count   <= (others => '0');
        
		rx_kchar_prev1 	<= (others => '0');
		rx_data_prev1 	<= (others => '0');
		rx_kchar_prev2 	<= (others => '0');
		rx_data_prev2 	<= (others => '0');
		rx_kchar_prev3 	<= (others => '0');
		rx_data_prev3 	<= (others => '0');
        
        rx_error_seen   <= '0';
        rx_comma_seen   <= '0';
		comma_err_count <= (others => '0');
        
        evm_lost        <= '0';
        hb_lost         <= '0';
        hb_count        <= (others => '0');
        TAG_LOST        <= (others => '0');
     
	elsif rising_edge(clk) then
	 
		HEARTBEAT_SEEN      <= '0';
		NULL_HEARTBEAT_SEEN	<= '0';
		PREFETCH_SEEN	    <= '0';
		  
		rx_kchar_latch	<= rx_kchar_in;
		rx_kchar_prev1	<= rx_kchar_latch;
		rx_kchar_prev2	<= rx_kchar_prev1;
		rx_kchar_prev3	<= rx_kchar_prev2;
			
		rx_data_latch	<= rx_data_in;
		rx_data_prev1	<= rx_data_latch;
		rx_data_prev2	<= rx_data_prev1;
		rx_data_prev3	<= rx_data_prev2;
		  
        is_anymarker	<= (is_evtmarker or is_clkmarker or is_loopmarker or is_othermarker or is_retrmarker);
        
        marker_wen      <= is_loopmarker;
        rx_marker_out   <= rx_kchar_prev3 & rx_data_prev3;
        
        if aligned = '1' then
      
        hb_lost_reg     <= hb_lost;
        evm_lost_reg    <= evm_lost;
        if (hb_lost_reg = '1')  then hb_lost <= '0';    end if;
        if (evm_lost_reg = '1') then evm_lost <= '0';   end if;
        
        hb_seen_reg <= HEARTBEAT_SEEN;
        
        -- add check of EVM vs HB counter
        if  HEARTBEAT_SEEN = '1'    then 
            hb_count <= std_logic_vector(unsigned(hb_count) + 1);
        end if;
        if  hb_seen_reg = '1' then
            if  hb_count > std_logic_vector(unsigned(event_marker_count)+1)   then    
                hb_lost <= '1';
            end if;
        end if;
            
        -- mark start and end of a DTC packet, including possible embedded markers
		if  rx_kchar_in = "10" and rx_data_in(15 downto 8) = X"1C" and 
			(   rx_data_in(4 downto 0) = B"00000" or    --  DCS Request 
                rx_data_in(4 downto 0) = B"00001" or    --  Hearbeat
                rx_data_in(4 downto 0) = B"00010" or    --  Data Request
                rx_data_in(4 downto 0) = B"00011" or    -- Prefecth
                rx_data_in(4 downto 0) = B"00111") then    -- DCS Request Additional Block Write
			is_DTCpacket <= '1';
		elsif (rx_kchar_in = "11" and rx_data_in = X"BC3C") then
            is_DTCpacket <= '0';
		end if;
        
		if counter = 0 then 	-- for double markers: COUNTER is reset on second word seen
			if (is_evtmarker = '1') then	
				eventmarker     <= '1'; 	
                
                if  evm_lost = '0'    and    event_marker_count /= std_logic_vector(unsigned(hb_count)-1)   then    
                    evm_lost <= '1';
                    TAG_LOST <= HEARTBEAT_EVENT_WINDOW_TAG;
                end if;                
 			end if;
			if (is_evm_for_dreq = '1') then	
				evm_for_dreq    <= '1'; 	
			end if;
			if (is_clkmarker = '1') then 	
				clockmarker     <= '1'; 	
			end if;
			if (is_loopmarker = '1') then	
				loopmarker      <= '1'; 	
			end if;
			if (is_othermarker = '1') then	
				othermarker     <= '1'; 	
			end if;
		end if;
        
		if counter = 1 then	-- for retransmission (triple marker)
			if (is_retrmarker) then 	
				retrmarker 	    <= '1'; 
				--is_retrmarker	<= '0'; 	
				retr_seq 	    <= retr_seq_save;
				retr_seq_save	<= (others=> '0');
				--retr_marker_count   <= std_logic_vector(unsigned(retr_marker_count) + 1);
			end if;
            
            -- clear double markers
            -- Generate single clock markers and count each of them
            if  eventmarker = '1'   then
				eventmarker     <= '0'; 	
				is_evtmarker    <= '0'; 	
				event_marker_count  <= std_logic_vector(unsigned(event_marker_count) + 1);
            end if;
            if  evm_for_dreq = '1'   then
				evm_for_dreq    <= '0'; 	
				is_evm_for_dreq <= '0'; 	
				evm_for_dreq_count  <= std_logic_vector(unsigned(evm_for_dreq_count) + 1);
            end if;
            if  clockmarker = '1'   then
				clockmarker     <= '0'; 	
				is_clkmarker    <= '0'; 	
				clock_marker_count  <= std_logic_vector(unsigned(clock_marker_count) + 1);
            end if;
            if  loopmarker = '1'   then
				loopmarker      <= '0'; 	
				is_loopmarker   <= '0'; 	
				loop_marker_count   <= std_logic_vector(unsigned(loop_marker_count) + 1);
            end if;
            if  othermarker = '1'   then
				othermarker     <= '0'; 	
				is_othermarker  <= '0'; 	
				other_marker_count  <= std_logic_vector(unsigned(other_marker_count) + 1);
            end if;
            
		end if;
        
        -- clear triple markers
		if counter = 2 then	
            if  retrmarker = '1'   then
				retrmarker     <= '0'; 	
				is_retrmarker  <= '0'; 	
				retr_marker_count   <= std_logic_vector(unsigned(retr_marker_count) + 1);
            end if;
        end if;
        
		-- COUNTER starts at "111" so it will fail this at the very beginning 
		if counter < 5 then
			counter <= counter + 1;
		else	
      -- use PREV1 and PREV2 to decode (double) markers 
			if rx_kchar_prev2 = "10" then
				if rx_kchar_prev1 = "10" then
					if (rx_data_prev2 = X"1C10" and rx_data_prev1 = X"1CEF") then
						counter <= (others => '0');
                        -- count free running EVM
                        is_evtmarker    <= '1';
						if (is_valid_EWM) then   -- count EVMs only up to FIRST null HB 
                            is_evm_for_dreq <= '1';
                            is_valid_EWM    <= '0';
                        end if;
					elsif (rx_data_prev2 = X"1C11" and rx_data_prev1 = X"1CEE") then
						counter <= (others => '0');
						is_clkmarker <= '1';
					elsif (rx_data_prev2 = X"1C12" and rx_data_prev1 = X"1CED") then
						counter         <= (others => '0');
						is_loopmarker   <= '1';
					elsif ( (rx_data_prev2 = X"1C13" and rx_data_prev1 = X"1CEC") or
                            (rx_data_prev2 = X"1C14" and rx_data_prev1 = X"1CEB")) then
						counter <= (others => '0');
						is_othermarker <= '1';
					elsif (rx_data_prev2 = X"1C15" and rx_data_prev1 = X"1CEA") then
						counter <= (others => '0');
						is_retrseq <= '1';
					else
                    -- this is true at the beginning of any DTC packet: recognize and skip this case
					---- skip case of marker right after first DTC packet word (but it will also skip finding errors if marker is in the middle of a packet )
					---- Still OK because it will be caught later by DCS/DREQProcessor either as CRC error or RX_packet error or both!
						if (is_DTCpacket = '0') then	
							is_marker_error	<= '1';
						end if;
					end if;
				end if; 	-- if rx_kchar_prev1 = "10" 
			end if; 		-- if rx_kchar_prev2 = "10" 
		end if;			-- if counter < 5 
        
   		-- clear error when marker is re-established
		if (is_marker_error <= '1' and rx_kchar_prev2 = "11" and rx_kchar_prev1 = "11") then
			is_marker_error <= '0';
            marker_error_count <= std_logic_vector(unsigned(marker_error_count) + 1);
		end if;
        
		-- finish retransmission marker decoding by checking on sequence request 
		-- Must be outside of previous IF because counter=0 at this point
		if(is_retrseq = '1' and rx_data_prev2 = X"1CEA") then 
			if(rx_data_prev1(7 downto 4) 	= rx_data_prev1(3 downto 0) and  
				rx_data_prev1(11 downto 8) = rx_data_prev1(3 downto 0) and 
				rx_data_prev1(15 downto 12)= rx_data_prev1(3 downto 0) ) 	then
                is_retrseq 	<= '0';
                is_retrmarker 	<= '1';
                retr_seq_save	<= rx_data_prev1(2 downto 0);
			else
                is_retrseq 	<= '0';
                is_marker_error	<= '1';
                if (is_marker_error = '0') then	marker_error_count <= std_logic_vector(unsigned(marker_error_count) + 1);	end if;
			end if;
		end if;
				
      
		-- start and end of decoding DTC packet using PREV3 with look-ahead knowledge about incoming markers
		if (is_evtmarker = '0' and is_clkmarker = '0' and is_loopmarker = '0' and is_othermarker = '0' and is_retrseq = '0' and is_retrmarker = '0') then
			if word_count = 0 then
				is_dcsreq	<= '0';
				is_datareq	<= '0';
                is_prefetch	<= '0';
                req_we      <= '0';
                rx_we       <= '0';
                rx_comma_seen   <= '0';
                rx_error_seen   <= '0';
				if rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and 
                    (  rx_data_prev3(4 downto 0) = B"00000"  or rx_data_prev3(4 downto 0) = B"00111" ) then  -- DCS Request packet or additional REquest
					word_count  <= word_count + 1;
					is_dcsreq   <= '1';
					rx_we       <= '1';
					rx_data_out <= rx_data_prev3;
					seq_num     <= unsigned(rx_data_prev3(7 downto 5));
				elsif rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and rx_data_prev3(4 downto 0) = B"00010" then -- Data Request
					word_count  <= word_count + 1;
					is_datareq  <= '1';
					req_we      <= '1';
					rx_data_out <= rx_data_prev3;
					seq_num     <= unsigned(rx_data_prev3(7 downto 5));
				elsif rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and rx_data_prev3(4 downto 0) = B"00001" then	-- Heartbeat
					word_count  <= word_count + 1;
					is_heartbeat<= '1';
					seq_num     <= unsigned(rx_data_prev3(7 downto 5));
				elsif rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and rx_data_prev3(4 downto 0) = B"00011" then	-- Prefetch
					word_count  <= word_count + 1;
					is_prefetch	<= '1';
					is_loadpretag  <= '1';
					req_we      <= '1';
					rx_data_out <= rx_data_prev3;
					seq_num     <= unsigned(rx_data_prev3(7 downto 5));
				end if;
                
			else    -- word_count > 0: must have found one of the RX_KCHAR_PREV3 conditions listed above
                
				word_count <= word_count + 1;
				rx_data_out <= rx_data_prev3;
                
                -- check on request SEQUENCE NUMBER... there might be an error at the beginning if no DTC_Reset issued
				if (word_count =1) then
					if( seq_num_expected /= seq_num) then	seq_error_count <= std_logic_vector(unsigned(seq_error_count) + 1);	end if;
					seq_num_expected <= seq_num + 1;
				end if;
					 
				-- set WE for either DCS packet input FIFO or Data Request input FIFO
				if (is_dcsreq = '1') then 
					rx_we <= '1';
				elsif (is_datareq = '1' or is_prefetch = '1') then
					req_we <= '1';
				end if;
                
				-- save EWTag and Event Mode for heartbeat packet or Prefecth packet
				if (is_heartbeat = '1') then
					if (word_count = 3) then 	HEARTBEAT_EVENT_WINDOW_TAG(15 downto 0)  <= rx_data_prev3; end if;
					if (word_count = 4) then 	HEARTBEAT_EVENT_WINDOW_TAG(31 downto 16) <= rx_data_prev3; end if;
					if (word_count = 5) then 	HEARTBEAT_EVENT_WINDOW_TAG(47 downto 32) <= rx_data_prev3; end if;
                    if (word_count = 6) then 	EVT_MODE(15 downto 0)  <= rx_data_prev3;  end if;
                    if (word_count = 7) then 	EVT_MODE(31 downto 16) <= rx_data_prev3;  end if;
					-- delay HEARTBEAT_SEEN until ONSPILL and EVTMODE have been determined
					if (word_count = 8)	then	
						if (unsigned(EVT_MODE) > 0) then
                            SPILL_EVENT_WINDOW_TAG 	<= std_logic_vector(unsigned(SPILL_EVENT_WINDOW_TAG) + 1);
                        end if;
                        -- ONSPILL logic DOES not seem to work for now (03/25/23): MT comments any use
						onspill_old <= ONSPILL; 
                        ONSPILL <= rx_data_prev3(0); 
					end if;
					-- restart SPILL_EVENT_WINDOW_TAG on ONSPILL rising edge
                    -- MT 07/20/23: use NEWSPILL for now
					if (word_count = 9)	then 	
                        is_heartbeat <= '0';
                        if (unsigned(EVT_MODE) > 0) then -- differentiate non_null from null HB
                            HEARTBEAT_SEEN  <= '1'; 
                            is_valid_EWM    <= '1';  -- start gate for EWM after any non-null HB
                            is_non_null_HB  <= '1';
                            if (is_firstHB = '1') then    
                                NEWSPILL    <= '1'; 
                                SPILL_EVENT_WINDOW_TAG	<= X"00001";
                                is_firstHB  <= '0'; 
                                nullHB_counter <= (others => '0'); 
                            --else  
                                --NEWSPILL <= '0';  
                            end if;
                        else  -- must be NULL HB!
                            if (is_non_null_HB = '1') then  -- start gate for last EWM after first null HB after  
                                is_valid_EWM    <= '1';
                                is_non_null_HB  <= '0';
                                NEWSPILL        <= '0';   -- clear NEWSPIL if only 1 non-null DREQ is requested 
                                is_firstHB      <= '1';   -- re-establish condition for NEWSPILL to be issued on next DREQ w/o reset
                            else
                                is_valid_EWM    <= '0';
                            end if;
                            NULL_HEARTBEAT_SEEN <= '1';
                            nullHB_counter <= nullHB_counter + 1;
                        end if;
                        -- reset local EWTag counter condition
						--if ( onspill_old = '0' and ONSPILL = '1' ) then 
							--SPILL_EVENT_WINDOW_TAG	<= X"00001";
						--end if;
					end if;
				end if; -- end if (is_heartbeat = '1')
						
				if (is_loadpretag = '1') then
					if (word_count = 3)     then 	PREFETCH_EVENT_WINDOW_TAG(15 downto 0)  <= rx_data_prev3; end if;
					if (word_count = 4) 	then 	PREFETCH_EVENT_WINDOW_TAG(31 downto 16) <= rx_data_prev3; end if;
					if (word_count = 5) 	then 	PREFETCH_EVENT_WINDOW_TAG(47 downto 32) <= rx_data_prev3; PREFETCH_SEEN <= '1'; end if;
					if (word_count = 6)	    then	is_loadpretag <= '0';	end if;
				end if;
					 
                -- catch if COMMA shows up in the middle of a packet 
                if  rx_kchar_prev3 = "11" and rx_data_prev3 = X"BC3C"    then 
                    comma_err_count  <= std_logic_vector(unsigned(comma_err_count) + 1);	
                    rx_comma_seen   <= '1';
                end if;
                    
                -- catch if KCHAR shows up in the middle of a packet (unless valid marker)
				if rx_kchar_prev3 = "10"    then	
                    rx_error_count  <= std_logic_vector(unsigned(rx_error_count) + 1);	
                    rx_error_seen   <= '1';
                end if;
				
				if word_count = 9 then
					word_count  <= 0;
				end if;
				
			end if; 	-- if word_count = 0 
            
        else    -- a marker is detected. Stop writing to RXPacket FIFOs, even if we are in the middle of it
            req_we      <= '0';
            rx_we       <= '0';
		end if;         -- if not marker
        
 		end if; 		-- if aligned = '1'
	end if;			    -- if rising_edge(clk) 
	end process;

   -- architecture body
end architecture_RxPacketReader;
