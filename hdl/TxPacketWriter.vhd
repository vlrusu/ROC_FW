--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: RxPacketReader.vhd
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

entity TxPacketWriter is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    fifo_rdcnt : in std_logic_vector(10 downto 0);
    fifo_re : out std_logic;
    fifo_data_in : in std_logic_vector(17 downto 0);
    
    data_out : out std_logic_vector(15 downto 0);
    kchar_out : out std_logic_vector(1 downto 0)
);
end TxPacketWriter;
architecture architecture_TxPacketWriter of TxPacketWriter is


    type state_type is (IDLE, RUNNING);
    signal state      : state_type;
    signal tx_data : std_logic_vector(15 downto 0);
    signal tx_kchar : std_logic_vector(1 downto 0);
    signal word_count : integer range 0 to 31;

begin

    data_out <= tx_data;
    kchar_out <= tx_kchar;
    
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        tx_data <= X"BC3C";
        tx_kchar <= "11";
        word_count <= 0;
        state <= IDLE;
    elsif rising_edge(clk) then
        fifo_re <= '0';
        tx_data <= X"BC3C";
        tx_kchar <= "11";
        case state is
            when IDLE =>
                word_count <= 0;
                if unsigned(fifo_rdcnt) > 9 then
                    fifo_re <= '1';
                    state <= RUNNING;
                end if;
                
            when RUNNING =>
                word_count <= word_count + 1;
                if word_count < 9 then
                    fifo_re <= '1';
                end if;
                if word_count > 0 then
                    tx_data <= fifo_data_in(15 downto 0);
                    tx_kchar <= fifo_data_in(17 downto 16);
                end if;
                if word_count = 10 then
                    state <= IDLE;
                end if;
        end case;
    end if;
    end process;

end architecture_TxPacketWriter;
