--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: TWIController.vhd
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

entity TWIController is
  generic(
    a_width : integer := 9;
    d_width : integer := 16);
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    init : in std_logic;
    busy : out std_logic;
    
    data_in : in std_logic_vector(15 downto 0);
    address : in std_logic_vector(8 downto 0);
    data_out : buffer std_logic_vector(15 downto 0);

    scl : out std_logic;
    sda : inout std_logic
);
end TWIController;

architecture architecture_TWIController of TWIController is

    type sm is(IDLE,RUNNING);
    signal state : sm;
    
    signal counter : integer range 0 to 128 := 0;
    signal clock_counter : integer range 0 to 128 := 0;
   
    
    signal data_buffer : std_logic_vector(d_width-1 downto 0);
    signal address_buffer : std_logic_vector(a_width-1 downto 0);

    constant divider : integer := 2;
  SIGNAL data_clk      : STD_LOGIC;                      --data clock for sda
  SIGNAL data_clk_prev : STD_LOGIC;                      --data clock during previous system clock
  SIGNAL scl_clk       : STD_LOGIC;                      --constantly running internal scl
begin


 


process(reset_n, clk)
begin


    if reset_n = '0' then
        state <= IDLE;
        busy <= '1';
        
        scl <= '0';
        sda <= '0';
        scl_clk <= '0';
                 data_clk <= '0';
        clock_counter <= 0;
        counter <= 0;
       
        data_out <= (others => '0');
    elsif rising_edge(clk) then
 data_clk_prev <= data_clk;          --store previous value of data clock
        case state is
            when IDLE =>
                state <= IDLE;
                busy <= '0';
                scl <= '0';
                sda <= '0';
                 scl_clk <= '0';
                 data_clk <= '0';
                clock_counter <= 0;
                counter <= 0;
                   data_buffer <= (others=>'0');
                    address_buffer <= (others=>'0');               


                if init = '1' then
                    busy <= '1';
                    state <= RUNNING;
                    data_buffer <= data_in;
                    address_buffer <= address;
                end if;

   
           when RUNNING =>
                state <= RUNNING;
                busy <= '1';
                scl <= scl_clk;

         IF(clock_counter = divider*4-1) THEN        --end of timing cycle
            clock_counter <= 0;                       --reset timer
         else
                clock_counter <= clock_counter + 1;               --continue clock generation timing
         END IF;
     
              CASE clock_counter IS
                WHEN 0 TO divider-1 =>            --first 1/4 cycle of clocking
                  scl_clk <= '0';
                  data_clk <= '0';
                WHEN divider TO divider*2-1 =>    --second 1/4 cycle of clocking
                  scl_clk <= '0';
                  data_clk <= '1';
                WHEN divider*2 TO divider*3-1 =>  --third 1/4 cycle of clocking
                  scl_clk <= '1';                 --release scl
                  data_clk <= '1';
                WHEN OTHERS =>                    --last 1/4 cycle of clocking
                  scl_clk <= '1';
                  data_clk <= '0';
              END CASE;
            
 
            IF(data_clk = '1' AND data_clk_prev = '0') THEN  --data clock rising edge 
            counter <= counter + 1;    
      
                      if counter < a_width then
                            sda <= address_buffer(a_width-1);
                            address_buffer <= address_buffer(a_width-2 downto 0) & '0';
                        elsif counter >= a_width and counter < a_width + d_width then
                            sda <= data_buffer(d_width-1);
                            data_buffer <= data_buffer(d_width-2 downto 0) & '0';
                        else
                            sda<='Z';
                        end if;
           
            ELSIF(data_clk = '0' AND data_clk_prev = '1') THEN  --data clock falling edge
                     if counter > a_width+d_width and counter <= a_width + 2* d_width then
--                            sda <= 'Z';
                            data_out <= data_out(d_width-2 downto 0) & sda;
                       end if;
            end if;
                
            if counter = a_width + 2*d_width + 1 and clock_counter = divider-1 then
                        state <= IDLE;
            end if;

              
  
                
            when OTHERS =>
        end case;
    end if;
end process;




end architecture_TWIController;
