--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DCSRegisters.vhd
-- File history:
-- File history:
--      <v0>: <06/26/22>: First version reading from CRDCS_EXAMPLE_RD and wrting content to CRDCS_EXAMPLE_WR
--      <v1>: <07/05/22>: Add CMD_RX_BUFFER
--      <v2>: <08/03/22>: Clean logic and add comments: tested for single DCS Read/Block DCS Read (inclusing READSPI)
--
-- Description: 
--
--  Code for APB slave transactions: note that since processor is APB MASTER
--      -> after DCS WR commands, uProc reads data from PRDATA
--      -> after DCS RD commands, uProc writes data to PWDATA
--  Based on SlowControls/REGISTERS module.  It contains:
--      1) P_RX state machine to read data from CMD_TO_PROC FIFO (written by TOP_SERDES/DCSWriteCMDProcessor) 
--          and pass it to DCS_RX_BUFFER until CMDTrailer is found, ie CMD_Ready is generated.
--          State machine end is controlled by DCS_RX_EMPTY = '1', which required response from uProc
--      2) P_TX state machine to write data to DCS_TX_BUFFER (eventually picked up by TOP_SERDES/DCSReadCMDProcessor) 
--      3) control logic for data to be read from PRDATA and written to PWDATA 
--  N.B.  Allow extending of transfers from APB Slave by driving PREADY LOW
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

entity DCSRegisters is
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
   
    PROC_CMD_DATA_IN:   in  std_logic_vector(15 downto 0);
    PROC_CMD_RDCNT  :   in  std_logic_vector(10 downto 0);
    PROC_CMD_EMPTY  :   in  std_logic;
    PROC_CMD_FULL   :   in  std_logic;
    PROC_CMD_RE     :   out std_logic;

    DCS_RX_WE       :   out std_logic;
    DCS_RX_IN       :   out std_logic_vector(15 downto 0);
    DCS_RX_EMPTY    :   in  std_logic;
    DCS_RX_FULL     :   in  std_logic;
    DCS_RX_OUT      :   in  std_logic_vector(15 downto 0);
    DCS_RX_RE       :   out std_logic;

    DCS_TX_WE       :   out std_logic;
    DCS_TX_IN       :   out std_logic_vector(15 downto 0);

    DCS_CMD_STATUS  :   out std_logic_vector(15 downto 0);
    DCS_DIAG_DATA   :   out std_logic_vector(15 downto 0)
);
end DCSRegisters;

architecture architecture_DCSRegisters of DCSRegisters is

    -- DCS Commands APB address offset
	constant CRDCS_CMD_STATUS  : std_logic_vector(7 downto 0) := x"00";     -- PADDR = 0x7A00_0000
	constant CRDCS_CMD_Ready   : std_logic_vector(7 downto 0) := x"01";     -- PADDR = 0x7A00_0004
	constant CRDCS_READ_RX     : std_logic_vector(7 downto 0) := x"02";     -- PADDR = 0x7A00_0008
	constant CRDCS_WRITE_TX    : std_logic_vector(7 downto 0) := x"03";     -- PADDR = 0x7A00_000C
	constant CRDCS_DIAG_DATA   : std_logic_vector(7 downto 0) := x"04";     -- PADDR = 0x7A00_0010
   
  -------------------------------------------------------------------------------
  -- Signal declarations
  -------------------------------------------------------------------------------
   type state_type is (IDLE, SENDREAD, SENDWRITE, HOLD, HOLD1, HOLD2, HOLD3, READY);
   signal prdata_state  : state_type;
   signal rx_in_state: state_type;
   signal tx_in_state: state_type;

   signal DataOut       : std_logic_vector(APB_DATA_WIDTH-1 downto 0);
   signal DataOutLatch  : std_logic_vector(APB_DATA_WIDTH-1 downto 0);
  
   signal Is_BufferRD   : std_logic;
   signal Is_BufferWR   : std_logic;
   signal CMD_Ready     : std_logic;
   
   signal tx_data       : std_logic_vector(APB_DATA_WIDTH-1 downto 0);

begin

-------------------------------------------------------------------------------
--  PREADY was always high BEFORE introducing microProc reading from FIFO
--  With the introduction of CMD_RX_BUFFER, during the access phase  when PENABLE is HIGH, 
--  the APB Slave extends the transfrer by driving PREADY LOW
--  PREADY  <= '1';
    PSLVERR <= '0';
    
    --*****************************************************************************************
    -- State Machine to control CMD_RX_BUFFER writing and reading
    --     generate CMD_READY used by uProc to know that a commands is ready to be processed
    p_rx: process (PRESETn, PCLK, PROC_CMD_EMPTY)
    begin
        if (PRESETn = '0') then -- initialize output registers
            
            DCS_RX_WE   <= '0'; 
            DCS_RX_IN   <= (others => '0'); 
            PROC_CMD_RE <= '0';
            CMD_Ready   <= '0';
            rx_in_state <= IDLE;
         
        elsif (PCLK'event and PCLK = '1') then
         
            DCS_RX_WE   <= '0'; 
            DCS_RX_IN   <= (others => '0'); 
                
            case rx_in_state is
            
            when IDLE =>
                if (PROC_CMD_EMPTY = '0') then
                    PROC_CMD_RE <= '1';
                    rx_in_state <= SENDREAD;
                end if;
                
            ---- wait for PROC_CMD word
            when SENDREAD =>
                --PROC_CMD_RE <= '1';
                PROC_CMD_RE <= '0';
                rx_in_state <= SENDWRITE;
                
            ---- PROC_CMD word is in and can be written to CMD_RX_BUFFER
            when SENDWRITE =>
                DCS_RX_WE   <= '1';
                DCS_RX_IN   <= PROC_CMD_DATA_IN;
                if  PROC_CMD_DATA_IN = CMDTRAILER  then
                    PROC_CMD_RE <= '0';
                    CMD_Ready   <= '1';
                    rx_in_state <= HOLD;
                elsif  unsigned(PROC_CMD_RDCNT)>0 then
                    PROC_CMD_RE <= '1';
                    rx_in_state <= SENDREAD;
                end if;
                             
            -- wait few more cycles because the DCS_RX_EMPTY can take up to 6 clocks to be set!!!
            when HOLD =>
                rx_in_state <= HOLD1;
            when HOLD1 =>
                rx_in_state <= HOLD2;
            when HOLD2 =>
                rx_in_state <= HOLD3;
                
            -- wait until processor reads all of the CMD_RX_BUFFER to go the the next command from DTC    
            when HOLD3 =>
                if (DCS_RX_EMPTY = '1') then
                    CMD_Ready   <= '0';
                    rx_in_state <= IDLE;
                end if;
                
            when OTHERS =>
                
            end case;
        end if;
    end process p_rx;

    --*****************************************************************************************
    -- Control logic for APB reads when uProc sees a command from the DTC:
    --      latch DATAOUT (to be passed to PRDATA)
    --      identify read from DCS_RX_BUFFER 
    -- NB: added PREADY to sensitivity list to accommodate pipelined read of DCS_RX_BUFFER
    p_PRDATA : process (PWRITE, PSEL, PADDR, PREADY)
    begin
        Is_BufferRD <= '0';
        DataOut     <= (others => '0');
        
        if PWRITE = '0' and PSEL = '1' and PREADY = '1' then
            
            case PADDR(9 downto 2) is
            
            when CRDCS_CMD_Ready =>    
                DataOut(15 downto 0) <= B"0000_0000_0000_000" & CMD_Ready;
            
            when CRDCS_READ_RX =>
                Is_BufferRD   <= '1';
                DataOut(15 downto 0) <= DCS_RX_OUT;
                
            when others =>
                DataOut <= (others => '0');
                
            end case;
            
        else
        
            Is_BufferRD <= '0';
            DataOut     <= (others => '0');
            
        end if;
    end process p_PRDATA;
        
      
    --*****************************************************************************************
    -- Generate PRDATA for:
    --      either single constant register sent to uProc during a WR operation, 
    --      or pipelined data saved in CMD_RX_BUFFER FIFO buffer for DTC command meant for uProc
    p_pipelined_PRDATA: process (PRESETn, PCLK)
    begin
        if (PRESETn = '0') then
            
            PREADY      <= '1';
            PRDATA      <= (others => '0');
            DataOutLatch<= (others => '0');
            DCS_RX_RE   <= '0'; 
            prdata_state<= IDLE;
            
        elsif (PCLK'event and PCLK = '1') then
            
            PREADY  <= '1';
            DCS_RX_RE   <= '0';
         
            case prdata_state is
         
            when IDLE =>
                if (PSEL = '1' and PWRITE = '0') then
                    -- extend transfer while DCS_RX_BUFFER had data
                    if (DCS_RX_EMPTY = '0' and Is_BufferRD = '1') then
                        PREADY      <= '0';
                        DCS_RX_RE   <= '1';
                        prdata_state<= READY; 
                    else
                    -- normal APB read request from microProc 
                        PRDATA <= DataOut;
                    end if;
                end if; 
                
            -- wait for DATAOUT to change after PREADY low
            when READY =>
                prdata_state   <= HOLD; 
                
            when HOLD =>
                PRDATA         <= DataOut;
                prdata_state   <= IDLE; 
                
            when OTHERS => 
                
            end case;
        end if;
    end process p_pipelined_PRDATA;
     
        
    --*****************************************************************************************
    -- Control logic for APB writes when uProc responds to command from the DTC:
    --      latch PWDATA from CMD_TX_BUFFER 
    --      set IS_BUFFERWR to start TX_IN_STATE state machine
    p_reg_seq : process (PRESETn, PCLK, PSEL, PENABLE, PWRITE)
    begin
        if (PRESETn = '0') then -- initialize output registers
            
            Is_BufferWR     <= '0';
            DCS_DIAG_DATA   <= (others => '0');
            DCS_CMD_STATUS  <= (others => '0');
            tx_data         <= (others => '0');
         
        elsif (PCLK'event and PCLK = '1') then
            
            Is_BufferWR  <= '0';
            
            if (PWRITE = '1' and PSEL = '1' and PENABLE = '1') then
                case PADDR(9 downto 2) is
                               
                when CRDCS_CMD_STATUS =>
                    DCS_CMD_STATUS  <= PWDATA(15 downto 0);
                
                when CRDCS_DIAG_DATA =>
                    DCS_DIAG_DATA   <= PWDATA(15 downto 0);
                    
                --  needs to write 24x32-bits to CMX_TX_BUFFER
                when CRDCS_WRITE_TX =>
                    Is_BufferWR <= '1';
                    tx_data     <= PWDATA;
                    
                when others =>
                    
                end case;
            end if;
        end if;
    end process p_reg_seq;


   --*****************************************************************************************
    -- State Machine to control CMD_TX_BUFFER writing
    p_tx: process (PRESETn, PCLK)
    begin
        if (PRESETn = '0') then -- initialize output registers
            
            DCS_TX_WE   <= '0'; 
            DCS_TX_IN   <= (others => '0'); 
            tx_in_state <= IDLE;
         
        elsif (PCLK'event and PCLK = '1') then

            DCS_TX_WE   <= '0'; 
            DCS_TX_IN   <= (others => '0'); 
                
            case tx_in_state is
            
            when IDLE =>
                if (Is_BufferWR = '1') then
                    DCS_TX_WE <= '1';
                    DCS_TX_IN <= tx_data(15 downto 0);
                    tx_in_state <= HOLD;
                end if;
                
            -- wait for Is_BufferWR to clear
            when HOLD =>
                if (Is_BufferWR = '0') then
                    tx_in_state <= IDLE;
                end if;
                
            when OTHERS =>
                
            end case;
        end if;
    end process p_tx;
    
end architecture_DCSRegisters;
