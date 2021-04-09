--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: EventMarker.vhd
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
use IEEE.NUMERIC_STD.all; 

entity EventMarker is
port (
    EPCS_RXCLK  : in std_logic;
	RESET_N     : in std_logic;
    
    RX_DATA     : in std_logic_vector(15 downto 0);
    RX_K_CHAR   : in std_logic_vector(1 downto 0);
    event_marker_count : out std_logic_vector(15 downto 0);
    eventmarker : out std_logic
);
end EventMarker;
architecture architecture_EventMarker of EventMarker is
    signal counter : unsigned(2 downto 0);
    signal rx_k_char_latch : std_logic_vector(1 downto 0);
    signal rx_k_char_latch_prev : std_logic_vector(1 downto 0);
    signal rx_data_latch : std_logic_vector(15 downto 0);
    signal rx_data_latch_prev : std_logic_vector(15 downto 0);                                                         

begin	

    process(reset_n, EPCS_RXCLK)
    begin
    if reset_n = '0' then
        counter <= (others => '1');
        eventmarker <= '0';
        event_marker_count <= (others => '0');
        rx_k_char_latch_prev <= (others => '0');
        rx_data_latch_prev <= (others => '0');
    elsif rising_edge(EPCS_RXCLK) then			
        rx_k_char_latch	<= RX_K_CHAR;
        rx_data_latch	<= RX_DATA;	
        rx_data_latch_prev 	<= rx_data_latch; 
		rx_k_char_latch_prev	<= rx_k_char_latch;
        
        eventmarker <= '0';
        if counter = 2 then
            eventmarker <= '1';
            event_marker_count <= std_logic_vector(unsigned(event_marker_count) + 1);
        end if;
    
    
        if counter < 5 then
            counter <= counter + 1;
        else
            if rx_k_char_latch_prev = "10" then
                if rx_k_char_latch = "10" then
                    if (rx_data_latch_prev = X"1C10" and rx_data_latch = X"1CEF") or (rx_data_latch_prev = X"1C11" and rx_data_latch = X"1CEE") then
                        counter <= (others => '0');
                    end if;
                end if;
            elsif rx_k_char_latch_prev = "01" then
                if rx_k_char_latch = "01" then
                    if (rx_data_latch_prev = X"101C" and rx_data_latch = X"EF1C") or (rx_data_latch_prev = X"111C" and rx_data_latch = X"EE1C") then
                        counter <= (others => '0');
                    end if;
                end if;
            end if;
        end if;

    end if;
    end process;

end architecture_EventMarker;
