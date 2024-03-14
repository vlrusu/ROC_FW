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
--      <v6>: <02/2024>: add SPILLTIMEOUT logic to drive NEWSPILL
--      <v7>: <03/2024>: update LOOPMARKER reply and control logic. USe HB_TO_EWM gate on second HB to fix PATTERN start logic.
--                       Increase SPILLTIMEOUT to ~10s. Add RX_MARKER and use for ONSPILL logic.
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
    
    END_EVM_SEEN    : out std_logic;
	HEARTBEAT_SEEN  :	out std_logic;
	--PREFETCH_SEEN	:	out std_logic;
	ONSPILL         :	out std_logic;
    NEWSPILL        :   out std_logic;
	HEARTBEAT_EVENT_WINDOW_TAG	: out std_logic_vector(EVENT_TAG_BITS-1 downto 0);
	PREFETCH_EVENT_WINDOW_TAG	: out std_logic_vector(EVENT_TAG_BITS-1 downto 0);
	TAG_LOST	                : out std_logic_vector(EVENT_TAG_BITS-1 downto 0);
	SPILL_EVENT_WINDOW_TAG		: out std_logic_vector(SPILL_TAG_BITS-1 downto 0);
    EVT_MODE                    : out std_logic_vector(31 downto 0);
    RF_MARKER                   : out std_logic_vector(7 downto 0);
	 
    -- this are single RXCLK pulses
	eventmarker	: out std_logic;
	evm_for_dreq: out std_logic;
	clockmarker : out std_logic;
	loopmarker  : out std_logic;
	othermarker : out std_logic;
	retrmarker 	: out std_logic;
	retr_seq	: out std_logic_vector(2 downto 0);

    roc_id              : in std_logic_vector(3 downto 0);   -- from DCSProcessor (assumes at least one DCS request has been sent from DTC)
    rx_loopmarker_out   : out std_logic_vector(17 downto 0);
    
    hb_lost_cnt     :  out std_logic_vector(7 downto 0);
    evm_lost_cnt    :  out std_logic_vector(7 downto 0);
    
	event_marker_count  : out std_logic_vector(31 downto 0);
	evm_for_dreq_count  : out std_logic_vector(31 downto 0);
    hb_count 	        : out std_logic_vector(31 downto 0);
    null_hb_count 	    : out std_logic_vector(31 downto 0);
    pref_count 	        : out std_logic_vector(31 downto 0);
	clock_marker_count  : out std_logic_vector(15 downto 0);
	loop_marker_count   : out std_logic_vector(15 downto 0);
	other_marker_count  : out std_logic_vector(15 downto 0);
	retr_marker_count   : out std_logic_vector(15 downto 0);
	is_skipped_dreq_cnt : out std_logic_vector(15 downto 0);
    bad_marker_cnt      : out std_logic_vector(15 downto 0);
	 
    comma_err_count     : out std_logic_vector(15 downto 0);
    rx_error_count 	    : out std_logic_vector(15 downto 0);
	seq_error_count     : out std_logic_vector(15 downto 0);
	marker_error_count  : out std_logic_vector(15 downto 0)
);
end RxPacketReader;

architecture architecture_RxPacketReader of RxPacketReader is
	
    -- these are signals 8 RXCLK wide 
	signal is_DTCpacket	: std_logic;
	signal is_dcsreq 	: std_logic;
	signal is_datareq 	: std_logic;
	signal is_heartbeat	: std_logic;
	signal is_prefetch 	: std_logic;
	signal is_loadpretag: std_logic;
    
    -- these are signals 2 RXCLK wide  
	signal is_evtmarker	    : std_logic;
	signal is_evm_for_dreq	: std_logic;
	signal is_clkmarker	    : std_logic;
	signal is_loopmarker    : std_logic;
	signal is_othermarker   : std_logic;
	signal is_retrmarker    : std_logic;
    signal is_anymarker     : std_logic;
	signal is_retrseq	    : std_logic;
    
	signal retr_seq_save    : std_logic_vector(2 downto 0);
		
	signal onspill_reg	    :	std_logic;
    signal is_firstCLKM     :   std_logic;
	signal is_firstHB       :   std_logic;
	signal is_firstDREQ     :   std_logic;
    signal is_valid_EVM     :   std_logic;
	signal tag_first_null_evt_mode   : std_logic;
    
	signal counter 		    : unsigned(2 downto 0);
	signal word_count 	    : integer range 0 to 31;
--    signal spillTimeout		: unsigned(15 downto 0);  --  corresponds to a 328 us timeout
    signal spillTimeout		: unsigned(30 downto 0);  --  corresponds to 1.3 s timeout
    
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
    
    signal hb_to_evm, hb_to_evm_reg    : std_logic;
    signal missing_hb   : std_logic;
	signal is_marker_error  : std_logic;
    
    signal link_id : std_logic_vector(2 downto 0);
    
    signal PREFETCH_SEEN        : std_logic;
    signal NULL_HEARTBEAT_SEEN  : std_logic;
    
    signal newspill_reg     : std_logic;
    signal newspill_clear   : std_logic;
    
    signal datareq_delta_cnt: unsigned(15 downto 0); 
    signal SAVE_EVM_TAG     : unsigned(15 downto 0); 
    signal EVM_TAG          : unsigned(15 downto 0); 
    signal is_loadtag       : std_logic;
    signal is_skipped_dreq  : std_logic;
    
    signal anymarker        : std_logic;
	signal  count_5in25     : unsigned(2 downto 0);    
    signal is_bad_marker    : std_logic;
    
begin
	 
    process(reset_n, aligned, clk)  
	begin
	if reset_n = '0' then
		word_count      <= 0;
		rx_we   <= '0';
		req_we  <= '0';
		rx_data_out     <= (others => '0');
		rx_error_count  <= (others => '0');
        
     	eventmarker 	<= '0';
        evm_for_dreq 	<= '0';
        clockmarker 	<= '0';
        loopmarker 	    <= '0';
        othermarker 	<= '0';
        retrmarker 	    <= '0';
        retr_seq 	    <= "000";
        
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
        
		rx_loopmarker_out   <= B"11" & X"BC3C";
        
		onspill_reg		<= '0';
        is_firstCLKM    <= '1';
        is_firstHB      <= '1';
        is_firstDREQ    <= '1';
        is_valid_EVM    <= '0';
        tag_first_null_evt_mode  <= '0';
        spillTimeout    <= (others=> '1');
        
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
        RF_MARKER                   <= (others => '0');
		HEARTBEAT_EVENT_WINDOW_TAG	<= (others => '0');	
		PREFETCH_EVENT_WINDOW_TAG	<= (others => '0');	
		
		is_marker_error	    <= '0';
		marker_error_count  <= (others => '0');
		  
		counter <= (others => '1');
		event_marker_count  <= (others => '0');
        null_hb_count       <= (others => '0');
        pref_count          <= (others => '0');
        
        evm_for_dreq_count  <= (others => '0');
		clock_marker_count  <= (others => '0');
		loop_marker_count   <= (others => '0');
		other_marker_count  <= (others => '0');
		retr_marker_count   <= (others => '0');
        is_skipped_dreq_cnt <= (others => '0');
        
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
        evm_lost_cnt    <= (others => '0');
        hb_lost_cnt     <= (others => '0');
        hb_count        <= (others => '0');
        TAG_LOST        <= (others => '0');
        
        END_EVM_SEEN    <= '0';
        hb_to_evm       <= '0';
        hb_to_evm_reg   <= '0';
        missing_hb      <= '0';
        
        newspill_reg    <= '0';
		datareq_delta_cnt <= (others => '0');
        SAVE_EVM_TAG    <= (others => '0');
        EVM_TAG         <= (others => '0');
        is_skipped_dreq <= '0';
        is_loadtag      <= '0';
        
        anymarker       <= '0';
        count_5in25     <= (others => '0');
        is_bad_marker   <= '0';
        bad_marker_cnt  <= (others => '0');
        
	elsif rising_edge(clk) then
	 
        -- re-established initial conditions for generating NEWSPILL (used in cleaning logic needed to restart data taking WITHOUT a full initialization) 
        -- by waiting for a long time ( 65535 x 25-ns clocks) in between HBs 
        -- NB: replace old way to detect first non-hull HB
        if (is_firstHB  = '0') then     spillTimeout <= spillTimeout - 1;       end if;
        if (spillTimeout = 0)  then
            NEWSPILL        <= '0'; 
            is_firstHB      <= '1';   -- re-establish condition for NEWSPILL to be issued on next DREQ w/o reset
            tag_first_null_evt_mode  <= '0';
        end if;

        -- use NEWSPILL edge to clear diagnostics counters
        newspill_reg    <= NEWSPILL;
--        newspill_clear  <=  (newspill_reg and  not NEWSPILL);  -- falling edge
        newspill_clear  <=  (not newspill_reg and  NEWSPILL);  -- rising edge. NB: it misses first first HB 
        if  newspill_clear = '1'    then
            event_marker_count<= (others => '0');
            hb_count        <= (others => '0');            
            evm_lost_cnt    <= (others => '0');
            hb_lost_cnt     <= (others => '0');
        end if;
        
        
        END_EVM_SEEN        <= '0';
		HEARTBEAT_SEEN      <= '0';
		NULL_HEARTBEAT_SEEN	<= '0';
		PREFETCH_SEEN	    <= '0';
        
        -- loopback reply marker as agreed woth Ryan on 02/28/2024
        -- require at least one DCS request to define ROC_ID
        rx_loopmarker_out   <= B"10" & X"1C9" & roc_id;  
		  
		rx_kchar_latch	<= rx_kchar_in;
		rx_kchar_prev1	<= rx_kchar_latch;
		rx_kchar_prev2	<= rx_kchar_prev1;
		rx_kchar_prev3	<= rx_kchar_prev2;
			
		rx_data_latch	<= rx_data_in;
		rx_data_prev1	<= rx_data_latch;
		rx_data_prev2	<= rx_data_prev1;
		rx_data_prev3	<= rx_data_prev2;
		  
        is_anymarker	<= (is_evtmarker or is_clkmarker or is_loopmarker or is_othermarker or is_retrmarker);
        
        -- generate pulse on falling edge of HB_TO_EVM gate  
        hb_to_evm_reg   <=  hb_to_evm;
        if (hb_to_evm_reg = '1' and hb_to_evm = '0') then    END_EVM_SEEN <= '1';    end if;
         
        if aligned = '1' then
      
        hb_lost_reg     <= hb_lost;
        evm_lost_reg    <= evm_lost;
        if (hb_lost_reg = '1')  then hb_lost <= '0';    end if;
        if (evm_lost_reg = '1') then evm_lost <= '0';   end if;
        
        -- HB_COUNT count both non-null and null HEARTBITS!
        if  HEARTBEAT_SEEN = '1'        then    hb_count <= std_logic_vector(unsigned(hb_count) + 1);           end if;
        if  NULL_HEARTBEAT_SEEN = '1'   then    hb_count <= std_logic_vector(unsigned(hb_count) + 1);           end if;
        if  NULL_HEARTBEAT_SEEN = '1'   then    null_hb_count <= std_logic_vector(unsigned(null_hb_count) + 1); end if;
        if  PREFETCH_SEEN = '1'         then    pref_count <= std_logic_vector(unsigned(pref_count) + 1);       end if;
        
        
        -- HB has been counted: add checks on EVM vs HB counter
        hb_seen_reg <= HEARTBEAT_SEEN;
        if  hb_seen_reg = '1' then
            if  hb_count > std_logic_vector(unsigned(event_marker_count)+1)   then    
                evm_lost <= '1';   
                evm_lost_cnt <= std_logic_vector(unsigned(evm_lost_cnt) + 1);  
            end if;
            if  hb_count < std_logic_vector(unsigned(event_marker_count)+1)     then    
                hb_lost<= '1';   
                hb_lost_cnt <= std_logic_vector(unsigned(hb_lost_cnt) + 1);   
            end if;
            -- save TAG of first lost event
            if  evm_lost_cnt = X"00" and hb_lost_cnt = X"00" and hb_count /= std_logic_vector(unsigned(event_marker_count)+1)   then
                TAG_LOST <= HEARTBEAT_EVENT_WINDOW_TAG;
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
        
        -- count number of 5 ns buckets in 40 MHz clock
        count_5in25 <= count_5in25 + 1;
        if  count_5in25 >= 4    then    count_5in25 <= (others => '0');    end if;
        
        is_bad_marker   <= '0';
        
        if (clockmarker = '1')  then
            if (is_firstCLKM = '1')  then
                is_firstCLKM <= '0';
            else
                count_5in25 <= (others => '0');
            end if;
        end if;
        
        -- check on marker synchronization with 40 MHz clock
        anymarker   <= not(is_firstCLKM)  and (eventmarker or clockmarker or loopmarker);
        if   (anymarker = '1'  and  count_5in25 > 0) then 
            is_bad_marker   <= '1';
            bad_marker_cnt  <= std_logic_vector(unsigned(bad_marker_cnt) + 1); 
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
                        -- clear HB_TO_EVM gate
                        hb_to_evm <= '0';
                        
                        -- count EVMs only up to FIRST null HB
						if (is_valid_EVM) then    is_evm_for_dreq <= '1';   is_valid_EVM    <= '0';  end if;
                        
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
				
        if (is_firstDREQ = '0'  and  is_datareq = '0') then
            datareq_delta_cnt <= datareq_delta_cnt + 1;
        else
            datareq_delta_cnt <= (others=> '0');
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
                    if (is_firstDREQ = '1') then    is_firstDREQ <= '0';    end if;
					is_datareq  <= '1';
                    is_loadtag  <= '1';
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
                    spillTimeout    <= (others=> '1');
                            
					if (word_count = 3) then 	HEARTBEAT_EVENT_WINDOW_TAG(15 downto 0)  <= rx_data_prev3; end if;
					if (word_count = 4) then 	HEARTBEAT_EVENT_WINDOW_TAG(31 downto 16) <= rx_data_prev3; end if;
					if (word_count = 5) then 	HEARTBEAT_EVENT_WINDOW_TAG(47 downto 32) <= rx_data_prev3; end if;
                    if (word_count = 6) then 	EVT_MODE(15 downto 0)  <= rx_data_prev3;  end if;
                    if (word_count = 7) then 	EVT_MODE(31 downto 16) <= rx_data_prev3;  end if;
					-- delay HEARTBEAT_SEEN until ONSPILL and EVTMODE have been determined
					if (word_count = 8)	then	
                        RF_MARKER   <= rx_data_prev3(15 downto 8);
                        ONSPILL     <= rx_data_prev3(0);
						if (unsigned(EVT_MODE) > 0) then
                            SPILL_EVENT_WINDOW_TAG 	<= std_logic_vector(unsigned(SPILL_EVENT_WINDOW_TAG) + 1);
                        end if;
                        
                        -- ONSPILL logic DOES not seem to work for now (03/25/23): MT comments any use
						onspill_reg <= ONSPILL; 
					end if;
					-- restart SPILL_EVENT_WINDOW_TAG on ONSPILL rising edge
                    -- MT 07/20/23: use NEWSPILL for now
					if (word_count = 9)	then 	
                        is_heartbeat <= '0';
                        if (unsigned(EVT_MODE) > 0) then -- differentiate non_null from null HB
                            HEARTBEAT_SEEN  <= '1'; 
                            is_valid_EVM    <= '1';  -- start gate for EWM after any non-null HB
                            
                            if (is_firstHB = '1') then    
                                is_firstHB  <= '0';
                                NEWSPILL    <= '1'; 
--                                SPILL_EVENT_WINDOW_TAG	<= X"00001";
                                SPILL_EVENT_WINDOW_TAG	<= X"00000";
                            else
                                -- gate from HB to EWM, skipping first
                                hb_to_evm <= '1';  
                            end if;
                        else  -- must be NULL HB! Tag FIRST non-null HB to issue one last HB_TO_EVM gate and send one last EVM to external logic
                            NULL_HEARTBEAT_SEEN <= '1';
                            if (tag_first_null_evt_mode = '0') then  -- start gate for last EWM after first null HB after  
                                tag_first_null_evt_mode  <= '1';
                                is_valid_EVM    <= '1';
                                hb_to_evm       <= '1'; 
                            end if;
                        end if;
                        
                        -- drive NEWSPILL with ONSPILL: NEWSPILL becomes pulse....
                        -- if (ONSPILL and not onspill_reg) then NEWSPILL <= '1'; 
                        
					end if;
				end if; -- end if (is_heartbeat = '1')
						
				if (is_loadpretag = '1') then
					if (word_count = 3)     then 	PREFETCH_EVENT_WINDOW_TAG(15 downto 0)  <= rx_data_prev3; end if;
					if (word_count = 4) 	then 	PREFETCH_EVENT_WINDOW_TAG(31 downto 16) <= rx_data_prev3; end if;
					if (word_count = 5) 	then 	PREFETCH_EVENT_WINDOW_TAG(47 downto 32) <= rx_data_prev3; PREFETCH_SEEN <= '1'; end if;
					if (word_count = 6)	    then	is_loadpretag <= '0';	end if;
				end if;
					 
				if (is_loadtag = '1') then
					if (word_count = 1)     then 	is_skipped_dreq <= '0';     end if;
					if (word_count = 2)     then 	SAVE_EVM_TAG <= EVM_TAG;    end if;
                    if (word_count = 3)     then 	EVM_TAG <= unsigned(rx_data_prev3);   end if;
					if (word_count = 6)	    then	is_loadtag <= '0';	        end if;
					if (word_count = 8)     then 	
                        if  EVM_TAG  = (SAVE_EVM_TAG+1)     then  
                            is_skipped_dreq <= '0';     
                        else  
                            is_skipped_dreq     <= '1'; 
                            is_skipped_dreq_cnt <=  std_logic_vector(unsigned(is_skipped_dreq_cnt) + 1);   
                        end if;
                    end if;
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
