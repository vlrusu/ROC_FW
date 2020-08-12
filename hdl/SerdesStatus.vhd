--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SerdesStatus.vhd
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

entity SerdesStatus is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    tx_clk_stable : in std_logic;
    crc_err_rx : in std_logic;
    usr_data_val : in std_logic;
    lane_aligned : in std_logic;
    rx_val : in std_logic;
    rx_idle : in std_logic;
    rx_ready : in std_logic;
    block_aligned : in std_logic;
    disparity_error : in std_logic_vector(3 downto 0);
    code_violation : in std_logic_vector(3 downto 0);
    local_token : in std_logic_vector(7 downto 0);
    remote_token : in std_logic_vector(7 downto 0);
    stable_lock : in std_logic;
    reset_cycle_count : in std_logic_vector(7 downto 0);
    rx_notval_cycle_count : in std_logic_vector(7 downto 0);
    litefast_unaligned_cycle_count : in std_logic_vector(7 downto 0);
    
    address : in std_logic_vector(3 downto 0);
    
    registered_out : out std_logic_vector(7 downto 0)
);
end SerdesStatus;
architecture architecture_SerdesStatus of SerdesStatus is
    signal tx_clk_stable_1q : std_logic;
    signal crc_err_rx_1q : std_logic;
    signal usr_data_val_1q : std_logic;
    signal lane_aligned_1q : std_logic;
    signal rx_val_1q : std_logic;
    signal rx_idle_1q : std_logic;
    signal rx_ready_1q : std_logic;
    signal block_aligned_1q : std_logic;
    signal disparity_error_1q : std_logic_vector(3 downto 0);
    signal code_violation_1q : std_logic_vector(3 downto 0);
    signal local_token_1q : std_logic_vector(7 downto 0);
    signal remote_token_1q : std_logic_vector(7 downto 0);
    signal stable_lock_1q : std_logic;
    signal reset_cycle_count_1q : std_logic_vector(7 downto 0);
    signal rx_notval_cycle_count_1q : std_logic_vector(7 downto 0);
    signal litefast_unaligned_cycle_count_1q : std_logic_vector(7 downto 0);

begin

    process (reset_n, clk)
    begin
    if reset_n = '0' then
        tx_clk_stable_1q <= '0';
        crc_err_rx_1q <= '0';
        usr_data_val_1q <= '0';
        lane_aligned_1q <= '0';
        rx_val_1q <= '0';
        rx_idle_1q <= '0';
        rx_ready_1q <= '0';
        block_aligned_1q <= '0';
        disparity_error_1q <= (others => '0');
        code_violation_1q <= (others => '0');
        local_token_1q <= (others => '0');
        remote_token_1q <= (others => '0');
        stable_lock_1q <= '0';
        reset_cycle_count_1q <= (others =>  '0');
        rx_notval_cycle_count_1q <= (others => '0');
        litefast_unaligned_cycle_count_1q <= (others => '0');
    elsif rising_edge(clk) then
        tx_clk_stable_1q <= tx_clk_stable;
        crc_err_rx_1q <= crc_err_rx;
        usr_data_val_1q <= usr_data_val;
        lane_aligned_1q <= lane_aligned;
        rx_val_1q <= rx_val;
        rx_idle_1q <= rx_idle;
        rx_ready_1q <= rx_ready;
        block_aligned_1q <= block_aligned;
        disparity_error_1q <= disparity_error;
        code_violation_1q <= code_violation;
        local_token_1q <= local_token;
        remote_token_1q <= remote_token;
        stable_lock_1q <= stable_lock;
        reset_cycle_count_1q <= reset_cycle_count;
        rx_notval_cycle_count_1q <= rx_notval_cycle_count;
        litefast_unaligned_cycle_count_1q <= litefast_unaligned_cycle_count;
        
        registered_out <= (others => '0');
        case address is
                when X"0" =>
                    registered_out(0) <= tx_clk_stable_1q;
                when X"1" =>
                    registered_out(0) <= crc_err_rx_1q;
                when X"2" =>
                    registered_out(0) <= usr_data_val_1q;
                when X"3" =>
                    registered_out(0) <= lane_aligned_1q;
                when X"4" =>
                    registered_out(0) <= rx_val_1q;
                when X"5" =>
                    registered_out(0) <= rx_idle_1q;
                when X"6" =>
                    registered_out(0) <= rx_ready_1q;
                when X"7" =>
                    registered_out(0) <= block_aligned_1q;
                when X"8" =>
                    registered_out(3 downto 0) <= disparity_error_1q;
                when X"9" =>
                    registered_out(3 downto 0) <= code_violation_1q;
                when X"A" =>
                    registered_out <= local_token_1q;
                when X"B" =>
                    registered_out <= remote_token_1q;
                when X"C" =>
                    registered_out <= reset_cycle_count_1q;
                when X"D" =>
                    registered_out <= rx_notval_cycle_count_1q;
                when X"E" =>
                    registered_out <= litefast_unaligned_cycle_count_1q;
                when X"F" =>
                    registered_out(0) <= stable_lock_1q;
                    
                
                when others =>
                    registered_out <= (others => '0');
        end case;
    end if;
    end process;
        

   -- architecture body
end architecture_SerdesStatus;
