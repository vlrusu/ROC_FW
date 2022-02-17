--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DRACRegisters.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;	  							
USE IEEE.std_logic_1164.ALL;				 
USE IEEE.numeric_std.ALL;			  			 
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.algorithm_constants.all; 

entity DRACRegisters is
port (
    --<port_name> : <direction> <type>;
   DCS_CLK				: IN  std_logic;				-- 50 MHz clock
	READ_REG				: IN  std_logic;				
	WRITE_REG			: IN  std_logic;				
   READY_REG 			: OUT  std_logic;					-- signal that requested data is on DATA_OUT
   RESET_N 				: IN  std_logic;				--
   ADDR_IN				: IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
   DATA_IN				: IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
   DATA_OUT				: OUT  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
   
   -- Debugging
   DEBUG_REG_0			: IN  std_logic_vector(15 downto 0);
   PREREAD_PULSE		: OUT std_logic;
	SEL_RST				: OUT std_logic;

   -- DRAC specific registers
	DDR_DDR3_FULL		: IN	std_logic;								-- stays highes from WRITE_PAGE_NO written to memory until all read out. Read via addr=11.
	TEMPFIFO_EMPTY		: IN	std_logic;								-- status of TEMPFIFO empty (contain 1kB page on the way to DDR). Read via addr=12, bit[0].
	TEMPFIFO_FULL		: IN	std_logic;								-- status of TEMPFIFO full  (contain 1kB page on the way to DDR). Read via addr=12, bit[1].
	MEMFIFO_EMPTY		: IN	std_logic;								-- status of MEMFIFO empty  (contain 1kB page on the way out of DDR). Read via addr=12, bit[2].
	MEMFIFO_FULL		: IN	std_logic;								-- status of MEMFIFO full  (contain 1kB page on the way out of DDR). Read via addr=12, bit[3].
	MEM_WR_CNT			: IN  std_logic_vector(31 DOWNTO 0);	-- no. of 1KB pages written to DR3 memory. Read via addr=13/14 (LSB/MSB).
	MEM_RD_CNT			: IN  std_logic_vector(31 DOWNTO 0);	-- no. of 1KB pages read from DR3 memory. Read via addr=15/16 (LSB/MSB).
	FIFO_RD_CNT			: IN  std_logic_vector(15 DOWNTO 0);	-- no. of data payload packets. Read via addr=17. (NB: this is the number of FIFO_RD_EN/2!)
	DCS_DREQ_SEL		: OUT std_logic;								-- enable simulation of Data Request Protocol via serial (addr=8, bit[4])
   DCS_DDRRESET		: OUT STD_LOGIC;								-- specific firmware reset (separate from TOP_Serdes reset, although it does drive EXT_RST_N)
	DCS_WRITE_MEM_EN	: OUT std_logic;								-- enable write of data to memory
	DCS_READ_MEM_EN	: OUT std_logic;								-- enable read of 1 kB page from memory (ie simulates DATA_REQUEST from DTC)
	DCS_MEMFIFO_REN	: OUT std_logic;								-- enable memory data to TOP_SERDES (ie simulates DATA_REPLY to DTC)
	DCS_FORCE_MEMRD	: OUT std_logic;								-- force DDR3_FULL=1 .AND. MEM_RD_CNT=0 to allow for new DDR3 memory read
	DCS_PATTERN_EN		: OUT std_logic;								-- switch between DIGIFIFO/PATTERN_FIFO inputs to memory when 0/1 (addr=8, bit[3])
   DCS_PATTERN			: OUT std_logic_vector(1 downto 0);		-- pattern generator type: 0=>+1, 1=>-1, 2=>A's,  3=>5's (addr=8, bit[1,0])
   DCS_WRITE_PAGE_NO	: OUT std_logic_vector(19 downto 0)	   -- MAX. no of 1kB pages wirtten to memory.  NB: ALGO_ADDR can drive only 15 LSB (ie MAX = 2**15 = 32768).
);
end DRACRegisters;

architecture architecture_DRACRegisters of DRACRegisters is
		
   -- signal, component etc. declarations
	signal drac_read		: std_logic;
	signal drac_write		: std_logic;
   signal drac_addrs		: std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
   signal drac_wdata		: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 	
		
	signal read_latch		: std_logic;				
	signal write_latch	: std_logic;				
		
   signal writeCounter			: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
   signal readCounter			: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
		
	--signal sel_rst					: std_logic;
	signal reset_sig				: std_logic;
	signal ddr_full				: std_logic;
	signal tempfifo_e				: std_logic;
	signal tempfifo_f				: std_logic;
	signal memfifo_e				: std_logic;
	signal memfifo_f				: std_logic;
	signal mem_write_cnt			: std_logic_vector(31 downto 0);
	signal mem_read_cnt			: std_logic_vector(31 downto 0);
	signal fifo_read_cnt			: std_logic_vector(15 downto 0);
	
	signal dreq_sel_reg			: std_logic;
	signal pattern_en_reg		: std_logic;
   signal pattern_reg			: std_logic_vector(gAPB_DWIDTH-1 downto 0);
   signal write_page_reg_LSB	: std_logic_vector(gAPB_DWIDTH-1 downto 0);
   signal write_page_reg_MSB	: std_logic_vector(gAPB_DWIDTH-1 downto 0);
		
begin	
		
   -- architecture body
   drac_read	<= READ_REG;
   drac_write	<= WRITE_REG;
   drac_addrs 	<= ADDR_IN; 
   drac_wdata 	<= DATA_IN;
	
	-------------------------------------------------------------------------------
   -- Process Read/Write Commands
   -------------------------------------------------------------------------------
	process(RESET_N, DCS_CLK)
	begin
	if RESET_N = '0' then
			
		--ALGO_RESET 	<= '1';	
			
		writeCounter 		<= (others => '0');  
		readCounter 		<= (others => '0'); 
			
		dreq_sel_reg		<= '0';	
		pattern_en_reg		<= '0';	
		pattern_reg			<= (others => '0');
		write_page_reg_LSB<= (others => '0');
		write_page_reg_MSB<= (others => '0');
					
		--ram_wdata         <= (others => '0');
		--ram_addr          <= (others => '0');
		--fifo_wdata        <= (others => '0');
	elsif rising_edge(DCS_CLK) then
			
		READY_REG		<= '0'; 
			
		--ALGO_RESET     <= '0'; 				
		PREREAD_PULSE  <= '0';
		DATA_OUT      	<= (others => '0');
			
		read_latch		<= '0';
		write_latch		<= '0';
		SEL_RST			<= '0';
				
		DCS_DDRRESET		<= '0';
		DCS_WRITE_MEM_EN	<=	'0';
		DCS_READ_MEM_EN	<= '0';
		DCS_MEMFIFO_REN	<= '0';
		DCS_FORCE_MEMRD	<= '0';
		DCS_DREQ_SEL		<=	dreq_sel_reg;
		DCS_PATTERN_EN		<= pattern_en_reg;
		DCS_PATTERN			<= pattern_reg(1 downto 0);
		DCS_WRITE_PAGE_NO	<= write_page_reg_MSB(7 downto 0) & write_page_reg_LSB(11 downto 0);		
				
-- for signal that have to change clock domain
		ddr_full				<= DDR_DDR3_FULL;
		tempfifo_e			<=	TEMPFIFO_EMPTY;	
		tempfifo_f			<=	TEMPFIFO_FULL;	
		memfifo_e			<=	MEMFIFO_EMPTY;	
		memfifo_f			<=	MEMFIFO_FULL;	
		mem_write_cnt		<= MEM_WR_CNT;
		mem_read_cnt		<= MEM_RD_CNT;
		fifo_read_cnt		<= FIFO_RD_CNT;
		
		----------------------------------			
		-- DCS REGISTER WRITE
		----------------------------------	
		if (drac_write = '1') then	
			
			write_latch	<= drac_write;
			if (drac_write = '1' and write_latch = '0') then
				writeCounter <= writeCounter + 1;
			end if;
						
			-- 0...7 are reserved registers to deal with other modules inside TOP_SERDES
			if (drac_addrs = 0) then			-- RESET ALL
				SEL_RST	<= '1';
			elsif (drac_addrs = 1) then		-- SELECTIVE RESET 
				SEL_RST	<= '1';
				--reset_cntl	    <= drac_wdata(9 downto 0);	  -- any bit high issues reset to the associated block 
			--elsif (drac_addrs = 2) then			 -- reserved to drive ALGO_ADDR in module write/read 
				--algo_addr_sig <= drac_wdata;
			--elsif (drac_addrs = 3) then			 -- reserved to drive ALGO_WDATA in module write/read
				--algo_wdata_sig <= drac_wdata;
			--elsif (drac_addrs = 4) then
				--DCS_ALIGNMENT_REQ <= '1';   		-- self clearing	  
			--elsif (drac_addrs = 5) then
				--evtstart_delay_en_reg	<= drac_wdata(14);				  
				--evtstart_delay_fine_reg	<= "00" & drac_wdata(13 downto 0);	
			--elsif (drac_addrs = 6) then
				--RESET_XCVR_ERRORS			<= '1';	-- self clearing			  
            
			-- 8...255 are reserved for DRAC controls and registers
			elsif (drac_addrs = 8) then
				pattern_reg 	<= B"000X_0000_000X_00" & drac_wdata(1 downto 0);
				pattern_en_reg	<= drac_wdata(3);				  
				dreq_sel_reg	<= drac_wdata(4);	
			elsif (drac_addrs = 9) then
				write_page_reg_LSB <= X"0" & drac_wdata(11 downto 0);
				elsif (drac_addrs = 10) then
				write_page_reg_MSB <= X"00" & drac_wdata(7 downto 0);
			elsif (drac_addrs = 11) then
				DCS_WRITE_MEM_EN	<= '1';	 -- self clearing
			elsif (drac_addrs = 12) then
				DCS_READ_MEM_EN	<= '1';	 -- self clearing
			elsif (drac_addrs = 13) then
				DCS_MEMFIFO_REN	<= '1';	 -- self clearing
			elsif (drac_addrs = 14) then
				DCS_DDRRESET		<= '1';	 -- self clearing
			elsif (drac_addrs = 15) then
				DCS_FORCE_MEMRD	<= '1';	 -- self clearing
			--elsif (drac_addrs = 126) then
				--fifo_we   <= '1';
				--fifo_wdata <= drac_wdata(7 downto 0);
			--elsif (drac_addrs >= 127 and drac_addrs <255) then   -- allow for one register per straw
				--ram_we    <= '1';
				--ram_addr  <= drac_addrs(7 downto 0);
				--ram_wdata <= drac_wdata(7 downto 0);
			end if;
				
		----------------------------------			
		-- DCS REGISTER READ
		----------------------------------	
		elsif (drac_read = '1') then  
				
			READY_REG		<= '1';
			read_latch		<= drac_read;
			if (drac_read = '1' and read_latch = '0') then 	             
				readCounter 	<= readCounter + 1;  
				PREREAD_PULSE	<= '1';
			end if;	
				
			-- 0...7 are reserved registers to deal with other modules inside TOP_SERDES
			if (drac_addrs = 0) then	-- monitors status of Core_PCS	 						
				DATA_OUT 	<= DEBUG_REG_0;			
			--elsif (drac_addrs = 1) then	
				--DATA_OUT 	<=  ALGO_RDATA;	-- data read from other modules
			elsif (drac_addrs = 2) then	
				DATA_OUT 	<=  writeCounter ;	-- useful counters
			elsif (drac_addrs = 3) then	 
				DATA_OUT 	<=  readCounter; 	
			--elsif (drac_addrs = 4) then		 	 
				--DATA_OUT <=   "00" &  RX_K_CHAR & 
									--"00" & ALIGNED & TX_CLK_STABLE & 
									--INVALID_K & RD_ERR & B_CERR & CODE_ERR_N;
			--elsif (drac_addrs = 5) then		 	 
				--DATA_OUT 	<= XCVR_LOSS_COUNTER;			
			--elsif (drac_addrs = 6) then		 	 
				--DATA_OUT 	<= TIMESTAMP_IN;			
					
			-- 8...255 are reserved for DRAC controls and registers
			elsif (drac_addrs = 8) then		 	 
				DATA_OUT <= B"0000_0000_000" & dreq_sel_reg  & pattern_en_reg & "0" & pattern_reg(1 downto 0);	
			elsif (drac_addrs = 9) then		 	 
				DATA_OUT <= write_page_reg_LSB;	
			elsif (drac_addrs = 10) then		 	 
				DATA_OUT <= write_page_reg_MSB;	
			elsif (drac_addrs = 11) then
				DATA_OUT	<=	B"0000_0000_0000_000" & ddr_full;
			elsif (drac_addrs = 12) then
				DATA_OUT	<= B"0000_0000_0000" & memfifo_f & memfifo_e & tempfifo_f & tempfifo_e;
			elsif (drac_addrs = 13) then
				DATA_OUT	<= mem_write_cnt(15 downto 0);
			elsif (drac_addrs = 14) then
				DATA_OUT	<= mem_write_cnt(31 downto 16);
			elsif (drac_addrs = 15) then
				DATA_OUT	<= mem_read_cnt(15 downto 0);
			elsif (drac_addrs = 16) then
				DATA_OUT	<= mem_read_cnt(31 downto 16);
			elsif (drac_addrs = 17) then
				DATA_OUT	<= fifo_read_cnt;
			--elsif (drac_addrs = 126) then		 	 
				--fifo_re   <= PREREAD_PULSE;
				--DATA_OUT <= "00000000" & fifo_rdata;
			--elsif (drac_addrs >= 127 and drac_addrs <255) then   -- allow for one register per straw
				--ram_we    <= '0';
				--ram_addr  <= drac_addrs(7 downto 0);
				--DATA_OUT <= "00000000" & ram_rdata;							-- only 8-bit ram data allowed!!
			else	
				DATA_OUT <= drac_addrs;		  --Unmapped Addresses
			end if;								  							   		   
				
		end if;    -- if drac_write or read 
			
	end if;
	end process;
	
end architecture_DRACRegisters;
