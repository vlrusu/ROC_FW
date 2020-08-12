--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SerdesInitializer.vhd
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

entity SerdesInitializer is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    litefast_aligned : in std_logic;
    rx_val : in std_logic;
    code_violation : in std_logic_vector(3 downto 0);
    disp_error : in std_logic_vector(3 downto 0);
    
    pcs_reset_n : out std_logic;
    pma_reset_n : out std_logic;
    
    reset_cycle_count : out std_logic_vector(7 downto 0);
    rx_notval_cycle_count : out std_logic_vector(7 downto 0);
    litefast_unaligned_cycle_count : out std_logic_vector(7 downto 0);
    
    stable_lock : out std_logic
);
end SerdesInitializer;
architecture architecture_SerdesInitializer of SerdesInitializer is
   
    signal reset_serdes_n : std_logic;
   
    signal litefast_unaligned_countdown : unsigned(8 downto 0);
    signal rx_notval_countdown : unsigned(19 downto 0);
    signal reset_countdown : unsigned(5 downto 0);
    
    signal rx_val_1q : std_logic;
    signal litefast_aligned_1q : std_logic;
    signal code_violation_1q : std_logic_vector(3 downto 0);
    signal disp_error_1q : std_logic_vector(3 downto 0);
    
    signal rx_completely_valid : std_logic;
    
    signal serdes_state : std_logic_vector(1 downto 0);

begin
    
    pcs_reset_n <= reset_serdes_n;
    pma_reset_n <= reset_serdes_n;
    
    rx_completely_valid <= '1' when rx_val_1q = '1' and code_violation_1q = X"0" and disp_error_1q = X"0" else '0';
    
    process (reset_n, clk)
    begin
    if reset_n = '0' then
        reset_serdes_n <= '1';
        litefast_unaligned_countdown <= (others => '1');
        rx_notval_countdown <= (others => '1');
        reset_countdown <= (others => '1');
        
        rx_val_1q <= '0';
        litefast_aligned_1q <= '0';
        code_violation_1q <= (others => '0');
        disp_error_1q <= (others => '0');
        
        stable_lock <= '0';
        serdes_state <= "01"; -- start assuming failed
        
        reset_cycle_count <= (others => '0');
        rx_notval_cycle_count <= (others => '0');
        litefast_unaligned_cycle_count <= (others => '0');
    elsif rising_edge(clk) then
        rx_val_1q <= rx_val;
        litefast_aligned_1q <= litefast_aligned;
        code_violation_1q <= code_violation;
        disp_error_1q <= disp_error;
        
        -- check if serdes setup is complete and successful
        if serdes_state = "00" then
            reset_countdown <= (others => '1');
            if rx_completely_valid = '1' then -- if is valid, if litefast not aligned for certain number of clocks, then reset
                if litefast_aligned_1q = '1' then
                    serdes_state <= "10"; -- success, go to stable
                else
                    litefast_unaligned_countdown <= litefast_unaligned_countdown - 1;
                    if litefast_unaligned_countdown = 0 then
                        serdes_state <= "01"; -- failed, reset
                        litefast_unaligned_cycle_count <= std_logic_vector(unsigned(litefast_unaligned_cycle_count) + 1);
                    end if;
                end if;
            else -- if not valid, wait countdown number of clocks, then reset
                litefast_unaligned_countdown <= (others => '1');
                if (rx_notval_countdown = 0) then		 
                    serdes_state <= "01"; -- failed, reset
                    rx_notval_cycle_count <= std_logic_vector(unsigned(rx_notval_cycle_count) + 1);
                else				  
                    rx_notval_countdown <= rx_notval_countdown - 1;	
                end if;	
            end if;
        
        -- reset PMA
        elsif serdes_state = "01" then
            litefast_unaligned_countdown <= (others => '1');
            rx_notval_countdown <= (others => '1');
            if reset_countdown = 0 then
                serdes_state <= "00";
                reset_cycle_count <= std_logic_vector(unsigned(reset_cycle_count) + 1);
            else
                reset_countdown <= reset_countdown - 1;
                if reset_countdown > 40 then
                    reset_serdes_n <= '0';
                else
                    reset_serdes_n <= '1';
                end if;
            end if;
    
        -- successful, idle until something breaks
        elsif serdes_state = "10" then
            litefast_unaligned_countdown <= (others => '1');
            rx_notval_countdown <= (others => '1');
            reset_countdown <= (others => '1');
            stable_lock <= '1';
            if rx_completely_valid = '0' or litefast_aligned_1q = '0' then
                serdes_state <= "01";
                stable_lock <= '0';
            end if;
            --if start_manual_reset = '1' then
            --    start_manual_reset = '0';
            --    serdes_state <= "01";
            --end if;
        end if;
    end if;
    end process;

   -- architecture body
end architecture_SerdesInitializer;
