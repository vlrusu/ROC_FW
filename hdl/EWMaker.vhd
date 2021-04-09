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
    digi_reset_n : in std_logic;
    digi_clk : in std_logic;

    external_ewm_50mhz : in std_logic;

    ewm_enable_50mhz : in std_logic;
    ewm_period_5ns : in std_logic_vector(15 downto 0);
    --event_window_early_cut : in std_logic_vector(15 downto 0);
    --event_window_late_cut : in std_logic_vector(15 downto 0);
    ewm : out std_logic
    --ewm_active : out std_logic
);
end EWMaker;
architecture architecture_EWMaker of EWMaker is

    signal counter : unsigned(15 downto 0);
    signal ewm_generated : std_logic;
    
    signal external_ewm : std_logic;
    signal external_ewm_1Q : std_logic;
    signal external_ewm_2Q : std_logic;
    signal external_ewm_3Q : std_logic;
    signal ewm_enable : std_logic;
    signal ewm_enable_1Q : std_logic;
    signal ewm_enable_2Q : std_logic;

begin


    process (digi_clk)
    begin
    if rising_edge(digi_clk) then
        external_ewm_1Q <= external_ewm_50mhz;
        external_ewm_2Q <= external_ewm_1Q;
        external_ewm_3Q <= external_ewm_2Q;
        ewm_enable_1Q <= ewm_enable_50mhz;
        ewm_enable_2Q <= ewm_enable_1Q;
    end if;
    end process;

    external_ewm <= (external_ewm_2Q and not external_ewm_3Q);
    ewm_enable <= ewm_enable_2Q;


    ewm <= external_ewm or (ewm_generated and ewm_enable);

process(digi_reset_n,digi_clk)
begin
if digi_reset_n = '0' then
    ewm_generated <= '0';
    --ewm_active <= '0';
    counter <= (others => '0');
elsif rising_edge(digi_clk) then
    counter <= counter + 1;
    ewm_generated <= '0';
    if counter = unsigned(ewm_period_5ns) then
        ewm_generated <= '1';
        counter <= (others => '0');
    end if;
    --if counter >= unsigned(event_window_early_cut) and counter <= unsigned(event_window_late_cut) then
    --    ewm_active <= '1';
    --else
    --    ewm_active <= '0';
    --end if;
end if;
end process;

end architecture_EWMaker;
