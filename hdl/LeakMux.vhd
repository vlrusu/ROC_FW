--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: LeakMux.vhd
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

entity LeakMux is
port (
    muxselect : in std_logic;
    
    HV_PREAMP_MOSI : in std_logic;
    
    
    LEAK_SCL : in std_logic;
    LEAK_SDI : out std_logic;
    LEAK_SDO : in std_logic;
    LEAK_SDA_DIR : in std_logic;
    
    
    
    HV_PREAMP_FCLK_out : out std_logic;
    HV_PREAMP_MOSI_out : inout std_logic
);
end LeakMux;
architecture architecture_LeakMux of LeakMux is

begin

    LEAK_SDI <= HV_PREAMP_MOSI_out;

    ac_statemachine : process(LEAK_SDA_DIR, muxselect)
	begin
        if muxselect = '1' then
            if LEAK_SDA_DIR = '0' then
                HV_PREAMP_MOSI_out <= 'Z';
            else
                HV_PREAMP_MOSI_out <= LEAK_SDO;
            end if;
            HV_PREAMP_FCLK_out <= LEAK_SCL;
        else
            HV_PREAMP_MOSI_out <= HV_PREAMP_MOSI;
            HV_PREAMP_FCLK_out <= '1';
            
        end if;
    end process;


end architecture_LeakMux;
