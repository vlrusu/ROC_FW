							   --------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Reset_Watchdog.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 
				   		   
library work;
use work.algorithm_constants.all; 

entity XCVR_Reset_Controller_0 is	
	Generic (										 
            gAPB_DWIDTH     		: integer := 16;  
            gAPB_AWIDTH     		: integer := 16;	 
            gSERDES_DWIDTH  		: integer := 20; 
            gENDEC_DWIDTH   		: integer := 16;	
            IO_SIZE         		: integer := 2;
            ALGO_LOC_ADDR 			: natural := 12
		);               
	port (	
	-- RocMonitor Interface				

		ALGO_CLK				: in std_logic;			 
		ALGO_RESET			: in std_logic;
		
		ALGO_ADDR 			: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	 	  
		ALGO_WDATA			: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	
		ALGO_RDATA			: inout std_logic_vector(gAPB_DWIDTH-1 downto 0);
				
	   -- XCVR Controller Signals
      INIT_RESET_N		: IN	std_logic;
		
		SLOW_CLK			   : IN	std_logic; 
		RX_DATA				: IN  std_logic_vector(19 downto 0); 
		
		--XCVR FLAGS
		ALIGNED				: 	IN  std_logic;		
		PLL_LOCK			   : 	IN  std_logic;
		RX_VAL          	: 	IN  std_logic; 
      RX_READY        	: 	IN  std_logic;
		TX_CLK_STABLE   	: 	IN  std_logic;
		
		RESET_XCVR_ERRORS	:	IN std_logic;			
		
		--RESET OUTPUTS
		RESET_CORE_N	: OUT std_logic;
		RX_RESET_N		: OUT	std_logic; 
		TX_RESET_N		: OUT	std_logic;
		XCVR_LOCK		: OUT std_logic;	   
		WA_RST_N		   : OUT	std_logic;
		PCS_RESET_N		: OUT	std_logic;
		PMA_RESET_N		: OUT	std_logic;	  
		
		--STATUS--
		XCVR_LOSS_COUNTER : OUT std_logic_vector(15 downto 0)
		
	);
end XCVR_Reset_Controller_0;												


architecture architecture_XCVR_Reset_Controller of XCVR_Reset_Controller_0 is	

-- SIGNAL DECLARATIONS			
   signal module_init_happened		:  std_logic_vector(4 downto 0);

	signal bit_slip_match_register	:	std_logic_vector(19 downto 0);
	signal bit_slip_state 				:  unsigned(1 downto 0);		  	 
												
	signal counterTimerReset 			: 	unsigned (15 downto 0) 	:= (others => '0');	 
	                                	
	signal count						   :  unsigned(3 downto 0);
	signal stable_lock					:	std_logic;
	signal stable_lock_latch			:  std_logic;
	signal stable_lock_fallingEdge  	:  std_logic;
	signal XCVR_LockLoss_Counter		:  unsigned (15 downto 0);
	                                	
	signal reset_serdes					:  std_logic;  
	signal reset_core					   :  std_logic;
	signal reset_WA						:  std_logic;
	signal aligned_latch				   :  std_logic;
	signal rx_val_latch 				   :  std_logic; 
	signal rx_raw_data_latch 			:  std_logic_vector(19 downto 0);
	
	signal sel_rst_cntl_latch			:  std_logic_vector(9 downto 0);
	
	signal reset_xcvr_errors_sig		:  std_logic; 
	signal reset_xcvr_errors_algo		:  std_logic;
	signal xcvr_counter_init			:  std_logic;
	signal bit_slip_shifts_req			:  unsigned(4 downto 0); 
	signal start_bit_slip_shift		:  std_logic;
	
	signal sel_reset_req				   :  std_logic;
	signal sel_reset_cntl_req			:  std_logic_vector(9 downto 0);	  			
	
	--BITSLIP REGISTERS--
	constant bit_slip_match_default 	:  std_logic_vector(19 downto 0) := x"941CF";
	signal new_bitslip_register_match:  unsigned(19 downto 0);
	
	signal bitslip_counter				:	unsigned(4 downto 0);
	signal bit_slip_reset_cnt 			:  unsigned(5 downto 0);		 	 
	signal bit_slip_dead_cnt 			:  unsigned(19 downto 0);
	signal bit_slip_shifts_req_latch	: 	unsigned(4 downto 0);
	signal new_bitslip_finish			:  std_logic;	
	
	signal rx_val_count					:	unsigned(8 downto 0);
   
begin					  									  
	
		RESET_CORE_N				<=  not reset_serdes; --and not sel_rst_cntl_latch(0) ;
		RX_RESET_N					<=  not reset_serdes; --and not sel_rst_cntl_latch(1) ;
		TX_RESET_N					<=  not reset_serdes; --and not sel_rst_cntl_latch(2) ;
		WA_RST_N					   <=  not reset_serdes; --and not sel_rst_cntl_latch(3) ;
		PCS_RESET_N					<=  not reset_serdes; --and not sel_rst_cntl_latch(4) ;
		PMA_RESET_N					<=  not reset_serdes; --and not sel_rst_cntl_latch(5) ;
		reset_xcvr_errors_sig   <= RESET_XCVR_ERRORS or xcvr_counter_init or reset_xcvr_errors_algo;
		XCVR_LOCK					<= stable_lock_latch;	  
		
		XCVR_Controller :process(SLOW_CLK)
		begin  				  
			if(rising_edge(SLOW_CLK)) then	   		
				
				--Latches							  
				stable_lock_latch		   <= stable_lock;
				stable_lock_fallingEdge <= stable_lock_latch and not stable_lock;	
				
				aligned_latch		<= ALIGNED;
				rx_val_latch 		<= RX_VAL;		   						
				rx_raw_data_latch <= RX_DATA;  	
				
				xcvr_counter_init		<= '0';
				module_init_happened	<= module_init_happened and "10101";	  --didn't happen wont be 10101 pattern.
				
				--(0) Reset Init
				if (INIT_RESET_N = '0' ) then	-- System Init	 
					module_init_happened	<= (others => '1');
					sel_rst_cntl_latch	<= (others => '0');
					xcvr_counter_init		<= '1';	   
					count			  		   <= (others => '0');
				else		 
					
					--(1A) Load Selective Reset
					if (sel_reset_req = '1') then	
					   sel_rst_cntl_latch <= sel_reset_cntl_req;	
					   count			  <= (others => '0');
					--(1B) Deassert Selective Reset  					
					else						 
						if(count > 4) then 
							sel_rst_cntl_latch	<= (others => '0');		 	
						else
							count <= count + 1;
						end if;
					end if;
						   
			   	
					--(2A) COUNTERS - LOSS OF LOCK 						-- Counts Errors times XCVR is not responding.
					if reset_xcvr_errors_sig = '1' then  
						XCVR_LockLoss_Counter	<= (others => '0');
					elsif stable_lock_fallingEdge = '1'  then
					   XCVR_LockLoss_Counter	<=	XCVR_LockLoss_Counter + 1;	 
					end if;												  		  
				end if;		
				
			END IF;
		end process;
		
		--================================================================
		---------------------------BITSLIP--------------------------------
		bitslip : for i in 0 to 0 generate	 
		
		begin
				
			bitslip: process(SLOW_CLK)	
			BEGIN		
				if (rising_edge(SLOW_CLK)) then
					reset_serdes 			<= '0';		   
					new_bitslip_finish 	<= '0';
						--(3A) BIT SLIP ALIGNMENT CHECK				
						if (INIT_RESET_N = '0') then	-- System Init	  	  	
							rx_val_count			   <= (others => '1');
							stable_lock				   <= '0';	 
							bit_slip_match_register	<= bit_slip_match_default;
							bit_slip_state			   <= (0 => '1', others => '0'); --goto bit slip check		  
							bit_slip_reset_cnt 	   <= (others => '1'); 
						elsif(bit_slip_state = 0 ) then -- check for bit slip alignment	
							if(rx_val_latch = '1') then		
								if (rx_raw_data_latch(19 DOWNTO 0) /= bit_slip_match_register and		  --check for rx_data and its 4 possible polarities.
									rx_raw_data_latch(19 DOWNTO 0) /= not bit_slip_match_register and
									rx_raw_data_latch(19 DOWNTO 0) /= not bit_slip_match_register(19 downto 10) & bit_slip_match_register(9 downto 0)) and
									rx_raw_data_latch(19 DOWNTO 0) /= bit_slip_match_register(19 downto 10) & not bit_slip_match_register(9 downto 0) then
										rx_val_count			<= rx_val_count + 1;
										if (rx_val_count > 128) then
											bit_slip_state <= (0 => '1', others => '0');    -- bitslip failed, reset.
											bit_slip_reset_cnt <= (others => '1'); 	
										end if;
									else 
										bit_slip_state <= (1 => '1', others => '0');    -- bitslip succeeded.
									end if;	 
							else 	  												-- check for valid being dead 
								rx_val_count			<= (others => '0');
								if (bit_slip_dead_cnt = 0) then		 
									bit_slip_state <= (0 => '1', others => '0');    --go to bit reset PMA
									bit_slip_reset_cnt <= (others => '1'); 	  
								else				  
									bit_slip_dead_cnt <= bit_slip_dead_cnt - 1;	
								end if;	
								
							end if;
						--(3B) BITSLIP ALIGNMENT FAILED - XCVR RESET	
						elsif(bit_slip_state = 1) then -- reset PMA
							rx_val_count			<= (others => '0');

							if (bit_slip_reset_cnt = 0) then		   							
								bit_slip_state <= (others => '0'); 	 --goto bit slip check	
								bit_slip_dead_cnt <= (others => '1');
							else
								bit_slip_reset_cnt <= bit_slip_reset_cnt - 1;	
								if (bit_slip_reset_cnt > 40) then
									reset_serdes <= '1';
								else 
									reset_serdes <= '0';
								end if;
							end if;						   
							
						--(3C) BITSLIP ALIGNMENT SUCCESS - IDLE UNTIL LOSS OF LOCK	
						elsif(bit_slip_state = 2) then	
							stable_lock			<= '1';
							
							if(rx_val_latch = '0' or aligned_latch = '0') then		
								 bit_slip_state 		<= (others => '0'); 
								 stable_lock			<= '0';
							end if;		   
							
							if (new_bitslip_finish = '1') then	 				  
								new_bitslip_finish 			<= '0';
								bit_slip_state 			<= (others => '0');
								bit_slip_match_register	<= std_logic_vector(new_bitslip_register_match);
							end if;									 
						end if;	
					
						--Generate Bitslip
					if(start_bit_slip_shift = '1' and bit_slip_shifts_req <= 20) then	  
						bitslip_counter 			<= (others => '0');	  
						bit_slip_shifts_req_latch	<= bit_slip_shifts_req;	
						new_bitslip_register_match 	<= unsigned(bit_slip_match_default);
					else	   						
						if (bitslip_counter >= 0 and bitslip_counter < bit_slip_shifts_req_latch) then 
							bitslip_counter				<= bitslip_counter + 1;
							new_bitslip_register_match 	<= new_bitslip_register_match ror 1;	
						elsif (bitslip_counter = bit_slip_shifts_req_latch) then
							bitslip_counter				<= (others => '1');
							new_bitslip_finish					<= '1';
						end if;					
					end if;	 	   
				END IF;
			END PROCESS;
		END GENERATE;	
		
	--=======================
	--=======================	
	roc_mon_gen	: for i in 0 to 0 generate	   
		--standard RocMonitor interface generate template
		signal prev_wData					: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	 
		signal prev_addr					: std_logic_vector(ALGO_WADDR_WIDTH-1 DOWNTO 0);
		
		signal algo_rdata_sig				: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0) := (others => 'Z');   --bus		
		signal locAddr						: unsigned(ALGO_LOCADDR_WIDTH-1 DOWNTO 0);																
		signal wAddr						: unsigned(ALGO_WADDR_WIDTH-1 DOWNTO 0);																
		signal wData						: std_logic_vector(ALGO_WDATA_WIDTH-1 DOWNTO 0);		
		signal old_we, we					: std_logic;				   	   
															  									  
		signal rAddr						: unsigned(ALGO_RADDR_WIDTH-1 DOWNTO 0) := (others => '1');	
		signal rst_cnt						: unsigned(3 DOWNTO 0) := (others => '0');			 
		
		signal dummy_reg					: std_logic_vector(gAPB_DWIDTH-1 downto 0);
		
	begin				 
		 
		ALGO_RDATA 	<= algo_rdata_sig;	
		wAddr		<= extract_algo_waddr(ALGO_ADDR); --get write address  
		locAddr		<= extract_algo_locaddr(ALGO_ADDR); --get target location address  	 
		wData		<= extract_algo_wdata(ALGO_WDATA); -- get write enable
		
		roc_monitor: process( ALGO_CLK )   														 
		begin		
			
			if rising_edge(ALGO_CLK) then		  
																			 
				we <= extract_algo_we(ALGO_WDATA); -- get write enable		  
				old_we <= we; --latch we bit		
				algo_rdata_sig <= (others => 'Z'); --always high impedance if not addressed
				
				start_bit_slip_shift			<= '0';	 
				bit_slip_shifts_req				<= (others => '0');	  
				
				sel_reset_req					<= '0';
				sel_reset_cntl_req				<= (others => '0');				  
				reset_xcvr_errors_algo			<= '0';
				-- main cases										 
				if ALGO_RESET = '1' then					   
					--addr							
					reset_xcvr_errors_algo		<= '1';	
					rAddr 						<= (others => '1');  
					prev_wData					<= (others => '0');						   
					prev_addr					<= (others => '0');
				else							   	
					
					if(	locAddr = to_unsigned(ALGO_LOC_ADDR, ALGO_LOCADDR_WIDTH)) then --check target address
																	  
						--Writes
						if (old_we = '0' and we = '1') then -- identify we rising edge
							prev_wData						<= wData;		
							prev_addr						<= std_logic_vector(wAddr);
							
							if wAddr = 0 then
								rAddr						<= unsigned(wData(ALGO_RADDR_WIDTH-1 downto 0));
							elsif wAddr = 1 then 			
							--	bit_slip_shifts_req			<= unsigned(wData(4 downto 0));	
							--	start_bit_slip_shift		<= '1';
							elsif wAddr = 2 then	 
							--	 sel_reset_req				<= '1';
							-- 	 sel_reset_cntl_req			<= wData(9 downto 0);
							elsif wAddr = 3 then
								 reset_xcvr_errors_algo			<= '1';
							elsif wAddr = 4 then
								dummy_reg(ALGO_WDATA_WIDTH-1 downto 0) <= wData;
							end if;
							
						end if;	
						
						
						--Reads				
						algo_rdata_sig <= (others => '0');		  
						if (rAddr = 0) then		
							algo_rdata_sig 								<= prev_wData;
						elsif (rAddr = 1) then	
							algo_rdata_sig(7 downto 0)					<= prev_addr;		
						elsif (rAddr = 2) then		 
							algo_rdata_sig 								<= std_logic_vector(XCVR_LockLoss_Counter);				  
						elsif (rAddr = 3) then 
							algo_rdata_sig 								<= bit_slip_match_register(15 downto 0);
						elsif (rAddr = 4) then
						  	algo_rdata_sig 								<= "00000000000000" & std_logic_vector(bit_slip_state);
						end if;
						
					end if;	  
				end if;	   	
	
			end if;			
		end process;   				
	end generate;
	
	
end architecture_XCVR_Reset_Controller;
