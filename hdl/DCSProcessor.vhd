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
    
    error_count : out std_logic_vector(15 downto 0)
);
end DCSProcessor;
architecture architecture_DCSProcessor of DCSProcessor is

    type state_type is (IDLE, FIRSTREAD, SECONDREAD, CHECKCRC, RW1, RW2, RW3, RW4, RW5, SENDPACKET, CALCULATECRC, WRITECRC);
    signal state      : state_type;
    signal counter : integer range 0 to 5;
    
    signal reg_address : std_logic_vector(15 downto 0);
    signal reg_data_in : std_logic_vector(15 downto 0);
    signal reg_data_out : std_logic_vector(15 downto 0);
    signal reg_we : std_logic;
    signal register_0 : std_logic_vector(15 downto 0);
    signal register_1 : std_logic_vector(15 downto 0);
    signal register_2 : std_logic_vector(15 downto 0);
    signal register_3 : std_logic_vector(15 downto 0);
    
    signal corrupted : std_logic;
    signal dcs_fifo_empty : std_logic;
    
    type packet   is array (9 downto 0) of std_logic_vector(15 downto 0);
    signal inbuffer : packet;
    
    signal word_count : integer range 0 to 31;
    signal error_flag : std_logic;
    signal calculated_crc : std_logic_vector(15 downto 0);
    
    signal write_ack : std_logic;
    signal read_write : std_logic;
    signal double_rw : std_logic;
    signal block_op_packet_count : std_logic_vector(9 downto 0);
    signal opcode : std_logic_vector(2 downto 0);
    signal op1_address : std_logic_vector(15 downto 0);
    signal op2_address : std_logic_vector(15 downto 0);
    signal op1_data : std_logic_vector(15 downto 0);
    signal op2_data : std_logic_vector(15 downto 0);
    signal read_crc : std_logic_vector(15 downto 0);

begin

    corrupted <= '0';
    dcs_fifo_empty <= '0';
    
    
    -- DCS packet definition
    write_ack <= inbuffer(3)(3);
    opcode <= inbuffer(3)(2 downto 0);
    read_write <= '1' when opcode(0) = '0' else '0';
    double_rw <= '1' when opcode(2) = '1' else '0';
    block_op_packet_count <= inbuffer(3)(15 downto 6);
    op1_address <= inbuffer(4);
    op1_data <= inbuffer(5);
    op2_address <= inbuffer(6);
    op2_data <= inbuffer(7);
    read_crc <= inbuffer(9);
    
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        crc_en <= '0';
        crc_rst <= '1';
        crc_data_out <= (others => '0');
        state <= IDLE;
        fifo_re <= '0';
        fifo_we <= '0';
        fifo_data_out <= (others => '0');
        reg_we <= '0';
        reg_data_in <= (others => '0');
        
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
        
        error_count <= (others => '0');
        word_count <= 0;

    elsif rising_edge(clk) then
        crc_en <= '0';
        crc_rst <= '1';
        fifo_re <= '0';
        fifo_we <= '0';
        reg_we <= '0';
        reg_data_in <= (others => '0');
        
        case state is 
            when IDLE =>
                if unsigned(fifo_rdcnt) > 9 then
                    fifo_re <= '1';
                    state <= FIRSTREAD;
                end if;
            
            when FIRSTREAD =>
                fifo_re <= '1';
                word_count <= 0;
                state <= SECONDREAD;
                
            when SECONDREAD =>
                fifo_re <= '1';
                inbuffer(word_count) <= fifo_data_in;
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
                
            when CHECKCRC =>
                word_count <= 0;
                calculated_crc <= crc_data_in;
                if crc_data_in /= read_crc then
                    error_count <= std_logic_vector(unsigned(error_count) + 1);
                    state <= IDLE;
                else
                    state <= RW1;
                end if;
                
            when RW1 =>
                reg_address <= op1_address;
                reg_data_in <= op1_data;
                if read_write = '1' then
                    state <= RW2;
                else
                    reg_we <= '1';
                    state <= RW3;
                end if;
                
            when RW2 =>
                state <= RW3;
            
            when RW3 =>
                if read_write = '1' then
                    inbuffer(5) <= reg_data_out;
                end if;
                reg_address <= op2_address;
                reg_data_in <= op2_data;
                if double_rw = '1' then
                    if read_write = '1' then
                        state <= RW4;
                    else
                        reg_we <= '1';
                        state <= IDLE; -- FIXME WRITE ACK
                    end if;
                else
                    if read_write = '1' then
                        state <= IDLE; -- FIXME WRITE ACK
                    end if;
                end if;
                
            when RW4 =>
                state <= RW5;
            
            when RW5 =>
                inbuffer(7) <= reg_data_out;
                state <= SENDPACKET;
                
            when SENDPACKET =>
                word_count <= word_count + 1;
                fifo_we <= '1';
                if word_count = 0 then
                    fifo_data_out <= "10" & X"1C04";  -- k28.0 & D4.y
                    crc_rst <= '0';
                    crc_en <= '0';
                elsif word_count = 1 then
                    fifo_data_out <= (others => '0'); -- DMA bytes
                    crc_data_out <= (others => '0');
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 2 then
                    fifo_data_out <= "00" & X"8040"; -- valid & reserved & roc_id & packet_type & hop_count
                    crc_data_out <= X"8040";
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 3 then
                    fifo_data_out <= "00" & block_op_packet_count & corrupted & dcs_fifo_empty & write_ack & opcode;
                    crc_data_out <= block_op_packet_count & corrupted & dcs_fifo_empty & write_ack & opcode;
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 4 then
                    fifo_data_out <= "00" & op1_address;
                    crc_data_out <= op1_address;
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 5 then
                    fifo_data_out <= "00" & op1_data;
                    crc_data_out <= op1_data;
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 6 then
                    fifo_data_out <= "00" & op2_address;
                    crc_data_out <= op2_address;
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 7 then
                    fifo_data_out <= "00" & op2_data;
                    crc_data_out <= op2_data;
                    crc_rst <= '0';
                    crc_en <= '1';
                elsif word_count = 8 then
                    fifo_data_out <= (others => '0');
                    crc_data_out <= (others => '0');
                    crc_rst <= '0';
                    crc_en <= '1';
                    state <= CALCULATECRC;
                end if;
                
            when CALCULATECRC =>
                fifo_we <= '0';
                crc_rst <= '0';
                crc_en <= '1';
                state <= WRITECRC;
                
            when WRITECRC =>
                fifo_we <= '1';
                fifo_data_out <= "00" & crc_data_in;
                state <= IDLE;                
            
            when others =>
                --pass
        end case;
    end if;
    end process;
    
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        register_0 <= (others => '0');
        register_1 <= X"DEAD";
        register_2 <= X"1111";
        register_3 <= X"2222";
        reg_data_out <= (others => '0');
    elsif rising_edge(clk) then
        if reg_we = '1' then
            case reg_address is
                when X"0000" =>
                    register_0 <= reg_data_in;
                when X"0001" =>
                    register_1 <= reg_data_in;
                when X"0002" =>
                    register_2 <= reg_data_in;
                when X"0003" =>
                    register_3 <= reg_data_in;
                when others =>
                    -- pass
            end case;
        end if;
        case reg_address is
            when X"0000" =>
                reg_data_out <= register_0;
            when X"0001" =>
                reg_data_out <= register_1;
            when X"0002" =>
                reg_data_out <= register_2;
            when X"0003" =>
                reg_data_out <= register_3;
            when others =>
                reg_data_out <= X"BEEF";
        end case;
    end if;
    end process;









   -- architecture body
end architecture_DCSProcessor;
