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
  
    sr_delay: std_logic_vector(9 downto 0);
    
    sr_in   : in std_logic;
    sr_out  : out std_logic
  );
end delay_sreg_1bit;


architecture slicing_with_rst of delay_sreg_1bit is

    type sr_ram_t is array (0 to 1023) of std_logic;

    signal sr_ram       : sr_ram_t;
    signal wr_ptr       : unsigned(9 downto 0);
    signal stored_count : unsigned(9 downto 0);
    signal sr_temp      : std_logic;
    
begin

    sr_out <= sr_in when unsigned(sr_delay) = 0 else sr_temp;
    
    -- Use a circular buffer so the delay can span the full 10-bit range.
    process(clk, resetn)
        variable rd_ptr : unsigned(9 downto 0);
    begin
        if resetn = '0' then
            wr_ptr       <= (others => '0');
            stored_count <= (others => '0');
            sr_temp      <= '0';
        elsif rising_edge(clk) then
            if unsigned(sr_delay) = 0 then
                sr_temp <= sr_in;
            elsif stored_count < unsigned(sr_delay) then
                sr_temp <= '0';
            else
                rd_ptr := wr_ptr - unsigned(sr_delay);
                sr_temp <= sr_ram(to_integer(rd_ptr));
            end if;

            sr_ram(to_integer(wr_ptr)) <= sr_in;
            wr_ptr <= wr_ptr + 1;

            if stored_count /= "1111111111" then
                stored_count <= stored_count + 1;
            end if;
        end if;
    end process;
   
  
end architecture slicing_with_rst;
