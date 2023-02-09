--------------------------------------------------------------
-- Separate between
--	   STORE signals: on sysclk, used to save event size to SIZE_FIFO
--    FETCH signals: on dreqclk after PREFETCH packet: used to access event size from SIZE_FIFO and decode info to pass to DDR READ
--------------------------------------------------------------
library IEEE;			
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 

library work;
use work.algorithm_constants.all; 

entity ew_size_store_and_fetch_controller is	
	port (
-- on SYSCLK
		wclk				: IN std_logic;
		wreset_n			: IN std_logic;
        store_newspill      : IN std_logic;
		store_event_we		: IN std_logic; 					 
		store_event_wraparound 	: IN std_logic; 	-- if wrapped around DDR address space: use bits [35]/[23]/[11] of store word 
		store_overflow 		: IN std_logic; 		-- if event ize is larger than 11 bits: used bit[38:36] of store_word
		store_event_size	: IN std_logic_vector(EVENT_SIZE_BITS-1 downto 0); -- number of packets for EW		   
		store_event_tag 	: IN std_logic_vector(EVENT_TAG_BITS-1 downto 0); 
		store_word 			: OUT std_logic_vector (FIFO_DATA_SIZE-1 downto 0); 
		store_we 			: OUT std_logic; 
        -- diagnostics outputs
        store_cnt 			: OUT std_logic_vector (19 downto 0);  -- number of words stored to DREQ FIFO (each stored word correspong to 3 HBs)
        store_pos_cnt       : OUT std_logic_vector (1 downto 0);   -- number of HB not yet stored to DREQ FIFO
-- on DREQCLK
		rclk				: IN std_logic;
		rreset_n			: IN std_logic;
        fetch_newspill      : IN std_logic;
		fetch				: IN std_logic;
		fetch_event_tag 	: IN std_logic_vector(EVENT_TAG_BITS-1 downto 0);  
		fetch_timeout_error	: OUT std_logic;
		fetch_missing_error	: OUT std_logic; 
		fetch_address_valid	: OUT std_logic;
		fetch_overflow      : OUT std_logic;
		fetch_ddr_address 	: OUT std_logic_vector(DDR_ADDRESS_BITS-1 downto 0); -- 8Gbit DDR address space (64 bit words)
		fetch_size			: OUT std_logic_vector(EVENT_SIZE_BITS-1 downto 0); -- number of packets for EW
		fetch_tag           : OUT std_logic_vector(EVENT_TAG_BITS-1 downto 0);  
			
		fetch_re 			: OUT	std_logic; 
		size_fifo_empty		: IN 	std_logic; 					
		size_fifo_rdata		: IN	std_logic_vector (FIFO_DATA_SIZE-1 downto 0);
        -- diagnostics outputs
        fetch_cnt           : OUT std_logic_vector (19 downto 0);  -- number of words fetched from DREQ FIFO (each fetched word correspond to 3 DREQs)
        fetch_pos_cnt       : OUT std_logic_vector (1 downto 0);   -- number of DREQ not yet fetched from DREQ FIFO
        fetch_state_cnt     : OUT std_logic_vector (1 downto 0);   -- current FETCH SM position
        next_read_event_tag : OUT std_logic_vector (EVENT_TAG_BITS-1 downto 0)
		); 
end entity;

architecture arch of ew_size_store_and_fetch_controller is
		
	---- signals on fast WCLK ----
	--signal size_fifo_empty: std_logic; 					
	--signal size_fifo_rdata: std_logic_vector (FIFO_DATA_SIZE-1 downto 0); 
	signal store_first		: std_logic; 	 
	signal store_event_offset: std_logic_vector (EVENT_TAG_BITS-1 downto 0); 
	--signal store_word 		: std_logic_vector (FIFO_DATA_SIZE-1 downto 0);
	--signal store_we 		: std_logic; 
	signal store_pos 			: unsigned(1 downto 0);
    signal cnt_store        : unsigned(19 downto 0);
	
	---- signals on slow RCLK	----
	--signal fetch_re 		: std_logic;
    signal fetch_runover 	: std_logic; 
    signal fetch_first      : std_logic;
	signal fetch_word 		: std_logic_vector (FIFO_DATA_SIZE-1 downto 0);	
	signal fetch_pos 			: unsigned(1 downto 0);  		
	signal fetch_state		: unsigned(1 downto 0);	 	 
	signal fetch_done 		: std_logic;  		 
	signal fetch_has_not_fetched: std_logic;
	signal fetch_store_pos 	: unsigned(1 downto 0);
	signal fetch_timeout_count	: unsigned(15 downto 0);  	
	signal next_ddr_address	: unsigned(DDR_ADDRESS_BITS-1 downto 0);
--	signal next_read_event_tag : std_logic_vector (EVENT_TAG_BITS-1 downto 0); 
    signal cnt_fetch        : unsigned(19 downto 0);
	
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
	
	store_cnt       <= std_logic_vector(cnt_store);
	store_pos_cnt   <= std_logic_vector(store_pos);
	fetch_cnt       <= std_logic_vector(cnt_fetch);
	fetch_pos_cnt   <= std_logic_vector(fetch_pos);
	fetch_state_cnt <= std_logic_vector(fetch_state);
   
-- this is on fast Event Marker & HEARBIT time domain
	process(wclk)	 
	begin
		
		if (rising_edge(wclk)) then 
			-- ============================================						
			-- write-side of event size FIFO store handling				
            store_we <= '0'; 
            
            if(wreset_n = '0') then
				store_pos 			<= (others => '0');
				store_word			<= (others => '0');
				store_first 		<= '1';  -- load event tag offset on first event even without ONSPILL
				store_event_offset  <=	(others => '0');
                cnt_store           <=	(others => '0');
		 	   
			else  -- else not reset
         
                -- mark start of new SPILL
                if (store_newspill) then
                    store_first <= '1';
                end if;
                
                if (store_we) then 
                    cnt_store <= cnt_store + 1; 
                end if;
                
				if (store_event_we = '1') then 
                    
                    --store TAG after new SPILL
                    if(store_first = '1') then	
                        store_event_offset <= store_event_tag; 
                        store_first <= '0';	 		
                    end if;
                  
                    store_pos <= store_pos + 1; 
					
					if(store_pos = 0) then   -- fill STORE_WORD[11:0] with event_size[9:0] + overflow [10] + store_event_wraparound [11] 
						store_word(EVENT_SIZE_BITS-1 downto 0) <= store_event_size;
						store_word(EVENT_SIZE_BITS)            <= store_overflow;
						store_word(EVENT_SIZE_BITS+1)          <= store_event_wraparound;
                  
					elsif(store_pos = 1) then  -- fill STORE_WORD[23:12] with event_size[21:12] + overflow [22] + store_event_wraparound [23] 
						store_word(EVENT_SIZE_BITS+11 downto 12)  <= store_event_size;
						store_word(EVENT_SIZE_BITS+12)         <= store_overflow;
						store_word(EVENT_SIZE_BITS+13)         <= store_event_wraparound;
						
					elsif(store_pos = 2) then  -- fill STORE_WORD[35:24] with event_size[33:24] + overflow [34] + store_event_wraparound [35] 
						store_word(EVENT_SIZE_BITS+23 downto 24)  <= store_event_size;
						store_word(EVENT_SIZE_BITS+24)            <= store_overflow;
						store_word(EVENT_SIZE_BITS+25)            <= store_event_wraparound;
						
						store_word(FIFO_DATA_SIZE-1 downto 36) <= (others => '0'); 
						store_we <= '1';
						store_pos <= (others => '0');
                    end if;	  
					
				end if; -- end event size write handling 
			end if;	 --end not reset write-side	  
		end if; --end rising edge	  	
		
	end process;
      
--
-- CDC (Cross-Domain Clock) handshake for STORE_EVENT_WE
-- 1) start REQ on clk_fast signal and clear on "synchronized ACKNOWLEDGE"
-- 2) synchronize REQ on clk_slow => REQ_SYNC
-- 3) feed-back REQ_SYNC as acknowlegde => ACK_SYNC 
-- 4) generate BUSY until ACKOWLEDGE is cleared

    process(wclk,rclk)
        variable busy  : std_logic;    
    begin
         
        if (rising_edge(wclk)) then
        
            busy  := (req or ack_sync);
         
            if (store_event_we and  not busy) then 
                req <= '1';
            elsif (ack_sync) then
                req <= '0';
            end if;
         
            ack_req	<= req_sync;
            ack_sync	<=	ack_req;
         
        end if;
      
		if (rising_edge(rclk)) then
         
            if(rreset_n = '0') then
                store_on_dreqclk  <= '0';
            else
                req_latch<= req;
                req_sync	<=	req_latch;
                
                store_on_dreqclk  <=	req_latch and not req_sync;
			end if;
        end if;
      
    end process;
   
-- this is on slow DREQ time domain
	process(rclk)	 
		variable wraparound_flag	: std_logic;
		
	begin
		
		if (rising_edge(rclk)) then 
			
			-- ============================================
			-- read-side of event size FIFO fetch handling
			fetch_re 		      <= '0';	
			fetch_address_valid	<= '0';
			
			if(rreset_n = '0') then
                        
				fetch_done 	    <= '0';	
				fetch_state     <= (others => '0');	
				fetch_pos       <= (others => '0');	
				fetch_word      <= (others => '0');	
				fetch_overflow  <= '0';
				fetch_size      <= (others => '0');	
				fetch_tag	    <= (others => '0');
				fetch_ddr_address   <= (others => '0');
                cnt_fetch       <=	(others => '0');
            
				next_ddr_address    <= (others => '0');  
				next_read_event_tag <= (others => '0');  
				
				fetch_timeout_count <= (others => '0');	 
				fetch_has_not_fetched   <= '0';
				fetch_timeout_error <= '0';	  
				fetch_missing_error <= '0';
                fetch_first         <= '1'; -- load event tag offset on first event even without ONSPILL
                fetch_runover       <= '0';
            				
			else  -- else not reset	   
			
                if (fetch_re) then   
                    cnt_fetch <= cnt_fetch + '1'; 
                end if;
                
				-- register STORE_POS on SLOW_CLK.  
                -- Needed in order to pass event size to EW_FIFO_Cntrl BEFORE a full 40b word is assembled 
                -- for SIZE_FIFO (it takes three events to fill it up!!). Marked with FETCH_HAS_NOT_FETCHED flag high.
				fetch_store_pos	<= store_pos;
                
                -- register first STORE_EVENT_WE seen after start of a new SPILL and use to update expected event tag
                if (fetch_newspill = '1') then   fetch_first <= '1';  end if;
                
                if (fetch_first = '1'  and  store_on_dreqclk = '1') then
                    fetch_first <= '0';
                    next_read_event_tag <= store_event_offset;
                end if;
                
				-- user holds fetch high, until address valid response (fetch_done)
				if (fetch_first = '0' and fetch = '1' and fetch_done = '0') then
               
 				   if(fetch_state = 0) then   --initial state
						fetch_timeout_error <= '0';	  
						fetch_missing_error <= '0';
                  
 						--could timeout waiting for fifo
						fetch_timeout_count <= fetch_timeout_count + 1;
						if(fetch_timeout_count = 8196) then --timeout!
							--fetch_done <= '1';  -- continue thru state machine for now
							fetch_timeout_error <= '1';
						end if;	  
						
						--requested tag could be missing
						if(fetch_event_tag < next_read_event_tag) then 
							--fetch_done <= '1';  -- continue thru state machine for now
							fetch_missing_error <= '1';	 
						end if;

                        if ( unsigned(next_read_event_tag) > (unsigned(fetch_event_tag) + 1) ) then
                            fetch_runover <= '1';
                        end if;
						
							
						if(fetch_pos = 0) then
                            -- Monica commented: cleared in fetch_pos 1 or 2, if SIZE_FIFO has been read
							-- fetch_has_not_fetched <= '0'; --init							
							if(size_fifo_empty = '0') then
								--straightforward fetch from fifo
								fetch_re <= '1';	 
								fetch_state <= to_unsigned(1,2); 
							elsif(fetch_pos < fetch_store_pos) then -- fifo empty, but have data
								-- get size from store_word, not in FIFO yet 
								-- if pos = 2, wait for it to show up in FIFO					
								fetch_has_not_fetched <= '1';
								fetch_word <= store_word;	
								fetch_state <= to_unsigned(3,2); --goto 'have fetch word state'	 								
							end if;
						elsif(fetch_has_not_fetched = '1') then
							if(fetch_pos = 1) then 
								if(size_fifo_empty = '0') then
									--straightforward fetch from fifo, one position late is OK
									fetch_has_not_fetched <= '0';
									fetch_re <= '1';	 
									fetch_state <= to_unsigned(1,2); 
								elsif(fetch_pos < fetch_store_pos) then -- fifo empty, but have data
									-- get size from store_word, not in FIFO yet 
									-- if pos = 2, wait for it to show up in FIFO					
									fetch_has_not_fetched <= '1';
									fetch_word <= store_word;																  
									fetch_state <= to_unsigned(3,2); --goto 'have fetch word state'	 								
								end if;
                            -- if we get here, we might as well wait for fifo to get a word		
							elsif(fetch_pos = 2 and size_fifo_empty = '0') then 
                        fetch_has_not_fetched <= '0';  -- Monica added
								fetch_re <= '1';	 
								fetch_state <= to_unsigned(1,2); 
							end if;								   
							-- there are else cases here that will wait and eventually timeout							
						else -- pos is 1 or 2 and already have fetch word
							fetch_state <= to_unsigned(3,2); --goto 'have fetch word state'
						end if;
							
					elsif(fetch_state = 1) then -- FIFO has been read; wait for FIFO data
						--fetch_word <= size_fifo_rdata; -- Monica: this was too early. Added state=4 for an extra clock delay
						fetch_state <= to_unsigned(2,2); --goto 'set fetch word state'		
						
					elsif(fetch_state = 2) then --FIFO data has settled
						fetch_word <= size_fifo_rdata;
						fetch_state <= to_unsigned(3,2); --goto 'have fetch word state'
						
					elsif(fetch_state = 3) then --have fetch_word	
							
						-- offset address by fetched size (and setup output size while we are at it)
						if(fetch_pos = 0) then	 
							wraparound_flag 	:= fetch_word(EVENT_SIZE_BITS+1);
							if(wraparound_flag = '1') then -- ddr wraparound!
								next_ddr_address <= (others => '0'); --wraparound to 0 
							else
								next_ddr_address 	<= next_ddr_address + unsigned(calc_block(fetch_word(EVENT_SIZE_BITS-1 downto 0)));	
							end if;
							fetch_overflow		<= fetch_word(EVENT_SIZE_BITS);
							fetch_size			<= fetch_word(EVENT_SIZE_BITS-1 downto 0);
						elsif(fetch_pos = 1) then	 
							wraparound_flag 	:= fetch_word(EVENT_SIZE_BITS+13);	  
							if(wraparound_flag = '1') then -- ddr wraparound!
								next_ddr_address <= (others => '0'); --wraparound to 0 
							else
								next_ddr_address 	<= next_ddr_address + unsigned(calc_block(fetch_word(EVENT_SIZE_BITS+11 downto 12)));
							end if;
							fetch_overflow		<= fetch_word(EVENT_SIZE_BITS+12);
							fetch_size			<= fetch_word(EVENT_SIZE_BITS+11 downto 12);
						else -- if(fetch_pos = 2) then			 
							wraparound_flag	:= fetch_word(EVENT_SIZE_BITS+25);   
							if(wraparound_flag = '1') then -- ddr wraparound!
								next_ddr_address <= (others => '0'); --wraparound to 0 
							else
								next_ddr_address 	<= next_ddr_address + unsigned(calc_block(fetch_word(EVENT_SIZE_BITS+23 downto 24)));	
							end if;
							fetch_overflow		<= fetch_word(EVENT_SIZE_BITS+24);
							fetch_size			<= fetch_word(EVENT_SIZE_BITS+23 downto 24);
						end if;	
						
						-- always increment next tag	 								   							  
						next_read_event_tag <= std_logic_vector(unsigned(next_read_event_tag) + 1);	
                        
                        -- extra diagnostics
                        if ( unsigned(next_read_event_tag) > (unsigned(fetch_event_tag) + 1) ) then
                            fetch_runover <= '1';
                        end if;
						
						-- increment fetch_pos and wrap around  for 3 positions					   
						fetch_pos <= fetch_pos + 1;
						if(fetch_pos = 2) then
							fetch_pos   <= (others => '0');
						end if;	 
						
                        
						--check if done and send out FETCH_ADDRESS_VALID (used to clear FETCH)
						if(fetch_event_tag = next_read_event_tag) then
							--DONE!
							fetch_done 			<= '1'; 
                            fetch_address_valid <= '1';
                            
                            fetch_ddr_address   <= std_logic_vector(next_ddr_address);
                            fetch_tag		    <= next_read_event_tag;
						end if;
						
						--- no matter what, return to init state
						--	either for immediate next fetch, or to wait for next fetch request
						fetch_state		    <= to_unsigned(0,2);
						fetch_timeout_count <= (others => '0');	--reset timeout
						
					end if;	-- end of FETCH_STATE state mchine										  
					
				elsif (fetch = '0') then
					fetch_done <= '0'; -- get ready for next fetch
				end if; -- end event size write handling 
				
			end if;	 --end not reset read-side	
	  		
		end if; --end RCLK rising edge	  	
		
	end process;	
	
end architecture arch;