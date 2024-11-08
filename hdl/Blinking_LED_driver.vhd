--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Blinking_LED_driver.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all; 

entity Blinking_LED_driver is
port (
	CLK     : IN  std_logic; 
    RESETN  : IN  std_logic;
    
    SIGIN   : IN  std_logic;
    LED_OFF : IN  std_logic;
    SIGOUT  : OUT std_logic
);
end Blinking_LED_driver;

architecture architecture_Blinking_LED_driver of Blinking_LED_driver is
   -- signal, component etc. declarations
    signal clk_counter      : unsigned(30 downto 0);

begin
   -- architecture body
    process(CLK, RESETN)
    begin
    if RESETN = '0' then
        SIGOUT          <= '1';
        clk_counter     <= (others => '0');
    elsif rising_edge(CLK) then
        if  SIGIN = '1' then
            if (LED_OFF = '0') then
                clk_counter <= clk_counter + 1;
                
                if  clk_counter(26) = '1'   then
                    SIGOUT      <= not(SIGOUT);
                    clk_counter <= (others => '0');
                end if;
            else
                SIGOUT  <= '0';
                clk_counter <= (others => '0');
            end if;
        else
            SIGOUT  <= '1';
            clk_counter <= (others => '0');
        end if;
    end if;
    end process;

end architecture_Blinking_LED_driver;