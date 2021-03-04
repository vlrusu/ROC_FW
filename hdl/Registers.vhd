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
    SERDES_RESET : out std_logic;
    SERDES_RDCNT : in std_logic_vector(16 downto 0);
    SERDES_HOWMANY : out std_logic_vector(12 downto 0);
    serdes_aligned : in std_logic_vector(3 downto 0);

    INVERTCALSPICLCK : out std_logic;
    ROCRESET         : out std_logic;

    DDRNHITS : out std_logic_vector(7 downto 0);
    DDRCS    : out std_logic;
    DDRWEN   : out std_logic;
    DDRREN   : out std_logic;
    DDRFIFOWEN : out std_logic;
    DDROFFSET: out std_logic_vector(31 downto 0);
    DDRIN    : out std_logic_vector(31 downto 0);
    DDRDIAG0 : in  std_logic_vector(31 downto 0);
    DDRDIAG1 : in  std_logic_vector(31 downto 0);
    DDRPATTRN: out  std_logic_vector(1 downto 0);
    DDRRAM   : in  std_logic_vector(31 downto 0);
    DDRISERR : in  std_logic;
    DDRERRLOC: in  std_logic_vector(31 downto 0);
    DDRPTTREN: out std_logic;

    DDRSEL      : out std_logic;
    DDRFULL     : in  std_logic;
    DDRFIFO_RE  : out std_logic;
    DDRSET      : out  std_logic;
    DDRPAGENO   : out std_logic_vector(31 downto 0);
    DDRPAGEWR   : in  std_logic_vector(31 downto 0);
    DDRPAGERD   : in  std_logic_vector(31 downto 0);

    DDRMEMFIFODATA0 : in  std_logic_vector(31 downto 0);
    DDRMEMFIFODATA1 : in  std_logic_vector(31 downto 0);
    DDRMEMFIFOFULL  : in  std_logic;
    DDRMEMFIFOEMPTY : in  std_logic;
    DDRTEMPFIFOFULL : in  std_logic;
    DDRTEMPFIFOEMPTY: in  std_logic;
    DDRMEMFIFO_RE   : out std_logic;

    DDRCONVRDCNT    : in std_logic_vector(16 downto 0);
    DDRCONVDATA     : in std_logic_vector(31 downto 0);

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

    tracker_clk : in std_logic;
    ewm : out std_logic;
    ewm_enable : out std_logic;
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

    ROCTVS_VAL  : in std_logic_vector(15 downto 0);
    ROCTVS_ADDR : out std_logic_vector(1 downto 0);
    
    enable_fiber_clock : out std_logic;
    enable_fiber_marker : out std_logic;

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


   constant CRROCRESET : std_logic_vector(7 downto 0) := x"10";
   constant CRTIMERENABLE : std_logic_vector(7 downto 0):= x"12";
   constant CRTIMERRESET : std_logic_vector(7 downto 0):= x"13";
   constant CRTIMERCOUNTER : std_logic_vector(7 downto 0):= x"14";
   

  ------------------------------------------------------------------------------
  --  Invert the spi clock for CAL, multiplexer enable
  ------------------------------------------------------------------------------
   constant CRINVERTCALSPICLCK : std_logic_vector(7 downto 0) := x"11";

-------------------------------------------------------------------------------
-- DDR signals as per Monica's email 12/10/2018
-------------------------------------------------------------------------------
   constant CRDDRNHITS : std_logic_vector(7 downto 0) := x"20";  -- a 8-bit register to set up the number of hits to be written/read from memory

   constant CRDDROFFSET: std_logic_vector(7 downto 0) := x"21";  -- 25-bit memory address offset (to cover the 0x1000_0000 address space reserved for the DDR3 memory in multiple of  0x8, as to not cross the boundary of a single hit)
   constant CRDDRCS    : std_logic_vector(7 downto 0) := x"22";  -- 1-bit chip select (to decide if we are writing to memory or to FIFO - in reality an SRAM)
   constant CRDDRWEN   : std_logic_vector(7 downto 0) := x"23";  -- a WR_EN that has to be set high and low by hand
   constant CRDDRREN   : std_logic_vector(7 downto 0) := x"24";  -- a RD_EN that has to be set high and low by hand
   constant CRDDRFIFOWEN : std_logic_vector(7 downto 0) := x"25";  -- a DMA_EN to transfer data from FIFO to  memory that has to be set high and low by hand
   constant CRDDRDIAG0 : std_logic_vector(7 downto 0) := x"26";  -- a 32-bit diagnostic input from DDR
   constant CRDDRIN    : std_logic_vector(7 downto 0) := x"27";  -- a 32-bit register driven to DDR (set offset in DDR memory address)
   constant CRDDRDIAG1 : std_logic_vector(7 downto 0) := x"28";  -- another 32-bit diagnostic input from DDR
   constant CRDDRRPATTRN: std_logic_vector(7 downto 0):= x"29";  -- 2-bit to specify test patter: 0=> ++1, 1=> --1, 2=> 5's, 3=> A's
   constant CRDDRRAM   : std_logic_vector(7 downto 0) := x"2A";  -- 32-bit diagnostic input from RAM inside pattern generator
   constant CRDDRISERR : std_logic_vector(7 downto 0) := x"2B";  -- 32-bit diagnostic input from RAM inside pattern generator
   constant CRDDRERRLOC: std_logic_vector(7 downto 0) := x"2C";  -- 32-bit diagnostic input from RAM inside pattern generator
   constant CRDDRPTTREN: std_logic_vector(7 downto 0) := x"2D";  -- a WR_EN that has to be set high and low by hand

   constant CRDDRSEL   : std_logic_vector(7 downto 0) := x"30";   -- 1-bit serial readout select (1 => DIGIFIFO readout via DDR3, 0 => DIGIFIFO readout directly)
   constant CRDDRFULL  : std_logic_vector(7 downto 0) := x"31";   --  DDR3 full flag: if 1, DDRPAGENO have been written to memory. When DDRPAGENO have been readout, goes back to 0 
   constant CRDDRFIFORE: std_logic_vector(7 downto 0) := x"32";   --  start reading 1KB page of DDR3 memory 
   constant CRDDRSET   : std_logic_vector(7 downto 0):= x"33"; --  if 1, clean DIGIFIFO content at the end of DDR readout; 
                                                                  --  if 0, DIGIFIFO data collected during DDR readout is kept
   constant CRDDRPAGENO: std_logic_vector(7 downto 0) := x"34";   --  how many 1KB pages of DIGIFIFO we want to write to DDR3: max is 2Gb/1KB = 2**18-1 = 262143 
   constant CRDDRPAGEWR: std_logic_vector(7 downto 0) := x"35";   --  how many 1KB pages have been written to DDR3
   constant CRDDRPAGERD: std_logic_vector(7 downto 0) := x"36";   --  how many 1KB pages have been read from DDR3
   constant CRDDRMEMFIFODATA0  : std_logic_vector(7 downto 0) := x"37";
   constant CRDDRMEMFIFODATA1  : std_logic_vector(7 downto 0) := x"38";
   constant CRDDRMEMFIFOFULL    : std_logic_vector(7 downto 0) := x"39";
   constant CRDDRMEMFIFOEMPTY   : std_logic_vector(7 downto 0) := x"3A";
   constant CRDDRMEMFIFORE      : std_logic_vector(7 downto 0) := x"3B";
   constant CRDDRTEMPFIFOFULL   : std_logic_vector(7 downto 0) := x"3C"; 
   constant CRDDRTEMPFIFOEMPTY  : std_logic_vector(7 downto 0) := x"3D"; 
   constant CRDDRCONVDATA       : std_logic_vector(7 downto 0) := x"3E";  -- DATA out of DIGIFIFO or PATTERN_FIFO
   constant CRDDRCONVRDCNT      : std_logic_vector(7 downto 0) := x"3F"; -- RDCNT out of DIGIFIFO or PATTERN_FIFO

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
-- -DT SIMULATION signals: Monica added 08/22/2020 
------------------------------------------------------------------------------ 
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

  -------------------------------------------------------------------------------
  -- Signal declarations
  -------------------------------------------------------------------------------
  signal DataOut            : std_logic_vector(APB_DATA_WIDTH-1 downto 0);
    signal ewm_50mhz : std_logic;
    signal ewm_1Q : std_logic;
    signal ewm_2Q : std_logic;
    signal ewm_3Q : std_logic;
    signal ewm_enable_50mhz : std_logic;
    signal ewm_enable_1Q : std_logic;
    signal ewm_enable_2Q : std_logic;
    signal ewm_enable_3Q : std_logic;

   component TWIMaster
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

    --component SPIMaster
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

     --calSPIMaster : SPIMaster
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
     --hvSPIMaster : SPIMaster
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


    hvTWIMaster_0 : TWIMaster
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

  calTWIMaster_0 : TWIMaster
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

    process (tracker_clk)
    begin
    if rising_edge(tracker_clk) then
        ewm_1Q <= ewm_50mhz;
        ewm_2Q <= ewm_1Q;
        ewm_3Q <= ewm_2Q;
        ewm_enable_1Q <= ewm_enable_50mhz;
        ewm_enable_2Q <= ewm_enable_1Q;
    end if;
    end process;

    ewm <= (ewm_2Q and not ewm_3Q);
    ewm_enable <= ewm_enable_2Q;



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

        when CRDDRDIAG0 =>
          DataOut(31 downto 0) <= DDRDIAG0;
        when CRDDRDIAG1 =>
          DataOut(31 downto 0) <= DDRDIAG1;
        when CRDDRRAM =>
          DataOut(31 downto 0) <= DDRRAM;
        when CRDDRISERR =>
          DataOut(0)    <= DDRISERR;
        when CRDDRERRLOC =>
          DataOut(31 downto 0) <= DDRERRLOC;

        when CRDDRFULL =>
          DataOut(0) <= DDRFULL;
        when CRDDRPAGEWR =>
          DataOut(31 downto 0) <= DDRPAGEWR;
        when CRDDRPAGERD =>
          DataOut(31 downto 0) <= DDRPAGERD;

        when CRDDRMEMFIFOFULL =>
          DataOut(0) <= DDRMEMFIFOFULL;
        when CRDDRMEMFIFOEMPTY =>
          DataOut(0) <= DDRMEMFIFOEMPTY;
        when CRDDRMEMFIFODATA0 =>
          DataOut(31 downto 0) <= DDRMEMFIFODATA0;
        when CRDDRMEMFIFODATA1 =>
          DataOut(31 downto 0) <= DDRMEMFIFODATA1;
        when CRDDRTEMPFIFOFULL =>
          DataOut(0) <= DDRTEMPFIFOFULL;
        when CRDDRTEMPFIFOEMPTY =>
          DataOut(0) <= DDRTEMPFIFOEMPTY;

        when CRDDRCONVDATA =>
          DataOut(31 downto 0) <= DDRCONVDATA;
        when CRDDRCONVRDCNT =>
          DataOut(16 downto 0) <= DDRCONVRDCNT;

        when CRDTCDATAREAD =>
          DataOut(31 downto 0) <= DTCDATAREAD;
          
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
      ROCRESET <= '1';

      INVERTCALSPICLCK  <= '0';
      DDRCS             <= '0';
      DDRWEN            <= '0';
      DDRREN            <= '0';
      DDRFIFOWEN        <= '0';
      DDRSEL            <= '0';
      DDRSET            <= '0';
      DDRPTTREN         <= '0';
      DDRFIFO_RE        <= '0';
      DDRMEMFIFO_RE     <= '0';
      DDRPAGENO         <= x"0000_0000"; 
      DDROFFSET         <= x"0000_0000"; 
      DDRNHITS          <= x"01"; 
      DDRPATTRN         <= b"00";
      DDRIN             <= x"0000_0000";

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
      
      SERDES_RESET <= '1';
      
      cal_init <= '0';
      hv_init <= '0';
      ewm_50mhz <= '0';
      ewm_enable_50mhz <= '0';
      
      write_to_fifo <= '0';
      reset_fifo_n <= '1';
      dummy_status_address <= (others => '0');
      
      enable_fiber_clock <= '0';
      enable_fiber_marker <= '0';

    elsif (PCLK'event and PCLK = '1') then
      --ROCRESET  <= '1';

      SERDES_RE <= '0';
      serdes_re0 <= '0';
      serdes_re1 <= '0';
      serdes_re2 <= '0';
      serdes_re3 <= '0';
      
      SERDES_RESET  <= '1';
      --reset_fifo_n <= '1';
     
      cal_init  <= '0';
      hv_init   <= '0';
	  
      DDRWEN        <= '0';
      DDRREN        <= '0';
      DDRFIFOWEN    <= '0';
      DDRFIFO_RE    <= '0';
      --DDRMEMFIFO_RE <= '0';

      DTCSIMSTART    <= '0';
      DTCSIMBLKEN    <= '0';
      
      if (PWRITE = '1' and PSEL = '1' and PENABLE = '1') then
        case PADDR(9 downto 2) is


          when CRROCRESET =>
            ROCRESET <= PWDATA(0);
          when CRINVERTCALSPICLCK =>
            INVERTCALSPICLCK <= PWDATA(0);
    
          when CRTIMERRESET =>
            TIMERRESET<=PWDATA(0);

          when CRTIMERENABLE =>
            TIMERENABLE <= PWDATA(0);


          when CRDDRNHITS =>
            DDRNHITS <= PWDATA(7 downto 0);
          when CRDDROFFSET =>
            DDROFFSET <= PWDATA(31 downto 0);
          when CRDDRPAGENO =>
            DDRPAGENO <= PWDATA(31 downto 0);
          when CRDDRIN =>
            DDRIN <= PWDATA(31 downto 0);
          when CRDDRRPATTRN =>
            DDRPATTRN <= PWDATA(1 downto 0);
          when CRDDRPTTREN =>
            DDRPTTREN <= PWDATA(0);

          when CRDDRCS =>
            DDRCS <= PWDATA(0);
          when CRDDRWEN =>
            DDRWEN <= '1';
          when CRDDRREN =>
            DDRREN <= '1';
          when CRDDRFIFOWEN =>
            DDRFIFOWEN <= '1';
          when CRDDRSEL =>
            DDRSEL <= PWDATA(0);
          when CRDDRSET =>
            DDRSET <= PWDATA(0);

          when CRDDRFIFORE =>
            DDRFIFO_RE <= '1';
          when CRDDRMEMFIFORE =>
--            DDRMEMFIFO_RE <= '1';
            DDRMEMFIFO_RE <= PWDATA(0);
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
            SERDES_RESET <= '0';
         
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
            
          when others =>
        end case;
      end if;
    end if;
  end process p_reg_seq;




end synth;

