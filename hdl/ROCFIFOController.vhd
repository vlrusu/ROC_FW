--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: ROCFIFOController.vhd
-- File history:
--      v1.0: <Aug. 2021>: first version
--      v2.0: <Mar. 2022>: Fixed size of EW_SIZE output as (EVENT_SIZE_BITS downto 0)  => MAX allowed value is 4096
--      v3.0: <July 2023>: Added NEWSPILL_RESET input used as overall logic reset
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

library work;
use work.algorithm_constants.all; 

entity ROCFIFOController is
generic ( 
    NROCFIFO             : integer := 4
); 
port (
    reset_n : in std_logic;
    clk : in std_logic;
    
    use_lane : in std_logic_vector(3 downto 0);
    
    lane0_empty : in std_logic;
    lane1_empty : in std_logic;
    lane2_empty : in std_logic;
    lane3_empty : in std_logic;
    
    lane0_data : in std_logic_vector(31 downto 0);
    lane1_data : in std_logic_vector(31 downto 0);
    lane2_data : in std_logic_vector(31 downto 0);
    lane3_data : in std_logic_vector(31 downto 0);
    
    axi_start_on_serdesclk : in std_logic;
    
    lane0_re : out std_logic;
    lane1_re : out std_logic;
    lane2_re : out std_logic;
    lane3_re : out std_logic;
    
    ew_done : out std_logic;
    ew_ovfl : out std_logic;
    ew_size : out std_logic_vector(EVENT_SIZE_BITS-1 downto 0);
    ew_tag  : out std_logic_vector(SPILL_TAG_BITS-1 downto 0);
    
    newspill_reset : in  std_logic;
    curr_ewfifo_wr : out std_logic;
    
    state_count : out std_logic_vector(7 downto 0);

    use_uart : in std_logic;
    
    uart_fifo_full : in std_logic;
    uart_fifo_we   : out std_logic;
    uart_fifo_data : out std_logic_vector(31 downto 0);
    
    ew_fifo_full : in std_logic;  -- not used because EW_FIFO size is hard-wired to be at most equal to one maximum size event
    ew_fifo_we   : out std_logic;
    ew_fifo_data : out  std_logic_vector(31 downto 0)
);
end ROCFIFOController;
architecture architecture_ROCFIFOController of ROCFIFOController is
    
    type state_type is (RESET, IDLE, START, CHECK, COUNT, UPDATE, HOLD);
    signal state            : state_type;
    
    signal current_lane : integer range 0 to NROCFIFO-1;
    signal ew_tag_error : std_logic;

    signal lane_size : unsigned(12 downto 0);
    signal full_size : unsigned(11 downto 0);
    constant  MAX_BEATS: integer := (2**TRK_HIT_BITS-1)*4;
    
    signal rd_cnt : unsigned(15 downto 0);    -- this counts words read from ROCFIFO in units of 32-bit words
    signal wr_cnt : unsigned(15 downto 0);    -- this counts words written to EW_FIFO in units of 64-bit words (must stop when overflow condition is reached!!)
    signal wait_cnt : unsigned(7 downto 0);
    signal timeout_cnt : unsigned(15 downto 0);
    signal timeout_en : std_logic;
    
    signal rocfifo_empty : std_logic_vector(NROCFIFO-1 downto 0);
    signal current_data : std_logic_vector(31 downto 0);
    
    signal data_ready : std_logic;
    signal outfifo_we : std_logic;
    signal outfifo_full : std_logic;
    signal want_we : std_logic;
    signal want_re : std_logic_vector(NROCFIFO-1 downto 0);

    signal first_used_lane : integer range 0 to 4;
    signal active_lane : std_logic_vector(1 downto 0);
        
begin

    rocfifo_empty(0) <= lane0_empty;
    rocfifo_empty(1) <= lane1_empty;
    rocfifo_empty(2) <= lane2_empty;
    rocfifo_empty(3) <= lane3_empty;
    
    ---- data ready whenever not empty
    data_ready  <= not rocfifo_empty(current_lane);
    
    outfifo_full<= uart_fifo_full when use_uart = '1' else ew_fifo_full;

    -- use OUTFIFO_WE to enable output data write: must skip first header word, wait until data is available (not empty) and output fifo is not full
    -- outfifo_we  <= '1' when want_we = '1' and data_ready = '1' and outfifo_full = '0' else '0';
    outfifo_we  <= '1' when want_we = '1' and data_ready = '1' and outfifo_full = '0' else '0';

    -- read whenever we writing (to make sure next one is new)
    --  Use WANT_RE to force one extra read of the first DIGI header word (containing EWTAG number plus number of hits) 
    --  which is passed to the DigiReaderFIFO but not to the DDR 
    lane0_re    <= '1' when ((outfifo_we = '1' and current_lane = 0) or want_re(0) = '1') and rocfifo_empty(0) = '0' else '0';
    lane1_re    <= '1' when ((outfifo_we = '1' and current_lane = 1) or want_re(1) = '1') and rocfifo_empty(1) = '0' else '0';
    lane2_re    <= '1' when ((outfifo_we = '1' and current_lane = 2) or want_re(2) = '1') and rocfifo_empty(2) = '0' else '0';
    lane3_re    <= '1' when ((outfifo_we = '1' and current_lane = 3) or want_re(3) = '1') and rocfifo_empty(3) = '0' else '0';

    
    with current_lane select
        current_data <= lane0_data when 0,
                        lane1_data when 1,
                        lane2_data when 2,
                        lane3_data when 3;

    
    
    process(reset_n, newspill_reset, clk)
    begin
    if reset_n = '0' OR newspill_reset = '1'  then
        state <= RESET;
        state_count <= (others => '0');
        
        current_lane <= 0;
        curr_ewfifo_wr <= '1';
        ew_done <= '0';
        ew_ovfl <= '0';
        ew_size <= (others => '0');
        ew_tag <= (others => '0');
        ew_tag_error <= '0';
        lane_size <= (others => '0');
        full_size <= (others => '0');
        rd_cnt <= (others => '0');
        wr_cnt <= (others => '0');
        wait_cnt <= (others => '0');
        timeout_en <= '0';
        timeout_cnt <= (others => '0');
        
        want_we     <= '0';
        want_re <= (others => '0');
        ew_fifo_we  <= '0';
        uart_fifo_we<= '0';
        uart_fifo_data <= (others => '0');
        ew_fifo_data <= (others => '0');
        
        first_used_lane <= 4;     -- this is an unphysical value: use to disable start of STATE MACHINE until ROCFIFOs are seeing good data
        active_lane <= (others => '0');
        
    elsif rising_edge(clk) then
    
        want_re <= (others => '0');
        ew_fifo_we  <= '0';
        uart_fifo_we<= '0';
        
        -- set FIRST enabled lane
        if ( use_lane(0) = '1') then
            first_used_lane <= 0;        
        elsif ( use_lane(1) = '1') then
            first_used_lane <= 1;       
        elsif ( use_lane(2) = '1') then
            first_used_lane <= 2;      
        elsif ( use_lane(3) = '1') then
            first_used_lane <= 3;
        else     
            first_used_lane <= 4;
        end if;
        
        case state is
        
            when RESET =>
                state_count <= X"01";
                wait_cnt <= wait_cnt + 1;
                if wait_cnt > X"F0" then
                    state <= IDLE;
                end if;
                
            -- find next lane in use
            when IDLE => 
                state_count <= X"02";
                if  first_used_lane < 4 then
                    if  use_lane(current_lane) = '1'    then 
                        state <= START;
                    else    
                        state <= UPDATE;
                    end if;
                end if;
                
            when START =>
                state_count <= X"03";
                ew_done <= '0';
                
                if rocfifo_empty(current_lane) = '0' and outfifo_full = '0' then
                
                    -- force ROCFIFOs read 
                     want_re(current_lane) <= '1';
                    
                    -- set EW_TAG for first enabled lane. Set an error if other enabled lanes don't agree
                    if current_lane = first_used_lane   then
                        curr_ewfifo_wr <= not curr_ewfifo_wr;
                        ew_tag <= current_data(SPILL_TAG_BITS-1 downto 0);
                    elsif current_data(SPILL_TAG_BITS-1 downto 0) /= ew_tag then
                        ew_tag_error <= '1';
                    end if;
                     
                    -- assume header word from Richie is in unit of 128-bit (ie number of DTC packets == 2*(no. of hits) )
                    --  LANE_SIZE is in units of 32-bits and use to save the number of hits in the current lane
                    --  FULL_SIZE is in units of 64-bits (or AXI beats) and saves the total number of hits in the window
                    lane_size <= unsigned(current_data(30 downto 20) & "00");  
                    full_size <= full_size + unsigned(current_data(30 downto 20) & '0');
                    
                    -- write header word to DigiReaderFIFO (but not to DDR)
                   if use_uart then
                        uart_fifo_we    <= '1';
                        uart_fifo_data 	<= current_data;
                    end if;
                    
                    state <= CHECK;
                end if; 
            
            -- don't write any payload out until the size is checked!    
            when CHECK =>
                state_count <= X"04";
                
                if full_size > MAX_BEATS then  -- set overflow condition of too many hits per window
                    --ew_ovfl <= '1';
                    ew_size <= std_logic_vector(to_unsigned(MAX_BEATS,ew_size'length));
                else
                    ew_size <= std_logic_vector(full_size(EVENT_SIZE_BITS-1 downto 0)); -- event size in units of 64-bit AXI beats                
                end if;
                
                if lane_size > 0 then
                    want_we <= '1';     -- enable OUTFIFO_WE: its logic requires ROCFIFO's not empty anyway
                    state <= COUNT;
                else
                    state <= UPDATE;  -- no need to write any payload. Go and check the next lane
                end if;
                
            when COUNT =>
                state_count <= X"05";
                
                if outfifo_we = '1' then
                    
                    -- use WR_CNT (in units of 32-bits) to decide when the event has reached the maximum allowed size 
                    wr_cnt <= wr_cnt + 1;
                    
                    if  wr_cnt <= (2*unsigned(ew_size) - 1)  then
                        if use_uart then
                            uart_fifo_we    <= '1';
                            uart_fifo_data 	<= current_data;
                        else
                            ew_fifo_we      <= '1';
                            ew_fifo_data    <= current_data;
                        end if;
                    else
                        ew_ovfl <= '1';
                    end if;
                    
                    -- use RD_CNT (in units of 32-bits) to decide when the lane is done 
                    rd_cnt <= rd_cnt + 1;
                    if rd_cnt = (lane_size - 1) then
                        want_we <= '0'; -- disable OUTFIFO_WE             
                        state <= UPDATE;
                    end if;
                end if;
                
                
            when UPDATE =>                
                state_count <= X"06";
                rd_cnt <= (others => '0');
                if current_lane < NROCFIFO-1 then
                    current_lane <= current_lane + 1;
                    -- used for ILA
                    if      (active_lane = B"00") then active_lane <= B"01";
                    elsif   (active_lane = B"01") then active_lane <= B"10";
                    elsif   (active_lane = B"10") then active_lane <= B"11";
                    end if;
                    STATE <= IDLE;
                else
                    current_lane <= 0;
                    active_lane <= (others => '0');
                    wr_cnt <= (others => '0');
                    ew_done <= '1';
                    state <= HOLD;
                end if;
                
            when HOLD =>
                state_count <= X"07";
                ew_done <= '0';
                if axi_start_on_serdesclk = '1' then
                    ew_size <= (others => '0');
                    full_size <= (others => '0');
                    ew_ovfl <= '0';
                    state <= IDLE;
                end if;
                
            when OTHERS =>
                state_count <= X"0F";
                state <= IDLE;
                
        end case;
        
    end if;  -- end of  if rising_edge(clk) 
    
    end process;
    
end architecture_ROCFIFOController;
