							   --------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Reset_Watchdog.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_MISC.all; 
				   		   
library work;
use work.algorithm_constants.all; 

entity MainResetController is
port (				   
	FABRIC_RESET_N		: IN	std_logic;

	SEL_RESET 			: IN    std_logic;		  					--  0 = Pre-Load/ 1 = Start
	SEL_RST_CNTL		: IN    std_logic_vector(9 downto 0);		-- 	Reset Cntl
	
	SLOW_CLK			: IN	std_logic; 
	
	RESET_FW_N			: OUT    std_logic;
	RESET_PS_N			: OUT	std_logic; 
	RESET_RM_N			: OUT	std_logic;
	RESET_CH_N			: OUT   std_logic;	
	RESET_TS_N			: OUT	std_logic;
	RESET_40CLK_N		: OUT   std_logic; 
	RESET_RESP_FIFO_N	: OUT	std_logic;
	RESET_RECV_FIFO_N	: OUT 	std_logic;
	RESET_DCSRCV_N		: OUT	std_logic;
	RESET_DCSRESP_N		: OUT	std_logic 
	
);
end MainResetController;												


architecture architecture_ResetController of MainResetController is	
-- SIGNAL DECLARATIONS			
	
	signal sel_rst_cntl_latch		: std_logic_vector(9 downto 0);
	signal sel_rst_cntl_latch1		: std_logic_vector(9 downto 0);
	signal sel_reset_latch			: std_logic;	   	  
	signal sel_reset_risingEdge		: std_logic;
	
	signal 	reset_init_counter		: unsigned(9 downto 0); 
	--signal 	reset_count				: unsigned(9 downto 0);
	signal	reset_fw_sig			: std_logic;			
	signal	reset_ps_sig			: std_logic;
	signal	reset_rm_sig			: std_logic;
	signal	reset_ch_sig			: std_logic;
	signal	reset_40clk_sig			: std_logic; 
	signal	reset_rcv_sig			: std_logic;
	signal	reset_rsp_sig			: std_logic;
	signal	reset_dcsrcv_sig		: std_logic;
	signal	reset_dcsrsp_sig		: std_logic;  
	signal 	reset_ts_sig			: std_logic;
	
	signal reset_init				: std_logic;
	

begin					  									  
	
		RESET_40CLK_N 				<= not (sel_rst_cntl_latch(0) and reset_40clk_sig) ;
		RESET_FW_N 					<= not (sel_rst_cntl_latch(1) and reset_fw_sig);
		RESET_CH_N					<= not (sel_rst_cntl_latch(2) and reset_ch_sig);
		RESET_TS_N					<= not (sel_rst_cntl_latch(3) and reset_ts_sig);  
		RESET_DCSRCV_N				<= not (sel_rst_cntl_latch(4) and reset_dcsrcv_sig);
		RESET_RM_N					<= not (sel_rst_cntl_latch(5) and reset_rm_sig);
		RESET_DCSRESP_N				<= not (sel_rst_cntl_latch(6) and reset_dcsrsp_sig);	
		RESET_PS_N				    <= not (sel_rst_cntl_latch(7) and reset_ps_sig);  
		RESET_RECV_FIFO_N			<= not (sel_rst_cntl_latch(8) and reset_rcv_sig);		
		RESET_RESP_FIFO_N			<= not (sel_rst_cntl_latch(9) and reset_rsp_sig);	
		

		Reset_Controller :process(SLOW_CLK)
		begin  				  
			if(rising_edge(SLOW_CLK)) then	   		
				
				--Latches
				sel_reset_latch 		<= SEL_RESET;  	  
				sel_reset_risingEdge 	<= SEL_RESET and not sel_reset_latch;  	
				sel_rst_cntl_latch1 	<= SEL_RST_CNTL;
				
				reset_40clk_sig			<= '0';	
				reset_fw_sig			<= '0';			  
				reset_ts_sig			<= '0';
				reset_ch_sig			<= '0';	   	  
				reset_rm_sig			<= '0';	   
				reset_dcsrcv_sig		<= '0';
				reset_dcsrsp_sig		<= '0';	 
				reset_ps_sig			<= '0';
				reset_rsp_sig			<= '0';
				reset_rcv_sig			<= '0';
				
				--(0) Fabric Reset Init
				if (FABRIC_RESET_N = '0') then	-- System Init	
					
					sel_rst_cntl_latch	<= (others => '1');
					reset_init  		<=	'1';	   
					reset_init_counter 	<= (others => '0');	
					
				--(1B) Selective Reset on Rising Edge
				elsif(sel_reset_risingEdge = '1' and reset_init = '0') then
					   	
					sel_rst_cntl_latch 	<= sel_rst_cntl_latch1;
					reset_init  		<=	'1';	   
					reset_init_counter	<= (others => '0');		
					
				elsif	(reset_init = '1') then		 
					
					--(1A) Fabric Reset - Power Up Sequence		 
					reset_init_counter 		<= reset_init_counter + 1;
					
					if(reset_init_counter >= 0+10 and reset_init_counter < 4+10) then	
						reset_40clk_sig		<= '1';	
					elsif (reset_init_counter >=4+10 and reset_init_counter < 8+10) then 
						reset_fw_sig		<= '1';			  
						reset_ts_sig		<= '1';
					elsif (reset_init_counter >=8+10 and reset_init_counter < 20+10) then  
						reset_rcv_sig		<= '1';
						reset_rsp_sig		<= '1';
						reset_ch_sig		<= '1';	   	  
						reset_rm_sig		<= '1';	   
						reset_dcsrcv_sig	<= '1';
						reset_dcsrsp_sig	<= '1';
					elsif (reset_init_counter >= 20+10 and reset_init_counter < 28+10) then	   
						reset_ps_sig		<= '1';
					elsif(reset_init_counter > 28+10) then
						reset_init 			<= '0';
					end if;														
					
				--	--(1B) Preload and Reset Cntl					
--					else						 
--						if(reset_count > 4) then 
--							sel_rst_cntl_latch	<= (others => '0');		 	
--						else
--							reset_count <= reset_count + 1;
--						end if;
					--end if;					
				end if;		
				
			END IF;
		end process;	 		
end architecture_ResetController;
