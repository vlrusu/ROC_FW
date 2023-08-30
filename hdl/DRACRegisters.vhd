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
    DCS_CLK				: IN  std_logic;				-- 200 MHz clock
	READ_REG			: IN  std_logic;				
	WRITE_REG			: IN  std_logic;				
    READY_REG 			: OUT  std_logic;					-- signal that requested data is on DATA_OUT
    RESET_N 			: IN  std_logic;				--
    ADDR_IN				: IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
    DATA_IN				: IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
    DATA_OUT			: OUT  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
    IS_DRAC_REGISTER    : OUT  std_logic;           -- signal that DATA_OUT is driven by DRACRegister
   
   -- Debugging
    DEBUG_REG_0			: IN  std_logic_vector(15 downto 0);
    PREREAD_PULSE		: OUT std_logic;
	SEL_RST				: OUT std_logic;

    -- DTC to RISKV diagnostic registers
    DCS_CMD_STATUS	    : IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 	-- status of DCS command to RiskV
    DCS_DIAG_DATA	    : IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 	-- diagnostic register via RiskV
    DCS_TX_FULL 		: IN  std_logic;				--
    DCS_TX_EMPTY 		: IN  std_logic;				--
    DCS_TX_WRCNT	    : IN  std_logic_vector(10 downto 0);     -- DCS_TX_BUFFER WRCNT
    DCS_RX_FULL 		: IN  std_logic;				--
    DCS_RX_EMPTY 		: IN  std_logic;				--
    DCS_RX_WRCNT	    : IN  std_logic_vector(10 downto 0);     -- DCS_RX_BUFFER WRCNT

    -- DRAC specific registers
    DCS_CAL_LANE0_EMPTY : IN std_logic;             -- ROCFIFO for CAL Lane 0 is empty
    DCS_CAL_LANE1_EMPTY : IN std_logic;             -- ROCFIFO for CAL Lane 1 is empty
    DCS_HV_LANE0_EMPTY  : IN std_logic;             -- ROCFIFO for HV  Lane 0 is empty
    DCS_HV_LANE1_EMPTY  : IN std_logic;             -- ROCFIFO for HV  Lane 1 is empty
    DCS_CAL_LANE0_FULL  : IN std_logic;             -- ROCFIFO for CAL Lane 0 is empty
    DCS_CAL_LANE1_FULL  : IN std_logic;             -- ROCFIFO for CAL Lane 1 is empty
    DCS_HV_LANE0_FULL   : IN std_logic;             -- ROCFIFO for HV  Lane 0 is empty
    DCS_HV_LANE1_FULL   : IN std_logic;             -- ROCFIFO for HV  Lane 1 is empty
    DCS_EVT_ERR      : IN  std_logic;               -- error seen for EVENT Tag number
    DCS_HDR1_ERR     : IN  std_logic;               -- error seen in header 1
    DCS_HDR2_ERR     : IN  std_logic;               -- error seen in header 2
    DCS_DATA_ERR     : IN  std_logic;               -- error seen for pattern data
    DCS_ERR_EXPC     : IN  std_logic_vector(63 DOWNTO 0);   -- one of four expected 64-bit with error
    DCS_ERR_SEEN     : IN  std_logic_vector(63 DOWNTO 0);   -- one of four seen 64-bit with error
    DCS_DREQ_FIFO_FULL: IN  std_logic;                -- FULL signal for DREQ FIFO (40b x 65K) used to store event sizes (3 for each FIFO entry)
    DCS_STORE_POS    : IN  std_logic_vector(1 DOWNTO 0);    -- number of sizes stored in a partially written DREQ FIFO entry (0 to 2)
    DCS_STORE_CNT    : IN  std_logic_vector(19 DOWNTO 0);   -- number of fully written DREQ FIFO entries 
    DCS_DREQ_FIFO_EMPTY:IN  std_logic;                -- EMPTY signal for DREQ FIFO (40b x 65K) used to save event sizes (3 for each FIFO entry)
    DCS_FETCH_POS   : IN  std_logic_vector(1 DOWNTO 0);     -- number of sizes fetched from a partially read FIFO entry (0 to 2)
    DCS_FETCH_CNT   : IN  std_logic_vector(19 DOWNTO 0);    -- number of fully read DREQ FIFO read entries
    DCS_EVMCNT      : IN  std_logic_vector(31 DOWNTO 0);    -- number of Event Markers with non-null HB plus first null HB seen
    DCS_HBCNT       : IN  std_logic_vector(31 DOWNTO 0);    -- number of HB seen
    DCS_NULLHBCNT   : IN  std_logic_vector(31 DOWNTO 0);    -- number of null HB seen
    DCS_HBONHOLD    : IN  std_logic_vector(31 DOWNTO 0);    -- number of HB not processed
    DCS_PREFCNT     : IN  std_logic_vector(31 DOWNTO 0);    -- number of Prefetch seen
    DCS_DREQCNT     : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request seen
    DCS_DREQREAD    : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request read from DDR
    DCS_DREQSENT    : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request sent to DTC
    DCS_DREQNULL    : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request with null payload
    DCS_SPILLCNT    : IN  std_logic_vector(19 DOWNTO 0);    -- number of HB from start of SPILL
    DCS_HBTAG       : IN  std_logic_vector(47 DOWNTO 0);    -- last HB tag
    DCS_PREFTAG     : IN  std_logic_vector(47 DOWNTO 0);    -- last PREFETCH tag
    DCS_FETCHTAG    : IN  std_logic_vector(47 DOWNTO 0);    -- last FETCH tag
    DCS_DREQTAG     : IN  std_logic_vector(47 DOWNTO 0);    -- last DREQ tag
    DCS_OFFSETTAG   : IN  std_logic_vector(47 DOWNTO 0);    -- offset TAG in present SPILL
    DCS_FULLTAG     : IN  std_logic_vector(47 DOWNTO 0);    -- first TAG with DREQ full
    DCS_TAG_LOST    : IN  std_logic_vector(47 downto 0);	-- first TAG with EVM counter falling behing of HB counter
    DCS_ERR_REQ     : OUT std_logic_vector(1 downto 0);     -- set which error to read: 0-> EVT; 1->HDR1; 2->HDR2; 3-> DATA
    DCS_TAG_OFFSET  : OUT std_logic_vector(47 downto 0);	-- set EWTAG offset

    DCS_DDRRESET    : OUT STD_LOGIC;						-- specific firmware reset (separate from TOP_Serdes reset, although it does drive EXT_RST_N)
    DCS_RESETFIFO   : OUT STD_LOGIC;						-- specific DIGIInterface reset (level: must be written high and then low again via bit[0])
    DCS_USE_LANE    : OUT std_logic_vector(3 downto 0);		-- SERDES lanes enable bit map (addr[8], bit[3:0])
    DCS_PATTERN_EN  : OUT std_logic;						-- switch between DIGIFIFO/PATTERN_FIFO inputs to memory when 0/1 (addr=8, bit[4])
    DCS_ERROR_EN    : OUT std_logic;						-- enable ErrorCounter reading via DCS (addr=8, bit[5])
    DCS_FREE_EVM    : OUT std_logic;						-- switch to free EVM (vs EVMs with DREQ) to DIGIs (addr=8, bit[6])
    DCS_INT_EVM_EN  : OUT std_logic;						-- enable internal EVM to DIGIs(addr=8, bit[7])
    DCS_ENABLE_CLOCK: OUT std_logic;						-- enable fiber clock to DIGIs(addr=8, bit[8])
    DCS_ENABLE_MARKER: OUT std_logic;						-- enable fiber marker to DIGIs(addr=8, bit[9])
    DCS_FORCE_FULL  : OUT std_logic;						-- enable FORCE_FULL to DIGIs(addr=8, bit[10])

    DCS_ERROR_DATA  : IN  std_logic_vector(15 DOWNTO 0);    -- read error counter content for address DCS_ERROR_ADDRESS
    DCS_ERROR_ADDR  : OUT std_logic_vector(7 DOWNTO 0);     -- set address of ErrorCounter to be read
    
   -- added signals for DIGIRW via DCS: drive signals for TWIController inside SLOWCONTROLS/Registers module
    dcs_cal_init    : out std_logic;                        -- generate CAL_INIT via DCS reg 23: must toggle 0->1->0 after DATA abd ADDR have been set
    dcs_cal_data    : out std_logic_vector(15 downto 0);    -- write CAL_DATA_IN via DCS reg 24
    dcs_cal_addr    : out std_logic_vector(8 downto 0);     -- write CAL_ADDRESS_IN via DCS reg 25
    dcs_hv_init     : out std_logic;                        -- generate HV_INIT via DCS reg 26: must toggle 0->1->0 after DATA abd ADDR have been set
    dcs_hv_data     : out std_logic_vector(15 downto 0);    -- write HV_DATA_IN via DCS reg 27
    dcs_hv_addr     : out std_logic_vector(8 downto 0);     -- write HV_ADDRESS_IN via DCS reg 28,
    dcs_format_vrs  : out std_logic_vector(7 downto 0);     -- pass Packer Format Version to Data Packer Header
    dcs_status_sel  : out std_logic_vector(2 downto 0)      -- write which info to send to Data header STATUS BITS via DCS reg 30
                                                            -- 0 (def) is selected bits like DREQ EMPTY and FULL;  for others, see DataStatusProcessor
);
end DRACRegisters;

architecture architecture_DRACRegisters of DRACRegisters is
		
   -- signal, component etc. declarations
	signal drac_read		: std_logic;
	signal drac_write		: std_logic;
    signal drac_addrs		: std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
    signal drac_wdata		: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 	
		
	signal read_latch		: std_logic;				
	signal write_latch	    : std_logic;				
		
    signal writeCounter		: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
    signal readCounter		: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
		
	--signal sel_rst		: std_logic;
	signal reset_sig		: std_logic;

	signal pattern_en_reg	: std_logic;
	signal free_evm_en_reg	: std_logic;
    signal error_en_reg     : std_logic;
    signal use_lane_reg		: std_logic_vector(3 downto 0);
    signal enable_internal_ewm  : std_logic;
    signal enable_clock_reg     : std_logic;
    signal enable_marker_reg    : std_logic;
    signal force_full_reg   : std_logic;

    signal err_req_reg		: std_logic_vector(1 downto 0);
    signal expc_reg_15_0,   expc_reg_31_16,   expc_reg_47_32,   expc_reg_63_48 : std_logic_vector(gAPB_DWIDTH-1 downto 0); 
    signal seen_reg_15_0,   seen_reg_31_16,   seen_reg_47_32,   seen_reg_63_48 : std_logic_vector(gAPB_DWIDTH-1 downto 0); 
    signal offset_reg_15_0, offset_reg_31_16, offset_reg_47_32                 : std_logic_vector(gAPB_DWIDTH-1 downto 0); 
   
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
		writeCounter 	<= (others => '0');  
		readCounter 	<= (others => '0'); 
			
		DCS_RESETFIFO   <= '0';
        DCS_ERROR_ADDR  <= (others => '0'); 
        IS_DRAC_REGISTER<= '0';

		pattern_en_reg	<= '0';	
		free_evm_en_reg	<= '0';	
        error_en_reg    <= '0';
		use_lane_reg    <= (others => '0');
        err_req_reg     <= (others => '0');

        enable_internal_ewm <= '0';
        enable_clock_reg    <= '0';
        enable_marker_reg   <= '0';
        force_full_reg      <= '0';
      
        offset_reg_15_0   <= (others => '0');
        offset_reg_31_16  <= (others => '0');
        offset_reg_47_32  <= (others => '0');
      
        expc_reg_15_0   <= (others => '0');      
        expc_reg_31_16  <= (others => '0');      
        expc_reg_47_32  <= (others => '0');      
        expc_reg_63_48  <= (others => '0');      
        seen_reg_15_0   <= (others => '0');      
        seen_reg_31_16  <= (others => '0');      
        seen_reg_47_32  <= (others => '0');      
        seen_reg_63_48  <= (others => '0');
        
        dcs_cal_init    <= '0';
        dcs_cal_data    <= (others => '0');
        dcs_cal_addr    <= (others => '0');
        dcs_hv_init     <= '0';
        dcs_hv_data     <= (others => '0');
        dcs_hv_addr     <= (others => '0');
        dcs_format_vrs  <= (others => '0');
        dcs_status_sel  <= (others => '0');
      
   elsif rising_edge(DCS_CLK) then
			
		READY_REG		<= '0'; 
			
		--ALGO_RESET    <= '0'; 				
		PREREAD_PULSE   <= '0';
		DATA_OUT      	<= (others => '0');
        IS_DRAC_REGISTER<= '0';
			
		read_latch		<= '0';
		write_latch		<= '0';
		SEL_RST			<= '0';
				
		DCS_DDRRESET    <= '0';
		DCS_USE_LANE    <= use_lane_reg(3 downto 0);
		DCS_PATTERN_EN  <= pattern_en_reg;
        DCS_ERROR_EN    <= error_en_reg;
        DCS_FREE_EVM    <= free_evm_en_reg;
        DCS_INT_EVM_EN  <= enable_internal_ewm;
        DCS_ENABLE_CLOCK    <= enable_clock_reg;
        DCS_ENABLE_MARKER   <= enable_marker_reg;
        DCS_FORCE_FULL  <= force_full_reg;  
        
        DCS_ERR_REQ     <= err_req_reg(1 downto 0);
        DCS_TAG_OFFSET  <= offset_reg_47_32 & offset_reg_31_16 & offset_reg_15_0;
    
        expc_reg_15_0   <= DCS_ERR_EXPC(15 downto 0);      
        expc_reg_31_16  <= DCS_ERR_EXPC(31 downto 16);      
        expc_reg_47_32  <= DCS_ERR_EXPC(47 downto 32);      
        expc_reg_63_48  <= DCS_ERR_EXPC(63 downto 48);      
        seen_reg_15_0   <= DCS_ERR_SEEN(15 downto 0);      
        seen_reg_31_16  <= DCS_ERR_SEEN(31 downto 16);      
        seen_reg_47_32  <= DCS_ERR_SEEN(47 downto 32);      
        seen_reg_63_48  <= DCS_ERR_SEEN(63 downto 48);      
		
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
				use_lane_reg 	<= drac_wdata(3 downto 0);
                pattern_en_reg  <= drac_wdata(4);
                free_evm_en_reg <= drac_wdata(5);  
                error_en_reg    <= drac_wdata(6);
                enable_internal_ewm <= drac_wdata(7);
                enable_clock_reg    <= drac_wdata(8);
                enable_marker_reg   <= drac_wdata(9);
                force_full_reg  <= drac_wdata(10);
			elsif (drac_addrs = 13) then
				DCS_RESETFIFO	<= drac_wdata(0);
			elsif (drac_addrs = 14) then
				DCS_DDRRESET		<= '1';	 -- self clearing
   -- addr 9 to 17 were used in older DDRInterface
         elsif (drac_addrs = 17) then
				DCS_ERROR_ADDR  <= drac_wdata(7 downto 0);
         elsif (drac_addrs = 18) then
				err_req_reg    <= drac_wdata(1 downto 0);
         elsif (drac_addrs = 19) then
				offset_reg_15_0   <= drac_wdata(15 downto 0);
         elsif (drac_addrs = 20) then
				offset_reg_31_16  <= drac_wdata(15 downto 0);
         elsif (drac_addrs = 21) then
				offset_reg_47_32  <= drac_wdata(15 downto 0);
         elsif (drac_addrs = 23) then
                dcs_cal_init <= drac_wdata(0);
         elsif (drac_addrs = 24) then
                dcs_cal_data <= drac_wdata(15 downto 0);
         elsif (drac_addrs = 25) then
                dcs_cal_addr <= drac_wdata(8 downto 0);
         elsif (drac_addrs = 26) then
                dcs_hv_init <= drac_wdata(0);
         elsif (drac_addrs = 27) then
                dcs_hv_data <= drac_wdata(15 downto 0);
         elsif (drac_addrs = 28) then
                dcs_hv_addr <= drac_wdata(8 downto 0);
         elsif (drac_addrs = 29) then   -- 0x13
                dcs_format_vrs <= drac_wdata(7 downto 0);
         elsif (drac_addrs = 30) then   -- 0x14
                dcs_status_sel <= drac_wdata(2 downto 0);
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
            IS_DRAC_REGISTER<= '1';               -- default is high. Overwritten is unrecognized address
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
				DATA_OUT <= B"0000" &
                            "0" & force_full_reg & enable_marker_reg & enable_clock_reg &
                            enable_internal_ewm & free_evm_en_reg & error_en_reg & pattern_en_reg & 
                            use_lane_reg(3 downto 0);	
   -- addresses 9 to 17 used in old DDRINterface
			elsif (drac_addrs = 17) then		 	 
				DATA_OUT <= DCS_ERROR_DATA(15 downto 0);
 			elsif (drac_addrs = 18) then		 	 
				DATA_OUT <= B"00" & err_req_reg & 
                            DCS_HV_LANE1_EMPTY & DCS_HV_LANE0_EMPTY & DCS_CAL_LANE1_EMPTY & DCS_CAL_LANE0_EMPTY & 
                            DCS_HV_LANE1_FULL  & DCS_HV_LANE0_FULL  & DCS_CAL_LANE1_FULL  & DCS_CAL_LANE0_FULL  & 
                            DCS_DATA_ERR & DCS_HDR2_ERR & DCS_HDR1_ERR & DCS_EVT_ERR;	
			elsif (drac_addrs = 19) then	
				DATA_OUT <= expc_reg_15_0;    
			elsif (drac_addrs = 20) then
				DATA_OUT <= expc_reg_31_16;  
			elsif (drac_addrs = 21) then
				DATA_OUT <= expc_reg_47_32;   
			elsif (drac_addrs = 22) then
				DATA_OUT <= expc_reg_63_48;    
			elsif (drac_addrs = 60) then	
				DATA_OUT <= seen_reg_15_0;    
			elsif (drac_addrs = 61) then
				DATA_OUT <= seen_reg_31_16;  
			elsif (drac_addrs = 62) then
				DATA_OUT <= seen_reg_47_32;   
			elsif (drac_addrs = 63) then
				DATA_OUT <= seen_reg_63_48;    
			elsif (drac_addrs = 23) then		 	 
				DATA_OUT <= DCS_STORE_CNT(15 downto 0);	
			elsif (drac_addrs = 24) then		 	 
				DATA_OUT <= B"000" & DCS_DREQ_FIFO_FULL & B"00" & DCS_STORE_POS & B"0000" & DCS_STORE_CNT(19 downto 16);	
			elsif (drac_addrs = 25) then		 	 
				DATA_OUT <= DCS_FETCH_CNT(15 downto 0);	
			elsif (drac_addrs = 26) then		 	 
				DATA_OUT <= B"000" & DCS_DREQ_FIFO_EMPTY & B"00" & DCS_FETCH_POS & B"0000" & DCS_FETCH_CNT(19 downto 16);	
			elsif (drac_addrs = 27) then		 	 
				DATA_OUT <= DCS_HBCNT(15 downto 0);
			elsif (drac_addrs = 28) then		 	 
				DATA_OUT <= DCS_HBCNT(31 downto 16);
			elsif (drac_addrs = 29) then		 	 
				DATA_OUT <= DCS_NULLHBCNT(15 downto 0);
			elsif (drac_addrs = 30) then		 	 
				DATA_OUT <= DCS_NULLHBCNT(31 downto 16);
			elsif (drac_addrs = 31) then		 	 
				DATA_OUT <= DCS_HBONHOLD(15 downto 0);
			elsif (drac_addrs = 32) then		 	 
				DATA_OUT <= DCS_HBONHOLD(31 downto 16);
			elsif (drac_addrs = 33) then		 	 
				DATA_OUT <= DCS_PREFCNT(15 downto 0);
			elsif (drac_addrs = 34) then		 	 
				DATA_OUT <= DCS_PREFCNT(31 downto 16);
			elsif (drac_addrs = 35) then		 	 
				DATA_OUT <= DCS_DREQCNT(15 downto 0);
			elsif (drac_addrs = 36) then		 	 
				DATA_OUT <= DCS_DREQCNT(31 downto 16);
			elsif (drac_addrs = 37) then		 	 
				DATA_OUT <= DCS_DREQREAD(15 downto 0);
			elsif (drac_addrs = 38) then		 	 
				DATA_OUT <= DCS_DREQREAD(31 downto 16);
			elsif (drac_addrs = 39) then		 	 
				DATA_OUT <= DCS_DREQSENT(15 downto 0);
			elsif (drac_addrs = 40) then		 	 
				DATA_OUT <= DCS_DREQSENT(31 downto 16);
			elsif (drac_addrs = 41) then		 	 
				DATA_OUT <= DCS_DREQNULL(15 downto 0);
			elsif (drac_addrs = 42) then		 	 
				DATA_OUT <= DCS_DREQNULL(31 downto 16);
			elsif (drac_addrs = 43) then		 	 
				DATA_OUT <= DCS_SPILLCNT(15 downto 0);
			elsif (drac_addrs = 44) then		 	 
				DATA_OUT <= X"000" & DCS_SPILLCNT(19 downto 16);
			elsif (drac_addrs = 45) then		 	 
				DATA_OUT <= DCS_HBTAG(15 downto 0);
			elsif (drac_addrs = 46) then		 	 
				DATA_OUT <= DCS_HBTAG(31 downto 16);
			elsif (drac_addrs = 47) then		 	 
				DATA_OUT <= DCS_HBTAG(47 downto 32);
			elsif (drac_addrs = 48) then		 	 
				DATA_OUT <= DCS_PREFTAG(15 downto 0);
			elsif (drac_addrs = 49) then		 	 
				DATA_OUT <= DCS_PREFTAG(31 downto 16);
			elsif (drac_addrs = 50) then		 	 
				DATA_OUT <= DCS_PREFTAG(47 downto 32);
			elsif (drac_addrs = 51) then		 	 
				DATA_OUT <= DCS_FETCHTAG(15 downto 0);
			elsif (drac_addrs = 52) then		 	 
				DATA_OUT <= DCS_FETCHTAG(31 downto 16);
			elsif (drac_addrs = 53) then		 	 
				DATA_OUT <= DCS_FETCHTAG(47 downto 32);
			elsif (drac_addrs = 54) then		 	 
				DATA_OUT <= DCS_DREQTAG(15 downto 0);
			elsif (drac_addrs = 55) then		 	 
				DATA_OUT <= DCS_DREQTAG(31 downto 16);
			elsif (drac_addrs = 56) then		 	 
				DATA_OUT <= DCS_DREQTAG(47 downto 32);
			elsif (drac_addrs = 57) then		 	 
				DATA_OUT <= DCS_OFFSETTAG(15 downto 0);
			elsif (drac_addrs = 58) then		 	 
				DATA_OUT <= DCS_OFFSETTAG(31 downto 16);
			elsif (drac_addrs = 59) then		 	 
				DATA_OUT <= DCS_OFFSETTAG(47 downto 32);
			elsif (drac_addrs = 60) then	
				DATA_OUT <= seen_reg_15_0;    
			elsif (drac_addrs = 61) then
				DATA_OUT <= seen_reg_31_16;  
			elsif (drac_addrs = 62) then
				DATA_OUT <= seen_reg_47_32;   
			elsif (drac_addrs = 63) then
				DATA_OUT <= seen_reg_63_48;    
			elsif (drac_addrs = 64) then		 	 
				DATA_OUT <= DCS_EVMCNT(15 downto 0);
			elsif (drac_addrs = 65) then		 	 
				DATA_OUT <= DCS_EVMCNT(31 downto 16);
			elsif (drac_addrs = 66) then		 	 
				DATA_OUT <= DCS_FULLTAG(15 downto 0);
			elsif (drac_addrs = 67) then		 	 
				DATA_OUT <= DCS_FULLTAG(31 downto 16);
			elsif (drac_addrs = 68) then		 	 
				DATA_OUT <= DCS_FULLTAG(47 downto 32);
			elsif (drac_addrs = 69) then		 	 
				DATA_OUT <= DCS_TAG_LOST(15 downto 0);
			elsif (drac_addrs = 70) then		 	 
				DATA_OUT <= DCS_TAG_LOST(31 downto 16);
			elsif (drac_addrs = 71) then		 	 
				DATA_OUT <= DCS_TAG_LOST(47 downto 32);
            -- DCS CMD Registers
			elsif (drac_addrs = 128) then		-- 0x80 	 
				DATA_OUT <= DCS_CMD_STATUS;
			elsif (drac_addrs = 129) then		-- 0x81 	 
				DATA_OUT <= '0' & DCS_TX_FULL & '0' & DCS_TX_EMPTY & '0' & DCS_TX_WRCNT;
			elsif (drac_addrs = 130) then		-- 0x82 	 
				DATA_OUT <= '0' & DCS_RX_FULL & '0' & DCS_RX_EMPTY & '0' & DCS_RX_WRCNT;
			elsif (drac_addrs = 255) then		-- 0xFF 	 
				DATA_OUT <= DCS_DIAG_DATA;
			else	
				DATA_OUT            <= drac_addrs;		  --Unmapped Addresses
                IS_DRAC_REGISTER    <= '0';               -- unrecognized DRACRegister address
			end if;								  							   		   
				
		end if;    -- if drac_write or read 
			
	end if;
	end process;
	
end architecture_DRACRegisters;
