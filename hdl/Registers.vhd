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
    error_address : out std_logic_vector(7 downto 0);
    error_counter : in std_logic_vector(15 downto 0);
    
    cal_serdes_reset_n : out std_logic;
    hv_serdes_reset_n : out std_logic;
    dtc_serdes_reset_n : out std_logic;
    
    event_window_expected : out std_logic_vector(15 downto 0);

    TIMERENABLE : out std_logic;
    TIMERRESET: out std_logic;
    TIMERCOUNTER : in std_logic_vector(31 downto 0);

    -- DIGIs commands driven by DTC via DRACRegisters
    dcs_cal_init : in std_logic;
    dcs_cal_data : in std_logic_vector(15 downto 0);
    dcs_cal_addr : in std_logic_vector(8 downto 0);

    dcs_hv_init : in std_logic;
    dcs_hv_data : in std_logic_vector(15 downto 0);
    dcs_hv_addr : in std_logic_vector(8 downto 0);
    
    dcs_enable_fiber_clock  : in std_logic;    
    dcs_enable_fiber_marker : in std_logic;  
  
    dcs_ewm_enable_50mhz    : in std_logic;
    dcs_use_lane            : in std_logic_vector(3 downto 0);
    dcs_force_full          : in std_logic;

    PRBS_LOCK		: in  std_logic;
    PRBS_ON		    : in  std_logic;
    PRBS_ERRORCNT   : in  std_logic_vector(31 downto 0);
    PRBS_EN         : out std_logic;
    PRBS_ERROROUT   : out std_logic;
    PRBS_ERRORCLR   : out std_logic;
    
    DDR_WREN        : out std_logic;
    DDR_RDEN        : out std_logic;
    DDR_BLOCK_NO    : out std_logic_vector(31 downto 0);
    DDR_TEST_STATUS : in  std_logic_vector(3 downto 0);
    DDR_TEST_ERRCNT : in  std_logic_vector(31 downto 0);
    DDR_TEST_ERRLOC : in  std_logic_vector(31 downto 0)
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
   constant CRTIMERENABLE	: std_logic_vector(7 downto 0) := x"12";
   constant CRTIMERRESET	: std_logic_vector(7 downto 0) := x"13";
   constant CRTIMERCOUNTER	: std_logic_vector(7 downto 0) := x"14";
   constant	CRDTCALIGNRESETN: std_logic_vector(7 downto 0) := x"15";
   constant	CRTVSRESETN     : std_logic_vector(7 downto 0) := x"16";
   
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

------------------------------------------------------------------------------    
---- PRBS & DDR MEMORY TEST SIGNALS
------------------------------------------------------------------------------ 
   constant	CRPRBS_EN	    : std_logic_vector(7 downto 0) := x"D0";    -- level HIGH for duration of PRBS pattern test
   constant	CRPRBS_ERROROUT : std_logic_vector(7 downto 0) := x"D2";    -- inject ERROR into PRBS
   constant	CRPRBS_ERRORCLR	: std_logic_vector(7 downto 0) := x"D3";	-- clear PRBS errors
   constant	CRPRBS_ERRORCNT	: std_logic_vector(7 downto 0) := x"D9";	-- PRBS ERROR CNT 
   constant	CRPRBS_ON	    : std_logic_vector(7 downto 0) := x"DA";	-- PRBS ON
   constant	CRPRBS_LOCK		: std_logic_vector(7 downto 0) := x"DB";	-- PRBS fiber locked

   constant CR_ERROR_ADDRESS: std_logic_vector(7 downto 0) := x"E0";
   constant CR_ERROR_COUNTER: std_logic_vector(7 downto 0) := x"E1";

   constant	CRDDR_WREN		: std_logic_vector(7 downto 0) := x"E2";	-- Start DDR pattern WRITE
   constant	CRDDR_RDEN		: std_logic_vector(7 downto 0) := x"E3";	-- Start DDR pattern READ
   constant	CRDDR_BLOCK_NO  : std_logic_vector(7 downto 0) := x"E4";	-- Number of 1kB DDR blocks to write
   constant	CRDDR_TESTDIAG	: std_logic_vector(7 downto 0) := x"E5";	-- DDR test STATUS ( [0]=WRTIE DONE, [1]=READ DONE, [2]=ERROR SEEN ) 
   constant	CRDDR_TESTERRCNT: std_logic_vector(7 downto 0) := x"E6";    -- number of errors in DDR test
   constant	CRDDR_TESTERRLOC: std_logic_vector(7 downto 0) := x"E7";    -- addr of FIRST DDR test error
-- -- other register implicitely used
--      0xED to drive   cal_serdes_reset_n , hv_serdes_reset_n , dtc_serdes_reset_n 
--      0xEE to drive   align_roc_to_digi
--      0xEF to drive   serial_force_full
--      0xF0 to drive   event_window_expected
    constant CR_USE_UART                : std_logic_vector(7 downto 0) := x"F1";  -- send DIGI data to DIGIReaderFIFO. bypassing ROCFIFOs 
    constant CR_DIGIRW_SEL              : std_logic_vector(7 downto 0) := x"F2";  -- select source of some signals as fiber (if 0) or serail (if 1)


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


-- added signals to deal with DIGI_RW commands via DCS packets from fiber
    signal  digirw_sel      : std_logic;    -- if 0 (default) registers are driven by fiber; if 1, registers are driven by serial

    signal serial_cal_init  : std_logic;
    signal serial_cal_data  : std_logic_vector(15 downto 0);
    signal serial_cal_addr  : std_logic_vector(8 downto 0);

    signal serial_hv_init   : std_logic;
    signal serial_hv_data   : std_logic_vector(15 downto 0);
    signal serial_hv_addr   : std_logic_vector(8 downto 0);

    signal dcs_cal_init_reg : std_logic;
    signal syncd_cal_init   : std_logic;
    signal dcs_hv_init_reg  : std_logic;
    signal syncd_hv_init    : std_logic;
    
    signal serial_enable_fiber_clock    : std_logic;
    signal serial_enable_fiber_marker   : std_logic;
    signal serial_ewm_enable_50mhz      : std_logic;
    signal serial_force_full: std_logic;
    signal serial_use_lane  : std_logic_vector(3 downto 0);
    
begin

 -- added logic to deal with DIGI commands via DTC
    enable_fiber_clock  <=  dcs_enable_fiber_clock  when digirw_sel = '0'    else   serial_enable_fiber_clock;    
    enable_fiber_marker <=  dcs_enable_fiber_marker when digirw_sel = '0'    else   serial_enable_fiber_marker; 
    ewm_enable_50mhz    <=  dcs_ewm_enable_50mhz    when digirw_sel = '0'    else   serial_ewm_enable_50mhz;
    use_lane            <=  dcs_use_lane            when digirw_sel = '0'    else   serial_use_lane;
    force_full          <=  dcs_force_full          when digirw_sel = '0'    else   serial_force_full;
    
  -- Synchronize DTC signals for DIGI_RW on PCLK 
    p_DIGIRW : process (PRESETn, PCLK)
    begin
        if (PRESETn = '0') then
            
            syncd_cal_init  <= '0';
            syncd_hv_init   <= '0';
            
        elsif (PCLK'event and PCLK = '1') then
            
            dcs_cal_init_reg    <= dcs_cal_init;
            if  dcs_cal_init = '1' and dcs_cal_init_reg = '0'   then  
                syncd_cal_init  <= '1';
            else
                syncd_cal_init  <= '0';
            end if;
                
            dcs_hv_init_reg     <= dcs_hv_init;
            if  dcs_hv_init = '1' and dcs_hv_init_reg = '0'   then  
                syncd_hv_init  <= '1';
            else
                syncd_hv_init  <= '0';
            end if;

            cal_init        <= syncd_cal_init   when digirw_sel = '0'    else serial_cal_init;
            cal_data_in     <= dcs_cal_data     when digirw_sel = '0'    else serial_cal_data;
            cal_address_in  <= dcs_cal_addr     when digirw_sel = '0'    else serial_cal_addr;

            hv_init         <= syncd_hv_init    when digirw_sel = '0'    else serial_hv_init;
            hv_data_in      <= dcs_hv_data      when digirw_sel = '0'    else serial_hv_data;
            hv_address_in   <= dcs_hv_addr      when digirw_sel = '0'    else serial_hv_addr;
            
        end if;
    end process p_DIGIRW;
    

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
          DataOut(31 downto 0)  <= TIMERCOUNTER;
            
        when CRPRBS_LOCK =>
          DataOut(0)            <= PRBS_LOCK;
        when CRPRBS_ON =>
          DataOut(0)            <= PRBS_ON;
        when CRPRBS_ERRORCNT =>
          DataOut(31 downto 0)  <= PRBS_ERRORCNT;
            
        when CRDDR_TESTDIAG =>
          DataOut(3 downto 0) <= DDR_TEST_STATUS;
        when CRDDR_TESTERRCNT =>
          DataOut(31 downto 0) <= DDR_TEST_ERRCNT;
        when CRDDR_TESTERRLOC =>
          DataOut(31 downto 0) <= DDR_TEST_ERRLOC;
        when CRDDR_BLOCK_NO =>
          DataOut(31 downto 0) <= DDR_BLOCK_NO;
          
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
        when CR_ERROR_COUNTER =>
            DataOut(15 downto 0) <= error_counter;
            
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
        DDR_RESETN 		    <= '1';
        DTCALIGN_RESETN	    <= '1';
        DIGIDEVICE_RESETN	<= '1';
        TVS_RESETN		    <=	'1';
		
        INVERTCALSPICLCK  <= '0';
        
		PRBS_EN	 	      <= '0';
		PRBS_ERROROUT 	  <= '0';
		PRBS_ERRORCLR	  <= '0';
        
        DDR_WREN          <= '0';
        DDR_RDEN          <= '0';
        DDR_BLOCK_NO      <= x"0000_0000";
        
        DDRSERIALSET      <= '0';
        DDRPTTREN         <= '0';
        DDRCFOEN          <= '0';
        DDRCFOSTART       <= '0';
        DDRPREFETCHEN     <= '0';
        DDRERRREQ         <= b"00";
        DDRCFOOFFSET      <= (others => '0');  -- default TAG offset is zero
        DDRCFODELTAHB     <= x"0000_00FF";     -- default is 255*6.7 ns = 1.7 us
        DDRCFONUMBERHB    <= x"0000_0001";   
		
        DTCSIMSTART    <= '0';
        DTCSIMBLKEN    <= '0';
        DTCSIMPARAM    <= x"0000_0000";
        DTCSIMADDR     <= x"0000_0000";
        DTCSIMDATA     <= x"0000_0000";
        DTCSIMSPILLDATA<= x"0000_0000";
        DTCSIMBLKDATA  <= x"0000";
        DTCSIMBLKADDR  <= b"0000000";

        SERDES_RE   <= '0';
        serdes_re0  <= '0';
        serdes_re1  <= '0';
        serdes_re2  <= '0';
        serdes_re3  <= '0';
        --use_lane    <= b"0000";
        serial_use_lane <= b"0000";
      
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
      
        --cal_init <= '0';
        --hv_init <= '0';
        serial_cal_init <= '0';
        serial_hv_init <= '0';
        
        ewm_50mhz <= '0';
        --ewm_enable_50mhz <= '0';
        serial_ewm_enable_50mhz <= '0';
        use_uart <= '0';
      
        write_to_fifo <= '0';
        reset_fifo_n <= '1';
        dummy_status_address <= (others => '0');
        --force_full <= '0';
        serial_force_full <= '0';
        align_roc_to_digi <= '0';
      
        --enable_fiber_clock <= '0';
        --enable_fiber_marker <= '0';
        serial_enable_fiber_clock <= '0';
        serial_enable_fiber_marker <= '0';
      
        error_address <= (others => '0');
		
    elsif (PCLK'event and PCLK = '1') then
		DDR_RESETN  <= '1';
		
        SERDES_RE <= '0';
        serdes_re0 <= '0';
        serdes_re1 <= '0';
        serdes_re2 <= '0';
        serdes_re3 <= '0';
      
        --DIGI_RESET  <= '1';
        --reset_fifo_n <= '1';
     
        --cal_init <= '0';
        --hv_init <= '0';
        serial_cal_init <= '0';
        serial_hv_init <= '0';
        
        -- this are meant to be pulses 
        DTCSIMSTART    <= '0';
        DTCSIMBLKEN    <= '0';
        DDRCFOSTART    <= '0';
        
		PRBS_ERROROUT	<= '0';
		PRBS_ERRORCLR	<= '0';
        
        DDR_WREN        <= '0';        
        DDR_RDEN        <= '0';        

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
                
			when CRPRBS_EN =>
                PRBS_EN <= PWDATA(0);
			when CRPRBS_ERROROUT =>
                PRBS_ERROROUT   <= '1';
			when CRPRBS_ERRORCLR =>
                PRBS_ERRORCLR<= '1';
                
            when CRDDR_WREN =>
                DDR_WREN <= '1';
            when CRDDR_RDEN =>
                DDR_RDEN <= '1';
            when CRDDR_BLOCK_NO =>
                DDR_BLOCK_NO <= PWDATA(31 downto 0);
                
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
                --cal_init <= '1';
                serial_cal_init <= '1';
            when CRCALSPIADDRESS =>
                --cal_address_in <= PWDATA(8 downto 0);
                serial_cal_addr <= PWDATA(8 downto 0);
            when CRCALSPIDATA =>
                --cal_data_in <= PWDATA(15 downto 0);
                serial_cal_data <= PWDATA(15 downto 0);

            when CRHVSPIINIT =>
                --hv_init <= '1';
                serial_hv_init <= '1';
            when CRHVSPIADDRESS =>
                --hv_address_in <= PWDATA(8 downto 0);
                serial_hv_addr <= PWDATA(8 downto 0);
            when CRHVSPIDATA =>
                --hv_data_in <= PWDATA(15 downto 0);
                serial_hv_data <= PWDATA(15 downto 0);

            when CREWM =>
                ewm_50mhz <= PWDATA(0);
            when CREWMENABLE =>
                --ewm_enable_50mhz <= PWDATA(0);
                serial_ewm_enable_50mhz <= PWDATA(0);
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
                --use_lane   <= PWDATA(3 downto 0);
                serial_use_lane   <= PWDATA(3 downto 0);
            
            when CR_ENABLE_FIBER_CLOCK =>
                --enable_fiber_clock <= PWDATA(0);
                serial_enable_fiber_clock <= PWDATA(0);
            when CR_ENABLE_FIBER_MARKER =>
                --enable_fiber_marker <= PWDATA(0);
                serial_enable_fiber_marker <= PWDATA(0);
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
                --force_full <= PWDATA(0);
                serial_force_full <= PWDATA(0);
            when X"EE" =>
                align_roc_to_digi <= PWDATA(0);
            when X"ED" =>
                cal_serdes_reset_n <= PWDATA(0);
                hv_serdes_reset_n <= PWDATA(1);
                dtc_serdes_reset_n <= PWDATA(2);
            
            when CR_ERROR_ADDRESS =>
                error_address <= PWDATA(7 downto 0);
            when X"F0" =>
                event_window_expected <= PWDATA(15 downto 0);
            --when X"F1" =>
            when CR_USE_UART  =>
                use_uart <= PWDATA(0);
            when CR_DIGIRW_SEL =>
                digirw_sel <= PWDATA(0);
				            
            when others =>
        end case;
        end if;
    end if;
  end process p_reg_seq;




end synth;

