

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SerdesTxController is
port ( 
    reset_n : in std_logic;
    write_clk : in std_logic;
    read_clk : in std_logic;
    
    fifo_full : in std_logic;
    fifo_empty : in std_logic;
    
    fifo_we : out std_logic;
    fifo_re : out std_logic;
    
    req_usr_data : in std_logic;
    usr_data_rdy : out std_logic;
    usr_data_valid : out std_logic;
    
    write_words : in std_logic;
    write_count : in std_logic_vector(15 downto 0);
    
    --extra_data : out std_logic_vector(15 downto 0);
    
    fifo_rdcnt : in std_logic_vector(10 downto 0);

    data_to_fifo : out std_logic_vector(31 downto 0);
    data_from_fifo : in std_logic_vector(31 downto 0);
    
    data_to_serdes : out std_logic_vector(31 downto 0)
);
end SerdesTxController;
architecture architecture_SerdesTxController of SerdesTxController is

    signal write_counter : unsigned(15 downto 0);
    signal data_counter : unsigned(15 downto 0);
    signal write_words_1q : std_logic;
    signal write_words_2q : std_logic;
    
    signal req_usr_data1 : std_logic;
    signal req_usr_data2 : std_logic;
    signal req_usr_data3 : std_logic;
    signal req_usr_data4 : std_logic;
    signal usr_data_valid1 : std_logic;
    signal usr_data_valid2 : std_logic;
    signal usr_data_valid3 : std_logic;
    signal usr_data_valid4 : std_logic;
    signal usr_data_ready1 : std_logic;
    signal usr_data_ready2 : std_logic;
    signal usr_data_ready3 : std_logic;
    signal usr_data_ready4 : std_logic;
    signal data_in_buffer1 : std_logic;
    signal data_in_buffer2 : std_logic;
    signal data_in_buffer3 : std_logic;
    signal data_in_buffer4 : std_logic;
    signal fifo_empty1 : std_logic;
    signal fifo_empty2 : std_logic;
    signal fifo_empty3 : std_logic;
    signal fifo_empty4 : std_logic;
    signal fifo_re1 : std_logic;
    signal fifo_re2 : std_logic;
    signal fifo_re3 : std_logic;
    signal fifo_re4 : std_logic;

    signal one_word_left : std_logic;
    signal req_usr_data_1q : std_logic;
    
    signal buffered_data : std_logic_vector(31 downto 0);
    signal data_in_buffer : std_logic;
    signal data_was_in_buffer : std_logic;
    
    signal extra_data : std_logic_vector(15 downto 0);
    
    
    type state_type is (IDLE_EMPTY, LOAD_ONE_WORD, IDLE_ONE_WORD, READ_WORD, END1);
    signal state            : state_type;
    
    signal usr_data_rdy_ungated : std_logic;
    signal fifo_re_ungated : std_logic;
    
begin

    --data_to_serdes <= extra_data & fifo_empty4 & fifo_empty3 & fifo_empty2 & fifo_empty & fifo_re4 & fifo_re3 & fifo_re2 & fifo_re &  buffered_data(7 downto 0);
    --extra_data <= req_usr_data3 & req_usr_data2 & req_usr_data1 & req_usr_data & usr_data_valid4 & usr_data_valid3 & usr_data_valid2 & usr_data_valid & usr_data_ready4 & usr_data_ready3 & usr_data_ready2 & usr_data_rdy & data_in_buffer4 & data_in_buffer3 & data_in_buffer2 & data_in_buffer;

    process (reset_n, write_clk)
    begin
        if reset_n = '0' then
            data_to_fifo <= X"FFFFFFFF";
            fifo_we <= '0';
            write_counter <= (others => '0');
            data_counter <= (others => '0');
            write_words_1q <= '0';
            write_words_2q <= '0';
        elsif rising_edge(write_clk) then
            write_words_1q <= write_words;
            write_words_2q <= write_words_1q;
            if write_words_1q = '1' and write_words_2q = '0' then
                write_counter <= unsigned(write_count);
            end if;
            
            data_to_fifo <= X"FFFFFFFF";
            fifo_we <= '0';
            if write_counter > 0 and fifo_full = '0' then
                write_counter <= write_counter - 1;
                data_counter <= data_counter + 1;
                data_to_fifo <= X"0000" & std_logic_vector(data_counter);
                fifo_we <= '1';
            end if;
        end if;
    end process;
    
    fifo_re <= '1' when fifo_re_ungated = '1' and fifo_empty = '0' else '0'; -- takes one clock to turn on, turns off same clock as fifo_empty
    usr_data_rdy <= '1' when usr_data_rdy_ungated = '1' and not (req_usr_data_1q = '1' and fifo_empty = '1') else '0'; -- ready unless starting empty process
    
    data_to_serdes <= buffered_data;
    
    process (reset_n, read_clk)
    begin
        if reset_n = '0' then
            state <= IDLE_EMPTY;
            fifo_re_ungated <= '0';
            buffered_data <= (others => '0');
            req_usr_data_1q <= '0';
            usr_data_valid <= '0';
            usr_data_rdy_ungated <= '0';
            one_word_left <= '0';
        elsif rising_edge(read_clk) then
            buffered_data <= data_from_fifo;
            req_usr_data_1q <= req_usr_data;
            
            case state is
                when IDLE_EMPTY =>
                    if fifo_empty = '0' then
                        state <= LOAD_ONE_WORD;
                    end if;
                
                when LOAD_ONE_WORD =>
                    fifo_re_ungated <= '1';
                    state <= IDLE_ONE_WORD;
                
                when IDLE_ONE_WORD =>
                    fifo_re_ungated <= '0';
                    usr_data_rdy_ungated <= '1';
                    if req_usr_data = '1' then
                        state <= READ_WORD;
                        fifo_re_ungated <= '1';
                    end if;
                
                when READ_WORD =>
                    usr_data_valid <= '1';
                    if req_usr_data = '0' then
                        one_word_left <= '1';
                        fifo_re_ungated <= '0';
                        state <= END1;
                    end if;
                    if usr_data_rdy = '0' then
                        usr_data_rdy_ungated <= '0';
                        one_word_left <= '0';
                        fifo_re_ungated <= '0';
                        state <= END1;
                    end if;
                    
                when END1 =>
                    usr_data_valid <= '0';
                    fifo_re_ungated <= '0';
                    if one_word_left then
                        state <= IDLE_ONE_WORD;
                    else
                        state <= IDLE_EMPTY;
                    end if;
            
            end case;
        end if;
    end process;
                
                    
    --process (reset_n, read_clk)
    --begin
        --if reset_n = '0' then
            ----fifo_re <= '0';
            ----usr_data_rdy <= '0';
            --usr_data_valid <= '0';
            --req_usr_data1 <= '0';
            --req_usr_data2 <= '0';
            --req_usr_data3 <= '0';
            --req_usr_data4 <= '0';
            --usr_data_valid1 <= '0';
            --usr_data_valid2 <= '0';
            --usr_data_valid3 <= '0';
            --usr_data_valid4 <= '0';
            --usr_data_ready1 <= '0';
            --usr_data_ready2 <= '0';
            --usr_data_ready3 <= '0';
            --usr_data_ready4 <= '0';
            --data_in_buffer1 <= '0';
            --data_in_buffer2 <= '0';
            --data_in_buffer3 <= '0';
            --data_in_buffer4 <= '0';
            --fifo_empty1 <= '0';
            --fifo_empty2 <= '0';
            --fifo_empty3 <= '0';
            --fifo_empty4 <= '0';
            --fifo_re1 <= '0';
            --fifo_re2 <= '0';
            --fifo_re3 <= '0';
            --fifo_re4 <= '0';
            --req_usr_data_1q <= '0';
            --buffered_data <= (others => '0');
            --data_was_in_buffer <= '0';
        --elsif rising_edge(read_clk) then
            --req_usr_data1 <= req_usr_data;
            --req_usr_data2 <= req_usr_data1;
            --req_usr_data3 <= req_usr_data2;
            --req_usr_data4 <= req_usr_data3;
            ----usr_data_valid1 <= usr_data_valid;
            --usr_data_valid2 <= usr_data_valid;
            --usr_data_valid3 <= usr_data_valid2;
            --usr_data_valid4 <= usr_data_valid3;
            --usr_data_ready2 <= usr_data_rdy;
            --usr_data_ready3 <= usr_data_ready2;
            --usr_data_ready4 <= usr_data_ready3;
            --data_in_buffer2 <= data_in_buffer;
            --data_in_buffer3 <= data_in_buffer2;
            --data_in_buffer4 <= data_in_buffer3;
            --fifo_empty2 <= fifo_empty;
            --fifo_empty3 <= fifo_empty2;
            --fifo_empty4 <= fifo_empty3;
            --fifo_re2 <= fifo_re;
            --fifo_re3 <= fifo_re2;
            --fifo_re4 <= fifo_re3;
            --
            --req_usr_data_1q <= req_usr_data;
            --
            --usr_data_valid <= '1' when req_usr_data = '1' and req_usr_data_1q = '1' else '0';
            --
            --if usr_data_valid = '1' and fifo_re = '0' then
                --data_was_in_buffer <= '0';
            --end if;
            --if fifo_re = '1' then
                --data_was_in_buffer <= '1';
                --buffered_data <= data_from_fifo;
            --end if;
            --
        --end if;
    --end process;
    --
    --one_word_left <= '1' when fifo_empty = '1' and data_in_buffer = '1' else '0';
    --data_in_buffer <= '1' when (fifo_re = '1' or (usr_data_valid = '0' and data_was_in_buffer = '1')) else '0';
    --fifo_re <= '1' when (data_was_in_buffer = '0' or usr_data_valid = '1') and fifo_empty = '0' else '0';
    --usr_data_rdy <= '1' when (fifo_empty = '0' or data_in_buffer = '1') and (req_usr_data_1q = '0' or one_word_left = '0') else '0';

end architecture_SerdesTxController;
