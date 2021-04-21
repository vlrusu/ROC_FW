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

entity RxPacketReader is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    k_char : in std_logic_vector(1 downto 0);
    data_in : in std_logic_vector(15 downto 0);
    
    rxpacket_data : out std_logic_vector(19 downto 0);
    rxpacket_we : out std_logic
);
end RxPacketReader;
architecture architecture_RxPacketReader of RxPacketReader is


    type state_type is (IDLE, RUNNING);
    signal state      : state_type;
    signal counter : integer range 0 to 5;

begin


    process(reset_n, clk)
    begin
    if reset_n = '0' then
        state <= IDLE;
        counter <= 0;
        rxpacket_data <= (others => '0');
        rxpacket_we <= '0';
    elsif rising_edge(clk) then
        rxpacket_data <= "00" & k_char & data_in;
        
    
        case state is
            when IDLE =>
                rxpacket_we <= '0';
                if k_char = "10" and (
                        data_in(7 downto 0) /= x"10" and
                        data_in(7 downto 0) /= x"11" and
                        data_in(7 downto 0) /= x"12" and
                        data_in(7 downto 0) /= x"13" and
                        data_in(7 downto 0) /= x"14" and
                        data_in(7 downto 0) /= x"15" and
                        data_in(7 downto 0) /= x"EF" and
                        data_in(7 downto 0) /= x"EE" and
                        data_in(7 downto 0) /= x"ED" and
                        data_in(7 downto 0) /= x"EC" and
                        data_in(7 downto 0) /= x"EB" and
                        data_in(7 downto 0) /= x"EA") then
                    state <= RUNNING;
                    rxpacket_we <= '1';
                    counter <= 7;
                end if;
            
            when RUNNING =>
                rxpacket_we <= '1';
                counter <= counter - 1;
                if counter = 0 then
                    state <= IDLE;
                end if;
            
        end case;
    end if;
    end process;

end architecture_RxPacketReader;
