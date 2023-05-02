--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DataStatusProcessor.vhd
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
USE IEEE.std_logic_1164.ALL;				 
USE IEEE.numeric_std.ALL;			  			 
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;		  			 

library work;
use work.algorithm_constants.all; 

entity DataStatusProcessor is
port (
    DREQ_CLK    : IN  std_logic;			
	EXT_RSTN	: IN  std_logic;
    
    STATUS_SEL  : IN  std_logic_vector(2 DOWNTO 0);     -- select STATUS_BIT content via DCS register 0x 
    
	DREQ_FULL	: IN  std_logic;
	DREQ_EMPTY  : IN  std_logic;
	DDR_WRAP    : IN  std_logic;
	ETFIFO_FULL : IN  std_logic;

	DREQ_WRCNT  : IN  std_logic_vector(16 DOWNTO 0);

	EWM_COUNTER : IN  std_logic_vector(15 DOWNTO 0);

    DREQ_START  : IN  std_logic;
	TIMEOUT_LEFT: IN  std_logic_vector(10 DOWNTO 0);
    
    STATUS_BIT  : OUT std_logic_vector(7 DOWNTO 0) 
);
end DataStatusProcessor;

architecture architecture_DataStatusProcessor of DataStatusProcessor is
   -- signal, component etc. declarations
   signal ewm_counter_slow          : std_logic_vector(15 DOWNTO 0);

begin

  -- architecture body
    process(EXT_RSTN, DREQ_CLK)
	begin
        if EXT_RSTN = '0' then
            STATUS_BIT  <= (others => '0'); 
        else
            
            if (STATUS_SEL = "001") then
                STATUS_BIT(0) <= DREQ_EMPTY;    -- bit(0) has current DREQ_EMPTY status
                
                if  DREQ_FULL = '1' then
                    STATUS_BIT(1) <= '1';       -- bit(1) has latched DREQ_FIFO status      
                end if;
                
                STATUS_BIT(2) <= ETFIFO_FULL;   -- bit(2) has current ET_FIFO FULL status
                
                if  DDR_WRAP = '1' then
                    STATUS_BIT(3) <= '1';       -- bit(2) has latched DDR_WRAP status      
                end if;
                
                STATUS_BIT(7 downto 4)  <= (others => '0'); 
                
            elsif (STATUS_SEL = "010") then         -- SEL=2 records DREQ LSB seen at DREQ HEADER sent out
                
                if  DREQ_FULL = '1' then            -- sit at 0xFF forever once DREQ_FULL is seen
                    STATUS_BIT <= (others => '1');      
                else                              
                    STATUS_BIT <= DREQ_WRCNT(7 downto 0);
                end if;
                
            elsif (STATUS_SEL = "011") then         -- SEL=3 records DREQ MSB seen at DREQ HEADER sent out
                
                if  DREQ_FULL = '1' then                    -- sit at 0xFF forever once DREQ_FULL is seen
                    STATUS_BIT <= (others => '1');      
                else                               
                    STATUS_BIT <= DREQ_WRCNT(15 downto 8);
                end if;
                
            elsif (STATUS_SEL = "100") then         -- SEL=4 records EWM LSB seen at DREQ HEADER sent out
                ewm_counter_slow <= EWM_COUNTER(15 downto 0);
                
                if  DREQ_FULL = '1' then            -- sit at 0xFF forever once DREQ_FULL is seen
                    STATUS_BIT <= (others => '1');
                else      
                    STATUS_BIT <= ewm_counter_slow (7 downto 0);
                end if;
                
            elsif (STATUS_SEL = "101") then         -- SEL=5 records EWM MSB seen at DREQ HEADER sent out
                ewm_counter_slow <= EWM_COUNTER(15 downto 0);
                
                if  DREQ_FULL = '1' then            -- sit at 0xFF forever once DREQ_FULL is seen
                    STATUS_BIT <= (others => '1');
                else      
                    STATUS_BIT <= ewm_counter_slow (15 downto 8);
                end if;
                
            elsif (STATUS_SEL = "110") then         -- SEL=6 records EWM LSB at DREQ seen
                if  DREQ_START = '1'    then    ewm_counter_slow <= EWM_COUNTER(15 downto 0);   end if;
                
                if  DREQ_FULL = '1' then            -- sit at 0xFF forever once DREQ_FULL is seen
                    STATUS_BIT <= (others => '1');
                else
                    STATUS_BIT <= ewm_counter_slow (7 downto 0);
                end if;
                
            elsif (STATUS_SEL = "111") then         -- SEL=7 records TIME between DREQ seen and DREQ HEADER sent out 

                if  DREQ_FULL = '1' then            
                    STATUS_BIT <= (others => '1'); -- sit at 0xFF forever once DREQ_FULL is seen
                else      
                    STATUS_BIT <=   TIMEOUT_LEFT(9 downto 2); -- this is a backward counter in multiples of 4*DREQ_CLK= 4*12.5ns = 50 ns
                end if;
                
                
            else
                STATUS_BIT <= X"55";    -- old default value
            end if;
        end if;
    end process; 
    
end architecture_DataStatusProcessor;
