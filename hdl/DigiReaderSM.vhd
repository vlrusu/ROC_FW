--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DigiReaderSM.vhd
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

entity DigiReaderSM is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    use_lane : in std_logic_vector(3 downto 0);
    
    lane0_empty : in std_logic;
    lane1_empty : in std_logic;
    lane2_empty : in std_logic;
    lane3_empty : in std_logic;
    
    lane0_rdcnt : in std_logic_vector(12 downto 0);
    lane1_rdcnt : in std_logic_vector(12 downto 0);
    lane2_rdcnt : in std_logic_vector(12 downto 0);
    lane3_rdcnt : in std_logic_vector(12 downto 0);
    
    lane0_data : in std_logic_vector(31 downto 0);
    lane1_data : in std_logic_vector(31 downto 0);
    lane2_data : in std_logic_vector(31 downto 0);
    lane3_data : in std_logic_vector(31 downto 0);
    
    fifo_re : out std_logic_vector(3 downto 0);
    
    outfifo_we : out std_logic;
    outfifo_data : out  std_logic_vector(31 downto 0)
);
end DigiReaderSM;
architecture architecture_DigiReaderSM of DigiReaderSM is

    type state_type is (IDLE, READ_HEADER1, READ_HEADER2, HIT_LOOP, READ_HIT_FIRSTPACKET, READ_HIT_ADC1, READ_HIT_ADC2);
    signal state            : state_type;
    
    signal current_channel : integer range 0 to 3;
    signal hit_counter : unsigned(15 downto 0);
    signal packet_counter : unsigned(5 downto 0);
    signal word_counter : unsigned(3 downto 0);
    signal event_window_counter : std_logic_vector(15 downto 0);
    
    signal current_data : std_logic_vector(31 downto 0);
    signal outfifo_data_select : std_logic;
    
    signal fifo_ready : std_logic_vector(3 downto 0);
    signal fifo_empty : std_logic_vector(3 downto 0);

begin

    with current_channel select
        current_data <= lane0_data when 0,
                        lane1_data when 1,
                        lane2_data when 2,
                        lane3_data when 3;
                        
    fifo_empty <= lane3_empty & lane2_empty & lane1_empty & lane0_empty;

    fifo_ready(0) <= '1' when unsigned(lane0_rdcnt) >= 4 else '0';
    fifo_ready(1) <= '1' when unsigned(lane1_rdcnt) >= 4 else '0';
    fifo_ready(2) <= '1' when unsigned(lane2_rdcnt) >= 4 else '0';
    fifo_ready(3) <= '1' when unsigned(lane3_rdcnt) >= 4 else '0';

    outfifo_data <= X"0000" & event_window_counter when outfifo_data_select = '0' else current_data;

    process(reset_n,clk)
    begin
    if reset_n = '0' then
        state <= IDLE;
        current_channel <= 0;
        fifo_re <= (others => '0');
        outfifo_we <= '0';
        hit_counter <= (others => '0');
        word_counter <= (others => '0');
        outfifo_data_select <= '0';
        
    elsif rising_edge(clk) then
        case state is
            when IDLE =>
                fifo_re <= (others => '0');
                outfifo_we <= '0';
                if fifo_empty(current_channel) = '1' or use_lane(current_channel) = '0' then
                    current_channel <= current_channel + 1;
                else
                    state <= READ_HEADER1;
                    fifo_re(current_channel) <= '1';
                end if;
                
            when READ_HEADER1 => 
                fifo_re <= (others => '0');
                state <= READ_HEADER2;
                
            when READ_HEADER2 =>
                event_window_counter <= current_data(15 downto 0);
                hit_counter <= unsigned(current_data(31 downto 16));
                state <= HIT_LOOP;
                
            when HIT_LOOP =>
                outfifo_data_select <= '0';
                word_counter <= X"3";
                if hit_counter = 0 then
                    state <= IDLE;
                    current_channel <= current_channel + 1;
                else
                    if fifo_ready(current_channel) = '0' then
                        state <= HIT_LOOP;
                    else
                        state <= READ_HIT_FIRSTPACKET;
                        fifo_re(current_channel) <= '1';
                        outfifo_we <= '1';
                    end if;
                end if;
                
            when READ_HIT_FIRSTPACKET =>
                outfifo_data_select <= '1';
                word_counter <= word_counter - 1;
                if word_counter = 0 then
                    packet_counter <= unsigned(current_data(21 downto 16));
                    fifo_re(current_channel) <= '0';
                    state <= READ_HIT_ADC1;
                end if;
                
            when READ_HIT_ADC1 =>
                outfifo_we <= '0';
                if packet_counter = 0 then
                    hit_counter <= hit_counter - 1;
                    state <= HIT_LOOP;
                else
                    if fifo_ready(current_channel) = '1' then
                        packet_counter <= packet_counter - 1;
                        state <= READ_HIT_ADC2;
                        word_counter <= X"3";
                        fifo_re(current_channel) <= '1';
                    end if;
                end if;
                
            when READ_HIT_ADC2 =>
                outfifo_we <= '1';
                word_counter <= word_counter - 1;
                if word_counter = 0 then
                    fifo_re(current_channel) <= '0';
                    state <= READ_HIT_ADC1;
                end if;
                
        end case;
    end if;
    end process;

end architecture_DigiReaderSM;
