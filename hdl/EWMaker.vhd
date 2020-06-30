--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: EWMaker.vhd
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

entity EWMaker is
port (
        reset_n : in std_logic;
    clk : in std_logic;

    external_ewm : in std_logic;

    enable : in std_logic;
    delay : in std_logic_vector(15 downto 0);
    event_window_early_cut : in std_logic_vector(15 downto 0);
    event_window_late_cut : in std_logic_vector(15 downto 0);
    ewm : out std_logic;
    ewm_active : out std_logic
);
end EWMaker;
architecture architecture_EWMaker of EWMaker is

    signal counter : unsigned(15 downto 0);
    signal ewm_generated : std_logic;

begin

    ewm <= external_ewm or (ewm_generated and enable);

process(reset_n,clk)
begin
if reset_n = '0' then
    ewm_generated <= '0';
    ewm_active <= '0';
    counter <= (others => '0');
elsif rising_edge(clk) then
    counter <= counter + 1;
    ewm_generated <= '0';
    if counter = unsigned(delay) then
        ewm_generated <= '1';
        counter <= (others => '0');
    end if;
    if counter >= unsigned(event_window_early_cut) and counter <= unsigned(event_window_late_cut) then
        ewm_active <= '1';
    else
        ewm_active <= '0';
    end if;
end if;
end process;

end architecture_EWMaker;
