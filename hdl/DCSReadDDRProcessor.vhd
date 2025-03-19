--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DCSReadDDRProcessor.vhd
-- File history:
--      <v0>: <003/03/25>: first version
--                                                         
--
-- Description: 
--
-- <Description here>
--     Module to read DDR1KB_FIFO, filled with 1 kB (512x16b) block to DDR memory in response to MEM_READ command.
--     Based on DRCReadCMDProcessor to pass data to DCSProcessor. 
--     It knows to fill 512/8 = 64 payload packets in response to Block Read, with last 3 words of last packets equal to zero.
--     NB: Address decoding (257 or 0x201) is done in DCSProcessor.
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

entity DCSReadDDRProcessor is
port (
    DCS_CLK			: IN    std_logic;	-- 200 MHz recovered RX clock
    RESET_N 		: IN    std_logic;	
    
-- from DCSProcessor
	READ_CMD		: IN    std_logic;	-- DCS read decoded for 0x201 address			
    BLOCK_SIZE		: IN    std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);		
    BLOCK_START		: IN    std_logic;	-- pulse signaling start of a new packet in DCS BLOCK READ			
	FIRST_BLOCK     : IN    std_logic;	-- pulse signaling first block of a DCS BLOCK READ			
    BLK_READ_REQ    : IN    std_logic;
    PKT_DONE        : IN    std_logic;  --
    DCS_DONE        : IN    std_logic;  -- 
    IS_DDR_REG      : OUT   std_logic;  -- selects DATA_OUT and READY from uProc inside DCSProcessor  
    READY_REG 		: OUT   std_logic;	-- signlas that DTAT_OUT is ready to be read
    DATA_OUT        : OUT   std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 
       
-- excahnged with NewDDRInterface/MEM_READ_CNTRL and DDR1KB_FIFO within
    DCS_DDR_RE      : OUT   std_logic;
    DCS_DDR_FULL    : IN    std_logic;
    DCS_DDR_DATA    : IN    std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);

-- to ErrorCounter   
    dcsrd_state_cnt : OUT   std_logic_vector(7 DOWNTO 0) 

);
end DCSReadDDRProcessor;

architecture architecture_DCSReadDDRProcessor of DCSReadDDRProcessor is

  -------------------------------------------------------------------------------
  -- Signal declarations
  -------------------------------------------------------------------------------
   type state_type is ( IDLE, STARTDATA, WAITDATA, SENDREADY, WAITREQ, WAITDONE, HOLD);
    signal dcsrd_state          : state_type;
--    signal dcsrd_state_cnt  : std_logic_vector(7 DOWNTO 0); 

    
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
         
            dcsrd_state     <= IDLE;
            dcsrd_state_cnt <= (others => '0');
            
            word_dcspkt_cnt <= (others => '0');
            word_dcspkt_max <= (others => '0');
            payload_in_cnt  <= (others => '0');
            payload_out_cnt <= (others => '0');
            payload_size    <= (others => '0');
            
            DCS_DDR_RE  <= '0';
            READY_REG   <= '0'; 
            IS_DDR_REG  <= '0';
                        
        elsif rising_edge(DCS_CLK) then
                
            DCS_DDR_RE  <= '0';
            READY_REG   <= '0'; 
                        
            case dcsrd_state is
                
            when IDLE => 
                dcsrd_state_cnt <= X"01";
                IS_DDR_REG      <= '0';  
                payload_in_cnt  <= (others => '0');
                payload_out_cnt <= (others => '0');
                -- DDR1kB_FIFO is FULL 
                if  DCS_DDR_FULL = '1' and READ_CMD = '1'   then  
                    IS_DDR_REG  <= '1'; 
                    DCS_DDR_RE      <= '1';                    
                    payload_size<= BLOCK_SIZE;    
                    dcsrd_state <= STARTDATA;
                end if;
                
            -- read first payload data from DDR1KB_FIFO
            -- use WORD_DCSPKT_CNT as the local counter of words in the packet (to be compared to WORD_DCSPKT_MAX)
            when STARTDATA =>
                dcsrd_state_cnt <= X"02";
                
                if  BLOCK_START = '1'  then  
                    word_dcspkt_cnt <= std_logic_vector(unsigned(word_dcspkt_cnt) + 1); -- counter of payload words in DCS packet
                    
                    if  payload_in_cnt < std_logic_vector(unsigned(payload_size))    then 
                        DCS_DDR_RE      <= '1';
                        payload_in_cnt  <= std_logic_vector(unsigned(payload_in_cnt) + 1);
                    end if;
                    
                    -- set maximum number of data request per packet to service
                    if  FIRST_BLOCK = '1' then
                        word_dcspkt_max <= X"0003";
                    else
                        word_dcspkt_max <= X"0008";
                    end if;
                    
                    dcsrd_state <= SENDREADY;
                end if;
                
            -- Start sending data to DCSProcessor using SENDREADY <-> WAITREQ handshake
            -- A) set ready (READY_REG) and pass word (DATA_OUT) from DDR1KB_FIFO:
            -- B) wait for data request (BLK_READ_REQ) from DCSProcessor and read next word from DDR1KB_FIFO
            --
            --  Use PAYLOAD_OUT_CNT to keep track of data words sent to DCSPROCESSOR:
            --      if last word in DCS packet detected, go to HOLD and decide what to do next
            --      if last word payload word in DDR1KB_FIFO has been reached, set DATA_OUT to zero.
            --
            when SENDREADY =>
                dcsrd_state_cnt <= X"03";
                READY_REG   <= '1';
                if  payload_out_cnt < std_logic_vector(unsigned(payload_size))    then
                    DATA_OUT<= DCS_DDR_DATA; 
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
                dcsrd_state_cnt <= X"04";
                if  BLK_READ_REQ = '1'  then
--                    READY_REG   <= '0';
                    word_dcspkt_cnt     <= std_logic_vector(unsigned(word_dcspkt_cnt) + 1);
                    if  payload_in_cnt < std_logic_vector(unsigned(payload_size))    then 
                        DCS_DDR_RE       <= '1';
                        payload_in_cnt  <= std_logic_vector(unsigned(payload_in_cnt) + 1);
                    end if;
                    dcsrd_state <= SENDREADY;
                end if;
                    
            -- wait here until DCSProcessor send end of packet or end of block
            when HOLD =>
                dcsrd_state_cnt <= X"05";
                word_dcspkt_cnt    <= (others => '0');
                if  PKT_DONE = '1'  then        -- DCSProcessor requests another BLOCK RD packet 
                    dcsrd_state <= STARTDATA;
                elsif   DCS_DONE = '1'  then    -- DCSProcessor thinks BLOCK RD is done
                                                -- check if we have exhausted payload words and empty DDR1KB_FIFO
                    dcsrd_state <= IDLE;
                end if;
                
                
            when others =>
                dcsrd_state_cnt <= X"FF";
            end case;
            
        end if;
    end process;
   
end architecture_DCSReadDDRProcessor;
