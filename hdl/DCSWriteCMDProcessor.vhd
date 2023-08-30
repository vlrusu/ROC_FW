--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DCSWriteCMDProcessor.vhd
-- File history:
--      <v1>: <07/18/22>: services single DCS Write commands to uProc
--      <v2>: <08/10/22>: services single and block DCS Write commands to uProc
--      <v3>: <08/03/23>:  remove address space check to start SM (done in DCSProcessor now)
--
-- Description: 
--
-- <Description here>
--      Respond to DCS Write commands with adress in 0x100-0x200 range from DCSProcessor.
--      Generate DCSWriteCMD Packet and passes it to CMD_IN_PROC on 200 MHz DCS_CLK.
--      DCSWriteCMD structure:
--          header word:    0XAABB
--          packet lenght:  1-N(*) in units of payload words (i.e. 1 for DCS single WRITE, 1-N for DCS block write) 
--          payload:        N x 16-bit words
--          trailer word:   0xFFEE
--        (*)  Maximum N = 8187 (0x1FFB) calculated as words in first packet (3) plus max. no of additional packets (1023x8)
--              This constraints CMD_IN_PROC FIFO size (16bx8K)
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

entity DCSWriteCMDProcessor is
port (
-- DTC Interface ports
    DCS_CLK			: IN    std_logic;	-- 200 MHz recovered RX clock
	WRITE_CMD		: IN    std_logic;	-- flag for first data WRITE			
	BLOCK_CMD		: IN    std_logic;	-- must be set at the same time as READ_CMD/WRITE_CMD to qualify if BLOCK_WR is coming			
	BLOCK_SIZE		: IN    std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);				
    ADDR_IN			: IN    std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
    DATA_IN			: IN    std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
	NEXT_WRITE_CMD	: IN    std_logic;	-- write word ready			
    RESET_N 		: IN    std_logic;	

	NEXT_WRITE_ACK	: OUT   std_logic;	-- write word acknowledged			
    CMD_IN_WE       : OUT   std_logic;
    CMD_IN_DATA	    : OUT   std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
 -- to ErrorCounter   
    state_count	    : OUT   std_logic_vector(7 DOWNTO 0)

);
end DCSWriteCMDProcessor;

architecture architecture_DCSWriteCMDProcessor of DCSWriteCMDProcessor is

   type state_type is (IDLE, START, WRITECMD, WRITESIZE, DATAWAIT, DATAACK, DONE);
   signal state             : state_type;
--   signal state_count	    : std_logic_vector(7 DOWNTO 0); 

   -- signal, component etc. declarations
   signal command_length    : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
   signal cnt_length        : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 

   signal command_addr      : std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);
   signal command_data      : std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
   
begin

	-------------------------------------------------------------------------------
   -- Process Read/Write Commands
   -------------------------------------------------------------------------------
   process(RESET_N, DCS_CLK)
	begin
        if RESET_N = '0' then
         
            state       <= IDLE;
            state_count <= (others => '0');
            command_addr    <= (others => '0');
            command_data    <= (others => '0');
            command_length  <= (others => '0');
            NEXT_WRITE_ACK  <= '0';
            CMD_IN_WE   <= '0';
            CMD_IN_DATA <= (others => '0');
         
        elsif rising_edge(DCS_CLK) then
         
            CMD_IN_WE <= '0';
         
		----------------------------------			
		-- DCS WRITE TO PROCESSOR
		----------------------------------	
            -- wait for register dedicated to processor commands and latch all relevant info
            case state is
            
            when IDLE => 
                state_count <= X"01";
                cnt_length <= (others => '0');
                if  WRITE_CMD = '1'     then  
                    command_addr    <= ADDR_IN;
                    command_data    <= DATA_IN;
                    command_length  <= X"0001";
                    if (BLOCK_CMD = '1') then
                        command_length  <= std_logic_vector(unsigned(BLOCK_SIZE));
                    end if;
                    state <= START;
                end if;
            
            --start writing of DCS_INPUT_BUFFER
            when START =>
                state_count <= X"02";
                CMD_IN_WE   <= '1';
                CMD_IN_DATA <= CMDHEADER; 
                state <= WRITESIZE;
            
            --write command size
            when WRITESIZE =>
                state_count <= X"03";
                CMD_IN_WE   <= '1';
                CMD_IN_DATA <=  command_length;
                state <= WRITECMD;
            
            --write command type
            when WRITECMD =>
                state_count <= X"04";
                CMD_IN_WE   <= '1';
                CMD_IN_DATA <= X"C" & command_addr(11 downto 0); --  microprocess commands always have [15:12]=0xC 
                cnt_length <= std_logic_vector(unsigned(cnt_length) + 1);
                if  unsigned(command_length) = X"0"  then
                    state <= DONE;
                else
                    state <= DATAWAIT;
                end if;
             
            -- write as many data as needed
            when DATAWAIT =>
                state_count <= X"05";
                command_data<= DATA_IN;
                
                -- if bad command lenght, write error word
                if ( unsigned(command_length) > unsigned(MAX_CMD_LENGHT)) then
                    command_data <= CMDERROR;
                end if;
                
                if (BLOCK_CMD = '1') then
                    if  NEXT_WRITE_CMD = '1'    then
                        NEXT_WRITE_ACK  <= '1';
                        CMD_IN_WE   <= '1';
                        CMD_IN_DATA <= command_data;
                        state <= DATAACK;
                    end if;
                else
                    CMD_IN_WE   <= '1';
                    CMD_IN_DATA <= command_data;
                    state <= DONE;
                end if;
            
            when DATAACK =>
                state_count <= X"06";
                NEXT_WRITE_ACK  <= '0';
                cnt_length      <= std_logic_vector(unsigned(cnt_length) + 1);
                
                -- force early termination if commands lenght is bad
                if  unsigned(command_length) > unsigned(MAX_CMD_LENGHT)   then
                    state <= DONE;
                end if;
                
                if (cnt_length = command_length) then
                    state <= DONE;
                else
                    state <= DATAWAIT;
                end if;
            
            when DONE =>
                state_count <= X"07";
                CMD_IN_WE   <= '1';
                CMD_IN_DATA <= CMDTRAILER; 
                state <= IDLE;
            
            when others =>
                state_count <= X"FF";
            
         end case;   
      end if;
   end process;
   
end architecture_DCSWriteCMDProcessor;
