library ieee;
use ieee.std_logic_1164.all;

entity Registers is
  generic (
    SERDES_ADDRESS_WIDTH : integer := 10;
    CB_ADDRESS_WIDTH     : integer := 6;
    APB_ADDRESS_WIDTH    : integer := 32;   -- APB_ADDRESS_WIDTH
    APB_DATA_WIDTH       : integer := 32);  --APB data width
  port(
    PCLK    : in  std_logic;            -- APB clock
    PRESETn : in  std_logic;            -- APB reset
    PENABLE : in  std_logic;            -- APB enable
    PSEL    : in  std_logic;            -- APB periph select
    PADDR   : in  std_logic_vector(APB_ADDRESS_WIDTH-1 downto 0);  -- APB address bus
    PWRITE  : in  std_logic;            -- APB write
    PWDATA  : in  std_logic_vector(APB_DATA_WIDTH-1 downto 0);  -- APB write data
    PRDATA  : out std_logic_vector(APB_DATA_WIDTH-1 downto 0);  -- APB read data
    PREADY  : out std_logic;            -- APB ready signal data
    PSLVERR : out std_logic;            -- APB error signal
		
    SERDES_RE    : out std_logic;
    SERDES_DATA  : in  std_logic_vector(31 downto 0);
    SERDES_FULL  : in  std_logic;
    SERDES_EMPTY : in  std_logic;
    DIGIDEVICE_RESETN : out std_logic;
    SERDES_RDCNT : in std_logic_vector(16 downto 0);
    SERDES_HOWMANY : out std_logic_vector(12 downto 0);
    serdes_aligned : in std_logic_vector(3 downto 0);
		
    INVERTCALSPICLCK : out std_logic;
    DDR_RESETN 		: out std_logic;
    DTCALIGN_RESETN 	: out std_logic;
    TVS_RESETN 		: out std_logic;
      
    DDRSERIALSET  : out  std_logic;
    DDRPTTREN     : out std_logic;
    DDRCFOEN      : out  std_logic;
    DDRCFOSTART   : out  std_logic;
    DDRPREFETCHEN : out  std_logic;
    DDRERROR      : in  std_logic_vector(3 downto 0);
    DDRERRREQ     : out std_logic_vector(1 downto 0);
    DDRERRSEEN    : in  std_logic_vector(63 downto 0);
    DDRERREXPC    : in  std_logic_vector(63 downto 0);
    DDRSIZEWR     : in  std_logic_vector(31 downto 0);
    DDRSIZERD     : in  std_logic_vector(31 downto 0);
    DDRHBCNT      : in  std_logic_vector(31 downto 0);
    DDRNULLHBCNT  : in  std_logic_vector(31 downto 0);
    DDRHBONHOLD   : in  std_logic_vector(31 downto 0);
    DDRPREFCNT    : in  std_logic_vector(31 downto 0);
    DDRDREQCNT    : in  std_logic_vector(31 downto 0);
    DDRDREQREAD   : in  std_logic_vector(31 downto 0);
    DDRDREQSENT   : in  std_logic_vector(31 downto 0);
    DDRDREQNULL   : in  std_logic_vector(31 downto 0);
    DDRSPILLCNT   : in  std_logic_vector(19 downto 0);
    DDRHBTAG      : in  std_logic_vector(31 downto 0);
    DDRPRETAG     : in  std_logic_vector(31 downto 0);
    DDRFETCHTAG   : in  std_logic_vector(31 downto 0);
    DDRDREQTAG    : in  std_logic_vector(31 downto 0);
    DDROFFSETTAG  : in  std_logic_vector(31 downto 0);
    DDRCFOOFFSET  : out std_logic_vector(31 downto 0);
    DDRCFODELTAHB : out std_logic_vector(31 downto 0);
    DDRCFONUMBERHB: out std_logic_vector(31 downto 0);

    --DDRNHITS : out std_logic_vector(31 downto 0);
    --DDRCS    : out std_logic;
    --DDRWEN   : out std_logic;
    --DDRREN   : out std_logic;
    --DDRFIFOWEN : out std_logic;
    --DDROFFSET: out std_logic_vector(31 downto 0);
    --DDRDIAG0 : in  std_logic_vector(31 downto 0);
    --DDRDIAG1 : in  std_logic_vector(31 downto 0);
    --DDRPATTRN: out  std_logic_vector(1 downto 0);
	 --DDRBURST : out std_logic_vector(7 downto 0);
    --DDRRWEN  : out std_logic;
    --DDRERRREN: out std_logic;
    --DDRWRTREN: out std_logic;
    --DDRRDTREN: out std_logic;
	 --DDRRAMREN: out std_logic;
    --DDRFORCERD  : out std_logic;
		--
    --DDRWRTIME: in  std_logic_vector(31 downto 0);
    --DDRRDTIME: in  std_logic_vector(31 downto 0);
    --DDRERRCNT: in  std_logic_vector(31 downto 0);
    --DDRPTTREN: out std_logic;
    --DDRERRLOC: in  std_logic_vector(31 downto 0);
    --DDRFIFODIA: in  std_logic_vector(15 downto 0);
    --DDRTRUEL : in  std_logic_vector(31 downto 0);
    --DDRTRUEH : in  std_logic_vector(31 downto 0);
    --DDREXPCL : in  std_logic_vector(31 downto 0);
    --DDREXPCH : in  std_logic_vector(31 downto 0);
	 --DDRRAMADDR : out std_logic_vector(31 downto 0);
	 --DDRRAMDATA : in  std_logic_vector(31 downto 0);
    --DDRLOCRAM: out  std_logic_vector(31 downto 0);
	 --DDRWRBCNT : in  std_logic_vector(31 downto 0);
	 --DDRRDBCNT : in  std_logic_vector(31 downto 0);
--
    --DDRSEL      : out std_logic;
    --DDRFULL     : in  std_logic;
    --DDRFIFO_RE  : out std_logic;
    --DDRSET      : out  std_logic;
    --DDRPAGENO   : out std_logic_vector(31 downto 0);
    --DDRPAGEWR   : in  std_logic_vector(31 downto 0);
    --DDRPAGERD   : in  std_logic_vector(31 downto 0);
--
    --DDRMEMFIFODATA0 : in  std_logic_vector(31 downto 0);
    --DDRMEMFIFODATA1 : in  std_logic_vector(31 downto 0);
    --DDRMEMFIFOFULL  : in  std_logic;
    --DDRMEMFIFOEMPTY : in  std_logic;
    --DDRTEMPFIFOFULL : in  std_logic;
    --DDRTEMPFIFOEMPTY: in  std_logic;
    --DDRMEMFIFO_RE   : out std_logic;
--
    --DDRCONVRDCNT    : in std_logic_vector(16 downto 0);
    --DDRCONVDATA     : in std_logic_vector(31 downto 0);
    DDRCTRLREADY  : in  std_logic;

    DTCSIMSTART   : out std_logic;
    DTCSIMBLKEN   : out std_logic;
    DTCSIMPARAM   : out std_logic_vector(31 downto 0);
    DTCSIMADDR    : out std_logic_vector(31 downto 0);
    DTCSIMDATA    : out std_logic_vector(31 downto 0);
    DTCSIMSPILLDATA: out std_logic_vector(31 downto 0);
    DTCSIMBLKDATA : out std_logic_vector(15 downto 0);
    DTCSIMBLKADDR : out std_logic_vector(6 downto 0);
    DTCDATAREAD   : in std_logic_vector(31 downto 0);
    
    hvscl   : out std_logic;
    calscl  : out std_logic;

    hvsda : inout std_logic;
    calsda : inout std_logic;

    ewm_50mhz : out std_logic;
    ewm_enable_50mhz : out std_logic;
    ewm_delay : out std_logic_vector(15 downto 0);
    event_window_early_cut : out std_logic_vector(15 downto 0);
    event_window_late_cut : out std_logic_vector(15 downto 0);
    
    
    reset_fifo_n : out std_logic;
    write_to_fifo : out std_logic;
    remote_token0 : in std_logic_vector(7 downto 0);
    remote_token1 : in std_logic_vector(7 downto 0);
    remote_token2 : in std_logic_vector(7 downto 0);
    remote_token3 : in std_logic_vector(7 downto 0);
    dummy_status_address : out std_logic_vector(3 downto 0);
    dummy_status_out0 : in std_logic_vector(7 downto 0);
    dummy_status_out1 : in std_logic_vector(7 downto 0);
    dummy_status_out2 : in std_logic_vector(7 downto 0);
    dummy_status_out3 : in std_logic_vector(7 downto 0);
    
    serdes_re0 : out std_logic;
    serdes_re1 : out std_logic;
    serdes_re2 : out std_logic;
    serdes_re3 : out std_logic;
    serdes_rdcnt0 : in std_logic_vector(12 downto 0);
    serdes_rdcnt1 : in std_logic_vector(12 downto 0);
    serdes_rdcnt2 : in std_logic_vector(12 downto 0);
    serdes_rdcnt3 : in std_logic_vector(12 downto 0);
    serdes_data0 : in std_logic_vector(31 downto 0);
    serdes_data1 : in std_logic_vector(31 downto 0);
    serdes_data2 : in std_logic_vector(31 downto 0);
    serdes_data3 : in std_logic_vector(31 downto 0);
    use_lane : out std_logic_vector(3 downto 0);
    use_uart : out std_logic;

    ROCTVS_VAL  : in std_logic_vector(15 downto 0);
    ROCTVS_ADDR : out std_logic_vector(1 downto 0);
    
    enable_fiber_clock : out std_logic;
    enable_fiber_marker : out std_logic;
    
    cal_lane0_pcs_reset_n : out std_logic;
    cal_lane1_pcs_reset_n : out std_logic;
    cal_lane0_pma_reset_n : out std_logic;
    cal_lane1_pma_reset_n : out std_logic;
    hv_lane0_pcs_reset_n : out std_logic;
    hv_lane1_pcs_reset_n : out std_logic;
    hv_lane0_pma_reset_n : out std_logic;
    hv_lane1_pma_reset_n : out std_logic;
    
    cal_lane0_aligned : in std_logic;
    cal_lane1_aligned : in std_logic;
    hv_lane0_aligned : in std_logic;
    hv_lane1_aligned : in std_logic;
    
    cal_lane0_alignment : in std_logic_vector(3 downto 0);
    cal_lane1_alignment : in std_logic_vector(3 downto 0);
    hv_lane0_alignment : in std_logic_vector(3 downto 0);
    hv_lane1_alignment : in std_logic_vector(3 downto 0);
    
    cal_lane0_error_count : in std_logic_vector(7 downto 0);
    cal_lane1_error_count : in std_logic_vector(7 downto 0);
    hv_lane0_error_count : in std_logic_vector(7 downto 0);
    hv_lane1_error_count : in std_logic_vector(7 downto 0);
    
    dtc_enable_reset : out std_logic;
    force_full : out std_logic;
    align_roc_to_digi : out std_logic;
    dtc_error_address : out std_logic_vector(7 downto 0);
    dtc_error_counter : in std_logic_vector(15 downto 0);
    
    cal_serdes_reset_n : out std_logic;
    hv_serdes_reset_n : out std_logic;
    dtc_serdes_reset_n : out std_logic;
    
    event_window_expected : out std_logic_vector(15 downto 0);

    TIMERENABLE : out std_logic;
    TIMERRESET: out std_logic;
    TIMERCOUNTER : in std_logic_vector(31 downto 0)

    --cal_ss_n : out std_logic;
    --cal_sclk : out std_logic;
    --cal_mosi : out std_logic;
    --cal_miso : in std_logic;
--
    --hv_ss_n : out std_logic;
    --hv_sclk : out std_logic;
    --hv_mosi : out std_logic;
    --hv_miso : in std_logic

    );
end Registers;

architecture synth of Registers is


   constant CRDDRRESETN		: std_logic_vector(7 downto 0) := x"10";
   constant CRTIMERENABLE	: std_logic_vector(7 downto 0):= x"12";
   constant CRTIMERRESET	: std_logic_vector(7 downto 0):= x"13";
   constant CRTIMERCOUNTER	: std_logic_vector(7 downto 0):= x"14";
   constant	CRDTCALIGNRESETN	:	std_logic_vector(7 downto 0) := x"15";
   constant	CRTVSRESETN		:	std_logic_vector(7 downto 0) := x"16";

   constant CRUSEUART       : std_logic_vector(7 downto 0) := x"F1";  -- last DTC reply [31:16] = addr, [15:0] = data 

  ------------------------------------------------------------------------------
  --  Invert the spi clock for CAL, multiplexer enable
  ------------------------------------------------------------------------------
   constant CRINVERTCALSPICLCK : std_logic_vector(7 downto 0) := x"11";

-------------------------------------------------------------------------------
-- DDR signals with Monica updates in "flowcontrol"
-------------------------------------------------------------------------------
   constant CRDDRPTTREN: 	std_logic_vector(7 downto 0):= x"20";  -- drive PATTERN to be used
   constant CRDDRERROR:	   std_logic_vector(7 downto 0):= x"21";  -- error seen: [0] event_error, [1] header1_error, [2] header2_error, [3] data_error seen
   constant CRDDRERRREQ:	std_logic_vector(7 downto 0):= x"22";  -- error requested: [0] event_error, [1] header1_error, [2] header2_error, [3] data_error seen
   constant CRDDRERRSEENL: std_logic_vector(7 downto 0):= x"23";  -- 32 LBS of word read when first requested error seen
   constant CRDDRERRSEENH: std_logic_vector(7 downto 0):= x"24";  -- 32 MSB of word read when first requested error seen
   constant CRDDRERREXPCL: std_logic_vector(7 downto 0):= x"25";  -- 32 LBS of expected word when first requested error seen 
   constant CRDDRERREXPCH: std_logic_vector(7 downto 0):= x"26";  -- 32 MBS of expected word when first requested error seen 
   constant CRDDRSPILLCNT  :  std_logic_vector(7 downto 0):= x"27";  -- no. of HB from start of SPILL
   constant CRDDRNULLHBCNT :  std_logic_vector(7 downto 0):= x"28";  -- no. of null HBs from start of SPILL
   constant CRDDRHBCNT:    std_logic_vector(7 downto 0):= x"29";  -- no. of HB seen
   constant CRDDRHBONHOLD: std_logic_vector(7 downto 0):= x"2A";  -- no. of HB not processeduse 
   constant CRDDRPREFCNT:  std_logic_vector(7 downto 0):= x"2B";  -- no. of PREFETCH seen 
   constant CRDDRDREQCNT:  std_logic_vector(7 downto 0):= x"2C";  -- no. of DREQs received from DTC
   constant CRDDRDREQREAD: std_logic_vector(7 downto 0):= x"2D";  -- no. of DREQs read from memory
   constant CRDDRDREQSENT: std_logic_vector(7 downto 0):= x"2E";  -- no. of DREQs sent to DTC
   constant CRDDRDREQNULL: std_logic_vector(7 downto 0):= x"2F";  -- no. of null size DREQs sent to DTC
   
   --constant CRDDRNHITS : 	std_logic_vector(7 downto 0) := x"20";  -- a 31-bit register to set up the number of hits to be written/read from memory
   --constant CRDDROFFSET: 	std_logic_vector(7 downto 0) := x"21";  -- 31-bit memory address offset 
   --constant CRDDRCS    : 	std_logic_vector(7 downto 0) := x"22";  -- 1-bit chip select (to decide if we are writing to memory or to FIFO - in reality an SRAM)
   --constant CRDDRWEN   : 	std_logic_vector(7 downto 0) := x"23";  -- a DDR WR-only enable: auto-clearing
   --constant CRDDRREN   : 	std_logic_vector(7 downto 0) := x"24";  -- a DDR RD-only with pattern compare enable: auto-clearing
   --constant CRDDRFIFOWEN: 	std_logic_vector(7 downto 0) := x"25";-- a DMA_EN to transfer data from FIFO to  memory that has to be set high and low by hand
   --constant CRDDRDIAG0 : 	std_logic_vector(7 downto 0) := x"26";  -- 32-bit diagnostic bus: used for MEMFIFO_RD_CNT
   --constant CRDDRRAMADDR: 	std_logic_vector(7 downto 0) := x"27";  -- addr to last DDR content RAM 
   --constant CRDDRDIAG1 : 	std_logic_vector(7 downto 0) := x"28";  -- 32-bit diagnostic bus: used for DDR_RD_CNT (cumulative)
   --constant CRDDRRPATTRN: 	std_logic_vector(7 downto 0):= x"29";  -- 2-bit to specify test patter: 0=> +1, 1=> -1, 2=> A's & 5's, 3=> PRBG
   --constant CRDDRRAMDATA: 	std_logic_vector(7 downto 0) := x"2A";  -- data from last DDR content RAM 
   --constant CRDDRRAMREN: 	std_logic_vector(7 downto 0)	:= x"2B";  -- read enable for RAM with latest DDR read values: auto-clearing 
   --constant CRDDRERRLOC: 	std_logic_vector(7 downto 0) := x"2C";  -- 32-bit DDR error location (x8 to determine DDR address with error)
   --constant CRDDRPTTREN: 	std_logic_vector(7 downto 0) := x"2D";  -- a WR_EN that has to be set high and low by hand
   --constant CRDDRFORCERD:	std_logic_vector(7 downto 0) := x"2E";  -- set DDR3_FULL=1 .AND. MEM_RD_CNT=0 to force DDR3 read: auto-clearing
		--
   constant CRDDRSERIALSET:   std_logic_vector(7 downto 0):= x"30"; 	-- if 1, setup DDR tests via SERIAL, if 0 assumed setup via DCS
   constant CRDDRHBTAG  : 	   std_logic_vector(7 downto 0):= x"31";  -- bit [31:0] of last DTC Heartbeat Tag
   constant CRDDRPRETAG : 	   std_logic_vector(7 downto 0):= x"32";  -- bit [31:0] of last DTC Prefetch Tag
   constant CRDDRFETCHTAG: 	std_logic_vector(7 downto 0):= x"33";  -- bit [31:0] of last Fetched Tag
   constant CRDDRDREQTAG: 	   std_logic_vector(7 downto 0):= x"34";  -- bit [31:0] of last DTC Data Request tag
   constant CRDDROFFSETTAG:   std_logic_vector(7 downto 0):= x"35";  -- bit [31:0] of offset tag in present SPILL
   constant CRDDRCFOEN  : 	   std_logic_vector(7 downto 0):= x"36";  -- enable CFO emulator
   constant CRDDRCFOSTART: 	std_logic_vector(7 downto 0):= x"37";  -- CFO emulator start
   constant CRDDRCFOOFFSET: 	std_logic_vector(7 downto 0):= x"38";  -- set HB tag offset for CFO emulator
   constant CRDDRCFODELTAHB: 	std_logic_vector(7 downto 0):= x"39";  -- set HB DeltaT for CFO emulator
   constant CRDDRCFONOHB   : 	std_logic_vector(7 downto 0):= x"3A";  -- set Number of HBs for CFO emulator
   constant CRDDRPREFEN    : 	std_logic_vector(7 downto 0):= x"3B";   -- enable PREFETCH in CFO emulator
   constant CRDDRSIZEWR:   std_logic_vector(7 downto 0):= x"3C";  -- event size(*3) written to DREQ FIFO:  [31] = DREQ_FIFO FULL,  [16:0] DREQ_FIFO_WRCNT
   constant CRDDRSIZERD:   std_logic_vector(7 downto 0):= x"3D";  -- event size(*3) read from DREQ FIFO:[31] = DREQ_FIFO EMPTY, [16:0] DREQ_FIFO_RDCNT
   constant CRDDRCTRLREADY: std_logic_vector(7 downto 0) := x"3E";  -- DDR ctrl ready
   
   --constant CRDDRSEL   : std_logic_vector(7 downto 0) := x"30";   -- 1-bit serial readout select (1 => DIGIFIFO readout via DDR3, 0 => DIGIFIFO readout directly)
   --constant CRDDRFULL  : std_logic_vector(7 downto 0) := x"31";   --  DDR3 full flag: if 1, DDRPAGENO have been written to memory. When DDRPAGENO have been readout, goes back to 0 
   --constant CRDDRFIFORE: std_logic_vector(7 downto 0) := x"32";   --  start reading 1KB page of DDR3 memory 
   --constant CRDDRSET   : std_logic_vector(7 downto 0):= x"33"; 	--  if 1, use DDR simulator data to TOP_SERDES; if 0, use DDR data to TOP_SERDES
		--
   --constant CRDDRPAGENO: std_logic_vector(7 downto 0) := x"34";   --  how many 1KB pages of DIGIFIFO we want to write to DDR3: max is 2Gb/1KB = 2**18-1 = 262143 
   --constant CRDDRPAGEWR: std_logic_vector(7 downto 0) := x"35";   --  how many 1KB pages have been written to DDR3
   --constant CRDDRPAGERD: std_logic_vector(7 downto 0) := x"36";   --  how many 1KB pages have been read from DDR3
   --constant CRDDRMEMFIFODATA0  : std_logic_vector(7 downto 0) := x"37";
   --constant CRDDRMEMFIFODATA1  : std_logic_vector(7 downto 0) := x"38";
   --constant CRDDRMEMFIFOFULL    : std_logic_vector(7 downto 0) := x"39";
   --constant CRDDRMEMFIFOEMPTY   : std_logic_vector(7 downto 0) := x"3A";
   --constant CRDDRMEMFIFORE      : std_logic_vector(7 downto 0) := x"3B";
   --constant CRDDRTEMPFIFOFULL   : std_logic_vector(7 downto 0) := x"3C"; 
   --constant CRDDRTEMPFIFOEMPTY  : std_logic_vector(7 downto 0) := x"3D"; 
   --constant CRDDRCONVDATA       : std_logic_vector(7 downto 0) := x"3E";  -- DATA out of DIGIFIFO or PATTERN_FIFO
   --constant CRDDRCONVRDCNT      : std_logic_vector(7 downto 0) := x"3F"; -- RDCNT out of DIGIFIFO or PATTERN_FIFO

-------------------------------------------------------------------------------
-- -SERDES 
------------------------------------------------------------------------------ 
   constant CRSERDESRE    : std_logic_vector(7 downto 0) := x"40";
   constant CRSERDESDATA  : std_logic_vector(7 downto 0) := x"41";
   constant CRSERDESFULL  : std_logic_vector(7 downto 0) := x"42";
   constant CRSERDESEMPTY : std_logic_vector(7 downto 0) := x"43";
   constant CRSERDESRESET : std_logic_vector(7 downto 0) := x"44";
   constant CRSERDESRDCNT : std_logic_vector(7 downto 0) := x"45";
   constant CRSERDESHOWMANY : std_logic_vector(7 downto 0) := x"46";
   constant CRSERDESALIGNMENT : std_logic_vector(7 downto 0) := x"47";
   constant CRSERDES_RE : std_logic_vector(7 downto 0) := x"48";
   constant CRSERDES_RDCNT0 : std_logic_vector(7 downto 0) := x"49";
   constant CRSERDES_RDCNT1 : std_logic_vector(7 downto 0) := x"4A";
   constant CRSERDES_RDCNT2 : std_logic_vector(7 downto 0) := x"4B";
   constant CRSERDES_RDCNT3 : std_logic_vector(7 downto 0) := x"4C";
   constant CRSERDES_DATA0 : std_logic_vector(7 downto 0) := x"4D";
   constant CRSERDES_DATA1 : std_logic_vector(7 downto 0) := x"4E";
   constant CRSERDES_DATA2 : std_logic_vector(7 downto 0) := x"4F";
   constant CRSERDES_DATA3 : std_logic_vector(7 downto 0) := x"50";
 

 -------------------------------------------------------------------------------
-- -DTC SIMULATION signals: Monica added 08/22/2020 
------------------------------------------------------------------------------ 
   --constant CRDTCSIMEN 	  : std_logic_vector(7 downto 0) := x"50";  -- send DTC packets/marker to DTCInterface
   constant CRDTCSIMSTART : std_logic_vector(7 downto 0) := x"51";  -- send DTC packets/marker to DTCInterface
   constant CRDTCSIMPARAM : std_logic_vector(7 downto 0) := x"52";  -- simulation parameters: [28] = DTC_SIMEN, [24] = DTC_SEL, [21:16] = OP_CODE,
                                                                    --    [11:8] = RETR_SEQ_NUM, [7:4] = MARKER_TYPE, [3:0] = PACKET_TYPE
   constant CRDTCSIMADDR  : std_logic_vector(7 downto 0) := x"53";  -- simulation packet address:  [23:16] = MODULE_ID, [15:0] = operation ADDRESS
   constant CRDTCSIMDATA  : std_logic_vector(7 downto 0) := x"54";  -- simulation packet data:     [31:16] = BLK_CNT,   [15:0] = operation DATA
   constant CRDTCSIMSPILLDT: std_logic_vector(7 downto 0) := x"55";  -- simulated data packet parameters: [31] = ON_SPILL, [30:24] = RF_MARKER
                                                                    --    [23:16] =  EVT_MODE[7:0],  [15:0] = WINDOW_MARKER[15:0]
   constant CRDTCSIMBLKEN : std_logic_vector(7 downto 0) := x"56";  -- enable write of DTC BLK data to RAM
   constant CRDTCSIMBLKDT : std_logic_vector(7 downto 0) := x"57";  -- DTC BLK_RAM data
   constant CRDTCSIMBLKAD : std_logic_vector(7 downto 0) := x"58";  -- DTC BLK_RAM address

   constant CRDTCDATAREAD : std_logic_vector(7 downto 0) := x"59";  -- last DTC reply [31:16] = addr, [15:0] = data 

-------------------------------------------------------------------------------
-- -CAL DIGI SPI
------------------------------------------------------------------------------ 
   constant CRCALSPIINIT : std_logic_vector(7 downto 0) := x"60";
   constant CRCALSPIBUSY : std_logic_vector(7 downto 0) := x"61";
   constant CRCALSPIADDRESS  : std_logic_vector(7 downto 0) := x"62";
   constant CRCALSPIDATA : std_logic_vector(7 downto 0) := x"63";


-------------------------------------------------------------------------------
-- -HV DIGI SPI
------------------------------------------------------------------------------ 
   constant CRHVSPIINIT : std_logic_vector(7 downto 0) := x"70";
   constant CRHVSPIBUSY : std_logic_vector(7 downto 0) := x"71";
   constant CRHVSPIADDRESS  : std_logic_vector(7 downto 0) := x"72";
   constant CRHVSPIDATA : std_logic_vector(7 downto 0) := x"73";

   constant CREWM : std_logic_vector(7 downto 0) := x"80";
   constant CREWMENABLE : std_logic_vector(7 downto 0) := x"81";
   constant CREWMDELAY : std_logic_vector(7 downto 0) := x"82";
   constant CREWMEARLY : std_logic_vector(7 downto 0) := x"84";
   constant CREWMLATE  : std_logic_vector(7 downto 0) := x"85";


-------------------------------------------------------------------------------
-- -TVS READINGS
------------------------------------------------------------------------------ 
   constant CRROCTVS_VAL : std_logic_vector(7 downto 0) := x"90";
   constant CRROCTVS_ADDR : std_logic_vector(7 downto 0) := x"91";
   
------------------------------------------------------------------------------    
-------MISC DIGI's SIGNALS
------------------------------------------------------------------------------ 
	constant CR_FIFO_RESET : std_logic_vector(7 downto 0) := x"A3";
	constant CR_LANE_ALIGNED : std_logic_vector(7 downto 0) := x"A4";
	constant CR_REMOTE_TOKEN0 : std_logic_vector(7 downto 0) := x"A5";
	constant CR_REMOTE_TOKEN1 : std_logic_vector(7 downto 0) := x"A6";
	constant CR_REMOTE_TOKEN2 : std_logic_vector(7 downto 0) := x"A7";
	constant CR_REMOTE_TOKEN3 : std_logic_vector(7 downto 0) := x"A8";
	constant CR_SERDES_WRITE_FIFO : std_logic_vector(7 downto 0) := x"A9";
	constant CR_DUMMY_ADDRESS : std_logic_vector(7 downto 0) := x"AA";
	constant CR_DUMMY_STATUS_OUT : std_logic_vector(7 downto 0) := x"AB";
    
	constant CR_ENABLE_FIBER_CLOCK : std_logic_vector(7 downto 0) := x"B0";
	constant CR_ENABLE_FIBER_MARKER : std_logic_vector(7 downto 0) := x"B1";
    
	constant CR_LANE0_RESET 		: std_logic_vector(7 downto 0) := x"B2";
	constant CR_LANE1_RESET 		: std_logic_vector(7 downto 0) := x"B3";
	constant CR_DTC_ENABLE_RESET : std_logic_vector(7 downto 0) := x"B4";
    
	constant CR_DIGI_SERDES_RESETS		: std_logic_vector(7 downto 0) := x"B5";
	constant CR_DIGI_SERDES_ALIGNED		: std_logic_vector(7 downto 0) := x"B6";
	constant CR_DIGI_SERDES_ALIGNMENT 	: std_logic_vector(7 downto 0) := x"B7";
	constant CR_CAL_SERDES_ERRORS 		: std_logic_vector(7 downto 0) := x"B8";
	constant CR_HV_SERDES_ERRORS 		: std_logic_vector(7 downto 0) := x"B9";

    constant CR_DTC_ERROR_ADDRESS		: std_logic_vector(7 downto 0) := x"E0";
    constant CR_DTC_ERROR_COUNTER		: std_logic_vector(7 downto 0) := x"E1";

-------------------------------------------------------------------------------
-- DDR SPEED TESTS
------------------------------------------------------------------------------ 
   --constant CRDDRTRUEL:		std_logic_vector(7 downto 0) := x"C0";  -- LSB 32-bit for DDR read with error
   --constant CRDDRTRUEH: 	std_logic_vector(7 downto 0) := x"C1";  -- MSB 32-bit for DDR read with error
   --constant CRDDREXPCL: 	std_logic_vector(7 downto 0) := x"C2";  -- LSB 32-bit for DDR expected with error
   --constant CRDDREXPCH: 	std_logic_vector(7 downto 0) := x"C3";  -- MSB 32-bit for DDR expected with error
   --constant CRDDRBURST: 	std_logic_vector(7 downto 0) := x"C4";	 -- DDR BURST size (ex:0x3 = 256 bits, 0x7F = 1kB)	
   --constant CRDDRRWEN: 		std_logic_vector(7 downto 0) := x"C5";  -- a simultaneous DDR WR&RD EN: auto-clearing 
   --constant CRDDRERRREN:	std_logic_vector(7 downto 0) := x"C6";  -- read enable for FIFOs with DDR errors: auto-clearing 
   --constant CRDDRWRTREN:	std_logic_vector(7 downto 0) := x"C7";  -- read enable for DDR-Writes timer FIFO: auto-clearing 
   --constant CRDDRRDTREN:	std_logic_vector(7 downto 0) := x"C8";  -- read enable for DDR-Reads timer FIFO: auto-clearing 
   --constant CRDDRFIFODIA: 	std_logic_vector(7 downto 0) := x"C9";  -- FIFO STATUS for timing and error FIFOs: bit 0/1 => WRTIME E/F;  4/5 RDTIME E/F;  8/9 ERROR E/F
   --constant CRDDRWRTIME:	std_logic_vector(7 downto 0) := x"CA";  -- 32-bit timer for DDR writes
   --constant CRDDRRDTIME:	std_logic_vector(7 downto 0) := x"CB";  -- 32-bit timer for DDR reads
   --constant CRDDRERRCNT:	std_logic_vector(7 downto 0) := x"CC";  -- 32-bit DDR error count
   --constant CRDDRLOCRAM:	std_logic_vector(7 downto 0) := x"CD";  -- 32-bit DDR location to start write to TPSRAM(x8 to determine DDR address)
   --constant CRDDRWRBCNT: 	std_logic_vector(7 downto 0) := x"CE";  -- DDR Write-data burst count 
   --constant CRDDRRDBCNT: 	std_logic_vector(7 downto 0) := x"CF";  -- DDR Read-data burst count 

  -------------------------------------------------------------------------------
  -- Signal declarations
  -------------------------------------------------------------------------------
  signal DataOut            : std_logic_vector(APB_DATA_WIDTH-1 downto 0);

   component TWIController
        -- ports
        port( 
            -- Inputs
            reset_n : in std_logic;
            clk : in std_logic;
            init : in std_logic;
            data_in : in std_logic_vector(15 downto 0);
            address : in std_logic_vector(8 downto 0);

            -- Outputs
            busy : out std_logic;
            data_out : out std_logic_vector(15 downto 0);
            scl : out std_logic;

            -- Inouts
            sda : inout std_logic

        );
    end component;

    --component SPIController
    --port (
        --reset_n : in std_logic;
        --clk : in std_logic;
        --
        --init : in std_logic;
        --busy : out std_logic;
        --
        --data_in : in std_logic_vector(15 downto 0);
        --address : in std_logic_vector(2 downto 0);
        --data_out : out std_logic_vector(15 downto 0);
    --
        --ss_n : out std_logic;
        --sclk : out std_logic;
        --mosi : out std_logic;
        --miso : in std_logic
    --);
    --end component;
--
    signal cal_init : std_logic;
    signal cal_busy : std_logic;
    signal cal_data_in : std_logic_vector(15 downto 0);
    signal cal_data_out : std_logic_vector(15 downto 0);
    signal cal_address_in : std_logic_vector(8 downto 0);
  
    signal hv_init : std_logic;
    signal hv_busy : std_logic;
    signal hv_data_in : std_logic_vector(15 downto 0);
    signal hv_data_out : std_logic_vector(15 downto 0);
    signal hv_address_in : std_logic_vector(8 downto 0);




begin

     --calSPIController : SPIController
        --port map(
            --reset_n => PRESETn,
            --clk => PCLK,
            --
            --init => cal_init,
            --busy => cal_busy,
            --
            --data_in => cal_data_in,
            --address => cal_address_in,
            --data_out => cal_data_out,
        --
            --ss_n => cal_ss_n,
            --sclk => cal_sclk,
            --mosi => cal_mosi,
            --miso => cal_miso
        --);
--
--
     --hvSPIController : SPIController
        --port map(
            --reset_n => PRESETn,
            --clk => PCLK,
            --
            --init => hv_init,
            --busy => hv_busy,
            --
            --data_in => hv_data_in,
            --address => hv_address_in,
            --data_out => hv_data_out,
        --
            --ss_n => hv_ss_n,
            --sclk => hv_sclk,
            --mosi => hv_mosi,
            --miso => hv_miso
        --);


    hvTWIController_0 : TWIController
        -- port map
        port map( 
            -- Inputs
            reset_n => PRESETn ,
            clk => PCLK,
            init => hv_init,
            data_in => hv_data_in,
            address => hv_address_in,

            -- Outputs
            busy =>  hv_busy,
            data_out => hv_data_out,
            scl =>  hvscl,

            -- Inouts
            sda =>  hvsda

        );

  calTWIController_0 : TWIController
        -- port map
        port map( 
            -- Inputs
            reset_n => PRESETn ,
            clk => PCLK,
            init => cal_init,
            data_in => cal_data_in,
            address => cal_address_in,

            -- Outputs
            busy =>  cal_busy,
            data_out => cal_data_out,
            scl =>  calscl,

            -- Inouts
            sda =>  calsda

        );



  PREADY  <= '1';
  PSLVERR <= '0';
-------------------------------------------------------------------------------
-- Code for APB transactions
-------------------------------------------------------------------------------
  -- Generate PRDATA on falling edge
  p_PRDATA : process (PWRITE, PSEL, PADDR)
  begin
    DataOut <= (others => '0');
    if PWRITE = '0' and PSEL = '1' then
      case PADDR(9 downto 2) is
        when CRINVERTCALSPICLCK =>
          DataOut(0) <= INVERTCALSPICLCK;
            
        when CRTIMERCOUNTER =>
            DataOut(31 downto 0) <= TIMERCOUNTER;
            
        when CRDDRERROR =>
          DataOut(3 downto 0) <= DDRERROR;
        when CRDDRERRSEENL =>
          DataOut(31 downto 0) <= DDRERRSEEN(31 downto 0);
        when CRDDRERRSEENH =>
          DataOut(31 downto 0) <= DDRERRSEEN(63 downto 32);
        when CRDDRERREXPCL =>
          DataOut(31 downto 0) <= DDRERREXPC(31 downto 0);
        when CRDDRERREXPCH =>
          DataOut(31 downto 0) <= DDRERREXPC(63 downto 32);
        when CRDDRSIZEWR =>
          DataOut(31 downto 0) <= DDRSIZEWR;
        when CRDDRSIZERD =>
          DataOut(31 downto 0) <= DDRSIZERD;
        when CRDDRHBCNT =>
          DataOut(31 downto 0) <= DDRHBCNT;
        when CRDDRHBONHOLD =>
          DataOut(31 downto 0) <= DDRHBONHOLD;
        when CRDDRPREFCNT =>
          DataOut(31 downto 0) <= DDRPREFCNT;
        when CRDDRDREQCNT =>
          DataOut(31 downto 0) <= DDRDREQCNT;
        when CRDDRDREQREAD =>
          DataOut(31 downto 0) <= DDRDREQREAD;
        when CRDDRDREQSENT =>
          DataOut(31 downto 0) <= DDRDREQSENT;
        when CRDDRDREQNULL =>
          DataOut(31 downto 0) <= DDRDREQNULL;
        when CRDDRSPILLCNT =>
          DataOut(19 downto 0) <= DDRSPILLCNT;
        when CRDDRNULLHBCNT =>
          DataOut(31 downto 0) <= DDRNULLHBCNT;
        when CRDDRHBTAG =>
          DataOut(31 downto 0) <= DDRHBTAG;
        when CRDDRPRETAG =>
          DataOut(31 downto 0) <= DDRPRETAG;
        when CRDDRFETCHTAG =>
          DataOut(31 downto 0) <= DDRFETCHTAG;
        when CRDDRDREQTAG =>
          DataOut(31 downto 0) <= DDRDREQTAG;
        when CRDDROFFSETTAG =>
          DataOut(31 downto 0) <= DDROFFSETTAG;

          --when CRDDRDIAG0 =>
          --DataOut(31 downto 0) <= DDRDIAG0;
        --when CRDDRDIAG1 =>
          --DataOut(31 downto 0) <= DDRDIAG1;
			 --
        --when CRDDRWRTIME =>
          --DataOut(31 downto 0) <= DDRWRTIME;
        --when CRDDRRDTIME =>
          --DataOut(31 downto 0) <= DDRRDTIME;
        --when CRDDRERRCNT =>
          --DataOut(31 downto 0) <= DDRERRCNT;
        --when CRDDRERRLOC =>
          --DataOut(31 downto 0) <= DDRERRLOC;
        --when CRDDRFIFODIA =>
          --DataOut(15 downto 0) <= DDRFIFODIA;
        --when CRDDRTRUEL =>
          --DataOut(31 downto 0) <= DDRTRUEL;
        --when CRDDRTRUEH =>
          --DataOut(31 downto 0) <= DDRTRUEH;
        --when CRDDREXPCL =>
          --DataOut(31 downto 0) <= DDREXPCL;
        --when CRDDREXPCH =>
          --DataOut(31 downto 0) <= DDREXPCH;
        --when CRDDRRAMDATA =>
          --DataOut(31 downto 0) <= DDRRAMDATA;
        --when CRDDRWRBCNT =>
          --DataOut(31 downto 0) <= DDRWRBCNT;
        --when CRDDRRDBCNT =>
          --DataOut(31 downto 0) <= DDRRDBCNT;
--
--
        --when CRDDRFULL =>
          --DataOut(0) <= DDRFULL;
        --when CRDDRPAGEWR =>
          --DataOut(31 downto 0) <= DDRPAGEWR;
        --when CRDDRPAGERD =>
          --DataOut(31 downto 0) <= DDRPAGERD;
--
        --when CRDDRMEMFIFOFULL =>
          --DataOut(0) <= DDRMEMFIFOFULL;
        --when CRDDRMEMFIFOEMPTY =>
          --DataOut(0) <= DDRMEMFIFOEMPTY;
        --when CRDDRMEMFIFODATA0 =>
          --DataOut(31 downto 0) <= DDRMEMFIFODATA0;
        --when CRDDRMEMFIFODATA1 =>
          --DataOut(31 downto 0) <= DDRMEMFIFODATA1;
        --when CRDDRTEMPFIFOFULL =>
          --DataOut(0) <= DDRTEMPFIFOFULL;
        --when CRDDRTEMPFIFOEMPTY =>
          --DataOut(0) <= DDRTEMPFIFOEMPTY;
--
        --when CRDDRCONVDATA =>
          --DataOut(31 downto 0) <= DDRCONVDATA;
        --when CRDDRCONVRDCNT =>
          --DataOut(16 downto 0) <= DDRCONVRDCNT;
--
        when CRDTCDATAREAD =>
          DataOut(31 downto 0) <= DTCDATAREAD;
        when CRDDRCTRLREADY =>
          DataOut(0) <= DDRCTRLREADY;
          
        when CRSERDESFULL =>
          DataOut(0) <= SERDES_FULL;
        when CRSERDESEMPTY =>
          DataOut(0) <= SERDES_EMPTY;
        when CRSERDESDATA =>
          DataOut(31 downto 0) <= SERDES_DATA;
       when CRSERDESRDCNT =>
          DataOut(16 downto 0) <= SERDES_RDCNT;
        when CRSERDESALIGNMENT =>
          DataOut(3 downto 0 ) <= serdes_aligned;

       when CRCALSPIBUSY =>
          DataOut(0) <= cal_busy;
        when CRCALSPIDATA =>
          DataOut(15 downto 0) <= cal_data_out;

       when CRHVSPIBUSY =>
          DataOut(0) <= hv_busy;
        when CRHVSPIDATA =>
          DataOut(15 downto 0) <= hv_data_out;
        when CRROCTVS_VAL =>
          DataOut(15 downto 0) <= ROCTVS_VAL;

        when CR_LANE_ALIGNED =>
            DataOut(3 downto 0) <= serdes_aligned;
        when CR_REMOTE_TOKEN0 =>
            DataOut(7 downto 0) <= remote_token0;
        when CR_REMOTE_TOKEN1 =>
            DataOut(7 downto 0) <= remote_token1;
        when CR_REMOTE_TOKEN2 =>
            DataOut(7 downto 0) <= remote_token2;
        when CR_REMOTE_TOKEN3 =>
            DataOut(7 downto 0) <= remote_token3;

        when CR_DUMMY_STATUS_OUT =>
            DataOut <= dummy_status_out0 & dummy_status_out1 & dummy_status_out2 & dummy_status_out3;
            
        when CRSERDES_RDCNT0 =>
            DataOut(12 downto 0) <= serdes_rdcnt0;
        when CRSERDES_RDCNT1 =>
            DataOut(12 downto 0) <= serdes_rdcnt1;
        when CRSERDES_RDCNT2 =>
            DataOut(12 downto 0) <= serdes_rdcnt2;
        when CRSERDES_RDCNT3 =>
            DataOut(12 downto 0) <= serdes_rdcnt3;
        when CRSERDES_DATA0 =>
            DataOut <= serdes_data0;
        when CRSERDES_DATA1 =>
            DataOut <= serdes_data1;
        when CRSERDES_DATA2 =>
            DataOut <= serdes_data2;
        when CRSERDES_DATA3 =>
            DataOut <= serdes_data3;
            
        when CR_DIGI_SERDES_ALIGNED =>
            DataOut(0) <= cal_lane0_aligned;
            DataOut(1) <= cal_lane1_aligned;
            DataOut(2) <= hv_lane0_aligned;
            DataOut(3) <= hv_lane1_aligned;
        when CR_DIGI_SERDES_ALIGNMENT =>
            DataOut(3 downto 0) <= cal_lane0_alignment;
            DataOut(7 downto 4) <= cal_lane1_alignment;
            DataOut(11 downto 8) <= hv_lane0_alignment;
            DataOut(15 downto 12) <= hv_lane1_alignment;
        when CR_CAL_SERDES_ERRORS =>
            DataOut(7 downto 0) <= cal_lane0_error_count;
            DataOut(15 downto 8) <= cal_lane1_error_count;
        when CR_HV_SERDES_ERRORS =>
            DataOut(7 downto 0) <= hv_lane0_error_count;
            DataOut(15 downto 8) <= hv_lane1_error_count;
        when CR_DTC_ERROR_COUNTER =>
            DataOut(15 downto 0) <= dtc_error_counter;
            

        when others =>
          DataOut <= (others => '0');
      end case;
    else
      DataOut <= (others => '0');
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
  -- Control registers writing
  p_reg_seq : process (PRESETn, PCLK, PSEL, PENABLE, PWRITE)
  begin
    if (PRESETn = '0') then
      DDR_RESETN 			<= '1';
		DTCALIGN_RESETN	<= '1';
      DIGIDEVICE_RESETN	<= '1';
		TVS_RESETN			<=	'1';
		
      INVERTCALSPICLCK  <= '0';

      DDRSERIALSET      <= '0';
      DDRPTTREN         <= '0';
      DDRCFOEN          <= '0';
      DDRCFOSTART       <= '0';
      DDRPREFETCHEN     <= '0';
      DDRERRREQ         <= b"00";
      DDRCFOOFFSET      <= (others => '0');  -- default TAG offset is zero
      DDRCFODELTAHB     <= x"0000_00FF";     -- default is 255*6.7 ns = 1.7 us
      DDRCFONUMBERHB    <= x"0000_0001";   

      --DDRCS             <= '0';
      --DDRWEN            <= '0';
      --DDRREN            <= '0';
      --DDRFIFOWEN        <= '0';
      --DDRSEL            <= '0';
      --DDRSET            <= '0';
      --DDRPTTREN         <= '0';
      --DDRFIFO_RE        <= '0';
      --DDRMEMFIFO_RE     <= '0';
      --DDRPAGENO         <= x"0000_0000"; 
      --DDROFFSET         <= x"0000_0000"; 
      --DDRNHITS          <= x"0000_0001"; 
      --DDRPATTRN         <= b"00";
      --DDRRAMADDR        <= x"FFFF_FFFF";
      --DDRLOCRAM         <= x"0000_0000"; 
		--
		--DDRFORCERD		<= '0';
		
      DTCSIMSTART    <= '0';
      DTCSIMBLKEN    <= '0';
      DTCSIMPARAM    <= x"0000_0000";
      DTCSIMADDR     <= x"0000_0000";
      DTCSIMDATA     <= x"0000_0000";
      DTCSIMSPILLDATA<= x"0000_0000";
      DTCSIMBLKDATA  <= x"0000";
      DTCSIMBLKADDR  <= b"0000000";

      SERDES_RE <= '0';
      serdes_re0 <= '0';
      serdes_re1 <= '0';
      serdes_re2 <= '0';
      serdes_re3 <= '0';
      use_lane <= b"0000";
      
      cal_lane0_pcs_reset_n <= '1';
      cal_lane1_pcs_reset_n <= '1';
      cal_lane0_pma_reset_n <= '1';
      cal_lane1_pma_reset_n <= '1';
      hv_lane0_pcs_reset_n <= '1';
      hv_lane1_pcs_reset_n <= '1';
      hv_lane0_pma_reset_n <= '1';
      hv_lane1_pma_reset_n <= '1';
      
      cal_serdes_reset_n <= '1';
      hv_serdes_reset_n <= '1';
      dtc_serdes_reset_n <= '1';
      
      dtc_enable_reset <= '0';
      
      cal_init <= '0';
      hv_init <= '0';
      ewm_50mhz <= '0';
      ewm_enable_50mhz <= '0';
      use_uart <= '0';
      
      write_to_fifo <= '0';
      reset_fifo_n <= '1';
      dummy_status_address <= (others => '0');
      force_full <= '0';
      align_roc_to_digi <= '0';
      
      enable_fiber_clock <= '0';
      enable_fiber_marker <= '0';
      dtc_error_address <= (others => '0');
		
    elsif (PCLK'event and PCLK = '1') then
		DDR_RESETN  <= '1';
		
		SERDES_RE <= '0';
      serdes_re0 <= '0';
      serdes_re1 <= '0';
      serdes_re2 <= '0';
      serdes_re3 <= '0';
      
      --DIGI_RESET  <= '1';
      --reset_fifo_n <= '1';
     
      cal_init  <= '0';
      hv_init   <= '0';
--
-- this are meant to pulses 
      DTCSIMSTART    <= '0';
      DTCSIMBLKEN    <= '0';
      DDRCFOSTART    <= '0';
      
      if (PWRITE = '1' and PSEL = '1' and PENABLE = '1') then
        case PADDR(9 downto 2) is
			
          when CRDDRRESETN =>
            DDR_RESETN <= '0';
			 when CRDTCALIGNRESETN =>
            DTCALIGN_RESETN <= PWDATA(0);
          when CRINVERTCALSPICLCK =>
            INVERTCALSPICLCK <= PWDATA(0);
			 when CRTVSRESETN =>
				TVS_RESETN <= PWDATA(0);
				
          when CRTIMERRESET =>
            TIMERRESET<=PWDATA(0);
				
          when CRTIMERENABLE =>
            TIMERENABLE <= PWDATA(0);
				
          when CRDDRSERIALSET =>
            DDRSERIALSET <= PWDATA(0);
          when CRDDRPTTREN =>
            DDRPTTREN <= PWDATA(0);
          when CRDDRERRREQ =>
            DDRERRREQ <= PWDATA(1 downto 0);
          when CRDDRCFOEN =>
            DDRCFOEN <= PWDATA(0);
          when CRDDRPREFEN =>
            DDRPREFETCHEN <= PWDATA(0);
          when CRDDRCFOSTART =>
            DDRCFOSTART <= '1';
          when CRDDRCFOOFFSET =>
            DDRCFOOFFSET <= PWDATA(31 downto 0);
          when CRDDRCFODELTAHB =>
            DDRCFODELTAHB  <= PWDATA(31 downto 0);
          when CRDDRCFONOHB  =>
            DDRCFONUMBERHB <= PWDATA(31 downto 0);

          when CRDTCSIMSTART =>
            DTCSIMSTART <= '1';
          when CRDTCSIMBLKEN =>
            DTCSIMBLKEN <= '1';
          when CRDTCSIMPARAM =>
            DTCSIMPARAM <= PWDATA(31 downto 0);
          when CRDTCSIMADDR =>
            DTCSIMADDR <= PWDATA(31 downto 0);
          when CRDTCSIMDATA =>
            DTCSIMDATA <= PWDATA(31 downto 0);
          when CRDTCSIMSPILLDT =>
            DTCSIMSPILLDATA <= PWDATA(31 downto 0);
          when CRDTCSIMBLKDT =>
            DTCSIMBLKDATA <= PWDATA(15 downto 0);
          when CRDTCSIMBLKAD =>
            DTCSIMBLKADDR <= PWDATA(6 downto 0);
          when CRSERDESRE =>
            SERDES_RE <= '1';
   
          when CRSERDESRESET =>
            DIGIDEVICE_RESETN	<= PWDATA(0);
         
          when CRSERDESHOWMANY =>
            SERDES_HOWMANY <= PWDATA(12 downto 0);

          when CRCALSPIINIT =>
            cal_init <= '1';
          when CRCALSPIADDRESS =>
            cal_address_in <= PWDATA(8 downto 0);
          when CRCALSPIDATA =>
            cal_data_in <= PWDATA(15 downto 0);

          when CRHVSPIINIT =>
            hv_init <= '1';
          when CRHVSPIADDRESS =>
            hv_address_in <= PWDATA(8 downto 0);
          when CRHVSPIDATA =>
            hv_data_in <= PWDATA(15 downto 0);

          when CREWM =>
            ewm_50mhz <= PWDATA(0);
          when CREWMENABLE =>
            ewm_enable_50mhz <= PWDATA(0);
          when CREWMDELAY =>
            ewm_delay <= PWDATA(15 downto 0);
        when CREWMEARLY =>
            event_window_early_cut <= PWDATA(15 downto 0);
        when CREWMLATE =>
            event_window_late_cut <= PWDATA(15 downto 0);
        when CRROCTVS_ADDR =>
            ROCTVS_ADDR <= PWDATA(1 downto 0);
            
        when CR_FIFO_RESET =>
            reset_fifo_n <= PWDATA(0);
         
        when CR_SERDES_WRITE_FIFO =>
            write_to_fifo <= PWDATA(0);

        when CR_DUMMY_ADDRESS =>
            dummy_status_address <= PWDATA(3 downto 0);
            
        when CRSERDES_RE =>
            serdes_re0 <= PWDATA(0);
            serdes_re1 <= PWDATA(1);
            serdes_re2 <= PWDATA(2);
            serdes_re3 <= PWDATA(3);
            use_lane <= PWDATA(3 downto 0);
            
        when CR_ENABLE_FIBER_CLOCK =>
            enable_fiber_clock <= PWDATA(0);
        when CR_ENABLE_FIBER_MARKER =>
            enable_fiber_marker <= PWDATA(0);
        when CR_DTC_ENABLE_RESET =>
            dtc_enable_reset <= PWDATA(0);
        when CR_DIGI_SERDES_RESETS =>
            cal_lane0_pcs_reset_n <= PWDATA(0);
            cal_lane1_pcs_reset_n <= PWDATA(1);
            cal_lane0_pma_reset_n <= PWDATA(2);
            cal_lane1_pma_reset_n <= PWDATA(3);
            hv_lane0_pcs_reset_n <= PWDATA(4);
            hv_lane1_pcs_reset_n <= PWDATA(5);
            hv_lane0_pma_reset_n <= PWDATA(6);
            hv_lane1_pma_reset_n <= PWDATA(7);
            
        when X"EF" =>
            force_full <= PWDATA(0);
        when X"EE" =>
            align_roc_to_digi <= PWDATA(0);
        when X"ED" =>
            cal_serdes_reset_n <= PWDATA(0);
            hv_serdes_reset_n <= PWDATA(1);
            dtc_serdes_reset_n <= PWDATA(2);
            
        when CR_DTC_ERROR_ADDRESS =>
            dtc_error_address <= PWDATA(7 downto 0);
        when X"F0" =>
            event_window_expected <= PWDATA(15 downto 0);
--        when X"F1" =>
        when CRUSEUART  =>
            use_uart <= PWDATA(0);
            
          when others =>
        end case;
      end if;
    end if;
  end process p_reg_seq;




end synth;

