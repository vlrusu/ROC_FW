--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: evm_delay_fifo_driver.vhd
-- File history:
--      <v1>: <03/07/2024>: first version
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--    Delays Event Window Marker by EVM_DELAY 5ns clocks.
--    Drives external FIFO 2048 cycles deep.
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG484>
-- Author: Luca Morescalchi
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use IEEE.std_logic_1164.all;

entity evm_delay_fifo_driver is
port (

    reset_n : in std_logic;
    clk : in std_logic;
        
    evm_delay : in std_logic_vector(10 downto 0);
        
    re_fifo : out std_logic;
    we_fifo : out std_logic;
        
    fifo_reset : out std_logic

);
end evm_delay_fifo_driver;
architecture architecture_evm_delay_fifo_driver of evm_delay_fifo_driver is

type state_type is (IDLE, RESETTING, WAITING);
signal FSM_STATE    : state_type;

signal evm_delay_int : std_logic_vector(10 downto 0);
signal counter : std_logic_vector(10 downto 0);
signal rfc : std_logic_vector(2 downto 0);

begin

    process(reset_n,clk)
    begin
    if reset_n = '0' then
            
        evm_delay_int <= (others => '0');
        counter <= (others => '0');
        fifo_reset <= '0';
        re_fifo <= '0';
        we_fifo <= '0';
        rfc <= (others => '0');
        FSM_STATE <= WAITING;
            
    elsif rising_edge(clk) then
            
        evm_delay_int <= evm_delay;
            
        case FSM_STATE is
            
            when IDLE =>
                
                re_fifo <= '1';
                we_fifo <= '1';
                fifo_reset <= '1';
                
                if(evm_delay_int /=evm_delay) then
                    FSM_STATE <= RESETTING;
                else
                    FSM_STATE <= IDLE;
                end if;
            
            when RESETTING =>
                
                fifo_reset <= '0';
                re_fifo <= '0';
                we_fifo <= '0';
                
                if(rfc = "111") then
                    FSM_STATE <= WAITING;
                    rfc <= (others => '0');
                else
                    FSM_STATE <= RESETTING;
                    rfc <= rfc + '1';
                end if;
            
            when WAITING =>
                
                fifo_reset <= '1';
                re_fifo <= '0';
                we_fifo <= '1';
                
                if(counter = evm_delay_int) then
                    FSM_STATE <= IDLE;
                    counter <= (others => '0');
                else
                    FSM_STATE <= WAITING;
                    counter <= counter + '1';
                end if;
            
            when others =>
                
                FSM_STATE <= RESETTING;
                rfc <= (others => '0');
                counter <= (others => '0');
            
        end case;
            
    end if;
    end process;

end architecture_evm_delay_fifo_driver;