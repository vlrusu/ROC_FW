--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DRACRegisters.vhd
-- File history:
--      <v1>: <Feb. 17,2024>: Reset register 8 enables ONLY on POWER ON reset (POR_N) and not on DDRReset_N
--      <v2>: <June,2024>: Clean up registers. Add "dcs_newspill_cntrl"
--      <v3>: <July,2024>: Remove "dcs_newspill_cntrl". Add "DCS_PATTERN_TYPE".
--      <v4>: <Aug,2024>:  Add HALTRUN_EN.
--      <v5>: <Jan,2025>:  Add LANE_EMPTY_SEEN input and DCS_TO_SERIAL output (def = 0x1234).
--      <v6>: <Mar,2025>:  Improved RESET logic. Removed expc vs seen signals. Added DDR dump and BITSLIP  command
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
    READY_REG 			: OUT  std_logic;			    -- signal that requested data is on DATA_OUT
    DDRReset_N 			: IN  std_logic;				--  external reset (via reg 14 - autoclearing)
    POR_N 	            : IN  std_logic;				--  power up reset
    ADDR_IN				: IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
    DATA_IN				: IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
    DATA_OUT			: OUT  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   
    IS_DRAC_REGISTER    : OUT  std_logic;               -- signal that DATA_OUT is driven by DRACRegister
   
   -- Debugging
    DEBUG_REG_0			: IN  std_logic_vector(15 downto 0);

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
    LANE_EMPTY_SEEN : IN std_logic_vector(3 DOWNTO 0);      -- ROCFIFO {HV_lane1, HV_lane0,CAL_lane1,CAL_lane0} EMPTY  has been seen
    DCS_LANE_EMPTY  : IN std_logic_vector(3 DOWNTO 0);      -- ROCFIFO {HV_lane1, HV_lane0,CAL_lane1,CAL_lane0} EMPTY  bus
    DCS_LANE_FULL   : IN std_logic_vector(3 DOWNTO 0);      -- ROCFIFO {HV_lane1, HV_lane0,CAL_lane1,CAL_lane0} FULL bus
    DCS_DREQ_FIFO_FULL: IN  std_logic;                      -- FULL signal for DREQ FIFO (40b x 65K) used to store event sizes (3 for each FIFO entry)
    DCS_STORE_POS   : IN  std_logic_vector(1 DOWNTO 0);     -- number of sizes stored in a partially written DREQ FIFO entry (0 to 2)
    DCS_STORE_CNT   : IN  std_logic_vector(19 DOWNTO 0);    -- number of fully written DREQ FIFO entries 
    DCS_DREQ_FIFO_EMPTY:IN  std_logic;                      -- EMPTY signal for DREQ FIFO (40b x 65K) used to save event sizes (3 for each FIFO entry)
    DCS_FETCH_POS   : IN  std_logic_vector(1 DOWNTO 0);     -- number of sizes fetched from a partially read FIFO entry (0 to 2)
    DCS_FETCH_CNT   : IN  std_logic_vector(19 DOWNTO 0);    -- number of fully read DREQ FIFO read entries
    DCS_EVMCNT      : IN  std_logic_vector(31 DOWNTO 0);    -- number of windows (between two EVMs)
    DCS_HBCNT       : IN  std_logic_vector(31 DOWNTO 0);    -- number of HB seen
    DCS_NULLHBCNT   : IN  std_logic_vector(31 DOWNTO 0);    -- number of null HB seen
    DCS_HBONHOLD    : IN  std_logic_vector(31 DOWNTO 0);    -- number of HB not processed
    DCS_PREFCNT     : IN  std_logic_vector(31 DOWNTO 0);    -- number of Prefetch seen
    DCS_DREQCNT     : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request seen
    DCS_DREQREAD    : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request read from DDR
    DCS_DREQSENT    : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request sent to DTC
    DCS_DREQNULL    : IN  std_logic_vector(31 DOWNTO 0);    -- number of Data Request with null payload
    DCS_SPILLCNT    : IN  std_logic_vector(31 DOWNTO 0);    -- number of HB from start of SPILL
    DCS_HBTAG       : IN  std_logic_vector(47 DOWNTO 0);    -- last HB tag
    DCS_PREFTAG     : IN  std_logic_vector(47 DOWNTO 0);    -- last PREFETCH tag
    DCS_FETCHTAG    : IN  std_logic_vector(47 DOWNTO 0);    -- last FETCH tag
    DCS_DREQTAG     : IN  std_logic_vector(47 DOWNTO 0);    -- last DREQ tag
    DCS_OFFSETTAG   : IN  std_logic_vector(47 DOWNTO 0);    -- offset TAG in present SPILL
    DCS_FULLTAG     : IN  std_logic_vector(47 DOWNTO 0);    -- first TAG with DREQ full

    DCS_LED_OFF     : OUT STD_LOGIC;    -- turn on/off key LED via write to reg. 9																				   
    DCS_DDRRESET_N  : OUT STD_LOGIC;						-- specific firmware reset (separate from TOP_Serdes reset, although it does drive DDRReset_N)
    DCS_RESETFIFO   : OUT STD_LOGIC;						-- specific DIGIInterface reset (level: must be written high and then low again via bit[0])
    DCS_USE_LANE    : OUT std_logic_vector(3 downto 0);		-- SERDES lanes enable bit map (addr[8], bit[3:0])
    DCS_PATTERN_EN  : OUT std_logic;						-- switch between DIGIFIFO/PATTERN_FIFO inputs to memory when 0/1 (addr=8, bit[4])
    DCS_ERROR_EN    : OUT std_logic;						-- enable ErrorCounter reading via DCS (addr=8, bit[6])
    DCS_INT_EVM_EN  : OUT std_logic;						-- enable internal EVM to DIGIs(addr=8, bit[7])
    DCS_ENABLE_CLOCK: OUT std_logic;						-- enable fiber clock to DIGIs(addr=8, bit[8])
    DCS_ENABLE_MARKER: OUT std_logic;						-- enable fiber marker to DIGIs(addr=8, bit[9])
    DCS_FORCE_FULL  : OUT std_logic;						-- enable FORCE_FULL to DIGIs(addr=8, bit[10])
    DCS_PATTERN_TYPE: OUT std_logic;					    -- switch pattern between 32-bit counters to alternating 5s&As (addr=8, bit[12])
    HALTRUN_EN      : OUT std_logic;					    -- enable HALTRUN mode(addr=8, bit[13])

    DCS_LOOPBACK_COARSE_DELAY   : OUT std_logic_vector(10 downto 0);		-- coarse Event Window Marker delay (addr=4)
    DCS_TO_SERIAL   : OUT std_logic_vector(15 downto 0);    -- diagnostic RW register to be sent to serial (addr=5)

    DCS_ERROR_DATA  : IN  std_logic_vector(15 DOWNTO 0);    -- read error counter content for address DCS_ERROR_ADDRESS
    DCS_ERROR_ADDR  : OUT std_logic_vector(7 DOWNTO 0);     -- set address of ErrorCounter to be read

    DCS_FORMAT_VERSION  : OUT std_logic_vector(7 downto 0);  -- pass Packer Format Version to Data Packer Header
    DCS_DTC_ID          : OUT std_logic_vector(7 downto 0);  -- pass DTC_ID to Data Packer Header
    DCS_SUBSYSTEM_ID    : OUT std_logic_vector(2 downto 0);  -- pass SubSysem ID (0=TRK, 1=CAL, 2=CRV, 4=STM, 5=ExtMon) to Data Packer Header

    DCS_MEM_READ        : OUT std_logic;
    DCS_MEM_OFFSET      : OUT std_logic_vector(19 downto 0);
    EVENT_TIMEOUT       : OUT std_logic_vector(19 downto 0);
    
    DCS_DDR_FIFO_FULL   : IN std_logic;
    DCS_DDR_FIFO_EMPTY  : IN std_logic;
    DCS_DDR_FIFO_WRCNT  : IN std_logic_vector(7 downto 0);
    DCS_DDR_FIFO_RDCNT  : IN std_logic_vector(9 downto 0);
    DCS_DDR_ADDRESS     : IN std_logic_vector(19 downto 0);
    
    CLOCK_ALIGNED       : IN std_logic;
    DCS_BITSLIP_START   : OUT std_logic;
    DCS_BITSLIP_SHIFT   : OUT std_logic_vector(4 downto 0);

    hb_tag_err_cnt      : IN std_logic_vector(15 DOWNTO 0);    
    hb_dreq_err_cnt     : IN std_logic_vector(15 DOWNTO 0);    
    hb_lost_cnt         : IN std_logic_vector(15 DOWNTO 0);    
    evm_lost_cnt        : IN std_logic_vector(15 DOWNTO 0);    

    DATAREQ_CNT         : IN std_logic_vector(31 DOWNTO 0);
    EVENT_MARKER_CNT    : IN std_logic_vector(31 DOWNTO 0);  
    IS_SKIPPED_DREQ_CNT : IN std_logic_vector(15 DOWNTO 0);  
    BAD_MARKER_CNT      : IN std_logic_vector(15 DOWNTO 0);       
    LOSS_OF_LOCK_CNT    : IN std_logic_vector(15 DOWNTO 0);
    ew_done_cnt         : IN std_logic_vector(15 DOWNTO 0);
    
    dtc_pkt_count       : IN std_logic_vector(15 downto 0);
    dcs_pkt_count       : IN std_logic_vector(15 downto 0);
    dreq_pkt_count      : IN std_logic_vector(15 downto 0);
    dreq_hdr_pkt_count  : IN std_logic_vector(15 downto 0);
    dreq_data_pkt_count : IN std_logic_vector(15 downto 0);
    dreq_empty_pkt_count: IN std_logic_vector(15 downto 0);
    
   -- added signals for DIGIRW via DCS: drive signals for TWIController inside SLOWCONTROLS/Registers module
    dcs_digirw_sel  : out std_logic;                        -- drive TWI inputs via fiber: set 1 for duration of TWI transation, drive low to go back to TWI via uProc
    dcs_cal_init    : out std_logic;                        -- drive TWI CAL_INIT    via DCS write to addr=23: must toggle 1->0 after DATA and ADDR have been set
    dcs_cal_data    : out std_logic_vector(15 downto 0);    -- drive TWI CAL_DATA_IN via DCS write to addr=24
    dcs_cal_addr    : out std_logic_vector(8 downto 0);     -- drive TWI CAL_ADDRESS via DCS write to addr=25: bit[7:0] is address, bit[9]=1/0 for RD/WR
    dcs_hv_init     : out std_logic;                        -- drive TWI HV_INIT     via DCS write to addr=26: must toggle 1->0 after DATA and ADDR have been set
    dcs_hv_data     : out std_logic_vector(15 downto 0);    -- drive TWI HV_DATA_IN  via DCS write to addr=27
    dcs_hv_addr     : out std_logic_vector(8 downto 0);     -- drive TWI HV_ADDRESS  via DCS write to addr=28: bit[7:0] is address, bit[9]=1/0 for RD/WR
    dcs_cal_busy    : in std_logic;                         -- read TWI CAL_BUSY      via  addr=69, bit([0]
    dcs_hv_busy     : in std_logic;                         -- read TWI HV_BUSY       via  addr=69, bit([4]
    dcs_cal_data_out: in std_logic_vector(15 downto 0);     -- read TWI CAL_DATA_OUT  via addr=70
    dcs_hv_data_out : in std_logic_vector(15 downto 0)      -- read TWI CAL_DATA_OUT  via addr=71
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
	signal pattern_type_reg : std_logic;  -- 0 => 32-bit counter + 1;  1=> alternating 5s&As
    signal error_en_reg     : std_logic;
    signal enable_internal_ewm  : std_logic;
    signal use_lane_reg		: std_logic_vector(3 downto 0);
    signal enable_clock_reg     : std_logic;
    signal enable_marker_reg    : std_logic;
    signal force_full_reg       : std_logic;
    signal haltrun_en_reg       : std_logic;
    signal event_timeout_reg	: std_logic_vector(19 downto 0);
   
begin	
		
    -- architecture body
    drac_read	<= READ_REG;
    drac_write	<= WRITE_REG;
    drac_addrs 	<= ADDR_IN; 
    drac_wdata 	<= DATA_IN;

    DCS_USE_LANE    <= use_lane_reg(3 downto 0);
    DCS_PATTERN_EN  <= pattern_en_reg;
    DCS_PATTERN_TYPE<= pattern_type_reg;
    DCS_ERROR_EN    <= error_en_reg;
    DCS_INT_EVM_EN  <= enable_internal_ewm;
    DCS_ENABLE_CLOCK    <= enable_clock_reg;
    DCS_ENABLE_MARKER   <= enable_marker_reg;
    DCS_FORCE_FULL  <= force_full_reg; 
    HALTRUN_EN      <= haltrun_en_reg;
    EVENT_TIMEOUT   <= event_timeout_reg;
    
   -------------------------------------------------------------------------------
   -- Process Read/Write Commands
   -------------------------------------------------------------------------------
	process(POR_N, DDRReset_N, DCS_CLK)
	begin
	if POR_N = '0' then
			
		--ALGO_RESET 	<= '1';	
		writeCounter 	<= (others => '0');  
		readCounter 	<= (others => '0'); 
			
		DCS_RESETFIFO   <= '0';
        DCS_ERROR_ADDR  <= (others => '0'); 
        IS_DRAC_REGISTER<= '0';
        DCS_LED_OFF     <= '0';
            
        -- DO NOT RESET THESE REGISTERS ON DCS_RESET!!!
		use_lane_reg    <= (others => '0');
		pattern_en_reg	<= '0';	
        pattern_type_reg<= '0';
        error_en_reg    <= '0';
        enable_internal_ewm <= '0';
        enable_clock_reg    <= '0';
        enable_marker_reg   <= '0';
        force_full_reg      <= '0';
        haltrun_en_reg      <= '0';
        
        DCS_FORMAT_VERSION  <= (others => '0');
        DCS_DTC_ID          <= (others => '0');
        DCS_SUBSYSTEM_ID    <= (others => '0');  -- 0 is the TRK Subsystem ID
        
        DCS_MEM_READ    <= '0';
        DCS_MEM_OFFSET  <= (others => '0');
        event_timeout_reg   <= X"0_FFFF";
        
        dcs_digirw_sel  <= '0';
        dcs_cal_init    <= '0';
        dcs_cal_data    <= (others => '0');
        dcs_cal_addr    <= (others => '0');
        dcs_hv_init     <= '0';
        dcs_hv_data     <= (others => '0');
        dcs_hv_addr     <= (others => '0');
        
        DCS_LOOPBACK_COARSE_DELAY <= B"000_0000_0000";   -- default delay is zero 5 ns clock
        DCS_TO_SERIAL   <= X"1234";             -- default delay is 0x1234
		DCS_DDRRESET_N    <= '1';
        
        DCS_BITSLIP_START   <= '0';
        DCS_BITSLIP_SHIFT   <= (others => '0');
      
    elsif rising_edge(DCS_CLK) then
			
		READY_REG		<= '0'; 
			
		DATA_OUT      	<= (others => '0');
        IS_DRAC_REGISTER<= '0';
			
		read_latch		<= '0';
		write_latch		<= '0';
        
        DCS_BITSLIP_START   <= '0';
        
        if DDRReset_N = '0' then
			
            --ALGO_RESET 	<= '1';	
            writeCounter 	<= (others => '0');  
            readCounter 	<= (others => '0'); 
                
            DCS_RESETFIFO   <= '0';
            DCS_ERROR_ADDR  <= (others => '0'); 
            IS_DRAC_REGISTER<= '0';
            DCS_LED_OFF     <= '0';
                
            DCS_DDRRESET_N    <= '1';
            
        end if;
            
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
            
            elsif (drac_addrs = 1) then  
                DCS_BITSLIP_START   <= '1';
                DCS_BITSLIP_SHIFT   <= drac_wdata(4 downto 0);
                
            elsif (drac_addrs = 4) then  
                DCS_LOOPBACK_COARSE_DELAY <= drac_wdata(10 downto 0);
            elsif (drac_addrs = 5) then  
                DCS_TO_SERIAL <= drac_wdata(15 downto 0);
			elsif (drac_addrs = 6) then
                dcs_digirw_sel <= drac_wdata(0);     
            
   -- 8...255 are reserved for DRAC controls and registers
			elsif (drac_addrs = 8) then
				use_lane_reg 	<= drac_wdata(3 downto 0);
                pattern_en_reg  <= drac_wdata(4);
                error_en_reg    <= drac_wdata(6);
                enable_internal_ewm <= drac_wdata(7);
                enable_clock_reg    <= drac_wdata(8);
                enable_marker_reg   <= drac_wdata(9);
                force_full_reg      <= drac_wdata(10);
                pattern_type_reg    <= drac_wdata(12);
                haltrun_en_reg      <= drac_wdata(13);
            elsif (drac_addrs = 9) then 
                DCS_LED_OFF     <= drac_wdata(0);
			elsif (drac_addrs = 13) then
				DCS_RESETFIFO	<= drac_wdata(0);
			elsif (drac_addrs = 14) then
				DCS_DDRRESET_N		<= '0';	 -- self clearing
                    
            elsif (drac_addrs = 17) then
				DCS_ERROR_ADDR  <= drac_wdata(7 downto 0);
                    
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
            elsif (drac_addrs = 29) then   -- 0x1D
                DCS_FORMAT_VERSION <= drac_wdata(7 downto 0);
            elsif (drac_addrs = 30) then   -- 0x1E
                DCS_DTC_ID <= drac_wdata(7 downto 0);
            elsif (drac_addrs = 31) then   -- 0x1F
                DCS_SUBSYSTEM_ID <= drac_wdata(2 downto 0);
            elsif (drac_addrs = 32) then   -- 0x20
                DCS_MEM_READ <= drac_wdata(0);
            elsif (drac_addrs = 33) then   -- 0x21
                DCS_MEM_OFFSET(15 downto 0) <= drac_wdata(15 downto 0);
            elsif (drac_addrs = 34) then   -- 0x22
                DCS_MEM_OFFSET(19 downto 16) <= drac_wdata(3 downto 0);
            elsif (drac_addrs = 60) then   -- 0x3C
                event_timeout_reg(15 downto 0)  <= drac_wdata(15 downto 0);
            elsif (drac_addrs = 61) then   -- 0x3D
                event_timeout_reg(19 downto 16)  <= drac_wdata(3 downto 0);
                 
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
            IS_DRAC_REGISTER<= '1';               -- default is high. Overwritten if unrecognized address
			read_latch		<= drac_read;
			if (drac_read = '1' and read_latch = '0') then 	             
				readCounter 	<= readCounter + 1;  
			end if;	
				
			-- 0...7 are reserved registers to deal with other modules inside TOP_SERDES
			if (drac_addrs = 0) then	-- monitors status of Core_PCS	 						
				DATA_OUT 	<= DEBUG_REG_0;			
			elsif (drac_addrs = 1) then	
				DATA_OUT 	<=  CLOCK_ALIGNED & B"000_0000_000" & DCS_BITSLIP_SHIFT;	-- data read from other modules
			elsif (drac_addrs = 2) then	
				DATA_OUT 	<=  writeCounter ;	-- useful counters
			elsif (drac_addrs = 3) then	 
				DATA_OUT 	<=  readCounter; 	
			elsif (drac_addrs = 4) then	 
				DATA_OUT 	<=  B"0_0000" & DCS_LOOPBACK_COARSE_DELAY; 	
			elsif (drac_addrs = 5) then	 
				DATA_OUT 	<=  DCS_TO_SERIAL; 	
			elsif (drac_addrs = 6) then		 	 
                DATA_OUT    <= B"000_0000_0000_0000" & dcs_digirw_sel;
			elsif (drac_addrs = 7) then		 	 
				DATA_OUT 	<= LOSS_OF_LOCK_CNT;			
					
   -- 8...255 are reserved for DRAC controls and registers
			elsif (drac_addrs = 8) then		 	 
				DATA_OUT <= B"00" & HALTRUN_EN & DCS_PATTERN_TYPE &
                            '0'   & DCS_FORCE_FULL & DCS_ENABLE_MARKER & DCS_ENABLE_CLOCK &
                            DCS_INT_EVM_EN & DCS_ERROR_EN & '0' & DCS_PATTERN_EN & 
                            DCS_USE_LANE;
                            
			elsif (drac_addrs = 9) then		 	 
				DATA_OUT 	<= DATAREQ_CNT(15 downto 0);			
			elsif (drac_addrs = 10) then		 	 
				DATA_OUT 	<= DATAREQ_CNT(31 downto 16);			
			elsif (drac_addrs = 11) then		 	 
				DATA_OUT 	<= EVENT_MARKER_CNT(15 downto 0);			
			elsif (drac_addrs = 12) then		 	 
				DATA_OUT 	<= EVENT_MARKER_CNT(31 downto 16);			
			elsif (drac_addrs = 13) then		 	 
				DATA_OUT 	<= IS_SKIPPED_DREQ_CNT;			
            elsif (drac_addrs = 14) then		 	 
				DATA_OUT 	<= ew_done_cnt;                
            elsif (drac_addrs = 15) then		 	 
				DATA_OUT 	<= DCS_DDR_ADDRESS(15 downto 0);
            elsif (drac_addrs = 16) then		 	 
				DATA_OUT 	<= B"0000_0000_0000" & DCS_DDR_ADDRESS(19 downto 16);
            elsif (drac_addrs = 17) then		 	 
				DATA_OUT <= DCS_ERROR_DATA(15 downto 0);
 			elsif (drac_addrs = 18) then		 	 
				DATA_OUT    <= B"0000" & 
                            DCS_LANE_EMPTY & 
                            DCS_LANE_FULL  &
                            LANE_EMPTY_SEEN;
                    
 			elsif (drac_addrs = 20) then		 	 
				DATA_OUT    <= DCS_DDR_FIFO_FULL &
                            B"000_0000" & 
                            DCS_DDR_FIFO_WRCNT;
 			elsif (drac_addrs = 21) then		 	 
				DATA_OUT    <= DCS_DDR_FIFO_EMPTY &
                            B"000_00" & 
                            DCS_DDR_FIFO_RDCNT;
                    
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
				DATA_OUT <= DCS_SPILLCNT(31 downto 16);
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
				DATA_OUT <= EVENT_TIMEOUT(15 downto 0);
			elsif (drac_addrs = 61) then		 	 
				DATA_OUT <= X"000" & EVENT_TIMEOUT(19 downto 16);
                
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
				DATA_OUT <= X"00" & B"000" & dcs_hv_busy & B"000" & dcs_cal_busy;
			elsif (drac_addrs = 70) then		 	 
				DATA_OUT <= dcs_cal_data_out(15 downto 0);
			elsif (drac_addrs = 71) then		 	 
				DATA_OUT <= dcs_hv_data_out(15 downto 0);
			elsif (drac_addrs = 72) then		 	 
				DATA_OUT <= hb_tag_err_cnt;
			elsif (drac_addrs = 73) then		 	 
				DATA_OUT <= hb_dreq_err_cnt;
			elsif (drac_addrs = 74) then		 	 
				DATA_OUT <= hb_lost_cnt;
			elsif (drac_addrs = 75) then		 	 
				DATA_OUT <= evm_lost_cnt;
			elsif (drac_addrs = 76) then		 	 
				DATA_OUT 	<= BAD_MARKER_CNT;			
                
            -- CALO uses 77 to 126                
            -- DCS CMD Registers
			elsif (drac_addrs = 128) then		-- 0x80 	 
				DATA_OUT <= DCS_CMD_STATUS;
			elsif (drac_addrs = 129) then		-- 0x81 	 
				DATA_OUT <= '0' & DCS_TX_FULL & '0' & DCS_TX_EMPTY & '0' & DCS_TX_WRCNT;
			elsif (drac_addrs = 130) then		-- 0x82 	 
				DATA_OUT <= '0' & DCS_RX_FULL & '0' & DCS_RX_EMPTY & '0' & DCS_RX_WRCNT;
			elsif (drac_addrs = 255) then		-- 0xFF 	 
				DATA_OUT <= DCS_DIAG_DATA;
                
            elsif (drac_addrs = 144) then	 -- 0x90	 	 
                DATA_OUT <= dtc_pkt_count;
			elsif (drac_addrs = 145) then	 -- 0x91		 	 
                DATA_OUT <= dcs_pkt_count;
			elsif (drac_addrs = 146) then	 -- 0x92		 	 
                DATA_OUT <= dreq_pkt_count;
			elsif (drac_addrs = 147) then	 -- 0x93		 	 
                DATA_OUT <= dreq_hdr_pkt_count;
			elsif (drac_addrs = 148) then	 -- 0x94		 	 
                DATA_OUT <= dreq_data_pkt_count;
			elsif (drac_addrs = 149) then	 -- 0x95		 	 
                DATA_OUT <= dreq_empty_pkt_count;	
                
			else	
				DATA_OUT            <= drac_addrs;		  --Unmapped Addresses
                IS_DRAC_REGISTER    <= '0';               -- unrecognized DRACRegister address
			end if;								  							   		   
				
		end if;    -- if drac_write or read 
			
	end if;
	end process;
	
end architecture_DRACRegisters;
