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
    
    lane0_data : in std_logic_vector(31 downto 0);
    lane1_data : in std_logic_vector(31 downto 0);
    lane2_data : in std_logic_vector(31 downto 0);
    lane3_data : in std_logic_vector(31 downto 0);
    
    fifo_re : out std_logic_vector(3 downto 0);
    
    outfifo_full : in std_logic;
    outfifo_we : out std_logic;
    outfifo_data : out  std_logic_vector(31 downto 0)
);
end DigiReaderSM;
architecture architecture_DigiReaderSM of DigiReaderSM is

    type state_type is (IDLE, HIT_LOOP, READ_HIT_FIRSTPACKET, READ_HIT_ADC1, READ_HIT_ADC2, FINISH_HIT_LOOP);
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
    
    signal want_we : std_logic;
    signal want_re : std_logic_vector(3 downto 0);
    signal data_ready : std_logic;

begin

    with current_channel select
        current_data <= lane0_data when 0,
                        lane1_data when 1,
                        lane2_data when 2,
                        lane3_data when 3;
                        
    fifo_empty <= lane3_empty & lane2_empty & lane1_empty & lane0_empty;

    outfifo_data <= current_data;
    
    outfifo_we <= '1' when want_we = '1' and data_ready = '1' and outfifo_full = '0' else '0';
    fifo_re(0) <= '1' when want_re(0) = '1' and fifo_empty(0) = '0' and (data_ready = '0' or outfifo_we = '1') else '0';
    fifo_re(1) <= '1' when want_re(1) = '1' and fifo_empty(1) = '0' and (data_ready = '0' or outfifo_we = '1') else '0';
    fifo_re(2) <= '1' when want_re(2) = '1' and fifo_empty(2) = '0' and (data_ready = '0' or outfifo_we = '1') else '0';
    fifo_re(3) <= '1' when want_re(3) = '1' and fifo_empty(3) = '0' and (data_ready = '0' or outfifo_we = '1') else '0';
    
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        data_ready <= '0';
        state <= IDLE;
        want_we <= '0';
        want_re <= (others => '0');
    elsif rising_edge(clk) then
        want_re <= (others => '0');
        want_we <= '0';
    
        case state is
            when IDLE =>
                if fifo_empty(current_channel) = '1' or use_lane(current_channel) = '0' or outfifo_full = '1' then
                    current_channel <= current_channel + 1;
                else
                    state <= HIT_LOOP;
                    want_re(current_channel) <= '1';
                end if;
    
            when HIT_LOOP =>
                word_counter <= X"3";
                want_re(current_channel) <= '1';
                if fifo_re(current_channel) = '1' then
                    state <= READ_HIT_FIRSTPACKET;
                    want_we <= '1';
                end if;
    
            when READ_HIT_FIRSTPACKET =>
                want_re(current_channel) <= '1';
                want_we <= '1';
                if fifo_re(current_channel) = '1' then
                    word_counter <= word_counter - 1;
                    if word_counter = 0 then
                        packet_counter <= unsigned(current_data(21 downto 16));
                        want_re(current_channel) <= '0';
                        state <= READ_HIT_ADC1;
                    end if;
                end if;
                
                
            when READ_HIT_ADC1 =>
                want_we <= '1';
                if data_ready = '0' then
                    want_we <= '0';
                    if packet_counter = 0 then
                        hit_counter <= hit_counter - 1;
                        state <= FINISH_HIT_LOOP;
                    else
                        packet_counter <= packet_counter - 1;
                        state <= READ_HIT_ADC2;
                        word_counter <= X"3";
                        want_re(current_channel) <= '1';
                    end if;
                end if;
                
            when READ_HIT_ADC2 =>
                want_re(current_channel) <= '1';
                want_we <= '1';
                if fifo_re(current_channel) = '1' then
                    word_counter <= word_counter - 1;
                    if word_counter = 0 then
                        want_re(current_channel) <= '0';
                        state <= READ_HIT_ADC1;
                    end if;
                end if;
                
            when FINISH_HIT_LOOP =>
                state <= IDLE;
                current_channel <= current_channel + 1;
                
        end case;
                
        if outfifo_we = '1' then -- and ignore_write = '0' then
            data_ready <= '0';
        end if;
        if fifo_re /= "0000" then -- and ignore_read = '0' then
            data_ready <= '1';
        end if;
    end if;
    end process;

end architecture_DigiReaderSM;
