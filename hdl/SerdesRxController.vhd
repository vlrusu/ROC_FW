--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SerdesRxController.vhd
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity SerdesRxController is
generic (
  FIFO_ADDRESS_WIDTH : integer := 13);
port (
    reset_n : in std_logic;
    clk : in std_logic;
    k_in : in std_logic_vector(3 downto 0);
    data_in : in std_logic_vector(31 downto 0);
    rx_valid : in std_logic;

    rx_code_violation : in std_logic_vector(3 downto 0);
    rx_disparity_error : in std_logic_vector(3 downto 0);
    serdes_aligned : out std_logic;

    fifo_full : in std_logic;
    fifo_we : out std_logic;
    data_out : out std_logic_vector(31 downto 0);

    howmany : in std_logic_vector(FIFO_ADDRESS_WIDTH-1 downto 0);
    fifo_rdcnt : in std_logic_vector(FIFO_ADDRESS_WIDTH-1  downto 0);
    fifo_ready : out std_logic
    --rx_ready : in std_logic; -- not used
    --rx_idle : in std_logic  -- not used
);
end SerdesRxController;
architecture architecture_SerdesRxController of SerdesRxController is

    type sm_type is (RESET, ALIGNING1, ALIGNING2, READY);
    signal fifo_state : sm_type;
    signal bitshift : unsigned(1 downto 0);
    signal k_in_last : std_logic_vector(3 downto 0);
    signal data_in_last : std_logic_vector(31 downto 0);

begin

    fifo_ready <= '1' when fifo_rdcnt >= 4 + howmany(FIFO_ADDRESS_WIDTH - 1 downto 0) else '0';

    process(reset_n, clk)
        variable data_aligned : std_logic_vector(31 downto 0);
        variable k_aligned : std_logic_vector(3 downto 0);
    begin
    if reset_n = '0' then
        fifo_we <= '0';
        serdes_aligned <='0';
        fifo_state <= RESET;
        bitshift <= "00";
        k_in_last <= (others => '0');
        data_in_last <= (others => '0');
    elsif rising_edge(clk) then
        case fifo_state is
            when RESET =>
                fifo_we <= '0';
                --fifo_state <= RESET;
                --if k_in = "1111" then
                    fifo_state <= ALIGNING1;
                --end if;

            when ALIGNING1 =>
                fifo_state <= ALIGNING1;
                k_in_last <= k_in;
                data_in_last <= data_in;
                case k_in is
                    when "1111" =>
                        fifo_state <= ALIGNING1;
                    when "1000" =>
                        bitshift <= "00";
                        fifo_state <= ALIGNING2;
                    when "0001" =>
                        bitshift <= "01";
                        fifo_state <= ALIGNING2;
                    when "0010" =>
                        bitshift <= "10";
                        fifo_state <= ALIGNING2;
                    when "0100" =>
                        bitshift <= "11";
                        fifo_state <= ALIGNING2;
                    when others =>
                        fifo_state <= RESET;
                end case;

            when ALIGNING2 =>
                serdes_aligned <= '1';
                fifo_state <= READY;
                k_in_last <= k_in;
                data_in_last <= data_in;                

            when READY =>
                fifo_state <= READY;
                k_in_last <= k_in;
                data_in_last <= data_in;
                fifo_we <= '0';
                case bitshift is
                    when "00" =>
                        k_aligned := k_in_last;
                        data_aligned := data_in_last;
                    when "01" =>
                        k_aligned := k_in(0) & k_in_last(3 downto 1);
                        data_aligned := data_in(7 downto 0) & data_in_last(31 downto 8);
                    when "10" =>
                        k_aligned := k_in(1 downto 0) & k_in_last(3 downto 2);
                        data_aligned := data_in(15 downto 0) & data_in_last(31 downto 16);
                    when "11" =>
                        k_aligned := k_in(2 downto 0) & k_in_last(3);
                        data_aligned := data_in(23 downto 0) & data_in_last(31 downto 24);
                    when others=>
                        fifo_state <= RESET;
                end case;
                if k_aligned = "0000" then
                    data_out <= data_aligned;
                    fifo_we <= '1';
                elsif k_aligned = "1111" then
                    -- do nothing
                elsif k_aligned = "1000" then
                    if data_aligned(31 downto 24) = X"1C" then
                        data_out <= X"80" & data_aligned(23 downto 0);
                        fifo_we <= '1';
                    else
                        -- do nothing
                    end if;
                else
                    fifo_state <= RESET;
                end if;
            when others =>
                fifo_state <= RESET;
        end case;
    end if;     
    end process;


end architecture_SerdesRxController;
