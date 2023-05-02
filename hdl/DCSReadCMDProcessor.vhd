--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DCSReadCMDProcessor.vhd
-- File history:
--      <Revision number>: <07/19/22>: first version: service DCS Single and Block commands to uProc
--      <Revision number>: <08/05/22>: joined READSPI and TESTDCSBLK in a single State machine
--      <Revision number>: <>: <Comments>
--
-- Description: 
--
-- <Description here>
--     Module to read DCS_TX_BUFFER (filed by processor in response to a DCS Write command)
--     and pass data to DCSProcessor to generate DCS single or BLK Read packet of relevant quantities.
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
-- from DCSProcessor
    DCS_CLK			: IN    std_logic;	-- 200 MHz recovered RX clock
	READ_CMD		: IN    std_logic;				
	BLOCK_START		: IN    std_logic;				
	FIRST_BLOCK     : IN    std_logic;				
    READY_REG 		: OUT   std_logic;	-- signal that requested data to READ is on DATA_OUT
    IS_CMD_REG      : OUT   std_logic;
    RESET_N 		: IN    std_logic;	
    ADDR_IN			: IN    std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
    BLOCK_WORD_IN	: IN    std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
    DATA_OUT        : OUT   std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 
    BLK_READ_REQ    : IN    std_logic;
    PKT_DONE        : IN    std_logic;
    DCS_DONE        : IN    std_logic;
       
-- from DCS_TX_BUFFER
    DCS_DIAG_DATA   : IN    std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 
    DCS_TX_RE       : OUT   std_logic;
    DCS_TX_WRCNT    : IN    std_logic_vector(7 DOWNTO 0);
    DCS_TX_DATA	    : IN    std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);

-- to ErrorCounter   
    state_count     : OUT   std_logic_vector(7 DOWNTO 0) 

);
end DCSReadCMDProcessor;

architecture architecture_DCSReadCMDProcessor of DCSReadCMDProcessor is

    -- DCS Commands to microprocessor (passed as DCS Write address)
	constant TESTDCSNGL : std_logic_vector(15 downto 0) := x"0100"; -- addr 256
	constant TESTDCSBLK : std_logic_vector(15 downto 0) := x"0101"; -- addr 257
	constant READSPI    : std_logic_vector(15 downto 0) := x"0102"; -- addr 258
	constant READBACKBLK: std_logic_vector(15 downto 0) := x"0103"; -- addr 259
	constant DIAGDATA   : std_logic_vector(15 downto 0) := x"0104"; -- addr 260

  -------------------------------------------------------------------------------
  -- Signal declarations
  -------------------------------------------------------------------------------
   type state_type is (IDLE, CHECKHEADER, GETSIZE, GETCMDID, GETDATA, CHECKTRAILER,
                        STARTDATA, WAITREQ, SENDREADY, CHECK, CHECKLAST, CHECKZERO,  
                        HOLD, DONE);
    signal state        : state_type;
--    signal state_count  : std_logic_vector(7 DOWNTO 0); 

    signal dcs_done_dly : std_logic;
    signal read_hold    : std_logic;
    signal addr_hold    : std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);
    
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
         
            state       <= IDLE;
            state_count <= (others => '0');
            
            word_dcspkt_cnt <= (others => '0');
            word_dcspkt_max <= (others => '0');
            payload_in_cnt  <= (others => '0');
            payload_out_cnt <= (others => '0');
            payload_size    <= (others => '0');
            
            DCS_TX_RE   <= '0';
            READY_REG   <= '0'; 
            IS_CMD_REG  <= '0';
            
            dcs_done_dly<= '0';
            read_hold   <= '0';
            addr_hold   <= (others => '0');
            
        elsif rising_edge(DCS_CLK) then
                
            DCS_TX_RE   <= '0';
            READY_REG   <= '0'; 
            
            -- register these signals until delayed version of DCS_DONE
            -- (or not enough time to clear DCS_TX_BUFFER)
            if (READ_CMD = '1') then
                read_hold   <= '1';
                addr_hold   <= ADDR_IN;
            --elsif (DCS_DONE = '1') then
            elsif (dcs_done_dly = '1') then
                read_hold   <= '0';
                addr_hold   <= (others => '0');
            end if;
             
             
            if (read_hold = '1') then
            
                IS_CMD_REG  <= '1';    -- default is high. Overwritten is unrecognized address
                
                if (addr_hold = TESTDCSNGL) then
                
                    case state is
                    
                    when IDLE => 
                        state_count <= X"10";
                        -- DCS_TX_BUFFER has reported data: 
                        if  unsigned(DCS_TX_WRCNT) > X"0004"    then  
                            DCS_TX_RE   <= '1';
                            state       <= CHECKHEADER;
                        end if;
                            
                    -- check for header word
                    when CHECKHEADER =>
                        state_count <= X"11";
                        if  DCS_TX_DATA = CMDHEADER   then
                            DCS_TX_RE   <= '1';
                            state       <= GETSIZE;
                        end if;
                        
                    -- get payload size
                    when GETSIZE =>
                        state_count <= X"12";
                        if  DCS_TX_DATA = X"0001"   then
                            DCS_TX_RE   <= '1';
                            state <= GETCMDID;
                       end if;
                            
                    -- get payload size
                    when GETCMDID =>
                        state_count <= X"13";
                        if  DCS_TX_DATA(15 downto 12) = X"C"   then
                            DCS_TX_RE   <= '1';
                            state <= GETDATA;
                        end if;
                            
                    -- get payload
                    when GETDATA =>
                        state_count <= X"14";
                        DCS_TX_RE   <= '1';
                        DATA_OUT    <= DCS_TX_DATA;
                        READY_REG   <= '1'; 
                        state   <= CHECKTRAILER;
                            
                    -- check for header word
                    when CHECKTRAILER =>
                        state_count <= X"15";
                        READY_REG   <= '0'; 
                        DCS_TX_RE   <= '0';
                        if  DCS_TX_DATA = CMDTRAILER   then
                            state <= HOLD;
                        end if;
                        
                    -- send last words and wait here until DCSProcessor is done dealing with this request
                    when HOLD =>
                        state_count <= X"16";
                        READY_REG   <= '0';
                        DCS_TX_RE   <= '0';
                        if  DCS_DONE='1' then
                            dcs_done_dly <= '1';
                            state   <= DONE;
                        end if;
                        
                    -- wait for READ_HOLD and ADDR_HOLD to clear
                    when DONE =>
                        state_count <= X"17";
                        dcs_done_dly<= '0';
                        state       <= IDLE;
                        
                    when others =>
                        state_count <= X"1F";
                    
                    end case;
                        
                        
                elsif ( addr_hold = TESTDCSBLK  or addr_hold = READSPI   or 
                        addr_hold = DIAGDATA    or addr_hold = READBACKBLK) then
                        
                    case state is
                        
                    when IDLE => 
                        state_count <= X"21";
                        payload_in_cnt <= (others => '0');
                        payload_out_cnt <= (others => '0');
                        -- DCS_TX_BUFFER has reported data: 
                        if  unsigned(DCS_TX_WRCNT) > X"0004"    then  
                            DCS_TX_RE   <= '1';
                            state <= CHECKHEADER;
                        end if;
                        
                    -- check for header word
                    when CHECKHEADER =>
                        state_count <= X"22";
                        if  DCS_TX_DATA = CMDHEADER   then
                            DCS_TX_RE   <= '1';
                            state <= GETSIZE;
                        end if;
                        
                    -- get payload size
                    when GETSIZE =>
                        state_count <= X"23";
                        if  DCS_TX_DATA /= CMDHEADER   then -- next word has come in...must be number of blocks
                            payload_size<= DCS_TX_DATA;  -- PAYLOAD SIZE contain number of words for the block read
                            DCS_TX_RE   <= '1';
                            state <= GETCMDID;
                        end if;
                        
                    -- get commandID word and send DCS_TX_RE for first data
                    -- use PAYLOAD_IN_CNT to keep track of DCS_TX_RE requests for payload words 
                    when GETCMDID =>
                        state_count <= X"24";
                        if  DCS_TX_DATA(15 downto 12) = X"C"   then
                            if  payload_in_cnt < std_logic_vector(unsigned(payload_size))    then 
                                DCS_TX_RE   <= '1';
                                payload_in_cnt <= std_logic_vector(unsigned(payload_in_cnt) + 1);
                            end if;
                            state <= STARTDATA;
                        end if;
                        
                    -- start first data read: needed to generate READY so the DCSProcessor state machine can get going 
                    -- use WORD_DCSPKT_CNT as the local counter of words in the packet (to be compared to WORD_DCSPKT_MAX)
                    when STARTDATA =>
                        state_count <= X"25";
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
                            
                            state <= SENDREADY;
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
                        state_count <= X"26";
                        READY_REG   <= '1';
                        if  payload_out_cnt < std_logic_vector(unsigned(payload_size))    then
                            DATA_OUT    <= DCS_TX_DATA; 
                            payload_out_cnt <= std_logic_vector(unsigned(payload_out_cnt) + 1);
                        else                                
                            DATA_OUT    <= X"0000"; 
                        end if;
                        
                        if  word_dcspkt_cnt = std_logic_vector(unsigned(word_dcspkt_max))    then
                            state       <= HOLD;
                        else
                            state       <= WAITREQ;
                        end if;
                        
                    
                    when WAITREQ =>
                        state_count <= X"27";
                        READY_REG   <= '0';
                        if  BLK_READ_REQ = '1'  then
                            word_dcspkt_cnt    <= std_logic_vector(unsigned(word_dcspkt_cnt) + 1);
                            if  payload_in_cnt < std_logic_vector(unsigned(payload_size))    then 
                                DCS_TX_RE   <= '1';
                                payload_in_cnt <= std_logic_vector(unsigned(payload_in_cnt) + 1);
                            end if;
                            state       <= SENDREADY;
                        end if;
                    
                    -- wait here until DCSProcessor is done dealing with this request
                    -- When DONE, empty DCS_TX_BUFFER of TRAILER word 
                    when HOLD =>
                        state_count <= X"28";
                        READY_REG   <= '0';
                        word_dcspkt_cnt    <= (others => '0');
                        if  PKT_DONE = '1'  then        -- DCSProcessor requests another BLOCK RD packet 
                            state <= STARTDATA;
                        elsif  DCS_DONE = '1'   then    -- DCSProcessor thinks BLOCK RD is done
                                                        -- check if we have exhausted payload words to start emptying DCS_TX_BUFFER
                            if  payload_in_cnt = std_logic_vector(unsigned(payload_size))  then
                                DCS_TX_RE   <= '1';
                                state <= CHECK;
                            end if;
                        end if;
                        
                    -- wait for remaining DCS_TX_BUFFER word to arrive
                    when CHECK =>
                        state_count <= X"29";
                        DCS_TX_RE   <= '1';
                        state   <= CHECKTRAILER;
                            
                    -- check for LSB 16-bit of trailer word (0XFFEE_FFEE)
                    when CHECKTRAILER =>
                        state_count <= X"2A";
                        DCS_TX_RE   <= '0';
                        if  DCS_TX_DATA = CMDTRAILER   then
                            dcs_done_dly <= '1';
                            state   <= DONE;
                        end if;
                            
                    -- wait for READ_HOLD and ADDR_HOLD to clear
                    when DONE =>
                        state_count <= X"2B";
                        dcs_done_dly<= '0';
                        state       <= IDLE;
                        
                    
                    when others =>
                        state_count <= X"2F";
                        
                    end case;
                        
                        
                else
                    DATA_OUT    <= ADDR_IN;		  --Unmapped Addresses
                    IS_CMD_REG  <= '0';           -- unrecognized DCS command register
                end if;        
            else
                IS_CMD_REG  <= '0';     
            end if;
        end if;
    end process;
   
end architecture_DCSReadCMDProcessor;
