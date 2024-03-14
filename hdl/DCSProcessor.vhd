--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DCSProcessor.vhd
-- File history:
--      <v1>: <07/05/2022>: MT adds separate READY and DATA_OUT inputs from DRACRegister and DCSReadCMDProcessor
--      <v2>: <07/18/2022>: MT adds logic for DCS Block Read and Block Write response from/to uProcessor
--      <v3>: <02/15/2023>: MT integrates with DCSProcessor in latest commit
--      <v4>: <04/05/2023>: MT adds number of packets for DCS Block Read (needed by DTC!)
--      <v5>: <04/10/2023>: MT fixes to CRC calculation for DCS Block Read replies. Removed Double RD and WR
--      <v6>: <04/20/2023>: MT major STATE MACHINE overhaul to make it more transparent and fix DCS Block Write decoding of additional packets
--      <v7>: <05/03/2023>: MT added timeouts to WAIT_DATA_READY/CHECK_WRD1 state to deal with undefined DCS commands. 
--                             If timeout is seen, either return TIMEOUT_WRD = 0xEFFE or clear DCS_WRITE data to prevent blocking the fiber 
--                             from processing future commands.
--      <v8>: <07/22/2023>: MT generate separate READ and WRITE commands depending on request address: XX_REG if 0-0xFF range, XX_PROC if 0x100-0x1FF range
--      <v9>: <02/07/2024>: MT Add timeout for automatic State Machine when garbage data comes in during DTC Flashing or DTC Reset
--      <v10>: <02/28/2024>: MT Added ROC_ID output for LOOPBACK REPLY MARKER
--
-- Description: 
--      Module decoding DCS operations. DCS Single RD, DCS Single WR (with ACK), DCS Block RD and DCS Block WRITE supported so far.
--      State Machine is driven by data seen in RXPacketFIFO_0. When at least one full DCS packet of 10 words is there,
--      read it all in to validate CRC, and then start decoding (see below).
--   NB: BLOCK_RD and BLOCK_WR are meant to uProcessor and require to be written/read from intermediate FIFOs with VALID <-> READY handshake 
--
--                                                   |- >IDLE        if CRC ERROR
--       IDLE -> FIRSTREAD -> SECONDREAD -> @CHECKCRC ---> SEND_ADDR  if first DCS command packet 
--                                                   |-> NEXT_BLK_WR if additional DCS command packet (for DCS BLOCK_WRITE)
--                                                                                                               |-----------------------------------------------------------|
--                                                                       |-> (BLOCK_RD)  SENDFIRSTPACKET |      \|/                    |-> WAITTOSENDNEXT -> SENDNEXTPACKET -> 
--                   |-> (for any DCS RD)    WAIT_DATA_READY -> SET_DATA --> (Single_RD) SENDPACKET      -->   CALCULATECRC -> WRITECRC --> IDLE
--       @SEND_ADDR  --> (for DCS Single WR) SEND_DATA ->  CHECK_FOR_ACK  -> IDLE or SENDPACKET (if ACK requested) 
--                   |-> (for DCS BLOCK WR)  BLK_WRD1 -> CHECK_WDR1 -> BLK_WRD2....(3 times) -> IDLE or BLKIDLE -> FIRSTREAD-> SECONDREAD -> CHECKCRC
--
--
--       @NEXT_BLK_WR -> CHECK_BLK_WR |   for up to 8 payload words, with -> FIRSTREAD-> SECONDREAD -> CHECKCRC for any additional packet present
--      /|\----------------------------  
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.algorithm_constants.all; 

entity DCSProcessor is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    reset_dcs_logic : out std_logic;

    fifo_rdcnt : in std_logic_vector(10 downto 0);
    fifo_data_in : in std_logic_vector(15 downto 0);
    fifo_re : out std_logic;
    
    fifo_data_out : out std_logic_vector(17 downto 0);
    fifo_we : out std_logic;
    
    crc_en : out std_logic;
    crc_rst : out std_logic;
    crc_data_out : out std_logic_vector(15 downto 0);
    crc_data_in : in std_logic_vector(15 downto 0);
		
    ready_from_drac	:	in  std_logic;
    ready_from_cmd	:	in  std_logic;
    reg_from_drac   :   in  std_logic_vector(15 downto 0);
    reg_from_cmd    :   in  std_logic_vector(15 downto 0);
    
    read_reg    :	out std_logic;  -- high for READ DCS via DRACRegister
    read_proc   :	out std_logic;  -- high for READ DCS via uProcessor
    write_reg	:	out std_logic;  -- high for WRITE DCS via DRACRegister
    write_proc  :	out std_logic;  -- high for WRITE DCS via uProcessor
    address_reg :   out std_logic_vector(15 downto 0);
    data_reg    :   out std_logic_vector(15 downto 0);
    blk_reg     :   out std_logic;  -- high for BLK DCS packet
    blk_start   :   out std_logic;  -- high for BLK DCS packet
    first_blk   :   out std_logic;  -- high at start of new BLK RD packet
    blk_size    :   out std_logic_vector(15 downto 0);  -- number of word in ANY block operation (ie both RD or WR)
    blk_read_req:   out std_logic;  -- request of read feom DCS_TX_BUFFER
    blk_cnt_reg :   out std_logic_vector(15 downto 0);
    
    data_we_ack :   in  std_logic;
    data_we     :   out std_logic;

    is_drac_reg	:	in  std_logic;
    is_cmd_reg	:	in  std_logic;
    pckt_done   :   out   std_logic;  -- used in block request, if more packets are needed
    dcs_done    :   out   std_logic;  -- used in block request, to release processor
    
    roc_id      :   out std_logic_vector(3 downto 0);

    dcs_state_count : out std_logic_vector(7 downto 0);
    dcs_error_count : out std_logic_vector(15 downto 0)
);
end DCSProcessor;
architecture architecture_DCSProcessor of DCSProcessor is

    type state_type is (IDLE, FIRSTREAD, SECONDREAD, CHECKCRC, SEND_ADDR, SEND_DATA, CHECK_FOR_ACK, WAIT_DATA_READY, SET_DATA,
                        SENDPACKET, CALCULATECRC, WRITECRC, SENDFIRSTPACKET, WAITTOSENDNEXT, SENDNEXTPACKET,
                        BLK_WRD1, CHECK_WRD1, BLK_WRD2, CHECK_WRD2, BLK_WRD3, CHECK_WRD3, BLKIDLE, NEXT_BLK_WR, CHECK_BLK_WR);
    signal dcs_state    : state_type;
    
    signal corrupted        : std_logic;
    signal dcs_fifo_empty   : std_logic;
    
    type packet   is array (9 downto 0) of std_logic_vector(15 downto 0);
    signal inbuffer : packet;
    
    signal word_count       : integer range 0 to 31;
    signal word_in_blk_pckt : integer range 0 to 9;
    signal blk_wr_word_cnt  : integer range 0 to 8192;
    signal blk_rd_word_cnt : integer range 0 to 8192;

    signal read_write   : std_logic;        -- 1 for READ, 0 for WRITE
    signal is_blk_rw    : std_logic;
    signal first_pckt   : std_logic;        -- indicates first packet of any DCS command (BLK WR can have multiple)  
    signal sequence_num : std_logic_vector(2 downto 0);
    signal add_rd_pckt  : std_logic_vector(9 downto 0);     -- no. of packets in DCS Block RD
    signal blk_rd_word_left: std_logic_vector(15 downto 0);
    signal blk_pckt_size: std_logic_vector(15 downto 0);    -- no. of additional packets needed to fit the required words in the block BEFORE doing "divide-by-8" 
    
    signal link_id      : std_logic_vector(2 downto 0);
    signal write_ack    : std_logic;
    signal opcode       : std_logic_vector(2 downto 0);
    signal add_wr_pckt  : std_logic_vector(9 downto 0);     -- no. of additional packets for DCS Block WR
    signal op_address   : std_logic_vector(15 downto 0);
    signal op_data      : std_logic_vector(15 downto 0);
    signal blk_wr_data1 : std_logic_vector(15 downto 0);
    signal blk_wr_data2 : std_logic_vector(15 downto 0);
    signal blk_wr_data3 : std_logic_vector(15 downto 0);
    signal read_crc     : std_logic_vector(15 downto 0);    
    signal ready        : std_logic;
    signal reg_data     : std_logic_vector(15 downto 0);
    signal save_data    : std_logic_vector(15 downto 0);
    signal data_to_read : std_logic_vector(15 downto 0);

    signal delay_count      : integer range 0 to 31;
    signal readTimeout      : unsigned(6 downto 0);
    signal blkreadTimeout   : unsigned(6 downto 0);

    signal dcsTimeout       : unsigned(15 downto 0);  -- allow for a 65535 x 5 ns = 328 us timeout
    signal first_dcs_seen   : std_logic;
    
begin

    corrupted <= '0';
    dcs_fifo_empty <= '0';
    
    -- DCS packet definition
    link_id     <= inbuffer(2)(10 downto 8);
    write_ack   <= inbuffer(3)(3);
    opcode      <= inbuffer(3)(2 downto 0);
    add_wr_pckt <= inbuffer(3)(15 downto 6);
    op_address  <= inbuffer(4);
    op_data     <= inbuffer(5); -- for block operations, this is the word count
    blk_wr_data1<= inbuffer(6);
    blk_wr_data2<= inbuffer(7);
    blk_wr_data3<= inbuffer(8);
    read_crc    <= inbuffer(9);
    
    ready   <=  ready_from_drac   when    is_drac_reg = '1'   else
                ready_from_cmd    when    is_cmd_reg = '1'    else
                '0';
    reg_data<=  reg_from_drac   when    is_drac_reg = '1'   else
                reg_from_cmd    when    is_cmd_reg = '1'    else
                X"0000";
        
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        
        read_reg    <= '0';
        read_proc   <= '0';
        write_reg   <= '0';
        write_proc  <= '0';
        address_reg <= (others => '1');
        data_reg    <= (others => '0');
        
        blk_reg     <= '0';
        blk_start   <= '0';
        first_blk   <= '0';
        blk_read_req<= '0';
        data_we     <= '0';
        pckt_done   <= '0';
        dcs_done    <= '0';
        
        blk_size    <= (others => '0');
        add_rd_pckt <= (others => '0');
        blk_pckt_size<= (others => '0');
        blk_cnt_reg <= (others => '0');
        dcs_error_count <= (others => '0');
        dcs_state_count <= (others => '0');
        
        dcs_state   <= IDLE;
        
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
        
        fifo_re <= '0';
        fifo_we <= '0';
        fifo_data_out <= (others => '0');
        
        crc_en <= '0';
        crc_rst <= '1';
        crc_data_out <= (others => '0');
        
        read_write  <= '0';
        is_blk_rw   <= '0';
        first_pckt  <= '1';
        sequence_num    <= (others => '0');
        blk_rd_word_left<= (others => '0');
         
        word_count  <= 0;
        word_in_blk_pckt<= 0;
        blk_wr_word_cnt <= 0;
        blk_rd_word_cnt <= 0;
        
        delay_count     <= 0;
        readTimeout	    <= (others => '1');
        blkreadTimeout	<= (others => '1');
        
        dcsTimeout	    <= (others => '1');
        reset_dcs_logic <= '0';
        
        first_dcs_seen  <= '1';
        roc_id          <= (others => '1');
        
    elsif rising_edge(clk) then
        
        crc_en  <= '0';
        crc_rst <= '1';
        
        fifo_re <= '0';
        fifo_we <= '0';
        
        pckt_done   <= '0';
        dcs_done    <= '0';
        
        read_reg    <= '0';
        read_proc   <= '0';
        write_reg   <= '0';
        write_proc  <= '0';
        blk_start   <= '0';
        blk_read_req<= '0';
            
        case dcs_state is 
        
           -- start reading full DCS packet from RxPacketFIFO_0 to ckeck on CRC
            when IDLE =>
                dcs_state_count <= X"00";
                blk_reg     <= '0';
                first_pckt  <= '1';
                blk_wr_word_cnt <= 0;
                readTimeout	    <= (others => '1');
                blkreadTimeout	<= (others => '1');
                
                if unsigned(fifo_rdcnt) > 0 then
                    dcsTimeout	<= dcsTimeout - 1;  
                    if      dcsTimeout =  1     then    reset_dcs_logic <= '1'; 
                    elsif   dcsTimeout =  0     then    reset_dcs_logic <= '0';  end if;
                end if;
                if unsigned(fifo_rdcnt) > 9 then
                    dcsTimeout	<= (others => '1');
                    fifo_re     <= '1';
                    dcs_state   <= FIRSTREAD;
                end if;
            
            when FIRSTREAD =>
                dcs_state_count <= X"01";
                fifo_re     <= '1';
                word_count  <= 0;
                delay_count <= 0;
                blk_rd_word_cnt <= 0;
                dcs_state <= SECONDREAD;
                
            when SECONDREAD =>
                dcs_state_count <= X"02";
                -- we get here only for the first DCS BLOCK write
                -- DO NOT CHANGE this on additional DCS Block Write packets!!!
                if  first_pckt = '1'  then 
                    read_write  <= '1' when opcode(0) = '0' else '0'; -- 1 if DCS read, 0 is DCS write
                    is_blk_rw   <= '1' when opcode(1) = '1' else '0';
                end if;
                
                fifo_re <= '1';
                inbuffer(word_count)<= fifo_data_in;
                crc_data_out <= fifo_data_in;
                word_count <= word_count + 1;
                if word_count = 0 then
                    crc_rst <= '0';
                    crc_en  <= '0';
                elsif word_count > 0 then
                    crc_rst <= '0';
                    crc_en  <= '1';
                end if;
                if word_count = 8 then
                    fifo_re <= '0';
                end if;
                if word_count = 9 then
                    fifo_re <= '0';
                    dcs_state   <= CHECKCRC;
                end if;
                
            -- this CRC check state is common to ANY packet in the DCS command
            -- what to do after depends if command contains only one or multiple packets (DCS BLOCK WR)
            when CHECKCRC =>
                dcs_state_count <= X"03";
                word_count      <= 0;
                    
                if crc_data_in /= read_crc then
                    dcs_error_count <= std_logic_vector(unsigned(dcs_error_count) + 1);
                    dcs_state <= IDLE;
                else
                    if  first_dcs_seen = '1' then
                        first_dcs_seen  <= '0';
                        roc_id          <= '0' & link_id;
                    end if;
                    
                    if  first_pckt = '1' then
                        -- clear FIRST_PCKT only if more packets are expected  
                        if  unsigned(add_wr_pckt) > X"0" then     first_pckt <= '0';    end if;
                        dcs_state <= SEND_ADDR;
                    else
                        word_in_blk_pckt <= 1;  -- reset this counter to 1 so that we skip K28 word
                        dcs_state <= NEXT_BLK_WR;
                    end if;
                end if;
                
            -- CRC is correct: stop reading RxPacketFIFO_0 and start processing DCS packet request
            when SEND_ADDR =>
                dcs_state_count <= X"04";
                address_reg     <= op_address;
                    
                -- set parameters for any BLOCK operation meant for uProcessor
                if  is_blk_rw = '1'    then
                    blk_reg     <= '1';
                    blk_size    <= op_data;
                end if;
                    
                    
                if  read_write = '0'    then    -- if DCS WRITE operations....
                    if  is_blk_rw = '0'   then  -- ... can be single DCS WRITE: handling is straightforward   
                        dcs_state   <= SEND_DATA;
                    else                        -- ... or block DCS WRITE: it requires more attention
                        dcs_state   <= BLK_WRD1;
                    end if;
                else                            -- if any DCS READ operation, go to next state to handle data for single vs block operations 
                    -- distinguish between registers for uProc vs others
                    if  unsigned(op_address) >= X"0100" and unsigned(op_address) <= X"0200"   then
                        read_proc   <= '1';
                    else
                        read_reg    <= '1';
                    end if;
                    
                    dcs_state   <= WAIT_DATA_READY;     
                end if;
            
            -- send DCS SINGLE WRITE data and check if ACK packets is requested
            when SEND_DATA =>    
                dcs_state_count <= X"05";
                -- distinguish between registers for uProc vs others
                if  unsigned(address_reg) >= X"0100" and unsigned(address_reg) <= X"0200"   then
                    write_proc   <= '1';
                else
                    write_reg    <= '1';
                end if;
                    
                data_reg        <= op_data;
                dcs_state       <= CHECK_FOR_ACK;
            
            -- deal with WRITE_ACK: need to send a packet out, as if it was a DCS read
            -- (to be tested!!)
            when CHECK_FOR_ACK =>
                dcs_state_count <= X"06";
                if (write_ack = '1') then 
                    read_reg	<= '1';
                    if  ready = '1'  then 
                        data_to_read    <= op_data; 
                        dcs_state       <= SENDPACKET;
                    end if;
                else -- for SINGLE DCS WR without ACK, we are done
                    dcs_state <= IDLE;
                end if;
                
            -- holding status for DCS READY to wait for READY signal 
            -- (indicating that modules have received the data words to be read)
            -- Use timeout if READY never seen.
            when WAIT_DATA_READY =>
                dcs_state_count <= X"10";
                
                -- prepare all info for block read to be able to generate READY
                if  is_blk_rw = '1'   then
                    first_blk   <= '1';
                    blk_start   <= '1';
                    blk_pckt_size  <= std_logic_vector(unsigned(blk_size)+4); 
                    if  unsigned(blk_size) > X"0003" then
                        blk_cnt_reg     <= X"0003";
                        blk_rd_word_left   <= std_logic_vector(unsigned(blk_size)-3);
                    else
                        blk_cnt_reg     <= blk_size;
                        blk_rd_word_left   <= (others => '0');
                    end if;
                end if;
                 
                -- if about to TIMEOUT, force returning packet with TIMEOUT_WRD
                -- for BLK RD timeout, reset FIRST_BLK and BLK_SIZE as to force only one packet when in SENDFIRSTPACKET
                readTimeout	<= readTimeout - 1;
                if  readTimeout = 1 then
                    if  is_blk_rw = '1'   then
                        blk_rd_word_cnt<= blk_rd_word_cnt + 1;
                        first_blk   <= '0';
                        blk_size    <= X"0003";
                        blk_cnt_reg <= X"0003";
                        blk_rd_word_left   <= (others => '0');
                    end if;
                    dcs_state <= SET_DATA;                    
                elsif (ready = '1') then
                    if  is_blk_rw = '1'   then
                        blk_rd_word_cnt<= blk_rd_word_cnt + 1;
                        first_blk   <= '0';
                    end if;
                    save_data   <= reg_data; -- hold to word to send back for general case (no TIMEOUT)
                    dcs_state <= SET_DATA;
                end if;
                
                
            -- common to all DCS READ operations: decide which packet has to be sent in single vs block read
            -- if TIMEOUT condition, return TIMEOUT_WRD
            when SET_DATA =>
                dcs_state_count <= X"11";
                
                if  is_blk_rw = '1'     then
                    if  readTimeout = 0 then
                        add_rd_pckt <= B"00_0000_0000";
                    else
                        add_rd_pckt <= blk_pckt_size(12 downto 3);
                    end if;
                    dcs_state <= SENDFIRSTPACKET;
                else  -- single DCS read
                    if  readTimeout = 0 then
                        data_to_read<= TIMEOUT_WRD; -- timeout word
                    else
                        data_to_read<= save_data;
                    end if;
                    dcs_state <= SENDPACKET;
                end if;
                
            -- send first payload of DCS BLOCK WRITE or exit write operation 
            when BLK_WRD1 =>
                dcs_state_count <= X"12";
                --write_reg	<= '1';
                -- distinguish between registers for uProc vs others
                if  unsigned(address_reg) >= X"0100" and unsigned(address_reg) <= X"0200"   then
                    write_proc   <= '1';
                else
                    write_reg    <= '1';
                end if;

                if  unsigned(blk_size) = X"0000" then -- send something, rely on DCSWriteProcessor to deal with BLK WRITE of null size
                    data_reg    <= (others => '0');
                    dcs_state   <= IDLE;
                else 
                    data_reg        <= blk_wr_data1;
                    blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                    dcs_state       <= CHECK_WRD1;
                end if;
             
            -- need to wait for DCSWriteCMDProcessor to acknowledge that DCSWriteCMD buffer is being filled
            -- add TIMEOUT in case the address is wrong and no acknowledge comes back from DCSWriteCMDProcessor
            -- N.B. even with TIMEOUT, must still read all of the data sent by the BLK WRITE!!
            when CHECK_WRD1 =>
                dcs_state_count <= X"13";
                data_we         <= '1';
                
                blkreadTimeout	<= blkreadTimeout - 1;
                if  blkreadTimeout = 1 or data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        dcs_state   <= BLK_WRD2;
                    else
                        dcs_state   <= IDLE;
                    end if;
                end if;
                
            -- pass second payload data of DCS BLOCK WRITE or exit write operation   
            when BLK_WRD2 =>
                dcs_state_count <= X"14";
                data_reg        <= blk_wr_data2;
                blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                dcs_state       <= CHECK_WRD2;
                
                
            when CHECK_WRD2 =>
                dcs_state_count <= X"15";
                data_we         <= '1';
                if  blkreadTimeout = 0 or data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        dcs_state   <= BLK_WRD3;
                    else
                        dcs_state   <= IDLE;
                    end if;
                end if;
                
            -- pass third payload data of DCS BLOCK WRITE or exit write operation   
            when BLK_WRD3 =>
                dcs_state_count <= X"16";
                data_reg        <= blk_wr_data3;
                blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                dcs_state       <= CHECK_WRD3;
            
            -- reset write enable and pass third data in block
            when CHECK_WRD3 =>
                dcs_state_count <= X"17";
                data_we         <= '1';
                if  blkreadTimeout = 0 or data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        dcs_state   <= BLKIDLE;
                    else
                        dcs_state   <= IDLE;
                    end if;
                end if;
                
            -- read and check CRC of next BLOCK WR packet
            when BLKIDLE =>
                dcs_state_count <= X"18";
                if unsigned(fifo_rdcnt) > 9 then
                    fifo_re     <= '1';
                    dcs_state   <= FIRSTREAD;
                end if;
                
            -- start passing data words from the next block packet
            when NEXT_BLK_WR =>
                dcs_state_count <= X"19";
                data_reg        <= inbuffer(word_in_blk_pckt);
                blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                word_in_blk_pckt<= word_in_blk_pckt + 1;
                dcs_state       <= CHECK_BLK_WR;
                
            -- decide with state to go next
            -- N.B. even with TIMEOUT, must still read all of the data sent by the BLK WRITE!!
            when CHECK_BLK_WR =>
                dcs_state_count <= X"1A";
                data_we         <= '1';
                if  blkreadTimeout = 0 or data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        if  word_in_blk_pckt < 9    then
                            dcs_state  <= NEXT_BLK_WR;
                        else
                            dcs_state   <= BLKIDLE;
                        end if;
                    else
                        dcs_state  <= IDLE;
                    end if;
                end if;
            
            -- start putting together DATA REPLY packet   
            when SENDPACKET =>
                dcs_state_count <= X"07";
                word_count  <= word_count + 1;
                fifo_we     <= '1';
                if word_count = 0 then
                    crc_rst <= '0';
                    crc_en <= '0';
                elsif word_count > 0 then
                    crc_rst <= '0';
                    crc_en <= '1';
                end if;
                if word_count = 0 then
                    fifo_data_out <= "10" & X"1C" & sequence_num & "0" & X"4";  -- k28.0 & D4.y
                elsif word_count = 1 then
                    fifo_data_out <= (others => '0'); -- DMA bytes
                    crc_data_out <= (others => '0');
                elsif word_count = 2 then
                    fifo_data_out <= "00" & "10000" & link_id & X"40"; -- valid & reserved & roc_id & packet_type & hop_count
                    crc_data_out <= "10000" & link_id & X"40";
                elsif word_count = 3 then -- for single DCS reply, 10-bit blk_packet_size set to 1 but ignored by the DTC
                    fifo_data_out <= "00" & "0000000000" & corrupted & dcs_fifo_empty & write_ack & opcode;
                    crc_data_out <= "0000000000" & corrupted & dcs_fifo_empty & write_ack & opcode;
                elsif word_count = 4 then
                    fifo_data_out <= "00" & op_address;
                    crc_data_out <= op_address;
                elsif word_count = 5 then
                    fifo_data_out <= "00" & data_to_read;
                    crc_data_out <= data_to_read;
                elsif word_count = 6 then
                    fifo_data_out <= (others => '0');
                    crc_data_out <= (others => '0');
                elsif word_count = 7 then
                    fifo_data_out <= (others => '0');
                    crc_data_out <= (others => '0');
                elsif word_count = 8 then
                    fifo_data_out <= (others => '0');
                    crc_data_out <= (others => '0');
                    dcs_state <= CALCULATECRC;
                end if;
                
            when CALCULATECRC =>
                dcs_state_count <= X"08";
                word_count   <= 0;
                crc_rst     <= '0';
                crc_en      <= '1';
                dcs_state   <= WRITECRC;
                
            when WRITECRC =>
                dcs_state_count <= X"09";
                fifo_we         <= '1';
                fifo_data_out   <= "00" & crc_data_in;
                
                --sequence_num <= std_logic_vector(unsigned(sequence_num) + 1); -- done in TxPacketWriter now
                sequence_num  <= (others => '0');
                
                -- for single read, we are done
                -- for block read, if TIMEOUT condition detected, we are done WITHOUT any signal out to DCSReadCMDProcessor
                --           else check on how many packets are left before sending appropriate signal out to DCSReadCMDProcessor
                if  is_blk_rw = '1'   then
                    if  blkreadTimeout = 0  then
                        dcs_state <= IDLE; 
                    elsif     unsigned(blk_rd_word_left) > X"0000"   then
                        pckt_done   <= '1'; 
                        if  unsigned(blk_rd_word_left) > X"0008"    then
                            blk_cnt_reg     <= X"0008";
                            blk_rd_word_left<= std_logic_vector(unsigned(blk_rd_word_left) - 8); 
                        else
                            blk_cnt_reg     <= blk_rd_word_left;
                            blk_rd_word_left<= (others => '0');
                        end if;
                        dcs_state <= WAITTOSENDNEXT;
                    else
                        dcs_done    <= '1';
                        dcs_state   <= IDLE; 
                    end if;
                else                     
                    dcs_state   <= IDLE; 
                end if;
                ---- for TIMEOUT condition, we are done without any signal out to DCSReadCMDProcessor
                --if  ((readTimeout = 0 and is_blk_rw = '0') or (blkreadTimeout = 0 and is_blk_rw = '1')) then
                    --dcs_state <= IDLE; 
                --elsif  is_blk_rw = '1' and unsigned(blk_rd_word_left) > X"0000"   then
                    --pckt_done   <= '1'; 
                    --word_count  <= 0; 
                    --if  unsigned(blk_rd_word_left) > X"0008"    then
                        --blk_cnt_reg     <= X"0008";
                        --blk_rd_word_left<= std_logic_vector(unsigned(blk_rd_word_left) - 8); 
                    --else
                        --blk_cnt_reg     <= blk_rd_word_left;
                        --blk_rd_word_left<= (others => '0');
                    --end if;
                    --dcs_state <= WAITTOSENDNEXT;
                --else
                    --dcs_done    <= '1';
                    --dcs_state   <= IDLE; 
                --end if;
                         
            -- start putting together DATA REPLY packet   
            when SENDFIRSTPACKET =>
                dcs_state_count <= X"0A";
                if word_count = 0 then
                    word_count <= word_count + 1;
                    fifo_we <= '1';
                    crc_rst <= '0';
                    crc_en  <= '0';
                elsif word_count > 0 and word_count < 7 then
                    word_count <= word_count + 1;
                    fifo_we <= '1';
                    crc_rst <= '0';
                    crc_en  <= '1';
                end if;
                
                if word_count = 0 then
                    fifo_data_out <= "10" & X"1C" & sequence_num & "0" & X"4";  -- k28.0 & D4.y
                elsif word_count = 1 then
                    fifo_data_out <= (others => '0'); -- DMA bytes
                    crc_data_out <= (others => '0');
                elsif word_count = 2 then
                    fifo_data_out <= "00" & "10000" & link_id & X"40"; -- valid & reserved & roc_id & packet_type & hop_count
                    crc_data_out <= "10000" & link_id & X"40";
                elsif word_count = 3 then
                    fifo_data_out <= "00" & add_rd_pckt & corrupted & dcs_fifo_empty & write_ack & opcode;
                    crc_data_out <= add_rd_pckt & corrupted & dcs_fifo_empty & write_ack & opcode;
                elsif word_count = 4 then
                    fifo_data_out <= "00" & op_address;
                    crc_data_out <= op_address;
                elsif word_count = 5 then
                    fifo_data_out <= "00" & blk_size;
                    crc_data_out <= blk_size;
                elsif word_count = 6 then
                    blkreadTimeout	<= (others => '1');
                    if   readTimeout = 0 then
                        fifo_data_out   <= "00" & TIMEOUT_WRD;
                        crc_data_out    <= TIMEOUT_WRD;
                    else
                        blk_read_req    <= '1';  -- send request for next block data
                        fifo_data_out   <= "00" & reg_from_cmd ;
                        crc_data_out    <= reg_from_cmd;
                    end if;
                elsif word_count = 7 then
                    -- deal with timeout condition by skipping READY<->REQ protocol and forcing TIMEOUT word out 
                    -- for block read without TIMEOUT, always wait for READY and send next BLK_READ_REQ
                    -- then decide if no more block words are to be expected
                    blkreadTimeout	<= blkreadTimeout - 1;
                    if  (readTimeout = 0 or blkreadTimeout = 1) then
                        word_count <= word_count + 1;
                        fifo_we <= '1';
                        blk_rd_word_cnt<= blk_rd_word_cnt + 1;
                        fifo_data_out   <= "00" & TIMEOUT_WRD;
                        crc_rst <= '0';
                        crc_en <= '1';
                        fifo_data_out   <= "00" & TIMEOUT_WRD;
                        crc_data_out    <= TIMEOUT_WRD;
                    elsif  ready = '1' then
                        blk_read_req    <= '1';  
                        word_count <= word_count + 1;
                        fifo_we <= '1';
                        crc_rst <= '0';
                        crc_en <= '1';
                        if blk_rd_word_cnt > to_integer(unsigned(blk_size))    then
                            fifo_data_out   <= (others => '0');
                            crc_data_out    <= (others => '0');
                        else
                            blk_rd_word_cnt<= blk_rd_word_cnt + 1;
                            fifo_data_out   <= "00" & reg_from_cmd ;
                            crc_data_out    <= reg_from_cmd;
                        end if;
                    else  -- prevent data to be used for CRC calculation
                        crc_rst <= '0';
                        crc_en <= '0';
                        fifo_we <= '0';
                    end if;
                elsif word_count = 8 then
                    -- deal with timeout condition by skipping READY<->REQ protocol and forcing TIMEOUT word out 
                    -- for block read without TIMEOUT,
                    -- do not send BLK_READ_REQ for last work of packet
                    if  (readTimeout = 0 or blkreadTimeout = 0) then
                        word_count <= word_count + 1;
                        fifo_we <= '1';
                        blk_rd_word_cnt<= blk_rd_word_cnt + 1;
                        crc_rst <= '0';
                        crc_en <= '1';
                        fifo_data_out   <= "00" & TIMEOUT_WRD;
                        crc_data_out    <= TIMEOUT_WRD;
                        dcs_state   <= CALCULATECRC;
                    elsif  ready = '1' then
                        word_count <= word_count + 1;
                        fifo_we <= '1';
                        crc_rst <= '0';
                        crc_en  <= '1';
                        if blk_rd_word_cnt > to_integer(unsigned(blk_size))    then
                            fifo_data_out   <= (others => '0');
                            crc_data_out    <= (others => '0');
                        else
                            blk_rd_word_cnt<= blk_rd_word_cnt + 1;
                            fifo_data_out   <= "00" & reg_from_cmd ;
                            crc_data_out    <= reg_from_cmd;
                        end if;
                        dcs_state <= CALCULATECRC;
                    else  -- prevent data to be used for CRC calculation
                        crc_rst <= '0';
                        crc_en  <= '0';
                        fifo_we <= '0';
                    end if;
                end if;
            
            -- add "arbitrary" delay between DCS Block Read packets   
            when WAITTOSENDNEXT =>
                dcs_state_count <= X"0B";
                delay_count <= delay_count + 1;
                if  delay_count = 16    then 
                    delay_count <= 0; 
                    dcs_state   <= SENDNEXTPACKET;
                end if;
                            
            when SENDNEXTPACKET =>
                dcs_state_count <= X"0C";
                if word_count = 0 then
                    blk_start <= '1';
                    word_count <= word_count + 1;
                    fifo_we <= '1';
                    crc_rst <= '0';
                    crc_en  <= '0';
                    fifo_data_out <= "10" & X"1C" & sequence_num & "0" & X"8";  -- k28.0 & D8.y
                elsif word_count > 0 and word_count < 8 then
                    if  ready = '1' then
                        blk_read_req    <= '1';  
                        word_count <= word_count + 1;
                        fifo_we <= '1';
                        crc_rst <= '0';
                        crc_en  <= '1';
                        if blk_rd_word_cnt > to_integer(unsigned(blk_size))    then
                            fifo_data_out   <= (others => '0');
                            crc_data_out    <= (others => '0');
                        else
                            blk_rd_word_cnt    <= blk_rd_word_cnt + 1;
                            fifo_data_out   <= "00" & reg_from_cmd ;
                            crc_data_out    <= reg_from_cmd;
                        end if;
                    else  -- prevent data to be used for CRC calculation
                        crc_rst <= '0';
                        crc_en <= '0';
                    end if;
                elsif word_count = 8 then
                    if  ready = '1' then
                        word_count <= word_count + 1;
                        fifo_we <= '1';
                        crc_rst <= '0';
                        crc_en  <= '1';
                         if blk_rd_word_cnt > to_integer(unsigned(blk_size))    then
                            fifo_data_out   <= (others => '0');
                            crc_data_out    <= (others => '0');
                        else
                            blk_rd_word_cnt    <= blk_rd_word_cnt + 1;
                            fifo_data_out   <= "00" & reg_from_cmd ;
                            crc_data_out    <= reg_from_cmd;
                        end if;
                        dcs_state <= CALCULATECRC;
                    else  -- prevent data to be used for CRC calculation
                        crc_rst <= '0';
                        crc_en  <= '0';
                        fifo_we <= '0';
                    end if;
                end if;
                           
            when others =>
                dcs_state_count <= X"FF";
                --pass
        end case;
    end if;
    end process;
    
   -- architecture body
end architecture_DCSProcessor;
