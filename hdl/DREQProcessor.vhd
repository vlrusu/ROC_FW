--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DREQProcessor.vhd
-- File history:
--      <v1>: <2021>: Decode Data Request only and generate Data Reply packet
--      <v2>: <02/2022>: Add Prefetch decoding and drive new FETCH/FETCH_EVENT_WINDOW_TAG outputs, with logic to give priority to Prefetch data over Data Request packet, if present
--      <v3>: <07/2023>: Add FORMAT_VRS to data header for Packet Format Version and drive with DRACRegister address 29
--      <v4>: <02/2024>: MT Add timeout for automatic State Machine reset when garbage data comes in during DTC Flashing or DTC Reset
--      <v5>: <07/2024>: MT Add DATAREQ_PACKETS_OVFL and DATAREQ_TAG_ERROR as Data Header status bit (4) and (5), respectively 
--      <v6>: <10/2024>: MT Add EMPTY_EVENT flag and DTC header/data packet counters
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
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 

library work;
use work.algorithm_constants.all; 

entity DREQProcessor is
port (
    reset_n : in std_logic;
    clk  : in std_logic;

    reset_dreq_logic : out std_logic;
    
    dreq_rdcnt : in std_logic_vector(10 downto 0);
    dreq_fifo_in : in std_logic_vector(15 downto 0);
    dreq_fifo_re : out std_logic;
    
    dreq_fifo_out : out std_logic_vector(17 downto 0);
    dreq_fifo_we : out std_logic;
    
    crc_en : out std_logic;
    crc_rst : out std_logic;
    crc_data_out : out std_logic_vector(15 downto 0);
    crc_data_in : in std_logic_vector(15 downto 0);
		
    FETCH_START             : OUT STD_LOGIC;           -- start fetching event from DREQ_FIFO	
    FETCH_EVENT_WINDOW_TAG  : OUT STD_LOGIC_VECTOR(EVENT_WINDOW_TAG_SIZE-1 downto 0);	-- EWT for event to FETCH 
      
    -- Data Request	 (Request Side)		
    DATAREQ_START_EVENT		: OUT STD_LOGIC;  												    --gimme Event Window Flag	
    DATAREQ_EVENT_WINDOW_TAG	: OUT STD_LOGIC_VECTOR(EVENT_WINDOW_TAG_SIZE-1 downto 0);		--TAG 1 
		
    --Data Request (Reply Side) 	
    DATAREQ_DATA_READY		: IN  STD_LOGIC;
    DATAREQ_LAST_WORD		: IN  STD_LOGIC;			   
    DATAREQ_FORMAT_VRS	    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    DATAREQ_STATUS			: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    DATAREQ_DATA			: IN  STD_LOGIC_VECTOR(DATAREQ_DWIDTH-1 downto 0);		   	--Data Reply
    DATAREQ_PACKETS_IN_EVT  : IN  STD_LOGIC_VECTOR(EVENT_SIZE_BITS-1 DOWNTO 0);
    DATAREQ_PACKETS_OVFL    : IN  STD_LOGIC;
    DATAREQ_TAG_ERROR       : IN  STD_LOGIC;
    DATAREQ_RE_FIFO			: OUT STD_LOGIC; 
    
    -- debug signals
    dreq_pkt_count      : out std_logic_vector(15 downto 0);
    dreq_hdr_pkt_count  : out std_logic_vector(15 downto 0);
    dreq_data_pkt_count : out std_logic_vector(15 downto 0);
    dreq_empty_pkt_count: out std_logic_vector(15 downto 0);
    
    dreq_timeout_count  : out std_logic_vector(15 downto 0);
    dreq_state_count    : out std_logic_vector(7 downto 0);
    dreq_error_count    : out std_logic_vector(15 downto 0);
    reqType_debug       : out std_logic_vector(3 downto 0);
    reqEventWindowTag_debug     : out std_logic_vector(EVENT_WINDOW_TAG_SIZE-1 downto 0);
    fetchEventWindowTag_debug   : out std_logic_vector(EVENT_WINDOW_TAG_SIZE-1 downto 0)
    
);
end DREQProcessor;

architecture architecture_DREQProcessor of DREQProcessor is

    type dreq_state_type is (IDLE, FIRSTREAD, SECONDREAD, CHECKCRC, DREQ, DBGDATA, DREQHDR, SENDHEADER, READDATA, SENDDATA, DONE, CALCULATECRC, WRITECRC, FLUSHFIFO);
    signal dreq_state      : dreq_state_type;
    
    type   packet   is array (9 downto 0) of std_logic_vector(15 downto 0);
    signal inbuffer : packet;
		
    type shRxReg_t 	is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
    signal shRxReg_dataReq1	: shRxReg_t(3 downto 0);	
    signal shRxReg_dataReq2	: shRxReg_t(3 downto 0);	
		
    signal word_count 		: integer range 0 to 31;
    signal counter          : integer range 0 to 5;
    signal calculated_crc 	: std_logic_vector(15 downto 0);
    signal sequence_num 	: std_logic_vector(2 downto 0);
    signal read_crc 		: std_logic_vector(15 downto 0);
		
    signal link_id : std_logic_vector(2 downto 0);
    signal reqType : unsigned(3 downto 0);
    signal reqEventWindowTag: unsigned(6*8-1 downto 0);		--6 byte    --		* NOTE: assume "timestamp" tag does not wrap around
     
    -- DEBUG PACKET is now driven by EVT_MODE
    --signal dgbDreq			: 	std_logic;
    --signal dbgDataPacketCnt : 	unsigned(10 downto 0);	
    --signal dbgDataType		: 	unsigned(3 downto 0);	
	 
    signal dataReq_FIFOReadyState	: unsigned(1 downto 0);
    signal dataReq_dataReady		: std_logic;
    signal dataReqDataReadCnt		: unsigned(15 downto 0);
    signal dataReqStatus            : std_logic_vector(7 downto 0);                 -- hold status to pass to DATA HEADER packet
    signal dataReqPktCnt            : std_logic_vector(EVENT_SIZE_BITS-2 DOWNTO 0); -- hold packet count to pass to DATA HEADER packet
    signal dataReqPktOvfl           : std_logic;
    signal dataReqTagErr            : std_logic;
    signal firstDone				: std_logic; 
    
    -- debug signals for ILA
    signal mark_dreq_pkt_long       : std_logic;
    signal mark_dreq_pkt_error      : std_logic;
    signal mark_window_tag_error    : std_logic; 
    signal mark_window_tag_unknown  : std_logic;
    signal mark_dreq_timeout        : std_logic;  
    
    signal  empty_event             : std_logic;

    signal dreqTimeout  : unsigned(13 downto 0);        -- allow a 16383 x 12.5 ns = 205 us timeout
    signal readTimeout	: unsigned(13 downto 0);
    
begin

    -- DCS packet definition
    reqType 			<= unsigned(inbuffer(2)(7 downto 4));
    link_id 			<= inbuffer(2)(10 downto 8);
    reqEventWindowTag 	<= unsigned(inbuffer(5)) & unsigned(inbuffer(4)) & unsigned(inbuffer(3));
    --dgbDreq				<= inbuffer(7)(0);					-- debug data mask: if 1, ROC sends data for debugging purposes
    --dbgDataType			<= unsigned(inbuffer(7)(7 downto 4));  -- 0x0 special sequence; 0x1 External serial data; 0x2 Same as 0x1 WITH initial FIFO reset
    --dbgDataPacketCnt	<= unsigned(inbuffer(8)(10 downto 0)); -- number of Debug Data packets
    read_crc 			<= inbuffer(9);
	 
    sequence_num		<= "000";
    
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        crc_en <= '0';
        crc_rst <= '1';
        crc_data_out <= (others => '0');
        dreq_state <= IDLE;
        dreq_fifo_re <= '0';
        dreq_fifo_we <= '0';
        dreq_fifo_out <= (others => '0');
			
        inbuffer(0) <= (others => '0');
        inbuffer(1) <= (others => '0');
        inbuffer(2) <= (others => '0');
        inbuffer(3) <= (others => '0');
        inbuffer(4) <= (others => '0');
        inbuffer(5) <= (others => '0');
        inbuffer(6) <= (others => '0');
        inbuffer(7) <= (others => '0');
        inbuffer(8) <= (others => '0');
        inbuffer(9) <= (others => '0');
        
        DATAREQ_START_EVENT			<= '0';	
        DATAREQ_EVENT_WINDOW_TAG 	<= (others => '0');
        DATAREQ_RE_FIFO				<= '0';
        
        FETCH_START             <= '0';
        FETCH_EVENT_WINDOW_TAG 	<= (others => '0');
        
        dataReqStatus       <= (others => '0'); 
        dataReqPktCnt       <= (others => '0'); 
        dataReqDataReadCnt  <= (others => '0'); 
        dataReqPktOvfl      <= '0';
        dataReqTagErr       <= '0';
        
        dataReq_dataReady 		<= '0';
        firstDone 				<= '0';
        word_count <= 0;
        dreq_timeout_count  <= (others => '0');
        dreq_error_count    <= (others => '0');
        dreq_state_count    <= (others => '0');
        
        mark_dreq_pkt_long  <= '0';
        mark_dreq_pkt_error <= '0';
        mark_window_tag_error   <= '0';
        mark_window_tag_unknown <= '0';
        mark_dreq_timeout   <= '0';
        
        readTimeout		<= (others => '1');
        dreqTimeout     <= (others => '1');
        reset_dreq_logic<= '0';
        
        reqType_debug               <= (others => '0');
        reqEventWindowTag_debug     <= (others => '0');
        fetchEventWindowTag_debug   <= (others => '0');
        
        dreq_pkt_count      <= (others => '0');
        dreq_hdr_pkt_count  <= (others => '0');
        dreq_data_pkt_count <= (others => '0');
        dreq_empty_pkt_count<= (others => '0');
        empty_event         <= '0';
         
    elsif rising_edge(clk) then
        crc_en <= '0';
        crc_rst <= '1';
        dreq_fifo_re <= '0';
        dreq_fifo_we <= '0';
        FETCH_START  <= '0';
            
				
        if  unsigned(dreq_rdcnt) > 10 then
            mark_dreq_pkt_long  <= '1';
        end if;
        
        case dreq_state is 
            when IDLE =>
                dreq_state_count <= X"01";
                
                mark_window_tag_unknown <= '0';
                mark_window_tag_error   <= '0';
                mark_dreq_timeout       <= '0';
                readTimeout		        <= (others => '1');
                
                dataReqStatus   <= DATAREQ_STATUS;
                if unsigned(dreq_rdcnt) > 0 then
                    dreqTimeout	<= dreqTimeout - 1;  
                    if      dreqTimeout =  1     then    reset_dreq_logic <= '1'; 
                    elsif   dreqTimeout =  0     then    reset_dreq_logic <= '0';  end if;
                end if;
                if unsigned(dreq_rdcnt) > 9 then
                    dreqTimeout	<= (others => '1');
                    dreq_fifo_re <= '1';
                    dreq_state <= FIRSTREAD;
                end if;
            
            when FIRSTREAD =>
                dreq_state_count <= X"02";
                dreq_fifo_re <= '1';
                word_count <= 0;
                dreq_state <= SECONDREAD;
                
            when SECONDREAD =>
                dreq_state_count <= X"03";
                dreq_fifo_re <= '1';
                inbuffer(word_count) <= dreq_fifo_in;
                crc_data_out <= dreq_fifo_in;
                word_count <= word_count + 1;
                if word_count = 0 then
                    crc_rst <= '0';
                    crc_en <= '0';
                elsif word_count > 0 then
                    crc_rst <= '0';
                    crc_en <= '1';
                end if;
                if word_count = 8 then
                    dreq_fifo_re <= '0';
                end if;
                if word_count = 9 then
                    dreq_fifo_re <= '0';
                    dreq_state <= CHECKCRC;
                end if;
                
            when CHECKCRC =>
                dreq_state_count <= X"04";
                word_count <= 0;
                
                -- signals for ILA triggering: skip first DREQ after reset
                if  (reqEventWindowTag <= unsigned(FETCH_EVENT_WINDOW_TAG) and unsigned(FETCH_EVENT_WINDOW_TAG) > 0)  then   mark_window_tag_error <= '1';  end if;
                
                if  unsigned(dreq_rdcnt) > 0 then   mark_dreq_pkt_error <= '1';  end if;
                
                ---- drive FETCH signals to DDRInterface/EW_SIZE_STORE_AND_FETCH_CONTROLLER
                ---- Recognize PREFETCH and skip following DATA REQUEST                
                -- DO THIS ONLY AFTER CRC ERROR DETECTION
                calculated_crc <= crc_data_in;
                if (crc_data_in /= read_crc) then
                    dreq_error_count <= std_logic_vector(unsigned(dreq_error_count) + 1);
                    dreq_state <= FLUSHFIFO;
                else
                    if (reqType = X"03") then
                        FETCH_START <= '1';
                        FETCH_EVENT_WINDOW_TAG  <= std_logic_vector(reqEventWindowTag); 
                        dreq_state <= IDLE;
                    -- skip this check for now or we need to force zeroing of FETCH_EVENT_WINDOW_TAG at start of NEWRUN... 
                    --elsif (reqType = X"02" and (reqEventWindowTag = X"000000000000" or reqEventWindowTag > unsigned(FETCH_EVENT_WINDOW_TAG)) ) then
                    elsif (reqType = X"02") then
                        FETCH_START <= '1';
                        FETCH_EVENT_WINDOW_TAG  <= std_logic_vector(reqEventWindowTag); 
                        dreq_state <= DREQ;
                    else -- catch-all condition for "unusual" EW Timestamps: send back a data packet header with Status bit(7) 
                        reqType_debug   <= std_logic_vector(reqType);
                        reqEventWindowTag_debug     <= std_logic_vector(reqEventWindowTag);
                        fetchEventWindowTag_debug   <= std_logic_vector(FETCH_EVENT_WINDOW_TAG);
                        mark_window_tag_unknown <= '1';
                        
                        dataReqStatus(7)    <= '1';
                        dataReqDataReadCnt  <= (others => '0');
                        dataReqPktCnt       <= (others => '0');
                        dreq_state <= SENDHEADER;
                    end if;
                end if;
                
            when DREQ =>
                dreq_state_count <= X"05";
                dataReq_dataReady<= '0';
                    
                DATAREQ_START_EVENT		<= '1';			
                DATAREQ_EVENT_WINDOW_TAG <= std_logic_vector(reqEventWindowTag); 
                dreq_state <= DREQHDR;
                
            when DREQHDR =>
                -- start building Data Header Packet in reply to DataRequest 
                dreq_state_count <= X"06";
                
                readTimeout		<= readTimeout - 1;
                DATAREQ_START_EVENT		<= '0';	  
                dataReq_FIFOReadyState	<= (others => '0');	
						
                if (dataReq_dataReady = '0') then  	--  Wait for DATA Ready: if timeout, drain!...To be defined
							
                    if (DATAREQ_DATA_READY = '1') then
                        dataReq_dataReady	<= '1';	
                    else -- send back a data packet header with Status bit(3) 
                        if (readTimeout = 0) then  
                            mark_dreq_timeout   <= '1';
                            dreq_timeout_count  <= std_logic_vector(unsigned(dreq_timeout_count) + 1);
                            
                            dataReqStatus(3)    <= '1';
                            dataReqDataReadCnt  <= (others => '0');
                            dataReqPktCnt       <= (others => '0');
                            dreq_state <= SENDHEADER;
                        end if;
                    end if;
                    
                else
                    dataReqPktOvfl      <= DATAREQ_PACKETS_OVFL;
                    dataReqTagErr       <= DATAREQ_TAG_ERROR;
                    dataReqDataReadCnt  <= to_unsigned(0,16-EVENT_SIZE_BITS+1) & unsigned(DATAREQ_PACKETS_IN_EVT(EVENT_SIZE_BITS-1 downto 1));
                    dataReqPktCnt       <= DATAREQ_PACKETS_IN_EVT(EVENT_SIZE_BITS-1 downto 1);	
                    dreq_state          <= SENDHEADER;
                end if;
					
            when SENDHEADER =>
                dreq_state_count <= X"0A";
                word_count <= word_count + 1;
                dreq_fifo_we <= '1';
                
                if  (dataReqDataReadCnt = 0) then
                    dataReqStatus(0) <= '0';  
                else
                    dataReqStatus(0) <= '1';
                end if;
                if  (dataReqPktOvfl = '1') then
                    dataReqStatus(4) <= '1';  
                end if;
                if  (dataReqTagErr = '1') then
                    dataReqStatus(5) <= '1';  
                end if;
                
                
                if word_count = 0 then
                    dreq_fifo_out <= "10" & X"1C" & sequence_num & "0" & X"5";  -- k28.0 & D4.y
                    crc_rst <= '0';
                    crc_en <= '0';
                elsif word_count = 1 then
                    dreq_fifo_out <= (others => '0'); -- DMA bytes
                    crc_data_out <= (others => '0');
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 2 then
                    dreq_fifo_out <= "00" & b"10000" & link_id & X"50"; -- valid & reserved & roc_id & packet_type & hop_count
                    crc_data_out <= "10000" & link_id & X"50";
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 3 then
                    -- this is all in units of DTC packets 
                    dreq_fifo_out <= "00" & b"0000000" & dataReqPktCnt; 
                    crc_data_out <= b"0000000" & dataReqPktCnt;
                    crc_rst <= '0';
                    crc_en <= '1';
                    if  dataReqPktCnt = B"0_0000_0000"   then    
                        empty_event <= '1';
                        dreq_empty_pkt_count  <= std_logic_vector(unsigned(dreq_empty_pkt_count) + 1);
                    end if;
                elsif word_count = 4 then 		
                    dreq_fifo_out <= "00" & inbuffer(3);		--timestamp[15:0]
                    crc_data_out <= inbuffer(3);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 5 then
                    dreq_fifo_out <= "00" & inbuffer(4);		--timestamp[31:16]
                    crc_data_out <= inbuffer(4);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 6 then
                    dreq_fifo_out <= "00" & inbuffer(5);		--timestamp[47:32]
                    crc_data_out <= inbuffer(5);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 7 then
                    dreq_fifo_out <= "00" & DATAREQ_FORMAT_VRS & dataReqStatus;  -- Data Packer Format Version (15:8) | Status (7:0)	
                    crc_data_out <= DATAREQ_FORMAT_VRS & dataReqStatus;
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 8 then
                    dreq_fifo_out <= (others => '0');	  -- Event Window Mode (15:11) | Subrub[10:9] On-spill FLAG | DTC ID (7:0)	
                    crc_data_out <= (others => '0');
                    crc_rst <= '0';
                    crc_en <= '1';
                    dataReq_dataReady			<= '0';
                    dataReq_FIFOReadyState	<= (others => '0');	
                    dreq_hdr_pkt_count  <= std_logic_vector(unsigned(dreq_hdr_pkt_count) + 1); 
                    empty_event         <= '0';
                    dreq_state <= CALCULATECRC;
                end if;
                
            when CALCULATECRC =>
                dreq_state_count <= X"0B";
                word_count <= 0;
                dreq_fifo_we <= '0';
                crc_rst <= '0';
                crc_en <= '1';
                dreq_pkt_count  <= std_logic_vector(unsigned(dreq_pkt_count) + 1); 
                dreq_state <= WRITECRC;
                
            when WRITECRC =>
                dreq_state_count <= X"0C";
                dreq_fifo_we <= '1';
                dreq_fifo_out <= "00" & crc_data_in;
                --sequence_num <= std_logic_vector(unsigned(sequence_num) + 1);
                    if ((DATAREQ_DATA_READY = '1' and dataReqDataReadCnt > 0) ) then
                        dreq_state <= READDATA;
                    else
                        dreq_state <= IDLE;
                    end if; 
						
            when READDATA =>      --Wait and Receive Data	
                dreq_state_count <= X"0D";
                word_count <= 0;
                    DATAREQ_RE_FIFO	<= '0';	 
						
                    if (dataReq_dataReady = '0') then 					 
						if (dataReq_FIFOReadyState = 0) then  
							dataReq_FIFOReadyState		<= to_unsigned(1,2); 
							DATAREQ_RE_FIFO				<= '1';	 
						elsif(dataReq_FIFOReadyState = 1) then
							dataReq_FIFOReadyState		<= to_unsigned(2,2);
						elsif (dataReq_FIFOReadyState = 2) then	
							dataReq_FIFOReadyState		<= to_unsigned(0,2);
							if (firstDone = '0') then
								shRxReg_dataReq1(3)	<=	DATAREQ_DATA(63 downto 48);	   
								shRxReg_dataReq1(2)	<=	DATAREQ_DATA(47 downto 32);
								shRxReg_dataReq1(1)	<=  DATAREQ_DATA(31 downto 16);
								shRxReg_dataReq1(0)	<=  DATAREQ_DATA(15 downto 0);
							else
								shRxReg_dataReq2(3)	<=	DATAREQ_DATA(63 downto 48);	   
								shRxReg_dataReq2(2)	<=	DATAREQ_DATA(47 downto 32);
								shRxReg_dataReq2(1)	<=  DATAREQ_DATA(31 downto 16);
								shRxReg_dataReq2(0)	<=  DATAREQ_DATA(15 downto 0);
							end if;
							dataReq_dataReady				<= '1';	
						end if;
                    else
						if (firstDone = '0') then
							firstDone	<= '1';
							dataReq_dataReady				<= '0';	
						else
							dataReq_dataReady				<= '0';	
							dreq_state <= SENDDATA;
						end if;
                    end if;
					 
            when SENDDATA =>  -- Send Payload Packet	
                dreq_state_count <= X"0E";
                firstDone	<= '0';
                word_count <= word_count + 1;
                dreq_fifo_we <= '1';
                if word_count = 0 then
                    dreq_fifo_out <= "10" & X"1C" & sequence_num & "0" & X"6";  -- k28.0 & D4.y
                    crc_rst <= '0';
                    crc_en <= '0';
                elsif word_count = 1 then
                    dreq_fifo_out <= "00" & shRxReg_dataReq1(0);
                    crc_data_out <= shRxReg_dataReq1(0);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 2 then
                    dreq_fifo_out <= "00" & shRxReg_dataReq1(1);
                    crc_data_out <= shRxReg_dataReq1(1);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 3 then
                   dreq_fifo_out <= "00" & shRxReg_dataReq1(2);
                    crc_data_out <= shRxReg_dataReq1(2);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 4 then 		
                   dreq_fifo_out <= "00" & shRxReg_dataReq1(3);
                    crc_data_out <= shRxReg_dataReq1(3);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 5 then
                    dreq_fifo_out <= "00" & shRxReg_dataReq2(0);
                    crc_data_out <= shRxReg_dataReq2(0);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 6 then
                   dreq_fifo_out <= "00" & shRxReg_dataReq2(1);
                    crc_data_out <= shRxReg_dataReq2(1);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 7 then
                   dreq_fifo_out <= "00" & shRxReg_dataReq2(2);
                    crc_data_out <= shRxReg_dataReq2(2);
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 8 then
                   dreq_fifo_out <= "00" & shRxReg_dataReq2(3);
                    crc_data_out <= shRxReg_dataReq2(3);
                    crc_rst <= '0';
                    crc_en <= '1';
                    dataReq_dataReady			<= '0';
                    dataReq_FIFOReadyState	<= (others => '0');
                    dataReqDataReadCnt	<= dataReqDataReadCnt - 1;	
                    dreq_data_pkt_count  <= std_logic_vector(unsigned(dreq_data_pkt_count) + 1);   
                    dreq_state <= CALCULATECRC;
                end if;
					 
            when FLUSHFIFO =>  -- Make sure nothing is left in RXPacketFIFO before continuing	
                dreq_state_count <= X"0F";
                if unsigned(dreq_rdcnt) > 0 then
                    dreq_fifo_re <= '1';
                else                
                    dreq_state <= IDLE;
                end if;
                
            when others =>
                dreq_state_count <= X"FF";
                
        end case;
    end if;
    end process;
    
end architecture_DREQProcessor;
