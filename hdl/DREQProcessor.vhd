--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DCSProcessor.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
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
    clk : in std_logic;
    
    dreq_rdcnt : in std_logic_vector(10 downto 0);
    dreq_fifo_in : in std_logic_vector(15 downto 0);
    dreq_fifo_re : out std_logic;
    
    dreq_fifo_out : out std_logic_vector(17 downto 0);
    dreq_fifo_we : out std_logic;
    
    crc_en : out std_logic;
    crc_rst : out std_logic;
    crc_data_out : out std_logic_vector(15 downto 0);
    crc_data_in : in std_logic_vector(15 downto 0);
		
	 -- Data Request	 (Request Side)		
	 DATAREQ_START_EVENT		: OUT STD_LOGIC;  														--gimme Event Window Flag	
	 DATAREQ_EVENT_WINDOW_TAG1	: OUT STD_LOGIC_VECTOR(EVENT_WINDOW_TAG_SIZE-1 downto 0);		--TAG 1 
	 DATAREQ_EVENT_WINDOW_TAG2	: OUT STD_LOGIC_VECTOR(EVENT_WINDOW_TAG_SIZE-1 downto 0);		--Optional		 
		
	 --Data Request (Reply Side) 	
	 DATAREQ_DATA_READY		: IN  STD_LOGIC;
	 DATAREQ_LAST_WORD		: IN  STD_LOGIC;			   
	 DATAREQ_STATUS			: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
	 DATAREQ_DATA				: IN  STD_LOGIC_VECTOR(DATAREQ_DWIDTH-1 downto 0);		   	--Data Reply
	 DATAREQ_PACKETS_IN_EVENT	: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
	 DATAREQ_RE_FIFO			: OUT STD_LOGIC; 
    
    dreq_state_count : out std_logic_vector(7 downto 0);
    dreq_error_count : out std_logic_vector(15 downto 0)
);
end DREQProcessor;
architecture architecture_DREQProcessor of DREQProcessor is

    type dreq_state_type is (IDLE, FIRSTREAD, SECONDREAD, CHECKCRC, DREQ, DBGDATA, DREQHDR, SENDHEADER, READDATA, SENDDATA, DONE, CALCULATECRC, WRITECRC);
    signal dreq_state      : dreq_state_type;
    signal counter : integer range 0 to 5;
    
    type packet   is array (9 downto 0) of std_logic_vector(15 downto 0);
    signal inbuffer : packet;
		
	 type shRxReg_t 	is array(natural range <>) of std_logic_vector(gENDEC_DWIDTH-1 downto 0);  
	 signal shRxReg_dataReq1	: shRxReg_t(3 downto 0);	
	 signal shRxReg_dataReq2	: shRxReg_t(3 downto 0);	
		
	 signal word_count 		: integer range 0 to 31;
    signal calculated_crc 	: std_logic_vector(15 downto 0);
    signal sequence_num 	: std_logic_vector(2 downto 0);
    signal read_crc 			: std_logic_vector(15 downto 0);
		
    signal link_id : std_logic_vector(2 downto 0);
	 signal reqEventWindowTag	: unsigned(6*8-1 downto 0);		--6 byte    --		* NOTE: assume "timestamp" tag does not wrap around
     
	 signal dgbDreq			: 	std_logic;
	 signal dbgDataPacketCnt: 	unsigned(10 downto 0);	
	 signal dbgDataType		: 	unsigned(3 downto 0);	
	 
	 signal dataReq_FIFOReadyState	: unsigned(1 downto 0);
	 signal dataReq_dataReady			: std_logic;
	 signal dataReqDataReadCnt			: unsigned(15 downto 0);
	 signal readTimeout					: unsigned(15 downto 0);
	 signal firstDone						: std_logic; 

begin

    -- DCS packet definition
    link_id 				<= inbuffer(2)(10 downto 8);
	 reqEventWindowTag 	<= unsigned(inbuffer(5)) & unsigned(inbuffer(4)) & unsigned(inbuffer(3));
	 dgbDreq					<= inbuffer(7)(0);							-- debug data mask: if 1, ROC sends data for debugging purposes
	 dbgDataType			<= unsigned(inbuffer(7)(7 downto 4));  -- 0x0 special sequence; 0x1 External serial data; 0x2 Same as 0x1 WITH initial FIFO reset
	 dbgDataPacketCnt		<= unsigned(inbuffer(8)(10 downto 0)); -- number of Debug Data packets
    read_crc 				<= inbuffer(9);
	 
	 sequence_num			<= "000";
    
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
		  DATAREQ_EVENT_WINDOW_TAG1	<= (others => '0');
		  DATAREQ_EVENT_WINDOW_TAG2	<= (others => '0');	
		  DATAREQ_RE_FIFO					<= '0';
		  
		  dataReq_dataReady 		<= '0';
		  readTimeout				<= (others => '0');
		  firstDone 				<= '0';
			
        word_count <= 0;
        dreq_error_count <= (others => '0');
        dreq_state_count <= (others => '0');
        
    elsif rising_edge(clk) then
        crc_en <= '0';
        crc_rst <= '1';
        dreq_fifo_re <= '0';
        dreq_fifo_we <= '0';
				
        case dreq_state is 
            when IDLE =>
                dreq_state_count <= X"01";
                if unsigned(dreq_rdcnt) > 9 then
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
                calculated_crc <= crc_data_in;
                if crc_data_in /= read_crc then
                    dreq_error_count <= std_logic_vector(unsigned(dreq_error_count) + 1);
                    dreq_state <= IDLE;
                else
                    dreq_state <= DREQ;
                end if;
                
            when DREQ =>
                dreq_state_count <= X"05";
					 dataReq_dataReady<= '0';
					 readTimeout		<= (others => '1');
                if dgbDreq = '1' then
                    dreq_state <= DBGDATA;   -- undefined Payload for now
                else
						  DATAREQ_START_EVENT		<= '1';			
						  DATAREQ_EVENT_WINDOW_TAG1<= std_logic_vector(reqEventWindowTag); 
						  DATAREQ_EVENT_WINDOW_TAG2<= std_logic_vector(reqEventWindowTag + 1);
                    dreq_state <= DREQHDR;
                end if;
                
            when DREQHDR =>
					 -- start building Data Header Packet in reply to DataRequest 
                dreq_state_count <= X"06";
					 DATAREQ_START_EVENT		<= '0';	  
					 dataReq_FIFOReadyState		<= (others => '0');		
						
					if (dataReq_dataReady = '0') then  	--  Wait for DATA Ready: ff timeout, drain!...To be defined
							
						if (DATAREQ_DATA_READY = '1') then
							dataReq_dataReady		<= '1';	
						else						   
							if (readTimeout = 0) then  
								--ch_state								<= S_Drain;	 
								--ch_errors(ERROR_ReadTimeout)	<= '1';
							end if;
						end if;									
						readTimeout		<= readTimeout - 1;
					else
						dreq_state <= SENDHEADER;
					end if;
					
            when SENDHEADER =>
                dreq_state_count <= X"0A";
                word_count <= word_count + 1;
                dreq_fifo_we <= '1';
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
                    dreq_fifo_out <= "00" & "10000" & link_id & X"50"; -- valid & reserved & roc_id & packet_type & hop_count
                    crc_data_out <= "10000" & link_id & X"50";
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 3 then
						  --dataReqDataReadCnt	<= to_unsigned(0,3) & unsigned(DATAREQ_PACKETS_IN_EVENT(11 DOWNTO 0)) & to_unsigned(0,1);	 --TWICE THE PACKET CNT. 
						  dataReqDataReadCnt	<= to_unsigned(0,4) & unsigned(DATAREQ_PACKETS_IN_EVENT(11 DOWNTO 0));	
                    dreq_fifo_out <= "00" & b"00000" & DATAREQ_PACKETS_IN_EVENT(10 downto 0); 	--Data Req packet count
                    crc_data_out <= b"00000" & DATAREQ_PACKETS_IN_EVENT(10 downto 0);
                    crc_rst <= '0';
                    crc_en <= '1';
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
                    dreq_fifo_out <= "00" & x"00" & DATAREQ_STATUS;  -- Data Packer Format Version (15:8) | Status (7:0)	
                    crc_data_out <= x"00" & DATAREQ_STATUS;
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 8 then
                    dreq_fifo_out <= (others => '0');	  -- Event Window Mode (15:11) | Subrub[10:9] On-spill FLAG | DTC ID (7:0)	
                    crc_data_out <= (others => '0');
                    crc_rst <= '0';
                    crc_en <= '1';
 						  dataReq_dataReady			<= '0';
						  dataReq_FIFOReadyState	<= (others => '0');			 
                    dreq_state <= CALCULATECRC;
                end if;
                
            when CALCULATECRC =>
                dreq_state_count <= X"0B";
                word_count <= 0;
                dreq_fifo_we <= '0';
                crc_rst <= '0';
                crc_en <= '1';
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
								shRxReg_dataReq1(1)	<= DATAREQ_DATA(31 downto 16);
								shRxReg_dataReq1(0)	<= DATAREQ_DATA(15 downto 0);
							else
								shRxReg_dataReq2(3)	<=	DATAREQ_DATA(63 downto 48);	   
								shRxReg_dataReq2(2)	<=	DATAREQ_DATA(47 downto 32);
								shRxReg_dataReq2(1)	<= DATAREQ_DATA(31 downto 16);
								shRxReg_dataReq2(0)	<= DATAREQ_DATA(15 downto 0);
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
                    dreq_state <= CALCULATECRC;
                end if;
					 
            when others =>
                dreq_state_count <= X"FF";
                
        end case;
    end if;
    end process;
    
end architecture_DREQProcessor;