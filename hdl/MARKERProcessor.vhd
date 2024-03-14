--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: MARKERProcessor.vhd
-- File history:
--      <v1>: <08/30/2023>: MT  First version
--      <v2>: <02/28/2024>: MT  Revised after loopback marker definition
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
--    Pass Loopback Marker from RxProcessor to DTC via RxMkarkerFIFO
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

entity MARKERProcessor is
port (
    reset_n : in std_logic;
    clk     : in std_logic;
    
    marker_rdcnt  : in std_logic_vector(10 downto 0);
    marker_data_in: in std_logic_vector(17 downto 0);
    marker_re     : out std_logic;
    
    marker_data_out   : out std_logic_vector(17 downto 0);
    marker_data_en    : out std_logic
);
end MARKERProcessor;

architecture architecture_MARKERProcessor of MARKERProcessor is
   -- signal, component etc. declarations
    type state_type is (IDLE, WAITDATA, FIRSTDATA, SECONDDATA);
    signal state    : state_type;

begin
    process(reset_n, clk)
    begin
    if reset_n = '0' then
    
        marker_re         <= '0';
        marker_data_en    <= '0';
        marker_data_out   <= (others => '0');
        state             <= IDLE;
        
    elsif rising_edge(clk) then

        case state is 
        
        -- start reading two-word marker in RxMarkerFIFO
        when IDLE =>
            marker_data_en    <= '0';
            marker_data_out   <= (others => '0');
--            if unsigned(marker_rdcnt) > 1 then
            if unsigned(marker_rdcnt) > 0 then
                marker_re   <= '1';
                state       <= WAITDATA;
            end if;
            
        -- read second marker and wait fro data to exit the FIFO    
        when WAITDATA =>
            marker_re         <= '0';
            marker_data_en    <= '0';
            marker_data_out   <= (others => '0');
            state             <= FIRSTDATA;
         
        -- first word is in    
        when FIRSTDATA =>
            marker_re         <= '0';
            marker_data_en    <= '1';
            marker_data_out   <= marker_data_in;
--            state             <= SECONDDATA;
            state             <= IDLE;
            
        -- second word is in   
        when SECONDDATA =>
            marker_re         <= '0';
            marker_data_en    <= '1';
            marker_data_out   <= B"00" & marker_data_in(15 downto 0);
            state             <= IDLE;
            
        when others =>
            marker_re         <= '0';
            marker_data_en    <= '0';
            marker_data_out   <= (others => '0');
            state             <= IDLE;
            
        end case;
    end if;
end process;

   -- architecture body
end architecture_MARKERProcessor;
