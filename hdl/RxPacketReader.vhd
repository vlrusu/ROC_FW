--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: RxPacketReader.vhd
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
use IEEE.numeric_std.all;

entity RxPacketReader is
port (
	reset_n : in std_logic;
	clk : in std_logic;
    
	aligned : in std_logic;
    
	rx_data_in : in std_logic_vector(15 downto 0);
	rx_kchar_in : in std_logic_vector(1 downto 0);
		
	rx_we : out std_logic;
	rx_data_out : out std_logic_vector(15 downto 0);
		
	req_we : out std_logic;
	 
	HEARTBEAT_EVENT_WINDOW_TAG: out std_logic_vector(47 downto 0);
	PREFETCH_EVENT_WINDOW_TAG	: out std_logic_vector(47 downto 0);
	 
	eventmarker	: out std_logic;
	clockmarker : out std_logic;
	loopmarker 	: out std_logic;
	othermarker : out std_logic;
	retrmarker 	: out std_logic;
	retr_seq		: out std_logic_vector(2 downto 0);
	event_marker_count : out std_logic_vector(15 downto 0);
	 
	rx_error_count 	: out std_logic_vector(15 downto 0);
	seq_error_count 	: out std_logic_vector(15 downto 0);
	marker_error_count: out std_logic_vector(15 downto 0)

);
end RxPacketReader;

architecture architecture_RxPacketReader of RxPacketReader is
		
	signal is_DTCpacket : std_logic;
	signal is_dcsreq 		: std_logic;
	signal is_datareq 	: std_logic;
	signal is_heartbeat : std_logic;
	signal is_prefetch 	: std_logic;
		
	signal is_evtmarker : std_logic;
	signal is_clkmarker : std_logic;
	signal is_loopmarker: std_logic;
	signal is_othermarker: std_logic;
	signal is_retrmarker: std_logic;
	signal is_retrseq : std_logic;
	signal retr_seq_save	: std_logic_vector(2 downto 0);
	signal is_marker_error : std_logic;
	 
	signal counter 		: unsigned(2 downto 0);
	signal word_count 	: integer range 0 to 31;
	 
	signal seq_num 			: unsigned(2 downto 0);
	signal seq_num_expected: unsigned(2 downto 0);
	 
	signal rx_data_latch : std_logic_vector(15 downto 0);
	signal rx_kchar_latch: std_logic_vector(1 downto 0);
	signal rx_data_prev1 : std_logic_vector(15 downto 0);
	signal rx_kchar_prev1: std_logic_vector(1 downto 0);
	signal rx_data_prev2 : std_logic_vector(15 downto 0);
	signal rx_kchar_prev2: std_logic_vector(1 downto 0);
	signal rx_data_prev3 : std_logic_vector(15 downto 0);
	signal rx_kchar_prev3: std_logic_vector(1 downto 0);
	 
begin
	 
	process(reset_n, clk)  
	begin
	if reset_n = '0' then
		word_count <= 0;
		rx_error_count <= (others => '0');
		rx_we <= '0';
		rx_data_out <= (others => '0');
		req_we <= '0';
			
		is_DTCpacket 	<= '0';
		is_dcsreq		<= '0';
		is_datareq		<= '0';
		is_evtmarker	<= '0';
		is_clkmarker	<= '0';
		is_loopmarker	<= '0';
		is_othermarker	<= '0';
		is_retrmarker	<= '0';
		is_retrseq		<= '0';
	
		retr_seq		<= (others=> '0');
		retr_seq_save<= (others=> '0');
		seq_num <= (others => '0');
		seq_num_expected <= (others => '0');
		seq_error_count <= (others => '0');
		
		is_marker_error	<= '0';
		marker_error_count	 <= (others => '0');
		  
		counter <= (others => '1');
		event_marker_count <= (others => '0');
		  
		rx_kchar_latch <= (others => '0');
		rx_data_latch 	<= (others => '0');
		rx_kchar_prev1 <= (others => '0');
		rx_data_prev1 	<= (others => '0');
		rx_kchar_prev2 <= (others => '0');
		rx_data_prev2 	<= (others => '0');
		rx_kchar_prev3 <= (others => '0');
		rx_data_prev3 	<= (others => '0');
			
	elsif rising_edge(clk) then
		rx_we <= '0';
		req_we <= '0';		  
		  
		rx_kchar_latch	<= rx_kchar_in;
		rx_kchar_prev1	<= rx_kchar_latch;
		rx_kchar_prev2	<= rx_kchar_prev1;
		rx_kchar_prev3	<= rx_kchar_prev2;
			
		rx_data_latch	<= rx_data_in;
		rx_data_prev1	<= rx_data_latch;
		rx_data_prev2	<= rx_data_prev1;
		rx_data_prev3	<= rx_data_prev2;
		  
		is_heartbeat	<= '0';
		is_prefetch	<= '0';
		eventmarker 	<= '0';
		clockmarker 	<= '0';
		loopmarker 	<= '0';
		othermarker	<= '0';
		retrmarker 	<= '0';
		
		if aligned = '1' then
		
		if (rx_kchar_in = "10" and rx_data_in(15 downto 8) = X"1C" and 
			(rx_data_in(4 downto 0) = B"00000" or rx_data_in(4 downto 0) = B"00001" or rx_data_in(4 downto 0) = B"00010" or rx_data_in(4 downto 0) = B"00011")) then
			is_DTCpacket <= '1';
		else if (rx_kchar_in = "11" and rx_data_in = X"BC3C") then
			is_DTCpacket <= '0';
		end if;
		  
		-- clear error whem marker is re-established
		if (rx_kchar_prev2 = "11" and rx_kchar_prev1 = "11") then
			is_marker_error <= '0';
		end if;
	 		  
		if counter = 1 then 	-- for double markers
			if (is_evtmarker = '1') then	
				eventmarker <= '1'; 	
				is_evtmarker <= '0'; 	
				event_marker_count <= std_logic_vector(unsigned(event_marker_count) + 1);
			end if;
			if (is_clkmarker = '1') then 	
				clockmarker <= '1'; 	
				is_clkmarker <= '0'; 	
				event_marker_count <= std_logic_vector(unsigned(event_marker_count) + 1);
			end if;
			if (is_loopmarker = '1') then	
				loopmarker <= '1'; 	
				is_loopmarker <= '0'; 	
				eventmarker <= '1'; 	
				event_marker_count <= std_logic_vector(unsigned(event_marker_count) + 1);
			end if;
			if (is_othermarker = '1') then	
				othermarker <= '1'; 	
				is_othermarker <= '0'; 	
				event_marker_count <= std_logic_vector(unsigned(event_marker_count) + 1);
			end if;
		end if;
		if counter = 2 then	-- for retransmission (triple marker)
			if (is_retrmarker) then 	
				retrmarker 	<= '1'; 
				is_retrmarker	<= '0'; 	
				retr_seq 	<= retr_seq_save;
				retr_seq_save	<= (others=> '0');
				event_marker_count <= std_logic_vector(unsigned(event_marker_count) + 1);
			end if;
		end if;

		
		if counter < 5 then
			counter <= counter + 1;
		else	-- start (double) markers decoding
			if rx_kchar_prev2 = "10" then
				if rx_kchar_prev1 = "10" then
					if (rx_data_prev2 = X"1C10" and rx_data_prev1 = X"1CEF") then
						counter <= (others => '0');
						is_evtmarker <= '1';
					elsif (rx_data_prev2 = X"1C11" and rx_data_prev1 = X"1CEE") then
						counter <= (others => '0');
						is_clkmarker <= '1';
					elsif (rx_data_prev2 = X"1C12" and rx_data_prev1 = X"1CED") then
						counter <= (others => '0');
						is_loopmarker <= '1';
					elsif ((rx_data_prev2 = X"1C13" and rx_data_prev1 = X"1CEC") or
							 (rx_data_prev2 = X"1C14" and rx_data_prev1 = X"1CEB")) then
						counter <= (others => '0');
						is_othermarker <= '1';
					elsif (rx_data_prev2 = X"1C15" and rx_data_prev1 = X"1CEA") then
						counter <= (others => '0');
						is_retrseq <= '1';
					else
					-- skip case of marker right after first DTC packet word (but it will also skip finding errors if marker is in the middle of a packet )
					-- Still OK because it will be caught later by DCS/DREQProcessor either as CRC error or RX_packer error or both!
						if (is_DTCpacket = '0') then	
							is_marker_error	<= '1';
							if (is_marker_error = '0') then	marker_error_count <= std_logic_vector(unsigned(marker_error_count) + 1);	end if;
						end if;
					end if;
				end if; 	-- if rx_kchar_prev1 = "10" 
			end if; 		-- if rx_kchar_prev2 = "10" 
		end if;			-- if counter < 5 
					
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
					is_marker_error	<= '1';
					if (is_marker_error = '0') then	marker_error_count <= std_logic_vector(unsigned(marker_error_count) + 1);	end if;
					is_retrseq 	<= '0';
			end if;
		end if;
				
		-- decode start of packet AFTER marker has had change to be decoded
		if (is_evtmarker = '0' and is_clkmarker = '0' and is_loopmarker = '0' and is_othermarker = '0' and is_retrseq = '0' and is_retrmarker = '0') then
			if word_count = 0 then
				is_dcsreq	<= '0';
				is_datareq	<= '0';
				if rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and rx_data_prev3(4 downto 0) = B"00000" then  -- DCS packet
					word_count <= word_count + 1;
					is_dcsreq <= '1';
					rx_we <= '1';
					rx_data_out <= rx_data_prev3;
					seq_num <= unsigned(rx_data_prev3(7 downto 5));
				elsif rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and rx_data_prev3(4 downto 0) = B"00010" then -- Data Request
					word_count <= word_count + 1;
					is_datareq <= '1';
					req_we <= '1';
					rx_data_out <= rx_data_prev3;
					seq_num <= unsigned(rx_data_prev3(7 downto 5));
				elsif rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and rx_data_prev3(4 downto 0) = B"00001" then	-- Heartbeat
					word_count <= word_count + 1;
					is_heartbeat	<= '1';
					seq_num <= unsigned(rx_data_prev3(7 downto 5));
				elsif rx_kchar_prev3 = "10" and rx_data_prev3(15 downto 8) = X"1C" and rx_data_prev3(4 downto 0) = B"00011" then	-- Prefetch
					word_count <= word_count + 1;
					is_prefetch	<= '1';
					seq_num <= unsigned(rx_data_prev3(7 downto 5));
				end if;
			else
				if (word_count =1) then
					if( seq_num_expected /= seq_num) then	seq_error_count <= std_logic_vector(unsigned(seq_error_count) + 1);	end if;
					seq_num_expected <= seq_num + 1;
				end if;
					 
				-- set WE for either DCS packet input FIFO or Data Request input FIFO
				if (is_dcsreq = '1') then 
					rx_we <= '1';
				elsif (is_datareq = '1') then
					req_we <= '1';
				end if;
					 
				word_count <= word_count + 1;
				rx_data_out <= rx_data_prev3;
					 
				-- save EWTag for heartbeat packet or Prefecth packet
				if (is_heartbeat = '1' and word_count <6) then
					is_heartbeat <= '0';
					if (word_count = 3) then HEARTBEAT_EVENT_WINDOW_TAG(15 downto 0)  <= rx_data_prev3; end if;
					if (word_count = 4) then HEARTBEAT_EVENT_WINDOW_TAG(31 downto 16) <= rx_data_prev3; end if;
					if (word_count = 5) then HEARTBEAT_EVENT_WINDOW_TAG(47 downto 32) <= rx_data_prev3; end if;
				end if;
						
				if (is_prefetch = '1' and word_count <6) then
					is_prefetch <= '0';
					if (word_count = 3) then PREFETCH_EVENT_WINDOW_TAG(15 downto 0)  <= rx_data_prev3; end if;
					if (word_count = 4) then PREFETCH_EVENT_WINDOW_TAG(31 downto 16) <= rx_data_prev3; end if;
					if (word_count = 5) then PREFETCH_EVENT_WINDOW_TAG(47 downto 32) <= rx_data_prev3; end if;
				end if;
					 
				-- catch if KCHAR shows up in the middle of the DTC packet (unless valid marker)
				if rx_kchar_prev3 = "10" then		rx_error_count <= std_logic_vector(unsigned(rx_error_count) + 1);	end if;
				
				if word_count = 9 then
					word_count <= 0;
				end if;
				
			end if; 	-- if word_count = 0
		end if;		-- if not marker 
		end if; 		-- if aligned = '1'
	end if;			-- if rising_edge(clk) 
	
	end if;
	end process;

   -- architecture body
end architecture_RxPacketReader;
