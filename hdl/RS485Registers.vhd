--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: RS485Registers.vhd
-- File history:
-- File history:
--      <v0>: <02/13/25>: First version 
--      <v1>: <02/24/25>: First working version with 3 bytes RX and 3 byte for TX. Add programmable delay to wait for "set_rs485_receive()" response
--      <v2>: <02/25/25>: Increase "my_address" to 9 bits and set equal to PANEL_ID. Set bit(7) of first byte word to be equal to my_adress(8)
--
-- Description: 
--
--  Code to interface RS485 serial with APB bus: note that since processor is APB MASTER
--      -> after RX data is read in, uProc reads data from PRDATA
--      -> after uProc writes data to PWDATA, TX data can be sent out
--  It contains:
--      1) Receive_Process state machine, to receive and decode 3 bytes coming via RX: 
--          1st byte = master_to_slave code (0xAB); 2nd byte = ROC address (1-12); 3rd byte = CMD code
--      2) Transmit_Process state machine, to encode and send 3 bytes sent via TX: 
--          1st byte = slave_to_master code (0xEF); 2nd byte = reply bit(7:0); 3rd byte = reply bit(15:8)
--      3) P_PRDATA state machine to to pass RX_READY, RX_DATA and TX_BUSY to processor 
--      4) P_PRDATA_out to send data from "Receive_Process" to uProc
--      5) P_PWDATA to receive data from uProc and pass it to "Transmit_Process" 
--  Last 3 state machines are based on SlowControls/REGISTERS module. 
--
-------------------------------------------------------------------------------
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: MT
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.algorithm_constants.all; 

entity RS485Registers is
  generic (
    APB_ADDRESS_WIDTH    : integer := 32;   -- APB_ADDRESS_WIDTH
    APB_DATA_WIDTH       : integer := 32);  -- APB data width
port (
    PCLK    :   in  std_logic;            -- APB clock
    PRESETn :   in  std_logic;            -- APB reset
    PENABLE :   in  std_logic;            -- APB enable
    PSEL    :   in  std_logic;            -- APB periph select
    PADDR   :   in  std_logic_vector(APB_ADDRESS_WIDTH-1 downto 0);  -- APB address bus
    PWRITE  :   in  std_logic;            -- APB write
    PWDATA  :   in  std_logic_vector(APB_DATA_WIDTH-1 downto 0);  -- APB write data
    PRDATA  :   out std_logic_vector(APB_DATA_WIDTH-1 downto 0);  -- APB read data
    PREADY  :   out std_logic;            -- APB ready signal data
    PSLVERR :   out std_logic;            -- APB error signal
   
    rx           : in  std_logic;       -- RS-485 receiver input
    tx           : out std_logic;       -- RS-485 transmitter output
    tx_enable    : out std_logic;       -- RS-485 driver enable
    
    my_delay    : in  std_logic_vector(7 downto 0);   -- coming from SLOWCONTROLS/Registers for now; def = 1
    my_address  : in  std_logic_vector(8 downto 0)    -- coming from SLOWCONTROLS/Registers for now; def = 0
);
end RS485Registers;

architecture architecture_RS485Registers of RS485Registers is

    -- RS485 Commands APB address offset
	constant CRRS485_RX_READY   : std_logic_vector(7 downto 0) := x"01";     -- PADDR = 0x7E00_0004
	constant CRRS485_RX_READ    : std_logic_vector(7 downto 0) := x"02";     -- PADDR = 0x7E00_0008
	constant CRRS485_TX_WRITE   : std_logic_vector(7 downto 0) := x"03";     -- PADDR = 0x7E00_000C
	constant CRRS485_RX_ACK     : std_logic_vector(7 downto 0) := x"05";     -- PADDR = 0x7E00_0014
	constant CRRS485_TX_BUSY    : std_logic_vector(7 downto 0) := x"06";     -- PADDR = 0x7E00_0018
	constant CRRS485_TX_START   : std_logic_vector(7 downto 0) := x"07";     -- PADDR = 0x7E00_001C  
    
    constant MASTER_TO_SLAVE    : std_logic_vector(6 downto 0) := b"101_1010";
    constant SLAVE_TO_MASTER    : std_logic_vector(7 downto 0) := x"EF";

    constant BAUD_RATE : integer := 38400;
    constant CLK_FREQ  : integer := 50000000;
    constant BIT_TIME  : integer := 1302; --CLK_FREQ / BAUD_RATE;
    constant DELAY_TIME: integer := 5000000; -- 100 ms in 50MHz clock
    
    -- Internal signals
    type tx_state_type is (IDLE,DELAY_LATCH,LATCH_DATA,START_BIT,DATA_BITS,STOP_BIT);
    signal tx_state: tx_state_type := IDLE;
    signal tx_shift_reg : std_logic_vector(7 downto 0); --  8 data bits
    signal tx_bit_count : integer range 0 to 7 := 0;    -- Total bits for one byte
    signal tx_counter   : integer range 0 to BIT_TIME := 0;         --Clock counter for baud rate
    signal tx_busy      : std_logic;                    -- Use while sending 3x8-bit words out to RS485
    signal tx_start     : std_logic;  
    signal tx_data      : std_logic_vector(APB_DATA_WIDTH-1 downto 0);
    signal tx_phase     : integer range 0 to 2 := 0;    -- Transmission phase: '0' at start; '1' for slave code ; '2' for first byte, '3' for second byte
    
    type rx_state_type is (RX_IDLE,RX_START_BIT,RX_STOP_BIT,RX_DATA_BITS,RX_CHECK,RX_WAIT_ACK);
    signal rx_state     : rx_state_type := RX_IDLE;
    signal rx_shift_reg : std_logic_vector(8 downto 0); --1 start bit, 8 data bits, 1 stop bit
    signal rx_bit_count : integer range 0 to 10 := 0;   --Total bits for one byte
    signal rx_counter   : integer range 0 to BIT_TIME := 0; --Clock counter for baud rate
    signal rx_ready     : std_logic := '0';
    signal rx_ack       : std_logic := '0';
    signal rx_data      : std_logic_vector(7 downto 0);
    signal rx_phase     : integer range 0 to 3 := 0;    -- Reception phase: '0' at start; '1' for master code ; '2' for address, '3' for data

    signal DataOut      : std_logic_vector(APB_DATA_WIDTH-1 downto 0);
    signal data_in      : std_logic_vector(7 downto 0);
    
    signal delay_count  : integer;
    signal tx_dly_counter   : integer range 0 to DELAY_TIME := 0;   --Clock counter for 100 ms delay

begin
    
    -- RS485 Receiver Process from Vadim
    Receive_Process: process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
        
            rx_ready    <= '0';
            rx_bit_count<= 0;
            rx_counter  <= 0;
            rx_data     <= (others => '0');
            rx_shift_reg<= (others => '0');
            rx_phase    <= 0; -- Start with master/slave code
            rx_state    <= RX_IDLE;
            
        elsif rising_edge(PCLK) then
                
            case rx_state is 
                
                when RX_IDLE =>
                    rx_counter  <= 0;
                    rx_bit_count<= 0;
                    
                    if  rx = '0' then           -- check bit detection
                        rx_state <= RX_START_BIT;
                    else
                        rx_state <= RX_IDLE;
                    end if;
                    
                when RX_START_BIT =>
                    if rx_counter = (BIT_TIME - 1)/2 then --check middle of start bit to make sure is still low
                        if rx = '0' then 
                            rx_counter  <= 0;  -- reset counter since we found the middle. from now on, sample the middle
                            rx_state    <= RX_DATA_BITS;
                        else
                            rx_state    <= RX_IDLE; -- false alarm
                        end if;
                    else 
                        rx_counter  <= rx_counter + 1;
                        rx_state    <= RX_START_BIT;
                    end if;
                    
                when RX_DATA_BITS =>
                    if rx_counter < BIT_TIME -1 then
                        rx_counter  <= rx_counter + 1;
                        rx_state    <= RX_DATA_BITS;
                    else
                        rx_shift_reg(rx_bit_count) <=  rx;
                        rx_counter  <= 0;
                        if rx_bit_count < 7 then
                            rx_bit_count<= rx_bit_count +1;
                            rx_state    <= RX_DATA_BITS;
                        else
                            rx_bit_count<= 0;
                            rx_state    <= RX_CHECK;                                                       
                        end if;
                    end if;
                    
                when RX_CHECK =>
                    if rx_phase = 0 then    -- checking for MASTER_TO_SLAVE code
                        if  (rx_shift_reg(6 downto 0) = MASTER_TO_SLAVE   and   rx_shift_reg(7) = my_address(8))    then    -- master request decoded
                            rx_phase <= 1;
                        end if;
                    elsif   rx_phase = 1    then    -- checking for ROC address 
                        if rx_shift_reg(7 downto 0) = my_address(7 downto 0)    then --address matches
                            rx_phase <= 2;
                        end if;
                    else -- must be 2 at this point
                        rx_phase <= 3;
                    end if;
                        
                    rx_state <= RX_STOP_BIT;
                    
                    
                when RX_STOP_BIT =>                    
                    if  rx_phase = 3    then -- the 3rd byte has been received and passed along
                        rx_ready    <= '1';
                        rx_data     <= rx_shift_reg(7 downto 0);
                        rx_state    <= RX_WAIT_ACK;
                    else
                        if rx_counter < BIT_TIME -1 then
                            rx_counter  <= rx_counter + 1;
                            rx_state    <= RX_STOP_BIT;
                        else
                            rx_state    <= RX_IDLE;
                        end if;
                    end if;
                    
                -- Monica added to wait for uProc acknowledge before clearing RX_READY
                when RX_WAIT_ACK =>
                    if  rx_ack = '1' then
                        rx_phase    <= 0;
                        rx_ready    <= '0';
                        rx_state    <= RX_STOP_BIT;
                    else
                        rx_state    <= RX_WAIT_ACK;  
                    end if;
                    
                when others =>
                    rx_state <= RX_IDLE;
                    
            end case;
        end if;
    end process;

    
    -- RS485 Transmitter Process from Vadim
    Transmit_Process: process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
        
            tx          <= '1';
            tx_enable   <= '0';
            tx_busy     <= '0';
            tx_bit_count<= 0;
            tx_phase    <= 0;
            delay_count <= 0; 
            tx_shift_reg<= (others => '0');
            data_in     <= (others => '0');
            tx_state    <= IDLE;
            
        elsif rising_edge(PCLK) then
            
            case tx_state is
                when IDLE =>
                    tx          <= '1'; --UART idle interface
                    tx_bit_count<= 0;
                    tx_counter  <= 0;
                    delay_count <= 0; 
                    tx_dly_counter  <= 0;
                    if  tx_start = '1'   then  -- this will be cleared by uProc right after
                        tx_state <= DELAY_LATCH;
                    else
                        tx_state <= IDLE;
                    end if;
                    
                when DELAY_LATCH =>  -- programmable delay to wait for "set_rs485_receive()" response
                    tx          <= '1'; 
                    if tx_dly_counter = DELAY_TIME-1 then
                        delay_count <= delay_count + 1;
                        tx_dly_counter <= 0;
                    else
                        tx_dly_counter  <= tx_dly_counter + 1;
                    end if;
                    
                    if  delay_count = to_integer(unsigned(my_delay))   then
                        tx_state <= LATCH_DATA;
                    else
                        tx_state <= DELAY_LATCH;
                    end if;
                    
                when LATCH_DATA =>
                    tx          <= '1'; 
                    tx_bit_count<= 0;
                    tx_counter  <= 0;
                    tx_enable   <= '1'; -- ENABLE RS-485 driver
                    tx_busy     <= '1'; -- set TX BUSY
                    if  tx_phase = 0    then
                        tx_phase <= 1;
                        tx_shift_reg<= SLAVE_TO_MASTER;
                    elsif   tx_phase = 1    then
                        tx_phase <= 2;
                        tx_shift_reg<= tx_data(7 downto 0);
                    else -- must be 2 at this point
                        tx_phase <= 3;
                        tx_shift_reg<= tx_data(15 downto 8);
                    end if;
                    tx_state    <= START_BIT;
                    
                when START_BIT =>
                    tx <= '0'; --START BIT
                    if tx_counter = BIT_TIME-1 then
                        tx_counter <= 0;
                        tx_state <= DATA_BITS;
                    else
                        tx_counter <= tx_counter + 1;
                    end if;
                        
                when DATA_BITS =>
                    tx <= tx_shift_reg(tx_bit_count);
                    if tx_counter = BIT_TIME -1 then
                        tx_counter      <= 0;
                        if tx_bit_count = 7 then --Last bit
                            tx_bit_count<= 0;
                            tx_state    <= STOP_BIT;
                        else
                            tx_bit_count<= tx_bit_count + 1;
                        end if;
                    else
                        tx_counter <= tx_counter + 1;
                    end if;
                    
                when STOP_BIT =>
                    tx <= '1';
                    if tx_counter = BIT_TIME -1 then
                        tx_counter  <= 0;
                        tx_enable   <= '0'; --Release driver
                        if  tx_phase = 3    then
                            tx_phase <= 0;
                            tx_busy <= '0';
                            tx_state <= IDLE;
                        else
                            tx_state <= LATCH_DATA;
                        end if;
                    else
                        tx_counter  <= tx_counter + 1;
                        tx_state    <= STOP_BIT;
                    end if;
                    
                when others =>
                    tx_state <= IDLE;
            end case;
        end if;
    end process;
    

-------------------------------------------------------------------------------
-- Code for APB transactions
-------------------------------------------------------------------------------
    PREADY  <= '1';
    PSLVERR <= '0';
    --*****************************************************************************************
    -- Control logic for APB RX reads when uProc sees a command from RS485:
    --      generate RX_Ready
    --      latch DATAOUT (to be passed to PRDATA)
    --      identify read from DCS_RX_BUFFER 
    p_PRDATA : process (PWRITE, PSEL, PADDR)
    begin
        DataOut     <= (others => '0');
        
        if PWRITE = '0' and PSEL = '1' and PREADY = '1' then
                
            case PADDR(9 downto 2) is
                
                when CRRS485_RX_READY =>    
                    DataOut(15 downto 0) <= B"0000_0000_0000_000" & rx_ready;
                    
                when CRRS485_TX_BUSY =>    
                    DataOut(15 downto 0) <= B"0000_0000_0000_000" & tx_busy;
                    
                when CRRS485_RX_READ =>
                    DataOut(15 downto 0) <= B"0000_0000" & rx_data;
                    
                when others =>
                    DataOut <= (others => '0');
                
            end case;
            
        else            
            DataOut     <= (others => '0');
        end if;
        
    end process p_PRDATA;

    -- Generate PRDATA on falling edge
    p_PRDATA_out : process (PRESETn, PCLK)
    begin
        if (PRESETn = '0') then
            PRDATA <= (others => '0');
            
        elsif (PCLK'event and PCLK = '1') then
            
            if (PWRITE = '0' and PSEL = '1') then
                PRDATA <= DataOut;
            end if;
        end if;
    end process p_PRDATA_out;
    
    --*****************************************************************************************
    -- Control logic for APB TX writes when uProc responds to command from RS485:
    p_reg_seq : process (PRESETn, PCLK, PSEL, PENABLE, PWRITE)
    begin
        if (PRESETn = '0') then -- initialize output registers
            
            rx_ack      <= '0';
            tx_start    <= '0';
            tx_data     <= (others => '0');
         
        elsif (PCLK'event and PCLK = '1') then
            
            if (PWRITE = '1' and PSEL = '1' and PENABLE = '1') then
                case PADDR(9 downto 2) is
                               
                    when CRRS485_RX_ACK =>
                        rx_ack  <= PWDATA(0);
                        
                    when CRRS485_TX_START =>
                        tx_start <= PWDATA(0);
                        
                    when CRRS485_TX_WRITE =>
                        tx_data <= PWDATA;
                        
                    when others =>
                        
                end case;
            end if;
        end if;
    end process p_reg_seq;
    
end architecture_RS485Registers;
