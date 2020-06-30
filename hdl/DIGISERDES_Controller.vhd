-------------------------------------------------------------------------------
-- Title      : DIGISERDES_Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : DIGISERDES_Controller.vhd
-- Author     :   <vrusu@PPD-130027>
-- Company    : 
-- Created    : 2019-03-20
-- Last update: 2019-03-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-- 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-03-20  1.0      vrusu   Created
-------------------------------------------------------------------------------



library IEEE;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;


entity DIGISERDES_Controller is

  generic (NCHANNELS : integer := 4;
FIFO_ADDRESS_WIDTH : integer :=13);
  port (

    reset_n    : in  std_logic;
    clk        : in  std_logic;
    fifo_ready : in  std_logic_vector(NCHANNELS-1 downto 0);
    fifo_re    : out std_logic_vector(NCHANNELS-1 downto 0);
    outfifo_we : out std_logic;
    howmany : in std_logic_vector(FIFO_ADDRESS_WIDTH-1 downto 0);
fifo_select : out std_logic_vector(1 downto 0)


    );
end DIGISERDES_Controller;
architecture architecture_DIGISERDES_Controller of DIGISERDES_Controller is
  -- signal, component etc. declarations
 
  signal start_channel : integer range 0 to NCHANNELS-1;
  signal cur_channel   : integer range 0 to NCHANNELS-1;

  type outfifo_type is (IDLE, SETUP, S1, S2, S3, S4);
  signal outfifo_state : outfifo_type;

  signal outfifo_counter : unsigned(FIFO_ADDRESS_WIDTH-1 downto 0);
begin


fifo_select <= std_logic_vector(to_unsigned(cur_channel,fifo_select'length));


  fiforead_process : process(clk, reset_n)
  begin

    if reset_n = '0' then
      outfifo_state <= IDLE;
      outfifo_we    <= '0';
      fifo_re       <= (others => '0');
      start_channel <= 0;

    else
      if rising_edge(clk) then
        case outfifo_state is
          when IDLE =>
            outfifo_state <= IDLE;
            outfifo_we    <= '0';
            fifo_re       <= (others => '0');

            if fifo_ready(start_channel) = '1' then
              cur_channel     <= start_channel;
              outfifo_state   <= S1;
              outfifo_counter <= unsigned(howmany(FIFO_ADDRESS_WIDTH-1 downto 0)) + 4;
            end if;
            --else
              if start_channel = NCHANNELS-1 then
                start_channel <= 0;
              else
                start_channel <= start_channel + 1;
              end if;
            --end if;

          when S1 =>
            outfifo_state        <= S2;
            outfifo_we           <= '0';
            fifo_re(cur_channel) <= '1';

            outfifo_counter <= outfifo_counter - 1;

          when S2 =>
            outfifo_state        <= S3;
            outfifo_we           <= '1';
            fifo_re(cur_channel) <= '0';
                                        --if outfifo_counter = 0 then
            if outfifo_counter = 0 then
              outfifo_state <= S4;
            end if;

          when S3 =>
            outfifo_state        <= S2;
            outfifo_we           <= '0';
            fifo_re(cur_channel) <= '1';

            outfifo_counter <= outfifo_counter - 1;

          when S4 =>
            outfifo_state        <= IDLE;
            outfifo_we           <= '0';
            fifo_re(cur_channel) <= '0';
          when others =>
            outfifo_state        <= IDLE;
        end case;
      end if;
    end if;
  end process fiforead_process;



                                        -- architecture body
end architecture_DIGISERDES_Controller;
