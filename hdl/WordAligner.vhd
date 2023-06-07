--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: WordAligner.vhd
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

entity WordAligner is
port (
    reset_n : in std_logic;
    clk     : in std_logic;
    k_char_in   : in std_logic_vector(1 downto 0);
    data_in : in std_logic_vector(15 downto 0);
    
    word_aligned: out std_logic;
    k_char_out  : out std_logic_vector(1 downto 0);
    data_out    : out std_logic_vector(15 downto 0)
);
end WordAligner;
architecture architecture_WordAligner of WordAligner is

    signal alignment_counter : unsigned(3 downto 0);
    signal offset : std_logic;
    signal k_char_1Q : std_logic_vector(1 downto 0);
    signal data_1Q : std_logic_vector(15 downto 0);

begin

--    k_char_out <= k_char_in when offset = '0' else k_char_1Q(0) & k_char_in(1);
--    data_out <= data_in when offset = '0' else data_1Q(7 downto 0) & data_in(15 downto 8);
    k_char_out  <= k_char_in when offset = '0' else k_char_in(0) & k_char_1Q(1);
    data_out    <= data_in when offset = '0' else data_in(7 downto 0) & data_1Q(15 downto 8);

    process(reset_n, clk)
    begin
    if reset_n = '0' then
        word_aligned <= '0';
        alignment_counter <= (others => '1');
        offset <= '0';
        k_char_1Q <= "00";
        data_1Q <= (others => '0');
    elsif rising_edge(clk) then
        k_char_1Q <= k_char_in;
        data_1Q <= data_in;
    
        if k_char_in = "11" then
            if data_in = X"BC3C" then
                if offset = '1' then
                    word_aligned <= '0';
                    offset <= '0';
                    alignment_counter <= (others => '1');
                end if;
                if word_aligned = '0' then
                    alignment_counter <= alignment_counter - 1;
                    if alignment_counter = 0 then
                        word_aligned <= '1';
                    end if;
                end if;
            elsif data_in = X"3CBC" then
                if offset = '0' then
                    word_aligned <= '0';
                    offset <= '1';
                    alignment_counter <= (others => '1');
                end if;
                if word_aligned = '0' then
                    alignment_counter <= alignment_counter - 1;
                    if alignment_counter = 0 then
                        word_aligned <= '1';
                    end if;
                end if;
            end if;
        end if;
        
    end if;
    end process;

end architecture_WordAligner;
