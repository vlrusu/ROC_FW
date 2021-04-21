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
    
    crc_reset : out std_logic;
    crc_en : out std_logic;
    data_to_crc : out std_logic_vector(15 downto 0);
    data_from_crc : in std_logic_vector(15 downto 0);

    rxpacket_rdcnt : in std_logic_vector(10 downto 0);
    rxpacket_data : in std_logic_vector(15 downto 0);
    rxpacket_re : out std_logic;
    
    data_out : out std_logic_vector(15 downto 0);
    kchar_out : out std_logic_vector(1 downto 0)
);
end TxPacketWriter;
architecture architecture_TxPacketWriter of TxPacketWriter is


    type state_type is (IDLE, FIRSTREAD, FIRSTWORD, RUNNING, CRCWORD);
    signal state      : state_type;
    signal counter : integer range 0 to 5;
    signal tx_data : std_logic_vector(15 downto 0);
    signal tx_kchar : std_logic_vector(1 downto 0);

begin

    data_out <= tx_data;
    kchar_out <= tx_kchar;


    process(reset_n, clk)
    begin
    if reset_n = '0' then
        state <= IDLE;
        counter <= 0;
        tx_data <= X"BC3C";
        tx_kchar <= "11";
        
        rxpacket_re <= '0';
        crc_reset <= '1';
        crc_en <= '0';
    elsif rising_edge(clk) then
        tx_data <= X"BC3C";
        tx_kchar <= "11";
        crc_reset <= '1';
        crc_en <= '0';
        rxpacket_re <= '0';
        
        case state is
            when IDLE =>
                if unsigned(rxpacket_rdcnt) > 7 then
                    state <= FIRSTREAD;
                    rxpacket_re <= '1';
                end if;
                
            when FIRSTREAD =>
                crc_reset <= '0';
                rxpacket_re <= '1';
                state <= FIRSTWORD;
                
            
            when FIRSTWORD =>
                crc_reset <= '0';
                crc_en <= '1';
                rxpacket_re <= '1';
                tx_data(15 downto 4) <= rxpacket_data(15 downto 4);
                tx_data(3 downto 0) <= X"4";
                tx_kchar <= "10";
                state <= RUNNING;
                counter <= 5;
                
            when RUNNING =>
                crc_reset <= '0';
                crc_en <= '1';
                rxpacket_re <= '1';
                tx_data <= rxpacket_data;
                tx_kchar <= "00";
                data_to_crc <= rxpacket_data;
                counter <= counter - 1;
                if counter = 0 then
                    rxpacket_re <= '0';
                    state <= CRCWORD;
                end if;
            
            when CRCWORD =>
                crc_reset <= '0';
                crc_en <= '0';
                tx_data <= data_from_crc;
                tx_kchar <= "00";
                state <= IDLE;
            
        end case;
    end if;
    end process;

end architecture_TxPacketWriter;
