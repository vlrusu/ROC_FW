--------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: PacketSender.vhd
-- File history:
--      v00: Feb 25, 2015: Birthday	   
--
-- Description: 
-- PacketSender reads out own ForwardFifo (top priority) and own ResponseFifo
--	to SERDES.
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

entity PacketSender is         
	Generic (			
				NORMAL_FIFO_ADDR_SIZE		: integer := 9;
				NUM_OF_TCLK_IN_40			: integer := 5;
	            gAPB_DWIDTH     			: integer := 16;  
	            gAPB_AWIDTH     			: integer := 16;	 
	            gSERDES_DWIDTH  			: integer := 20; 
	            gENDEC_DWIDTH   			: integer := 16;	
	            IO_SIZE         			: integer := 2;
				ALGO_LOC_ADDR 				: natural := 0
		);                              	
		port(		
				CLK40_GEN					: in std_logic;
				ALIGNMENT_REQ				: in std_logic;
				LOOPBACKMARKER				: in std_logic;
                EPCS_TXCLK              	: in std_logic;            
	            ALGO_CLK              		: in std_logic;
                RESET_N                   	: in std_logic;	   
				                        	
				-- RocMonitor Interface						
				ALGO_RESET					: in std_logic;
				ALGO_ADDR 					: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	 	  
				ALGO_WDATA					: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	
				ALGO_RDATA					: inout std_logic_vector(gAPB_DWIDTH-1 downto 0);	   										   
														
				-- CRC Interface			 
			    CRC_RST       	   			: out std_logic;	  
			    CRC_EN       	   			: out std_logic;	 
			    CRC_OUT     	   			: in std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
			    CRC_IN    	   				: out std_logic_vector(gENDEC_DWIDTH-1 downto 0);
				                        	
				-- 8b10b CorePCS Interface					  									
                TX_CLK_STABLE          		: IN std_logic;	   
			    TX_DATA     	   			: OUT std_logic_vector(gENDEC_DWIDTH-1 downto 0);	
			    TX_K_CHAR     	   			: OUT std_logic_vector(IO_SIZE-1 downto 0);			
			    FORCE_DISP     	   			: OUT std_logic_vector(IO_SIZE-1 downto 0);			
			    DISP_SEL     	   			: OUT std_logic_vector(IO_SIZE-1 downto 0);	 
				                        	
				-- ResponseFifo Interface
		        RESP_FIFO_Q 				: in std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				RESP_FIFO_RE 				: out std_logic;
				RESP_FIFO_RESET				: out std_logic;
				RESP_FIFO_EMPTY 			: in std_logic;
				RESP_FIFO_COUNT				: in std_logic_vector(NORMAL_FIFO_ADDR_SIZE downto 0);
				                        	
				-- ForwardFifo Interface	
		        FWD_FIFO_Q 					: in std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				FWD_FIFO_RE 				: out std_logic;	
				FWD_FIFO_EMPTY 				: in std_logic; 
				
				-- Retransmission RAM											
				RETRANSMIT_DETECTED			: in std_logic;
				RETRANSMIT_SEQUENCE_REQ		: in std_logic_vector(2 downto 0); 
				
				RETRANSMIT_RAM_RE			: out std_logic;		  
				RETRANSMIT_RAM_RADDR		: out std_logic_vector(6 downto 0);	 

				RETRANSMIT_RAM_WADDR		: out std_logic_vector(6 downto 0);
				RETRANSMIT_RAM_WE			: out std_logic;		   
				RETRANSMIT_DOUT_TO_RAM		: out std_logic_vector(15 downto 0);
                RETRANSMIT_DOUT_FROM_RAM	: in std_logic_vector(15 downto 0)                      	
        );                              	
end PacketSender;                       	
                                        	                                                           
                                        	
architecture arch of PacketSender is    	       
				      	                	
	--=======================           	
	--standard RocMonitor interface temp late	
	signal rst_cmd							: std_logic := '0';		 												
	signal enable							: std_logic := '0';		 
	                                    	
	signal status							: std_logic_vector(gAPB_DWIDTH-1 downto 0);		 
		-- status bit def:              	
			-- 3:0 state	            	
			-- 8 indicate a fwd was sent ever
			-- 9 indicate a dbg was sent ever
			-- 14 enable                	
			-- 15 rst				    	
	signal errors							: std_logic_vector(gAPB_DWIDTH-1 downto 0);		
		-- errors bit def:
			-- 0 invalid resp packet
			-- 					
			
	constant ERROR_HasReset 				: natural := 0;				
	constant ERROR_WrongPacketOut			: natural := 1;
					     	
	--=======================
	--main signals	  		--| Equivalent Status (3 downto 0)
	type state_t is (		--------------------------------- 
		S_Pause,	   		--| Status: 10 
		S_OneExtra,			--| Status: 9  
		S_Crc,				--| Status: 8                                       
		S_Dbg,				--| Status: 7  
		S_WaitForRetransmitData,
		S_packetRetransmit,	
		S_postRetransmit,  
		S_doneRetransmit,
		S_Resp,				--| Status: 6                     
		S_Fwd,				--| Status: 5                     
		S_Start,			--| Status: 4                     	                              
		S_WaitForRespData,	--| Status: 3 
		S_Idle,				--| Status: 2 
		S_Reset,			--| Status: 1 				  
		S_TxClkLoss			--| Status: 15 (0xF)
		); 	  					 
	signal state : state_t := S_Idle;				 
	
--	constant status_Crc				: std_logic_vector(3 downto 0) := "0111";		
--	constant status_Dbg  			: std_logic_vector(3 downto 0) := "0110";	
--	constant status_Pause	  		: std_logic_vector(3 downto 0) := "0101";	
--	constant status_Resp			: std_logic_vector(3 downto 0) := "0100";	
--	constant status_Fwd 			: std_logic_vector(3 downto 0) := "0011";
--	constant status_Start			: std_logic_vector(3 downto 0) := "0010";		
--	constant status_OneExtra		: std_logic_vector(3 downto 0) := "0000";	
--	constant status_WaitForRespData	: std_logic_vector(3 downto 0) := "0001";	
--	constant status_Idle			: std_logic_vector(3 downto 0) := "0000";	
--	constant status_Reset	  		: std_logic_vector(3 downto 0) := "1111";
	--==============================
	---Debug Signals---	   
	signal one_bit_sig						: std_logic;
	---====================
	
	signal sendCnt							: unsigned(4 downto 0);	   
	signal fwdFifoRe_mask					: std_logic ;		     
	signal respFifoRe_mask					: std_logic ;		  
	signal txDataSel						: unsigned(2 downto 0) ;   
	
	constant TXDATASEL_FWDFIFO				: unsigned := "001";
	constant TXDATASEL_RSPFIFO				: unsigned := "010";
	constant TXDATASEL_CRC					: unsigned := "011";
	constant TXDATASEL_MARKER				: unsigned := "100";
	constant TXDATASEL_RETRANSMIT			: unsigned := "101";
	
	signal dbgDataSel						: unsigned(1 downto 0) ;
																							  
	signal tx_data_sig, tx_data_sig2 		: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal dbg_data_sig     	   			: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal fwd_fifo_latch  	   				: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal resp_tx_data     				: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal hdr_hdr_word     				: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	 	
													 
	constant SH_RX_REG_DEPTH 				: natural := 15;											 	  								   
	type shRxReg_t is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	signal shRxReg 							: shRxReg_t(SH_RX_REG_DEPTH-1 downto 0);	
																   								 
	signal disable_loop						: std_logic;   
	signal force_send						: std_logic;	 	
	signal force_reset						: std_logic;	 		  	
																 
	signal tx_k_char_sig     	   			: std_logic_vector(IO_SIZE-1 downto 0) := (others => '1');  	
	signal fwd_packet_count    				: unsigned(gENDEC_DWIDTH-1 downto 0);		  
	signal rsp_packet_count    				: unsigned(gENDEC_DWIDTH-1 downto 0);		  
	signal kchar_count    					: unsigned(gENDEC_DWIDTH-1 downto 0); --count anytime TX_K_CHAR is not "11"	
	signal kdata_count    					: unsigned(gENDEC_DWIDTH-1 downto 0); --count anytime TX_DATA is not "BC3C"		  
	                                    	
	signal respPacketType    				: unsigned(3 downto 0);		
	signal respPacketType_check				: std_logic_vector(3 downto 0);
	signal respPacketTypeSave    				: unsigned(3 downto 0);			  		  
	signal respDataPacketCnt    			: unsigned(15 downto 0);			  		  
	signal respDataPacketCnt_latch, respDataPacketCnt_latchlatch     			: unsigned(15 downto 0);
	signal nextIsPayload						: std_logic;				   			
	signal nextIsPayload_save					: std_logic;
	
	--Domain Transfer
	signal stepTXCLKin40					: unsigned (4 downto 0);
	signal loopbackLatch					: std_logic; 
	signal LoopbackLatch2					: std_logic; 
	signal LoopbackLatch3					: std_logic;	
	signal counterReset						: std_logic; 
	signal returnMarker						: std_logic;
	signal alignmentResetStrobe				: std_logic;  
	signal sendLoopbackOut					: std_logic;   
	
	signal dcsResp_BlockOp					: std_logic;			
	signal dcsResp_DoubleOp					: std_logic;
	
	signal needAlignment					: unsigned(2 downto 0);  
	signal alignmentReady					: std_logic;
	signal alignment_req_latch				: std_logic;
	signal alignment_req_latch2				: std_logic;
	signal alignment_req_risingEdge			: std_logic;
	
	signal resp_fifo_empty_latch			: std_logic;									 
	signal resp_fifo_count_latch			: std_logic_vector(NORMAL_FIFO_ADDR_SIZE downto 0);
	signal resp_fifo_count_latch2			: std_logic_vector(NORMAL_FIFO_ADDR_SIZE downto 0);
	signal resp_fifo_q_latch				: std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	signal resp_fifo_q_latch2				: std_logic_vector(gENDEC_DWIDTH-1 downto 0); 	
	signal resp_fifo_q_latch3				: std_logic_vector(gENDEC_DWIDTH-1 downto 0);
	
	signal tx_data_latch					: std_logic_vector(15 downto 0);
	signal tx_k_char_latch, tx_k_char_latch2: std_logic_vector(1 downto 0);			 
	signal clk40Counter						: unsigned (3 downto 0);	
	signal clk40_genlatch					: std_logic;
	signal clk40_genlatch2					: std_logic;
	signal flagDetectionEdge				: unsigned (4 downto 0); -- TX_CLK cycles. Range: 1 to NUM_OF_TCLK_IN_40-1. CANT BE 0	
	
	signal L_markerOffsetPlusTwo			: unsigned (20 downto 0);  
	signal L_markerOffsetPlusOne 			: unsigned (20 downto 0);	
	signal L_markerOffsetCenter				: unsigned (20 downto 0);  	 
	signal L_markerOffsetMinusOne			: unsigned (20 downto 0);	  
	signal L_markerOffsetMinusTwo			: unsigned (20 downto 0); 
	signal markerType						: std_logic_vector(15 downto 0);
	signal pausePacketTransmission			: std_logic;
	signal respFifoRe_maskSave				: std_logic;   
	
	signal retransmit_ram_save				: std_logic_vector(15 downto 0);
	signal retransmit_det_done				: std_logic;
	signal retransmit_det_sig				: std_logic;  
	signal retransmit_packet_req			: std_logic_vector(2 downto 0);   
	
	signal retransmit_word_count			: unsigned(3 downto 0);  
	signal retransmit_packet_req_unsigned	: unsigned(2 downto 0);	
	signal retransmit_read_count			: unsigned(3 downto 0);	 
	signal retransmitCnt					: unsigned(7 downto 0);	 
	signal rsp_packet_for_retransmit		: unsigned(2 downto 0);	
	signal rsp_packet_for_retransmit_latch	: unsigned(2 downto 0);
	signal retransmit_word_count_latch		: unsigned(3 downto 0);						 
	signal retransmit_data_signal 			: std_logic_vector(15 downto 0);
	signal retransmit_txdata_reg 			: std_logic_vector(15 downto 0); 
	signal flag_reset						: std_logic;
	signal mask_reset						: unsigned(2 downto 0);
	
	signal retransmit_we_packet_sender_state : std_logic;
	signal retransmit_we_latch1, retransmit_we_latch2 : std_logic;	
	signal retransmit_we_sig 				: std_logic;					
	
	signal crc_en_sig, crc_en_sig2 			: std_logic;	
	signal crc_to_tx, crc_to_tx2			: std_logic;								  
	
	
	signal debug_tx_clock_alive				: unsigned(3 downto 0);  
begin
															   												
	FWD_FIFO_RE <= (not FWD_FIFO_EMPTY) and fwdFifoRe_mask;	  

	FORCE_DISP 	<= (others => '0');		   
	DISP_SEL 	<= (others => '0');	  		 
				   
	dbg_data_sig	<= (std_logic_vector(kchar_count(7 downto 0)) &  tx_data_sig(7 downto 0)) when dbgDataSel = 1--(fwdFifoRe_mask & fwd_fifo_latch(10 downto 0) & status(3 downto 0)) 			when dbgDataSel = 1 
			   else	   (respFifoRe_mask & nextIsPayload & resp_tx_data(13 downto 0)) 				when dbgDataSel = 2 
			   else	   tx_data_sig when dbgDataSel = 3 --(CRC_OUT(15 downto 4) & resp_fifo_empty_latch & FWD_FIFO_EMPTY & tx_k_char_sig) 	when dbgDataSel = 3 
			   else    (std_logic_vector(txDataSel(1 downto 0)) & tx_k_char_sig & tx_data_sig(11 downto 0));	   -- while idle send K 28.5 & 28.1   
	
				   
	timingAlleviation: process (EPCS_TXCLK)	 	 	
	begin		
		if (rising_edge (EPCS_TXCLK)) then	 
			
			debug_tx_clock_alive <= debug_tx_clock_alive + 1;
			
			if (sendLoopbackOut = '0') then
				resp_fifo_q_latch 		<= RESP_FIFO_Q;	  
				resp_fifo_q_latch2		<= resp_fifo_q_latch;
				resp_fifo_q_latch3		<= resp_fifo_q_latch2; 
				resp_fifo_count_latch	<= RESP_FIFO_COUNT;
				resp_fifo_count_latch2	<= resp_fifo_count_latch;
				resp_fifo_empty_latch 	<= RESP_FIFO_EMPTY;
				RESP_FIFO_RE <= (not resp_fifo_empty_latch) and respFifoRe_mask;	   
			else
				RESP_FIFO_RE	<= '0';
			end if;
			
			TXDATA: case txDataSel is
				when TXDATASEL_FWDFIFO => 
				tx_data_sig <= fwd_fifo_latch(7 downto 0) & fwd_fifo_latch(15 downto 8);
				when TXDATASEL_RSPFIFO => 
				tx_data_sig <= resp_tx_data(7 downto 0) & resp_tx_data(15 downto 8);
				--when TXDATASEL_CRC => 
				--tx_data_sig <= CRC_OUT(7 downto 0) & CRC_OUT(15 downto 8);
				when TXDATASEL_MARKER => 
				tx_data_sig <= markerType(7 downto 0) & markerType(15 downto 8); 
				when TXDATASEL_RETRANSMIT=>
				tx_data_sig <= retransmit_data_signal;
				when others	=> 
				tx_data_sig <= x"3CBC";	  -- the DTC receives BC3C (byte-flipped)
			end case;  
			
			--give one extra clock for CRC calc before going to tx data
			if (txDataSel = TXDATASEL_CRC) then		
				crc_to_tx <= '1';
			else
				crc_to_tx <= '0';		   
			end if;
			
			tx_data_sig2 <= tx_data_sig;
			crc_to_tx2 <= crc_to_tx;
			if(crc_to_tx2 = '1') then   
				TX_DATA <= CRC_OUT(7 downto 0) & CRC_OUT(15 downto 8);	 
			else
				TX_DATA	<= tx_data_sig2;
			end if;	
											  	  
			
			tx_k_char_latch	<= tx_k_char_sig;  
			tx_k_char_latch2 <= tx_k_char_latch;
			TX_K_CHAR <= tx_k_char_latch2;	   
			
			---CRC EN Delay---		 
			crc_en_sig2 <= crc_en_sig;
			CRC_EN <= crc_en_sig2; 
			CRC_IN <= tx_data_sig(7 downto 0) & tx_data_sig(15 downto 8); 				
			
			----RAM WE Delay----
			retransmit_we_latch1 <= retransmit_we_packet_sender_state;
			retransmit_we_latch2 <= retransmit_we_latch1; 
			
			retransmit_we_sig <= '0';
			if(retransmit_we_latch1 = '1' or retransmit_we_latch2 = '1') then --extra clock to get CRC
					 			
				if(crc_to_tx = '1') then   
					retransmit_txdata_reg <= CRC_OUT(7 downto 0) & CRC_OUT(15 downto 8);	 
				else
					retransmit_txdata_reg	<= tx_data_sig;
				end if;	   
				
				retransmit_we_sig <= '1';
			end if;
			
			clk40_genlatch 	<= CLK40_GEN; 
			clk40_genlatch2	<= clk40_genlatch;	
			
			retransmit_det_sig	<= RETRANSMIT_DETECTED;				 
			retransmit_packet_req	<= RETRANSMIT_SEQUENCE_REQ;		
		
		end if;							
	end process;
				   
				   
	--=======================--
	--=======================--		
	--Domain Transfer (40Mhz to 200Mhz). 		 
	--Reset: 						   
	--Input: markers, reset
	--Output: markerDetected on 1st edge.  
	--=======================		  	    
		
	domainTransfer: process( EPCS_TXCLK )  															    	
	begin 					 
		if rising_edge(EPCS_TXCLK) then		
			respFifoRe_maskSave			<= respFifoRe_mask;
			alignment_req_risingEdge	<= 	alignment_req_latch and not alignment_req_latch2;	
			
			loopbackLatch 				<= LOOPBACKMARKER;			--latch loopback	
			LoopbackLatch2				<= loopbackLatch;	  
			LoopbackLatch3				<= loopbackLatch2;
			sendLoopbackOut 				<= '0';				 
			
			alignment_req_latch			<= ALIGNMENT_REQ;
			alignment_req_latch2		<= alignment_req_latch;
			
--	 -		------create wrapping counter in TCLK representing 40	   
			if (stepTXCLKin40 = NUM_OF_TCLK_IN_40 - 1 or 
				(clk40_genlatch2 = '0' and clk40_genlatch = '1')) then
				stepTXCLKin40 			<= (others => '0');   
			else
				stepTXCLKin40 			<= stepTXCLKin40 + 1;
			end if;	 
			
			retransmit_word_count_latch <= retransmit_word_count;  
			
			------Storage to RAM-----------		  
			RETRANSMIT_RAM_WE <= '0';
			if (retransmit_we_sig = '1') then 
				
				retransmit_word_count_latch	<= retransmit_word_count_latch + 1;	
				
				--condition < 11 should never be used, but a little extra safety to prevent corrupting other packets
				if (retransmit_word_count_latch < 11) then
					RETRANSMIT_RAM_WADDR	<= std_logic_vector(rsp_packet_count(2 downto 0)) & std_logic_vector(retransmit_word_count_latch); 
					RETRANSMIT_DOUT_TO_RAM	<= retransmit_txdata_reg; 
					RETRANSMIT_RAM_WE 		<= '1';
				end if;			
			end if;	 
			
			-------------------------------------------
					
			if(RESET_N = '0') then	--Reset signal	 
				flagDetectionEdge		<= (others => '0');
				needAlignment			<= (others => '0');
				alignmentReady			<= '0';
				L_markerOffsetPlusTwo	<= (others => '0');
				L_markerOffsetPlusOne 	<= (others => '0');
				L_markerOffsetCenter	<= (others => '0');
				L_markerOffsetMinusOne	<= (others => '0');
				L_markerOffsetMinusTwo	<= (others => '0');
				
			elsif (alignment_req_risingEdge = '1') then				--DCS Reset.
				alignmentReady			<= '0';
				needAlignment			<= (others => '0');						  
				L_markerOffsetPlusTwo	<= (others => '0');
				L_markerOffsetPlusOne 	<= (others => '0');
				L_markerOffsetCenter	<= (others => '0');
				L_markerOffsetMinusOne	<= (others => '0');
				L_markerOffsetMinusTwo	<= (others => '0');

			else		
				--Normal Op	
				if(loopbackLatch2 = '1' and LoopbackLatch3 = '0' and needAlignment < 2) then 				--Loopback Alignment 	  
					needAlignment			<= needAlignment + 1;
				elsif(loopbackLatch2 = '1' and LoopbackLatch3 = '0' and needAlignment = 2) then 			--Loopback Alignment
					if(stepTXCLKin40 > 1) then
						flagDetectionEdge		<=  stepTXCLKin40 + 3 - 5;
					else
						flagDetectionEdge		<=  stepTXCLKin40 + 3;
					end if;		 
					needAlignment		<= needAlignment + 1;	  
				elsif (loopbackLatch2 = '1' and LoopbackLatch3 = '0' and needAlignment > 2) then
					alignmentReady	<= '1';
				end if;					
				
				if		(loopbackLatch2 = '1' and LoopbackLatch3 = '0' and alignmentReady = '1')	then
					if		(stepTXClkin40 = flagDetectionEdge) then		
						L_markerOffsetMinusTwo	<=	L_markerOffsetMinusTwo + 1;
					elsif 	(stepTXClkin40 = flagDetectionEdge + 1 or stepTXClkin40 = flagDetectionEdge + 1 - 5) 	then 
						L_markerOffsetMinusOne	<=	L_markerOffsetMinusOne + 1;	
					elsif 	(stepTXClkin40 = flagDetectionEdge + 2 or stepTXClkin40 = flagDetectionEdge + 2 - 5) 	then
						L_markerOffsetCenter 	<=	L_markerOffsetCenter + 1;	
					elsif 	(stepTXClkin40 = flagDetectionEdge - 1 or stepTXClkin40 = flagDetectionEdge - 1 + 5) 	then
						L_markerOffsetPlusTwo	<= L_markerOffsetPlusTwo + 1;	
					elsif 	(stepTXClkin40 = flagDetectionEdge - 2 or stepTXClkin40 = flagDetectionEdge - 2 + 5) 	then	
						L_markerOffsetPlusOne	<= L_markerOffsetPlusOne + 1;
						if(stepTXCLKin40 > 1) then				   	--if there are 
							flagDetectionEdge		<=  stepTXCLKin40 + 3 - 5;
						else
							flagDetectionEdge		<=  stepTXCLKin40 + 3;
						end if;
					end if;	
				end if;
--					----Detection of Marker and Mode.
				if(stepTXCLKin40 = flagDetectionEdge and loopbackLatch2 = '1' and alignmentReady = '1') then								
					sendLoopbackOut <= '1';		  						
				end if;					
			
			end if;  
			
			
		end if;
	end process;	 	  
	
	--=======================
	--=======================			
	main: process( EPCS_TXCLK, TX_CLK_STABLE ) 
		
		variable respPacketType : unsigned(3 downto 0);
	begin						 
		--(0.1) Transmission Clock Stability Check
		if TX_CLK_STABLE = '0' then	  
			state			<= S_TxClkLoss;
			status 			<= (others => '1');  --indicate ALIGN problem   
			tx_k_char_sig 	<= (others => '1');  				 
			txDataSel 		<= (others => '0');	 -- Send Alignment "BC3C"
		----------------------------------------------------------------------
		--(1) ALIGNED XCVR DONE
		elsif rising_edge(EPCS_TXCLK) then	
			retransmit_we_packet_sender_state		<= '0';
			pausePacketTransmission	<= '0';
			respFifoRe_mask		 	<= '0';								
			status(14) 				<= enable;		
			status(15) 				<= rst_cmd;	 
			RETRANSMIT_RAM_RE       <= '0';						  
			
			fwdFifoRe_mask <= '0';	   	
			respFifoRe_mask <= '0';				
			crc_en_sig <= '0';				 
			CRC_RST <= '0';
			tx_k_char_sig 	<= (others => '1');  	
			if(	tx_k_char_sig /= "11") then
				kchar_count <= kchar_count + 1;
			end if;		
			
			if( tx_data_sig /= x"BC3C") then
				kdata_count <= kdata_count + 1;
			end if;
			
			
			txDataSel <= (others => '0');	
			
			fwd_fifo_latch <= FWD_FIFO_Q;  	   	
			resp_tx_data <= resp_fifo_q_latch3;    				
			
			if(state /= S_Idle) then
				shRxReg <= shRxReg(SH_RX_REG_DEPTH-2 downto 0) & dbg_data_sig;  	 
			end if;
			
			RESP_FIFO_RESET			<= '0';
			if RESET_N = '0' or rst_cmd = '1' or status(15) = '1' then 
				one_bit_sig				<= '0';							  
				RESP_FIFO_RESET			<= '1';
				nextIsPayload			<= '0';
				dcsResp_DoubleOp		<= '0';
				dcsResp_BlockOp			<= '0';
				respDataPacketCnt		<= (others => '0');
				state				 	<= S_Reset;	   
				status 					<= (others => '0');
				errors 					<= (others => '0');	  
				CRC_RST 				<= '1';	   						    		 			
				fwd_packet_count 		<= (others => '0');	   
				rsp_packet_count 		<= (others => '0');	 
				rsp_packet_for_retransmit <= (others => '0');
				kchar_count 			<= (others => '0');		
				kdata_count 			<= (others => '0');
				respDataPacketCnt_latch	<= (others => '0');		 
				--rsp_packet_for_retransmit_latch  <= (others => '0');	 
				flag_reset 				<= '0';	
				
				nextIsPayload_save		<= '0';
				
			elsif(force_reset = '1') then 
				state <= S_Reset; --can setup debug to mode DbgDataSel = 2 and view what was drained out of resp fifo
			elsif(sendLoopbackOut = '1') then  	
				respFifoRe_mask			<= respFifoRe_maskSave;
				pausePacketTransmission <= '0';
				txDataSel				<= 	TXDATASEL_MARKER;
				markerType				<=  x"1C12";
			elsif(sendLoopbackOut = '0') then		--If we are sending loopback, stop the state machine	  
				
				--(1)
				if(state = S_Reset) then		  
				-- error occurred ... drain everything out of resp fifo
					RESP_FIFO_RESET				<= '1';
					errors(ERROR_HasReset)		<= '1';				
					state 						<= S_Idle; 		
					txDataSel					<= TXDATASEL_MARKER;  
					markerType					<= x"1C13";	  	 
					
					retransmit_word_count		<= (others => '0');	 
									
				elsif (state = S_Idle) then
					
					
					-- Handling the retransmission request after a reset: when rsp_packet_for_retransmit is not increasing but changes from N to 0, 
					-- that is a reset on Packet Sender, retransmission_packet_req must be 0. This statement verify the reset condition	
					if(rsp_packet_for_retransmit /= (rsp_packet_for_retransmit_latch+1) and rsp_packet_for_retransmit_latch > 0) then 	
						                                                                   -- This condition is necessary to avoid errors in the retransmission  
																							--during the FABRIC RESET. It allows to select only the manual reset 
							flag_reset <= '1';
							
					end if;
					
					if (rsp_packet_count > "1") then   
						flag_reset <= '0';
					end if;
							
						CRC_RST <= '1';					
						
						if(enable = '1') then					
							
							if(retransmit_det_sig = '1') then			 -- retransmission request
								
								state			<= S_WaitForRetransmitData;
								sendCnt <= to_unsigned(1,5);
								retransmitCnt <= (others => '1');		
								RETRANSMIT_RAM_RE  	<= '0';	 			
								
							elsif(FWD_FIFO_EMPTY = '0') then		  	-- forward a packet		
								
								state		 	<= S_Fwd;			   
								fwdFifoRe_mask 	<= '1';		  
								sendCnt <= (others => '0');		  		   	   
								fwd_packet_count <= fwd_packet_count + 1;	  
								
							elsif(resp_fifo_empty_latch = '0' and 		 -- packet to send		
								
								unsigned(resp_fifo_count_latch2) > 7) then	-- was 4 	
								state			<= S_WaitForRespData;			  
								sendCnt <= to_unsigned(1,5); -- was 20, 5);	 
								rsp_packet_count <= rsp_packet_count + 1;
								rsp_packet_for_retransmit <= rsp_packet_for_retransmit +1; 
								rsp_packet_for_retransmit_latch <= rsp_packet_for_retransmit;
								
							elsif(force_send = '1') then				 -- debug force packet
								
								state			<= S_Dbg;			   
								sendCnt <= (others => '0');	
								
							end if;
						end if;
						
						status(7 downto 0) <= x"01";		
					elsif (state = S_Dbg) then	 	   -- handle debug packet generation
						
						sendCnt <= sendCnt + 1;				   	  
						crc_en_sig <= '1';
												 			  		  
						txDataSel <= TXDATASEL_CRC; --output CRC data
						tx_k_char_sig <= (others => '0'); --data chars						   			   
						
						if(sendCnt = 10) then -- first word, do funny KCHAR		
							state <= S_Pause; 																				 
							status(13) <= '1'; --indicate a fwd was sent ever	
						end if;	
						
						status(9) <= '1'; --indicate a dbg was sent ever   	   
						status(7 downto 0) <= x"04"; 										 
						
					elsif (state = S_Resp) then			-- handle sending packet from response FIFO
						
						sendCnt <= sendCnt + 1;	
						--============================== 
						--control resp fifo RE
						if(sendCnt = 0) then		
							--retransmit_word_count	<= (others => '0');
							nextIsPayload_save <= nextIsPayload;							 							   
							respFifoRe_mask <= '1';			 
						elsif(sendCnt = 1) then   
							if(nextIsPayload_save = '1') then -- Data Packet Payload							 							   
								respFifoRe_mask <= '1';			 
							end if;		 
							--else skip read for non-dataPayload packets
						elsif(sendCnt = 2) then   	 
							-- Third time, do nothing wait for extra data read delay clock	   
							respFifoRe_mask <= '1';
						else --body   	
							
							  if (nextIsPayload_save = '0') then
								if(sendCnt < 8) then --skip readout for CRC
									respFifoRe_mask <= '1';	
								end if;						
							  elsif (nextIsPayload_save = '1') then
								 if(sendCnt < 8) then --skip readout for CRC
									respFifoRe_mask <= '1';	
								end if;	 
							  end if;			
							
						end if; -- end resp fifo RE handling
								   
						--============================== 
						--control tx data	
						--	This is 2 clocks behind read steps above
						if (sendCnt = 0) then
							-- First time, do nothing wait for extra read enable delay clock  	  	
						elsif (sendCnt = 1) then				 
							-- Second time, do nothing wait for extra data read delay clock		
						elsif (sendCnt = 2) then				 
							-- Third time, do nothing wait for extra data read delay clock					
						elsif(sendCnt = 3) then 													
							-- Fourth time, do nothing wait for extra data read delay clock			
						elsif(sendCnt = 4) then	--first word, do funny KCHAR while FIFO data waits	 
							 								 							
							resp_tx_data(15 downto 8) <= x"1C";  --K28.0
							resp_tx_data(7 downto 5) <= std_logic_vector(rsp_packet_count(2 downto 0));	
							resp_tx_data(4) <= '0';	  -- really, this is the high bit of the packet type.. but we have < 16 (for now)
							
							hdr_hdr_word <= resp_fifo_q_latch2;		  
							
							--if nextIsPayload = '1' then	
--								resp_tx_data(7 downto 4)	<= "0111";	  
--								respDataPacketCnt			<= respDataPacketCnt - 1;
--							end if;
 							respPacketType := unsigned(resp_fifo_q_latch2(7 downto 4));		
							
							
							-- note, when responding, there is no packetType in FIFO, so ignore respPacketType
							if(nextIsPayload_save = '1' and respDataPacketCnt > 0) then -- Data Packet
								--decrement packet count 
								txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx	
								tx_k_char_sig(1) <= '0';	-- was (0),.. but Rick gets bytes flipped	
            	
								respDataPacketCnt <= respDataPacketCnt - 1;	 
								
								if (respPacketTypeSave = 4 or respPacketTypeSave = 8) then
									respPacketTypeSave <= x"8";	--DCS Block read response type	 
									resp_tx_data(3 downto 0) <= x"8";		  		
									respPacketType_check	<= x"8";
								else
									respPacketTypeSave <= x"6";	--Data response body 
									resp_tx_data(3 downto 0) <= x"6";	
								end if;
							
							elsif(respPacketType = 4 and nextIsPayload_save = '0') then -- DCS Reply Packet
								txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx		   
								tx_k_char_sig(1) <= '0';	-- was (0),.. but Rick gets bytes flipped						 
							 	resp_tx_data(3 downto 0) <= x"4";	
								 
								respPacketTypeSave <= respPacketType;	
									
							elsif(respPacketType = 5 and nextIsPayload = '0') then -- Data Header Packet				   
								txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx		   
								tx_k_char_sig(1) <= '0';	-- was (0),.. but Rick gets bytes flipped						 
							 	resp_tx_data(3 downto 0) <= x"5";			  
												
								
								respPacketTypeSave <= respPacketType;	   
								
							else					--invalid resp packet type, cancel send!
								errors(0)	 	<= '1'; 					  
								state 			<= S_Reset; 													  
								nextIsPayload 	<= '0';	  
								
								respPacketTypeSave <= x"F";		
								
							end if;		 			
						else  --body   											  						   
							txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx														 
							tx_k_char_sig <= (others => '0'); --data chars	 					  
							crc_en_sig <= '1';					
							
							
							-- NOTE: the data packet case should be lowest priority of if-else because nextIsPayload is high during Data Header Packet
							if(nextIsPayload_save = '1') then --Data Packet	 	
								one_bit_sig	<= '1';
							elsif(respPacketTypeSave = 4) then -- DCS Reply Header Packet	   					   		 							
								if(sendCnt = 5) then -- DMA Byte Count		
									resp_tx_data <= (others => '0');	
								elsif(sendCnt = 6) then --header word	
									resp_tx_data <= hdr_hdr_word;		
								elsif (sendCnt = 7) then -- PacketCount and Opcode	
									if (nextIsPayload_save = '0') then
										respDataPacketCnt	<= to_unsigned(0,6) & unsigned(resp_fifo_q_latch3(15 downto 6));
										dcsResp_BlockOp		<= resp_fifo_q_latch3(1);   
										dcsResp_DoubleOp	<= std_logic(resp_fifo_q_latch3(2));	 
									end if;	
								elsif (sendCnt = 8) then   --Op 1 Address
									if ( dcsResp_BlockOp = '1' and respDataPacketCnt /= 0) then	  
										nextIsPayload	<= '1';		 
									else  					   	
										nextIsPayload	<= '0';
									end if;			   
								elsif (sendCnt = 9)	then	--Op 1 Data
								elsif (sendCnt = 10) then	--Op 2 Address	 
									
									if(dcsResp_blockOp = '0' and dcsResp_doubleOp = '0') then	
										resp_tx_data <= (others => '0');
									end if;
								elsif (sendCnt = 11)	then	   --Op 2 Data	  
									if(dcsResp_blockOp = '0' and dcsResp_doubleOp = '0') then
										resp_tx_data <= (others => '0');
									end if;
								elsif(sendCnt = 12) then   --Block Op 3		
									if(dcsResp_blockOp = '0') then
										resp_tx_data <= (others => '0');
									end if;		
									state <= S_Crc; 		-- last word is CRC								
								end if;	
								
								
							elsif(respPacketTypeSave = 5) then -- Data Header Packet	 
												 			 							
								if(sendCnt = 5) then -- data doesnt matter for DMA byte count field		
									resp_tx_data <= (others => '0');
								elsif(sendCnt = 6) then 										
								elsif(sendCnt = 7) then -- Packet Count alleviate timing	
									respDataPacketCnt_latch <= unsigned(resp_fifo_q_latch3);				
								elsif(sendCnt = 8) then 			
								elsif(sendCnt = 9) then 	  
									if (respDataPacketCnt_latch > 0) then
										respDataPacketCnt <= respDataPacketCnt_latch; 
										nextIsPayload <= '1'; 
									else   
										respDataPacketCnt <= (others => '0'); 
										nextIsPayload 	  <= '0';
									end if;
								elsif(sendCnt = 10 and resp_fifo_q_latch(3 downto 0) = x"2") then 	-- if invalid status, no more responding	
									nextIsPayload <= '0';
									respDataPacketCnt <= (others => '0');											  
								elsif(sendCnt = 11) then 								
								end if;		  
									 							
							end if;	  		  
							
							if(sendCnt = 12) then -- last word is CRC 	 
								state <= S_Crc; 										
							end if;
							  				
						end if;					  
						
						
						--Retransmit RAM Storage----Enabling Write Signal-----
						if(sendCnt > 3) then	 	 			   
							retransmit_we_packet_sender_state		<= '1';	
							
						end if;
						status(7 downto 0) <= x"05"; 								  									   
					elsif (state = S_Fwd) then	 
						sendCnt <= sendCnt + 1;					  		
						txDataSel <= TXDATASEL_FWDFIFO;  --select FWD_FIFO for tx
												 
						if(sendCnt < 8) then	
							fwdFifoRe_mask <= '1';    
						end if;
								 	   
						if(sendCnt = 0) then -- first word, do funny KCHAR		
							tx_k_char_sig(1) <= '0';	-- was (0),.. but Rick gets bytes flipped	  
						else																						 
							tx_k_char_sig <= (others => '0'); --data chars				 					  
							crc_en_sig <= '1';
						end if;    
											   
						if(sendCnt = 8) then -- last word is CRC	
							state <= S_Crc; 	
						end if;			
																																 
						status(8) <= '1'; --indicate a fwd was sent ever
									 								  
						status(7 downto 0) <= x"02"; 	 																				   
					elsif (state = S_Crc) then	 	 
						txDataSel <= TXDATASEL_CRC; -- swap CRC into tx											 
						tx_k_char_sig <= (others => '0'); --data chars 
						
											  	 
						if(disable_loop = '1') then
							state <= S_Pause; 		 
							status(13) <= '1'; --indicate a crc was sent ever 	
						else
							state <= S_OneExtra;	
							status(12) <= '1'; --indicate a crc was sent ever 		
						end if;				
										 
						if(respDataPacketCnt = 0) then	  		  
							nextIsPayload <= '0';	
						end if;
							
						status(7 downto 0) <= x"07"; 	
					elsif (state = S_OneExtra) then	  		--CRC gets put into txdata
						state <= S_Idle;					
					elsif (state = S_Pause) then	 			  
						status(7 downto 0) <= x"AA"; 	
					elsif (state = S_WaitForRespData) then	 
						sendCnt	<= sendCnt - 1;
						if (sendCnt = 0) then		 	  
							sendCnt	<= (others => '0');
							state	<= S_Resp; 
							respFifoRe_mask <= not nextIsPayload;	--grab header from Q for data header, but not for payload
						end if;																								 
						
					elsif (state = S_WaitForRetransmitData) then	
						retransmitCnt <= retransmitCnt - 1;

						if (retransmitCnt = 100)then
							retransmit_packet_req_unsigned <= unsigned(retransmit_packet_req) + 1; 
							if (flag_reset = '1') then	   -- If PS had a reset, the retransmission starts from address 1
								retransmit_packet_req_unsigned <= "001";		
								flag_reset <= '0';
							end if;	
						end if;
						
						if (retransmitCnt = 20) then
							retransmitCnt	<= (others => '0');
							state	<= S_packetRetransmit;  				
							retransmit_read_count <= (others => '0');
						end if;						
							
					elsif (state = S_packetRetransmit) then
						retransmitCnt <= retransmitCnt + 1;	
					
						if (retransmitCnt > 1) then 						 
								 retransmit_read_count <= retransmit_read_count + 1;
							if (retransmit_packet_req_unsigned /= rsp_packet_for_retransmit) then	--Choose Packet		  
							   
							   	   
								if (retransmit_read_count  < 12) then		   --Send packet of 10 words 
									
									RETRANSMIT_RAM_RADDR   <= std_logic_vector(retransmit_packet_req_unsigned) & std_logic_vector(retransmit_read_count);
									if (retransmit_read_count > 1) then
										txDataSel <= TXDATASEL_RETRANSMIT;
										retransmit_data_signal <= RETRANSMIT_DOUT_FROM_RAM;
									end if;
									
									
								elsif (retransmit_read_count = 12) then
									state <= S_postRetransmit;	
									retransmitCnt <= (others => '1');
								end if;	 
								
								
							elsif (retransmit_packet_req_unsigned = rsp_packet_for_retransmit) then 
								retransmit_read_count <= retransmit_read_count + 1;
									
								if (retransmit_read_count  < 12) then		   --Send packet of 10 words 
			
									RETRANSMIT_RAM_RADDR   <= std_logic_vector(retransmit_packet_req_unsigned) & std_logic_vector(retransmit_read_count);	  
									if (retransmit_read_count > 1)then
										txDataSel <= TXDATASEL_RETRANSMIT;
										retransmit_data_signal <= RETRANSMIT_DOUT_FROM_RAM;
									end if;   
									
								elsif (retransmit_read_count = 12) then
									state <= S_doneRetransmit;
									retransmitCnt <= (others => '1');
									
								end if;	  
								
							end if;								
						end if;		

					elsif (state <= S_postRetransmit) then
						retransmitCnt <= retransmitCnt - 1;	 
						if (retransmitCnt = 100)then
							retransmit_packet_req_unsigned <= retransmit_packet_req_unsigned + 1;  
						end if;
						
						if (retransmitCnt = 20) then
							state <= S_packetRetransmit;
							retransmitCnt	<= (others => '0');	
						end if;
						
					elsif (state <= S_doneRetransmit) then
						  retransmitCnt <= retransmitCnt - 1;	 
						
						if (retransmitCnt = 20) then
							state <= S_Idle;
							retransmitCnt	<= (others => '0');
							retransmit_packet_req_unsigned <= (others => '0');
						end if;
						
					end if;	
					
			end if;			  
		end if;			
	end process;
	
	--=======================
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
					disable_loop <= '0';   
					force_send <= '0';	
					enable <= '1';	  
					force_reset <= '0';
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
								enable <= wData(4);
							elsif wAddr = 2 then
								--disable_loop <= wData(0);	  
							elsif wAddr = 4 then
								force_send <= wData(0);	
							elsif wAddr = 5 then
								dbgDataSel <= unsigned(wData(1 downto 0));	  
							elsif wAddr = 6 then
								force_reset <= wData(0);	
                            elsif wAddr = 7 then
                                dummy_reg(ALGO_WDATA_WIDTH-1 downto 0) <= wData;
							end if;											  
							
						end if;	
						
						
						--Reads				
						algo_rdata_sig <= (others => '0');		  
						if (rAddr = 0) then			  		
							algo_rdata_sig <= status;
						elsif (rAddr = 1) then			  		
							algo_rdata_sig <= errors;	 						
						elsif (rAddr > 4 and rAddr < 20) then --read data buffer
							algo_rdata_sig <= shRxReg(to_integer(rAddr)-5);		   				
						elsif (rAddr = 20) then			  		
							algo_rdata_sig <= std_logic_vector(fwd_packet_count);	 		 
						elsif (rAddr = 21) then			  		
							algo_rdata_sig <= std_logic_vector(rsp_packet_count);			 
						elsif (rAddr = 22) then			  		
							algo_rdata_sig(NORMAL_FIFO_ADDR_SIZE downto 0) <= resp_fifo_count_latch2;		  		 
						elsif (rAddr = 23) then			  		
							algo_rdata_sig(3 downto 0) <= std_logic_vector(respPacketType);	
							algo_rdata_sig(7 downto 4) <= std_logic_vector(debug_tx_clock_alive);
						elsif (rAddr = 24) then			  		
							algo_rdata_sig <= std_logic_vector(kchar_count);			   
						elsif (rAddr = 25) then			  		
							algo_rdata_sig <= std_logic_vector(kdata_count);
                        elsif (rAddr = 26) then
                            algo_rdata_sig <= dummy_reg;
						else						
							algo_rdata_sig <= std_logic_vector(rAddr) & std_logic_vector(to_unsigned(ALGO_LOC_ADDR, gAPB_DWIDTH-ALGO_RADDR_WIDTH));
						end if;
						
					end if;	  
				end if;	   				
			end if;			
		end process;
	end generate;
	
end arch;

