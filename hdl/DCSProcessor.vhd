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
--
-- Description: 
--      Module decoding DCS operations. DCS Single RD, DCS Single WR (with ACK), DCS Block RD and DCS Block WRITE supported so far.
--      State Machine is driven by data seen in RXPacketFIFO_0. When at least one full DCS packet of 10 words is there,
--      read it all in to validate CRC, and then start decoding (see below).
--   NB: BLOCK_RD and BLOCK_WR are meant to uProcessor and require to be written/read from intermediate FIFOs with VALID <-> READY handshake 
--
--                                                   |- >IDLE        if CRC ERROR
--       IDLE -> FIRSTREAD -> SECONDREAD -> @CHECKRC ---> SEND_ADDR  if first DCS command packet 
--                                                   |-> NEXT_BLK_WR if additional DCS command packet (for DCS BLOCK_WRITE)
--                                                                                                               |-----------------------------------------------------------|
--                                                                       |-> (BLOCK_RD)  SENDFIRSTPACKET |      \|/                    |-> WAITTOSENDNEXT -> SENDNEXTPACKET -> 
--                   |-> (for any DCS RD)    WAIT_DATA_READY -> SET_DATA --> (Single_RD) SENDPACKET      -->   CALCULATECRC -> WRITECRC --> IDLE
--       @SEND_ADDR  --> (for DCS Sinlge WR) SEND_DATA ->  CHECK_FOR_ACK  -> IDLE or SENDPACKET (if ACK requested) 
--                   |-> (for DCS BLOBK WR)  BLK_WRD1 -> CHECK_WDR1 -> BLK_WRD2....(3 times) -> IDLE or BLKIDLE -> FIRSTREAD-> SECONDREAD -> CHECKCRC
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

entity DCSProcessor is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
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
    
    read_reg    :	out std_logic;  -- high for READ DCS reply
    write_reg	:	out std_logic;  -- high for WRITE DCS reply
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
    dcs_done    :   out   std_logic;

    state_count : out std_logic_vector(7 downto 0);
    error_count : out std_logic_vector(15 downto 0)
);
end DCSProcessor;
architecture architecture_DCSProcessor of DCSProcessor is

    type state_type is (IDLE, FIRSTREAD, SECONDREAD, CHECKCRC, SEND_ADDR, SEND_DATA, CHECK_FOR_ACK, WAIT_DATA_READY, SET_DATA,
                        SENDPACKET, CALCULATECRC, WRITECRC, SENDFIRSTPACKET, WAITTOSENDNEXT, SENDNEXTPACKET,
                        BLK_WRD1, CHECK_WRD1, BLK_WRD2, CHECK_WRD2, BLK_WRD3, CHECK_WRD3, BLKIDLE, NEXT_BLK_WR, CHECK_BLK_WR);
    signal state    : state_type;
    
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
    signal data_to_read : std_logic_vector(15 downto 0);

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
        write_reg   <= '0';
        is_blk_rw   <= '0';
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
        error_count <= (others => '0');
        state_count <= (others => '0');
        
        state   <= IDLE;
        
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
        blk_rd_word_cnt<= 0;
        
    elsif rising_edge(clk) then
        
        crc_en  <= '0';
        crc_rst <= '1';
        
        fifo_re <= '0';
        fifo_we <= '0';
        
        pckt_done   <= '0';
        dcs_done    <= '0';
        
        read_reg    <= '0';
        write_reg   <= '0';
        blk_start   <= '0';
        blk_read_req<= '0';
            
        case state is 
        
           -- start reading full DCS packet from RxPacketFIFO_0 to ckeck on CRC
            when IDLE =>
                state_count <= X"01";
                blk_reg    <= '0';
                first_pckt  <= '1';
                blk_wr_word_cnt <= 0;
                if unsigned(fifo_rdcnt) > 9 then
                    fifo_re <= '1';
                    state <= FIRSTREAD;
                end if;
            
            when FIRSTREAD =>
                state_count <= X"02";
                fifo_re <= '1';
                word_count <= 0;
                blk_rd_word_cnt <= 0;
                state <= SECONDREAD;
                
            when SECONDREAD =>
                state_count <= X"03";
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
                    crc_en <= '0';
                elsif word_count > 0 then
                    crc_rst <= '0';
                    crc_en <= '1';
                end if;
                if word_count = 8 then
                    fifo_re <= '0';
                end if;
                if word_count = 9 then
                    fifo_re <= '0';
                    state <= CHECKCRC;
                end if;
                
            -- this CRC check state is common to ANY packet in the DCS command
            -- what to do after depends if command contains only one or multiple packets (DCS BLOCK WR)
            when CHECKCRC =>
                state_count <= X"04";
                word_count <= 0;
											  
                if crc_data_in /= read_crc then
                    error_count <= std_logic_vector(unsigned(error_count) + 1);
                    state <= IDLE;
                else    
                    if  first_pckt = '1' then
                        -- clear FIRST_PCKT if needed  
                        if  unsigned(add_wr_pckt) > X"0" then     first_pckt <= '0';    end if;
                       state <= SEND_ADDR;
                    else
                        word_in_blk_pckt <= 1;  -- reset this counter to 1 so that we skip K28 word
                        state <= NEXT_BLK_WR;
                    end if;
                end if;
                
            -- CRC is correct: stop reading RxPacketFIFO_0 and start processing DCS packet request
            when SEND_ADDR =>
                state_count <= X"05";
                address_reg <= op_address;
                
                -- common to any BLOCK operation meant for uProcessor
                if  is_blk_rw = '1'    then
                    blk_reg     <= '1';
                    blk_size    <= op_data;
                end if;

                if  read_write = '0'    then    -- if DCS WRITE operations....
                    if  is_blk_rw = '0'   then  --   single DCS WRITE is straightforward   
                        state   <= SEND_DATA;
                    else                        --   block DCS WRITE requires more attention
                        state   <= BLK_WRD1;
                    end if;
                else                            -- if DCS READ operation...
                    read_reg<= '1';
                    state   <= WAIT_DATA_READY;     
                end if;
            
            -- send DCS SINGLE WRITE data and check if ACK packets is requested
            when SEND_DATA =>    
                write_reg	<= '1';
                state_count <= X"06";
                data_reg    <= op_data;
                state       <= CHECK_FOR_ACK;
            
            -- deal with WRITE_ACK: need to send a packet out, as if it was a DCS read!!
            -- (to be tested!!)
            when CHECK_FOR_ACK =>
                state_count <= X"07";
                if (write_ack = '1') then 
                    read_reg	<= '1';
                    if  ready = '1'  then 
                        data_to_read<= op_data; 
                        state       <= SENDPACKET;
                    end if;
                else -- for double DCS WR without ACK we are done!!
                    state <= IDLE;
                end if;
                
            -- holding status for DCS READY to wait for READY signal 
            -- (indicating that modules have received the data words to be read)
            when WAIT_DATA_READY =>
                state_count <= X"08";
                read_reg	<= '1';
                
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
                 
                if (ready = '1') then
                    if  is_blk_rw = '1'   then
                        blk_rd_word_cnt<= blk_rd_word_cnt + 1;
                        first_blk   <= '0';
                    end if;
                    state <= SET_DATA;
                end if;
                
            -- for DCS READ operations: decide which packet has to be send    
            when SET_DATA =>
                state_count <= X"09";
                data_to_read<= reg_data;
                if  is_blk_rw = '1'     then
                    add_rd_pckt <= blk_pckt_size(12 downto 3);
                    state <= SENDFIRSTPACKET;
                else
                    state <= SENDPACKET;
                end if;
                
            -- send first payload of DCS BLOCK WRITE or exit write operation 
            when BLK_WRD1 =>
                state_count <= X"16";
                write_reg	<= '1';
                if  unsigned(blk_size) = X"0000" then -- send something, rely on DCSWriteProcessor to deal with BLK WRIT of null size
                    data_reg    <= (others => '0');
                    state       <= IDLE;
                else 
                    data_reg    <= blk_wr_data1;
                    blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                    state       <= CHECK_WRD1;
                end if;
             
            --need to wait for DCSWriteCMDProcessor to acknowledge that DCSWriteCMD buffer is being filled    
            when CHECK_WRD1 =>
                state_count <= X"17";
                data_we     <= '1';
                if  data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        state   <= BLK_WRD2;
                    else
                        state   <= IDLE;
                    end if;
                end if;
                
            -- pass second payload data of DCS BLOCK WRITE or exit write operation   
            when BLK_WRD2 =>
                state_count <= X"18";
                data_reg    <= blk_wr_data2;
                blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                state       <= CHECK_WRD2;
                
                
            when CHECK_WRD2 =>
                state_count <= X"19";
                data_we     <= '1';
                if  data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        state   <= BLK_WRD3;
                    else
                        state   <= IDLE;
                    end if;
                end if;
                
            -- pass third payload data of DCS BLOCK WRITE or exit write operation   
            when BLK_WRD3 =>
                state_count <= X"0E";
                data_reg    <= blk_wr_data3;
                blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                state       <= CHECK_WRD3;
            
            -- reset write enable and pass third data in block
            when CHECK_WRD3 =>
                state_count <= X"0F";
                data_we     <= '1';
                if  data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        state   <= BLKIDLE;
                    else
                        state   <= IDLE;
                    end if;
                end if;
                
            -- read and check CRC of next BLOCK WR packet
            when BLKIDLE =>
                state_count <= X"10";
                if unsigned(fifo_rdcnt) > 9 then
--                    first_pckt  <= '0';
                    fifo_re     <= '1';
                    state <= FIRSTREAD;
                end if;
                
            -- start passing data words from the next block packet
            when NEXT_BLK_WR =>
                state_count <= X"11";
                data_reg    <= inbuffer(word_in_blk_pckt);
                blk_wr_word_cnt <= blk_wr_word_cnt + 1;
                word_in_blk_pckt<= word_in_blk_pckt + 1;
                state       <= CHECK_BLK_WR;
                
            -- decide with state to go next
            when CHECK_BLK_WR =>
                state_count <= X"12";
                data_we     <= '1';
                if  data_we_ack = '1'   then
                    data_we <= '0';
                    if  blk_wr_word_cnt < to_integer(unsigned(blk_size))    then  
                        if  word_in_blk_pckt < 9    then
                            state  <= NEXT_BLK_WR;
                        else
                            state   <= BLKIDLE;
                        end if;
                    else
                        state  <= IDLE;
                    end if;
                end if;
            
         -- start putting together DATA REPLY packet   
            when SENDPACKET =>
                state_count <= X"0A";
                word_count <= word_count + 1;
                fifo_we <= '1';
                if word_count = 0 then
                    crc_rst <= '0';
                    crc_en <= '0';
                elsif word_count > 0 then
                    crc_rst <= '0';
                    crc_en <= '1';
                end if;
                if word_count = 0 then
                    fifo_data_out <= "10" & X"1C" & sequence_num & "0" & X"4";  -- k28.0 & D4.y
                    --crc_rst <= '0';
                    --crc_en <= '0';
                elsif word_count = 1 then
                    fifo_data_out <= (others => '0'); -- DMA bytes
                    crc_data_out <= (others => '0');
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 2 then
                    fifo_data_out <= "00" & "10000" & link_id & X"40"; -- valid & reserved & roc_id & packet_type & hop_count
                    crc_data_out <= "10000" & link_id & X"40";
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 3 then -- for single DCS reply, 10-bit blk_packet_size set to 1 but ignored by the DTC
                    fifo_data_out <= "00" & "0000000000" & corrupted & dcs_fifo_empty & write_ack & opcode;
                    crc_data_out <= "0000000000" & corrupted & dcs_fifo_empty & write_ack & opcode;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 4 then
                    fifo_data_out <= "00" & op_address;
                    crc_data_out <= op_address;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 5 then
                    fifo_data_out <= "00" & data_to_read;
                    crc_data_out <= data_to_read;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 6 then
                    fifo_data_out <= (others => '0');
                    crc_data_out <= (others => '0');
                    --fifo_data_out <= "00" & op2_address;
                    --crc_data_out <= op2_address;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 7 then
                    fifo_data_out <= (others => '0');
                    crc_data_out <= (others => '0');
                    --fifo_data_out <= "00" & op2_data;
                    --crc_data_out <= op2_data;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 8 then
                    fifo_data_out <= (others => '0');
                    crc_data_out <= (others => '0');
                    --crc_rst <= '0';
                    --crc_en <= '1';
                    state <= CALCULATECRC;
                end if;
                
            when CALCULATECRC =>
                state_count <= X"0B";
                --fifo_we <= '0';
                crc_rst <= '0';
                crc_en <= '1';
                state <= WRITECRC;
                
            when WRITECRC =>
                state_count <= X"0C";
                fifo_we <= '1';
                fifo_data_out <= "00" & crc_data_in;
                --sequence_num <= std_logic_vector(unsigned(sequence_num) + 1); -- done in TxPacketWriter now
                sequence_num  <= (others => '0');
                if  is_blk_rw = '1' and unsigned(blk_rd_word_left) > X"0000"   then
                    pckt_done <= '1'; 
                    word_count <= 0; 
                    if  unsigned(blk_rd_word_left) > X"0008"    then
                        blk_cnt_reg     <= X"0008";
                        blk_rd_word_left   <= std_logic_vector(unsigned(blk_rd_word_left) - 8); 
                    else
                        blk_cnt_reg     <= blk_rd_word_left;
                        blk_rd_word_left   <= (others => '0');
                    end if;
                    state <= WAITTOSENDNEXT;
                else
                    dcs_done<= '1';
                    state <= IDLE; 
                end if;

                         
         -- start putting together DATA REPLY packet   
            when SENDFIRSTPACKET =>
                state_count <= X"10";
                --word_count <= word_count + 1;
                --fifo_we <= '1';
                if word_count = 0 then
                    word_count <= word_count + 1;
                    fifo_we <= '1';
                    crc_rst <= '0';
                    crc_en <= '0';
                elsif word_count > 0 and word_count < 7 then
                    word_count <= word_count + 1;
                    fifo_we <= '1';
                    crc_rst <= '0';
                    crc_en <= '1';
                end if;
                
                if word_count = 0 then
                    fifo_data_out <= "10" & X"1C" & sequence_num & "0" & X"4";  -- k28.0 & D4.y
                    --crc_rst <= '0';
                    --crc_en <= '0';
                elsif word_count = 1 then
                    fifo_data_out <= (others => '0'); -- DMA bytes
                    crc_data_out <= (others => '0');
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 2 then
                    fifo_data_out <= "00" & "10000" & link_id & X"40"; -- valid & reserved & roc_id & packet_type & hop_count
                    crc_data_out <= "10000" & link_id & X"40";
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 3 then
                    fifo_data_out <= "00" & add_rd_pckt & corrupted & dcs_fifo_empty & write_ack & opcode;
                    crc_data_out <= add_rd_pckt & corrupted & dcs_fifo_empty & write_ack & opcode;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 4 then
                    fifo_data_out <= "00" & op_address;
                    crc_data_out <= op_address;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 5 then
                    fifo_data_out <= "00" & blk_size;
                    crc_data_out <= blk_size;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 6 then
                    blk_read_req    <= '1';  -- send request for next block data
                    fifo_data_out   <= "00" & reg_from_cmd ;
                    crc_data_out    <= reg_from_cmd;
                    --crc_rst <= '0';
                    --crc_en <= '1';
                elsif word_count = 7 then
                    -- for block read, always wait for READY and send next BLK_READ_REQ
                    -- then decide if no more block words are to be expected
                    if  ready = '1' then
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
                        --word_count <= 7;    
                    end if;
                elsif word_count = 8 then
                    -- no BLK_READ_REQ for last work of packet
                    if  ready = '1' then
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
                        state <= CALCULATECRC;
                    else  -- prevent data to be used for CRC calculation
                        crc_rst <= '0';
                        crc_en <= '0';
                        fifo_we <= '0';
                        --word_count <= 8;    
                    end if;
                end if;
            
            -- add "arbitrary" delay between DCS Block Read packets   
            when WAITTOSENDNEXT =>
                state_count <= X"11";
                word_count <= word_count + 1;
                if  word_count = 16    then 
                    word_count <= 0; 
                    state <= SENDNEXTPACKET;
                end if;
                            
            when SENDNEXTPACKET =>
                state_count <= X"12";
                --word_count <= word_count + 1;
                --fifo_we <= '1';
                if word_count = 0 then
                    blk_start <= '1';
                    word_count <= word_count + 1;
                    fifo_we <= '1';
                    crc_rst <= '0';
                    crc_en <= '0';
                    fifo_data_out <= "10" & X"1C" & sequence_num & "0" & X"8";  -- k28.0 & D8.y
                elsif word_count > 0 and word_count < 8 then
                    if  ready = '1' then
                        blk_read_req    <= '1';  
                        word_count <= word_count + 1;
                        fifo_we <= '1';
                        crc_rst <= '0';
                        crc_en <= '1';
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
                        crc_en <= '1';
                         if blk_rd_word_cnt > to_integer(unsigned(blk_size))    then
                            fifo_data_out   <= (others => '0');
                            crc_data_out    <= (others => '0');
                        else
                            blk_rd_word_cnt    <= blk_rd_word_cnt + 1;
                            fifo_data_out   <= "00" & reg_from_cmd ;
                            crc_data_out    <= reg_from_cmd;
                        end if;
                        state <= CALCULATECRC;
                    else  -- prevent data to be used for CRC calculation
                        crc_rst <= '0';
                        crc_en <= '0';
                        fifo_we <= '0';
                    end if;
                end if;
                           
            when others =>
                state_count <= X"FF";
                --pass
        end case;
    end if;
    end process;
    
   -- architecture body
end architecture_DCSProcessor;
