--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: delay_sreg_1bit.vhd
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
use IEEE.numeric_std.all;

library work;
use work.algorithm_constants.all; 

entity delay_sreg_1bit is
  port (
    clk     : in std_logic;
    resetn  : in std_logic; 
  
    sr_delay: std_logic_vector(10 downto 0);
    
    sr_in   : in std_logic;
    sr_out  : out std_logic
  );
end delay_sreg_1bit;


architecture slicing_with_rst of delay_sreg_1bit is

    signal sr_depth : integer range 2 to 2047;
    signal sr       : std_logic_vector(2047 downto 0);
    
    signal delay_sel: std_logic;
    signal sr_temp  : std_logic;
    
begin
  
    sr_depth <= to_integer(unsigned(sr_delay));

    -- MUX for undelayed outout if so desired
    delay_sel <= '0' when  sr_depth = 0   else '1';
    
    with delay_sel select
        sr_out  <=  sr_in   when '0',
                    sr_temp when '1';
    
    -- process to set delay based on value of SR_DELAY
    process(clk, resetn)
    begin
        if resetn = '0' then
            sr      <= (others => '0');
            sr_temp <= '0';
        elsif rising_edge(clk) then
            if sr_depth < 2 then
                sr_temp <= sr_in;
            else
                sr      <= sr(2046 downto 0) & sr_in;
                sr_temp <= sr(sr_depth-2);
            end if;
        end if;
    end process;
   
  
end architecture slicing_with_rst;
