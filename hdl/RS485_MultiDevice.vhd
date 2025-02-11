library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity RS485_MultiDevice is
  generic (
    APB_ADDRESS_WIDTH    : integer := 32;   -- APB_ADDRESS_WIDTH
    APB_DATA_WIDTH       : integer := 32);  --APB data width
  Port (
    PCLK    : in  std_logic;            -- APB clock
    PRESETn : in  std_logic;            -- APB reset
    
        data_in : in std_logic_vector(7 downto 0);
        tx_start : in std_logic;
        my_address : in std_logic_vector(7 downto 0);
        rx_data : out std_logic_vector(7 downto 0);
        tx_err : out std_logic;
        tx_busy : out std_logic;
        rx_ready : out std_logic;    
    
        rx           : in  std_logic;        -- RS-485 receiver input
        tx           : out std_logic;        -- RS-485 transmitter output
        tx_enable    : out std_logic        -- RS-485 driver enable
        
    );
end RS485_MultiDevice;
architecture Behavioral of RS485_MultiDevice is
    constant BAUD_RATE : integer := 38400;
    constant CLK_FREQ  : integer := 50000000;
    constant BIT_TIME  : integer := 1302; --CLK_FREQ / BAUD_RATE;
    -- Internal signals
    type tx_state_type is (IDLE,START_BIT,DATA_BITS,STOP_BIT);
    signal tx_state: tx_state_type := IDLE;
    signal tx_shift_reg : std_logic_vector(7 downto 0); --  8 data bits
    signal tx_bit_count : integer range 0 to 7 := 0; -- Total bits for one byte
    signal tx_counter   : integer range 0 to BIT_TIME := 0; --Clock counter for baud rate
    signal tx_ready : std_logic;
    
    type rx_state_type is (RX_IDLE,RX_START_BIT,RX_STOP_BIT,RX_DATA_BITS,RX_CHECK);
    signal rx_state: rx_state_type := RX_IDLE;
    signal rx_shift_reg : std_logic_vector(8 downto 0); --1 start bit, 8 data bits, 1 stop bit
    signal rx_bit_count : integer range 0 to 10 := 0; --Total bits for one byte
    signal rx_counter   : integer range 0 to BIT_TIME := 0; --Clock counter for baud rate
    signal rx_address_match    : std_logic := '0';-- match flag
    signal rx_phase     : std_logic := '0';             -- Reception phase: '0' for address, '1' for data
    signal rx_address : std_logic_vector(7 downto 0); -- Temporarily store the received address
    
begin

    -- Transmitter Process
    Transmit_Process: process(pclk, presetn)
    begin
        if presetn = '0' then
            tx <= '1';
            tx_enable <= '0';
            tx_ready <= '1';
            tx_bit_count <= 0;
            tx_busy <= '0';
            tx_err <= '0';
            tx_state <= IDLE;
        elsif rising_edge(pclk) then
            case tx_state is
                when IDLE =>
                    tx <= '1'; --UART idle interface
                    tx_bit_count <= 0;
                    tx_counter <= 0;
                    if tx_start = '1' and tx_ready = '1' then
                        tx_state <= START_BIT;
                        tx_shift_reg <= data_in;
                        tx_ready <= '0';
                        tx_enable <= '1'; -- ENABLE RS-485 driver
                        tx_busy <= '1';
                    else
                        tx_state <= IDLE;
                    end if;
                    
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
                        tx_counter <= 0;
                        if tx_bit_count = 7 then --Last bit
                            tx_bit_count <= 0;
                            tx_state <= STOP_BIT;
                        else
                            tx_bit_count <= tx_bit_count + 1;
                        end if;
                    else
                        tx_counter <= tx_counter + 1;
                    end if;
                    
                when STOP_BIT =>
                    tx <= '1';
                    if tx_counter = BIT_TIME -1 then
                        tx_counter <= 0;
                        tx_enable <= '0'; --Release driver
                        tx_ready <= '1';
                        tx_busy <= '0';
                        tx_state <= IDLE;
                    else
                        tx_counter <= tx_counter + 1;
                    end if;
                    
                when others =>
                    tx_state <= IDLE;
            end case;
        end if;
    end process;
    
    
    
    -- Receiver Process
    Receive_Process: process(pclk, presetn)
    begin
        if presetn = '0' then
            rx_ready <= '0';
            rx_bit_count <= 0;
            rx_counter <= 0;
            rx_address_match <= '0' ;
            rx_state <= RX_IDLE;
            rx_data <= (others => '0');
            rx_phase <= '0'; -- Start with address reception
        elsif rising_edge(pclk) then
            case rx_state is 
                when RX_IDLE =>
                    rx_counter <= 0;
                    rx_bit_count <= 0;
                    rx_ready <= '0';
                
                    if rx = '0' then -- check bit detection
                        rx_state <= RX_START_BIT;
                    else
                        rx_state <= RX_IDLE;
                    end if;
                    
                when RX_START_BIT =>
                    if rx_counter = (BIT_TIME - 1)/2 then --check middle of start bit to make sure is still low
                        if rx = '0' then 
                            rx_counter <= 0;  -- reset counter since we found the middle. from now on, sample the middle
                            rx_state   <= RX_DATA_BITS;
                        else
                            rx_state <= RX_IDLE; -- false alarm
                        end if;
                    else 
                        rx_counter <= rx_counter + 1;
                        rx_state <= RX_START_BIT;
                    end if;
                    
                when RX_DATA_BITS =>
                    if rx_counter < BIT_TIME -1 then
                        rx_counter <= rx_counter + 1;
                        rx_state <= RX_DATA_BITS;
                    else
                        rx_shift_reg(rx_bit_count) <=  rx;
                        rx_counter <= 0;
                        if rx_bit_count < 7 then
                            rx_bit_count <= rx_bit_count +1;
                            rx_state <= RX_DATA_BITS;
                        else
                            rx_bit_count <= 0;
                            rx_state <= RX_CHECK;                                                       
                                
                        end if;
                    end if;
                    
                when RX_CHECK =>
                    if rx_phase = '0' then -- this is the end of the address phase, we can check
                    
                        if rx_shift_reg(7 downto 0) = my_address then --address matches
                            rx_address_match <= '1';
                        else
                            rx_address_match <= '0';
                        end if;
                    end if;
                    rx_phase <= not rx_phase; 
                    rx_state <= RX_STOP_BIT;
                    
                when RX_STOP_BIT =>
                    if rx_phase = '0'  and rx_address_match = '1' then -- this is the beginningof the next address phase and address was a match
                        rx_data <= rx_shift_reg(7 downto 0);
                        rx_address_match <= '0' ; -- reset the match
                    end if;
                    if rx_counter < BIT_TIME -1 then
                        rx_counter <= rx_counter + 1;
                        rx_state <= RX_STOP_BIT;
                    else
                        rx_state <= RX_IDLE;
                    end if;
                    
                when others =>
                    tx_state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;