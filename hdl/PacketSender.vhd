--------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: PacketSender.vhd
-- File history:
--      v00: Feb 25,  2015: Birthday	   
--      v01: June 10, 2020:  MT  labelled state->ps_state and status->ps_status
--      v02: July 8,  2020:  MT  cleaned logic and unused signals. Fixed CRC word in data to RETRANSMISSSION RAM.
--      v02: July 17, 2020:  MT  cleaned retransmission logic and unused signals. Made retransmission protocol faster.
--      v03: Aug  13, 2020:  MT  added BUSY_STOP to signal uProc that logic is tending DTC request 
--      v04: Aug  23, 2020:  MT  made module RD/WR registers more uniform accross all modules
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
            EPCS_TXCLK              : in std_logic;            
            ALGO_CLK              	: in std_logic;
            RESET_N                 : in std_logic;	 
				                        	
				-- RocMonitor Interface						
				ALGO_RESET					: in std_logic;
				ALGO_ADDR 					: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	 	  
				ALGO_WDATA					: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	
				ALGO_RDATA					: inout std_logic_vector(gAPB_DWIDTH-1 downto 0);	   										   
														
				-- CRC Interface			 
            CRC_RST       	   	   : out std_logic;	  
            CRC_EN       	   		: out std_logic;	 
            CRC_OUT     	   		: in std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
            CRC_IN    	   			: out std_logic_vector(gENDEC_DWIDTH-1 downto 0);
				                        	
				-- 8b10b CorePCS Interface					  									
            TX_CLK_STABLE          	: IN std_logic;	   
            TX_DATA     	   		: OUT std_logic_vector(gENDEC_DWIDTH-1 downto 0);	
            TX_K_CHAR     	   		: OUT std_logic_vector(IO_SIZE-1 downto 0);			
            FORCE_DISP     	   	: OUT std_logic_vector(IO_SIZE-1 downto 0);			
            DISP_SEL     	   		: OUT std_logic_vector(IO_SIZE-1 downto 0);	 
				                        	
				-- ResponseFifo Interface
            RESP_FIFO_Q 				: in std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				RESP_FIFO_RE 				: out std_logic;
				RESP_FIFO_RESET			: out std_logic;
				RESP_FIFO_EMPTY 			: in std_logic;
				RESP_FIFO_COUNT			: in std_logic_vector(NORMAL_FIFO_ADDR_SIZE downto 0);
				                        	
				-- ForwardFifo Interface	
            FWD_FIFO_Q 					: in std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				FWD_FIFO_RE 				: out std_logic;	
				FWD_FIFO_EMPTY 			: in std_logic; 
				
				-- Retransmission RAM											
				RETRANSMIT_DETECTED		: in std_logic;
				RETRANSMIT_SEQUENCE_REQ	: in std_logic_vector(2 downto 0); 
				
				RETRANSMIT_RAM_RE			: out std_logic;		  
				RETRANSMIT_RAM_RADDR		: out std_logic_vector(6 downto 0);	 

				RETRANSMIT_RAM_WADDR		: out std_logic_vector(6 downto 0);
				RETRANSMIT_RAM_WE			: out std_logic;		   
				RETRANSMIT_DOUT_TO_RAM	: out std_logic_vector(15 downto 0);
            RETRANSMIT_DOUT_FROM_RAM: in std_logic_vector(15 downto 0);
            
            ----  MT addded
            BUSY_STOP               : out STD_LOGIC
        );                              	
end PacketSender;                       	
                                        	                                                           
                                        	
architecture arch of PacketSender is    	       
				      	                	
	--=======================           	
	--standard RocMonitor interface temp late	
	signal rst_cmd							: std_logic := '0';		 												
	signal enable							: std_logic := '0';		 
	                                    	
	signal ps_status						: std_logic_vector(gAPB_DWIDTH-1 downto 0);		 
		-- reset_ bit def: 
         ----  all 0s at reset
         ----  all 1s when no XCVR lock
			-- 7:0 state as per list below	            	
			-- 8 indicate a fwd was sent ever
			-- 9 indicate a dbg was sent ever
            -- 12 indicate a crc was sent ever
			-- 14 enable                	
			-- 15 rst	
            
	signal ps_errors							: std_logic_vector(gAPB_DWIDTH-1 downto 0);		
	constant ERROR_HasReset 				: natural := 0;				
	constant ERROR_WrongPacketOut			: natural := 1;
					     	
	--=======================
	--main signals	  		--| Equivalent Status (3 downto 0)
	type state_t is (		--------------------------------- 
		S_Pause,	   		      --| Status: (0xAA) 
		S_OneExtra,			      --| Status: 7  
		S_Crc,				      --| Status: 6                                       
		S_Dbg,				      --| Status: (0xDD)  
		S_WaitToRetransmitData, --| Status: 0x10
		S_packetRetransmit,	   --| Status: 0x11
		S_postRetransmit,       --| Status: 0x12
		S_doneRetransmit,       --| Status: 0x13
		S_Resp,				      --| Status: 5                     
		S_Fwd,				      --| Status: 4                     
		S_Start,			         --| Unused                   	                              
		S_WaitForRespData,	   --| Status: 3 
		S_Idle,				      --| Status: 2 
		S_Reset,			         --| Status: 1 				  
		S_TxClkLoss			      --| Status: 0xFFFF
		); 	  					 
	signal ps_state : state_t := S_Idle;				 
	
	---====================
	
	signal sendCnt							: unsigned(4 downto 0);	   
	signal fwdFifoRe_mask				: std_logic;		     
	signal respFifoRe_mask				: std_logic;		  
	signal respFifoRe_maskSave			: std_logic;   

	signal txDataSel						: unsigned(2 downto 0) ;   	
	constant TXDATASEL_FWDFIFO			: unsigned := "001";
	constant TXDATASEL_RSPFIFO			: unsigned := "010";
	constant TXDATASEL_CRC				: unsigned := "011";
	constant TXDATASEL_MARKER			: unsigned := "100";
	constant TXDATASEL_RETRANSMIT		: unsigned := "101";
	
	signal dbgDataSel						: unsigned(1 downto 0) ;
																							  
	signal tx_data_sig, tx_data_sig2 : std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal dbg_data_sig     	   	: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal fwd_fifo_latch  	   		: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal resp_tx_data     			: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	  
	signal hdr_word     				   : std_logic_vector(gENDEC_DWIDTH-1 downto 0);	 	
													 
	constant SH_RX_REG_DEPTH 			: natural := 15;											 	  								   
	type shRxReg_t is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	signal shRxReg 						: shRxReg_t(SH_RX_REG_DEPTH-1 downto 0);	
																   								 
	signal force_send						: std_logic;	 	
	signal force_reset					: std_logic;	 		  	
																 
	signal tx_k_char_sig     	   	: std_logic_vector(IO_SIZE-1 downto 0) := (others => '1');  	
	signal fwd_packet_count    		: unsigned(gENDEC_DWIDTH-1 downto 0);		  
	signal rsp_packet_count    		: unsigned(gENDEC_DWIDTH-1 downto 0);		  
	signal kchar_count    				: unsigned(gENDEC_DWIDTH-1 downto 0); --count anytime TX_K_CHAR is not "11"	
	signal kdata_count    				: unsigned(gENDEC_DWIDTH-1 downto 0); --count anytime TX_DATA is not "BC3C"		  
    signal rsp_packet_seq           : unsigned(2 downto 0);
	                                    	
	signal respPacketType    			: unsigned(3 downto 0);		-- packet type
	signal respPacketTypeSave    		: unsigned(3 downto 0);			  		  
	signal respDataPacketCnt    		: unsigned(15 downto 0);    -- number of packets in Block DCS reply or Data Payload			  		  
	signal respDataPacketCnt_save    : unsigned(15 downto 0);    -- number of packets from Data Header 
	signal nextIsPayload					: std_logic;				-- mask high after Block DCS reply or Data Header   			
	signal nextIsPayload_save			: std_logic;
	
	--Domain Transfer
	signal stepTXCLKin40					: unsigned (4 downto 0);
	signal LoopbackLatch					: std_logic; 
	signal LoopbackLatch2				: std_logic; 
	signal LoopbackLatch3				: std_logic;	
	signal returnMarker					: std_logic;
	signal sendLoopbackOut				: std_logic;   
	
	signal dcsResp_BlockOp				: std_logic;			
	signal dcsResp_DoubleOp				: std_logic;
	
	signal needAlignmentCnt				: unsigned(2 downto 0);  
	signal alignmentReady				: std_logic;
	signal alignment_req_latch			: std_logic;
	signal alignment_req_latch2		: std_logic;
	signal alignment_req_risingEdge	: std_logic;
	
	signal resp_fifo_empty_latch		: std_logic;									 
	signal resp_fifo_count_latch		: std_logic_vector(NORMAL_FIFO_ADDR_SIZE downto 0);
	signal resp_fifo_count_latch2		: std_logic_vector(NORMAL_FIFO_ADDR_SIZE downto 0);
	signal resp_fifo_q_latch			: std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	signal resp_fifo_q_latch2			: std_logic_vector(gENDEC_DWIDTH-1 downto 0); 	
	signal resp_fifo_q_latch3			: std_logic_vector(gENDEC_DWIDTH-1 downto 0);
	
	signal tx_data_latch					: std_logic_vector(15 downto 0);
	signal tx_k_char_latch           : std_logic_vector(1 downto 0);			 
	signal tx_k_char_latch2          : std_logic_vector(1 downto 0);			 
	signal clk40_genlatch				: std_logic;
	signal clk40_genlatch2				: std_logic;
	signal flagDetectionEdge			: unsigned (4 downto 0); -- TX_CLK cycles. Range: 1 to NUM_OF_TCLK_IN_40-1. CANT BE 0	
	
	signal L_markerOffsetPlusTwo		: unsigned (20 downto 0);  
	signal L_markerOffsetPlusOne 		: unsigned (20 downto 0);	
	signal L_markerOffsetCenter	   : unsigned (20 downto 0);  	 
	signal L_markerOffsetMinusOne		: unsigned (20 downto 0);	  
	signal L_markerOffsetMinusTwo		: unsigned (20 downto 0); 
	signal markerType						: std_logic_vector(15 downto 0);
	
	signal retransmit_det_sig			: std_logic;  
	signal retransmit_packet_req		: std_logic_vector(2 downto 0);   
	signal retransmit_word_count		: unsigned(3 downto 0);  
	signal retransmit_packet_seQ     : unsigned(2 downto 0);	
	signal retransmit_read_count		: unsigned(3 downto 0);	 
	signal retransmitCnt					: unsigned(3 downto 0);	 
	signal retransmit_data_signal 	: std_logic_vector(15 downto 0);
	signal retransmit_txdata_reg 		: std_logic_vector(15 downto 0); 
	
	signal retransmit_we             : std_logic;
	signal retransmit_we_latch1      : std_logic;	
	signal retransmit_we_latch2      : std_logic;	
	signal retransmit_we_sig 		   : std_logic;					
	
	signal crc_en_sig, crc_en_sig2 	: std_logic;	
	signal crc_to_tx, crc_to_tx2		: std_logic;
   
begin
															   												
   FWD_FIFO_RE <= (not FWD_FIFO_EMPTY) and fwdFifoRe_mask;	  

   FORCE_DISP 	<= (others => '0');		   
   DISP_SEL 	<= (others => '0');	  	
 
			   
   dbg_data_sig	<=  (std_logic_vector(kchar_count(7 downto 0)) &  tx_data_sig(7 downto 0)) when dbgDataSel = 1--(fwdFifoRe_mask & fwd_fifo_latch(10 downto 0) & ps_status(3 downto 0)) 			when dbgDataSel = 1 
            else    (respFifoRe_mask & nextIsPayload & resp_tx_data(13 downto 0)) 		      when dbgDataSel = 2 
            else     retransmit_data_signal                                                  when dbgDataSel = 3  
            else    (std_logic_vector(txDataSel(1 downto 0)) & tx_k_char_sig & tx_data_sig(11 downto 0));	   -- while idle send K 28.5 & 28.1   

    
   timingAlleviation: process (EPCS_TXCLK)	 	 	
   begin		
      if (rising_edge (EPCS_TXCLK)) then	 
			
         if (sendLoopbackOut = '0') then
            resp_fifo_q_latch 		<= RESP_FIFO_Q;	  
            resp_fifo_q_latch2		<= resp_fifo_q_latch;
            resp_fifo_q_latch3		<= resp_fifo_q_latch2; 
            resp_fifo_count_latch	<= RESP_FIFO_COUNT;
            resp_fifo_count_latch2	<= resp_fifo_count_latch;
            resp_fifo_empty_latch 	<= RESP_FIFO_EMPTY;
            RESP_FIFO_RE            <= (not resp_fifo_empty_latch) and respFifoRe_mask;	   
         else
            RESP_FIFO_RE	<= '0';
         end if;
			
         TXDATA: case txDataSel is
            when TXDATASEL_FWDFIFO => 
               tx_data_sig <= fwd_fifo_latch(7 downto 0) & fwd_fifo_latch(15 downto 8);
            when TXDATASEL_RSPFIFO => 
               tx_data_sig <= resp_tx_data(7 downto 0) & resp_tx_data(15 downto 8);
            when TXDATASEL_MARKER => 
               tx_data_sig <= markerType(7 downto 0) & markerType(15 downto 8); 
            when TXDATASEL_RETRANSMIT=>
               tx_data_sig <= retransmit_data_signal;
            when others	=> 
               tx_data_sig <= x"3CBC";	  -- the DTC receives BC3C (byte-flipped)
         end case;
         
         tx_data_sig2      <= tx_data_sig;

         tx_k_char_latch   <= tx_k_char_sig;  
         tx_k_char_latch2  <= tx_k_char_latch;
         TX_K_CHAR         <= tx_k_char_latch2;	   
			
         --give one extra clock for CRC calc before going to tx data
         if (txDataSel = TXDATASEL_CRC) then		
            crc_to_tx <= '1';
         else
            crc_to_tx <= '0';		   
         end if;
			
         crc_to_tx2     <= crc_to_tx;
         if(crc_to_tx2 = '1') then   
            TX_DATA <= CRC_OUT(7 downto 0) & CRC_OUT(15 downto 8);	 
         else
            TX_DATA	<= tx_data_sig2;
         end if;	
			
         CRC_IN     <= tx_data_sig(7 downto 0) & tx_data_sig(15 downto 8); 				

         ---CRC EN Delay---		 
         crc_en_sig2<= crc_en_sig;
         CRC_EN     <= crc_en_sig2; 

         
         ----RAM WE delay and strech to cover CRC word ----
         retransmit_we_latch1 <= retransmit_we;
         retransmit_we_latch2 <= retransmit_we_latch1; 
			
         retransmit_we_sig <= '0';
         if(retransmit_we_latch1 = '1' or retransmit_we_latch2 = '1') then --extra clock to get CRC
            retransmit_we_sig <= '1';
         end if;

         retransmit_word_count	<= (others => '0');	
         
         ------Storage to RAM-----------		  
         RETRANSMIT_RAM_RE       <= '0';						  
         RETRANSMIT_RAM_WE <= '0';
         if (retransmit_we_sig = '1') then 
				
            retransmit_word_count	<= retransmit_word_count + 1;	
				
            if (retransmit_word_count < 11) then
               RETRANSMIT_RAM_WADDR	<= std_logic_vector(rsp_packet_seq) & std_logic_vector(retransmit_word_count); 

               if(crc_to_tx2 = '1') then   
                  RETRANSMIT_DOUT_TO_RAM <= CRC_OUT(7 downto 0) & CRC_OUT(15 downto 8);	 
               else
                  RETRANSMIT_DOUT_TO_RAM	<= tx_data_sig2;
               end if;
               RETRANSMIT_RAM_WE 		<= '1';
            end if;			
         end if;	 
			
			
         clk40_genlatch 	      <= CLK40_GEN; 
         clk40_genlatch2	      <= clk40_genlatch;	
			
         retransmit_det_sig	   <= RETRANSMIT_DETECTED;				 
         retransmit_packet_req   <= RETRANSMIT_SEQUENCE_REQ;		
		
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
         respFifoRe_maskSave		<= respFifoRe_mask;
			
         LoopbackLatch 				<= LOOPBACKMARKER;			--latch loopback	
         LoopbackLatch2				<= LoopbackLatch;	  
         LoopbackLatch3				<= LoopbackLatch2;
         sendLoopbackOut 			<= '0';				 
			
         alignment_req_latch		   <= ALIGNMENT_REQ;
         alignment_req_latch2		   <= alignment_req_latch;
         alignment_req_risingEdge   <= alignment_req_latch and not alignment_req_latch2;	
			
         -- create wrapping counter in TCLK representing 40	   
         if (stepTXCLKin40 = NUM_OF_TCLK_IN_40 - 1 or 
            (clk40_genlatch2 = '0' and clk40_genlatch = '1')) then
            stepTXCLKin40 			<= (others => '0');   
         else
            stepTXCLKin40 			<= stepTXCLKin40 + 1;
         end if;	 
			
         -------------------------------------------
         if(RESET_N = '0') then	--Reset signal	 
            flagDetectionEdge		   <= (others => '0');
            needAlignmentCnt		   <= (others => '0');
            alignmentReady			   <= '0';
            L_markerOffsetPlusTwo	<= (others => '0');
            L_markerOffsetPlusOne 	<= (others => '0');
            L_markerOffsetCenter	   <= (others => '0');
            L_markerOffsetMinusOne	<= (others => '0');
            L_markerOffsetMinusTwo	<= (others => '0');
				
         elsif (alignment_req_risingEdge = '1') then				--DCS Reset.
            alignmentReady			   <= '0';
            needAlignmentCnt		   <= (others => '0');						  
            L_markerOffsetPlusTwo	<= (others => '0');
            L_markerOffsetPlusOne 	<= (others => '0');
            L_markerOffsetCenter	   <= (others => '0');
            L_markerOffsetMinusOne	<= (others => '0');
            L_markerOffsetMinusTwo	<= (others => '0');

         else		
            --Normal Op	
            if  (LoopbackLatch2 = '1' and LoopbackLatch3 = '0' and needAlignmentCnt < 2) then 				--Loopback Alignment 	  
               needAlignmentCnt	<= needAlignmentCnt + 1;
            elsif (LoopbackLatch2 = '1' and LoopbackLatch3 = '0' and needAlignmentCnt = 2) then 			--Loopback Alignment
               if(stepTXCLKin40 > 1) then
                  flagDetectionEdge		<=  stepTXCLKin40 + 3 - 5;
               else
                  flagDetectionEdge		<=  stepTXCLKin40 + 3;
               end if;		 
               needAlignmentCnt	<= needAlignmentCnt + 1;	  
            elsif (LoopbackLatch2 = '1' and LoopbackLatch3 = '0' and needAlignmentCnt > 2) then
               alignmentReady	<= '1';
            end if;					
				
            if (LoopbackLatch2 = '1' and LoopbackLatch3 = '0' and alignmentReady = '1')	then
               if (stepTXClkin40 = flagDetectionEdge) then		
                  L_markerOffsetMinusTwo	<=	L_markerOffsetMinusTwo + 1;
               elsif (stepTXClkin40 = flagDetectionEdge + 1 or stepTXClkin40 = flagDetectionEdge + 1 - 5) 	then 
                  L_markerOffsetMinusOne	<=	L_markerOffsetMinusOne + 1;	
               elsif (stepTXClkin40 = flagDetectionEdge + 2 or stepTXClkin40 = flagDetectionEdge + 2 - 5) 	then
                  L_markerOffsetCenter 	<=	L_markerOffsetCenter + 1;	
               elsif (stepTXClkin40 = flagDetectionEdge - 1 or stepTXClkin40 = flagDetectionEdge - 1 + 5) 	then
                  L_markerOffsetPlusTwo	<= L_markerOffsetPlusTwo + 1;	
               elsif (stepTXClkin40 = flagDetectionEdge - 2 or stepTXClkin40 = flagDetectionEdge - 2 + 5) 	then	
                  L_markerOffsetPlusOne	<= L_markerOffsetPlusOne + 1;
                  if(stepTXCLKin40 > 1) then				   	--if there are 
                     flagDetectionEdge		<=  stepTXCLKin40 + 3 - 5;
                  else
                     flagDetectionEdge		<=  stepTXCLKin40 + 3;
                  end if;
               end if;	
            end if;
            
            ----Detection of Marker and Mode.
            if(stepTXCLKin40 = flagDetectionEdge and LoopbackLatch2 = '1' and alignmentReady = '1') then								
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
      
      --(0) Transmission Clock Stability Check
      if TX_CLK_STABLE = '0' then	  
         ps_state		<= S_TxClkLoss;
         ps_status 		<= (others => '1');  --indicate ALIGN problem   
         tx_k_char_sig 	<= (others => '1');  				 
         txDataSel 		<= (others => '0');	 -- Send Alignment "BC3C"
      ----------------------------------------------------------------------
      --(1) ALIGNED XCVR DONE
      elsif rising_edge(EPCS_TXCLK) then
      
         retransmit_we      <= '0';
         respFifoRe_mask    <= '0';								
         ps_status(14) 	    <= enable;		
         ps_status(15) 	    <= rst_cmd;	 
			
         fwdFifoRe_mask     <= '0';	   	
         respFifoRe_mask    <= '0';				
         crc_en_sig         <= '0';				 
         CRC_RST            <= '0';
         tx_k_char_sig 	    <= (others => '1');  
                    
         if( tx_k_char_sig /= "11") then
            kchar_count <= kchar_count + 1;
         end if;		
			
         if( tx_data_sig /= x"3CBC") then
            kdata_count <= kdata_count + 1;
         end if;
						
         txDataSel <= (others => '0');	
			
         fwd_fifo_latch <= FWD_FIFO_Q;  	   	
         resp_tx_data   <= resp_fifo_q_latch3;    				
			
         if(ps_state /= S_Idle) then
            shRxReg <= shRxReg(SH_RX_REG_DEPTH-2 downto 0) & dbg_data_sig;  
         end if;
         
         BUSY_STOP  <= '0';	
         
         RESP_FIFO_RESET	<= '0';
         
         if RESET_N = '0' or rst_cmd = '1' or ps_status(15) = '1' then 
            RESP_FIFO_RESET		   <= '1';
            nextIsPayload			   <= '0';
            nextIsPayload_save	   <= '0';
            dcsResp_DoubleOp		   <= '0';
            dcsResp_BlockOp		   <= '0';
            ps_state				      <= S_Reset;	   
            ps_status 				   <= (others => '0');
            ps_errors 				   <= (others => '0');	  
            CRC_RST 				      <= '1';	   						    		 			
            fwd_packet_count 		   <= (others => '0');	   
            rsp_packet_count 		   <= (others => '0');	 
            rsp_packet_seq          <= (others => '0');
            kchar_count 			   <= (others => '0');		
            kdata_count 			   <= (others => '0');
            respDataPacketCnt		   <= (others => '0');
            respDataPacketCnt_save	<= (others => '0');		
            retransmitCnt           <= (others => '0');		
            retransmit_packet_seq   <= (others => '0');
            retransmit_read_count   <= (others => '0');            
            
         elsif(force_reset = '1') then 
            ps_state <= S_Reset;            -- can setup debug to mode DbgDataSel = 2 and view what was drained out of resp fifo
            
         elsif(sendLoopbackOut = '1') then  	-- If we are sending loopback, stop the state machine
            respFifoRe_mask		<= respFifoRe_maskSave;
            txDataSel				<= TXDATASEL_MARKER;
            markerType				<= x"1C12";
            
         elsif(sendLoopbackOut = '0') then			  
				
            -- error occurred ... drain everything out of resp fifo
            if(ps_state = S_Reset) then		  
				
               RESP_FIFO_RESET				<= '1';
               ps_errors(ERROR_HasReset)  <= '1';				
               ps_state 					   <= S_Idle; 		
               txDataSel					   <= TXDATASEL_MARKER;  
               markerType					   <= x"1C13";	  	 
               ps_status(7 downto 0)      <= x"01";	
                  
            elsif (ps_state = S_Idle) then
					
               CRC_RST <= '1';					
						
               if(enable = '1') then					
							
                  if(retransmit_det_sig = '1' and rsp_packet_count > 0) then    -- retransmission request: ignore if not packet received yet
								
                     ps_state			<= S_WaitToRetransmitData;
                     retransmitCnt  <= (others => '0');		
								
                  elsif(FWD_FIFO_EMPTY = '0') then		  	-- forward a packet		
								
                     ps_state		 	   <= S_Fwd;			   
                     fwdFifoRe_mask 	<= '1';		  
                     fwd_packet_count  <= fwd_packet_count + 1;	  
                     sendCnt <= (others => '0');		  		   	   
								
                  elsif(resp_fifo_empty_latch = '0' and unsigned(resp_fifo_count_latch2) > 7) then	-- was 4
                     
                     ps_state			   <= S_WaitForRespData;			  
                     rsp_packet_count  <= rsp_packet_count + 1;
                     rsp_packet_seq    <= rsp_packet_seq + 1;
                     sendCnt <= to_unsigned(1,5); -- was 20, 5);	 
								
                  elsif(force_send = '1') then				 -- debug force packet
								
                     ps_state	<= S_Dbg;			   
                     sendCnt  <= (others => '0');	
								
                  end if;
               end if;
               ps_status(7 downto 0) <= x"02";	
                  
            elsif (ps_state = S_Dbg) then	 	   -- handle debug packet generation
						
               sendCnt     <= sendCnt + 1;				   	  
               crc_en_sig  <= '1';
												 			  		  
               txDataSel    <= TXDATASEL_CRC; --output CRC data
               tx_k_char_sig<= (others => '0'); --data chars						   			   
						
               ps_status(9) <= '1'; --indicate a dbg was sent ever   	   
               ps_status(7 downto 0) <= x"DD"; 										 
						
            elsif (ps_state = S_WaitForRespData) then -- stay here for 2 clocks
            
               sendCnt	<= sendCnt - 1;
               if (sendCnt = 0) then		 	  
                  sendCnt	      <= (others => '0');
                  ps_state	      <= S_Resp; 
                  respFifoRe_mask<= not nextIsPayload;	--grab header from Q for data header, but not for payload
               end if;																								 
               ps_status(7 downto 0)   <= x"03";
                        
            elsif (ps_state = S_Resp) then			-- handle sending packet from response FIFO
						
               sendCnt <= sendCnt + 1;	
               --============================== 
               -- logic to control resp fifo RE (whose default state is '0'!)
               if(sendCnt = 0) then		
                  nextIsPayload_save<= nextIsPayload;							 							   
                  respFifoRe_mask   <= '1';			 
               elsif(sendCnt = 1) then  -- skip read for non-dataPayload packets 
                  if(nextIsPayload_save = '1') then -- Data Packet Payload							 							   
                     respFifoRe_mask <= '1';			 
                  end if;		 
               elsif(sendCnt < 8) then   	 
                  respFifoRe_mask   <= '1';			 
               end if; -- end resp fifo RE handling
								   
               --============================== 
               -- logic to control TX data to XCVR
               --	This is 2 clocks behind read steps above
               if (sendCnt >= 0 and sendCnt <4) then         
                  -- do nothing wait for extra data read delay clock	
               elsif(sendCnt = 4) then	--first word, do funny KCHAR while FIFO data waits	 
							 								 							
                  resp_tx_data(15 downto 8)  <= x"1C";  --K28.0
--                  resp_tx_data(7 downto 5) <= std_logic_vector(rsp_packet_count(2 downto 0));	
                  resp_tx_data(7 downto 5)   <= std_logic_vector(rsp_packet_seq);	
                  resp_tx_data(4)            <= '0';	  -- really, this is the high bit of the packet type.. but we have < 16 (for now)
							
                  hdr_word <= resp_fifo_q_latch2;		  
							
                  respPacketType := unsigned(resp_fifo_q_latch2(7 downto 4));		
							
                  -- note: there is no packetType in FIFO for dataPayload packets
                  --       Ignore respPacketType and set "respPacketTypeSave" by hand 
                  if(nextIsPayload_save = '1' and respDataPacketCnt > 0) then
                     txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx	
                     tx_k_char_sig(1) <= '0';	-- default value is set to be 3. 
                                                -- Was tx_k_char_sig(0),.. but Rick gets bytes flipped	
                     -- decrement count of expected number of packets to follow                      
                     respDataPacketCnt <= respDataPacketCnt - 1;	 
                           
                     if (respPacketTypeSave = 4 or respPacketTypeSave = 8) then
                        respPacketTypeSave         <= x"8";	--DCS Block read response type	 
                        resp_tx_data(3 downto 0)   <= x"8";		  		
                     else
                        respPacketTypeSave <= x"6";	--Data response body 
                        resp_tx_data(3 downto 0)   <= x"6";	
                     end if;
							
                  elsif(respPacketType = 4 and nextIsPayload_save = '0') then -- DCS Reply Packet
                     txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx		   
                     tx_k_char_sig(1)              <= '0';	-- was (0),.. but Rick gets bytes flipped						 
                     resp_tx_data(3 downto 0)      <= x"4";	
                           
                     respPacketTypeSave <= respPacketType;	
									
                  elsif(respPacketType = 5 and nextIsPayload = '0') then -- Data Header Packet				   
                     txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx		   
                     tx_k_char_sig(1)              <= '0';	-- was (0),.. but Rick gets bytes flipped						 
                     resp_tx_data(3 downto 0)      <= x"5";			  
                           
                     respPacketTypeSave <= respPacketType;	   
								
                  else					--invalid resp packet type, cancel send!
                     ps_errors(ERROR_WrongPacketOut)  <= '1'; 					  
                     ps_state 		                  <= S_Reset; 													  
                     nextIsPayload 	                  <= '0';	  
								
                     respPacketTypeSave               <= x"F";		
                  end if;	
                        
               else  -- sendCnt>4 starts packet body
                     
                  txDataSel <= TXDATASEL_RSPFIFO;  --select RESP_FIFO for tx														 
                  tx_k_char_sig <= (others => '0'); --data chars	 					  
                  crc_en_sig <= '1';	
                        
                  -- NOTE: "resp_tx_data" is driven by RESF_FIFO output to by default, unless overwritten in the following
                  if(respPacketTypeSave = 4) then -- DCS Reply Header Packet
                        
                     if(sendCnt = 5) then -- DMA Byte Count		
                        resp_tx_data <= (others => '0');	
                     elsif(sendCnt = 6) then --header word	
                        resp_tx_data <= hdr_word;		
                     elsif (sendCnt = 7) then -- PacketCount and Opcode	
                        if (nextIsPayload_save = '0') then
                           respDataPacketCnt	<= to_unsigned(0,6) & unsigned(resp_fifo_q_latch3(15 downto 6));
                           dcsResp_BlockOp		<= resp_fifo_q_latch3(1);   
                           dcsResp_DoubleOp	    <= std_logic(resp_fifo_q_latch3(2));	 
                        end if;	
                     elsif (sendCnt = 8) then       --Op 1 Address
                        if ( dcsResp_BlockOp = '1' and respDataPacketCnt /= 0) then	  
                           nextIsPayload	<= '1';		 
                        else  					   	
                           nextIsPayload	<= '0';
                        end if;			   
                     elsif (sendCnt = 9)  then	    --Op 1 Data
                     elsif (sendCnt = 10) then	    --Op 2 Address	 
                        if(dcsResp_blockOp = '0' and dcsResp_doubleOp = '0') then	
                           resp_tx_data <= (others => '0');
                        end if;
                     elsif (sendCnt = 11) then      --Op 2 Data	  
                        if(dcsResp_blockOp = '0' and dcsResp_doubleOp = '0') then
                           resp_tx_data <= (others => '0');
                        end if;
                     elsif(sendCnt = 12) then       --Block Op 3		
                        if(dcsResp_blockOp = '0') then
                           resp_tx_data <= (others => '0');
                        end if;		
                        ps_state <= S_Crc; 		-- last word is CRC								
                     end if;	
								
                  elsif(respPacketTypeSave = 5) then -- Data Header Packet	 
                           
                     if(sendCnt = 5) then -- data doesnt matter for DMA byte count field		
                        resp_tx_data <= (others => '0');
                     elsif(sendCnt = 6) then 										
                     elsif(sendCnt = 7) then -- Packet Count alleviate timing	
                        respDataPacketCnt_save <= unsigned(resp_fifo_q_latch3);				
                     elsif(sendCnt = 8) then 			
                     elsif(sendCnt = 9) then 	  
                        if (respDataPacketCnt_save > 0) then
                           respDataPacketCnt <= respDataPacketCnt_save; 
                           nextIsPayload <= '1'; 
                        else   
                           respDataPacketCnt <= (others => '0'); 
                           nextIsPayload 	  <= '0';
                        end if;
                     elsif(sendCnt = 10) then 								
                     elsif(sendCnt = 11) then 								
                     elsif(sendCnt = 12) then
                        ps_state <= S_Crc; 		-- last word is CRC	    
                     end if;		  
                  
                  else  -- for all other packet, just add CRC as last word 
                     if(sendCnt = 12) then 	 
                        ps_state <= S_Crc; 										
                     end if;
                  end if;
							  				
               end if;					  
                     
               --Retransmit RAM Storage----Enabling Write Signal-----
               if(sendCnt > 3) then	 	 			   
                  retransmit_we   <= '1';	
               end if;
                        
               ps_status(7 downto 0) <= x"05";
                     
            elsif (ps_state = S_Fwd) then
                  
               sendCnt <= sendCnt + 1;					  		
               txDataSel <= TXDATASEL_FWDFIFO;  --select FWD_FIFO for tx
												 
               if(sendCnt < 8) then	
                  fwdFifoRe_mask <= '1';    
               end if;
								 	   
               if(sendCnt = 0) then -- first word, do funny KCHAR		
                  tx_k_char_sig(1)  <= '0';	-- was (0),.. but Rick gets bytes flipped	  
               else																						 
                  tx_k_char_sig     <= (others => '0'); --data chars				 					  
                  crc_en_sig        <= '1';
               end if;    
											   
               if(sendCnt = 8) then -- last word is CRC	
                  ps_state <= S_Crc; 	
               end if;			
																																 
               ps_status(8)            <= '1'; --indicate a fwd was sent ever
               ps_status(7 downto 0)   <= x"04"; 	
                     
            elsif (ps_state = S_Crc) then	
                  
               txDataSel <= TXDATASEL_CRC; -- swap CRC into tx											 
               tx_k_char_sig <= (others => '0'); --data chars 
               ps_state <= S_OneExtra;	

               if(respDataPacketCnt = 0) then	  		  
                  nextIsPayload <= '0';	
                  BUSY_STOP     <= '1';
               end if;
							
               ps_status(12) <= '1'; --indicate a crc was sent ever 												 
               ps_status(7 downto 0) <= x"06"; 
                     
            elsif (ps_state = S_OneExtra) then	  		--CRC gets put into txdata
                  
               if(respDataPacketCnt = 0) then	  		  
                  BUSY_STOP     <= '1';
               end if;

               ps_state <= S_Idle;					
               ps_status(7 downto 0) <= x"07";
                                         
            elsif (ps_state = S_WaitToRetransmitData) then
                  
               retransmitCnt <= retransmitCnt + 1;
               if (retransmitCnt = 1)then
                  retransmit_packet_seq <= unsigned(retransmit_packet_req) + 1; 
               end if;
                     
               if (retransmitCnt = 2) then
                  retransmitCnt	<= (others => '0');
                  ps_state	<= S_packetRetransmit;  				
                  retransmit_read_count <= (others => '0');
               end if;						
               ps_status(7 downto 0)       <= x"10";
                        
            elsif (ps_state = S_packetRetransmit) then
                  
               retransmitCnt <= retransmitCnt + 1;	
					
               if (retransmitCnt > 1) then 						 
                  retransmit_read_count <= retransmit_read_count + 1;
                        
                  if (retransmit_read_count  < 12) then		   -- Send retransmitted packet of 10 words  
                           
                     RETRANSMIT_RAM_RADDR   <= std_logic_vector(retransmit_packet_seq) & std_logic_vector(retransmit_read_count);
                     if (retransmit_read_count > 1) then
                        txDataSel <= TXDATASEL_RETRANSMIT;
                        retransmit_data_signal <= RETRANSMIT_DOUT_FROM_RAM;
                     end if;
                              
                  elsif (retransmit_read_count = 12) then      -- decide if more packet need to be retransmitted
                  
                     if (retransmit_packet_seq /= rsp_packet_seq) then	--Choose Packet
                        ps_state <= S_postRetransmit;
                     else
                        ps_state <= S_doneRetransmit; 
                     end if;
                     retransmitCnt          <= (others => '0');
                     retransmit_read_count  <= (others => '0');
                  end if;								
               end if;	
               ps_status(7 downto 0)       <= x"11";
                     
            elsif (ps_state <= S_postRetransmit) then
               retransmitCnt <= retransmitCnt + 1;	 
               if (retransmitCnt = 5) then  -- wait for packet to be read from RAM and sent to TX XCVR
                  retransmit_packet_seq <= retransmit_packet_seq + 1;  
               end if;
                     
               if (retransmitCnt = 6) then
                  ps_state <= S_packetRetransmit;
                  retransmitCnt	<= (others => '0');	
               end if;
						
               ps_status(7 downto 0)       <= x"12";
                     
            elsif (ps_state <= S_doneRetransmit) then
               retransmitCnt <= retransmitCnt + 1;	 
						
               if (retransmitCnt = 5) then
                  ps_state <= S_Idle;
                  retransmitCnt	<= (others => '0');
                  retransmit_packet_seq <= (others => '0');
               end if;

               BUSY_STOP     <= '1';

               ps_status(7 downto 0)       <= x"13";
                     
            end if;	
               
         end if;			  
      end if;			
   end process;
	
   --=======================
   --=======================
	roc_mon_gen	: for i in 0 to 0 generate	   
		--standard RocMonitor interface generate template
		signal algo_rdata_sig			: std_logic_vector(gAPB_DWIDTH-1 downto 0) := (others => 'Z');   --16-bit bus		
		signal locAddr						: unsigned(ALGO_LOCADDR_WIDTH-1 downto 0);		   -- 8-bit bus														
		signal wAddr						: unsigned(ALGO_WADDR_WIDTH-1 downto 0);           -- 8-bit bus																
		signal wData						: std_logic_vector(ALGO_WDATA_WIDTH-1 downto 0);   -- 16-bit bus but bit[15] is filled as 0		
      signal we, we_latch				: std_logic;				   	   														  									  
																	  									  
		signal rAddr						: unsigned(ALGO_RADDR_WIDTH-1 downto 0) := (others => '1');	
		signal rst_cnt						: unsigned(3 downto 0) := (others => '0');		
		
		signal dummy_reg					: std_logic_vector(gAPB_DWIDTH-1 downto 0);
		
	begin				 
		 
		ALGO_RDATA 	<= algo_rdata_sig;	
		wAddr		   <= extract_algo_waddr(ALGO_ADDR);      -- get 8-bit operation address  
		locAddr		<= extract_algo_locaddr(ALGO_ADDR);    -- get 8-bit target location address  	 
		wData		   <= extract_algo_wdata(ALGO_WDATA);     -- get 15-bit data + bit[15] = 0 
		
		roc_monitor: process( ALGO_CLK )   														 
		begin		

			if rising_edge(ALGO_CLK) then		  
               we       <= extract_algo_we(ALGO_WDATA); -- get write enable		  
               we_latch <= we; --latch we bit		
               algo_rdata_sig <= (others => 'Z'); --always high impedance if not addressed
					
               -- gen reset pulse			
               rst_cmd <= '0';	  									
               if (rst_cnt /= 0) then
                  rst_cnt <= rst_cnt - 1;
                  rst_cmd <= '1';
               end if;
				
               -- main cases
               if ALGO_RESET = '1' then		 
                  rst_cmd     <= '0';	  
                  rAddr       <= (others => '1');		
                  enable      <= '1';	  
                  force_send  <= '0';	
                  force_reset <= '0';
                  
               else
                  -- check target address
                  if(	locAddr = to_unsigned(ALGO_LOC_ADDR, ALGO_LOCADDR_WIDTH)) then 
			
                     --Writes
                     if (we_latch = '0' and we = '1') then -- identify we rising edge
											
                        if wAddr = 0 then 						   --setup rAddr	 	
                           rAddr <= unsigned(wData(ALGO_RADDR_WIDTH-1 downto 0));
                        elsif wAddr = 1 then
                           if (wData(0) = '1') then --start a reset pulse
                              rst_cnt <= (others => '1');
                           end if; 		  
                           --enable <= wData(4);
                        elsif wAddr = 2 then
                           dummy_reg(ALGO_WDATA_WIDTH-1 downto 0) <= wData;
                        elsif wAddr = 3 then
                           dbgDataSel <= unsigned(wData(1 downto 0));	  
                        elsif wAddr = 4 then
                           force_send <= wData(0);	
                        elsif wAddr = 5 then
                           force_reset <= wData(0);	
                        end if;											  
							
                     end if;	-- end Writes
						
						
                     --Reads				
                     algo_rdata_sig <= (others => '0');		  
                     if (rAddr = 0) then			  		
                        algo_rdata_sig <= ps_status;
                     elsif (rAddr = 1) then			  		
                        algo_rdata_sig <= ps_errors;	 						
                     elsif (rAddr = 2) then
                        algo_rdata_sig <= dummy_reg;
                     elsif wAddr = 3 then
                        dbgDataSel <= unsigned(wData(1 downto 0));	  
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
                     elsif (rAddr = 24) then			  		
                        algo_rdata_sig <= std_logic_vector(kchar_count);			   
                     elsif (rAddr = 25) then			  		
                        algo_rdata_sig <= std_logic_vector(kdata_count);
                     elsif (rAddr = 26) then  -- 0x1A
                        algo_rdata_sig <= std_logic_vector(respDataPacketCnt);
                     elsif (rAddr = 27) then -- 0x1B
                        algo_rdata_sig(3 downto 0)     <= std_logic_vector(respPacketType);
                        algo_rdata_sig(7 downto 4)     <= "0000";
                        algo_rdata_sig(11 downto 8)    <= "000" & nextIsPayload;
                        algo_rdata_sig(15 downto 12)   <= "000" & nextIsPayload_save;
                     elsif (rAddr = 28) then -- 0x1C
                        algo_rdata_sig(2 downto 0)      <= std_logic_vector(txDataSel);
                     else						
                        algo_rdata_sig <= std_logic_vector(rAddr) & std_logic_vector(to_unsigned(ALGO_LOC_ADDR, gAPB_DWIDTH-ALGO_RADDR_WIDTH));
                     end if;    -- end Reads
						
                  end if;   -- check target address
                  
               end if;      -- end Main cases	   				
			end if;	        -- if rising_edge(ALGO_CLK)		
         end process;
   end generate;
	
end arch;

