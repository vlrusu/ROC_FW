--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: ClockAligner.vhd
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
use IEEE.NUMERIC_STD.all; 

entity ClockAligner is
port (
		RX_RESET_N  : IN std_logic;
		RX_CLK		: IN std_logic; 
        
        CTRL_RESET_N: IN std_logic;
        CTRL_CLK    : IN std_logic;
        
		RX_DATA		: IN std_logic_vector(19 downto 0); 
        PCS_ALIGNED : IN std_logic;
        RX_VAL      : IN std_logic;
        
        BITSLIP_START   : IN std_logic;
        BITSLIP_SHIFT   : IN std_logic_vector(4 downto 0); 
        
        ENABLE_ALIGNMENT: in std_logic;
        CLOCK_ALIGNED   : out std_logic;
        ALIGNMENT_LOSS_COUNTER  : out std_logic_vector(15 downto 0);
        ALIGNMENT_RESET_N       : out std_logic
);
end ClockAligner;
architecture architecture_ClockAligner of ClockAligner is

	--BITSLIP REGISTERS--
	constant match_default 	:   std_logic_vector(19 downto 0) := x"941CF";

    signal rx_raw_data_latch : std_logic_vector(19 downto 0);
    signal clock_aligned_1Q : std_logic;
    signal alignment_state : std_logic_vector(1 downto 0);
    signal alignment_counter : unsigned(6 downto 0);
    signal pcs_alignment_counter : unsigned(15 downto 0);
    signal reset_counter : unsigned(6 downto 0);
    signal aligned_flag : std_logic;
    signal aligned_flag_1Q : std_logic;
    signal aligned_flag_2Q : std_logic;
    signal pcs_aligned_1Q : std_logic;
    signal pcs_aligned_2Q : std_logic;
    signal rx_val_1Q : std_logic;
    signal rx_val_2Q : std_logic;
    
    signal  rx_raw_data_match       : std_logic_vector(19 downto 0);
    signal  bitslip_raw_data_match  : unsigned(19 downto 0);
    signal  bitslip_start_reg: std_logic;
    signal  bitslip_end     : std_logic;
    signal  bitslip_end_1Q  : std_logic;
    signal  bitslip_end_2Q  : std_logic;
    signal  bitslip_shift_reg   : std_logic_vector(4 downto 0);
    signal  bitslip_counter     : unsigned(4 downto 0);

begin

    process(CTRL_RESET_N, CTRL_CLK)
    begin
    if CTRL_RESET_N = '0' then
        clock_aligned <= '0';
        ALIGNMENT_RESET_N <= '1';
        alignment_state <= "00";
        alignment_counter <= (others => '0');
        pcs_alignment_counter <= (others => '0');	 	 
        alignment_loss_counter <= (others => '0');
        aligned_flag_1Q <= '0';
        aligned_flag_2Q <= '0';
        pcs_aligned_1Q  <= '0';
        pcs_aligned_2Q  <= '0';
        rx_val_1Q   <= '0';
        rx_val_2Q   <= '0';
        bitslip_end_1Q  <= '0';
        bitslip_end_2Q  <= '0';
    elsif rising_edge(CTRL_CLK) then
        aligned_flag_1Q <= aligned_flag;
        aligned_flag_2Q <= aligned_flag_1Q;
        pcs_aligned_1Q <= pcs_aligned;
        pcs_aligned_2Q <= pcs_aligned_1Q;
        rx_val_1Q <= rx_val;
        rx_val_2Q <= rx_val_1Q;
        
        -- force realignemnt after a new BITSLIP value is passed
        bitslip_end_1Q<= bitslip_end;
        bitslip_end_2Q<= bitslip_end_1Q;
        if  bitslip_end_1Q = '1' and bitslip_end_2Q = '0'   then
            alignment_state <= "00";
        end if;
        
        clock_aligned_1Q <= clock_aligned;
        if clock_aligned_1Q = '1' and clock_aligned = '0' then
            alignment_loss_counter <= std_logic_vector(unsigned(alignment_loss_counter) + 1);
        end if;
        
        if ENABLE_ALIGNMENT = '1' then
            case alignment_state is
            -- check for clock alignment
            when "00" =>
                reset_counter <= (others => '0');
                if pcs_aligned_2Q = '0' then
                    -- need time for pcs to regain alignment
                    pcs_alignment_counter <= pcs_alignment_counter + 1;
                    if pcs_alignment_counter(15) = '1' then
                        -- pcs hasn't regained alignment, reset
                        alignment_state <= "01";
                    end if;
                else
                    if aligned_flag_2Q = '0' then
                        alignment_counter <= alignment_counter + 1;
                        if alignment_counter(6) = '1' then
                            alignment_state <= "01"; -- failed, reset
                        end if;
                    else
                        alignment_state <= "10"; -- aligment succeeded
                    end if;    
                end if;

                -- reset clock alignment
                when "01" =>
                    alignment_counter <= (others => '0');
                    pcs_alignment_counter <= (others => '0');
                    
                    reset_counter <= reset_counter + 1;
                    if reset_counter(5 downto 4) = "00" then
                        ALIGNMENT_RESET_N <= '0';
                    end if;
                    if reset_counter(6) = '1' then
                        ALIGNMENT_RESET_N <= '1';
                        alignment_state <= "00";
                    end if;
                    
                -- success, wait until next lock
                when "10" =>
                    clock_aligned <= '1';
                    if pcs_aligned_2Q = '0' or rx_val_2Q = '0' then
                        alignment_state <= "00";
                        clock_aligned <= '0';
                    end if;
                
            end case;
        else
            ALIGNMENT_RESET_N <= '1';
        end if;
        
    end if;
    end process;
    
    process(RX_RESET_N, RX_CLK)
    begin
    if RX_RESET_N = '0' then
        bitslip_start_reg   <= '0';
        bitslip_shift_reg   <= (others => '0');
        rx_raw_data_match   <= match_default; 
        bitslip_raw_data_match   <= unsigned(match_default); 
        rx_raw_data_latch   <= (others => '0');
        aligned_flag    <= '0';
        bitslip_end     <= '0';
    elsif rising_edge(RX_CLK) then
        aligned_flag <= '0';
        rx_raw_data_latch <= RX_DATA;
        
        --if  rx_raw_data_latch(19 DOWNTO 0) = match_default or		  --check for rx_data and its 4 possible polarities.
            --rx_raw_data_latch(19 DOWNTO 0) = not match_default or
            --rx_raw_data_latch(19 DOWNTO 0) = (not match_default(19 downto 10) & match_default(9 downto 0)) or
            --rx_raw_data_latch(19 DOWNTO 0) = (match_default(19 downto 10) & not match_default(9 downto 0)) then
                --aligned_flag <= '1';
        --end if;
        
        -- start BITSLIP logic
        bitslip_start_reg   <=  BITSLIP_START;
        bitslip_shift_reg   <=  BITSLIP_SHIFT;
        
--        if (bitslip_start_reg = '1'     and     unsigned(bitslip_shift_reg) <=20)   then
        if (bitslip_start_reg = '1')   then
            bitslip_end             <=  '0';
            bitslip_counter         <=  (others => '0');
            bitslip_raw_data_match  <=  unsigned(match_default); 
        else
            if (unsigned(bitslip_shift_reg) <=20) then
                if (bitslip_counter >= 0 and bitslip_counter < unsigned(bitslip_shift_reg)) then 
                    bitslip_counter         <=  bitslip_counter + 1;
                    bitslip_raw_data_match  <=  bitslip_raw_data_match ror 1;  
                elsif (bitslip_counter = unsigned(bitslip_shift_reg))    then
                    bitslip_counter     <=  (others => '1');
                    bitslip_end         <=  '1';
                    rx_raw_data_match   <=  std_logic_vector(bitslip_raw_data_match);
                end if;
            end if;
        end if;
        
        -- check for alignment after bitslip, if enabled
        if  rx_raw_data_latch(19 DOWNTO 0) = rx_raw_data_match or		  --check for rx_data and its 4 possible polarities.
            rx_raw_data_latch(19 DOWNTO 0) = not rx_raw_data_match or
            rx_raw_data_latch(19 DOWNTO 0) = (not rx_raw_data_match(19 downto 10) & rx_raw_data_match(9 downto 0)) or
            rx_raw_data_latch(19 DOWNTO 0) = (rx_raw_data_match(19 downto 10) & not rx_raw_data_match(9 downto 0)) then
                aligned_flag <= '1';
        end if;
    end if;
    end process;
        

end architecture_ClockAligner;
