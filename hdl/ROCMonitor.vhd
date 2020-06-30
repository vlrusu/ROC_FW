--------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: RocMonitor.vhd
-- File history:
--      v00: Feb 25, 2015: Birthday
--
-- Description: 
-- Interface between uP APB interface (UART) and Algorithm Status
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S050T> <Package::896 FBGA>
-- Author: Ryan Rivera
--
--------------------------------------------------------------------------------

library IEEE;	  							
USE IEEE.std_logic_1164.ALL;				 
USE IEEE.numeric_std.ALL;			  			 
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
								 					   
library work;
use work.algorithm_constants.all; 

entity RocMonitor is	 
	Generic (			 
            gAPB_DWIDTH     		: integer := 16;  
            gAPB_AWIDTH     		: integer := 16;	 
            gSERDES_DWIDTH  		: integer := 20; 
            gENDEC_DWIDTH   		: integer := 16;	
            IO_SIZE         		: integer := 2;
			ALGO_LOC_ADDR 			: natural := 0
		); 
	port (									
		--APBus interface with uP over the FIC
    	algo_clk    		: IN  std_logic;            						-- APB clock
	    PRESETn 			: IN  std_logic;            						-- APB reset
	    PENABLE 			: IN  std_logic;            						-- APB enable
	    PSEL    			: IN  std_logic;            						-- APB periph select
	    PADDR   			: IN  std_logic_vector(gAPB_AWIDTH+4-1 DOWNTO 0);  	-- APB address bus
	    PWRITE  			: IN  std_logic;            						-- APB write
	    PWDATA  			: IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);  	-- APB write data		   
																																	 		
	    PRDATA  			: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);  	-- APB read data
	    PREADY  			: OUT std_logic;            						-- APB ready signal data
	    PSLVERR 			: OUT std_logic;            						-- APB error signal		   
									  																				 
		--DCS FIFO interface					  															
	    DCS_RCV_FIFO_EMPTY		: IN  std_logic;            													
	    DCS_RCV_FIFO_FULL		: IN  std_logic;    	
	    DCS_RCV_FIFO_Q			: IN  std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH DOWNTO 0);    --Valid | LastPacket |Opcode[34:32] | Addr(31:16) | WData(15:0)	 
		DCS_RCV_FIFO_RE 		: OUT  std_logic;             													 		
	    DCS_RESP_FIFO_DATA  	: OUT std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH DOWNTO 0);   -- DCS_RCV_FIFO_EMPTY(36) | Last Packet | Opcode[34:32] | Addr(31:16) | RData(15:0)	
		DCS_RESP_FIFO_WE 		: OUT  std_logic; 	
		
		--Serial Fifo
		dbgSerialFifo_full		: IN  std_logic; 
		dbgSerialFifo_empty		: IN  std_logic;
		dbgSerialFifo_rdCnt		: IN  std_logic_vector(10 downto 0);
		dbgSerialFifo_dataIn		: IN  std_logic_vector(15 downto 0); 
		
		dbgSerialFifo_re		: OUT std_logic;
		dbgSerialFifo_rst		: OUT std_logic;   
	 	dbgSerialFifo_dataOut	: OUT std_logic_vector(15 downto 0);   
		dbgSerialFifo_we		: OUT std_logic;
													  								   
		--8B10B interface 0									  	          						   
	    ALIGNED_0     	   		: IN std_logic;   
	    INVALID_K_0     	   	: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
	    RX_DATA_0     	   		: IN std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0);
	    CODE_ERR_N_0     	   	: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
	    RX_K_CHAR_0    	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
	    B_CERR_0       	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
	    RD_ERR_0       	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
		
	    EPCS_0_TX_CLK_STABLE	: IN std_logic;            			         					
		RX_EPCS_DATA_0 			: IN std_logic_vector(gSERDES_DWIDTH-1 DOWNTO 0);		
		XCVR_LOSS_COUNTER		: IN std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
		
		SEL_RST					: OUT STD_LOGIC;
		SEL_RST_CNTL			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		
		TX_EPCS_SEL_0      		: OUT std_logic;  
		RESET_EPCS_MUX_SEL_0 	: OUT std_logic;  
		TX_EPCS_DATA_0 			: OUT std_logic_vector(gSERDES_DWIDTH-1 DOWNTO 0);		
	    TX_DATA_0     	   		: OUT std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0);	
	    TX_K_CHAR_0     	   	: OUT std_logic_vector(IO_SIZE-1 DOWNTO 0);			
	    FORCE_DISP_0     	   	: OUT std_logic_vector(IO_SIZE-1 DOWNTO 0);			
	    DISP_SEL_0     	   		: OUT std_logic_vector(IO_SIZE-1 DOWNTO 0);	
		
        DCS_ALIGNMENT_REQ       : OUT std_logic;

		--Timestamp Manager
		EVENT_START_DELAY_FINE_TCLK	:	   	OUT	std_logic_vector(gAPB_DWIDTH - 1 downto 0);
		EVENT_START_COARSE_40		:   	OUT	std_logic_vector(18 downto 0);
																	 											  
		--8B10B interface 0									  	          						   
	   -- ALIGNED_1     	   		: IN std_logic;   
--	    INVALID_K_1     	   	: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
--	    RX_DATA_1     	   		: IN std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0);
--	    CODE_ERR_N_1     	   	: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
--	    RX_K_CHAR_1    	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
--	    B_CERR_1       	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
--	    RD_ERR_1       	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
--          			   
--	    EPCS_1_TX_CLK_STABLE	: IN std_logic;            			   
--	    EPCS_1_RX_RESET_N  		: IN std_logic;            			   
--	    EPCS_1_TX_RESET_N  		: IN std_logic;      
--		RX_EPCS_DATA_1 			: IN std_logic_vector(gSERDES_DWIDTH-1 DOWNTO 0);  
		                    	
	--	RESET_EPCS_N_1			: OUT std_logic;
--		RESET_COREPCS_N_1 		: OUT std_logic;  
--		WA_RSTn_1      			: OUT std_logic;  
--		TX_EPCS_SEL_1      		: OUT std_logic;  
--		RESET_EPCS_MUX_SEL_1 	: OUT std_logic;  
--		TX_EPCS_DATA_1 			: OUT std_logic_vector(gSERDES_DWIDTH-1 DOWNTO 0);		
--	    TX_DATA_1     	   		: OUT std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0);	
--	    TX_K_CHAR_1     	   	: OUT std_logic_vector(IO_SIZE-1 DOWNTO 0);			
--	    FORCE_DISP_1     	   	: OUT std_logic_vector(IO_SIZE-1 DOWNTO 0);			
--	    DISP_SEL_1     	   		: OUT std_logic_vector(IO_SIZE-1 DOWNTO 0);	
																									 											  
		--Digitizer interface 0									  	          						   
	    DIGI_CLK   	   			: IN std_logic;  				  	          						   
	    DIGI_SYNC_IN   	   		: IN std_logic;  				  	          						   
	    DIGI_DATA_IN   	   		: IN std_logic_vector(15 downto 0); 				  	          						   
	    DIGI_FIFO_WE   	   		: IN std_logic;    
		DIGI_CLK_LOCK		    : IN std_logic; 	            						   
	    DIGI_DATA_OUT     		: OUT std_logic_vector(15 downto 0); 				  	          						   
	    DIGI_FIFO_WE_OUT   		: OUT std_logic;    
	    DIGI_RST   	   			: OUT std_logic;   
	    DIGI_EXT_RST   	 		: OUT std_logic;    
													 													 											  
		--DDR3 AXI interface									  	          						   
	    DDR_CLK   	   			: IN std_logic;  				  	          						   
	    DDR_READY   			: IN std_logic;  	  	  	          						   
	    DDR_WSTROBE	   	   		: IN std_logic;  			  	          						   
	    DDR_RSTROBE		  	  	: IN std_logic;  		      						   
	    DDR_RDATA   	   		: IN std_logic_vector(63 downto 0);  	        						   
	    DDR_RINDEX   	   		: IN std_logic_vector(8 downto 0);   		
	    DDR_RST_N   	   		: OUT std_logic; 			  	          						   
	    DDR_WE		   	   		: OUT std_logic;  				  	          						   
	    DDR_WADDR   	   		: OUT std_logic_vector(31 downto 0); 	        						   
	    DDR_WDATA   	   		: OUT std_logic_vector(63 downto 0); 			  	          						   
	    DDR_RE		   	   		: OUT std_logic;  				         						   
	    DDR_RADDR   	   		: OUT std_logic_vector(31 downto 0); 	        						   
	    DDR_WLEN   	   			: OUT std_logic_vector(3 downto 0); 	        						   
	    DDR_RLEN	   	   		: OUT std_logic_vector(3 downto 0);   	        						   
	    DDR_WINDEX   	   		: IN std_logic_vector(8 downto 0);    
		
		--DDR3 debugging  				  
	    DDR_DBG_AXI_BUSY  	   		: IN std_logic;     				  
	    DDR_DBG_WDONE  	   			: IN std_logic; 		 	
	    DDR_DBG_RDONE  	   			: IN std_logic; 	 
	
		--Algo interface 								  
		ALGO_RESET				: OUT std_logic; 
		RESET_XCVR_ERRORS		: OUT std_logic;

		
		ALGO_ADDR     	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);  	-- address -1 reserved for turning off output bus of all algo blocks 
		
		-- internal block address | top level block address
		ALGO_WDATA   	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   	   
		ALGO_RDATA				: IN std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   --bus
		
									 		  
		TCLK_TIMESTAMP_RESET		: OUT std_logic;  
		
		--PLL Signals, ctrl @ register 23
		PLL_START_PHASE_SHIFT		: OUT std_logic;   
		PLL_PHASE_DIRECTION			: OUT std_logic;
		PLL_RESET_PHASE				: OUT std_logic;
		PLL_TICK_COUNT				: OUT std_logic_vector(gAPB_DWIDTH-3 downto 0);	   
		
		--Timestamp Manager Control
		PLL_PhaseShift_Enable		: OUT std_logic;
		FinePhase_Enable			: OUT std_logic;
		
		--SEU Large SRAM interface		 		  
		SEU_WE					: OUT std_logic;	    
		SEU_RADDR				: OUT std_logic_vector(14 downto 0); 
		SEU_WADDR				: OUT std_logic_vector(14 downto 0);
		SEU_WDATA				: OUT std_logic_vector(17 downto 0); 
		SEU_RDATA				: IN std_logic_vector(17 downto 0);		   
		
		SEU_SRAM_ERRS  	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
		SEU_SRAM_RLOOPS	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);				   
		SEU_SRAM_BAD_LOC	  	: OUT std_logic_vector(31 DOWNTO 0);
		SEU_DDR3_ERRS  	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
		SEU_DDR3_RLOOPS	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	  
		SEU_DDR3_BAD_LOC	  	: OUT std_logic_vector(31 DOWNTO 0);	
	
	    --debugging 
		refclk_lock		    : IN  std_logic;            -- fabric refclk lock, for debugging		
		DEBUG_REG_0			: IN  std_logic_vector(15 downto 0);
		DEBUG_REG_1			: IN  std_logic_vector(15 downto 0);
		DEBUG_REG_2			: IN  std_logic_vector(15 downto 0);
		DEBUG_REG_3			: IN  std_logic_vector(15 downto 0);		  
		
		DEBUG_PREREAD_PULSE	: OUT STD_LOGIC;
		
	    RegOut  			: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0)
	);
end RocMonitor;	

architecture arch of RocMonitor is		  

-- signal, component etc. declarations											
	  																																                                        				
		                                        				
	--algo_clk signals                              				
	signal EPCS_ctrls_sig       					: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);		
	--	definition:
	-- 		0-7 for EPCS_0 ..except 3 := ALGO_RESET
	-- 		8-15 for EPCS_1 ..except 11 := undefined		  
	
	signal writeCounter								: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
	signal readCounter								: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
	signal apb_read_data 							: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);			
	signal tx_data_sig								: std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0); 		
	signal tx_epcs_data_sig							: std_logic_vector(gSERDES_DWIDTH-1 DOWNTO 0);		  
	signal algo_addr_sig     	   					: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 
	signal algo_wdata_sig							: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
																				
	signal fifoReadEnable                              : std_logic;	  
	signal roc_mon_addrs     	   					: std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
	signal roc_mon_wdata     	   					: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 	
	
	signal dcs_data									: std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH DOWNTO 0);
	signal dcs_data_next_packet						: std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH DOWNTO 0);	   
	signal dcs_Block_notDone						: std_logic;
	signal dcs_selected, dcs_we, dcs_re				: std_logic;
	signal dcs_mult_re, dcs_mult_we					: std_logic;
	signal dcs_selected_cnt							: unsigned(1 downto 0);			
	signal dcs_addr									: unsigned(gAPB_AWIDTH-1 downto 0);
	
	signal debug_preread_pulse_sig					: std_logic;
	signal debug_preread_pulse_sig_latch			: std_logic;
	
	--Digitzer signals
	signal digi_rst_sig								: std_logic ;					 
	signal digi_ext_rst_sig							: std_logic ;
	signal digi_wrCnt								: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
	signal digi_synCnt								: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	 
	signal digi_data_latch							: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	 
	signal digi_test_mode 							: std_logic;
	
	
	constant DIGI_SHR_SZ : natural := 4;
	type digiDataShr_t is array(DIGI_SHR_SZ downto 0) of std_logic_vector(15 downto 0);	 	
	signal digi_data_out_shr     	: digiDataShr_t;
	signal digi_fifo_we_out_shr		: std_logic_vector(DIGI_SHR_SZ downto 0);   
	
	--DDR3 signals					  
	signal ddr_we_sig, ddr_we_sig_old				: std_logic ;  
	signal ddr_re_sig, ddr_re_sig_old				: std_logic ;  
	signal ddr_rst_sig								: std_logic ;
	signal ext_DDR_RST_N_sig						: std_logic ;
	signal ddr_wlen_sig								: std_logic_vector(3 DOWNTO 0) ;
	signal ddr_state 								: std_logic_vector(7 DOWNTO 0) ;
	signal ddr_count 								: std_logic_vector(7 DOWNTO 0) ;
	signal ddr_wdata_sig							: std_logic_vector(63 DOWNTO 0);  
	signal ddr_curr_time							: std_logic_vector(15 DOWNTO 0);  
	signal ddr_max_time								: std_logic_vector(15 DOWNTO 0);	   
	signal ddr_seu_test								: std_logic ;    		
	signal ddr_seu_rloops_cnt							: unsigned(gAPB_DWIDTH-1 DOWNTO 0) ;
	signal ddr_seu_err_cnt								: unsigned(gAPB_DWIDTH-1 DOWNTO 0) ; 				   
											  												 																											  
	constant SH_RX_REG_DEPTH : natural := 15;  											 	  								   
	type shRxReg_t is array(natural range <>) of std_logic_vector(15 downto 0);  
	signal shRxReg 						: shRxReg_t(SH_RX_REG_DEPTH-1 downto 0);	  
	signal shRxReg_addr					: std_logic_vector(3 DOWNTO 0);	
												  												 																											  
	constant SM_MEM_DEPTH : natural := 16; 
	type small_mem_t is array(natural range <>) of std_logic_vector(63 downto 0);  
	signal small_mem 						: small_mem_t(SM_MEM_DEPTH-1 downto 0);	 
	
	
	
	--SEU Large SRAM signals					  
	signal seu_needs_to_write				: std_logic;   	 
	signal seu_waddr_sig, seu_raddr_sig, seu_raddr_sig_old		: unsigned(14 downto 0) ;	 
	signal seu_wdata_sig					: std_logic_vector(17 downto 0);			 
	signal seu_rloops_cnt					: unsigned(gAPB_DWIDTH-1 DOWNTO 0) ;
	signal seu_err_cnt						: unsigned(gAPB_DWIDTH-1 DOWNTO 0) ;
	
	signal event_delay_latch				: std_logic_vector(15 downto 0); 
	
	signal algo_reset_ctrl					: unsigned(4 downto 0);	
	signal algo_reset_initiate				: std_logic ;
	signal tsreset_sig						: std_logic;   
	signal rx_link_reset_sig				: std_logic;
	signal phase_shift_sig					: std_logic;	 
	
	signal dcs_stream_re					: std_logic;
	signal dcs_stream_we					: std_logic;   
	
	signal registerSix						: std_logic_vector(15 downto 0);
	signal registerSeven					: std_logic_vector(15 downto 0);	 
	signal registerNine					: unsigned(15 downto 0);
begin
	PREADY  <= not dcs_selected;
	PSLVERR <= '0';	   					 
	PRDATA <= apb_read_data;			
	
	roc_mon_addrs <= PADDR(gAPB_AWIDTH+4-1 downto 4) when dcs_selected = '0' else dcs_data(gAPB_AWIDTH+gAPB_DWIDTH-1 downto gAPB_DWIDTH); 
	roc_mon_wdata <= PWDATA when dcs_selected = '0' else dcs_data(gAPB_DWIDTH-1 downto 0);
	
	ALGO_ADDR <= algo_addr_sig;		
												   
	TCLK_TIMESTAMP_RESET <= tsreset_sig;
	
	-------------------------------------------------------------------------------
	--(1) ALGO and EPCS RESET sequence
	--	it will be initiated by clearing algo_reset_ctrl count to 0 -- REGISTER 0 (Write)
	-------------------------------------------------------------------------------			
   	process (algo_clk)
	begin		
		if (rising_edge(algo_clk)) then	   
									 
			ALGO_RESET <= '0';	
			--(1A) Outside Preset
			if (PRESETn = '0') then	   	 
				ALGO_RESET <= '1';		
			end if;	
		end if;
		
	end process;
		
	ALGO_WDATA <= algo_wdata_sig;
	DIGI_RST <= digi_rst_sig;	
	DIGI_EXT_RST <= digi_ext_rst_sig;	  
	
	DDR_WLEN <= ddr_wlen_sig;	  
	DDR_WDATA <= ddr_wdata_sig;		  
	DDR_RST_N <= ext_DDR_RST_N_sig;
	
	SEU_RADDR <= std_logic_vector(seu_raddr_sig);
	SEU_WADDR <= std_logic_vector(seu_waddr_sig);	
	SEU_WDATA <= seu_wdata_sig;	  
	seu_wdata_sig <= std_logic_vector(seu_waddr_sig(2 downto 0) & seu_waddr_sig);
	
	SEU_SRAM_ERRS  	<= std_logic_vector(seu_err_cnt); 
	SEU_SRAM_RLOOPS	<= std_logic_vector(seu_rloops_cnt); 
	SEU_DDR3_ERRS  	<= std_logic_vector(ddr_seu_err_cnt); 
	SEU_DDR3_RLOOPS	<= std_logic_vector(ddr_seu_rloops_cnt);  	
		
	-------------------------------------------------------------------------------
	-- SEU 
	-------------------------------------------------------------------------------		 							  
   	process (algo_clk)
	begin	
		if (rising_edge(algo_clk)) then	 
			SEU_WE <= '0'; 
			
			if ( ddr_rst_sig = '1' or PRESETn = '0' ) then
				seu_needs_to_write <= '1';		  
				seu_rloops_cnt <= (others => '0');
				seu_err_cnt <= (others => '0');	   
				seu_waddr_sig <= (others => '0'); 
				seu_raddr_sig <= (others => '0');
				SEU_WE <= '1';			 		
				SEU_SRAM_BAD_LOC <= (others => '0');
			elsif (seu_needs_to_write = '1') then 	
				
				-- there are 20*1024 locations
				if (seu_waddr_sig /= 20480-1) then 
					seu_waddr_sig <= seu_waddr_sig + 1;
					SEU_WE <= '1';		
				else
					seu_needs_to_write <= '0';
				end if;
				
			else -- read for seu upsets	
				
				seu_raddr_sig_old <= seu_raddr_sig;
				
				if (unsigned(SEU_RDATA) /= seu_raddr_sig_old(2 downto 0) & seu_raddr_sig_old) then
					seu_err_cnt <= seu_err_cnt + 1; --Error!?	
					--fix error and save location
					seu_waddr_sig <= seu_raddr_sig_old;
					SEU_WE <= '1';						
					SEU_SRAM_BAD_LOC(seu_raddr_sig_old'length-1 downto 0) <= std_logic_vector(seu_raddr_sig_old);
				end if;									
				
				seu_raddr_sig <= seu_raddr_sig + 1;
				if (seu_raddr_sig = 20480-1) then				
					seu_rloops_cnt <= seu_rloops_cnt + 1; --count loop done
					seu_raddr_sig <= (others => '0'); --reset error			
				end if;								
				
			end if;			
			
		end if;
	end process;
		
	-------------------------------------------------------------------------------
	-- DDR3 Domain
	--	Watchdog
	-------------------------------------------------------------------------------		 							  
   	process (DDR_CLK)
	begin										  
		if rising_edge(DDR_CLK) then	
			
			ddr_we_sig_old <= ddr_we_sig;  
			ddr_re_sig_old <= ddr_re_sig; 	
			
			DDR_WE <= ddr_we_sig;-- or ddr_seu_test;--'0';	   
			DDR_RE <= ddr_re_sig;--'0';
			
			if(DDR_WSTROBE = '1') then
				for i in 7 downto 0 loop
					ddr_wdata_sig(i*8+7 downto i*8) <= DDR_WINDEX(7 downto 0);	-- always write repeating count byte
				end loop;				  
			end if;						 
			
			if(DDR_RSTROBE = '1') then		
				small_mem(to_integer(unsigned(DDR_RINDEX(3 downto 0)))) <= DDR_RDATA(63 downto 0); 
			end if;			  
			
			if ddr_rst_sig = '1' or PRESETn = '0' then
				ddr_state <= (others => '0');  
				ddr_count <= (others => '0');	  
				shRxReg <= (others => (others => '0'));	 
				ddr_curr_time <= (others => '0');	
				ddr_max_time <= (0=>'1',others => '0');	
				
			else			 
				
				if (DDR_DBG_WDONE = '0' or DDR_DBG_RDONE = '0') then
					ddr_curr_time <= ddr_curr_time + 1;	  
				end if;		
				
				if (ddr_curr_time > ddr_max_time) then
					ddr_max_time <= ddr_curr_time;
				end if;				
			
			--	-- ddr seu testing
--				if (ddr_seu_test = '1') then   	 
--					
--					-- the write to DDR is initiated on rising edge of ddr_seu_test
--					if (DDR_DBG_WDONE = '1') then -- keep reading and checking
--						
--						DDR_RE <= DDR_DBG_RDONE; -- keep reading	 
--						
--						if( DDR_DBG_RDONE = '0') then -- starting another read loop
--							ddr_seu_rloops_cnt <= ddr_seu_rloops_cnt + 1;
--						end if;
--						
--						-- and keep checking   				   
--						if ( DDR_RDATA /= DDR_RINDEX(7 downto 0) & DDR_RINDEX(7 downto 0) & DDR_RINDEX(7 downto 0) & DDR_RINDEX(7 downto 0)	&
--							DDR_RINDEX(7 downto 0) & DDR_RINDEX(7 downto 0) & DDR_RINDEX(7 downto 0) & DDR_RINDEX(7 downto 0)) then
--							ddr_seu_err_cnt <= ddr_seu_err_cnt + 1;
--						end if;
--						
--					else   -- consider to be reset of seu testing
--						ddr_seu_rloops_cnt <= (others => '0');
--						ddr_seu_err_cnt <= (others => '0');
--					end if;
--					
--				end if;
				
				
				--
--				if(DDR_WBUSY = '0' and ddr_we_sig_old = '0' and ddr_we_sig = '1') then -- rising we 
--					ddr_state <= x"01";	  
--					--DDR_WE <= '1';	  
--					ddr_count <= x"01";	
--				elsif(DDR_RBUSY = '0' and ddr_re_sig_old = '0' and ddr_re_sig = '1') then -- rising re 
--				   	ddr_state <= x"02";	 
--					--DDR_RE <= '1';
--				end if;	   
--				
--				if(ddr_state(3 downto 0) = x"1") then --writing	  
--					
--					
--					
--					--Notes on how AXI interface works:
--						-- once write starts WBUSY = '1' 
--						-- WNEXT is on 4th clocks the first time
--							-- and then every other clock after that
--								   
--					
--					if (unsigned(ddr_state(7 downto 4)) /= 15) then						
--						
--						ddr_state(7 downto 4) <= ddr_state(7 downto 4) + 1;		  
--						
--						--shRxReg(SH_RX_REG_DEPTH-1 downto 1) <= shRxReg(SH_RX_REG_DEPTH-2 downto 0);
--                       -- shRxReg(0) <= DDR_READY & DDR_RBUSY & 
--						--	DDR_WBUSY & DDR_WNEXT & ddr_state(7 downto 4) & ddr_count;
--						
--						small_mem(to_integer(unsigned(ddr_state(7 downto 4)))) <= 	
--						
--							ddr_wdata_sig(39 downto 0) & -- 40 wdata bits
--							-- 8 individual bits
--						"0" & 
--						DDR_WSTROBE	 &
--						DDR_DBG_WLAST   		 &
--						DDR_DBG_WVALID  		&
--						DDR_DBG_AWVALID  	   &
--						DDR_DBG_AXI_BUSY  	  &
--						DDR_DBG_WDONE  	  	 &	
--						DDR_DBG_RDONE  	  	 &		 
--					 	DDR_DBG_AWADDR  &  -- 8 bits --bits 14 downto 7 of AWADDR	
--						DDR_WINDEX(7 downto 0);
--					end if;
--					
--				elsif(ddr_state(3 downto 0) = x"2") then --reading	  
--					
--					if (DDR_DBG_RDONE = '0') then
--						ddr_curr_time <= ddr_curr_time + 1;
--					end if;
--					
--					if (unsigned(ddr_state(7 downto 4)) /= 15) then	   	
--						
--						ddr_state(7 downto 4) <= ddr_state(7 downto 4) + 1;
--						
--						--shRxReg(SH_RX_REG_DEPTH-1 downto 1) <=  --shRxReg(SH_RX_REG_DEPTH-1 downto 5) <= 
--						--	shRxReg(SH_RX_REG_DEPTH-2 downto 0); --shRxReg(SH_RX_REG_DEPTH-6 downto 0);
--						--shRxReg(0) <= DDR_READY & DDR_RBUSY & 
--						--	DDR_WBUSY & DDR_WNEXT & ddr_state(7 downto 4) & DDR_RINDEX(3 downto 0) & DDR_RDATA(3 downto 0);
--						--shRxReg(3) <= DDR_RDATA(32+31 downto 32+16);
--						--shRxReg(2) <= DDR_RDATA(32+15 downto 32+0);
--						--shRxReg(1) <= DDR_RDATA(31 downto 16);
--						--shRxReg(0) <= DDR_RDATA(15 downto 0);  			  
--										  
--						small_mem(to_integer(unsigned(ddr_state(7 downto 4)))) <= 
--							
--						DDR_RDATA(39 downto 0) & --40 rdata bits   
--									   
--							 DDR_DBG_RLAST  	&   	
--							 DDR_DBG_ARVALID  	 &
--							 DDR_DBG_RVALID  	 &
--							 DDR_DBG_ARREADY  	  &
--							 DDR_DBG_RREADY  	   & 	
--						 	 DDR_DBG_AXI_BUSY  	  &
--							 DDR_RSTROBE   &	                
--							 DDR_DBG_RDONE  		&
--							
--							 DDR_DBG_ARADDR	 &  -- 8 bits --bits 14 downto 7 of ARADDR	
--							 DDR_RINDEX(7 downto 0);	
--											  
--					end if;	   
--					
--				end if;	  			
					
			end if;
					   
		end if;
	end process;
	
	
	
	
	
	-------------------------------------------------------------------------------
	-- Digitizer Domain
	--	Count inputs
	-------------------------------------------------------------------------------
	
	gen_for_digi : for i in 0 downto 0 generate		
		signal digi_test_data : std_logic_vector(15 downto 0);
	begin
	   	process (DIGI_CLK)
		begin										  
			if rising_edge(DIGI_CLK) then			 
				
				
				DIGI_DATA_OUT <= digi_data_out_shr(DIGI_SHR_SZ);															 	 
				DIGI_FIFO_WE_OUT <= digi_fifo_we_out_shr(DIGI_SHR_SZ);
				digi_data_out_shr(DIGI_SHR_SZ downto 1) <= digi_data_out_shr(DIGI_SHR_SZ-1 downto 0);
				digi_fifo_we_out_shr(DIGI_SHR_SZ downto 1) <= digi_fifo_we_out_shr(DIGI_SHR_SZ-1 downto 0);
									   				
				if (digi_rst_sig = '1') then	
					digi_wrCnt <= (others => '0');	
					digi_synCnt <= (others => '0');
					digi_data_latch <= (others => '0');
				else 
					if (DIGI_SYNC_IN = '1') then
						digi_synCnt <= digi_synCnt + 1;
					end if;	 
					if (DIGI_FIFO_WE = '1') then
						digi_wrCnt <= digi_wrCnt + 1;	
						digi_data_latch <= DIGI_DATA_IN;
					end if;						 
				
							   -- note: this adds one clock of delay between SerialIn and fifo
					if (digi_test_mode = '0') then
						digi_data_out_shr(0) <= DIGI_DATA_IN;	 
						digi_fifo_we_out_shr(0) <= DIGI_FIFO_WE;
					else							   
						digi_test_data <= digi_test_data + 1;
						
						if( unsigned(digi_test_data(4 downto 0)) = 0) then	--sparsify test a bit							
							digi_data_out_shr(0) <= digi_test_data;
							digi_fifo_we_out_shr(0) <= '1';									 
						end if;	 					
						
					end if;
					
					
				end if;		   
			end if;
		end process;	 		 
	end generate;

	-------------------------------------------------------------------------------
	-- algo_clk Domain
	--	Handle APB Write and Read Commands
	-------------------------------------------------------------------------------
	process (algo_clk)
	begin							 
		
		
		if rising_edge(algo_clk) then		
			DEBUG_PREREAD_PULSE					<= '0';
		    debug_preread_pulse_sig				<= '0';	 
			debug_preread_pulse_sig_latch		<= debug_preread_pulse_sig;
			PLL_START_PHASE_SHIFT				<= '1';	                		
			DCS_RCV_FIFO_RE <= '0'; 	
			DCS_RESP_FIFO_WE <= '0'; 
			dcs_we <= '0';	
			dcs_re <= '0';		 
			algo_reset_initiate <= '0';
			RESET_XCVR_ERRORS <= '0';	
			SEL_RST			<= '0';
			SEL_RST_CNTL	<= (others => '0');
			DCS_ALIGNMENT_REQ	<= '0';	  
			dbgSerialFifo_we    <= '0';
			dbgSerialFifo_re	<= '0';	   
			dbgSerialFifo_rst	<= '0';
		 
			
			if (PRESETn = '0') then			 
				registerNine				<= (others => '0');
                fifoReadEnable              <= '0';		
				dbgSerialFifo_rst			<= '1';
				event_delay_latch 			<= (OTHERS => '0');
				EVENT_START_DELAY_FINE_TCLK	<= (OTHERS => '0');
				DCS_ALIGNMENT_REQ			<= '1';	
				dcs_selected 				<= '0';
				dcs_we 						<= '0';
				dcs_re						<= '0';
				dcs_selected_cnt			<= (others => '0');
				apb_read_data 				<= (others => '0');  				
				tx_data_sig					<= (others => '0');	
                tx_epcs_data_sig  		  	<= (others => '0');	  
				writeCounter 				<= (others => '0');  
				readCounter 				<= (others => '0');    
																	 
                FORCE_DISP_0 				<= (others => '0'); -- default to automatic disparity
                DISP_SEL_0 					<= (others => '0'); -- only active when FORCE_DISP active
				RegOut 						<= (others => '0');			
				
				digi_rst_sig <= '0';	
				ext_DDR_RST_N_sig <= '1';	
				DDR_RLEN <= x"4";	 
				ddr_wlen_sig <= x"4"; 
				DDR_WADDR <= (others => '0'); 
				DDR_RADDR <= (others => '0');	 
				
				algo_wdata_sig <= (others => '0');
				algo_addr_sig <= (others => '0');
				
				--PLL Interface		
				PLL_PhaseShift_Enable				<= '0';
				PLL_RESET_PHASE						<= '0';  
				PLL_PHASE_DIRECTION					<= '1';	
				PLL_TICK_COUNT						<= (others => '0'); 	  		
			else		  			  
							  		   						 
				----------------------------------	  
				if(dcs_selected = '1') then -- handle dcs command mode	  
					-- increment counter											  
					dcs_selected_cnt <= dcs_selected_cnt + 1;
					fifoReadEnable      <= '0';
			 					
					if (dcs_selected_cnt = 0) then		
						-- DCS Rcv FIFO Data Format:
						-- 		-- W/R (32) | Addr(31:16) | WData(15:0)	
						-- DCS Resp FIFO Data Format:
						-- 		DCS_RCV_FIFO_EMPTY(32)  Addr(31:16) | RData(15:0)	
						if (DCS_RCV_FIFO_Q(32) = '0') then	
							DEBUG_PREREAD_PULSE	 	<= '1';
							
							if (unsigned(DCS_RCV_FIFO_Q(31 downto 16)) = 42 and dbgSerialFifo_empty = '0') then   
								dbgSerialFifo_re	<= '1';		
							end if;	   	
						end if;			
					
						dcs_data <= DCS_RCV_FIFO_Q;			
						dcs_addr <= unsigned(DCS_RCV_FIFO_Q(31 DOWNTO 16));
					elsif (dcs_selected_cnt = 1) then -- data must be ready out of FIFO 
						
						if (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH) = '1') then 		--  Write
							dcs_we 		<= '1';	   	-- write				  	-- If Fifo addr... then register gets ready for transfer
						elsif (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH)= '0') then 	--  Read 
						    dcs_re 		        <= '1'; 						-- read	
						end if;	
						
					elsif (dcs_selected_cnt = 2) then  							-- read data should be in apb_read_data by now 	  				
						--Write Packet to DCS
							if (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH) = '0') then   -- write flag is '0'/(READ OP)
								DCS_RESP_FIFO_WE 			<= '1';	 -- read  
								DCS_RESP_FIFO_DATA 			<= DCS_RCV_FIFO_EMPTY & roc_mon_addrs & apb_read_data;      --_FIFO_EMPTY |Addr(31:16) | RData(15:0)	
							elsif (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH) = '1') then 	--save to FIFO
				   
								if (unsigned(DCS_RCV_FIFO_Q(31 downto 16)) = 42 and dbgSerialFifo_full = '0') then 
									dbgSerialFifo_we			<= '1';		
								end if;
							end if;	   		   
						dcs_selected <= '0'; -- done!
					end if;							
				end if;	
----------------------------------------------------------------------------------------------			
				--<A NAME="DCS REGISTER WRITE">
				----------------------------------		
				if ((dcs_selected = '0' and PWRITE = '1' and PSEL = '1' and PENABLE = '1') or
					(dcs_selected = '1' and dcs_we = '1')) then	--write command	  
														   
					writeCounter <= writeCounter + 1;
														
					if (roc_mon_addrs = 0) then				   --RESET ALL
						SEL_RST			<= '1';
						SEL_RST_CNTL	<= (others => '1');
						--EPCS_ctrls_sig <= roc_mon_wdata; 
						--algo_reset_initiate <= roc_mon_wdata(0); 
						--rx_link_reset_sig <= roc_mon_wdata(1);
					elsif (roc_mon_addrs = 1) then		 	  -- SELECTIVE RESET 
						SEL_RST			<= '1';
						SEL_RST_CNTL	<= roc_mon_wdata(9 downto 0);	  -- 1/HI reset to the associated block 
					elsif (roc_mon_addrs = 2) then		 	  --					
						tx_data_sig(15 downto 0) <= roc_mon_wdata;	
                        tx_epcs_data_sig(15 downto 0) <= roc_mon_wdata;
					elsif (roc_mon_addrs = 3) then		 
                        tx_epcs_data_sig(19 downto 16) <= roc_mon_wdata(3 downto 0);					
					elsif (roc_mon_addrs = 4) then		 	 												  						  
						ddr_wlen_sig <= roc_mon_wdata(3 downto 0);			 	 				
						DDR_RLEN <= roc_mon_wdata(7 downto 4);					
						ddr_rst_sig <= roc_mon_wdata(8);	 					
						ext_DDR_RST_N_sig <= roc_mon_wdata(9);				
						ddr_we_sig <= roc_mon_wdata(12);	 				
						ddr_re_sig <= roc_mon_wdata(13);
					elsif (roc_mon_addrs = 5) then	
						DDR_WADDR(15 downto 0) <= roc_mon_wdata;
						DDR_RADDR(15 downto 0) <= roc_mon_wdata;
					elsif (roc_mon_addrs = 6) then		
						registerSix 		<= roc_mon_wdata;
						
						--DDR_WADDR(31 downto 16) <= roc_mon_wdata;	
--						DDR_RADDR(31 downto 16) <= roc_mon_wdata;	
					elsif (roc_mon_addrs = 7) then		 	
						 registerSeven 		<= roc_mon_wdata;
						--shRxReg_addr <= roc_mon_wdata(3 downto 0);
					elsif (roc_mon_addrs = 8) then		 	 				
						RegOut <= roc_mon_wdata;							 
					elsif (roc_mon_addrs = 9) then		 	 				
						FORCE_DISP_0 <= roc_mon_wdata(IO_SIZE-1 downto 0);
				--		FORCE_DISP_1 <= roc_mon_wdata(8+IO_SIZE-1 downto 8+0);
					elsif (roc_mon_addrs = 10) then		 	 				
						DISP_SEL_0 <= roc_mon_wdata(IO_SIZE-1 downto 0);	
				--		DISP_SEL_1 <= roc_mon_wdata(8+IO_SIZE-1 downto 8+0);					 
					elsif (roc_mon_addrs = 12) then			 --Step 1 of write/read block
						algo_addr_sig <= roc_mon_wdata;
					elsif (roc_mon_addrs = 13) then			 --Step 2 of read block  (IF WRITE ONLY, THEN DONE)
						algo_wdata_sig <= roc_mon_wdata;
					elsif (roc_mon_addrs = 14) then	
						digi_rst_sig <= roc_mon_wdata(0);
                        digi_ext_rst_sig <= roc_mon_wdata(4);	   
						digi_test_mode <= roc_mon_wdata(8);	   	
					elsif (roc_mon_addrs = 15) then	   
						ddr_seu_test <= roc_mon_wdata(0);   	
					elsif (roc_mon_addrs = 16) then	   		
						ddr_seu_err_cnt <= unsigned(roc_mon_wdata);   	
					elsif (roc_mon_addrs = 17) then	   		
						ddr_seu_rloops_cnt <= unsigned(roc_mon_wdata);	 
					elsif (roc_mon_addrs = 18) then	   		
						SEU_DDR3_BAD_LOC(15 downto 0) <= roc_mon_wdata;	 
					elsif (roc_mon_addrs = 19) then	   		
						SEU_DDR3_BAD_LOC(31 downto 16) <= roc_mon_wdata;	
					elsif (roc_mon_addrs = 20) then	   		
						tsreset_sig <= roc_mon_wdata(0);	
					elsif (roc_mon_addrs = 21) then
						EVENT_START_DELAY_FINE_TCLK		<= roc_mon_wdata;	
						event_delay_latch 				<= roc_mon_wdata;		
                    elsif (roc_mon_addrs = 22) then
						DCS_ALIGNMENT_REQ				<= roc_mon_wdata(0);   		  
					elsif (roc_mon_addrs = 23) then		  --Pre-load PLL Phase Shift	
						PLL_PhaseShift_Enable				<= '1';
						PLL_START_PHASE_SHIFT				<= '0';	                --Pre-Load 
						PLL_RESET_PHASE						<= roc_mon_wdata(gAPB_DWIDTH-1);  
						PLL_PHASE_DIRECTION					<= roc_mon_wdata(gAPB_DWIDTH-2);	
						PLL_TICK_COUNT						<= roc_mon_wdata(gAPB_DWIDTH-3 downto 0); 	  
					elsif roc_mon_addrs = 24 then
						RESET_XCVR_ERRORS					<= '1';				  
					elsif roc_mon_addrs = 25 then
						PLL_PhaseShift_Enable				<= roc_mon_wdata(0);
						FinePhase_Enable					<= roc_mon_wdata(1);	
					elsif (roc_mon_addrs = 42) then
						--Serial Fifo One Read
						dbgSerialFifo_dataOut 				<= roc_mon_wdata;
					end if;										 									  
					
------------------------------------------------------------------------------------------------------					
				--<A NAME="DCS REGISTER READ">
				----------------------------------
				elsif ((dcs_selected = '0' and PWRITE = '0' and PSEL = '1') or
						(dcs_selected = '1' and dcs_we = '0')) then	 --read command	
					
					if (PENABLE = '1' or dcs_re = '1') then 	--indicates when the data is taken
						readCounter <= readCounter + 1;  
					end if;			  

                    apb_read_data <= (others => '0');
				
					if (roc_mon_addrs = 0) then		 						
						apb_read_data 	<= DEBUG_REG_0;
					elsif (roc_mon_addrs = 1) then	
						apb_read_data 	<= DEBUG_REG_1;	
					elsif (roc_mon_addrs = 2) then	 
						apb_read_data 	<= DEBUG_REG_2; 	
					elsif (roc_mon_addrs = 4) then		 	 
						apb_read_data 	<= DEBUG_REG_3;			
					elsif (roc_mon_addrs = 5) then		 	 
						apb_read_data <= readCounter;	
					elsif (roc_mon_addrs = 6) then		 			-- debugging signals 						
						apb_read_data <= DEBUG_REG_0;--ddr_curr_time;		   
					elsif (roc_mon_addrs = 7) then	 
						apb_read_data <= event_delay_latch;--ddr_max_time;	 
					elsif (roc_mon_addrs = 8) then				
						apb_read_data	<= XCVR_LOSS_COUNTER;
					elsif (roc_mon_addrs = 9) then		 
						apb_read_data 	<= std_logic_vector(registerNine);	  
						registerNine	<= registerNine + 1;
					elsif (roc_mon_addrs = 10) then		 
						apb_read_data <= digi_wrCnt; 	
					elsif (roc_mon_addrs = 11) then		 
						apb_read_data <= digi_data_latch;	
					elsif (roc_mon_addrs = 12) then		 
						apb_read_data <= DIGI_DATA_IN;		
					elsif (roc_mon_addrs = 13) then		 
						apb_read_data(0) <= digi_rst_sig;			   	 
						apb_read_data(4) <= digi_ext_rst_sig;	 
						apb_read_data(8) <= digi_test_mode;	 
						apb_read_data(12)<= DIGI_CLK_LOCK;	
						apb_read_data(1) <= tsreset_sig;
					elsif (roc_mon_addrs = 14) then		 			--	 						   			 
						apb_read_data <= algo_addr_sig;		
					elsif (roc_mon_addrs = 15) then	 
						apb_read_data <= RX_EPCS_DATA_0(15 downto 0);	 		   		
					elsif (roc_mon_addrs = 16) then		 	 
					--	apb_read_data <= x"0" & tx_epcs_data_sig(19 downto 16) & RX_EPCS_DATA_1(19 downto 16) & RX_EPCS_DATA_0(19 downto 16);
						apb_read_data <= x"0" & tx_epcs_data_sig(19 downto 16) & x"0" & RX_EPCS_DATA_0(19 downto 16);
					--elsif (roc_mon_addrs = 17) then	 
--						apb_read_data <= RX_EPCS_DATA_1(15 downto 0);	 		   		
					elsif (roc_mon_addrs = 18) then	
						apb_read_data <= std_logic_vector(ddr_seu_rloops_cnt);
					elsif (roc_mon_addrs = 20) then	 
						apb_read_data <= tx_epcs_data_sig(15 downto 0);	 		   		
					elsif (roc_mon_addrs = 21) then		 	 			 
						apb_read_data <= algo_wdata_sig;  
					elsif (roc_mon_addrs = 22) then		--Step 3 of read block 	 
						apb_read_data <= ALGO_RDATA;    	   			
					elsif (roc_mon_addrs = 23) then		 	 
						apb_read_data <= DDR_READY & DDR_DBG_RDONE & 
							DDR_DBG_WDONE & DDR_DBG_AXI_BUSY & ddr_count(3 downto 0) & ddr_state;    	  		
					elsif (roc_mon_addrs = 24) then	  								   
						apb_read_data <= shRxReg(to_integer(unsigned(shRxReg_addr)));		 	  		
					elsif (roc_mon_addrs = 25) then	  
						apb_read_data <= DDR_RINDEX(3 downto 0) & DDR_RDATA(11 downto 0);	   		 	  		
					elsif (roc_mon_addrs = 26) then	  		 	  								   
						apb_read_data <= small_mem(to_integer(unsigned(shRxReg_addr)))(0*16+15 downto 0*16);
					elsif (roc_mon_addrs = 27) then	  		 	  		  
						apb_read_data <= small_mem(to_integer(unsigned(shRxReg_addr)))(1*16+15 downto 1*16);
					elsif (roc_mon_addrs = 28) then	  	
						apb_read_data <= small_mem(to_integer(unsigned(shRxReg_addr)))(2*16+15 downto 2*16);	 	  		
					elsif (roc_mon_addrs = 29) then	 
						apb_read_data <= small_mem(to_integer(unsigned(shRxReg_addr)))(3*16+15 downto 3*16); 		  		
					elsif (roc_mon_addrs = 30) then	 	
						apb_read_data <= std_logic_vector(seu_err_cnt);
					elsif (roc_mon_addrs = 31) then	 	  			  
						apb_read_data <= std_logic_vector(seu_rloops_cnt); 
					elsif (roc_mon_addrs = 32) then	 
						apb_read_data <= registerSix;
					elsif (roc_mon_addrs = 33) then
						apb_read_data <= registerSeven;	  
					elsif (roc_mon_addrs = 34) then
						apb_read_data <= EPCS_ctrls_sig;
                    elsif (roc_mon_addrs = 35) then
                        apb_read_data <= "00000" & dbgSerialFifo_rdCnt;	   
					elsif (roc_mon_addrs = 42) then
						--Serial Fifo One Read
						apb_read_data	<=	dbgSerialFifo_dataIn ;			
					else	
						apb_read_data <= roc_mon_addrs;		  --Unmapped Addresses
					end if;								  							   		   
				elsif (dcs_selected = '0' and DCS_RCV_FIFO_EMPTY = '0') then 	
						DCS_RCV_FIFO_RE 		<= '1';
						dcs_selected 			<= '1'; 	
						dcs_selected_cnt 		<= (others => '0');  		   		   
				end if;	  	
			end if;
		end if;
	end process;		
							 
								
	
end architecture;

--================================= End ===================================--
