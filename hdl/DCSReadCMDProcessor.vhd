--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DCSReadCMDProcessor.vhd
-- File history:
--      <v0>: <07/19/22>: first version: service DCS Single and Block commands to uProc
--      <v1>: <08/05/22>: joined READSPI and TESTDCSBLK in a single State machine
--      <v2>: <07/22/2023>: major cleanup and reorganization of state machines
--      <v3>: <08/21/2023>: rewrite GETCMID state, replacing check on ADDR_HOLD with check on BLOCK_START
--      <v4>: <02/17/2024>: changed name of STATE and STATE_COUNT
--                                                         
--
-- Description: 
--
-- <Description here>
--     Module to read DCS_TX_BUFFER (filed by processor in response to a DCS Write command)
--     and pass data to DCSProcessor to generate DCS single or BLK Read packet of relevant quantities.
--     NB: From version v2, address decoding is done in DCSProcessor.
--     
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: MT
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.algorithm_constants.all; 

entity DCSReadCMDProcessor is
port (
    DCS_CLK			: IN    std_logic;	-- 200 MHz recovered RX clock
    RESET_N 		: IN    std_logic;	
    
-- from DCSProcessor
	READ_CMD		: IN    std_logic;	-- DCS read decoded for uProc address space			
    ADDR_IN			: IN    std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
	BLOCK_START		: IN    std_logic;	-- pulse signaling start of a new packet in DCS BLOCK READ			
	FIRST_BLOCK     : IN    std_logic;	-- pulse signaling first block of a DCS BLOCK READ			
    BLK_READ_REQ    : IN    std_logic;
    PKT_DONE        : IN    std_logic;  --
    DCS_DONE        : IN    std_logic;  -- 
    IS_CMD_REG      : OUT   std_logic;  -- selects DATA_OUT and READY from uProc inside DCSProcessor  
    READY_REG 		: OUT   std_logic;	-- signlas that DTAT_OUT is ready to be read
    DATA_OUT        : OUT   std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 
       
-- from DCS_TX_BUFFER
    DCS_TX_RE       : OUT   std_logic;
    DCS_TX_WRCNT    : IN    std_logic_vector(10 DOWNTO 0);
    DCS_TX_DATA	    : IN    std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);

-- to ErrorCounter   
    dcsrd_state_count     : OUT   std_logic_vector(7 DOWNTO 0) 

);
end DCSReadCMDProcessor;

architecture architecture_DCSReadCMDProcessor of DCSReadCMDProcessor is

  -------------------------------------------------------------------------------
  -- Signal declarations
  -------------------------------------------------------------------------------
   type state_type is ( IDLE, WAITADDR, CHECKHEADER, GETSIZE, GETCMDID, 
                        GETDATA, READDATA, GETTRAILER, WAITDONE, READERROR,
                        STARTDATA, SENDREADY, WAITREQ, HOLD, WAITTRAILER, CHECKTRAILER);
    signal dcsrd_state          : state_type;
--    signal dcsrd_state_count  : std_logic_vector(7 DOWNTO 0); 

    
    signal word_dcspkt_cnt  : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
    signal word_dcspkt_max  : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
    
    signal payload_size     : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
    signal payload_in_cnt   : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
    signal payload_out_cnt  : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
   
begin

    -- architecture body
    -------------------------------------------------------------------------------
    -- Process DCS Read Commands to microProc
    -------------------------------------------------------------------------------
    process(RESET_N, DCS_CLK)
	begin
        if RESET_N = '0' then
         
            dcsrd_state       <= IDLE;
            dcsrd_state_count <= (others => '0');
            
            word_dcspkt_cnt <= (others => '0');
            word_dcspkt_max <= (others => '0');
            payload_in_cnt  <= (others => '0');
            payload_out_cnt <= (others => '0');
            payload_size    <= (others => '0');
            
            DCS_TX_RE   <= '0';
            READY_REG   <= '0'; 
            IS_CMD_REG  <= '0';
                        
        elsif rising_edge(DCS_CLK) then
                
            DCS_TX_RE   <= '0';
            READY_REG   <= '0'; 
                        
            case dcsrd_state is
                
            when IDLE => 
                dcsrd_state_count     <= X"01";
                IS_CMD_REG      <= '0';  
                payload_in_cnt  <= (others => '0');
                payload_out_cnt <= (others => '0');
                -- DCS_TX_BUFFER has reported data: 
                if  unsigned(DCS_TX_WRCNT) > X"0004"    then  
                    dcsrd_state <= WAITADDR;
                end if;
                
            --  wait for address to read
            when WAITADDR => 
                dcsrd_state_count     <= X"02";
                if  READ_CMD = '1'  then
                    DCS_TX_RE   <= '1';
                    dcsrd_state <= CHECKHEADER;
                end if;
                
            --check for header word
            when CHECKHEADER =>
                dcsrd_state_count <= X"03";
                if  DCS_TX_DATA = CMDHEADER   then
                    DCS_TX_RE   <= '1';
                    dcsrd_state <= GETSIZE;
                end if;
                
            -- get payload size
            when GETSIZE =>
                dcsrd_state_count <= X"04";
                if  DCS_TX_DATA /= CMDHEADER   then -- next word has come in...must be number of blocks
                    payload_size<= DCS_TX_DATA;     -- PAYLOAD SIZE contain number of words for the block read
                    DCS_TX_RE   <= '1';
                    dcsrd_state <= GETCMDID;
                end if;
                
            -- get payload size and start decoding DCS packet type using BLOCK_START
            when GETCMDID =>
                dcsrd_state_count <= X"05";
                if  DCS_TX_DATA(15 downto 12) = X"C"   then
                
                    IS_CMD_REG  <= '1';    -- default is high. Overwritten if unrecognized address
                        
                    payload_in_cnt <= std_logic_vector(unsigned(payload_in_cnt) + 1);
                    DCS_TX_RE   <= '1';
                    
                    if  unsigned(payload_size) = X"000" or unsigned(payload_size) > 1023   then 
                        dcsrd_state       <= READERROR;
                    else
                        if  BLOCK_START = '1'  then  
                            dcsrd_state   <= STARTDATA;
                        else
                            dcsrd_state   <= GETDATA;
                        end if;
                    end  if;
                    
                end if;
                
            -- get payload for single data read
            when GETDATA =>
                dcsrd_state_count <= X"06";
                DCS_TX_RE   <= '1';
                dcsrd_state <= READDATA;
                    
            -- read payload for single data read
            when READDATA =>
                dcsrd_state_count <= X"07";
                DCS_TX_RE   <= '1';
                DATA_OUT    <= DCS_TX_DATA;
                READY_REG   <= '1'; 
                dcsrd_state <= GETTRAILER;

                -- check for header word
            when GETTRAILER =>
                dcsrd_state_count <= X"08";
                READY_REG   <= '0'; 
                if  DCS_TX_DATA = CMDTRAILER   then
                    dcsrd_state <= WAITDONE;
                end if;
                    
            -- send last words and wait here until DCSProcessor is done dealing with this request
            when WAITDONE =>
                dcsrd_state_count   <= X"09";
                READY_REG       <= '0'; 
                if  DCS_DONE='1' then
                    dcsrd_state <= IDLE;
                end if;
                
            -- pass error word, skip trailer check and go to wait for DCS_DONE
            -- to be tested!!
            when READERROR =>
                dcsrd_state_count <= X"0A";
                DATA_OUT    <= ERROR_WRD;
                READY_REG   <= '1'; 
                dcsrd_state <= WAITDONE;
                
            -- start first data read: needed to generate READY so the DCSProcessor state machine can get going 
            -- use WORD_DCSPKT_CNT as the local counter of words in the packet (to be compared to WORD_DCSPKT_MAX)
            when STARTDATA =>
                dcsrd_state_count <= X"16";
                if  BLOCK_START = '1'  then  
                    word_dcspkt_cnt <= std_logic_vector(unsigned(word_dcspkt_cnt) + 1); -- counter of payload words in DCS packet
                    
                    if  payload_in_cnt < std_logic_vector(unsigned(payload_size))    then 
                        DCS_TX_RE   <= '1';
                        payload_in_cnt <= std_logic_vector(unsigned(payload_in_cnt) + 1);
                    end if;
                    
                    -- set maximum number of data request per packet to service
                    if  FIRST_BLOCK = '1' then
                        word_dcspkt_max <= X"0003";
                    else
                        word_dcspkt_max <= X"0008";
                    end if;
                    
                    dcsrd_state <= SENDREADY;
                end if;
                
            -- start passing data to DCSProcessor using SENDREADY <-> WAITREQ handshake:
            -- A) send ready (READY_REG) and pass word (DATA_OUT) from DCS_TX_BUFFER:
            -- B) wait for data request (BLK_READ_REQ) from DCSProcessor and read next word from DCS_TX_BUFFER
            --
            --  If last word payload word in DCS_TX_BUFFER has been reached, set DATA_OUT to zero.
            --
            --  If last word in DCS packet detected, go to HOLD and decide what to do next
            --
            -- use PAYLOAD_OUT_CNT to keep track of data words sent to DCSPROCESSOR
            when SENDREADY =>
                dcsrd_state_count <= X"17";
                READY_REG   <= '1';
                if  payload_out_cnt < std_logic_vector(unsigned(payload_size))    then
                    DATA_OUT<= DCS_TX_DATA; 
                    payload_out_cnt <= std_logic_vector(unsigned(payload_out_cnt) + 1);
                else                                
                    DATA_OUT<= X"0000"; 
                end if;
                        
                if  word_dcspkt_cnt = std_logic_vector(unsigned(word_dcspkt_max))    then
                    dcsrd_state   <= HOLD;
                else
                    dcsrd_state   <= WAITREQ;
                end if;
                        
            -- more data to come. Clear READY and go back in the SENDREADY loop        
            when WAITREQ =>
                dcsrd_state_count <= X"18";
                READY_REG   <= '0';
                if  BLK_READ_REQ = '1'  then
                    word_dcspkt_cnt     <= std_logic_vector(unsigned(word_dcspkt_cnt) + 1);
                    if  payload_in_cnt < std_logic_vector(unsigned(payload_size))    then 
                        DCS_TX_RE       <= '1';
                        payload_in_cnt  <= std_logic_vector(unsigned(payload_in_cnt) + 1);
                    end if;
                    dcsrd_state <= SENDREADY;
                end if;
                    
            -- wait here until DCSProcessor is done dealing with this request
            -- When DONE, empty DCS_TX_BUFFER of TRAILER word 
            when HOLD =>
                dcsrd_state_count <= X"19";
                READY_REG   <= '0';
                word_dcspkt_cnt    <= (others => '0');
                if  PKT_DONE = '1'  then        -- DCSProcessor requests another BLOCK RD packet 
                    dcsrd_state <= STARTDATA;
                elsif   DCS_DONE = '1'  then    -- DCSProcessor thinks BLOCK RD is done
                                                -- check if we have exhausted payload words and empty DCS_TX_BUFFER
                    if  payload_in_cnt = std_logic_vector(unsigned(payload_size))  then
                        DCS_TX_RE   <= '1';
                        dcsrd_state <= WAITTRAILER;
                    end if;
                end if;
                
            -- wait for remaining DCS_TX_BUFFER word to arrive
            when WAITTRAILER =>
                dcsrd_state_count <= X"1A";
                dcsrd_state   <= CHECKTRAILER;
                
            -- check for trailer word 
            when CHECKTRAILER =>
                dcsrd_state_count <= X"1B";
                if  DCS_TX_DATA = CMDTRAILER   then
                    --dcs_done_seen <= '1';
                    dcsrd_state   <= IDLE;
                end if;
                
            when others =>
                dcsrd_state_count <= X"FF";
            end case;
            
        end if;
    end process;
   
end architecture_DCSReadCMDProcessor;
