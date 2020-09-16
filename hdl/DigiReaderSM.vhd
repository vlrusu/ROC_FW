--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DigiReaderSM.vhd
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

entity DigiReaderSM is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    use_lane : in std_logic_vector(3 downto 0);
    
    lane0_empty : in std_logic;
    lane1_empty : in std_logic;
    lane2_empty : in std_logic;
    lane3_empty : in std_logic;
    
    lane0_rdcnt : in std_logic_vector(12 downto 0);
    lane1_rdcnt : in std_logic_vector(12 downto 0);
    lane2_rdcnt : in std_logic_vector(12 downto 0);
    lane3_rdcnt : in std_logic_vector(12 downto 0);
    
    lane0_data : in std_logic_vector(31 downto 0);
    lane1_data : in std_logic_vector(31 downto 0);
    lane2_data : in std_logic_vector(31 downto 0);
    lane3_data : in std_logic_vector(31 downto 0);
    
    fifo_re : out std_logic_vector(3 downto 0);
    
    outfifo_we : out std_logic;
    outfifo_data : out  std_logic_vector(31 downto 0)
);
end DigiReaderSM;
architecture architecture_DigiReaderSM of DigiReaderSM is


  type state_type is (IDLE, READ_WORD, WRITE_WORD);
  signal state : state_type;
    
    signal current_channel : integer range 0 to 3;
    
    
    signal fifo_empty : std_logic_vector(3 downto 0);

begin

    with use_lane select
        current_channel <=  0 when X"0",
                            1 when X"1",
                            2 when X"2",
                            3 when others;

    with current_channel select
        outfifo_data <= lane0_data when 0,
                        lane1_data when 1,
                        lane2_data when 2,
                        lane3_data when 3;
                        
    fifo_empty <= lane3_empty & lane2_empty & lane1_empty & lane0_empty;

    process(reset_n,clk)
    begin
    if reset_n = '0' then
        outfifo_we <= '0';
        fifo_re <= (others => '0');
    elsif rising_edge(clk) then
        case state is
            when IDLE =>
                fifo_re <= (others => '0');
                outfifo_we <= '0';
                if fifo_empty(current_channel) = '0' then
                    fifo_re(current_channel) <= '1';
                    state <= READ_WORD;
                end if;
            
            when READ_WORD =>
                fifo_re <= (others => '0');
                state <= WRITE_WORD;
                
            when WRITE_WORD =>
                outfifo_we <= '1';
                state <= IDLE;
        end case;
        --fifo_re <= (others => '0');
        --outfifo_we <= '0';
        --if fifo_empty(current_channel) = '0' then
        --    fifo_re(current_channel) <= '1';
        --end if;
        --if fifo_re(current_channel) = '1' then
        --    outfifo_we <= '1';
        --end if;
    end if;
    end process;

end architecture_DigiReaderSM;
