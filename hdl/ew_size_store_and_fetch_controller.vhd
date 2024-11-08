--------------------------------------------------------------
-- v0 :Started from Ryan provided version of 10/09/2020
-- 
--    This module writes the size of a given tag to DREQ_FIFO. DREQ FIFO stores the size of 3 consecutives tags in a single 40-bit word. 
--    Each 40-bit word has:  bit(39) unused and 13-bits ( [38:26]/[25:13]/[12:0] ) reserved for each tag.
--    The 13-bit reserved for each tag contain:   [12] = ddr_wraparound bit; [11] = tag sync error bit; [10] = event size overflow bit; [9:0] = number of hits
--   
-- Separate between
--	  *STORE* signals: on sysclk, used to save event size to DREQ_FIFO
--    *FETCH* signals: on dreqclk after PREFETCH packet, used to access event size from DREQ_FIFO and pass decoded info to DDR READ
--
--  v1 July 20, 2023: use STORE_NEWSPILL and FETCH_NEWSPILL to reset internal logic befor restarting from run PAUSE/HALT state
--  v2 Feb 28, 2024: add diagnostic for MISSED_FETCH_TAG
--  v3 Aug 1,  2024:  add diagnostic counters and ebanle for skipped DREQs
--  v4 Oct 31, 2024:  changed input names:  from "wclk -> sysclk" and "rclk -> dreqclk "
--                                          from "store_XXX -> XXX_to_store" and "fetch_XXX -> XXX_to_fetch"; 
--                                          from "store_newspill -> newspill_on_wclk" and "fetch_newspill -> newspill_on_rclk";
--                                          from "size_fifo_XXX -> fetch_fifo_XXX"
--------------------------------------------------------------
library IEEE;			
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 

library work;
use work.algorithm_constants.all; 

entity ew_size_store_and_fetch_controller is	
	port (
    -- on fast SYSCLK 
		sysclk				: IN std_logic;
		resetn_sysclk	    : IN std_logic;
        newspill_on_sysclk  : IN std_logic;
        
		store		        : IN std_logic; 					 
		wrap_event_to_store : IN std_logic; 	-- if wrapped around DDR address space, store in STORE_WORD bits [38]/[25]/[12] 
		sync_error_to_store : IN std_logic;     -- if event reported tag sync error, store in STORE_WORD bits [37]/[24]/[11]
		overflow_to_store   : IN std_logic; 	-- if event size is larger than 11 bits, store in STORE_WORD bits [36]/[23]/[10]
		event_size_to_store	: IN std_logic_vector(EVENT_SIZE_BITS-1 downto 0); -- number of packets in event: store in STORE_WORD bits [35:26]/[22:13]/[9:0]		   
		event_tag_to_store 	: IN std_logic_vector(EVENT_TAG_BITS-1 downto 0);  -- event tag at NEWSPILL
		store_word 			: OUT std_logic_vector (FIFO_DATA_SIZE-1 downto 0); 
		store_we 			: OUT std_logic;     -- write next word from DREQ_FIFO 
        
    -- on slow DREQCLK
		dreqclk				: IN std_logic;
		resetn_dreqclk      : IN std_logic;
        newspill_on_dreqclk : IN std_logic;
        
		fetch				: IN std_logic;
		event_tag_to_fetch 	: IN std_logic_vector(EVENT_TAG_BITS-1 downto 0);  
		fetch_valid	        : OUT std_logic;
		fetch_sync_error    : OUT std_logic;     
		fetch_overflow      : OUT std_logic;
		fetch_address 	    : OUT std_logic_vector(DDR_ADDRESS_BITS-1 downto 0); -- 8Gbit DDR address space in units of 1 kB blocks
		fetch_size			: OUT std_logic_vector(EVENT_SIZE_BITS-1 downto 0); -- number of packets for EW
		fetch_tag           : OUT std_logic_vector(EVENT_TAG_BITS-1 downto 0);  
			
		fetch_re 			: OUT	std_logic;      -- read next word from DREQ_FIFO
		fetch_fifo_empty	: IN 	std_logic; 					
		fetch_fifo_rdata	: IN	std_logic_vector (FIFO_DATA_SIZE-1 downto 0);  
        
    -- diagnostics outputs to either TOP_SERDES/DRACRegisters or TOP_SERDES/ERROR_COUNTER
        store_cnt 			: OUT std_logic_vector (19 downto 0);  -- number of words stored to DREQ FIFO (each word contain 3 tags)
        store_pos_cnt       : OUT std_logic_vector (1 downto 0);   -- number of HB not yet stored to DREQ FIFO
        fetch_cnt           : OUT std_logic_vector (19 downto 0);  -- number of words fetched from DREQ FIFO (each word contain 3 tags)
        fetch_pos_cnt       : OUT std_logic_vector (1 downto 0);   -- number of DREQ not yet fetched from DREQ FIFO
        fetch_state_cnt     : OUT std_logic_vector (1 downto 0);   -- current FETCH SM position
        fetch_timeout_cnt   : OUT std_logic_vector(15 downto 0); 
        fetch_runover_cnt   : OUT std_logic_vector(15 downto 0); 
        fetch_missing_cnt   : OUT std_logic_vector(15 downto 0); 
        skipped_DREQ_cnt	: OUT std_logic_vector(15 downto 0);   -- counter skipped DREQ from null HB since last reset 
        next_read_event_tag : OUT std_logic_vector (EVENT_TAG_BITS-1 downto 0); -- look-ahead tag
		skipped_DREQ_tag    : OUT std_logic_vector(EVENT_TAG_BITS-1 downto 0);  -- last skipped DREQ tag in HB bull 
		fetch_missing_TAG   : OUT std_logic_vector(EVENT_TAG_BITS-1 downto 0);  -- last DREQ lower than expected
		fetch_runover_TAG   : OUT std_logic_vector(EVENT_TAG_BITS-1 downto 0)   -- last DREQ higher than expected 
		); 
end entity;

architecture arch of ew_size_store_and_fetch_controller is
		        
	---- signals on fast SYSCLK (167 MHz) ----
	signal store_first		: std_logic;                -- HIGH to load event tag offset on first event of a NEW SPILL 	 
	signal store_pos 		: unsigned(1 downto 0);     -- index 0 thru 2 for tag inside a 40-bit FIFO word to store
	signal store_event_offset: std_logic_vector (EVENT_TAG_BITS-1 downto 0);   -- first tag of a NEW SPILL 
    signal store_word_cnt   : unsigned(19 downto 0);    -- number of words written to FIFO 
	
	---- signals on slow DREQCLK (80 MHz)	----
    signal fetch_first      : std_logic;                -- HIGH to load event tag offset on first event of a NEW SPILL
	signal fetch_word 		: std_logic_vector (FIFO_DATA_SIZE-1 downto 0);	
	signal fetch_pos 		: unsigned(1 downto 0);     -- index 0 thru 2 for tag inside a fetched 40-bit FIFO word  		
	signal fetch_state		: unsigned(1 downto 0);	 	 
	signal fetch_done 		: std_logic;  		 
	signal fetch_has_not_fetched: std_logic;
	signal fetch_store_pos 	: unsigned(1 downto 0);
	signal fetch_timeout	: unsigned(15 downto 0);  	
	signal next_ddr_address	: unsigned(DDR_ADDRESS_BITS-1 downto 0);  -- offset address for next fetched tag, in units on 1KB DDR blocks
    signal fetch_word_cnt   : unsigned(19 downto 0);
    
    signal fetch_timeout_error	: std_logic;    -- pulse if waiting for data in DREQ FIFO is larger than 100 us
    signal fetch_missing_error	: std_logic;    -- pulse if requested tag is lower than last tag from previous run
    signal fetch_runover_error  : std_logic;    -- pulse if requested tag is higher and not consistent with a null H
    signal skipped_DREQ_error   : std_logic;    -- pulse if requested tag has skipped last tag from previous run by one (ie null HB)

    signal ddr_wrap	            : std_logic;
	
	-- signals for time domain crossing
 	signal req, ack_req, ack_sync : std_logic;
    signal req_latch, req_sync    : std_logic;
    signal store_on_dreqclk       : std_logic;   
   
	--
	-- function to calculate the number of blocks needed to store an event of a given size
    -- in units of 128-bit words (unlike in EW_FIFO_controller):  
    --    1kB = 128-bit x 64  and  memory header words equal one 128-bit unit 
	function calc_block (
		word_size: in std_logic_vector(EVENT_SIZE_BITS-1 downto 0))
		return	std_logic_vector is
		variable	read_step:	std_logic_vector(MAX_STEP_BITS downto 0);
        begin
            if 	    (unsigned(word_size) > 1008)     then   read_step := std_logic_vector(to_unsigned(9,read_step'length));   -- >=1008 beats (252 trackers hits)  
            elsif	(unsigned(word_size) > (896-14)) then   read_step := std_logic_vector(to_unsigned(8,read_step'length));	-- >= 882 beats (220.5 trackers hits)  
            elsif	(unsigned(word_size) > (768-12)) then   read_step := std_logic_vector(to_unsigned(7,read_step'length));	-- >= 756 beats (189 trackers hits)  
            elsif	(unsigned(word_size) > (640-10)) then   read_step := std_logic_vector(to_unsigned(6,read_step'length));	-- >= 630 beats (157.5 trackers hits)  
            elsif	(unsigned(word_size) > (512-8))  then   read_step := std_logic_vector(to_unsigned(5,read_step'length));	-- >= 504 beats (126 trackers hits)  
            elsif	(unsigned(word_size) > (384-6))  then   read_step := std_logic_vector(to_unsigned(4,read_step'length));	-- >= 378 beats (94.5 trackers hits)  
            elsif	(unsigned(word_size) > (256-4))  then   read_step := std_logic_vector(to_unsigned(3,read_step'length));	-- >= 252 beats (63   trackers hits)  
            elsif	(unsigned(word_size) > (128-2))  then   read_step := std_logic_vector(to_unsigned(2,read_step'length));	-- >= 126 beats (31.5 trackers hits)
            else	                                        read_step := std_logic_vector(to_unsigned(1,read_step'length));
		end if;
		return std_logic_vector(read_step);
	end;	
    --
    
begin	
	
-- fill up some diagnostic outputs to ERROR_COUNTER    
	store_cnt       <= std_logic_vector(store_word_cnt);
	store_pos_cnt   <= std_logic_vector(store_pos);
	fetch_cnt       <= std_logic_vector(fetch_word_cnt);
	fetch_pos_cnt   <= std_logic_vector(fetch_pos);
	fetch_state_cnt <= std_logic_vector(fetch_state);
   
-- this is on fast DDR clock when tag is written to memory
	process(sysclk)	 
	begin
		
		if (rising_edge(sysclk)) then 
			-- ============================================						
			-- write-side of event size store handling				
            store_we <= '0'; 
            
            if  (resetn_sysclk = '0'   or  newspill_on_sysclk = '1')    then
				store_first 		<= '1';             
				store_pos 			<= (others => '0');
				store_word			<= (others => '0');
				store_event_offset  <=	(others => '0');
                store_word_cnt      <=	(others => '0');
		 	   
            else  -- else not reset or NEWSPILL
                
                if  (store_we = '1')    then  store_word_cnt <= store_word_cnt + 1;   end if;
                
				if  (store = '1') then 
                    -- store first TAG of a NEW SPILL after first event is seen and is being written to memory
                    if(store_first = '1') then	
                        store_event_offset  <= event_tag_to_store; 
                        store_first         <= '0';	 		
                    end if;
                  
                    store_pos <= store_pos + 1;   
					
					if(store_pos = 0) then   -- fill STORE_WORD[12:0] with event_size[9:0] + overflow [10] + tag_sync_error [11] + wrap_event_to_store [12] 
						store_word(9 downto 0)  <= event_size_to_store;
						store_word(10)          <= overflow_to_store;
						store_word(11)          <= sync_error_to_store;
						store_word(12)          <= wrap_event_to_store;
                  
					elsif(store_pos = 1) then  -- fill STORE_WORD[25:13] with event_size[22:13] + overflow [23] + tag_sync_error [24] + wrap_event_to_store [25] 
						store_word(22 downto 13)<= event_size_to_store;
						store_word(23)          <= overflow_to_store;
						store_word(24)          <= sync_error_to_store;
						store_word(25)          <= wrap_event_to_store;
						
					elsif(store_pos = 2) then  -- fill STORE_WORD[38:26] with event_size[35:26] + overflow [36] + tag_sync_error [37] + wrap_event_to_store [38] 
						store_word(35 downto 26)<= event_size_to_store;
						store_word(36)          <= overflow_to_store;
						store_word(37)          <= sync_error_to_store;
						store_word(38)          <= wrap_event_to_store;
						
						store_word(FIFO_DATA_SIZE-1 downto 39) <= (others => '0'); 
						store_we <= '1';
						store_pos <= (others => '0');
                    end if;	  
					
				end if; -- end event size write handling 
			end if;	 --end not reset write-side	  
		end if; --end rising edge	  	
		
	end process;
      
--
-- CDC (Cross-Domain Clock) handshake for STORE
-- 1) start REQ on clk_fast signal and clear on "synchronized ACKNOWLEDGE"
-- 2) synchronize REQ on clk_slow => REQ_SYNC
-- 3) feed-back REQ_SYNC as acknowlegde => ACK_SYNC 
-- 4) generate BUSY until ACKOWLEDGE is cleared

    process(sysclk,dreqclk)
        variable busy  : std_logic;    
    begin
         
        if (rising_edge(sysclk)) then
        
            busy  := (req or ack_sync);
         
            if (store and  not busy) then 
                req <= '1';
            elsif (ack_sync) then
                req <= '0';
            end if;
         
            ack_req	<= req_sync;
            ack_sync	<=	ack_req;
         
        end if;
      
		if (rising_edge(dreqclk)) then
         
            if(resetn_dreqclk = '0') then
                store_on_dreqclk  <= '0';
            else
                req_latch<= req;
                req_sync	<=	req_latch;
                
                store_on_dreqclk  <=	req_latch and not req_sync;
			end if;
        end if;
      
    end process;
        
        
-- this is on slow DREQ time domain when the tag is being passed to the DTC
	process(dreqclk)	 
		variable wraparound_flag	: std_logic;
		
	begin
		
		if (rising_edge(dreqclk)) then 
			
			-- ============================================
			-- read-side of event size FIFO fetch handling
			fetch_re    <= '0';	
			fetch_valid	<= '0';
            
            fetch_timeout_error <= '0';	    -- pulse if waiting for data in DREQ FIFO is larger than 1 us
            fetch_missing_error <= '0';     -- pulse when requested tag is lower than LAST tag from previous run
            fetch_runover_error <= '0';     -- pulse when requested tag is larger but not consecutive wrt LAST tag from previous run
            skipped_DREQ_error  <= '0';     -- pulse when requested tag has skipped last tag from previous run by one (ie null HB)
			
			if(resetn_dreqclk = '0') then
                        
				fetch_done 	    <= '0';	
				fetch_state     <= (others => '0');	
				fetch_pos       <= (others => '0');	
				fetch_word      <= (others => '0');	
				fetch_sync_error<= '0';
				fetch_overflow  <= '0';
				fetch_size      <= (others => '0');	
				fetch_tag	    <= (others => '0');
				fetch_address   <= (others => '0');
                fetch_word_cnt      <=	(others => '0');
                
				next_ddr_address    <= (others => '0');  
				next_read_event_tag <= (others => '0');  
				
				fetch_has_not_fetched   <= '0';
                fetch_first             <= '1'; 
                
				fetch_timeout       <= (others => '0');	 
				fetch_timeout_cnt   <= (others => '0');	 
                fetch_runover_cnt   <= (others => '0');
                fetch_runover_TAG   <= (others => '0'); 
				fetch_missing_cnt   <= (others => '0');
                fetch_missing_TAG   <= (others => '0');
                skipped_DREQ_cnt    <= (others => '0');
                skipped_DREQ_tag    <= (others => '0');
                
                ddr_wrap <= '0';
                
            -- reset everything on NEW SPILL except NEXT  DDR_ADDRESS and EVENT_TAG, 
            -- ie keep reading from DDR where it was left on previous spill
            elsif (newspill_on_dreqclk = '1') then
                
				fetch_done 	    <= '0';	
				fetch_state     <= (others => '0');	
				fetch_pos       <= (others => '0');	
				fetch_word      <= (others => '0');	
				fetch_sync_error<= '0';
				fetch_overflow  <= '0';
				fetch_size      <= (others => '0');	
				fetch_tag	    <= (others => '0');
				fetch_address   <= (others => '0');
                fetch_word_cnt      <=	(others => '0');
                
				--next_ddr_address    <= (others => '0');  
				--next_read_event_tag <= (others => '0');  
                
				fetch_has_not_fetched   <= '0';
                fetch_first             <= '1'; 
                
				fetch_timeout       <= (others => '0');	 
				fetch_timeout_cnt   <= (others => '0');	 
                fetch_runover_cnt   <= (others => '0');
                fetch_runover_TAG   <= (others => '0'); 
				fetch_missing_cnt   <= (others => '0');
                fetch_missing_TAG   <= (others => '0');
                skipped_DREQ_cnt    <= (others => '0');
                skipped_DREQ_tag    <= (others => '0');
                
			else  -- else not reset	or NEWSPILL 
                
                if (fetch_re)   then    fetch_word_cnt <= fetch_word_cnt + '1';     end if;
                
				-- register STORE_POS on SLOW_CLK:  
                -- needed in order to pass event size to EW_FIFO_Cntrl BEFORE the tags are seen and
                -- a full DREQ_FIFO 40b word is assembled. Marked this case with FETCH_HAS_NOT_FETCHED flag high.
				fetch_store_pos	<= store_pos;
                    
                if (fetch_first = '1'  and  store_on_dreqclk = '1') then
                    fetch_first <= '0';
                    next_read_event_tag <= store_event_offset;
                end if;
                
				-- user holds "fetch" input high, until valid response "fetch_valid" is seen.
                -- Use internal "fetch_done" signal to give time to user to clear "fetch"
				if (fetch_first = '0' and fetch = '1' and fetch_done = '0') then
                    
                    -- initial FETCH state: 
                    ----    EITHER  DREQ_FIFO is not empty, ie there are some data which can be read
                    ----      OR    set FETCH_HAS_NOT_FETCHED high and use the info from the one of the three tags that has already been seen 
                    if(fetch_state = 0) then   
                        
                        ddr_wrap <= '0';
                        
 						-- timeout 8196*12.5 ns ~ 1 ms long, waiting for DREQ_FIFO to have entries
						fetch_timeout <= fetch_timeout + 1;
						if(fetch_timeout = 8196) then --timeout!
							fetch_timeout_error <= '1';
                            fetch_timeout_cnt    <= std_logic_vector(unsigned(fetch_timeout_cnt) + 1);	                            
						end if;	  
						
						if(fetch_pos = 0) then
                            
                            -- Monica moved it fetch_pos=1 and 2, if DREQ_FIFO has been read
							-- fetch_has_not_fetched <= '0'; --init							
                            if(fetch_fifo_empty = '0') then         -- straightforward fetch from DREQ_FIFO: go to fetch_state=1 to wait foe fifo data to settle
								fetch_re <= '1';	 
								fetch_state <= to_unsigned(1,2); 
							elsif(fetch_pos < fetch_store_pos) then -- fifo is empty but have at least one tag in: flag with FETCH_HAS_NOT_FETCHED high,
                                                                    -- get size from store_word and skip to fetch_state=3 to decode
								fetch_has_not_fetched <= '1';
								fetch_word <= store_word;	
								fetch_state <= to_unsigned(3,2);    							
							end if;
                            
						elsif(fetch_has_not_fetched = '1') then     -- in FETCH_POS > 0 but have not read DREQ_FIFO yet....
                            
							if(fetch_pos = 1) then 
								if(fetch_fifo_empty = '0') then     -- DREQ_FIFO has seen a full word now...straightforward fetch and continue to fetch_state=1 
									fetch_has_not_fetched <= '0';
									fetch_re <= '1';	 
									fetch_state <= to_unsigned(1,2); 
                                elsif(fetch_pos < fetch_store_pos) then     -- fifo is empty but have at least thrid tag in:
                                                                            -- get size from store_word and skip to fetch_state=3 to decode
									fetch_has_not_fetched <= '1';
									fetch_word <= store_word;																  
									fetch_state <= to_unsigned(3,2); --goto 'have fetch word state'	 								
								end if;
							elsif(fetch_pos = 2 and fetch_fifo_empty = '0') then    -- if we get here, we might as well wait for DREQ_FIFO to get a word	
                                fetch_has_not_fetched <= '0'; 
								fetch_re <= '1';	 
								fetch_state <= to_unsigned(1,2); 
							end if;								   
							-- there are else cases here that will wait and eventually timeout
							
						else    -- fetch_pos must be 1 or 2 AND word has already been read from DREQ_FIFO: skip to fetch_state=3 to decode
							fetch_state <= to_unsigned(3,2);
						end if;
							
					elsif(fetch_state = 1) then     -- DREQ_FIFO has been read; wait for data
						fetch_state <= to_unsigned(2,2); --goto 'set fetch word state'		
						
					elsif(fetch_state = 2) then     -- DREQ_FIFO data has settled: skip to fetch_state=3 to decode
						fetch_word <= fetch_fifo_rdata;
						fetch_state <= to_unsigned(3,2); 
						
					elsif(fetch_state = 3) then     -- FIFO word decode state for one of the three tags
                        
						-- decode output size, special bits, and  
                        -- DDR address offset for start of NEXT fetch request by fetched size.
						if(fetch_pos = 0) then	 
							wraparound_flag 	:= fetch_word(12);
							if(wraparound_flag = '1') then -- ddr wraparound!
								next_ddr_address <= (others => '0'); --wraparound to 0 
                                ddr_wrap <= '1';
							else
								next_ddr_address <= next_ddr_address + unsigned(calc_block(fetch_word(9 downto 0)));	
							end if;
							fetch_sync_error	<= fetch_word(11);
							fetch_overflow		<= fetch_word(10);
							fetch_size			<= fetch_word(9 downto 0);
						elsif(fetch_pos = 1) then	 
							wraparound_flag 	:= fetch_word(25);	  
							if(wraparound_flag = '1') then -- ddr wraparound!
								next_ddr_address <= (others => '0'); --wraparound to 0 
                                ddr_wrap <= '1';
							else
								next_ddr_address <= next_ddr_address + unsigned(calc_block(fetch_word(22 downto 13)));
							end if;
							fetch_sync_error	<= fetch_word(24);
							fetch_overflow		<= fetch_word(23);
							fetch_size			<= fetch_word(22 downto 13);
						else -- if(fetch_pos = 2) then			 
							wraparound_flag	:= fetch_word(38);   
							if(wraparound_flag = '1') then -- ddr wraparound!
                              next_ddr_address <= (others => '0'); --wraparound to 0 
                                ddr_wrap <= '1';
							else
								next_ddr_address <= next_ddr_address + unsigned(calc_block(fetch_word(35 downto 26)));	
							end if;
							fetch_sync_error	<= fetch_word(37);
							fetch_overflow		<= fetch_word(36);
							fetch_size			<= fetch_word(35 downto 26);
						end if;	
							
						-- check if we at the corrected requested TAG before sending out FETCH_VALID and DDR address to read
						if(event_tag_to_fetch = next_read_event_tag) then
							--DONE!
							fetch_done 	<= '1'; 
                            fetch_valid <= '1';
                            
                            fetch_address   <= std_logic_vector(next_ddr_address);
                            fetch_tag       <= next_read_event_tag;
                            
                        -- this will happen after null HB. Tag and fix FETCH_TAG to pass to DDR and NEXT_READ_EVENT_TAG
						elsif   unsigned(event_tag_to_fetch) = (unsigned(next_read_event_tag) + 1) then  
                            skipped_DREQ_error  <= '1';
                            skipped_DREQ_cnt    <= std_logic_vector(unsigned(skipped_DREQ_cnt) + 1);
                            skipped_DREQ_tag    <= event_tag_to_fetch;
                            
							fetch_done 	<= '1'; 
                            fetch_valid <= '1';
                            
                            fetch_address   <= std_logic_vector(next_ddr_address);
                            fetch_tag       <= event_tag_to_fetch;
						--end if;
                    
                        -- catch other tag inconsistencies
						-- requested tag is lower than LAST tag from previous run
						--if(event_tag_to_fetch < next_read_event_tag) then 
						elsif(event_tag_to_fetch < next_read_event_tag) then 
							fetch_missing_error <= '1';	 
                            fetch_missing_cnt   <= std_logic_vector(unsigned(fetch_missing_cnt) + 1);	                            
                            fetch_missing_TAG   <= event_tag_to_fetch;
						--end if;
                            
                        -- requested tag is higher and not consistent with a null HB
                        --if ( unsigned(event_tag_to_fetch) > (unsigned(next_read_event_tag) + 1) ) then
                        elsif ( unsigned(event_tag_to_fetch) > (unsigned(next_read_event_tag) + 1) ) then
                            fetch_runover_error <= '1';
                            fetch_runover_cnt   <= std_logic_vector(unsigned(fetch_runover_cnt) + 1);
                            fetch_runover_TAG   <= event_tag_to_fetch;
                        end if;
                        
                        -- reset timeout
						fetch_timeout   <= (others => '0');	
                        -- increment fetch_pos and next tag
						fetch_pos <= fetch_pos + 1;
						if(fetch_pos = 2)   then    fetch_pos <= (others => '0');   end if;
                        -- increase look-ahead tag for next DREQ         
						next_read_event_tag <= std_logic_vector(unsigned(next_read_event_tag) + 1);	
                        -- return to init state either for immediate next fetch, or to wait for next fetch request
						fetch_state     <= to_unsigned(0,2);  
                        
					end if;	-- end of FETCH_STATE state mchine										  
					
				elsif (fetch = '0') then
					fetch_done <= '0'; -- get ready for next fetch
				end if; -- end event size write handling 
				
			end if;	 --end not reset read-side	
	  		
		end if; --end dreqclk rising edge	  	
		
	end process;	
	
end architecture arch;