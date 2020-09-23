--------------------------------------------------------------------------------
-- Company: Fermilab
--
-- File: ForwardDetector.vhd
-- File history:
--      v00: Feb 25, 2015: Birthday
--	    v01: June 23, 2018: First Update
--      v02: June 10, 2020: MT  labelled state->fd_state and status->fd_status
--      v03: July 8, 2020:  MT  cleaned logic and unused signals. 
--                          In particular, remove any usage of "byte_flip = 1" (ie assume byte flip is detected and fixed in XCVR block).
--                          Correct handling of single and double markers.    
--      v04: July 22, 2020: MT Added assignment of REC_SEQ_NUM from received packet header and moved REC_SEQ_NUM_EXPECTED check to S_Crc 
--                             to cover block packet case 
--      v05:  August 13, 2020:  MT added BUSY_START to signal uProc that logic is tending DTC request
--      v06:  August 23, 2020:  MT made module RD/WR registers more uniform accross all modules. Also fixed single/double error marker logic
--
-- Description: 
--  ForwardDetector decrements hop and forwards immediately if the hop result is not 0.
--	Also forwards if packet source is another ROC. Otherwise receive packet to ReceiveFifo.	
--	Note: Always forward to alternate link's ForwardFifo
-- 
-- Update Description:	
-- ForwardDetector identifies and distinguishes established packets and markers and forwards them
-- to their respective module. Packets (DCS Requests, Data Req, etc.) are usually sent to 
-- the Command Handler; Markers are sent to different modules and are used for alignment (Event Marker/Clock Marker/Loopback) or 
-- debugging purposes (Timeout Marker).

-- Targeted device: <Family::Polarfire> <Die::MPF300TS_ES> <Package::FCG484>
-- Author: Ryan Rivera and Jose Berlioz
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 
								   						   
library work;
use work.algorithm_constants.all; 

entity ForwardDetector is  
		Generic (			 
            gAPB_DWIDTH     		: integer := 16;  
            gAPB_AWIDTH     		: integer := 16;	 
            gSERDES_DWIDTH  		: integer := 20; 
            gENDEC_DWIDTH   		: integer := 16;	
            IO_SIZE         		: integer := 2;
            ALGO_LOC_ADDR 			: natural := 0
		);
	    port(	
				------- Clocks -------
            EPCS_RXCLK              : in std_logic;       -- RX Serdes Clock
            ALGO_CLK              	: in std_logic;	  	  -- Roc Monitor (Slow Control) Clock
				-------	Resets -------
            RESET_N                 : in std_logic;	   	   
				
				------- Synchronization	-------
				CLK40_GEN				: in std_logic;	
				------- Markers for ROC synchronization -------
				CLOCKMARKER				: out std_logic;
				EVENTMARKER				: out std_logic;	   
				LOOPBACKMODE			: out std_logic;
				
				------- Retransmission Request Markers -------
				RETRANSMIT_DETECTED		: out std_logic;
				RETRANSMIT_SEQUENCE_REQ	: out std_logic_vector(2 downto 0);
				
				------- CRC Interface -------		 
            CRC_RST       	   		: out std_logic;	  
            CRC_EN       	   		: out std_logic;	 							
            CRC_IN	     	   		: out std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0); 					 
            CRC_OUT     	   		: in std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0);   
				
				------- 8b10b CorePCS Interface -------
            INVALID_K     	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
            CODE_ERR_N     	   	: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
            B_CERR       	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
            RD_ERR       	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
				XCVR_LOCK     	   		: IN std_logic;  
				RX_VAL					   : IN std_logic;
				RX_K_CHAR    	   		: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
				RX_DATA     	   		: IN std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0);  
				
				------- RocMonitor Interface -------							   	
				ALGO_RESET				: in std_logic;
				ALGO_ADDR 				: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	 	  
				ALGO_WDATA				: in std_logic_vector(gAPB_DWIDTH-1 downto 0);	
				ALGO_RDATA				: inout std_logic_vector(gAPB_DWIDTH-1 downto 0);
				
				ALIGNMENT_REQ			: in std_logic;	
						
				------- ReceiveFifo Interface -------
            RCV_FIFO_DATA 		   : out std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				RCV_FIFO_WE 			: out std_logic;	  	 
				RCV_FIFO_RESET 		: out std_logic;
				RCV_FIFO_FULL 			: in std_logic;	   		
				------- ForwardFifo Interface -------
		        FWD_FIFO_DATA 		: out std_logic_vector (gENDEC_DWIDTH-1 downto 0);  
				FWD_FIFO_WE 			: out std_logic;	  	 
				FWD_FIFO_RESET 		: out std_logic;
				FWD_FIFO_FULL 			: in std_logic;		
				
				------- Marker Error Flags -------
				ERROREVENTALIGNMENT		: OUT std_logic;   --Is the Event XCVR_LOCK?	
				ERRORLOOPBACKALIGNMENT	: OUT std_logic;
				ERRORCLOCKALIGNMENT		: OUT std_logic;  			 
				------- Debugging Flags -------
				ERROR_CODE_FW				: OUT STD_LOGIC_VECTOR(15 downto 0); --Outputs the error (8 bits) and status flag(8 bits) in which it happened.
				ERROR_FLAG_FW				: OUT STD_LOGIC;
            ----  MT addded
            BUSY_START               : OUT STD_LOGIC
	    );
end ForwardDetector;
                                                                                                   

architecture arch of ForwardDetector is    

	------- Constant Parameters -------
	--=================================
	constant SH_RX_REG_DEPTH 				: natural 		:= 15;		  
	constant DCS_PACKET_BODY_SZ			: natural      := 8;
	constant PACKET_BODY_SZ					: natural 		:= 6;													 	  								   
	constant OFFSET_COUNTER_SIZE			: natural 		:= 32;
	constant offset_counter_saturated	: unsigned (OFFSET_COUNTER_SIZE-1 downto 0) := (others => '1');
	
	
	------- Types -------
	--===================				
	type state_t is ( 	--| Equivalent Status (3 downto 0) 
						---------------------------------
			S_Crc,		--| Status: 8
			S_Pause,   	--| Status: 7
			S_Body,	   --| Status: 6
			S_DCSData, 	--| Status: 5
			S_Header,  	--| Status: 4
			S_Start,	   --| Status: 3
			S_Idle,	   --| Status: 2
			S_Reset,	   --| Status: 1	  
			S_LossLock	--| Status: 15 (0xF)
			); 	  	
	
	type shRxReg_t is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	
	
	------- Main Signals -------
	--==========================	 
	
	------- Status Signals -------		
	signal fd_state 					: state_t;	 
	signal fd_status					: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	

	constant status_Crc				: std_logic_vector(3 downto 0) := "0111";		
	constant status_Pause  			: std_logic_vector(3 downto 0) := "0110";	
	constant status_Body	  		   : std_logic_vector(3 downto 0) := "0101";	
	constant status_DCSData			: std_logic_vector(3 downto 0) := "0100";	
	constant status_Header 			: std_logic_vector(3 downto 0) := "0011";
	constant status_Start			: std_logic_vector(3 downto 0) := "0010";	
	constant status_Idle	  		   : std_logic_vector(3 downto 0) := "0001";	
	constant status_Reset			: std_logic_vector(3 downto 0) := "0000";	
	constant status_LossOfLock		: std_logic_vector(3 downto 0) := "1111";										 
	
	------- Error Signals -------
	signal fd_errors					: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
	signal errors_latch				: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
	signal error_counter				: unsigned (10 downto 0);		  
	signal error_flag_read			: std_logic;
			
	constant ERROR_CRC 						   : natural := 0;
	constant ERROR_PacketTypeMismatch 		: natural := 1;	
	constant ERROR_InvalidDataExcess  		: natural := 2;
	constant ERROR_ReceiveSequenceMismatch : natural := 3;
	constant ERROR_DCSResetMalfunction		: natural := 4;
	constant ERROR_UnrecognizedMarker      : natural := 5;
	 
	------- Signals -------				   
	signal rst_cmd							: std_logic := '0';		 										
	signal enable							: std_logic := '0';	 
	
	signal shRxReg 							: shRxReg_t(SH_RX_REG_DEPTH-1 downto 0);		
	signal packetCnt						   : unsigned(9 downto 0);
	signal DCSBlockStream					: std_logic;											  								
	signal hopCountSv						   : unsigned(3 downto 0);		 		   
	signal fwdCnt 							   : unsigned(9 downto 0);	  
	signal fwd_fifo_we_sig					: std_logic;					
	signal rcv_fifo_we_sig					: std_logic;	
	signal data_valid, data_valid_latch	: std_logic; 
	signal data_valid_mask					: std_logic;
	signal crc_err							   : std_logic;		 				
	signal disable_loop						: std_logic;					
	signal byte_flip						   : std_logic;			   
	signal crc	 							   : std_logic_vector(gENDEC_DWIDTH-1 downto 0);	   
	                                    	
	signal crc_rcv_save						: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	 
	signal crc_gen_save						: std_logic_vector(gENDEC_DWIDTH-1 downto 0);	
	signal crc_en_sig						   : std_logic;
	
	signal rx_data_sig     	   			: std_logic_vector(gENDEC_DWIDTH-1 DOWNTO 0);
	                                    	
	signal fwd_packet_count    			: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);  
	signal rcv_packet_count    			: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal dcs_packet_count    			: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal hb_packet_count    				: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal data_packet_count    			: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal any_header_count    			: unsigned(gENDEC_DWIDTH-1 DOWNTO 0); -- should = fwd + rcv			
	signal fwd_fifo_full_count    		: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);		 				  	
	signal rcv_fifo_full_count    		: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);		  	
	signal rcv_seq_err_count    			: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);	  	
	signal rcv_seq_num				 		: unsigned(2 DOWNTO 0);
	signal rcv_seq_num_expected		 	: unsigned(2 DOWNTO 0);																			   				  
	signal fifo_rst							: std_logic;	                                    	
	signal stable_align_count    			: unsigned(3 DOWNTO 0);		  
	signal data_invalid_count				: unsigned(3 downto 0);
	                                    	
	--Test without ROC Monitor          	
	signal enable_noMonitor                : std_logic;
	                                    	
	--5 CYCLE, 200Mhz, Marker Generation to TimeStamp		 
	signal packetType						      : unsigned(3 downto 0);
		   
	signal needMarkerAlignment				   : std_logic;
	signal errorEventAlignmentCounter		: unsigned(31 downto 0);
	signal generateMarkerCounter			   : unsigned(2 downto 0);
	signal generateMarker					   : std_logic;		  
	signal counterEventAlignmentError		: std_logic;
	signal eventDetected					      : std_logic;   
	signal clockDetected					      : std_logic; 
	signal loopbackModeDetected				: std_logic;	  	 
	signal timeoutDetected				      : std_logic;	  	 
	signal clock_marker_count    			   : unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal event_marker_count    			   : unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal loopback_marker_count    			: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal retr_marker_count    			   : unsigned(gENDEC_DWIDTH-1 DOWNTO 0);
	signal timeout_marker_count				: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);
	signal alignment_req_latch				   : std_logic;
	signal alignment_req_latch2				: std_logic;
	signal alignment_req_risingEdge			: std_logic;
	signal needAlignment					      : std_logic;	 
	signal readyAlignment					   : std_logic;
	
	signal generateMarkerLatch				   : std_logic;
	signal clk40genLatch					      : std_logic;		   
	signal clk40Counter						   : unsigned(2 downto 0);		
	signal Counter_16						      : unsigned(5 downto 0);
	signal launchCounter					      : unsigned(3 downto 0);	  
	signal waitForAlignment					   : std_logic;
	
	signal errorEventAlignment_sig			: std_logic;
	signal errorClockAlignment_sig			: std_logic;
	signal errorLoopbackAlignment_sig		: std_logic;
	
	signal DCS_packetCnt					      : unsigned(9 downto 0);
	
	--DTC Error Marker
	signal error_DoubleMarker				   : std_logic;
	signal error_DoubleMarker_latch			: std_logic;
	signal error_DoubleMarker_count    		: unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	signal error_SingleMarker			      : std_logic;
	signal error_SingleMarker_latch        : std_logic;
	signal error_SingleMarker_count        : unsigned(gENDEC_DWIDTH-1 DOWNTO 0);			  
	--event
	signal E_markerOffsetPlusOne 				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	signal E_markerOffsetPlusTwo				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal E_markerOffsetMinusOne				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal E_markerOffsetMinusTwo				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);  	
	signal E_markerOffsetCenter				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);  	  	 
	
	--loopback
	signal L_markerOffsetPlusOne 				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	signal L_markerOffsetPlusTwo				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal L_markerOffsetMinusOne				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal L_markerOffsetMinusTwo				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);  	
	signal L_markerOffsetCenter				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0); 
    
	--clock
	signal C_markerOffsetPlusOne 				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	signal C_markerOffsetPlusTwo				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal C_markerOffsetMinusOne				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal C_markerOffsetMinusTwo				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);  	
	signal C_markerOffsetCenter				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);  
	
	--all markers									 
	signal markerOffsetPlusSeven 				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	signal markerOffsetPlusSix					: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal markerOffsetPlusFive 				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	signal markerOffsetPlusFour 				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	signal markerOffsetPlusThree				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal markerOffsetPlusTwo 				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	signal markerOffsetPlusOne					: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	  
																	   
	signal markerOffsetCenter					: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	
	signal markerOffsetMinusOne				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal markerOffsetMinusTwo				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal markerOffsetMinusThree				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal markerOffsetMinusFour				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	 
	signal markerOffsetMinusFive				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal markerOffsetMinusSix				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);
	signal markerOffsetMinusSeven				: unsigned (OFFSET_COUNTER_SIZE-1 downto 0);	
	
	--Timing Alleviation Latches (SERDES)			
	signal invalid_k_latch						: std_logic_vector(IO_SIZE-1 downto 0); 
	signal code_err_n_latch						: std_logic_vector(IO_SIZE-1 downto 0); 
	signal b_cerr_latch							: std_logic_vector(IO_SIZE-1 downto 0); 
	signal rd_err_latch							: std_logic_vector(IO_SIZE-1 downto 0); 
	signal XCVR_LOCK_latch						: std_logic; 
	signal rx_val_latch							: std_logic; 
	signal rx_data_latch						   : std_logic_vector(gENDEC_DWIDTH-1 downto 0); 	 
	signal rx_data_latch_prev					: std_logic_vector(gENDEC_DWIDTH-1 downto 0); 
	signal rx_k_char_latch_prev				: std_logic_vector(IO_SIZE-1 downto 0);
	signal rx_k_char_latch						: std_logic_vector(IO_SIZE-1 downto 0);	  	  

	signal retransmissionReq               : std_logic;
	signal retransmissionDetected     : std_logic;
	signal retransmit_seq_save					: std_logic_vector(2 downto 0);
	signal stable_retransmit_counter			: unsigned(1 downto 0);	 -- unsigned(3 downto 0);
    -- MT added
    signal dtcreq                         : std_logic;
    
begin													   	  
	FWD_FIFO_WE		<= fwd_fifo_we_sig;		  		  
	FWD_FIFO_DATA 	<= shRxReg(2); --SH_RX_REG_DEPTH-1);	  	 
	RCV_FIFO_WE		<= rcv_fifo_we_sig;	
	RCV_FIFO_DATA 	<= shRxReg(0);	 
	CRC_IN			<= crc;	    
	CRC_EN			<= crc_en_sig and data_valid_latch;   
	
	data_valid 		<= ((not rx_k_char_latch(0) and not rx_k_char_latch(1)) or (rx_k_char_latch(0) and rx_k_char_latch(1))) and data_valid_mask;
	
	RCV_FIFO_RESET 	<=  rst_cmd or fifo_rst;   
	FWD_FIFO_RESET 	<=  rst_cmd or fifo_rst; 
    
   BUSY_START      <=  dtcreq or RETRANSMIT_DETECTED; 
      	
--	rx_data_sig <= rx_data_latch when byte_flip = '0' else rx_data_latch(7 downto 0) & rx_data_latch(15 downto 8);
	rx_data_sig       <= rx_data_latch;
	enable_noMonitor  <= '1';		-- let SM to run even is not reset (ie enable might be low!!)			   	 
	
-- ===================	(1)Forward Detector State Machine 	==================
--	Produces 40Mhz markers (1C10,1C11,1C12) to transfer to a different clock domain.
--	Main Process of module. 
-----------------------------------------------------------------			 
	main: process( EPCS_RXCLK, XCVR_LOCK )  
		variable packetTypeBody	: unsigned (3 downto 0); 
		variable hopCount		: unsigned (3 downto 0); 
	begin				
	--(0.1) ALIGNMENT CHECK 			--If XCVR is not LOCKED, do nothing 
		if XCVR_LOCK = '0' then		 	--Could also use ALIGNED flag or RX_VAL if not using XCVR Controller Block
			fd_state  <= S_LossLock;
			fd_status <= (others => '1'); 			 	--indicate ALIGN problem (it will also reset the ROC and allow to transition to state  <= S_Reset; 	  	
		----------------------------------------------------------------------
	--(1) XCVR_LOCK XCVR DONE
		elsif rising_edge(EPCS_RXCLK) then		
			--(1A.1) SERDES Timing Alleviation Latches (SERDES)	 
			invalid_k_latch	<= INVALID_K;   --Useless  
			code_err_n_latch	<= CODE_ERR_N;    	
			b_cerr_latch		<= B_CERR;       	
			rd_err_latch		<= RD_ERR;   
			rx_val_latch 		<= RX_VAL;			
			rx_k_char_latch	<= RX_K_CHAR;
			rx_data_latch		<= RX_DATA;	
            
			errors_latch       <= fd_errors;   -- MT added
         dtcreq             <= '0';
			
			--(1A.2) STANDARD SIGNAL ASSIGNMENT		--Overwritten on the proper state.	 
			CLOCKMARKER 			<= '0';  
			EVENTMARKER				<= '0';	
			RETRANSMIT_DETECTED	<= '0';	  
         LOOPBACKMODE 	      <= '0';   -- MT added since following logic is edge sensitive. Remove if it needs to be a level! Next EVENTMARKER will clear it...
			data_valid_latch 		<= data_valid;
			fifo_rst 				<= '0';
			fwd_fifo_we_sig 		<= '0';		
			rcv_fifo_we_sig 		<= '0';			 
			fd_status(14) 			<= enable; 
			fd_status(15) 			<= rst_cmd;											   								  
			crc_en_sig 				<= '0';	 
			CRC_RST 				   <= '0';	
         retransmissionReq    <= '0';	  
         retransmissionDetected <= '0';	  	  
			data_valid_mask		<= '1';	 
			rx_data_latch_prev 	<= rx_data_latch; 
			rx_k_char_latch_prev	<= rx_k_char_latch;
			
			--(1A.3) FIFO FULL COUNTER				-- Counter for cycles where FIFO was full. 
			if (FWD_FIFO_FULL = '1' ) then	   
				fwd_fifo_full_count <= fwd_fifo_full_count + 1;
			end if;
			
			if (RCV_FIFO_FULL = '1') then		  
				rcv_fifo_full_count <= rcv_fifo_full_count + 1;
			end if;
			
			--(1A.4) Store into shRxReg the value of rx_data_sig
			if(fd_state /= S_Idle and fd_state /= S_Reset) then
				shRxReg <= shRxReg(SH_RX_REG_DEPTH-2 downto 0) & rx_data_sig;  		 
			end if;			  
			
			--(1D) MARKER GENERATION OUTPUT	
			-----------------------------------------------------
			--(1D.1) MARKER GEN (ON)					--Output for 5 cycles the Marker Flag
         if(generateMarkerCounter >= 0 and generateMarkerCounter < 5)then		
				if(clockDetected = '1') then
					CLOCKMARKER 	<= '1';		 
				elsif (eventDetected = '1') then
					EVENTMARKER 	<= '1';						  
					LOOPBACKMODE 	<= '0';
				elsif (loopbackModeDetected = '1') then
					EVENTMARKER 	<= '1';
					LOOPBACKMODE 	<= '1';
				end if;							   	
				
			--(1D.2) MARKER GEN (OFF)					--Stop Marker Generation
         elsif(generateMarkerCounter = 5 ) then
            if (clockDetected = '1') then          clock_marker_count <= clock_marker_count + 1; end if; 
            if (eventDetected = '1') then          event_marker_count <= event_marker_count + 1; end if;
            if (loopbackModeDetected = '1') then   loopback_marker_count <= loopback_marker_count + 1; end if;
            if (timeoutDetected = '1') then        timeout_marker_count <= timeout_marker_count + 1; end if;
				clockDetected 			<= '0';
				eventDetected			<= '0';
				loopbackModeDetected  <= '0';
				timeoutDetected 		<= '0';							 
			end if;					  
			
         --   double markers error counter
         error_DoubleMarker_latch   <= error_DoubleMarker;
         if ( error_DoubleMarker = '1' and error_DoubleMarker_latch = '0') then
            error_DoubleMarker_count <= error_DoubleMarker_count + 1;
         end if;
			

         --   single markers error counter
         error_SingleMarker_latch   <= error_SingleMarker;
         if ( error_SingleMarker = '1' and error_SingleMarker_latch = '0') then
            error_SingleMarker_count <= error_SingleMarker_count + 1;
         end if;
   

			--===========================================================
			---- 					MARKER DETECTION 
			--===========================================================
			--(1E.1) RESET DETECTED
			if RESET_N = '0' or rst_cmd = '1' or fd_status(15) = '1' then	 	
				CLOCKMARKER   			   <= '0';
				EVENTMARKER				   <= '0';
				LOOPBACKMODE			   <= '0';
				clockDetected 			   <= '0';
				eventDetected			   <= '0';
				loopbackModeDetected  	<= '0';	
				timeoutDetected 			<= '0';
				error_SingleMarker 		<= '0';
				error_DoubleMarker 		<= '0';
            
				RETRANSMIT_SEQUENCE_REQ	<= (others => '0'); 
            
            error_SingleMarker_count<= (others => '0');
            error_DoubleMarker_count<= (others => '0');
            clock_marker_count      <= (others => '0');
            event_marker_count      <= (others => '0');
            loopback_marker_count   <= (others => '0');
            timeout_marker_count    <= (others => '0');
            retr_marker_count       <= (others => '0');

			--  MT changed logic to implement specifications for DTC-to-ROC Robustness in DocDB-4914:	
			--   correct markers are double ONLY for Clock and Event Marker, and single (but double will work as well...) for Loopback and DTCError.
            --   for Retransmission, use double marker PLUS third word containing the packet sequence of the packet found to have errors repeated 4 times. 
			elsif (rx_k_char_latch_prev(1) = '1' and rx_k_char_latch_prev(0) = '0'  and
                   eventDetected = '0' and clockDetected = '0' and timeoutDetected = '0' and retransmissionDetected = '0') then  -- skip second k_char_prev = 2 if already identified and not waiting for a third 16-bit word
            
            -- identify double word marker
            if ( rx_k_char_latch(1) = '1' and rx_k_char_latch(0) = '0') then
            
            -- identify eventmarker
               if ( rx_data_latch_prev = x"1C10" and rx_data_latch = x"1CEF") then
                  if (generateMarkerCounter > 5) then
                     eventDetected			<= '1';
                  end if;	
               -- identify double clockmarker
               elsif ( rx_data_latch_prev = x"1C11" and rx_data_latch = x"1CEE") then
                  if (generateMarkerCounter > 5) then
                     clockDetected			<= '1';
                  end if;							 	
               -- identify double word retransmission marker
               elsif ( rx_data_latch_prev = x"1C15" and rx_data_latch = x"1CEA") then
                  if (generateMarkerCounter > 5) then
                     retransmissionReq       <= '1'; 
                  end if;	
               else  
                  error_DoubleMarker <= '1';
               end if;
               
            -- identify single word marker
            elsif ( rx_k_char_latch(1) = '1' and rx_k_char_latch(0) = '1' and rx_data_latch = x"BC3C") then
            
               -- identify lopback mode marker
               if ( rx_data_latch_prev = x"1C12") then
                  if (generateMarkerCounter > 5) then
                     loopbackModeDetected	<= '1';
                  end if;	
               -- identify other single word markers
               elsif (rx_data_latch_prev = x"1C13" or rx_data_latch_prev = x"1C14") then				
                  if (generateMarkerCounter > 5) then
                     timeoutDetected	<= '1';
                  end if;
               -- identify possible error if not already marked as bad double marker 
               else  
                  if (error_DoubleMarker = '0') then 
                     error_SingleMarker <= '1';
                  end if;
               end if;
               
            -- identify third marker word
            elsif( rx_k_char_latch(1) = '0' and rx_k_char_latch(0) = '0') then
            
               -- Confirm "retransmissionReq" with last word: check content later
               if(rx_data_latch_prev = x"1CEA") then
                  retransmissionDetected  <= retransmissionReq;
               end if; 
										 
            end if;
				
         end if; 
       
       
			--Retransmission Marker Mechanism
			if(retransmissionDetected = '1') then 	   -- Check on sequence request
				if (rx_data_latch_prev(7 downto 4) = rx_data_latch_prev(3 downto 0) and 
					rx_data_latch_prev(11 downto 8) = rx_data_latch_prev(3 downto 0) and
					rx_data_latch_prev(15 downto 12) = rx_data_latch_prev(3 downto 0)) 	then
					
					stable_retransmit_counter	<= (others => '1');
					retransmit_seq_save			<= rx_data_latch_prev(2 downto 0);  
					RETRANSMIT_DETECTED			<= '0';	
					RETRANSMIT_SEQUENCE_REQ  <= (others => '0');
            else
               error_DoubleMarker <= '1';                     
				end if;
			else		  							
				if (stable_retransmit_counter = 3)then
					stable_retransmit_counter	<= stable_retransmit_counter - 1; 
				
				elsif (stable_retransmit_counter = 2) then	 
					stable_retransmit_counter	<= stable_retransmit_counter - 1; 
               RETRANSMIT_DETECTED			<= '1';	
               retr_marker_count          <= retr_marker_count + 1;
				elsif (stable_retransmit_counter = 1)then 
					stable_retransmit_counter	<= stable_retransmit_counter - 1; 
					--retransmissionIsValid	<= '1';
					RETRANSMIT_SEQUENCE_REQ	<= retransmit_seq_save;
					RETRANSMIT_DETECTED			<= '1';	
				elsif (stable_retransmit_counter = 0)then
					retransmit_seq_save <= (others => '0');
				end if;	   
			end if;	
			
				
			----- Clear marker errors 
			if (rx_k_char_latch(1) = '1' and rx_k_char_latch(0) = '1' and rx_k_char_latch_prev(1) = '1' and rx_k_char_latch_prev(0) = '1') then 
				error_SingleMarker <= '0';						
				error_DoubleMarker <= '0';
			end if;		 
			
			--===========================================================
			---- 					end MARKER DETECTION 
			--===========================================================  
													 							   
			--=====================================
			--(1E) STATE MACHINE
			--=====================================
			--(1E.1) RESET DETECTED
			if RESET_N = '0' or rst_cmd = '1' or fd_status(15) = '1' then		   
				DCSBlockStream			<= '0';	
				fd_status(3 downto 0)<= (others => '0');
				fd_state 				<= S_Reset;	  
				fd_errors 				<= (others => '0');	 
				crc_err 				   <= '0';				  
				crc_rcv_save 			<= (others => '0');	   					
				crc_gen_save 			<= (others => '0'); 	
				packetType 		      <= (others => '1');	
				fwd_packet_count 		<= (others => '0');	   
				rcv_packet_count 		<= (others => '0');	
				dcs_packet_count 		<= (others => '0');	
				hb_packet_count 		<= (others => '0');	
				data_packet_count 	<= (others => '0');	
				any_header_count 		<= (others => '0');			 
				fwd_fifo_full_count	<= (others => '0');		
				rcv_fifo_full_count	<= (others => '0');		
				rcv_seq_err_count 	<= (others => '0');						
				stable_align_count 	<= (others => '1');	  
               
            -- MT added to prevent unexpected behaviour
            hopCountSv              <= (others => '1');
            rcv_seq_num             <= (others => '0'); 
            rcv_seq_num_expected    <= (others => '0'); 
            DCS_packetCnt           <= (others => '0');	      
                              
			--------------------------------------------	
			--(1E.2) RESET STATE					
			elsif(fd_state = S_Reset) then
				fifo_rst <= '1';	
				
				-- make sure align is stable before proceding 
				if (rx_k_char_latch(1) = '1' and rx_k_char_latch(0) = '1' and stable_align_count = 0) then 	
					fd_status(3 downto 0)   <= status_idle;
					fd_state 			      <= S_Idle;
				end if;		  
				stable_align_count <= stable_align_count - 1;				
			-------------------------------------------------
			--(1F) RUN-MODE STATES
			else
				--(1F.1) UNKNOWN STATE
				fd_status(7 downto 0) <= (others => '1'); -- default to unknown state	   
			
				-- Steps:
					-- identify the start of a valid packet					 
					-- if packetType = 4, 5, or 6 then source is a ROC, so forward packet
					-- else if the hop count is > 1, decrement and forward packet 						
					-- if broadcast (packetType = 1) or hop count = 1, receive into algo 	
				
				----------------------------------------------------------------------------
				--(1F.2) IDLE STATE
				if (fd_state = S_Idle) then	  
					
					--0x1C00  //K28.0 & D0.0  (DCS Request Packet)			
					--0x1C01  //K28.0 & D1.0  (Readout Request Packet)
					--0x1C02  //K28.0 & D2.0  (Data Request Packet)						
					--0x1C10  //K28.0 & D10.0 (Event Marker)
					--0x1C11  //K28.0 & D11.0 (Clock Marker)		  
					
					data_invalid_count <= (others => '1');
												
					CRC_RST <= '1';											  
					--(1F.2A) XCVR ERROR FLAGS CHECK				  -- if errs on links, reset and reject until stable
					if (b_cerr_latch /= "00" or rd_err_latch /= "00" or code_err_n_latch /= "11") then
						fd_status(15) 			<= '1'; --hard reset	   	
						fd_status(3 downto 0)	<= status_reset;
					--(1F.2B) IDLE STATE
					elsif (enable_noMonitor = '1' or enable = '1') then  -- "enable" is ON after a reset
						------------------------------------
						--(..2B.1) RX_K_CHAR = 2 identify control character in marker or at the beginning of a packet in NORMAL RX_DATA		 
						-- Packet Type Doc Link => <A HREF="https://mu2e-docdb.fnal.gov/cgi-bin/private/RetrieveFile?docid=4914&filename=Mu2e_ROC_Packet_Protocol.pdf">Mu2e-doc-4914</A>
						if (rx_k_char_latch(1) = '1' and rx_k_char_latch(0) = '0') then	

                            -- if not a marker
							if( rx_data_latch(7 downto 0) /= x"10" and
								rx_data_latch(7 downto 0) /= x"11" and
								rx_data_latch(7 downto 0) /= x"12" and
								rx_data_latch(7 downto 0) /= x"13" and	
								rx_data_latch(7 downto 0) /= x"14" and
								rx_data_latch(7 downto 0) /= x"15" and
								rx_data_latch(7 downto 0) /= x"EF" and
								rx_data_latch(7 downto 0) /= x"EE" and
								rx_data_latch(7 downto 0) /= x"ED" and
								rx_data_latch(7 downto 0) /= x"EC" and
								rx_data_latch(7 downto 0) /= x"EB" and
								rx_data_latch(7 downto 0) /= x"EA") then	   
								
								fd_status(8) 				<= '1';		 
								fd_status(3 downto 0) 	<= status_start;
								fd_state 					<= S_Start;	   				   
								
								if(DCS_packetCnt > 0 and DCSBlockStream = '1') then	  
									fd_state				    <= S_DCSData;
									fd_status(3 downto 0) <= status_DCSData;
									DCS_packetCnt 		    <= DCS_packetCnt - 1;	 
									fwdCnt				    <= to_unsigned(DCS_PACKET_BODY_SZ,10);
								end if;
								
								shRxReg(0)  <= rx_data_latch;		 						 
								packetType	<= unsigned(rx_data_latch(3 DOWNTO 0));
                        rcv_seq_num	<= unsigned(rx_data_latch(7 DOWNTO 5));
								byte_flip <= '0';		 
							end if;	    
							
						end if;
                        
					end if;
					
					crc_err <= '0';														   									
					fd_status(7 downto 0) <= x"01";
               
				elsif(data_valid = '1') then		
					
					data_invalid_count   <= (others => '1');	 					
					crc				      <= rx_data_sig; --shRxReg(0);	
					
					if(fd_state = S_Start) then			
							
						-- Transfer Byte Count(16b)		   	 		
						crc_en_sig <= '1';
						fd_state <= S_Header;								
						fd_status(3 downto 0) <= status_header;		 	

						
					elsif (fd_state = S_Header) then		
						--constant PACKET_TYPE_DCSRequest 			:  natural := 0;	  
						--constant PACKET_TYPE_Heartbeat 			:  natural := 1;
						--constant PACKET_TYPE_DataRequest 			:  natural := 2;
						--constant PACKET_TYPE_DCSReply 			   :  natural := 4;
						--constant PACKET_TYPE_DataHeader 			:  natural := 5;
						--constant PACKET_TYPE_DataPayload 			:  natural := 6;
						--constant PACKET_TYPE_DCSWritePayload 	:  natural := 7;
						--constant PACKET_TYPE_DCSReadPayload 		:  natural := 8;
						
						-- Packet Type Doc Link => <A HREF="https://mu2e-docdb.fnal.gov/cgi-bin/private/RetrieveFile?docid=4914&filename=Mu2e_ROC_Packet_Protocol.pdf">Mu2e-doc-4914</A>
						
						-- valid & RingID | PacketType(4b) & Hop Count(4b) 	 	  
						crc_en_sig <= '1';
						packetTypeBody	:= unsigned(rx_data_sig(7 downto 4)); 
						hopCount		:= unsigned(rx_data_sig(3 downto 0));
												 
						fwdCnt <= to_unsigned(PACKET_BODY_SZ,10);						
						
						fd_state <= S_Reset; -- assume invalid/ignore unless conditions met below	
						fd_status(3 downto 0) <= status_reset;
						any_header_count <= any_header_count + 1;
						
						-- decrement hopCount for certain packets
						if (packetType = PACKET_TYPE_DCSRequest or 
							packetType = PACKET_TYPE_Heartbeat or 
							packetType = PACKET_TYPE_DataRequest) then
							hopCountSv <= hopCount-1;	 
						else
							hopCountSv <= hopCount;
						end if;
																  
						
						-- check if packet should be forwarded
						if ( ((
								packetType = PACKET_TYPE_DCSRequest or
								-- packetType = PACKET_TYPE_DCSWritePayload or --NOTE: DCS Write Payload does not have hopcount, so is invalid in ROC Ring topology
								packetType = PACKET_TYPE_Heartbeat or 
								packetType = PACKET_TYPE_DataRequest) and hopCount /= 0) or
							(
								packetType = PACKET_TYPE_DCSReply or	   
								packetType = PACKET_TYPE_DCSReadPayload or 
								packetType = PACKET_TYPE_DataHeader or
								packetType = PACKET_TYPE_DataPayload)) then --forward						
							fwd_fifo_we_sig <= '1';	   				   
							fwd_packet_count <= fwd_packet_count + 1;	 
							fd_state <= S_Body;
							fd_status(3 downto 0) <= status_body;
						end if;					
						
						-- check if packet is for this ROC
						if( ((
								packetType = PACKET_TYPE_DCSRequest or 
								packetType = PACKET_TYPE_DataRequest) and hopCount = 0) or						
							(
								packetType = PACKET_TYPE_DCSWritePayload or	--NOTE: assuming for this ROC; DCS Write Payload does not have hopcount, so is invalid in ROC Ring topology
								packetType = PACKET_TYPE_Heartbeat
							)) then --recv into algo  
							
							rcv_fifo_we_sig <= '1';						 
							rcv_packet_count <= rcv_packet_count + 1;  
                     
                     if( packetType = PACKET_TYPE_DCSRequest ) then
                        dcs_packet_count  <= dcs_packet_count + 1;  
                     elsif( packetType = PACKET_TYPE_DataRequest) then
                        data_packet_count <= data_packet_count + 1;  
                     elsif( packetType = PACKET_TYPE_Heartbeat  ) then
                        hb_packet_count   <= hb_packet_count + 1;  
							end if;	
                     
                     --- move check to S_Crc to cover also Block packets
							--if( rcv_seq_num	/= rcv_seq_num_expected) then
								--rcv_seq_err_count <= rcv_seq_err_count + 1;
								--if (rcv_seq_err_count /= 0) then
									--errors(ERROR_ReceiveSequenceMismatch) <= '1'; --set error if not initial seq number
								--end if;
							--end if;
							--rcv_seq_num_expected <= rcv_seq_num + 1; --save next expected seq number
			
							fd_state <= S_Body;
							fd_status(3 downto 0) <= status_body;
						end if;		
						
							-- check body packet type match		   	   
						if((  packetType = PACKET_TYPE_DCSRequest or 
                        packetType = PACKET_TYPE_DataRequest or	 
                        packetType = PACKET_TYPE_DCSReply or	 
                        packetType = PACKET_TYPE_DataHeader or
                        packetType = PACKET_TYPE_Heartbeat)  and  packetType /= packetTypeBody) then
                           fd_errors(ERROR_PacketTypeMismatch) <= '1'; --set error if not initial seq number	   
                           fd_state <= S_Reset; 
                           fd_status(3 downto 0) <= status_reset;
						end if;
										 
						fd_status(7 downto 0) <= x"03";
                  
					elsif (fd_state = S_Body) then			
					  
					   crc_en_sig <= '1';		
					   fwdCnt     <= fwdCnt - 1;   
                  dtcreq     <= '1';
						
						if(fwdCnt = PACKET_BODY_SZ ) then									--insert decremented hop count	
                        shRxReg(1) <= (shRxReg(0)(15 downto 4) & std_logic_vector(hopCountSv));	
							if (packetType = 0 and rx_data_sig(1 downto 0) = "11") then	 	--if DCS Req packet and Stream Bit is HIGH (ON) for a WRITE Operation.
								DCS_packetCnt	<= UNSIGNED(rx_data_sig(15 downto 6));	 	--then prepare for DCS packet burst.
								DCSBlockStream	<= '1';
							end if;
						end if;	   
						
						fwd_fifo_we_sig <= fwd_fifo_we_sig; --continue fwd we if has started	
						if(fwdCnt /= 0) then
							rcv_fifo_we_sig <= '1';	 
						end if;	   
									 
						if(fwdCnt = 0) then	 
							fd_state <= S_Crc;	 
							fd_status(3 downto 0) <= status_crc;
							crc_en_sig <= '0';
						end if;		  	  
	
						fd_status(7 downto 0) <= x"04";   		
					elsif (fd_state = S_DCSData) then 	  
						crc_en_sig <= '1';	   
						fwdCnt <= fwdCnt - 1;  
						if(fwdCnt = 0) then	 
							fd_state   <= S_Crc;
							fd_status(3 downto 0) <= status_crc;
							crc_en_sig <= '0';
						else
							rcv_fifo_we_sig <= '1';	
						end if;	
					elsif (fd_state = S_Crc) then		
												   					 										 
						fwd_fifo_we_sig <= fwd_fifo_we_sig; --continue fwd we if has started
						
						crc_rcv_save <= crc;	   					
						crc_gen_save <= CRC_OUT;   
												 				   
                        if( rcv_seq_num	/= rcv_seq_num_expected) then
                           rcv_seq_err_count <= rcv_seq_err_count + 1;
                           if (rcv_seq_err_count /= 0) then
                              fd_errors(ERROR_ReceiveSequenceMismatch) <= '1'; --set error if not initial seq number
                           end if;
                        end if;
                        rcv_seq_num_expected <= rcv_seq_num + 1; --save next expected seq number

                        if(disable_loop = '1') then
							fd_state 				<= S_Pause; 	
							fd_status(3 downto 0)   <= status_pause;
						elsif(rx_k_char_latch(1) = '1' and rx_k_char_latch(0) = '1') then
							fd_state 				<= S_Idle;   			   
							fd_status(3 downto 0) 	<= status_idle;
						else	
							fd_state <= S_Reset;
							fd_status(3 downto 0) 	<= status_reset;
						end if;			   
						
						if(crc /= CRC_OUT) then		 
							fd_state                <= S_Reset;
							fd_status(3 downto 0) 	<= status_reset;
							fd_errors(ERROR_CRC) 	<= '1';
						end if;	
						
						fd_status(7 downto 0) <= x"05";   	    							  
					elsif (fd_state = S_Pause) then		
						fd_status(7 downto 0) <= x"AA"; --paused			
					end if;	  
				else -- data invalid
					
					data_invalid_count <= data_invalid_count - 1;
					-- do not let invalid data happen forever!
					 						   					
					if(data_invalid_count = 0) then
						fd_state                <= S_Reset;	
						fd_status(3 downto 0) 	<= status_reset;
						fd_errors(ERROR_InvalidDataExcess) 	<= '1';
					end if;	
				end if; -- data valid states condition	
			
				
			end if;									 							   
			--=====================================
			--(1E) end STATE MACHINE
			--=====================================
			
		end if;			   		
	end process;   		
													
	
	
-- ===================	(2)Marker Domain Transfer 	==================
--	Produces 40Mhz markers (1C10,1C11,1C12) to transfer to a different clock domain
----------------------------------------------------------------------					 
	--(2) 
--	generateMarker 				<= 	clockDetected or eventDetected or loopbackModeDetected; 
	generateMarker 				<= 	clockDetected or eventDetected or loopbackModeDetected or timeoutDetected or retransmissionDetected;	  
	alignment_req_risingEdge	<= 	'1' when alignment_req_latch = '1' and alignment_req_latch2 = '0' else  '0'; 
	
	domainTransferAssistant : process(EPCS_RXCLK)	   	  --200Mhz to 40Mhz Counter
	begin											   
		if (rising_edge(EPCS_RXCLK)) then  		  
			alignment_req_latch		<=	ALIGNMENT_REQ;	 
			alignment_req_latch2	<= alignment_req_latch;
			
		 	--(2A)	MODULE RESET
			if	(RESET_N = '0') then				
				generateMarkerCounter   <= (others => '1');	 	--Counting means marker is being produced. RX_CLK/40Mhz Steps
				launchCounter 			<= (others => '1');		--Alignment wait.
				needAlignment 			<= '1';			  								   
				ERROREVENTALIGNMENT		<= '0';
				ERRORCLOCKALIGNMENT		<= '0';
				
				markerOffsetPlusOne <= (others => '0');
				markerOffsetPlusTwo <= (others => '0');
				markerOffsetPlusThree <= (others => '0');
				markerOffsetPlusFour <= (others => '0');	
				markerOffsetPlusFive <= (others => '0');
				markerOffsetPlusSix <= (others => '0');
				markerOffsetPlusSeven <= (others => '0');	 
											 
				markerOffsetCenter <= (others => '0');	
				
				markerOffsetMinusOne 	<= (others => '0');	 
				markerOffsetMinusTwo	<= (others => '0');
				markerOffsetMinusThree <= (others => '0');
				markerOffsetMinusFour <= (others => '0');
				markerOffsetMinusFive <= (others => '0');
				markerOffsetMinusSix <= (others => '0');
				markerOffsetMinusSeven <= (others => '0');      
				
				E_markerOffsetPlusOne <= (others => '0');
				E_markerOffsetPlusTwo <= (others => '0');	 
				
				E_markerOffsetMinusOne 	<= (others => '0');	 
				E_markerOffsetMinusTwo	<= (others => '0');
				E_markerOffsetCenter	<= (others => '0');	   
				
				C_markerOffsetPlusOne <= (others => '0');
				C_markerOffsetPlusTwo <= (others => '0');	 
				
				C_markerOffsetMinusOne 	<= (others => '0');	 
				C_markerOffsetMinusTwo	<= (others => '0');
				C_markerOffsetCenter	<= (others => '0');
			else	  						
			
			--(2B) MARKER ALIGNMENT REQUEST
				if (alignment_req_risingEdge = '1') then  
					needAlignment 		<= '1';	  
					markerOffsetPlusOne <= (others => '0');
					markerOffsetPlusTwo <= (others => '0');
					markerOffsetPlusThree <= (others => '0');
					markerOffsetPlusFour <= (others => '0');	
					markerOffsetPlusFive <= (others => '0');
					markerOffsetPlusSix <= (others => '0');
					markerOffsetPlusSeven <= (others => '0');	 
												 
					markerOffsetCenter <= (others => '0');	
					
					markerOffsetMinusOne 	<= (others => '0');	 
					markerOffsetMinusTwo	<= (others => '0');
					markerOffsetMinusThree <= (others => '0');
					markerOffsetMinusFour <= (others => '0');
					markerOffsetMinusFive <= (others => '0');
					markerOffsetMinusSix <= (others => '0');
					markerOffsetMinusSeven <= (others => '0'); 
					ERROREVENTALIGNMENT		<= '0';
					ERRORCLOCKALIGNMENT		<= '0';		   
					
					E_markerOffsetPlusOne <= (others => '0');
					E_markerOffsetPlusTwo <= (others => '0');	 
				
					E_markerOffsetMinusOne 	<= (others => '0');	 
					E_markerOffsetMinusTwo	<= (others => '0');
					E_markerOffsetCenter	<= (others => '0');	   
					
					C_markerOffsetPlusOne <= (others => '0');
					C_markerOffsetPlusTwo <= (others => '0');	 
				
					C_markerOffsetMinusOne 	<= (others => '0');	 
					C_markerOffsetMinusTwo	<= (others => '0');
					C_markerOffsetCenter	<= (others => '0');	
					
					L_markerOffsetPlusOne <= (others => '0');
					L_markerOffsetPlusTwo <= (others => '0');	 
				
					L_markerOffsetMinusOne 	<= (others => '0');	 
					L_markerOffsetMinusTwo	<= (others => '0');
					L_markerOffsetCenter	<= (others => '0');
				end if;				
																								   
				generateMarkerLatch 	<= generateMarker;
				
				if (Counter_16 = 14) then
					Counter_16 			<= (others => '0');
				else
					Counter_16				<= Counter_16 + 1;	  						--Event Marker Counts in 4 40Mhz Cycles
				end if;
				
			--(2C) LAUNCH COUNTER
				if(generateMarkerLatch = '0' and generateMarker = '1') then 	--START A LAUNCH SEQUENCE 				 				
					if (needAlignment = '1') then								--LAUNCH IMMEDIATELY IF FIRST MARKER
						Counter_16	 	<= "00" & x"8";
						generateMarkerCounter <= (others => '0');		
						needAlignment <= '0';
					else
						launchCounter <= (others => '0');	
					end if;	
				elsif (launchCounter < 11) then									--LAUNCH COUNTER
					launchCounter <= launchCounter + 1;	  
				end if;		 			
				
			--(2D) 40 MHZ MARKER LAUNCHING MECHANISM	
				clk40genLatch 		<= CLK40_GEN;				
				if(clk40genLatch = '0' and CLK40_GEN = '1') then   				--ALIGN TO 40MHZ 
					clk40Counter 	<= (0 => '1',others => '0');  									 
				elsif clk40Counter < 6 then						  
					clk40Counter <= clk40Counter + 1;
				end if;	
				
				if(launchCounter >= 2 and launchCounter < 11 and clk40Counter = 2) then 			--LAUNCH!
					generateMarkerCounter 	<= (others => '0');
				end if;
				
				
			--(2D)	GENERATE MARKER COUNTER 													--MARKER GENERATION  
				if (generateMarkerCounter < 6) then
					generateMarkerCounter 	<=  generateMarkerCounter + 1; 
				end if;							 						   
				
			--(2E) MISALIGNMENT COUNTERS	
				ERROREVENTALIGNMENT 	<= errorEventAlignment_sig;
				ERRORCLOCKALIGNMENT		<= errorClockAlignment_sig;
				ERRORLOOPBACKALIGNMENT	<= errorLoopbackAlignment_sig;	 
				
			--(2E.1)CLOCK MISALIGNMENT
				if	(generateMarkerLatch = '0' and clockDetected = '1' and needAlignment = '0') then
					if (clk40Counter = 1 and offset_counter_saturated > C_markerOffsetMinusOne) then	
						C_markerOffsetMinusOne 		<= C_markerOffsetMinusOne + 1;
						errorClockAlignment_sig 	<= '1';
					elsif (clk40Counter = 5 and offset_counter_saturated > C_markerOffsetMinusTwo) then
						C_markerOffsetMinusTwo 		<=	C_markerOffsetMinusTwo + 1;	
						errorClockAlignment_sig 	<= '1';
					elsif (clk40Counter = 4 and offset_counter_saturated > C_markerOffsetPlusTwo) then
						C_markerOffsetPlusTwo 		<= C_markerOffsetPlusTwo + 1;   
						errorClockAlignment_sig 	<= '1';
					elsif (clk40Counter = 3 and offset_counter_saturated > C_markerOffsetPlusOne) then
						C_markerOffsetPlusOne 		<= C_markerOffsetPlusOne + 1;	 	
						errorClockAlignment_sig 	<= '1';
					elsif (clk40Counter = 2 and offset_counter_saturated > C_markerOffsetCenter) then
						C_markerOffsetCenter		<= C_markerOffsetCenter + 1;	 	
					end if;
				end if;	  
				
			--(2E.2)EVENT MISALIGNMENT	
				if	(generateMarkerLatch = '0' and eventDetected = '1' and needAlignment = '0') then
					if (clk40Counter = 1 and offset_counter_saturated > E_markerOffsetMinusOne) then	
						E_markerOffsetMinusOne 		<= E_markerOffsetMinusOne + 1;
						errorEventAlignment_sig 	<= '1';
					elsif (clk40Counter = 5 and offset_counter_saturated > E_markerOffsetMinusTwo) then
						E_markerOffsetMinusTwo 		<=	E_markerOffsetMinusTwo + 1;	
						errorEventAlignment_sig 	<= '1';
					elsif (clk40Counter = 4 and offset_counter_saturated > E_markerOffsetPlusTwo) then
						E_markerOffsetPlusTwo 		<= E_markerOffsetPlusTwo + 1;   
						errorEventAlignment_sig 	<= '1';
					elsif (clk40Counter = 3 and offset_counter_saturated > E_markerOffsetPlusOne) then
						E_markerOffsetPlusOne 		<= E_markerOffsetPlusOne + 1;	 	
						errorEventAlignment_sig 	<= '1';	
					elsif (clk40Counter = 2 and offset_counter_saturated > E_markerOffsetCenter) then
						E_markerOffsetCenter		<= E_markerOffsetCenter + 1;	 	
					end if;
				end if;	 	 	 
				
			--(2E.2)LOOPBACK MISALIGNMENT	
				if	(generateMarkerLatch = '0' and loopbackModeDetected = '1' and needAlignment = '0') then
					if (clk40Counter = 1 and offset_counter_saturated > E_markerOffsetMinusOne) then	
						E_markerOffsetMinusOne 		<= E_markerOffsetMinusOne + 1;
						errorLoopbackAlignment_sig 	<= '1';
					elsif (clk40Counter = 5 and offset_counter_saturated > E_markerOffsetMinusTwo) then
						E_markerOffsetMinusTwo 		<=	E_markerOffsetMinusTwo + 1;	
						errorLoopbackAlignment_sig 	<= '1';
					elsif (clk40Counter = 4 and offset_counter_saturated > E_markerOffsetPlusTwo) then
						E_markerOffsetPlusTwo 		<= E_markerOffsetPlusTwo + 1;   
						errorLoopbackAlignment_sig 	<= '1';
					elsif (clk40Counter = 3 and offset_counter_saturated > E_markerOffsetPlusOne) then
						E_markerOffsetPlusOne 		<= E_markerOffsetPlusOne + 1;	 	
						errorLoopbackAlignment_sig 	<= '1';	
					elsif (clk40Counter = 2 and offset_counter_saturated > E_markerOffsetCenter) then
						E_markerOffsetCenter		<= E_markerOffsetCenter + 1;	 	
					end if;
				end if;	 	 
				
			--(2E.2)EVENT MISALIGNMENT 
				if	(generateMarkerLatch = '0' and generateMarker = '1' and needAlignment = '0') then
					if (Counter_16 = 7-1 and offset_counter_saturated > markerOffsetMinusOne) then	
						markerOffsetMinusOne 	<= markerOffsetMinusOne + 1;	   
						errorEventAlignment_sig 	<= '1';			 
					elsif (Counter_16 = 7-2 and offset_counter_saturated > markerOffsetMinusTwo) then
						markerOffsetMinusTwo 	<=	markerOffsetMinusTwo + 1;	
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7-3 and offset_counter_saturated > markerOffsetMinusThree) then
						markerOffsetMinusThree 	<=	markerOffsetMinusThree + 1;	
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7-4 and offset_counter_saturated > markerOffsetMinusFour) then
						markerOffsetMinusFour 	<=	markerOffsetMinusFour + 1;	
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7-5 and offset_counter_saturated > markerOffsetMinusFive) then
						markerOffsetMinusFive 	<=	markerOffsetMinusFive + 1;	
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7-6 and offset_counter_saturated > markerOffsetMinusSix) then
						markerOffsetMinusSix 	<=	markerOffsetMinusSix + 1;	
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7-7 and offset_counter_saturated > markerOffsetMinusSeven) then
						markerOffsetMinusSeven 	<=	markerOffsetMinusSeven + 1;	
						errorEventAlignment_sig 	<= '1';				   
					elsif (Counter_16 = 7-0 and offset_counter_saturated > markerOffsetCenter) then
						markerOffsetCenter 		<= markerOffsetCenter + 1; 
						
					elsif (Counter_16 = 7+1 and offset_counter_saturated > markerOffsetPlusOne) then
						markerOffsetPlusOne 	<=	markerOffsetPlusOne + 1;	
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7+2 and offset_counter_saturated > markerOffsetPlusTwo) then
						markerOffsetPlusTwo 	<= markerOffsetPlusTwo + 1;
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7+3 and offset_counter_saturated > markerOffsetPlusThree) then
						markerOffsetPlusThree 	<= markerOffsetPlusThree + 1; 
						errorEventAlignment_sig 	<= '1';	   
					elsif (Counter_16 = 7+4 and offset_counter_saturated > markerOffsetPlusFour) then
						markerOffsetPlusFour 	<= markerOffsetPlusFour + 1; 
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7+5 and offset_counter_saturated > markerOffsetPlusFive) then
						markerOffsetPlusFive 	<= markerOffsetPlusFive + 1; 
						errorEventAlignment_sig 	<= '1';
					elsif (Counter_16 = 7+6 and offset_counter_saturated > markerOffsetPlusSix) then
						markerOffsetPlusSix 	<= markerOffsetPlusSix + 1; 
						errorEventAlignment_sig 	<= '1';		   				  
					elsif (Counter_16 = 7+7 and offset_counter_saturated > markerOffsetPlusSeven) then
						markerOffsetPlusSeven 	<= markerOffsetPlusSeven + 1; 
						errorEventAlignment_sig 	<= '1';		
					end if;	
				end if;	 
				
			
			end if;
						
			
		end if;
	end process;
	
	--------------------------------------------------------------------------------
	--		================(3) ERROR DETECTION ====================
			-----------------------------------------------------
	error_code_gen: process(EPCS_RXCLK)			
	begin	
		if (rising_edge(EPCS_RXCLK)) then
			if (RESET_N = '0') then			 
				error_counter		<= (OTHERS => '0');
				ERROR_CODE_FW		<= (OTHERS => '0'); 
				ERROR_FLAG_FW		<= '0';
			elsif (fd_errors /= errors_latch) then  				
				error_counter	    <= error_counter + 1;
				ERROR_FLAG_FW		<= '1';
				ERROR_CODE_FW		<= fd_status(7 downto 0) & fd_errors(7 downto 0);
			else
				if (error_flag_read	= '1') then
					ERROR_FLAG_FW	<= '0';
				end if;
			end if;
		end if;
	end process;
	
	--------------------------------------------------------------------------------
	--======================= (4) Roc Monitor Interface Gen =============
					-----------------------------------------------------		
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
																			 
				we <= extract_algo_we(ALGO_WDATA); -- get write enable		  
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
						
					--byte_flip <= '1';		  	 
					error_flag_read <= '1';
					disable_loop 	<= '0';	 	  		 
					rAddr 			<= (others => '1');  
					enable 			<= '1';		 
					rst_cnt 		   <= (others => '0');
					
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
								enable <= wData(4);
							elsif wAddr = 2 then
                        dummy_reg(ALGO_WDATA_WIDTH-1 downto 0) <= wData; 
							elsif wAddr = 3 then
                        --	disable_loop <= wData(0);		//If accidental write, one can never come out of it.		  
							end if;
							
						end if;	
						
						
						--Reads		
						algo_rdata_sig <= (others => '0');
						if (rAddr = 0) then			  		
							algo_rdata_sig <= fd_status;
						elsif (rAddr = 1) then			  		
							algo_rdata_sig <= fd_errors;
							error_flag_read<= '1';
						elsif (rAddr = 2) then
							algo_rdata_sig <= dummy_reg;		
						elsif (rAddr = 3) then	   
							algo_rdata_sig <= x"000" & std_logic_vector(packetType);   						
						elsif (rAddr > 4 and rAddr < 20) then --read data buffer
							algo_rdata_sig <= shRxReg(to_integer(rAddr)-5);	   						
						--elsif (rAddr = 5) then	  			   
							--algo_rdata_sig <= std_logic_vector(C_markerOffsetMinusOne(gAPB_DWIDTH-1 downto 0));
						--elsif (rAddr = 6) then	  
							--algo_rdata_sig <= std_logic_vector(C_markerOffsetCenter(gAPB_DWIDTH-1 downto 0)); 	
						--elsif (rAddr = 7) then	  
							--algo_rdata_sig <= std_logic_vector(C_markerOffsetPlusOne(gAPB_DWIDTH-1 downto 0));  
						--elsif (rAddr = 8) then	  			   
							--algo_rdata_sig <= std_logic_vector(E_markerOffsetMinusOne(gAPB_DWIDTH-1 downto 0));
						--elsif (rAddr = 9) then	  
							--algo_rdata_sig <= std_logic_vector(E_markerOffsetCenter(gAPB_DWIDTH-1 downto 0)); 	
						--elsif (rAddr = 10) then	  
							--algo_rdata_sig <= std_logic_vector(E_markerOffsetPlusOne(gAPB_DWIDTH-1 downto 0));
						--elsif (rAddr = 11) then	  			   
							--algo_rdata_sig <= std_logic_vector(L_markerOffsetMinusOne(gAPB_DWIDTH-1 downto 0));
						--elsif (rAddr = 12) then	  
							--algo_rdata_sig <= std_logic_vector(L_markerOffsetCenter(gAPB_DWIDTH-1 downto 0)); 	
						--elsif (rAddr = 13) then	  
							--algo_rdata_sig <= std_logic_vector(L_markerOffsetPlusOne(gAPB_DWIDTH-1 downto 0));
						elsif (rAddr = 20) then			  		
							algo_rdata_sig <= std_logic_vector(fwd_packet_count);	 		 
						elsif (rAddr = 21) then			  		
							algo_rdata_sig <= std_logic_vector(rcv_packet_count);	 		 
						elsif (rAddr = 22) then			  		
							algo_rdata_sig <= std_logic_vector(dcs_packet_count);		  		 
						elsif (rAddr = 23) then			  		
							algo_rdata_sig <= std_logic_vector(hb_packet_count);		  		 
						elsif (rAddr = 24) then			  		
							algo_rdata_sig <= std_logic_vector(data_packet_count);		  		 
						elsif (rAddr = 25) then			  		
							algo_rdata_sig <= std_logic_vector(any_header_count);   		 
						elsif (rAddr = 26) then			  		
							algo_rdata_sig <= std_logic_vector(fwd_fifo_full_count);	  		 
						elsif (rAddr = 27) then			  		
							algo_rdata_sig <= std_logic_vector(rcv_fifo_full_count);		  		 
						elsif (rAddr = 28) then			  		
							algo_rdata_sig <= std_logic_vector(rcv_seq_err_count);	--should normally be 1 after first packet received
						elsif (rAddr = 29) then			  		
							algo_rdata_sig <= std_logic_vector(clock_marker_count);
						elsif (rAddr = 30) then			  		
							algo_rdata_sig <= std_logic_vector(event_marker_count);
						elsif (rAddr = 31) then			  		
							algo_rdata_sig <= std_logic_vector(loopback_marker_count);
						elsif (rAddr = 32) then			  		
							algo_rdata_sig <= std_logic_vector(retr_marker_count);
						elsif (rAddr = 33) then			  		
							algo_rdata_sig <= std_logic_vector(timeout_marker_count);
						elsif (rAddr = 34) then
							algo_rdata_sig <= std_logic_vector(error_SingleMarker_count);		  		 
						elsif (rAddr = 35) then -- 0x23
							algo_rdata_sig <= std_logic_vector(error_DoubleMarker_count);		  		 
						else						
							algo_rdata_sig <= std_logic_vector(rAddr) & std_logic_vector(to_unsigned(ALGO_LOC_ADDR, gAPB_DWIDTH-ALGO_RADDR_WIDTH));
						end if;								 
						
					end if;	  
				end if;	   				
			end if;			
		end process;		 
	end generate;
	
end architecture;

