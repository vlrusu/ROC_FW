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
    
    dcs_fifo_rdcnt : in std_logic_vector(10 downto 0);
    dcs_fifo_re : out std_logic;
    dcs_fifo_data_in : in std_logic_vector(17 downto 0);

    dreq_fifo_rdcnt : in std_logic_vector(10 downto 0);
    dreq_fifo_re : out std_logic;
    dreq_fifo_data_in : in std_logic_vector(17 downto 0);
    
    tx_data_out : out std_logic_vector(15 downto 0);
    tx_kchar_out : out std_logic_vector(1 downto 0);
    
    dtc_pkt_count: out std_logic_vector(15 downto 0)
);
end TxPacketWriter;
architecture architecture_TxPacketWriter of TxPacketWriter is


    type tx_state_type is (IDLE, RUNNING1, RUNNING2);
    signal tx_state      : tx_state_type;
    signal tx_data : std_logic_vector(15 downto 0);
    signal tx_kchar : std_logic_vector(1 downto 0);
    signal tx_word_count : integer range 0 to 31;
    signal sequence_num : std_logic_vector(2 downto 0);

begin

    tx_data_out <= tx_data;
    tx_kchar_out <= tx_kchar;
    
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        tx_data <= X"BC3C";
        tx_kchar <= "11";
        tx_word_count <= 0;
        tx_state <= IDLE;
        sequence_num <= (others => '0');
        dtc_pkt_count<= (others => '0');
    elsif rising_edge(clk) then
        dcs_fifo_re <= '0';
        dreq_fifo_re <= '0';
        tx_data <= X"BC3C";
        tx_kchar <= "11";
        case tx_state is
            when IDLE =>
                tx_word_count <= 0;
                if unsigned(dcs_fifo_rdcnt) > 9 then  -- give priority to DCS packets 
                    dcs_fifo_re <= '1';
                    tx_state <= RUNNING1;
                elsif unsigned(dreq_fifo_rdcnt) > 9 then
                    dreq_fifo_re <= '1';
                    tx_state <= RUNNING2;
                end if;
                
            when RUNNING1 =>
                tx_word_count <= tx_word_count + 1;
                if tx_word_count < 9 then
                    dcs_fifo_re <= '1';
                end if;
                if tx_word_count = 1 then
                    tx_data <= dcs_fifo_data_in(15 downto 8) & sequence_num & dcs_fifo_data_in(4 downto 0);
                    tx_kchar <= dcs_fifo_data_in(17 downto 16);
                elsif tx_word_count > 1 then
                    tx_data <= dcs_fifo_data_in(15 downto 0);
                    tx_kchar <= dcs_fifo_data_in(17 downto 16);
                end if;
                if tx_word_count = 10 then
                    sequence_num <= std_logic_vector(unsigned(sequence_num) + 1);
                    dtc_pkt_count  <= std_logic_vector(unsigned(dtc_pkt_count) + 1);
                    tx_state <= IDLE;
                end if;
                
            when RUNNING2 =>
                tx_word_count <= tx_word_count + 1;
                if tx_word_count < 9 then
                    dreq_fifo_re <= '1';
                end if;
                if tx_word_count = 1 then
                    tx_data <= dreq_fifo_data_in(15 downto 8) & sequence_num & dreq_fifo_data_in(4 downto 0);
                    tx_kchar <= dreq_fifo_data_in(17 downto 16);
                elsif tx_word_count > 1 then
                    tx_data <= dreq_fifo_data_in(15 downto 0);
                    tx_kchar <= dreq_fifo_data_in(17 downto 16);
                end if;
                if tx_word_count = 10 then
                    sequence_num <= std_logic_vector(unsigned(sequence_num) + 1);
                    dtc_pkt_count  <= std_logic_vector(unsigned(dtc_pkt_count) + 1);
                    tx_state <= IDLE;
                end if;
        end case;
    end if;
    end process;

end architecture_TxPacketWriter;
