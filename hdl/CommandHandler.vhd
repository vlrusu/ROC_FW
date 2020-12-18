--------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: CommandHandler.vhd
-- File history:
--      	v00: Feb 25, 2015: Birthday
--			V01: August 7th, 2015 
--			v02: December 2, 2020:  MT cleans code and adds some CH_STATUS values
--			v03: December 11, 2020: fix bug in DCSReadBlock caused by previous code clean
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
            ALGO_CLK							: IN std_logic;       
            RESET_N							: IN std_logic;	   	  
																 
				--DCS FIFO interface					  															
            DCS_RCV_FIFO_DATA_0			: OUT  std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH downto 0);    -- W/R | Addr(31:16) | WData(15:0)	   		   	
				DCS_RCV_FIFO_WE_0 			: OUT  std_logic;       
				                        		
            DCS_RESP_FIFO_EMPTY_0		: IN  std_logic;            													
            DCS_RESP_FIFO_FULL_0		   : IN  std_logic;    	
            DCS_RESP_FIFO_Q_0			   : IN  std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH downto 0);    --  DCS_RCV_FIFO_EMPTY | Addr(31:16) | RData(15:0)
				DCS_RESP_FIFO_RD_CNT_0		: IN  STD_LOGIC_VECTOR(9 downto 0);
				DCS_RESP_FIFO_RE_0 			: OUT  std_logic; 
				                        		
				DCS_RESET_FIFOS_0 			: OUT  std_logic;   
				
				-- RocMonitor Interface			
				ALGO_RESET						: IN std_logic;
				ALGO_ADDR 						: IN std_logic_vector(gAPB_DWIDTH-1 downto 0);	 	  
				ALGO_WDATA						: IN std_logic_vector(gAPB_DWIDTH-1 downto 0);	
				ALGO_RDATA						: inout std_logic_vector(gAPB_DWIDTH-1 downto 0);
				                        		
		                                		
				-- ResponseFifo_0 Interface
            RESP_FIFO_DATA_0 			   : OUT std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				RESP_FIFO_WE_0 				: OUT std_logic;	  	 
				RESP_FIFO_RESET_0 			: OUT std_logic;
				RESP_FIFO_FULL_0 			   : IN std_logic;	  				   
				
				HEARTBEAT_EVENT_WINDOW_TAG	: OUT STD_LOGIC_VECTOR(DATAREQ_EVENT_WINDOW_SIZE-1 downto 0);
				
				-- Data Request	 (Request Side)		
				DATAREQ_START_EVENT_REQ		: OUT STD_LOGIC;  														--gimme Event Window Flag	
				DATAREQ_EVENT_WINDOW_TAG_1	: OUT STD_LOGIC_VECTOR(DATAREQ_EVENT_WINDOW_SIZE-1 downto 0);		--TAG 1 
				DATAREQ_EVENT_WINDOW_TAG_2	: OUT STD_LOGIC_VECTOR(DATAREQ_EVENT_WINDOW_SIZE-1 downto 0);		--Optional		 
				                                
				--Data Request (Reply Side) 	
				DATAREQ_DATA_READY_FLAG		: IN  STD_LOGIC;
				DATAREQ_LAST_WORD_FLAG		: IN  STD_LOGIC;			   
				DATAREQ_STATUS				   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
				DATAREQ_DATA_REQ_REPLY		: IN  STD_LOGIC_VECTOR(DATAREQ_DWIDTH-1 downto 0);		   	--Data Reply
				DATAREQ_PACKETS_IN_EVENT	: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
				
				DATAREQ_RE_FIFO				: OUT STD_LOGIC; 
				
				-- ReceiveFifo_0 Interface  	
            RCV_FIFO_Q_0 				   : IN std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				RCV_FIFO_RE_0 					: OUT std_logic;	
				RCV_FIFO_RESET_0				: OUT std_logic;	
				RCV_FIFO_EMPTY_0 				: IN std_logic		
        );
end CommandHandler;
                                                                                                   

architecture arch of CommandHandler is    
   	--=======================		  
	--<A NAME="standard RocMonitor interface template">--
	signal rst_cmd		: 	std_logic;														
	signal enable		:	std_logic;						  
	
	signal ch_status	: std_logic_vector(gAPB_DWIDTH-1 downto 0);		

	signal ch_errors	: std_logic_vector(gAPB_DWIDTH-1 downto 0);		
	-- errors bit def:
	constant ERROR_UndefinedPacketType 		: natural := 0;	-- undef packet type received	 	
	constant ERROR_InvalidReadoutTimestamp : natural := 1;	-- invalid data readout timestamp (not an increasing number!!)
	constant ERROR_HasDrained 				   : natural := 2;	-- been in drain state				 
	constant ERROR_UndefinedPacketFormat 	: natural := 3;	-- invalid packet format  	 
	constant ERROR_ReadTimeout 				: natural := 4;	-- read timeout		 
	constant ERROR_CountMismatch			   : natural := 5;
					     	
	--=======================		
	--<A NAME="main signals">	  	
	type state_t is (
		S_waitForCRCCheck,
		S_DataReqHeader,  
		S_DataReqDataRead,
--		S_DcsReply,
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
	signal ch_state : state_t := S_Idle;	
	
	type dcsReq_state is (
		None,
		DCSWriteSingle,
		DCSWriteDouble,	
		DCSWriteBlock,
		DCSReadSingle, 		
		DCSReadDouble,
		DCSReadBlock
		); 			 
	
	signal dcsReq_op 										: dcsReq_state ;	
	signal dcs_standby									: std_logic;		
	signal rcvFifoRe0_mask							   : std_logic;	     	   
	signal rcvCnt											: unsigned(4 downto 0);			
	signal rcv0_packet_count   						: unsigned(gENDEC_DWIDTH-1 downto 0);
	signal resp_fifo_full_cnt  						: unsigned(gENDEC_DWIDTH-1 downto 0);	
	signal rReqCnt, dReqCnt, dcsReqCnt				: unsigned(gENDEC_DWIDTH-1 downto 0);		   	  
	signal rcv_data     	   						   : std_logic_vector(gENDEC_DWIDTH-1 downto 0);
	
	signal resp_fifo_data,resp_fifo_data_latch  	: std_logic_vector(gENDEC_DWIDTH-1 downto 0); 	
	signal resp_fifo_we,resp_fifo_we_latch			: std_logic ;	 			     	
	
	constant SH_RX_REG_DEPTH : natural := 15;											 	  								   
	type shRxReg_t is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	signal shRxReg 										: shRxReg_t(SH_RX_REG_DEPTH-1 downto 0);			
	signal shRxReg_dataReq_reply						: shRxReg_t(3 downto 0);	
				                        					
	signal packetType, lastPacketType				: unsigned(3 downto 0);			  			
	signal reqEventWindowTag							: unsigned(6*8-1 downto 0);		--6 byte    --		* NOTE: assume "timestamp" tag does not wrap around
	signal write_timestamp, read_timestamp 		: unsigned(6*8-1 downto 0);		--6 bytes	--      used to tag errors in EventWindowTag	    
	signal dbgDataPacketCnt								: unsigned(15 downto 0);	
	signal dbgDataType									: unsigned(3 downto 0);	
	signal dataReqDataReadCnt							: unsigned(15 downto 0);
	signal first_read										: std_logic ;	  	
	                                    					
	signal dcsReq_opCode		   		: unsigned(2 downto 0);	
	
	constant DCS_OPCODE_Read 		   : natural := 0;
	constant DCS_OPCODE_Write 			: natural := 1;
	constant DCS_OPCODE_BlockRead   	: natural := 2;
	constant DCS_OPCODE_BlockWrite   : natural := 3;	 
	constant DCS_OPCODE_DoubleRead   : natural := 4;
	constant DCS_OPCODE_DoubleWrite  : natural := 5;	
	
	signal dcsReq_blockAddrMode					: std_logic;				 
	signal dcsReq_reqAck							   : std_logic;  
	signal dcsReq_isWriteType						: std_logic;
	signal dcsReq_isFirstBlockPacket				: std_logic;
	signal dcsReq_blockAddr							: unsigned(gAPB_AWIDTH-1 downto 0);  
	signal dcsReq_addrs								: std_logic_vector(gAPB_AWIDTH-1 downto 0);
	signal dcsReq_data		   					: std_logic_vector(gAPB_DWIDTH-1 downto 0);  
	signal dcsReq_packetCount						: unsigned(9 downto 0);	 
	signal dcsReq_packetCount_store				: unsigned(9 downto 0);		 
	signal dcsReq_packetWordCount					: unsigned(2 downto 0);
	signal dcsReq_packetWordCount_store			: unsigned(2 downto 0);
	signal dcsReq_blockWordCount					: unsigned(15 downto 0);	
	signal dcsReq_blockWordCount_store			: unsigned(15 downto 0);	  
	signal readTimeout								: unsigned(15 downto 0);	
	
	type dcsBlockPacket_t is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);
	signal dcsReq_blockPacketStore				: dcsBlockPacket_t(7 downto 0);	   
	signal dcsReq_blockPacketRemainingWords	: unsigned(2 downto 0);
	                                    					                                    		
	signal rcv_fifo_empty_latch					: std_logic;
	signal fifo_rst									: std_logic ;	
	
	signal dataReq_FIFOReadyState					: unsigned(1 downto 0);
	signal dataReq_dataReady						: std_logic;
		
begin
	
	RCV_FIFO_RE_0  	<= (not RCV_FIFO_EMPTY_0) and rcvFifoRe0_mask;	  
	
	rcv_data       	<=  RCV_FIFO_Q_0; 
	packetType     	<= unsigned(rcv_data(7 downto 4));
															   											 
	RESP_FIFO_DATA_0  <= resp_fifo_data_latch;	
	RESP_FIFO_WE_0    <= resp_fifo_we_latch;		
	RESP_FIFO_RESET_0 <= not RESET_N or rst_cmd or fifo_rst;
 	
	HEARTBEAT_EVENT_WINDOW_TAG <= std_logic_vector(write_timestamp);
	
	--=======================
	--=======================			
	main: process( ALGO_CLK )
	begin				   					
  	--<A NAME="(0) Setup Signals">
	  if rising_edge(ALGO_CLK) then	
		   
			ch_status(14) <= enable;	
			ch_status(15) <= rst_cmd;	  
									
			rcv_fifo_empty_latch	   <= RCV_FIFO_EMPTY_0;
			resp_fifo_data_latch 	<= resp_fifo_data;	  
			resp_fifo_we_latch 		<= resp_fifo_we;	   
			
			fifo_rst          <= '0';
			rcvFifoRe0_mask   <= '0'; 		
			resp_fifo_we      <= '0';	
			
			DCS_RESP_FIFO_RE_0<= '0';	 
			DCS_RCV_FIFO_WE_0 <= '0';	  	
			
			DCS_RESET_FIFOS_0 <= '0';	  
			RCV_FIFO_RESET_0  <= '0';
			
			if (RESP_FIFO_FULL_0 = '1') then
				resp_fifo_full_cnt <=  resp_fifo_full_cnt + 1;
			end if;
			
			  --<A NAME="(1.A) Reset Received">
			if RESET_N = '0' or rst_cmd = '1' then		  

				ch_state						      <= S_Reset;	  
				ch_status 						   <= (others => '0');
				ch_errors 						   <= (others => '0');		

				DATAREQ_START_EVENT_REQ			<= '0';	
				DATAREQ_EVENT_WINDOW_TAG_1		<= (others => '0');
				DATAREQ_EVENT_WINDOW_TAG_2	   <= (others => '0');	
				DATAREQ_RE_FIFO					<= '0';
				dataReq_dataReady 				<= '0';
				dcsReq_isFirstBlockPacket		<= '1';
				dcsReq_packetWordCount			<= (others => '0');
				dcsReq_packetWordCount_store	<= (others => '0');
				dcsReq_data						   <= (others => '0');
				dcsReq_blockWordCount			<= (others => '0');
				dcsReq_blockWordCount_store	<= (others => '0');
				readTimeout						   <= (others => '0');
				dcsReq_blockPacketStore			<= (others => (others =>'0'));
				dcsReq_blockPacketRemainingWords<= (others => '0');
				dcsReq_blockAddrMode			   <= '0';
				dcsReq_blockAddr				   <= (others => '0');
				dcsReq_addrs				      <= (others => '0');	  	   
				dcsReq_op						   <= None;
				dcs_standby						   <= '0';
				rcv0_packet_count 				<= (others => '0');		
				rReqCnt 						      <= (others => '0');	
				dReqCnt 						      <= (others => '0');		
				dcsReqCnt 						   <= (others => '0');
				resp_fifo_full_cnt 				<= (others => '0');
				write_timestamp 	            <= (others => '0');
				read_timestamp 					<= (others => '1');	  
				first_read 						   <= '1';	
				reqEventWindowTag 				<= (others => '0'); 
				
			 --<A NAME="(1.B)S_RESET">
			elsif(ch_state = S_Reset) then 
			
				ch_state <= S_Idle;	  --  this transition is overridden if RESET_N is still low. But then CH_STATUS == x"00"		
            ch_status(7 downto 0) 	<= x"0F";
				
				DCS_RESET_FIFOS_0 		<= '1';	   
				RCV_FIFO_RESET_0 			<= '1';	   					
				fifo_rst 					<= '1';	
            
			else	
			
				ch_status(7 downto 0) <= (others => '1'); -- default to unknown state x:FF" if no other ch_status is explicitely defined
															 
				if(ch_state /= S_Idle and ch_state /= S_DbgDataHdrGen and ch_state /= S_DbgDataGen) then
					shRxReg <= shRxReg(SH_RX_REG_DEPTH-2 downto 0) & rcv_data;  	 
				end if;
			
				--Steps:
					-- if IDLE and a fifo is not empty, start reading the command
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
				if (ch_state = S_Idle) then
				  							 	  		
					ch_status(7 downto 0) <= x"01";	  
					rcvCnt <= (others => '0');	
					
					if(enable = '1') then
						
						--get next command from RESP or RCV fifo, with priority to RESP fifo
						
						if(DCS_RESP_FIFO_EMPTY_0 = '0') then --DCS reply available	  --DCS Reply goes first to not saturate the FIFO with data.
							--This is now an error, no responses should happen without a request waiting on it
							--DCS_RESP_FIFO_RE_0 <= '1';	
							ch_state 	      <= S_Drain; -- S_DcsReply;	
						elsif(RCV_FIFO_EMPTY_0 = '0') then	
							ch_state 			<= S_Rcv;			   	 						
							rcvFifoRe0_mask 	<= '1';		 	  		   	   
							rcv0_packet_count <= rcv0_packet_count + 1;   	 							  		   	   
						end if;		   
					end if;		   
												  						   
			
				elsif (ch_state = S_Rcv) then	 					 									
 					--make decision based on packetType (listed in ALGORITHM_CONSTANTS.VHD) 	
					ch_status(7 downto 0) <= x"02";	
					rcvFifoRe0_mask <= rcvFifoRe0_mask;	 --continue reading the same source
					
					lastPacketType <= packetType;
					if(packetType = PACKET_TYPE_Heartbeat) then			--> 1	 	 
						ch_state 	<= S_ReadReq;		 
						rReqCnt 	   <= rReqCnt + 1;
					elsif(packetType = PACKET_TYPE_DataRequest) then  	--> 2  	 
						ch_state 	<= S_DataReq;	  
						dReqCnt 	   <= dReqCnt + 1;
					elsif(packetType = PACKET_TYPE_DCSRequest) then		--> 0		   	 
						ch_state 	<= S_DcsReq;	  
						dcsReqCnt 	<= dcsReqCnt + 1;
					else
						ch_errors(ERROR_UndefinedPacketType) 	<= '1'; --unrecognized packet type  	   
						ch_state 	<= S_Drain;	
						rcvCnt 		<= to_unsigned(4,5);	--indicate how much to clear from drain(?)			  
					end if;		
					
													 									                   
				elsif (ch_state = S_ReadReq) then	
					-- continue decoding Heartbeat packet 								  						 	 
					ch_status(7 downto 0) <= x"05";		
					
					rcvCnt <= rcvCnt + 1;	 			  			
					rcvFifoRe0_mask <= rcvFifoRe0_mask;								
					
					if(rcvCnt >= 0 and rcvCnt < 3) then 	-- acquire timestamp (3 chunks of 16-bits)
						reqEventWindowTag <= unsigned(rcv_data) & reqEventWindowTag(6*8-1 downto 2*8); -- shift down words 
					elsif(rcvCnt = 3) then 						-- reserved 16-bits : do nothing			 
					elsif(rcvCnt = 4) then 			 			-- end of packet: define WRITE_TIMESTAMP
						if(reqEventWindowTag < write_timestamp) then --new min
							ch_errors(ERROR_InvalidReadoutTimestamp) <= '1';
						end if;				   
						
						--	* NOTE: assume "timestamp" tag does not wrap around
						write_timestamp <= reqEventWindowTag;

						if(first_read = '1') then -- illegal read becomes current write 
							read_timestamp <= reqEventWindowTag;  
							first_read <= '0';
						end if;
						
						ch_state <= S_Done;			  
					end if;
																	 	 									
				--<A NAME="DATA REQUESTS">
				------------------------------------------------------------------
				elsif (ch_state = S_DataReq) then	 	
					-- continue decoding Data Reqiest packet 								  						 	 
					ch_status(7 downto 0) <= x"06";							
					
					rcvCnt <= rcvCnt + 1;	 	
					rcvFifoRe0_mask <= rcvFifoRe0_mask;			 
					
					if(rcvCnt >= 0 and rcvCnt < 3) then 	--acquire timestamp (3 chunks of 16-bits)
						reqEventWindowTag 	<= unsigned(rcv_data) & reqEventWindowTag(6*8-1 downto 2*8); -- shift down words 	 
						dataReq_dataReady 	<= '0';
					elsif(rcvCnt = 3) then 						-- reserved 16-bits: do nothing			 
					elsif(rcvCnt = 4) then 						-- contain "debug" data info
						if (rcv_data(0) = '1') then 			-- need to save data for debugging		 								     
							ch_state			<= S_DbgData;
							dbgDataType		<= unsigned(rcv_data(7 downto 4));
						else											
							ch_state							<= S_DataReqHeader;
							readTimeout						<= (others => '1');
							rcvCnt							<= (OTHERS => '0');
							DATAREQ_START_EVENT_REQ		<= '1';			
							DATAREQ_EVENT_WINDOW_TAG_1	<= std_logic_vector(reqEventWindowTag); 
							DATAREQ_EVENT_WINDOW_TAG_2	<= std_logic_vector(reqEventWindowTag + 1);
							dataReq_dataReady 			<= '0';
						end if;										  
--					elsif (rcvCnt < 20) then			-- needed to avoid going into S_Done when rcvCnt = 3!!	 
--					
					else
						ch_state 	<= S_Done;
					end if;		
					

				elsif (ch_state = S_DataReqHeader) then
				-- start building Data Header Packet in reply to DataRequest 
					ch_status(7 downto 0) 		<= x"08";  
					DATAREQ_START_EVENT_REQ		<= '0';	  
					dataReq_FIFOReadyState		<= (others => '0');		
					
					if (dataReq_dataReady = '0') then  	--  Wait for DATA Ready
																	--  If timeout, drain!... Reset Packet Sender. Send Drain Marker.
					
						if (DATAREQ_DATA_READY_FLAG = '1') then
							dataReq_dataReady		<= '1';	
						else						   
							if (readTimeout = 0) then  
								ch_state								<= S_Drain;	 
								ch_errors(ERROR_ReadTimeout)	<= '1';
							end if;
						end if;									
						readTimeout		<= readTimeout - 1;
						
					else 			-- data is ready: build Data Header packet
					-- 
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
							ch_state						<= S_DataReqDataRead; 	
							dataReq_dataReady			<= '0';
							dataReq_FIFOReadyState	<= (others => '0');			 
							rcvCnt						<= (others => '0');			
						else
							ch_state						<= S_Reset;
						end if;
					end if;		 
				------------------------------------------------------------------
				elsif (ch_state = S_DataReqDataRead) then	  	
				-- start building Payload Data Packet in reply to DataRequest after Data Header Packet 
					ch_status(7 downto 0) 		<= x"09";  
					DATAREQ_RE_FIFO				<= '0';	 
					
					if (dataReq_dataReady = '0') then 		--Wait and Receive Data				 
						resp_fifo_we			<= '0';

						if (dataReq_FIFOReadyState = 0) then  
							if ((DATAREQ_DATA_READY_FLAG = '1' and dataReqDataReadCnt > 0) ) then
								dataReq_FIFOReadyState		<= to_unsigned(1,2); 
								DATAREQ_RE_FIFO				<= '1';	 
							else
								ch_state 					<= S_Done;
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
				elsif (ch_state = S_DbgData) then
					-- figure out requested lenght of Debug data
					ch_status(7 downto 0) <= x"10";	 
					
					dbgDataPacketCnt <= unsigned(rcv_data);	
						 						  
					rcvCnt <= (others => '0');				     
					ch_state <= S_DbgDataHdrGen;	 
																	 
				------------------------------------------------------------------
				elsif (ch_state = S_DbgDataHdrGen) then					
					--generate Debug Data Header packet
					ch_status(7 downto 0) <= x"11";
					
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
						read_timestamp <= reqEventWindowTag; 
						resp_fifo_data(7 downto 0) <= x"00";   -- status=0 : valid data	 
						resp_fifo_data(15 downto 8) <= x"FF";--ALGO_VERSION;--x"FF"; 
					elsif(rcvCnt = 7) then			
						resp_fifo_data <= std_logic_vector(read_timestamp(7 downto 0)) & x"FF";--(others => '1'); --reserved, or is this data?
						if(dbgDataPacketCnt = 0) then
							ch_state <= S_Idle;
						else								 						 
							rcvCnt <= (others => '0');	
-- MT commented next line, as it was in Jose's latest firmware							
							dbgDataPacketCnt <= dbgDataPacketCnt - 1; --correct count for countdown to 0	
							ch_state <= S_DbgDataGen;					 
						end if;
					end if;					
					
				------------------------------------------------------------------
				elsif (ch_state = S_DbgDataGen) then
					-- build Payload Debug Data (undefnined for now)
					ch_status(7 downto 0) <= x"12";					 
					
				------------------------------------------------------------------ 
				elsif (ch_state = S_DcsReq) then	  	   
				-- Use dcsReq_op to know the type of dcs request once its captured.
					ch_status(7 downto 0) <= x"0A"; 	 	
				
					-- Packet Type Doc Link => <A HREF="https://mu2e-docdb.fnal.gov/cgi-bin/private/RetrieveFile?docid=4914&filename=Mu2e_ROC_Packet_Protocol.pdf">Mu2e-doc-4914</A>
					-------------------------------------------------------------------------
					-- DCS Req Format
					-- word 0 =	Block Op Packet Count [15:6] | Reserved [5:4] | Op Code [3:0]  
						--	 opCode[1:0]: 0 = read, 1 = write, 2 = block_read, 3 = block_write 
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
					-- 		0 | Opcode(34:32) | Addr(31:16) | RData(15:0)
					
					rcvCnt <= rcvCnt + 1;	 	
					rcvFifoRe0_mask <= rcvFifoRe0_mask;	   
	
					if(rcvCnt = 0) then 	-->> get op code		 
						dcsReq_packetCount			<= unsigned(rcv_data(15 downto 6));	   --if DCS Read Block. It gets replaced later on by wordCount calculation
						dcsReq_packetCount_store	<= unsigned(rcv_data(15 downto 6));	
						dcsReq_blockAddrMode			<= rcv_data(4);
						dcsReq_reqAck					<= rcv_data(3);		 
						dcsReq_opCode 					<= unsigned(rcv_data(2 downto 0));
						dcsReq_isFirstBlockPacket	<= '1';
						
					elsif(rcvCnt = 1) then  -->> 	get 1st address	   						
						dcsReq_addrs 			<= rcv_data;	
						dcsReq_isWriteType 	<= '0';	-- default to read type
						-- interpret Opcode
						if(dcsReq_opCode = DCS_OPCODE_Read) then
						
							dcsReq_op				<= DCSReadSingle; 								
							DCS_RCV_FIFO_WE_0 	<= '1';			
							DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)								<= (others => '0');
							DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<=  '0' & rcv_data;		 
						
						elsif(dcsReq_opCode = DCS_OPCODE_DoubleRead) then  
							
							dcsReq_op				<= DCSReadDouble;  							
							DCS_RCV_FIFO_WE_0 	<= '1';		
							DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)								<= (others => '0');
							DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH)	<= '0' & rcv_data;		 				  	
						
						elsif(dcsReq_opCode = DCS_OPCODE_BlockRead) then	

							dcsReq_op				<= DCSReadBlock;		
							dcsReq_blockAddr		<= unsigned(rcv_data);	 	 

						elsif(dcsReq_opCode = DCS_OPCODE_Write) then 
						
							dcsReq_op				<= DCSWriteSingle;
							dcsReq_isWriteType 	<= '1';
							
						elsif(dcsReq_opCode = DCS_OPCODE_DoubleWrite) then
						
							dcsReq_op				<= DCSWriteDouble;			
							dcsReq_isWriteType 	<= '1';
							
						elsif(dcsReq_opCode = DCS_OPCODE_BlockWrite) then
						
							dcsReq_op				<= DCSWriteBlock;	 
							dcsReq_blockAddr		<= unsigned(rcv_data);	
							dcsReq_isWriteType 	<= '1';	
							
						else			  
							
							ch_state 									<= S_Drain;								
							ch_errors(ERROR_UndefinedPacketType) <= '1';
							
						end if;
					
					elsif(rcvCnt = 2) then	-->> get 1st data or block word count  	
						
						--  Block Stream Operation
						--Note: DCSReadSingle is already done, so would be invalid at this point
						if 	(dcsReq_op = DCSReadSingle) 	then 	-- do nothing on data word place	
						elsif (dcsReq_op = DCSReadDouble) 	then 	-- do nothing on data word place 
						elsif (dcsReq_op = DCSWriteSingle)	then 
							DCS_RCV_FIFO_WE_0 	<= '1';			
							DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)								<= rcv_data;
							DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= '1' & std_logic_vector(dcsReq_addrs);	 		 
							
							if(dcsReq_reqAck = '1') then
								rcvCnt 				<= (others => '0');
								ch_state				<= S_DcsAck;		 	
							end if;	  

							elsif (dcsReq_op = DCSWriteDouble) then 							
															  
							DCS_RCV_FIFO_WE_0 	<= '1';			
							DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)								<= rcv_data;
							DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= '1' & dcsReq_addrs;	 		 
								
						elsif (dcsReq_op = DCSReadBlock) then	
							if(unsigned(rcv_data) = 0) then -- error, cant read 0 words!
								ch_state 				<= S_Drain;			 
							end if;								   
							
							dcsReq_blockWordCount	<= unsigned(rcv_data);		   							
							
							--check for packet count, word count mismatch  
							-- hijack dcsReq_blockWordCount_store signal for the test		   
							dcsReq_blockWordCount_store(15 downto 0) <=  unsigned(rcv_data) + 4; -- := (word_count + 4) / 8 (divide by 8 in next step) 
							
						elsif (dcsReq_op = DCSWriteBlock) then 											   		 
							rcvFifoRe0_mask			<= '0';		--Hold the current write data
							if(unsigned(rcv_data) = 0) then -- error, cant read 0 words!
								ch_state 				<= S_Drain;			 
							end if;								   
							
							dcsReq_blockWordCount	<= unsigned(rcv_data) - 1;		   							
							
							--check for packet count, word count mismatch  
							-- hijack dcsReq_blockWordCount_store signal for the test		   
							dcsReq_blockWordCount_store(15 downto 0) <=  unsigned(rcv_data)+ 4; -- := (word_count + 4) / 8 (divide by 8 in next step) 																		 
														
						else	  								  
							ch_state <= S_Drain;								
							ch_errors(ERROR_UndefinedPacketType) <= '1';
						end if;	
						
					--Double Operand!
					elsif(rcvCnt = 3) then 	-->> 	get 2nd address  
						dcsReq_addrs <= rcv_data;	   
						
						if		(dcsReq_op = DCSReadSingle) 	then  -- do nothing	 
						elsif (dcsReq_op = DCSWriteSingle)	then 	-- do nothing
						elsif (dcsReq_op = DCSWriteDouble) 	then 	-- do nothing until we get 2nd data										
						elsif (dcsReq_op = DCSReadDouble) 	then	 
								
							DCS_RCV_FIFO_WE_0 	<= '1';			
							DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)								<= (others => '0');
							DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<=	'0' & rcv_data;	  
														  					   
						elsif (dcsReq_op = DCSReadBlock or dcsReq_op = DCSWriteBlock) then 			 												 

							--use extra clock to check for packet count vs word count mismatch	
							if(dcsReq_blockWordCount_store(12 downto 3) /= 
								dcsReq_packetCount_store and dcsReq_op = DCSWriteBlock) then -- error, mismatch in size!
								ch_state <= S_Drain;				
								ch_errors(ERROR_CountMismatch) <= '1';
							else					  
								--fix hijacked signal
								dcsReq_blockWordCount_store 	<= 	dcsReq_blockWordCount;	
								dcsReq_packetWordCount 			<= 	to_unsigned(2,3);  -- init to 2	
								dcsReq_packetWordCount_store	<=  	to_unsigned(2,3);
								
								if (dcsReq_op = DCSWriteBlock) then 	
									rcvFifoRe0_mask				<= '1';
									rcvCnt							<= (others => '0');
									ch_state							<= S_DCSWriteBlockReq;
								
								else --if Read
									--initialize packet store
									dcsReq_blockPacketStore <= (others => (others => '0')); --clear packet store	
									dcsReq_blockPacketStore(3) <= x"8040";
									dcsReq_blockPacketStore(2) <= std_logic_vector(dcsReq_blockWordCount_store(12 downto 3)) & '0' & dcsReq_blockAddrMode & dcsReq_reqAck & std_logic_vector(dcsReq_opCode);
									dcsReq_blockPacketStore(1) <= std_logic_vector(dcsReq_blockAddr);			
									dcsReq_blockPacketStore(0) <= std_logic_vector(dcsReq_blockWordCount);
									
									--initialize packetCount
									dcsReq_packetCount			<=	dcsReq_blockWordCount_store(12 downto 3);
								end if;	
							end if;														
														
						else	  								  
							ch_state <= S_Drain;								
							ch_errors(ERROR_UndefinedPacketType) <= '1';
						end if;	
						
						
					elsif(rcvCnt = 4) then 	-->> 	get 2nd data, go to done and ignore last word 	 
						if (dcsReq_op	= DCSReadSingle) then
							rcvCnt		<= (others => '0');	 
							ch_state		<= S_DcsReadSingleResp;
							readTimeout <= (others => '1'); 			-- init timeout
						elsif (dcsReq_op = DCSWriteSingle) then  
							ch_state		<= S_Done;
						elsif (dcsReq_op = DCSReadDouble) then 	  
							ch_state		<=	S_DcsReadDoubleResp; 	   	 
							readTimeout <= (others => '1');
						elsif (dcsReq_op = DCSWriteDouble) then 							
															  
							DCS_RCV_FIFO_WE_0 	<= '1';			
							DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)								<= rcv_data;
							DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<=  '1' & dcsReq_addrs;	 											
								
							if(dcsReq_reqAck = '1') then
								rcvCnt 	<= (others => '0');
								ch_state	<= S_DcsAck;		 	
							else		 
								ch_state	<= S_Done; 	 
							end if;	  				  			
						elsif (dcsReq_op = DCSReadBlock) then			   
								rcvCnt	<= (others => '0');
								ch_state	<= S_DCSReadBlockReq; 		
						--elsif (dcsReq_op = DCSWriteBlock) then	 	
						else									  
							ch_state <= S_Drain;								
							ch_errors(ERROR_UndefinedPacketType) <= '1';
						end if;	
					else --invalid rcv cnt!!!						 							  				  
							ch_state <= S_Drain;		
							ch_errors(ERROR_UndefinedPacketType) <= '1';
					end if;	   				  					
					
					--TEMPLATE for ignore and drain
					--					rcvFifoRe0_mask <= rcvFifoRe0_mask;	
					--					ch_state <= S_Drain;	
					--					rcvCnt <= x"3";				  
						
				------------------------------------------------------------------
				elsif (ch_state =  S_DcsReadSingleResp) then		
					-- read enough resp fifo words from DCS_RESP fifo for a packet	
					-- hand packet to packet sender through RESP fifo	  
					ch_status(7 downto 0) <= x"0B"; 	 	
									   					
					if(DCS_RESP_FIFO_EMPTY_0 = '0') then --DCS reply available	   
						DCS_RESP_FIFO_RE_0 	<= '1';									 
						ch_state					<= S_DcsReadSingleTransferToSender;
						readTimeout 			<= (others => '1'); --reset timeout
					end if;								
							 
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						ch_state 							<= S_Drain;
						ch_errors(ERROR_ReadTimeout) 	<= '1';
					end if;		
					
				elsif (ch_state = S_DcsReadSingleTransferToSender) then
					ch_status(7 downto 0) <= x"1B"; 	 	
				
					rcvCnt 			<= rcvCnt + 1;
					resp_fifo_we 	<= '1'; 	 										   
					resp_fifo_data <=	(others => '0'); 	
					
					if(rcvCnt = 0) then		--DMA Byte Count	
						resp_fifo_data <=	(others => '0');
					elsif(rcvCnt = 1) then	--Valid(15)|Reserved(14:11)|RocLinkID(10:8)|PacketType(7:4)|HopCount(3:0)
						resp_fifo_data <=	x"8040";
					elsif(rcvCnt = 2) then	--PacketCount(15:6)| Reserved(5) | Opcode (4:0) 		  
						resp_fifo_data	<= (others => '0');
					elsif(rcvCnt = 3) then	--Addr1(15:0)			   
						resp_fifo_data	<= DCS_RESP_FIFO_Q_0(31 downto 16);
					elsif(rcvCnt = 4) then	--Data(15:0)		  
						resp_fifo_data	<= DCS_RESP_FIFO_Q_0(15 downto 0);  
					--elsif(rcvCnt = 5,6,7) then 
					elsif(rcvCnt = 8) then
						resp_fifo_we 	<= '0'; 
						ch_state			<= S_Done;
					end if;													
				------------------------------------------------------------------	
				elsif (ch_state =  S_DcsReadDoubleResp) then		
					-- read enough resp fifo words from DCS_RESP fifo for a packet	
					-- hand packet to packet sender through RESP fifo	  
					ch_status(7 downto 0) <= x"0C"; 	 	
									   					
					if(unsigned(DCS_RESP_FIFO_RD_CNT_0) = 2 ) then --DCS reply available	
						rcvCnt 					<= (others => '0');
						DCS_RESP_FIFO_RE_0 	<= '1';									 
						ch_state					<= S_DcsReadDoubleTransferToSender;
						readTimeout <= (others => '1'); --reset timeout	
					end if;		
						
							 
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						ch_state <= S_Drain;
						ch_errors(ERROR_ReadTimeout) <= '1';
					end if;		
					
				elsif (ch_state = S_DcsReadDoubleTransferToSender) then	
					ch_status(7 downto 0) <= x"1C"; 
					
					rcvCnt 					<= rcvCnt + 1;
					resp_fifo_we 			<= '1'; 	 										   
					resp_fifo_data 		<=	(others => '0'); 	
					
					if(rcvCnt = 0) then		
					elsif (rcvCnt = 1) then
						resp_fifo_data 	<=	x"8040";
					elsif(rcvCnt = 2) then	  		
						resp_fifo_data		<=  x"0004";
					elsif(rcvCnt = 3) then				   
						resp_fifo_data		<= DCS_RESP_FIFO_Q_0(gAPB_AWIDTH+gAPB_DWIDTH-1 downto gAPB_DWIDTH);
					elsif(rcvCnt = 4) then			  
						resp_fifo_data		<= DCS_RESP_FIFO_Q_0(gAPB_DWIDTH-1 downto 0);    
						DCS_RESP_FIFO_RE_0<= 	'1';	
					elsif (rcvCnt = 5) then									   	   
						resp_fifo_data		<= DCS_RESP_FIFO_Q_0(gAPB_AWIDTH+gAPB_DWIDTH-1 downto gAPB_DWIDTH);  
					elsif (rcvCnt = 6) then					
						resp_fifo_data		<= DCS_RESP_FIFO_Q_0(gAPB_DWIDTH-1 downto 0);  
					else
						ch_state	<= S_Done;
					end if;
				 --<A NAME="DCS_BLOCK_REQUEST">						--SPECIAL REQ.	
				 -----------------------------------------------------------------------
				elsif (ch_state = S_DcsReadBlockReq) then	
					ch_status(7 downto 0) <= x"0D"; 	 	
					
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
					DCS_RCV_FIFO_WE_0 	<= '1';		
					DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)								<= (others => '0');
					DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH)	<= '0' & std_logic_vector(dcsReq_blockAddr);
						
					-- Ctrl to stop requesting
					if(dcsReq_blockWordCount = 0) then	--if done with block Word Count		
						dcsReq_blockWordCount 	<= (others => '0'); 	--Used to indicate operation is DONE.
						ch_state 					<= S_DcsReadBlockResp;	--read 	 
						rcvCnt 						<= (others => '0');	  
						readTimeout 				<= (others => '1');
						DCS_RCV_FIFO_WE_0 		<= '0';
						
						if (dcsReq_isFirstBlockPacket = '1') then		  					
							
							dcsReq_packetWordCount 				<= dcsReq_packetWordCount_store - dcsReq_packetWordCount - 1; 
							dcsReq_blockPacketRemainingWords <=  dcsReq_packetWordCount + 1;  -- Plus 1 (+1) is to pad the first packet for the packet sender.	
						else  
							dcsReq_packetWordCount 				<= dcsReq_packetWordCount_store - dcsReq_packetWordCount - 1; 
							dcsReq_blockPacketRemainingWords <= dcsReq_packetWordCount + 1;
						end if;
						
					-- Reset Packet Word Count for DCS RCV								   		
					-- Restart the packet count
					elsif(dcsReq_packetWordCount = 0) then --done with packet worth of reads						
						ch_state 					<= S_DcsReadBlockResp;    
						readTimeout 				<= (others => '1'); --init timeout	
						rcvCnt 						<= (others => '0');	  	
						if(dcsReq_isFirstBlockPacket = '1') then   	   
							dcsReq_blockPacketRemainingWords <=  to_unsigned(0,3);   -- Plus 1 (+1) is to pad the first packet for the packet sender.
							dcsReq_packetWordCount			 	<= to_unsigned(2,3);
						else										
							dcsReq_blockPacketRemainingWords <=  (others => '0');
							dcsReq_packetWordCount 				<= to_unsigned(7,3);	 
						end if;			 	
					end if;		   						
								
				----------------------------------------------------------------	
				--Response after packetWordCount = 0 or blockWord = 0												   
				elsif (ch_state = S_DcsReadBlockResp) then		   			  
					ch_status(7 downto 0) <= x"1D"; 	 	
					
					-- read enough resp fifo words from DCS_RESP fifo for a packet	
					-- hand packet to packet sender through RESP fifo	  
								   
					if (rcvCnt = 0) then  --read from DCS Response FIFO											   												
						if(DCS_RESP_FIFO_EMPTY_0 = '0') then --DCS reply available	 
							
							DCS_RESP_FIFO_RE_0 	<= '1';
							rcvCnt					<= rcvCnt + 1;	 
							readTimeout 			<= (others => '1'); --reset timeout
						end if;		
						
					elsif (rcvCnt = 1) then	 			  
						
						rcvCnt			 			<= rcvCnt + 1;	 
						dcsReq_blockPacketStore(0) 			<= DCS_RESP_FIFO_Q_0(15 downto 0);	  
						dcsReq_blockPacketStore(7 downto 1) <= dcsReq_blockPacketStore(6 downto 0);
						
					elsif (rcvCnt = 2) then	  	 
						
						rcvCnt		<= rcvCnt + 1;		
						if(dcsReq_packetWordCount = 0) then					
							-- hand to packet sender through RESP fifo!
							ch_state <= S_DcsReadBlockPacketFill;	 
							rcvCnt 	<= (others => '0');		
						else
							dcsReq_packetWordCount <= dcsReq_packetWordCount - 1;
						end if;	
						
					elsif (rcvCnt = 3) then
					
						if(DCS_RESP_FIFO_EMPTY_0 = '0') then --DCS reply available	   		
							DCS_RESP_FIFO_RE_0 	<= '1';
							rcvCnt 					<= ( 0 => '1', others => '0');
							readTimeout 			<= (others => '1'); --reset timeout 
						end if;		
					end if;	   
					
							 
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						ch_state 							<= S_Drain;
						ch_errors(ERROR_ReadTimeout) 	<= '1';
					end if;									
				-------------------------------------------------------------------
				--Check if we need to fill additional packages.
				elsif (ch_state = S_DcsReadBlockPacketFill) then  					 
					ch_status(7 downto 0) <= x"2D"; 	 	
					
					dcsReq_blockPacketRemainingWords <= dcsReq_blockPacketRemainingWords - 1;
					if(dcsReq_blockPacketRemainingWords = 0) then			  
						-- hand to packet sender through RESP fifo!	 
						ch_state 							<= S_DcsReadBlockTransferToSender;	 
						rcvCnt 								<= (others => '0');	
					else -- fill packet with dummy data
						dcsReq_blockPacketStore(0) 	<= (others => '0'); --dummy data	  
						dcsReq_blockPacketStore(7 downto 1) <= dcsReq_blockPacketStore(6 downto 0);						
					end if;
				---------------------------------------------------------------
				--Send to Packet Sender
				elsif (ch_state = S_DcsReadBlockTransferToSender) then		
					ch_status(7 downto 0) <= x"3D"; 	 	
					dcsReq_isFirstBlockPacket		<= '0';
					rcvCnt 								<= rcvCnt + 1;
					resp_fifo_we 						<= '1'; 	 										   
					resp_fifo_data 					<= dcsReq_blockPacketStore(7);  
					dcsReq_blockPacketStore(7 downto 1) <= dcsReq_blockPacketStore(6 downto 0);
					
					if(rcvCnt = 7) then	   		  
						
						if (dcsReq_blockWordCount > 0) then
							if (dcsReq_packetCount = 0) then
								ch_errors(ERROR_CountMismatch) <= '1';	
						  	 	ch_state 							<= 	S_Drain;
						   else	   					  
								dcsReq_packetWordCount_store	<= to_unsigned(7,3);
								dcsReq_packetWordCount			<= to_unsigned(7,3);
								dcsReq_packetCount 				<= dcsReq_packetCount - 1;	
								ch_state				 				<= S_DcsReadBlockReq;
							end if;
						else   
							ch_state <= S_Done;
						end if;
						
					end if;
				------------------------------------------------------------------
				elsif (ch_state = S_DcsWriteBlockReq) then	  						 
					-- packet count vs word count assumed already verified at this point!  					
					-- place write ops in DCS RCV fifo
					ch_status(7 downto 0) 	<= x"0E"; 	 	
					rcvCnt						<= rcvCnt + 1;
					
					if dcsReq_blockAddrMode = '1' then
						dcsReq_blockAddr		<= dcsReq_blockAddr + 1;
					end if;						 								
						
					dcsReq_blockWordCount 	<= dcsReq_blockWordCount - 1;	  
					dcsReq_packetWordCount	<= dcsReq_packetWordCount - 1;
					
					if(dcsReq_blockWordCount = 0) then	
						rcvCnt 					<= (others => '1');	
						ch_state 				<= S_DcsWriteBlockEmptyRecvFifo;							
						dcsReq_blockPacketRemainingWords <= dcsReq_packetWordCount;	
						
					elsif(dcsReq_packetWordCount = 0) then
						--done with packet worth of writes	 
						rcvCnt					<= to_unsigned(20,5);	--Artificial delay between packets so DCS RCV FIFO doesnt overflow.
						ch_state 				<= S_DcsWriteBlockWaitForNext;   
						readTimeout 			<= (others => '1'); --init timeout	 
					else 
						rcvFifoRe0_mask		<= '1';
					end if;		   						
								
					DCS_RCV_FIFO_WE_0 		<= '1';
					DCS_RCV_FIFO_DATA_0(gAPB_DWIDTH-1 downto 0)		<= rcv_Data; 

						
					DCS_RCV_FIFO_DATA_0(gAPB_AWIDTH+gAPB_DWIDTH downto gAPB_DWIDTH) 	<= 
						'1' & std_logic_vector(dcsReq_blockAddr);	 
				------------------------------------------------------------------	
				elsif (ch_state = S_DcsWriteBlockEmptyRecvFifo) then	  
					ch_status(7 downto 0) <= x"1E"; 	 	
					
					dcsReq_blockPacketRemainingWords <= dcsReq_blockPacketRemainingWords - 1;	
					if(dcsReq_blockPacketRemainingWords = 0) then
						ch_state 			<= S_Done;			
					else
						rcvFifoRe0_mask	<= '1';
					end if;
				------------------------------------------------------------------	
				elsif (ch_state = S_DcsWriteBlockWaitForNext) then	  
					ch_status(7 downto 0) <= x"2E"; 	 	
					if (rcvCnt /= 0) then
						rcvCnt	<= rcvCnt - 1;	
					end if;
					
					if(RCV_FIFO_EMPTY_0 = '0' and rcvCnt = 0) then	   
						rcvCnt 				<= (others => '0');	
						ch_state 			<= S_DcsWriteBlockReq;			   
						rcvFifoRe0_mask 	<= '1';	  
						readTimeout 		<= (others => '1'); --reset timeout
					end if;
							
					readTimeout <= readTimeout - 1;
					if(readTimeout = 0) then
						ch_state 							<= S_Drain;
						ch_errors(ERROR_ReadTimeout) 	<= '1';
					end if;
					
				elsif (ch_state = S_DcsAck) then	   
					ch_status(7 downto 0) <= x"07"; 	 	
					 
					rcvCnt 			<= rcvCnt + 1;  
					resp_fifo_we 	<= '1';		  	
					
					
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
						ch_state <= S_Idle;
					end if;
					
				 ----<A NAME="S_DCS_REPLY">
				--elsif (ch_state = S_DcsReply) then	  	 --Send Reply: UNUSED!
						--ch_status(7 downto 0) <= x"1F"; 
						
				elsif (ch_state = S_Drain) then							
					--drain the receive fifo, usually in response to error	 
					ch_status(7 downto 0) 			<= x"03";	
					ch_errors(ERROR_HasDrained) 	<= '1';
					ch_state 							<= S_Reset; 
					
					DCS_RESET_FIFOS_0 		<= '1';	   
					RCV_FIFO_RESET_0 			<= '1';	   					
					fifo_rst 					<= '1';					   
					
					
				elsif (ch_state = S_Done) then	
					--1 clk pit stop for FIFO empty signal to respond									   				
					ch_status(7 downto 0)	<= x"04";	
					ch_state 					<= S_Idle;		 
					DCS_RCV_FIFO_DATA_0 		<= (OTHERS => '0');
					rcvCnt 						<= (others => '0');
				end if;
				
			end if;		
		end if;			
	end process;
	
	--=======================--<A NAME="Algo_rdata">
	--=======================	
	roc_mon_gen	: for i in 0 to 0 generate	   
		--standard RocMonitor interface generate template
		signal algo_rdata_sig			: std_logic_vector(gAPB_DWIDTH-1 downto 0) := (others => 'Z');   --bus		
		signal locAddr						: unsigned(ALGO_LOCADDR_WIDTH-1 downto 0);		-- 8-bit bus														
		signal wAddr						: unsigned(ALGO_WADDR_WIDTH-1 downto 0);				-- 8-bit bus												
		signal wData						: std_logic_vector(ALGO_WDATA_WIDTH-1 downto 0);	-- 16-bit bus but bit[15] is filled as zero	
		signal we_latch, we				: std_logic;				   	   
																	  									  
		signal rAddr						: unsigned(ALGO_RADDR_WIDTH-1 downto 0) := (others => '1');	 -- 8-bit bus
		signal rst_cnt						: unsigned(3 downto 0) := (others => '0');		
		
		signal dummy_reg					: std_logic_vector(gAPB_DWIDTH-1 downto 0);
		
	begin				 
		 
		ALGO_RDATA 	<= algo_rdata_sig;	
		wAddr			<= extract_algo_waddr(ALGO_ADDR); --get write address  
		locAddr		<= extract_algo_locaddr(ALGO_ADDR); --get target location address  	 
		wData			<= extract_algo_wdata(ALGO_WDATA); -- get data
		
		roc_monitor: process( ALGO_CLK )   														 
		begin		
			
			if rising_edge(ALGO_CLK) then		  
																			 
				we       		<= extract_algo_we(ALGO_WDATA); -- get write enable		  
				we_latch 		<= we; --latch we bit		
				algo_rdata_sig <= (others => 'Z'); --always high impedance if not addressed
					   					
				-- gen reset pulse			
				rst_cmd <= '0';	  									
				if (rst_cnt /= 0) then
					rst_cnt 	<= rst_cnt - 1;
					rst_cmd 	<= '1';
				end if;
				
				-- main cases										 
				if ALGO_RESET = '1' then		 
					rst_cmd 	<= '0';	  			  		 
					rAddr 	<= (others => '1');  
					enable 	<= '1';	  		
				else							   	
					
					if(	locAddr = to_unsigned(ALGO_LOC_ADDR, ALGO_LOCADDR_WIDTH)) then --check target address
																	  
						--Writes
						if (we_latch = '0' and we = '1') then -- identify we rising edge
											
							if wAddr = 0 then 						   --setup rAddr
								rAddr <= unsigned(wData(ALGO_RADDR_WIDTH-1 downto 0));
							elsif wAddr = 1 then
								if (wData(0) = '1') then --start a reset pulse
									rst_cnt <= (others => '1');
								end if;  
							elsif wAddr = 2 then
								dummy_reg(ALGO_WDATA_WIDTH-1 downto 0) <= wData;
							end if;
							
						end if;	
						
						
						--Reads				
						algo_rdata_sig <= (others => '0');		  
						if (rAddr = 0) then			  		
							algo_rdata_sig <= ch_status;	  
						elsif (rAddr = 1) then			  		
							algo_rdata_sig <= ch_errors;	 
						elsif (rAddr = 2) then			  		
							algo_rdata_sig <= dummy_reg;										 						  
						elsif (rAddr = 3) then				-- last packet type  		
							algo_rdata_sig(3 downto 0) <= std_logic_vector(lastPacketType);
						elsif (rAddr > 4 and rAddr < 20) then --read data buffer
							algo_rdata_sig <= shRxReg(to_integer(rAddr)-5);	   		 		
						elsif (rAddr = 20) then	-- 0x14		  		
							algo_rdata_sig <= std_logic_vector(rcv0_packet_count);	 		 
						elsif (rAddr = 21) then			  		
							algo_rdata_sig <= std_logic_vector(rReqCnt);			 
						elsif (rAddr = 22) then			  		
							algo_rdata_sig <= std_logic_vector(dReqCnt);	   	  
						elsif (rAddr = 23) then			  		
							algo_rdata_sig <= std_logic_vector(dcsReqCnt);	   
						elsif (rAddr = 24) then			  		
							algo_rdata_sig <= std_logic_vector(resp_fifo_full_cnt);	   	   	 
						elsif (rAddr = 25) then				-- timestamp
							algo_rdata_sig <= std_logic_vector(reqEventWindowTag(2*8-1 downto 0*8));							 				
						elsif (rAddr = 26) then				-- timestamp					
							algo_rdata_sig <= std_logic_vector(reqEventWindowTag(4*8-1 downto 2*8));						
						elsif (rAddr = 27) then				-- timestamp
							algo_rdata_sig <= std_logic_vector(reqEventWindowTag(6*8-1 downto 4*8));		   		
						elsif (rAddr = 28) then			 	-- last requested timestamp
							algo_rdata_sig <= std_logic_vector(reqEventWindowTag(gAPB_DWIDTH-1 downto 0));
						elsif (rAddr = 29) then			  	-- current read timestamp pointer	
							algo_rdata_sig <= std_logic_vector(read_timestamp(gAPB_DWIDTH-1 downto 0));
						elsif (rAddr = 30) then			  	-- current last write timestamp	(last readout request)
							algo_rdata_sig <= std_logic_vector(write_timestamp(gAPB_DWIDTH-1 downto 0));			
						else						
							algo_rdata_sig <= std_logic_vector(rAddr) & std_logic_vector(to_unsigned(ALGO_LOC_ADDR, gAPB_DWIDTH-ALGO_RADDR_WIDTH));
						end if;
						
					end if;	  
				end if;	   				
			end if;			
		end process;   				
	end generate;
	
end arch;

