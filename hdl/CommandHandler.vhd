--------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: CommandHandler.vhd
-- File history:
--      v00: Feb 25, 2015: Birthday
--		V01: August 7th, 2015 
-- Description: 
-- CommandHandler reads 2x FIFOs
--	* handle Readout Request(1) or Data Request(2) or DCS Request(0)
-- 	* Readout Request (broadcast)
-- 		* refers to taking beam for the next super clock 
-- 		* data will be tagged by super clock
--		* data is saved to giant memory (can buffer ~1s)		 	   
--	* Data Request (point-to-point)
--		* readout all data from requested tag from giant memory	   
--		* NOTE: assume "timestamp" tag does not wrap around
--	* DCS Request (point-to-point)
--		* respond with status and errors
--	* Note: Always respond back on the same link into 2x ResponseFifo
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

entity CommandHandler is       
	Generic (		   
			DATAREQ_DWIDTH				: integer := 64;		 
			DATAREQ_EVENT_WINDOW_SIZE	: integer := EVENT_WINDOW_TAG_SIZE;
            gAPB_DWIDTH     			: integer := 16;  
            gAPB_AWIDTH     			: integer := 16;	 
            gSERDES_DWIDTH  			: integer := 20; 
            gENDEC_DWIDTH   			: integer := 16;	
            IO_SIZE         			: integer := 2;
			ALGO_LOC_ADDR 				: natural := 0	 
		);               
		port(		   
                ALGO_CLK                       	: IN std_logic;       
                RESET_N                       	: IN std_logic;	   	  
				INTERNAL_RESET					: IN STD_LOGIC;
				
				-- Debug Serial Data Interface	
				dbgSerialFifo_re 				: OUT std_logic;	
				dbgSerialFifo_rst 				: OUT std_logic;		
				dbgSerialFifo_full 				: IN std_logic;																																 
				dbgSerialFifo_empty				: IN std_logic;					   
				dbgSerialFifo_rdCnt 			: IN std_logic_vector(10 downto 0);																											
				dbgSerialFifo_data 				: IN std_logic_vector(15 downto 0);
				
																 
				--DCS FIFO interface					  															
			    DCS_RCV_FIFO_EMPTY				: IN  std_logic;            													
			    DCS_RCV_FIFO_FULL				: IN  std_logic;    	
			    DCS_RCV_FIFO_DATA				: OUT  std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH downto 0);    -- W/R | Addr(31:16) | WData(15:0)	   		   	
				DCS_RCV_FIFO_WE 				: OUT  std_logic;       
				                        		
			    DCS_RESP_FIFO_EMPTY				: IN  std_logic;            													
			    DCS_RESP_FIFO_FULL				: IN  std_logic;    	
			    DCS_RESP_FIFO_Q					: IN  std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH downto 0);    --  DCS_RCV_FIFO_EMPTY | Addr(31:16) | RData(15:0)
				DCS_RESP_FIFO_RD_CNT			: IN  STD_LOGIC_VECTOR(9 downto 0);
				DCS_RESP_FIFO_RE 				: OUT  std_logic; 
				                        		
				DCS_RESET_FIFOS 				: OUT  std_logic;   
				
																
				
				-- RocMonitor Interface			
				ALGO_RESET						: IN std_logic;
				ALGO_ADDR 						: IN std_logic_vector(gAPB_DWIDTH-1 downto 0);	 	  
				ALGO_WDATA						: IN std_logic_vector(gAPB_DWIDTH-1 downto 0);	
				ALGO_RDATA						: inout std_logic_vector(gAPB_DWIDTH-1 downto 0);
				                        		
				                        		
				                        		
				SEU_SRAM_ERRS  	   				: IN std_logic_vector(gAPB_DWIDTH-1 downto 0);
				SEU_SRAM_RLOOPS	   				: IN std_logic_vector(gAPB_DWIDTH-1 downto 0); 			   
				SEU_SRAM_BAD_LOC	  			: IN std_logic_vector(31 downto 0);
				SEU_DDR3_ERRS  	   				: IN std_logic_vector(gAPB_DWIDTH-1 downto 0);
				SEU_DDR3_RLOOPS	   				: IN std_logic_vector(gAPB_DWIDTH-1 downto 0);
				SEU_DDR3_BAD_LOC	  			: IN std_logic_vector(31 downto 0);	
		                                		
				-- ResponseFifo_0 Interface
		        RESP_FIFO_DATA_0 				: OUT std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				RESP_FIFO_WE_0 					: OUT std_logic;	  	 
				RESP_FIFO_RESET_0 				: OUT std_logic;
				RESP_FIFO_FULL_0 				: IN std_logic;	  				   
				
				HEARTBEAT_EVENT_WINDOW_TAG		: OUT STD_LOGIC_VECTOR(DATAREQ_EVENT_WINDOW_SIZE-1 downto 0);
				
			--	-- Data Request	 (Request Side)		
				DATAREQ_START_EVENT_REQ			: OUT STD_LOGIC;  							--gimme Event Window Flag	
				DATAREQ_EVENT_WINDOW_TAG_1		: OUT STD_LOGIC_VECTOR(DATAREQ_EVENT_WINDOW_SIZE-1 downto 0);		--TAG 1 
				DATAREQ_EVENT_WINDOW_TAG_2		: OUT STD_LOGIC_VECTOR(DATAREQ_EVENT_WINDOW_SIZE-1 downto 0);		--Optional		 
				                                
				--Data Request (Reply Side) 	
				DATAREQ_DATA_READY_FLAG			: IN  STD_LOGIC;
				DATAREQ_LAST_WORD_FLAG			: IN  STD_LOGIC;			   
				DATAREQ_STATUS					: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
				DATAREQ_DATA_REQ_REPLY			: IN  STD_LOGIC_VECTOR(DATAREQ_DWIDTH-1 downto 0);		   --Data Reply
				DATAREQ_PACKETS_IN_EVENT		: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
				
				DATAREQ_RE_FIFO					: OUT STD_LOGIC; 
				
				-- ReceiveFifo_0 Interface  	
		        RCV_FIFO_Q_0 					: IN std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				RCV_FIFO_RE_0 					: OUT std_logic;	
				RCV_FIFO_RESET_0				: OUT std_logic;	
				RCV_FIFO_EMPTY_0 				: IN std_logic		
        );
end CommandHandler;
                                                                                                   

architecture arch of CommandHandler is    
   	--=======================		  
	--<A NAME="standard RocMonitor interface template">--
	signal rst_cmd	: 	std_logic		;														
	signal enable	:	std_logic		;						  
	
	signal status						: std_logic_vector(gAPB_DWIDTH-1 downto 0);		
	signal status_operation				: std_logic_vector(3 downto 0);
		-- status bit def:
		-- 15:0 state		  
		-- 15 : enable
		-- 14 : rst_cmd
		---13
		-- 12
		-- 11
		-- 10
		-- 9
		-- 8
		-- 7
		-- 6
		-- 5
		-- 4
		-- 3
		-- 2	: S_rcv
		-- 1
		-- 0
		
	signal errors						: std_logic_vector(gAPB_DWIDTH-1 downto 0);		
		-- errors bit def:
			-- 0 undef packet type received
			-- 1 invalid data readout timestamp		
			-- 2 been to drain state	
			-- 3 invalid packet format		  
			-- 4 read timeout
	
	constant ERROR_UndefinedPacketType 		: natural := 0;		 	
	constant ERROR_InvalidReadoutTimestamp 	: natural := 1;
	constant ERROR_HasDrained 				: natural := 2;				 
	constant ERROR_UndefinedPacketFormat 	: natural := 3;  	 
	constant ERROR_ReadTimeout 				: natural := 4;		 
	constant ERROR_CountMismatch			: natural := 5;
					     	
	--=======================		
	
	--==============================
	---Debug Signals---	   
	signal one_bit_sig						: std_logic;
	---====================
	
	--<A NAME="main signals">	  	
	type state_t is (
		S_waitForCRCCheck,
		S_DataReqHeader,  
		S_DataReqDataRead,
		S_DcsReply,
		S_DcsAck,  	 
		S_DcsReadSingleResp, 
		S_DcsWriteBlockEmptyRecvFifo,
		S_DcsReadSingleTransferToSender,   
		S_DcsReadDoubleResp,
		S_DcsReadDoubleTransferToSender,
		S_DcsReadBlockReq,	
		S_DcsReadBlockResp,	 
		S_DcsReadBlockPacketFill,	
		S_DcsReadBlockTransferToSender,	
		S_DcsWriteBlockWaitForNext,
		S_DcsWriteBlockReq,
		S_DbgDataGen,
		S_DbgDataHdrGen,
		S_DbgData,
		S_ReadReq,
		S_DataReq,
		S_DcsReq,
		S_Done,
		S_Drain,
		S_Rcv,
		S_Start,
		S_Reset,
		S_Idle 
		); 	  
	signal state : state_t := S_Idle;	
	
	type dcsReq_state is (
		None,
		DCSWriteSingle,
		DCSWriteDouble,	
		DCSWriteBlock,
		DCSReadSingle, 		
		DCSReadDouble,
		DCSReadBlock,
		DCSCheckCnt		
		); 			 
		
	signal dcsReq_op 										: dcsReq_state ;	
	signal dcs_standby										: std_logic;		
	signal lastOpOfPacket									: std_logic;
	signal rcvFifoRe0_mask									: std_logic;	     	  --<A NAME="SIGNALS">	 
	signal rcvCnt											: unsigned(4 downto 0);			
	signal rcv0_packet_count   								: unsigned(gENDEC_DWIDTH-1 downto 0);
	signal rcv1_packet_count   								: unsigned(gENDEC_DWIDTH-1 downto 0);	   
	signal resp_fifo_full_cnt  								: unsigned(gENDEC_DWIDTH-1 downto 0);	
	signal rReqCnt, dReqCnt, dcsReqCnt						: unsigned(gENDEC_DWIDTH-1 downto 0);		   	  
	signal rcv_data     	   								: std_logic_vector(gENDEC_DWIDTH-1 downto 0);
	
	signal resp_fifo_data,resp_fifo_data_latch  	   		: std_logic_vector(gENDEC_DWIDTH-1 downto 0); 	
	signal resp_fifo_we,resp_fifo_we_latch					: std_logic ;	 			     	
	
	constant SH_RX_REG_DEPTH : natural := 15;											 	  								   
	type shRxReg_t is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	signal shRxReg 											: shRxReg_t(SH_RX_REG_DEPTH-1 downto 0);			
				                        					
	signal packetType, lastPacketType						: unsigned(3 downto 0);			  			
	signal reqEventWindowTag								: unsigned(6*8-1 downto 0);		--6 bytes	  --		* NOTE: assume "timestamp" tag does not wrap around
	signal write_timestamp, read_timestamp 										: unsigned(6*8-1 downto 0);		--6 bytes		    
	signal takeData											: std_logic ; -- indicates to take data next super clock	 
	signal dbgDataPacketCnt									: unsigned(15 downto 0);	
	signal dataReqDataReadCnt								: unsigned(15 downto 0);
	signal first_read										: std_logic ;	  	
	                                    					
	signal req_for_dbg_serial								: std_logic ;	   
	signal dbgSerialFifo_rst_sig 							: std_logic;		
	signal dbgSerialFifo_fullCnt 							: unsigned(7 downto 0) ;
	signal dbgSerialFifo_emptyCnt 							: unsigned(7 downto 0) ;	
	signal last_dbg_type_req   								: std_logic_vector(3 downto 0) ; 	   
	
	signal dcsReq_opCode		   							: unsigned(2 downto 0);	
	
	constant DCS_OPCODE_Read 		: natural := 0;
	constant DCS_OPCODE_Write 		: natural := 1;
	constant DCS_OPCODE_BlockRead 	: natural := 2;
	constant DCS_OPCODE_BlockWrite 	: natural := 3;	 
	constant DCS_OPCODE_DoubleRead 	: natural := 4;
	constant DCS_OPCODE_DoubleWrite : natural := 5;	
	
	signal dcsReq_blockAddrMode								: std_logic;				 
	signal dcsReq_reqAck									: std_logic;  
	signal dcsReq_isWriteType								: std_logic;
	signal dcsReq_isFirstBlockPacket						: std_logic;
	signal dcsReq_blockAddr									: unsigned(gAPB_AWIDTH-1 downto 0);  
	signal dcsReq_addrs										: std_logic_vector(gAPB_AWIDTH-1 downto 0);
	signal dcsReq_data		   								: std_logic_vector(gAPB_DWIDTH-1 downto 0);  
	signal dcsReq_packetCount_store							: unsigned(9 downto 0);		 
	signal dcsReq_packetWordCount_store						: unsigned(2 downto 0);
	signal dcsReq_packetCount								: unsigned(9 downto 0);	 
	signal dcsReq_packetWordCount							: unsigned(2 downto 0);
	signal dcsReq_blockWordCount							: unsigned(15 downto 0);	
	signal dcsReq_blockWordCount_store						: unsigned(15 downto 0);	  
	signal readTimeout								: unsigned(15 downto 0);	
	
	type dcsBlockPacket_t is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);
	signal dcsReq_blockPacketStore							: dcsBlockPacket_t(7 downto 0);	   
	signal dcsReq_blockPacketRemainingWords					: unsigned(2 downto 0);
	                                    					                                    		
	signal dcsResp_readPacket								: std_logic;	  
	signal dcsResp_doneFlag									: std_logic;
	
	signal rcv_fifo_empty_latch								: std_logic;
	signal fifo_rst											: std_logic ;	
	signal empty_event_window_latch									: std_logic;
	signal empty_flag_latch2								: std_logic;   		  
	SIGNAL ddr3_data_ready_latch							: std_logic;
	
	signal dataReq_FIFOReadyState							: unsigned(1 downto 0);
	signal dataReq_dataReady								: std_logic;
	signal shRxReg_dataReq_reply							: shRxReg_t(3 downto 0);	
	signal event_window_tag_sig								: std_logic_vector(gENDEC_DWIDTH-1 downto 0);
begin
	
	RCV_FIFO_RE_0 <= (not RCV_FIFO_EMPTY_0) and rcvFifoRe0_mask;	  
	
	rcv_data <=  RCV_FIFO_Q_0; 
	packetType <= unsigned(rcv_data(7 downto 4));
															   											 
	RESP_FIFO_DATA_0 <= resp_fifo_data_latch;	
	RESP_FIFO_WE_0 <= resp_fifo_we_latch;		
	RESP_FIFO_RESET_0 <= not RESET_N or rst_cmd or fifo_rst; 	
	HEARTBEAT_EVENT_WINDOW_TAG <= std_logic_vector(write_timestamp);
	
	dbgSerialFifo_rst <= dbgSerialFifo_rst_sig;		
	
	--Status Assignment
	status(3 downto 0) <=status_operation;
	
	--=======================
	--=======================			
	main: process( ALGO_CLK )
	begin				   					
  	--<A NAME="(0) Setup Signals">
	  if rising_edge(ALGO_CLK) then	
		   
			status(14) <= enable;	
			status(15) <= rst_cmd;	  
									
	--		ddr3_data_ready_latch 	<= DDR3_DATA_READY_FLAG;
			rcv_fifo_empty_latch	<= RCV_FIFO_EMPTY_0;
			resp_fifo_data_latch 	<= resp_fifo_data;	  
			resp_fifo_we_latch 		<= resp_fifo_we;	   
			
			fifo_rst <= '0';
			rcvFifoRe0_mask <= '0'; 		
			takeData <= '0';			
			resp_fifo_we <= '0';	
			
			DCS_RESP_FIFO_RE <= '0';	 
			DCS_RCV_FIFO_WE <= '0';	  	
			
			DCS_RESET_FIFOS <= '0';	  
			RCV_FIFO_RESET_0 <= '0';
			
			dbgSerialFifo_re <= '0';	
			dbgSerialFifo_rst_sig <= '0';			
			--special serializer FIFO counters
			if (dbgSerialFifo_rst_sig = '1') then 
				dbgSerialFifo_fullCnt <= (others => '0');	  
				dbgSerialFifo_emptyCnt <= (others => '0');
			else	
				if(dbgSerialFifo_full = '1') then
					dbgSerialFifo_fullCnt <= dbgSerialFifo_fullCnt + 1;
				end if;
									   
				if(dbgSerialFifo_empty = '1') then
					dbgSerialFifo_emptyCnt <= dbgSerialFifo_emptyCnt + 1;
				end if;		 					
			end if; 	
	
			if (RESP_FIFO_FULL_0 = '1') then
				resp_fifo_full_cnt <=  resp_fifo_full_cnt + 1;
			end if;
			
			  --<A NAME="(1.A) Reset Received">
			if RESET_N = '0' or rst_cmd = '1' then		  
				one_bit_sig						<= '0';
				DATAREQ_START_EVENT_REQ			<= '0';	
				DATAREQ_EVENT_WINDOW_TAG_1		<= (others => '0');
				DATAREQ_EVENT_WINDOW_TAG_2	   	<= (others => '0');	
				DATAREQ_RE_FIFO					<= '0';
				dataReq_dataReady 				<= '0';
				dcsReq_isFirstBlockPacket		<= '1';
				dcsReq_packetWordCount_store	<= (others => '0');
				dcsReq_packetWordCount			<= (others => '0');
				dcsReq_data						<= (others => '0');
				dcsReq_blockWordCount_store		<= (others => '0');
				dcsReq_blockWordCount			<= (others => '0');
				readTimeout						<= (others => '0');
				dcsReq_blockPacketStore			<= (others => (others =>'0'));
				dcsReq_blockPacketRemainingWords	<= (others => '0');
				dcsReq_blockAddrMode			<= '0';
				dcsReq_blockAddr				<= (others => '0');
				dcsReq_addrs				<= (others => '0');	  	   
				dcsResp_readPacket				<= '1';
				dcsResp_doneFlag				<= '1';
				dcsReq_op						<= None;
				dcs_standby						<= '0';
				dcsReq_op						<= None; 
				state							<= S_Reset;	  
				status 							<= (others => '0');
				errors 							<= (others => '0');		
				rcv0_packet_count 				<= (others => '0');		
				rcv1_packet_count 				<= (others => '0');			
				rReqCnt 						<= (others => '0');	
				dReqCnt 						<= (others => '0');		
				dcsReqCnt 						<= (others => '0');
				resp_fifo_full_cnt 				<= (others => '0');
				write_timestamp 							<= (others => '0');
				read_timestamp 							<= (others => '1');	  
				first_read 						<= '1';	
				reqEventWindowTag 				<= (others => '0'); 
				req_for_dbg_serial 				<= '0';	   
				dbgSerialFifo_rst_sig 			<= '1';	   
				
			 --<A NAME="(1.B)S_RESET">
			elsif(state = S_Reset) then
				state <= S_Idle;			
				
				DCS_RESET_FIFOS 			<= '1';	   
				RCV_FIFO_RESET_0 			<= '1';	   					
				fifo_rst 					<= '1';	
			else		  	 				
				status(7 downto 0) <= (others => '1'); -- default to unknown state
															 
				if(state /= S_Idle and state /= S_DbgDataHdrGen and state /= S_DbgDataGen) then
					shRxReg <= shRxReg(SH_RX_REG_DEPTH-2 downto 0) & rcv_data;  	 
				end if;
			
				--Steps:
					-- if Idle and a fifo is not empty, start reading the command
					-- if packetType = 1, then Readout Request	
						-- acquire timestamp to read 
						-- if debug, then ignore this readout request
					-- if packetType = 2, then Data Request	
						-- acquire timestamp to return data
						-- if debug, then acquire debug packet count
							-- and trigger sending of data
							-- TODO ... handle stacking of multiple data requests?
					-- if packetType = 0, then DCS Request	  
				 --<A NAME="(1.C)S_IDLE">
				if (state = S_Idle) then
				  							 	  		
					rcvCnt <= (others => '0');	
					
					if(enable = '1') then
						
						--get next command from RESP or RCV fifo, with priority to RESP fifo
						
						if(DCS_RESP_FIFO_EMPTY = '0') then --DCS reply available	  --DCS Reply goes first to not saturate the FIFO with data.
							--This is now an error, no responses should happen without a request waiting on it
							--DCS_RESP_FIFO_RE <= '1';	
							state 			 <= S_Drain; -- S_DcsReply;	
						elsif(RCV_FIFO_EMPTY_0 = '0') then	
							state 				<= S_Rcv;			   	 						
							rcvFifoRe0_mask 	<= '1';		 	  		   	   
							rcv0_packet_count 	<= rcv0_packet_count + 1;   	 							  		   	   
						end if;		   
					end if;		   
												  						   
					status(7 downto 0) <= x"01";	  
			
				elsif (state = S_Rcv) then	 					 									
					--make decision based on packetType  	
					
					
					  
					lastPacketType <= packetType;
					if(packetType = PACKET_TYPE_Heartbeat) then		 	 
						state 		<= S_ReadReq;		 
						rReqCnt 	<= rReqCnt + 1;
					elsif(packetType = PACKET_TYPE_DataRequest) then  	 
						state 		<= S_DataReq;	  
						dReqCnt 	<= dReqCnt + 1;
					elsif(packetType = PACKET_TYPE_DCSRequest) then		   	 
						state 		<= S_DcsReq;	  
						dcsReqCnt 	<= dcsReqCnt + 1;
					else  
						errors(ERROR_UndefinedPacketType) 	<= '1'; --unrecognized packet type  	   
						state 		<= S_Drain;	
						rcvCnt 		<= to_unsigned(4,5);	--indicate how much to clear from drain(?)			  
					end if;		
					
					--continue reading the same source
					rcvFifoRe0_mask <= rcvFifoRe0_mask;	
													 									
					status(7 downto 0) <= x"02";	   
				elsif (state = S_ReadReq) then	
					 								  						 	 
					rcvCnt <= rcvCnt + 1;	 			  			
					rcvFifoRe0_mask <= rcvFifoRe0_mask;								
					
					if(rcvCnt >= 0 and rcvCnt < 3) then --acquire timestamp
						reqEventWindowTag <= unsigned(rcv_data) & reqEventWindowTag(6*8-1 downto 2*8); -- shift down words 
					elsif(rcvCnt = 4) then --is debug?			 
						if(reqEventWindowTag < write_timestamp) then --new min
							errors(1) <= '1';
						end if;				   
						
						--	* NOTE: assume "timestamp" tag does not wrap around
						write_timestamp <= reqEventWindowTag;
						if(first_read = '1') then -- illegal read becomes current write 
							read_timestamp <= reqEventWindowTag;  
							first_read <= '0';
						end if;
						
						if (rcv_data(0) = '0') then -- then need to take data!		 
							takeData <= '1';
						end if;				     
						state <= S_Done;			  
					end if;
																	 	 									
					status(7 downto 0) <= x"05";		
					
				--<A NAME="DATA REQUESTS">
				------------------------------------------------------------------
				elsif (state = S_DataReq) then	 	
					
					rcvCnt <= rcvCnt + 1;	 	
					rcvFifoRe0_mask <= rcvFifoRe0_mask;			 
					
					if(rcvCnt >= 0 and rcvCnt < 3) then --acquire timestamp (3 chunks of 16-bits)
						reqEventWindowTag 	<= unsigned(rcv_data) & reqEventWindowTag(6*8-1 downto 2*8); -- shift down words 	 
						dataReq_dataReady 	<= '0';
					elsif(rcvCnt = 4) then --is debug?
						if (rcv_data(0) = '1') then -- then need to take data!		 								     
							state <= S_DbgData;	 										 
																						   
							last_dbg_type_req <= rcv_data(7 downto 4);
							
							-- check debug types (i.e. 0x0 = special sequence, 0x1 = external serial data, 0x2 = external serial data with initial reset of FIFO, and 0x3-0xF = undefined)
							if(rcv_data(7 downto 4) = x"1") then -- external serial data
								req_for_dbg_serial <= '1'; -- flag to get data from external serial FIFO
							elsif(rcv_data(7 downto 4) = x"2") then -- external serial data w/initial reset
								dbgSerialFifo_rst_sig <= '1';			  
								req_for_dbg_serial <= '1'; -- flag to get data from external serial FIFO
							else							 -- special "madeup" sequence
								req_for_dbg_serial <= '0';
							end if;	  				 
						else				
							readTimeout						<= (others => '1');
							state							<= S_DataReqHeader;
							rcvCnt							<= (OTHERS => '0');
							DATAREQ_START_EVENT_REQ			<= '1';			
							DATAREQ_EVENT_WINDOW_TAG_1		<= std_logic_vector(reqEventWindowTag); 
							DATAREQ_EVENT_WINDOW_TAG_2		<= std_logic_vector(reqEventWindowTag + 1);
							dataReq_dataReady 				<= '0';
						end if;										  
					--elsif (rcvCnt = 6) then
--					--	if (DDR3_DATA_READY_FLAG = '0') then
--							rcvCnt	<= rcvCnt;				-- Wait until data is ready.
--						end if;									
--						
--						packetCount			<= 	DDR3_BYTES_IN_EVENT;
--						status				<=  DDR3_STATUS;
					elsif (rcvCnt < 20) then			--Header Packet		 
--					
					else
						state 	<= S_Done;
					end if;		
					
				--HEADER PACKET GEN (DATA REQ)
				elsif (state = S_DataReqHeader) then	   	   			
					DATAREQ_START_EVENT_REQ			<= '0';	  
					dataReq_FIFOReadyState			<= (others => '0');		
					
					if (dataReq_dataReady = '0') then  --Wait for DATA Ready
						if (DATAREQ_DATA_READY_FLAG = '1') then
							dataReq_dataReady			<= '1';	
						else						   
							if (readTimeout = 0) then  --If timeout, drain!... Reset Packet Sender. Send Drain Marker.
								state						<= S_Drain;	 
								errors(ERROR_ReadTimeout)	<= '1';
							end if;
						end if;			
						
						readTimeout		<= readTimeout - 1;
					else 
						rcvCnt <= rcvCnt + 1;  
						resp_fifo_we <= '1';
	
						if(rcvCnt = 0) then	   	
							resp_fifo_data <=(others => '0');
						elsif(rcvCnt = 1) then	--Valid (15)|Reserved(14:11)|Subsystem ID(10:8)|PacketType(7:4)|ROC ID(3:0)	 +
							resp_fifo_data <= x"8050"; 													
						elsif(rcvCnt = 2) then 	-- NULL (15:11)|PacketCount(10:0)
							resp_fifo_data			<= b"00000" & DATAREQ_PACKETS_IN_EVENT(10 downto 0); 	--Data Req packet count	
							dataReqDataReadCnt	<= to_unsigned(0,3) & unsigned(DATAREQ_PACKETS_IN_EVENT(11 DOWNTO 0)) & to_unsigned(0,1);	 --TWICE THE PACKET CNT. 
						elsif(rcvCnt = 3) then 	-- Event Tag Byte 1 and 0
							resp_fifo_data <= std_logic_vector(reqEventWindowTag(2*8-1 downto 0*8)); --timestamp
						elsif(rcvCnt = 4) then 	-- Event Tag Byte 3 and 2
							resp_fifo_data <= std_logic_vector(reqEventWindowTag(4*8-1 downto 2*8)); --timestamp
						elsif(rcvCnt = 5) then 	-- Event Tag Byte 5 and 4
							resp_fifo_data <= std_logic_vector(reqEventWindowTag(6*8-1 downto 4*8)); --timestamp
						elsif(rcvCnt = 6) then	-- Data Packet Version (15:8) | Status (7:0)			 
							resp_fifo_data <= x"00" & DATAREQ_STATUS;   -- status=0 : valid data	 
						elsif(rcvCnt = 7) then	-- Event Window Mode (15:8) | DTC ID (7:0)			
							resp_fifo_data	<= (others => '0');		
						elsif(rcvCnt = 8) then			   		  
							resp_fifo_we 				<= '0';		  
							state						<= S_DataReqDataRead; 	
							dataReq_dataReady			<= '0';
							dataReq_FIFOReadyState		<= (others => '0');			 
							rcvCnt						<= (others => '0');			
						else
							state					<= S_Reset;
						end if;
						status(7 downto 0) <= x"09";  
					end if;		 
				------------------------------------------------------------------
				elsif (state = S_DataReqDataRead) then	  	
					DATAREQ_RE_FIFO				<= '0';	 
					--RE goes high
					--read once
					--sends 4
					--read enable goes high
					--sends 4
					
					if (dataReq_dataReady = '0') then 		--Wait and Receive Data				 
						resp_fifo_we			<= '0';

						if (dataReq_FIFOReadyState = 0) then  
							if ((DATAREQ_DATA_READY_FLAG = '1' and dataReqDataReadCnt > 0) ) then
								dataReq_FIFOReadyState		<= to_unsigned(1,2); 
								DATAREQ_RE_FIFO				<= '1';	 
							else
								state 					<= S_Done;
							end if;					
						elsif(dataReq_FIFOReadyState = 1) then
							dataReq_FIFOReadyState		<= to_unsigned(2,2);
						elsif (dataReq_FIFOReadyState = 2) then	
							dataReq_FIFOReadyState		<= to_unsigned(0,2);
							dataReq_dataReady			<= '1';	   
							shRxReg_dataReq_reply(3)	<=	DATAREQ_DATA_REQ_REPLY(63 downto 48);	   
							shRxReg_dataReq_reply(2)	<=	DATAREQ_DATA_REQ_REPLY(47 downto 32);
							shRxReg_dataReq_reply(1)	<=  DATAREQ_DATA_REQ_REPLY(31 downto 16);
							shRxReg_dataReq_reply(0)	<=  DATAREQ_DATA_REQ_REPLY(15 downto 0);  
						end if;
					else	 							  --Send Data
						rcvCnt <= rcvCnt + 1;  
						resp_fifo_we <= '1';
						
						resp_fifo_data	<= shRxReg_dataReq_reply(0);
						shRxReg_dataReq_reply <= shRxReg_dataReq_reply(0) & shRxReg_dataReq_reply(3 DOWNTO 1);	 
						
						if (rcvCnt = 3) then			
							dataReq_dataReady 		<= '0';
							rcvCnt					<= (others => '0');	 
							dataReqDataReadCnt	<= dataReqDataReadCnt - 1;
						end if;
							 
					end if;	
				------------------------------------------------------------------
				elsif (state = S_DbgData) then	
					
					dbgDataPacketCnt <= unsigned(rcv_data);	
						 						  
					rcvCnt <= (others => '0');				     
					state <= S_DbgDataHdrGen;	 
																	 
					status(7 downto 0) <= x"08";	 
				------------------------------------------------------------------
				elsif (state = S_DbgDataHdrGen) then
					
					--generate Debug Data Header packet	 
					rcvCnt <= rcvCnt + 1;  
					resp_fifo_we <= '1';
					resp_fifo_data <= (others => '0');
					
					if(rcvCnt = 0) then
					elsif(rcvCnt = 1) then
						resp_fifo_data <= x"8050"; --header word
					elsif(rcvCnt = 2) then
						resp_fifo_data 		<= std_logic_vector(dbgDataPacketCnt); --dbg packet count  	  
					elsif(rcvCnt = 3) then
						resp_fifo_data <= std_logic_vector(reqEventWindowTag(2*8-1 downto 0*8)); --timestamp
					elsif(rcvCnt = 4) then
						resp_fifo_data <= std_logic_vector(reqEventWindowTag(4*8-1 downto 2*8)); --timestamp
					elsif(rcvCnt = 5) then
						resp_fifo_data <= std_logic_vector(reqEventWindowTag(6*8-1 downto 4*8)); --timestamp
					elsif(rcvCnt = 6) then				 
						--upper byte reserved, or is this data?	  
--						if(reqEventWindowTag > write_timestamp or 
--							reqEventWindowTag < read_timestamp) then
--							resp_fifo_data <= x"FF" & x"02"; -- status=2 :invalid timestamp request
--							dbgDataPacketCnt <= (others => '0'); --clear packet count
--						elsif(dbgDataPacketCnt = 0) then
--							resp_fifo_data <= x"FF" & x"01"; -- status=1 : indicates there is no valid data
--							read_timestamp <= reqEventWindowTag;
--						else					 
											   
							read_timestamp <= reqEventWindowTag; 
							resp_fifo_data(7 downto 0) <= x"00";   -- status=0 : valid data	 
							
							-- setup debug data
							if (req_for_dbg_serial = '1') then
								resp_fifo_data(15 downto 8) <= x"A" & "00" & dbgSerialFifo_full & dbgSerialFifo_empty;	
							else
								resp_fifo_data(15 downto 8) <= x"FF";--ALGO_VERSION;--x"FF"; 
							end if;
													
						--end if;
					elsif(rcvCnt = 7) then			
						
						if (req_for_dbg_serial = '1') then
							resp_fifo_data <= std_logic_vector(dbgSerialFifo_fullCnt) & std_logic_vector(dbgSerialFifo_emptyCnt);	
						else
							resp_fifo_data <= std_logic_vector(read_timestamp(7 downto 0)) & x"FF";--(others => '1'); --reserved, or is this data?	   
						end if;
						
											 
						if(dbgDataPacketCnt = 0) then
							state <= S_Idle;
						else								 						 
							rcvCnt <= (others => '0');				
							dbgDataPacketCnt <= dbgDataPacketCnt - 1; --correct count for countdown to 0	
							state <= S_DbgDataGen;					 
						end if;
					end if;					
					
					status(7 downto 0) <= x"09";
				------------------------------------------------------------------
				elsif (state = S_DbgDataGen) then
					
					--generate Debug Data packet	 
					rcvCnt <= rcvCnt + 1;  
					resp_fifo_we <= '1';
					
					if(req_for_dbg_serial = '1') then -- special debug packet from external serial FIFO
																																	
						if (rcvCnt(0) = '0') then -- even number words		 
							resp_fifo_data <= "00" & dbgSerialFifo_full & dbgSerialFifo_empty & "0" & dbgSerialFifo_rdCnt;	
							dbgSerialFifo_re <= not dbgSerialFifo_empty;	
						else 					-- odd number words
							resp_fifo_data <= dbgSerialFifo_data;
						end if;
					else		  		
						
						if (unsigned(last_dbg_type_req) = 3) then -- SEU SRAM		
							
							if (rcvCnt(0) = '0') then -- even number words
								resp_fifo_data <= SEU_SRAM_ERRS;								
							else		
								resp_fifo_data <= SEU_SRAM_RLOOPS;	
							end if;
							
						elsif (unsigned(last_dbg_type_req) = 4) then -- SEU DDR3		
							 														
							if (rcvCnt(0) = '0') then -- even number words
								resp_fifo_data <= SEU_DDR3_ERRS;								
							else		
								resp_fifo_data <= SEU_DDR3_RLOOPS;	
							end if;			   	 		   	 
							
						elsif (unsigned(last_dbg_type_req) = 5) then -- SEU SRAM BAD LOC	
														 												
							if (rcvCnt(0) = '0') then -- even number words
								resp_fifo_data <= SEU_SRAM_BAD_LOC(31 downto 16);								
							else		
								resp_fifo_data <= SEU_SRAM_BAD_LOC(15 downto 0);	
							end if;		  
							
						elsif (unsigned(last_dbg_type_req) = 6) then -- SEU DDR3 BAD LOC	
														 												
							if (rcvCnt(0) = '0') then -- even number words
								resp_fifo_data <= SEU_DDR3_BAD_LOC(31 downto 16);								
							else		
								resp_fifo_data <= SEU_DDR3_BAD_LOC(15 downto 0);	
							end if;								
						
					   	else		-- default to special sequence packet
							if(rcvCnt = 0) then	
								resp_fifo_data <= std_logic_vector(dbgDataPacketCnt(15 downto 0)); 
							else
								resp_fifo_data <= std_logic_vector(read_timestamp(3 downto 0) & dbgDataPacketCnt(7 downto 0) & rcvCnt(3 downto 0)); 
							end if;	  
						end if;
						
					end if;
					
					
					-- handle end case state transition
					if(rcvCnt = 7) then
						rcvCnt <= (others => '0');		
						if(dbgDataPacketCnt = 0) then	 
							state <= S_Idle;
						else								 						 						 
							dbgDataPacketCnt <= dbgDataPacketCnt - 1;
							state <= S_DbgDataGen;					 
						end if;	
					end if;					
					
					status(7 downto 0) <= x"0A";					 
					
				------------------------------------------------------------------ 
				elsif (state = S_DcsReq) then	  	   
				--Use dcsReq_op to know the type of dcs request once its captured.
				
					-- Packet Type Doc Link => <A HREF="https://mu2e-docdb.fnal.gov/cgi-bin/private/RetrieveFile?docid=4914&filename=Mu2e_ROC_Packet_Protocol.pdf">Mu2e-doc-4914</A>
					-------------------------------------------------------------------------
					--New DCS Req Format
					-- word 0 =	Block Op Packet Count [15:6] | Reserved [5:4] | Op Code [3:0]  
						--	opCode[1:0]: 0 = read, 1 = write, 2 = block_read, 3 = block_write 
						--  opCode[2] = double Operation
						--  opCode[3] = dcs Acknowledgement	 
						--  opCode[4] = dcs block op Increment Address
					-- word 1 =	Op1 Address [15:0]								
					-- word 2 = Op1 Write Data or Block word count [15:0]
					-- word 3 = Op2 Address [15:0] or Block Data 0	 
					-- word 4 = Op2 Write Data or Block Data 1 [15:0]
					-- word 5 = Reserved or Block Data 2 [15:0]	
					-- additional words based on block_op_packet_count...	   	
					--------------------------------------------------------------------------
					-- DCS Rcv FIFO Data Format:
					-- 		Last Bit | Valid | Opcode(34:32) | Addr(31:16) | WData or Rdata or WordCount(15:0)	
					-- DCS Resp FIFO Data Format:
					-- 		DCS_RCV_FIFO_EMPTY | Opcode(34:32) | Addr(31:16) | RData(15:0)
					
					rcvCnt <= rcvCnt + 1;	 	
					rcvFifoRe0_mask <= rcvFifoRe0_mask;	   
	
					if(rcvCnt = 0) then --get op code		 
						dcsReq_packetCount			<= unsigned(rcv_data(15 downto 6));	   --if DCS Read Block. It gets replaced later on by wordCount calculation
						dcsReq_packetCount_store	<= unsigned(rcv_data(15 downto 6));	
						dcsReq_blockAddrMode		<= rcv_data(4);
						dcsReq_reqAck				<= rcv_data(3);		 
						dcsReq_opCode 				<= unsigned(rcv_data(2 downto 0));
						dcsReq_isFirstBlockPacket	<= '1';
						
					elsif(rcvCnt = 1) then --get addrs				
						dcsReq_addrs <= rcv_data;	
						
						dcsReq_isWriteType 		<= '0';	--default to read type
						
						--Interpret Opcode and Get Address	   						
						if(dcsReq_opCode = DCS_OPCODE_Read) then	
							dcsReq_op			<= DCSReadSingle; 	
							
							DCS_RCV_FIFO_WE 	<= '1';			
							DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)		<= (others => '0');
							DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
								'0' & rcv_data;		 
						
						elsif(dcsReq_opCode = DCS_OPCODE_DoubleRead) then  
							
							dcsReq_op			<= DCSReadDouble;  
							
							DCS_RCV_FIFO_WE 	<= '1';		
							DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)		<= (others => '0');
							DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
								'0' & rcv_data;		 				  	
						
						elsif(dcsReq_opCode = DCS_OPCODE_BlockRead) then	
							dcsReq_op				<= DCSReadBlock;		
							dcsReq_blockAddr		<= unsigned(rcv_data);	 	 
						elsif(dcsReq_opCode = DCS_OPCODE_Write) then  			
							dcsReq_op				<= DCSWriteSingle;
							dcsReq_isWriteType 		<= '1';						
						elsif(dcsReq_opCode = DCS_OPCODE_DoubleWrite) then
							dcsReq_op				<= DCSWriteDouble;			
							dcsReq_isWriteType 		<= '1';		   			
						elsif(dcsReq_opCode = DCS_OPCODE_BlockWrite) then 
							dcsReq_op				<= DCSWriteBlock;	 
							dcsReq_blockAddr		<= unsigned(rcv_data);	
							dcsReq_isWriteType 		<= '1';			
						else			  
							
							state <= S_Drain;								
							errors(ERROR_UndefinedPacketType) <= '1';
						end if;
					
					elsif(rcvCnt = 2) then	--get data or block word count  	
						
						--  Block Stream Operation
						--Note: DCSReadSingle is already done, so would be invalid at this point
						if 		(dcsReq_op = DCSReadSingle) then 
						elsif 	(dcsReq_op = DCSReadDouble) then 
								
							-- do nothing on data word place	
							 
							
						elsif (dcsReq_op = DCSWriteSingle) then 
							DCS_RCV_FIFO_WE 	<= '1';			
							DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)		<= rcv_data;
							DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
								'1' & std_logic_vector(dcsReq_addrs);	 		 
							
							if(dcsReq_reqAck = '1') then
								rcvCnt 				<= (others => '0');
								state				<= S_DcsAck;		 	
--							else		 
--								state				<= S_Done; 	 
							end if;	  
						elsif (dcsReq_op = DCSWriteDouble) then 							
															  
							DCS_RCV_FIFO_WE 	<= '1';			
							DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)		<= rcv_data;
							DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
								'1' & dcsReq_addrs;	 		 
								
						elsif (dcsReq_op = DCSReadBlock) then	
							if(unsigned(rcv_data) = 0) then -- error, cant read 0 words!
								state 				<= S_Drain;			 
							end if;								   
							
							dcsReq_blockWordCount		<= unsigned(rcv_data);		   							
							
							--check for packet count, word count mismatch  
							-- hijack dcsReq_blockWordCount_store signal for the test		   
							dcsReq_blockWordCount_store(15 downto 0) <=  unsigned(rcv_data) + 4; -- := (word_count + 4) / 8 (divide by 8 in next step) 	
						elsif (dcsReq_op = DCSWriteBlock) then 											   		 
							rcvFifoRe0_mask				<= '0';		--Hold the current write data
							if(unsigned(rcv_data) = 0) then -- error, cant read 0 words!
								state 				<= S_Drain;			 
							end if;								   
							
							dcsReq_blockWordCount		<= unsigned(rcv_data) - 1;		   							
							
							--check for packet count, word count mismatch  
							-- hijack dcsReq_blockWordCount_store signal for the test		   
							dcsReq_blockWordCount_store(15 downto 0) <=  unsigned(rcv_data)+ 4; -- := (word_count + 4) / 8 (divide by 8 in next step) 																		 
							
						else	  								  
							state <= S_Drain;								
							errors(ERROR_UndefinedPacketType) <= '1';
						end if;	
						
					--Double Operand!
					elsif(rcvCnt = 3) then 	--second addrs	  
						dcsReq_addrs <= rcv_data;	   
						
						if 	  (dcsReq_op = DCSReadSingle) then 	 
						elsif (dcsReq_op = DCSWriteSingle) then 
						elsif (dcsReq_op = DCSReadDouble) then 
								
							DCS_RCV_FIFO_WE 												<= '1';			
							DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)						<= (others => '0');
							DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<=	'0' & rcv_data;	  
														  					   
						elsif (dcsReq_op = DCSReadBlock or dcsReq_op = DCSWriteBlock) then 			 												 
							--use extra clock to check for packet count, word count mismatch  
							
							if(dcsReq_blockWordCount_store(12 downto 3) /= 
								dcsReq_packetCount_store and dcsReq_op = DCSWriteBlock) then -- error, mismatch in size!
								state <= S_Drain;				
								errors(ERROR_CountMismatch) <= '1';
							else					  
								--fix hijacked signal
								dcsReq_blockWordCount_store 	<= 	dcsReq_blockWordCount;	
								dcsReq_packetWordCount 			<= 	to_unsigned(2,3); --init to 2	
								dcsReq_packetWordCount_store	<=  to_unsigned(2,3);
								
								if (dcsReq_op = DCSWriteBlock) then 	
									rcvFifoRe0_mask				<= '1';		--Hold the current write data
									rcvCnt						<= (others => '0');
									state						<= S_DCSWriteBlockReq;
								
								else --if Read
									--initialize packet store
									dcsReq_blockPacketStore <= (others => (others => '0')); --clear packet store	
									dcsReq_blockPacketStore(3) <= x"8040";
									dcsReq_blockPacketStore(2) <= std_logic_vector(dcsReq_blockWordCount_store(12 downto 3)) & '0' & dcsReq_blockAddrMode &
										dcsReq_reqAck & std_logic_vector(dcsReq_opCode);
									dcsReq_blockPacketStore(1) <= std_logic_vector(dcsReq_blockAddr);			
									dcsReq_blockPacketStore(0) <= std_logic_vector(dcsReq_blockWordCount);
									
									--initialize packetCount
									dcsReq_packetCount			<=	dcsReq_blockWordCount_store(12 downto 3);
								end if;	
							end if;														
							
						elsif (dcsReq_op = DCSWriteDouble) then 
							-- do nothing unti we get data										
							
						else	  								  
							state <= S_Drain;								
							errors(ERROR_UndefinedPacketType) <= '1';
						end if;	
						
						
					elsif(rcvCnt = 4) then 	--Go to done and ignore last word 	 
						if (dcsReq_op	= DCSReadSingle) then
							rcvCnt				<= (others => '0');	 
							state				<= S_DcsReadSingleResp;
							readTimeout <= (others => '1'); 			--init timeout
						elsif (dcsReq_op = DCSWriteSingle) then  
							state				<=S_Done;
						elsif (dcsReq_op = DCSReadDouble) then 	  
							state															<=	S_DcsReadDoubleResp; 	   	 
							readTimeout 												<= (others => '1');
						elsif (dcsReq_op = DCSWriteDouble) then 							
															  
							DCS_RCV_FIFO_WE 	<= '1';			
							DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)		<= rcv_data;
							DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
								'1' & dcsReq_addrs;	 											
								
							if(dcsReq_reqAck = '1') then
								rcvCnt 				<= (others => '0');
								state				<= S_DcsAck;		 	
							else		 
								state				<= S_Done; 	 
							end if;	  				  			
						elsif (dcsReq_op = DCSReadBlock) then			   
								rcvCnt						<= (others => '0');
								state						<= S_DCSReadBlockReq; 		
						--elsif (dcsReq_op = DCSWriteBlock) then	 	
						else									  
							state <= S_Drain;								
							errors(ERROR_UndefinedPacketType) <= '1';
						end if;	
					else --invalid rcv cnt!!!						 							  				  
							state <= S_Drain;		
							errors(ERROR_UndefinedPacketType) <= '1';
					end if;	   				  					
					
					--TEMPLATE for ignore and drain
					--					rcvFifoRe0_mask <= rcvFifoRe0_mask;	
					--					state <= S_Drain;	
					--					rcvCnt <= x"3";				  
						
					status(7 downto 0) <= x"0B"; 	 	
				------------------------------------------------------------------
				elsif (state =  S_DcsReadSingleResp) then		
					-- read enough resp fifo words from DCS_RESP fifo for a packet	
					-- hand packet to packet sender through RESP fifo	  
									   					
					if(DCS_RESP_FIFO_EMPTY = '0') then --DCS reply available	   
						DCS_RESP_FIFO_RE 	<= '1';									 
						state				<= S_DcsReadSingleTransferToSender;
						readTimeout 		<= (others => '1'); --reset timeout
					end if;		
						
							 
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						state <= S_Drain;
						errors(ERROR_ReadTimeout) <= '1';
					end if;		
					
				elsif (state = S_DcsReadSingleTransferToSender) then	
					rcvCnt <= rcvCnt + 1;
					resp_fifo_we <= '1'; 	 										   
					resp_fifo_data <=	(others => '0'); 	
					
					if(rcvCnt = 0) then		--DMA Byte Count	
						resp_fifo_data <=	(others => '0');
					elsif(rcvCnt = 1) then	--Valid(15)|Reserved(14:11)|RocLinkID(10:8)|PacketType(7:4)|HopCount(3:0)
						resp_fifo_data <=	x"8040";
					elsif(rcvCnt = 2) then	--PacketCount(15:6)| Reserved(5) | Opcode (4:0) 		  
						resp_fifo_data	<= (others => '0');
					elsif(rcvCnt = 3) then	--Addr1(15:0)			   
						resp_fifo_data	<= DCS_RESP_FIFO_Q(31 downto 16);
					elsif(rcvCnt = 4) then	--Data(15:0)		  
						resp_fifo_data	<= DCS_RESP_FIFO_Q(15 downto 0);  
					--elsif(rcvCnt = 5,6,7) then 
					elsif(rcvCnt = 8) then
						resp_fifo_we 	<= '0'; 
						state			<= S_Done;
					end if;													
				------------------------------------------------------------------	
				elsif (state =  S_DcsReadDoubleResp) then		
					-- read enough resp fifo words from DCS_RESP fifo for a packet	
					-- hand packet to packet sender through RESP fifo	  
									   					
					if(unsigned(DCS_RESP_FIFO_RD_CNT) = 2 ) then --DCS reply available	
						rcvCnt <= (others => '0');
						DCS_RESP_FIFO_RE 	<= '1';									 
						state				<= S_DcsReadDoubleTransferToSender;
						readTimeout <= (others => '1'); --reset timeout	
					end if;		
						
							 
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						state <= S_Drain;
						errors(ERROR_ReadTimeout) <= '1';
					end if;		
					
				elsif (state = S_DcsReadDoubleTransferToSender) then	
					rcvCnt <= rcvCnt + 1;
					resp_fifo_we <= '1'; 	 										   
					resp_fifo_data 		<=	(others => '0'); 	
					
					if(rcvCnt = 0) then		
					elsif (rcvCnt = 1) then
						resp_fifo_data 		<=	x"8040";
					elsif(rcvCnt = 2) then	  		
						resp_fifo_data		<=  x"0004";
					elsif(rcvCnt = 3) then				   
						resp_fifo_data		<= DCS_RESP_FIFO_Q(gAPB_AWIDTH+gAPB_DWIDTH-1 downto gAPB_DWIDTH);
					elsif(rcvCnt = 4) then			  
						resp_fifo_data		<= DCS_RESP_FIFO_Q(gAPB_DWIDTH-1 downto 0);    
						DCS_RESP_FIFO_RE 	<= 	'1';	
					elsif (rcvCnt = 5) then									   	   
						resp_fifo_data		<= DCS_RESP_FIFO_Q(gAPB_AWIDTH+gAPB_DWIDTH-1 downto gAPB_DWIDTH);  
					elsif (rcvCnt = 6) then					
						resp_fifo_data		<= DCS_RESP_FIFO_Q(gAPB_DWIDTH-1 downto 0);  
					else
						state	<= S_Done;
					end if;
				 --<A NAME="DCS_BLOCK_REQUEST">						--SPECIAL REQ.	
				 -----------------------------------------------------------------------
				elsif (state = S_DcsReadBlockReq) then	
					
					-- packet count vs word count assumed already verified at this point!
					-- place read ops in DCS RCV fifo
					
					--Incremental Address Mode?
					if dcsReq_blockAddrMode = '1' then
						dcsReq_blockAddr	<= dcsReq_blockAddr + 1;
					end if;				
					
					--Word Count = Valid Packages
					dcsReq_blockWordCount <= dcsReq_blockWordCount - 1;	
					--Packet Word Count = Words to put on this packet
					dcsReq_packetWordCount <= dcsReq_packetWordCount - 1;
					
					--Put into DCS_RCV
					DCS_RCV_FIFO_WE 	<= '1';		
					DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)		<= (others => '0');
					DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
						'0' & std_logic_vector(dcsReq_blockAddr);
						
					-- Ctrl to stop requesting
					if(dcsReq_blockWordCount = 0) then	--if done with block Word Count		
						dcsReq_blockWordCount 		<= (others => '0'); 	--Used to indicate operation is DONE.
						state 						<= S_DcsReadBlockResp;	--read 	 
						rcvCnt 						<= (others => '0');	  
						readTimeout 			<= (others => '1');
						DCS_RCV_FIFO_WE 			<= '0';
						
						if (dcsReq_isFirstBlockPacket = '1') then		  					
							
							dcsReq_packetWordCount 				<= dcsReq_packetWordCount_store - dcsReq_packetWordCount - 1; 
							dcsReq_blockPacketRemainingWords 	<=  dcsReq_packetWordCount + 1;  -- Plus 1 (+1) is to pad the first packet for the packet sender.	
						else  
							dcsReq_packetWordCount 				<= dcsReq_packetWordCount_store - dcsReq_packetWordCount - 1; 
							dcsReq_blockPacketRemainingWords 	<= dcsReq_packetWordCount + 1;
						end if;
						
						--Reset Packet Word Count for DCS RCV								   		
					-- Restart the packet count
					elsif(dcsReq_packetWordCount = 0) then
						--done with packet worth of reads
						state 						<= S_DcsReadBlockResp;    
						--dcsReq_packetWordCount 		<= dcsReq_packetWordCount;
						readTimeout 			<= (others => '1'); --init timeout	
						rcvCnt 						<= (others => '0');	  	
						if(dcsReq_isFirstBlockPacket = '1') then   	   
							dcsReq_blockPacketRemainingWords 	<=  to_unsigned(0,3);   -- Plus 1 (+1) is to pad the first packet for the packet sender.
							dcsReq_packetWordCount			 	<= to_unsigned(2,3);
						else										
							dcsReq_blockPacketRemainingWords 	<=  (others => '0');
							dcsReq_packetWordCount 				<= to_unsigned(7,3);	 
						end if;			 	
					end if;		   						
								
				----------------------------------------------------------------	
				--Response after packetWordCount = 0 or blockWord = 0												   
				elsif (state = S_DcsReadBlockResp) then		   			  
					
					-- read enough resp fifo words from DCS_RESP fifo for a packet	
					-- hand packet to packet sender through RESP fifo	  
								   
					if (rcvCnt = 0) then  --read from DCS Response FIFO											   												
						if(DCS_RESP_FIFO_EMPTY = '0') then --DCS reply available	 
							
							DCS_RESP_FIFO_RE 	<= '1';
							rcvCnt			 	<= rcvCnt + 1;	 
							readTimeout 	<= (others => '1'); --reset timeout
						end if;		
						
					elsif (rcvCnt = 1) then	 			  
						
						rcvCnt			 					<= rcvCnt + 1;	 
						dcsReq_blockPacketStore(0) 			<= DCS_RESP_FIFO_Q(15 downto 0);	  
						dcsReq_blockPacketStore(7 downto 1) <= dcsReq_blockPacketStore(6 downto 0);	
					elsif (rcvCnt = 2) then	  	 
						
						rcvCnt			 		<= rcvCnt + 1;		
						if(dcsReq_packetWordCount = 0) then					
							-- hand to packet sender through RESP fifo!
							state <= S_DcsReadBlockPacketFill;	 
							rcvCnt <= (others => '0');		
						else
							dcsReq_packetWordCount <= dcsReq_packetWordCount - 1;
						end if;	 
					elsif (rcvCnt = 3) then
						if(DCS_RESP_FIFO_EMPTY = '0') then --DCS reply available	   		
							DCS_RESP_FIFO_RE 	<= '1';
							rcvCnt 				<= ( 0 => '1', others => '0');
							readTimeout 	<= (others => '1'); --reset timeout 
						end if;		
					end if;	   
					
							 
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						state <= S_Drain;
						errors(ERROR_ReadTimeout) <= '1';
					end if;									
				-------------------------------------------------------------------
				--Check if we need to fill additional packages.
				elsif (state = S_DcsReadBlockPacketFill) then  					 
					
					dcsReq_blockPacketRemainingWords <= dcsReq_blockPacketRemainingWords - 1;
					if(	dcsReq_blockPacketRemainingWords = 0) then			  

						-- hand to packet sender through RESP fifo!	 
						state 								<= S_DcsReadBlockTransferToSender;	 
						rcvCnt 								<= (others => '0');	
					else -- fill packet with dummy data
						dcsReq_blockPacketStore(0) 			<= (others => '0'); --dummy data	  
						dcsReq_blockPacketStore(7 downto 1) <= dcsReq_blockPacketStore(6 downto 0);						
					end if;
				---------------------------------------------------------------
				--Send to Packet Sender
				elsif (state = S_DcsReadBlockTransferToSender) then		
					dcsReq_isFirstBlockPacket			<= '0';
					rcvCnt 								<= rcvCnt + 1;
					resp_fifo_we 						<= '1'; 	 										   
					resp_fifo_data 						<= dcsReq_blockPacketStore(7);  
					dcsReq_blockPacketStore(7 downto 1) <= dcsReq_blockPacketStore(6 downto 0);
					
					if(rcvCnt = 7) then	   		  
						
						if (dcsReq_blockWordCount > 0) then
							if (dcsReq_packetCount = 0) then
						   		errors(ERROR_CountMismatch) 	<= '1';	
						  	 	state 							<= 	S_Drain;
						   else	   					  
							    dcsReq_packetWordCount_store	<= to_unsigned(7,3);
							    dcsReq_packetWordCount			<= to_unsigned(7,3);
								state				 			<= S_DcsReadBlockReq;
								dcsReq_packetCount 				<= dcsReq_packetCount - 1;	
							end if;
						else   
							state <= S_Done;
						end if;
						
					end if;
				------------------------------------------------------------------
				elsif (state = S_DcsWriteBlockReq) then	  						 
					-- packet count vs word count assumed already verified at this point!  					
					-- place write ops in DCS RCV fifo
					rcvCnt					<= rcvCnt + 1;
					
					if dcsReq_blockAddrMode = '1' then
						dcsReq_blockAddr	<= dcsReq_blockAddr + 1;
					end if;						 								
						
					dcsReq_blockWordCount <= dcsReq_blockWordCount - 1;	  
					dcsReq_packetWordCount <= dcsReq_packetWordCount - 1;
					
					if(dcsReq_blockWordCount = 0) then	
						rcvCnt 					<= (others => '1');	
						state <= S_DcsWriteBlockEmptyRecvFifo;							
						dcsReq_blockPacketRemainingWords <= dcsReq_packetWordCount;	
						
					elsif(dcsReq_packetWordCount = 0) then
						--done with packet worth of writes	 
						rcvCnt	<= to_unsigned(20,5);	--Artificial delay between packets so DCS RCV FIFO doesnt overflow.
						state <= S_DcsWriteBlockWaitForNext;   
						readTimeout <= (others => '1'); --init timeout	 
					else 
						rcvFifoRe0_mask				<= '1';
					end if;		   						
								
					DCS_RCV_FIFO_WE 	<= '1';
					DCS_RCV_FIFO_DATA(gAPB_DWIDTH-1 downto 0)		<= rcv_Data; 

						
					DCS_RCV_FIFO_DATA(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
						'1' & std_logic_vector(dcsReq_blockAddr);	 
				------------------------------------------------------------------	
				elsif (state = S_DcsWriteBlockEmptyRecvFifo) then	  
					
					dcsReq_blockPacketRemainingWords <= dcsReq_blockPacketRemainingWords - 1;	
					if(dcsReq_blockPacketRemainingWords = 0) then
						state <= S_Done;			
					else
						rcvFifoRe0_mask				<= '1';
					end if;
				------------------------------------------------------------------	
				elsif (state = S_DcsWriteBlockWaitForNext) then	  
					if (rcvCnt /= 0) then
						rcvCnt						<= rcvCnt - 1;	
					end if;
					
					if(RCV_FIFO_EMPTY_0 = '0' and rcvCnt = 0) then	   
						rcvCnt 					<= (others => '0');	
						state 					<= S_DcsWriteBlockReq;			   
						rcvFifoRe0_mask 		<= '1';	  
						readTimeout 	<= (others => '1'); --reset timeout
					end if;
							
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						state <= S_Drain;
						errors(ERROR_ReadTimeout) <= '1';
					end if;
					
				elsif (state = S_DcsAck) then	   
					 
					rcvCnt <= rcvCnt + 1;  
					resp_fifo_we <= '1';		  	
					
					
					-- dcs reply ACK packet
					-- word 0 = 15:8 dcsReqCnt | 7:0 op code | 4:0 addresses (0=read,1=write,2=write with ack,3-255=undefined)	
					-- word 1 = 15:5 reserved | 
					-- word 2 = reserved
					-- word 3 = 15:0 write data
					-- word 4 = reserved   
					-- word 5 = reserved	 
																	 
					resp_fifo_data <= (others => '0');
					if(rcvCnt = 0) then
						resp_fifo_data <= x"8040"; --header word  
					elsif (rcvCnt = 1) then
						resp_fifo_data <= std_logic_vector(dcsReq_packetCount_store) & "000000"; 
					elsif(rcvCnt = 2) then
						resp_fifo_data <= dcsReq_addrs;		   
					elsif(rcvCnt = 4) then
						resp_fifo_data <= dcsReq_data;		 
					elsif(rcvCnt = 7) then -- done with packet	 
						state <= S_Idle;
					end if;
					
					
					status(7 downto 0) <= x"0C"; 	 
					
				 --<A NAME="S_DCS_REPLY">
				elsif (state = S_DcsReply) then	  	 --Send Reply
						status(7 downto 0) <= x"0D";  
				elsif (state = S_Drain) then							
					--drain the receive fifo, usually in response to error	 
					
					DCS_RESET_FIFOS 			<= '1';	   
					RCV_FIFO_RESET_0 			<= '1';	   					
					fifo_rst 					<= '1';					   
					
					state 						<= S_Reset; 
					
					errors(ERROR_HasDrained) 	<= '1';
					status(7 downto 0) 			<= x"03";	
				elsif (state = S_Done) then	 	
					--1 clk pit stop for FIFO empty signal to respond									   
					DCS_RCV_FIFO_DATA 	<= (OTHERS => '0');
					state 				<= S_Idle;		 
					rcvCnt 				<= (others => '0');
					status(7 downto 0) <= x"04";	
				end if;
				
			end if;		
		end if;			
	end process;
	
	--=======================--<A NAME="Algo_rdata">
	--=======================	
	roc_mon_gen	: for i in 0 to 0 generate	   
		--standard RocMonitor interface generate template
		signal algo_rdata_sig				: std_logic_vector(gAPB_DWIDTH-1 downto 0) := (others => 'Z');   --bus		
		signal locAddr						: unsigned(ALGO_LOCADDR_WIDTH-1 downto 0);																
		signal wAddr						: unsigned(ALGO_WADDR_WIDTH-1 downto 0);																
		signal wData						: std_logic_vector(ALGO_WDATA_WIDTH-1 downto 0);		
		signal old_we, we					: std_logic;				   	   
																	  									  
		signal rAddr						: unsigned(ALGO_RADDR_WIDTH-1 downto 0) := (others => '1');	
		signal rst_cnt						: unsigned(3 downto 0) := (others => '0');		
		
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
					   					
				-- gen reset pulse			
				rst_cmd <= '0';	  									
				if (rst_cnt /= 0) then
					rst_cnt <= rst_cnt - 1;
					rst_cmd <= '1';
				end if;
				
				-- main cases										 
				if ALGO_RESET = '1' then		 
					rst_cmd <= '0';	  			  		 
					rAddr <= (others => '1');  
					enable <= '1';	  		
				else							   	
					
					if(	locAddr = to_unsigned(ALGO_LOC_ADDR, ALGO_LOCADDR_WIDTH)) then --check target address
																	  
						--Writes
						if (old_we = '0' and we = '1') then -- identify we rising edge
											
							if wAddr = 0 then 						   --setup rAddr
								rAddr <= unsigned(wData(ALGO_RADDR_WIDTH-1 downto 0));
							elsif wAddr = 1 then
								if (wData(0) = '1') then --start a reset pulse
									rst_cnt <= (others => '1');
								end if;  
					--			enable <= wData(4);	  
							elsif wAddr = 2 then
								dummy_reg(ALGO_WDATA_WIDTH-1 downto 0) <= wData;
							end if;
							
						end if;	
						
						
						--Reads				
						algo_rdata_sig <= (others => '0');		  
						if (rAddr = 0) then			  		
							algo_rdata_sig <= status;	  
						elsif (rAddr = 1) then			  		
							algo_rdata_sig <= errors;											 						  
						elsif (rAddr = 2) then				-- last packet type  		
							algo_rdata_sig(3 downto 0) 	<= std_logic_vector(lastPacketType);
						elsif (rAddr = 3) then				-- timestamp
							algo_rdata_sig 				<= std_logic_vector(reqEventWindowTag(2*8-1 downto 0*8));							 				
						elsif (rAddr = 4) then				-- timestamp					
							algo_rdata_sig 				<= std_logic_vector(reqEventWindowTag(4*8-1 downto 2*8));						
						elsif (rAddr = 5) then				-- timestamp
							algo_rdata_sig <= std_logic_vector(reqEventWindowTag(6*8-1 downto 4*8));		   		
						elsif (rAddr = 6) then			 	-- last requested timestamp
							algo_rdata_sig <= std_logic_vector(reqEventWindowTag(gAPB_DWIDTH-1 downto 0));
						elsif (rAddr = 7) then			  	-- current read timestamp pointer	
							algo_rdata_sig <= std_logic_vector(read_timestamp(gAPB_DWIDTH-1 downto 0));
						elsif (rAddr = 8) then			  	-- current last write timestamp	(last readout request)
							algo_rdata_sig <= std_logic_vector(write_timestamp(gAPB_DWIDTH-1 downto 0));			
						elsif (rAddr > 4 and rAddr < 20) then --read data buffer
							algo_rdata_sig <= shRxReg(to_integer(rAddr)-5);	   		 		
						elsif (rAddr = 20) then			  		
							algo_rdata_sig <= std_logic_vector(rcv0_packet_count);	 		 
						elsif (rAddr = 21) then			  		
							algo_rdata_sig <= std_logic_vector(rcv1_packet_count);			 
						elsif (rAddr = 22) then			  		
							algo_rdata_sig <= std_logic_vector(rReqCnt);			 
						elsif (rAddr = 23) then			  		
							algo_rdata_sig <= std_logic_vector(dReqCnt);	   	  
						elsif (rAddr = 24) then			  		
							algo_rdata_sig <= std_logic_vector(resp_fifo_full_cnt);	   	   	 
						elsif (rAddr = 25) then			  		
							algo_rdata_sig <=  x"AA" & "000" & dbgSerialFifo_full & "000" & dbgSerialFifo_empty;	 
						elsif (rAddr = 26) then			  		
							algo_rdata_sig(3 downto 0) <=  last_dbg_type_req; 
						elsif (rAddr = 27) then			  		
							algo_rdata_sig <= std_logic_vector(dcsReqCnt);	   
						elsif (rAddr = 28) then			  		
							algo_rdata_sig <= dummy_reg;	
						elsif (rAddr = 29) then
						else						
							algo_rdata_sig <= std_logic_vector(rAddr) & std_logic_vector(to_unsigned(ALGO_LOC_ADDR, gAPB_DWIDTH-ALGO_RADDR_WIDTH));
						end if;
						
					end if;	  
				end if;	   				
			end if;			
		end process;   				
	end generate;
	
end arch;

