----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:23:41 2023
-- Version: 2022.3 2022.3.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- SLOWCONTROLS entity declaration
----------------------------------------------------------------------
entity SLOWCONTROLS is
    -- Port list
    port(
        -- Inputs
        CAL_PREAMP_MISO        : in    std_logic;
        DDRCTRLREADY           : in    std_logic;
        DDRDREQCNT             : in    std_logic_vector(31 downto 0);
        DDRDREQNULL            : in    std_logic_vector(31 downto 0);
        DDRDREQREAD            : in    std_logic_vector(31 downto 0);
        DDRDREQSENT            : in    std_logic_vector(31 downto 0);
        DDRDREQTAG             : in    std_logic_vector(31 downto 0);
        DDRERROR               : in    std_logic_vector(3 downto 0);
        DDRFETCHTAG            : in    std_logic_vector(31 downto 0);
        DDRHBCNT               : in    std_logic_vector(31 downto 0);
        DDRHBONHOLD            : in    std_logic_vector(31 downto 0);
        DDRHBTAG               : in    std_logic_vector(31 downto 0);
        DDRNULLHBCNT           : in    std_logic_vector(31 downto 0);
        DDROFFSETTAG           : in    std_logic_vector(31 downto 0);
        DDRPREFCNT             : in    std_logic_vector(31 downto 0);
        DDRPRETAG              : in    std_logic_vector(31 downto 0);
        DDRSIZERD              : in    std_logic_vector(31 downto 0);
        DDRSIZEWR              : in    std_logic_vector(31 downto 0);
        DDRSPILLCNT            : in    std_logic_vector(19 downto 0);
        DTCDATAREAD            : in    std_logic_vector(31 downto 0);
        HV_PREAMP_MISO         : in    std_logic;
        PADDR                  : in    std_logic_vector(31 downto 0);
        PCLK                   : in    std_logic;
        PENABLE                : in    std_logic;
        PRESETN                : in    std_logic;
        PSEL                   : in    std_logic;
        PWDATA                 : in    std_logic_vector(31 downto 0);
        PWRITE                 : in    std_logic;
        RX                     : in    std_logic;
        SERDES_DATA            : in    std_logic_vector(31 downto 0);
        SERDES_EMPTY           : in    std_logic;
        SERDES_FULL            : in    std_logic;
        SERDES_RDCNT           : in    std_logic_vector(16 downto 0);
        SPI0_MISO              : in    std_logic;
        SPI1_MISO              : in    std_logic;
        SPI2_MISO              : in    std_logic;
        cal_lane0_aligned      : in    std_logic;
        cal_lane0_alignment    : in    std_logic_vector(3 downto 0);
        cal_lane0_error_count  : in    std_logic_vector(7 downto 0);
        cal_lane1_aligned      : in    std_logic;
        cal_lane1_alignment    : in    std_logic_vector(3 downto 0);
        cal_lane1_error_count  : in    std_logic_vector(7 downto 0);
        data_expc              : in    std_logic_vector(63 downto 0);
        data_seen              : in    std_logic_vector(63 downto 0);
        dtc_error_counter      : in    std_logic_vector(15 downto 0);
        dummy_status_out0      : in    std_logic_vector(7 downto 0);
        dummy_status_out1      : in    std_logic_vector(7 downto 0);
        dummy_status_out2      : in    std_logic_vector(7 downto 0);
        dummy_status_out3      : in    std_logic_vector(7 downto 0);
        evt_expc               : in    std_logic_vector(63 downto 0);
        evt_seen               : in    std_logic_vector(63 downto 0);
        hdr1_expc              : in    std_logic_vector(63 downto 0);
        hdr1_seen              : in    std_logic_vector(63 downto 0);
        hdr2_expc              : in    std_logic_vector(63 downto 0);
        hdr2_seen              : in    std_logic_vector(63 downto 0);
        hv_lane0_aligned       : in    std_logic;
        hv_lane0_alignment     : in    std_logic_vector(3 downto 0);
        hv_lane0_error_count   : in    std_logic_vector(7 downto 0);
        hv_lane1_aligned       : in    std_logic;
        hv_lane1_alignment     : in    std_logic_vector(3 downto 0);
        hv_lane1_error_count   : in    std_logic_vector(7 downto 0);
        remote_token0          : in    std_logic_vector(7 downto 0);
        remote_token1          : in    std_logic_vector(7 downto 0);
        remote_token2          : in    std_logic_vector(7 downto 0);
        remote_token3          : in    std_logic_vector(7 downto 0);
        serdes_aligned         : in    std_logic_vector(3 downto 0);
        serdes_data0           : in    std_logic_vector(31 downto 0);
        serdes_data1           : in    std_logic_vector(31 downto 0);
        serdes_data2           : in    std_logic_vector(31 downto 0);
        serdes_data3           : in    std_logic_vector(31 downto 0);
        serdes_rdcnt0          : in    std_logic_vector(12 downto 0);
        serdes_rdcnt1          : in    std_logic_vector(12 downto 0);
        serdes_rdcnt2          : in    std_logic_vector(12 downto 0);
        serdes_rdcnt3          : in    std_logic_vector(12 downto 0);
        -- Outputs
        CAL_PREAMP_CE0n        : out   std_logic;
        CAL_PREAMP_CE1n        : out   std_logic;
        CAL_PREAMP_MOSI        : out   std_logic;
        CAL_PREAMP_SCLK        : out   std_logic;
        DDRCFODELTAHB          : out   std_logic_vector(31 downto 0);
        DDRCFOEN               : out   std_logic;
        DDRCFONUMBERHB         : out   std_logic_vector(31 downto 0);
        DDRCFOOFFSET           : out   std_logic_vector(31 downto 0);
        DDRCFOSTART            : out   std_logic;
        DDRPREFETCHEN          : out   std_logic;
        DDRPTTREN              : out   std_logic;
        DDRSERIALSET           : out   std_logic;
        DDR_RESETN             : out   std_logic;
        DIGIDEVICE_RESETN      : out   std_logic;
        DTCALIGN_RESETN        : out   std_logic;
        DTCSIMADDR             : out   std_logic_vector(31 downto 0);
        DTCSIMBLKADDR          : out   std_logic_vector(6 downto 0);
        DTCSIMBLKDATA          : out   std_logic_vector(15 downto 0);
        DTCSIMBLKEN            : out   std_logic;
        DTCSIMDATA             : out   std_logic_vector(31 downto 0);
        DTCSIMPARAM            : out   std_logic_vector(31 downto 0);
        DTCSIMSPILLDATA        : out   std_logic_vector(31 downto 0);
        DTCSIMSTART            : out   std_logic;
        GPIO_OUT               : out   std_logic_vector(3 downto 0);
        HV_PREAMP_CE0n         : out   std_logic;
        HV_PREAMP_CE1n         : out   std_logic;
        HV_PREAMP_MOSI         : out   std_logic;
        HV_PREAMP_SCLK         : out   std_logic;
        PRDATA                 : out   std_logic_vector(31 downto 0);
        PREADY                 : out   std_logic;
        PSLVERR                : out   std_logic;
        PWM0                   : out   std_logic;
        SENSOR_MCP_CEn         : out   std_logic;
        SERDES_HOWMANY         : out   std_logic_vector(12 downto 0);
        SERDES_RE              : out   std_logic;
        SPI0_ADC0_CEn          : out   std_logic;
        SPI0_ADC1_CEn          : out   std_logic;
        SPI0_ADC2_CEn          : out   std_logic;
        SPI0_MOSI              : out   std_logic;
        SPI0_SCLK              : out   std_logic;
        SPI1_ADC0_CEn          : out   std_logic;
        SPI1_ADC1_CEn          : out   std_logic;
        SPI1_ADC2_CEn          : out   std_logic;
        SPI1_MOSI              : out   std_logic;
        SPI1_SCLK              : out   std_logic;
        SPI2_ADC0_CEn          : out   std_logic;
        SPI2_MOSI              : out   std_logic;
        SPI2_SCLK              : out   std_logic;
        TX                     : out   std_logic;
        align_roc_to_digi      : out   std_logic;
        cal_lane0_pcs_reset_n  : out   std_logic;
        cal_lane0_pma_reset_n  : out   std_logic;
        cal_lane1_pcs_reset_n  : out   std_logic;
        cal_lane1_pma_reset_n  : out   std_logic;
        cal_serdes_reset_n     : out   std_logic;
        calscl                 : out   std_logic;
        dtc_enable_reset       : out   std_logic;
        dtc_error_address      : out   std_logic_vector(7 downto 0);
        dtc_serdes_reset_n     : out   std_logic;
        dummy_status_address   : out   std_logic_vector(3 downto 0);
        enable_fiber_clock     : out   std_logic;
        enable_fiber_marker    : out   std_logic;
        event_window_early_cut : out   std_logic_vector(15 downto 0);
        event_window_expected  : out   std_logic_vector(15 downto 0);
        event_window_late_cut  : out   std_logic_vector(15 downto 0);
        ewm_50mhz              : out   std_logic;
        ewm_delay              : out   std_logic_vector(15 downto 0);
        ewm_enable_50mhz       : out   std_logic;
        force_full             : out   std_logic;
        hv_lane0_pcs_reset_n   : out   std_logic;
        hv_lane0_pma_reset_n   : out   std_logic;
        hv_lane1_pcs_reset_n   : out   std_logic;
        hv_lane1_pma_reset_n   : out   std_logic;
        hv_serdes_reset_n      : out   std_logic;
        hvscl                  : out   std_logic;
        reset_fifo_n           : out   std_logic;
        serdes_re0             : out   std_logic;
        serdes_re1             : out   std_logic;
        serdes_re2             : out   std_logic;
        serdes_re3             : out   std_logic;
        use_lane               : out   std_logic_vector(3 downto 0);
        use_uart               : out   std_logic;
        write_to_fifo          : out   std_logic;
        -- Inouts
        calsda                 : inout std_logic;
        hvsda                  : inout std_logic
        );
end SLOWCONTROLS;
----------------------------------------------------------------------
-- SLOWCONTROLS architecture body
----------------------------------------------------------------------
architecture RTL of SLOWCONTROLS is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AND2
component AND2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- APB3
component APB3
    -- Port list
    port(
        -- Inputs
        PADDR     : in  std_logic_vector(31 downto 0);
        PENABLE   : in  std_logic;
        PRDATAS0  : in  std_logic_vector(31 downto 0);
        PRDATAS1  : in  std_logic_vector(31 downto 0);
        PRDATAS2  : in  std_logic_vector(31 downto 0);
        PRDATAS3  : in  std_logic_vector(31 downto 0);
        PRDATAS4  : in  std_logic_vector(31 downto 0);
        PRDATAS5  : in  std_logic_vector(31 downto 0);
        PRDATAS6  : in  std_logic_vector(31 downto 0);
        PRDATAS7  : in  std_logic_vector(31 downto 0);
        PRDATAS8  : in  std_logic_vector(31 downto 0);
        PRDATAS9  : in  std_logic_vector(31 downto 0);
        PREADYS0  : in  std_logic;
        PREADYS1  : in  std_logic;
        PREADYS2  : in  std_logic;
        PREADYS3  : in  std_logic;
        PREADYS4  : in  std_logic;
        PREADYS5  : in  std_logic;
        PREADYS6  : in  std_logic;
        PREADYS7  : in  std_logic;
        PREADYS8  : in  std_logic;
        PREADYS9  : in  std_logic;
        PSEL      : in  std_logic;
        PSLVERRS0 : in  std_logic;
        PSLVERRS1 : in  std_logic;
        PSLVERRS2 : in  std_logic;
        PSLVERRS3 : in  std_logic;
        PSLVERRS4 : in  std_logic;
        PSLVERRS5 : in  std_logic;
        PSLVERRS6 : in  std_logic;
        PSLVERRS7 : in  std_logic;
        PSLVERRS8 : in  std_logic;
        PSLVERRS9 : in  std_logic;
        PWDATA    : in  std_logic_vector(31 downto 0);
        PWRITE    : in  std_logic;
        -- Outputs
        PADDRS    : out std_logic_vector(31 downto 0);
        PENABLES  : out std_logic;
        PRDATA    : out std_logic_vector(31 downto 0);
        PREADY    : out std_logic;
        PSELS0    : out std_logic;
        PSELS1    : out std_logic;
        PSELS2    : out std_logic;
        PSELS3    : out std_logic;
        PSELS4    : out std_logic;
        PSELS5    : out std_logic;
        PSELS6    : out std_logic;
        PSELS7    : out std_logic;
        PSELS8    : out std_logic;
        PSELS9    : out std_logic;
        PSLVERR   : out std_logic;
        PWDATAS   : out std_logic_vector(31 downto 0);
        PWRITES   : out std_logic
        );
end component;
-- counter32
component counter32
    -- Port list
    port(
        -- Inputs
        clk   : in  std_logic;
        en    : in  std_logic;
        rst_n : in  std_logic;
        -- Outputs
        cnt   : out std_logic_vector(31 downto 0)
        );
end component;
-- GPIO
component GPIO
    -- Port list
    port(
        -- Inputs
        GPIO_IN  : in  std_logic_vector(3 downto 0);
        PADDR    : in  std_logic_vector(7 downto 0);
        PCLK     : in  std_logic;
        PENABLE  : in  std_logic;
        PRESETN  : in  std_logic;
        PSEL     : in  std_logic;
        PWDATA   : in  std_logic_vector(31 downto 0);
        PWRITE   : in  std_logic;
        -- Outputs
        GPIO_OUT : out std_logic_vector(3 downto 0);
        INT      : out std_logic_vector(3 downto 0);
        PRDATA   : out std_logic_vector(31 downto 0);
        PREADY   : out std_logic;
        PSLVERR  : out std_logic
        );
end component;
-- INV
component INV
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- MX2
component MX2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        S : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- pattern_err_switch
component pattern_err_switch
    -- Port list
    port(
        -- Inputs
        data_expc : in  std_logic_vector(63 downto 0);
        data_seen : in  std_logic_vector(63 downto 0);
        err_en    : in  std_logic_vector(1 downto 0);
        evt_expc  : in  std_logic_vector(63 downto 0);
        evt_seen  : in  std_logic_vector(63 downto 0);
        hdr1_expc : in  std_logic_vector(63 downto 0);
        hdr1_seen : in  std_logic_vector(63 downto 0);
        hdr2_expc : in  std_logic_vector(63 downto 0);
        hdr2_seen : in  std_logic_vector(63 downto 0);
        -- Outputs
        err_expc  : out std_logic_vector(63 downto 0);
        err_seen  : out std_logic_vector(63 downto 0)
        );
end component;
-- PF_SYSTEM_SERVICES_C0
component PF_SYSTEM_SERVICES_C0
    -- Port list
    port(
        -- Inputs
        APBS_PADDR       : in  std_logic_vector(31 downto 0);
        APBS_PENABLE     : in  std_logic;
        APBS_PSEL        : in  std_logic;
        APBS_PWDATA      : in  std_logic_vector(31 downto 0);
        APBS_PWRITE      : in  std_logic;
        CLK              : in  std_logic;
        RESETN           : in  std_logic;
        -- Outputs
        APBS_PRDATA      : out std_logic_vector(31 downto 0);
        APBS_PREADY      : out std_logic;
        APBS_PSLVERR     : out std_logic;
        SS_BUSY          : out std_logic;
        SYSSERV_INIT_REQ : out std_logic;
        USR_BUSY         : out std_logic;
        USR_CMD_ERROR    : out std_logic;
        USR_RDVLD        : out std_logic
        );
end component;
-- PREAMPSPI
component PREAMPSPI
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(31 downto 0);
        PREADY     : out std_logic;
        PSLVERR    : out std_logic;
        SPIINT     : out std_logic;
        SPIMODE    : out std_logic;
        SPIOEN     : out std_logic;
        SPIRXAVAIL : out std_logic;
        SPISCLKO   : out std_logic;
        SPISDO     : out std_logic;
        SPISS      : out std_logic_vector(7 downto 0);
        SPITXRFM   : out std_logic
        );
end component;
-- pwm
component pwm
    -- Port list
    port(
        -- Inputs
        PADDR   : in  std_logic_vector(7 downto 0);
        PCLK    : in  std_logic;
        PENABLE : in  std_logic;
        PRESETN : in  std_logic;
        PSEL    : in  std_logic;
        PWDATA  : in  std_logic_vector(31 downto 0);
        PWRITE  : in  std_logic;
        -- Outputs
        PRDATA  : out std_logic_vector(31 downto 0);
        PREADY  : out std_logic;
        PSLVERR : out std_logic;
        PWM     : out std_logic_vector(1 downto 0)
        );
end component;
-- Registers
-- using entity instantiation for component Registers
-- SPI0
component SPI0
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(31 downto 0);
        PREADY     : out std_logic;
        PSLVERR    : out std_logic;
        SPIINT     : out std_logic;
        SPIMODE    : out std_logic;
        SPIOEN     : out std_logic;
        SPIRXAVAIL : out std_logic;
        SPISCLKO   : out std_logic;
        SPISDO     : out std_logic;
        SPISS      : out std_logic_vector(7 downto 0);
        SPITXRFM   : out std_logic
        );
end component;
-- SPI_KEY
component SPI_KEY
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(31 downto 0);
        PREADY     : out std_logic;
        PSLVERR    : out std_logic;
        SPIINT     : out std_logic;
        SPIMODE    : out std_logic;
        SPIOEN     : out std_logic;
        SPIRXAVAIL : out std_logic;
        SPISCLKO   : out std_logic;
        SPISDO     : out std_logic;
        SPISS      : out std_logic_vector(7 downto 0);
        SPITXRFM   : out std_logic
        );
end component;
-- TVS_Interface
component TVS_Interface
    -- Port list
    port(
        -- Inputs
        R_ADDR   : in  std_logic_vector(1 downto 0);
        R_CLK    : in  std_logic;
        clk      : in  std_logic;
        resetn_i : in  std_logic;
        -- Outputs
        R_DATA   : out std_logic_vector(15 downto 0)
        );
end component;
-- UARTapb
component UARTapb
    -- Port list
    port(
        -- Inputs
        PADDR       : in  std_logic_vector(4 downto 0);
        PCLK        : in  std_logic;
        PENABLE     : in  std_logic;
        PRESETN     : in  std_logic;
        PSEL        : in  std_logic;
        PWDATA      : in  std_logic_vector(7 downto 0);
        PWRITE      : in  std_logic;
        RX          : in  std_logic;
        -- Outputs
        FRAMING_ERR : out std_logic;
        OVERFLOW    : out std_logic;
        PARITY_ERR  : out std_logic;
        PRDATA      : out std_logic_vector(7 downto 0);
        PREADY      : out std_logic;
        PSLVERR     : out std_logic;
        RXRDY       : out std_logic;
        TX          : out std_logic;
        TXRDY       : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal align_roc_to_digi_net_0       : std_logic;
signal AND2_0_Y                      : std_logic;
signal APB3_0_APBmslave0_PENABLE     : std_logic;
signal APB3_0_APBmslave0_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave0_PREADY      : std_logic;
signal APB3_0_APBmslave0_PSELx       : std_logic;
signal APB3_0_APBmslave0_PSLVERR     : std_logic;
signal APB3_0_APBmslave0_PWRITE      : std_logic;
signal APB3_0_APBmslave1_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave1_PREADY      : std_logic;
signal APB3_0_APBmslave1_PSELx       : std_logic;
signal APB3_0_APBmslave1_PSLVERR     : std_logic;
signal APB3_0_APBmslave2_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave2_PREADY      : std_logic;
signal APB3_0_APBmslave2_PSELx       : std_logic;
signal APB3_0_APBmslave2_PSLVERR     : std_logic;
signal APB3_0_APBmslave3_PREADY      : std_logic;
signal APB3_0_APBmslave3_PSELx       : std_logic;
signal APB3_0_APBmslave3_PSLVERR     : std_logic;
signal APB3_0_APBmslave4_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave4_PREADY      : std_logic;
signal APB3_0_APBmslave4_PSELx       : std_logic;
signal APB3_0_APBmslave4_PSLVERR     : std_logic;
signal APB3_0_APBmslave5_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave5_PREADY      : std_logic;
signal APB3_0_APBmslave5_PSELx       : std_logic;
signal APB3_0_APBmslave5_PSLVERR     : std_logic;
signal APB3_0_APBmslave6_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave6_PREADY      : std_logic;
signal APB3_0_APBmslave6_PSELx       : std_logic;
signal APB3_0_APBmslave6_PSLVERR     : std_logic;
signal APB3_0_APBmslave7_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave7_PREADY      : std_logic;
signal APB3_0_APBmslave7_PSELx       : std_logic;
signal APB3_0_APBmslave7_PSLVERR     : std_logic;
signal APB3_0_APBmslave8_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave8_PREADY      : std_logic;
signal APB3_0_APBmslave8_PSELx       : std_logic;
signal APB3_0_APBmslave8_PSLVERR     : std_logic;
signal APB3_0_APBmslave9_PRDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave9_PREADY      : std_logic;
signal APB3_0_APBmslave9_PSELx       : std_logic;
signal APB3_0_APBmslave9_PSLVERR     : std_logic;
signal APB3mmaster_PRDATA            : std_logic_vector(31 downto 0);
signal APB3mmaster_PREADY            : std_logic;
signal APB3mmaster_PSLVERR           : std_logic;
signal cal_lane0_pcs_reset_n_net_0   : std_logic;
signal cal_lane0_pma_reset_n_net_0   : std_logic;
signal cal_lane1_pcs_reset_n_net_0   : std_logic;
signal cal_lane1_pma_reset_n_net_0   : std_logic;
signal CAL_PREAMP_CE0n_net_0         : std_logic_vector(0 to 0);
signal CAL_PREAMP_CE1n_net_0         : std_logic_vector(1 to 1);
signal CAL_PREAMP_MOSI_net_0         : std_logic;
signal CAL_PREAMP_SCLK_net_0         : std_logic;
signal cal_serdes_reset_n_net_0      : std_logic;
signal calscl_net_0                  : std_logic;
signal counter32_0_cnt               : std_logic_vector(31 downto 0);
signal DDR_RESETN_net_0              : std_logic;
signal DDRCFODELTAHB_net_0           : std_logic_vector(31 downto 0);
signal DDRCFOEN_net_0                : std_logic;
signal DDRCFONUMBERHB_net_0          : std_logic_vector(31 downto 0);
signal DDRCFOOFFSET_net_0            : std_logic_vector(31 downto 0);
signal DDRCFOSTART_net_0             : std_logic;
signal DDRPREFETCHEN_net_0           : std_logic;
signal DDRPTTREN_net_0               : std_logic;
signal DDRSERIALSET_net_0            : std_logic;
signal DIGIDEVICE_RESETN_net_0       : std_logic;
signal dtc_enable_reset_net_0        : std_logic;
signal dtc_error_address_net_0       : std_logic_vector(7 downto 0);
signal dtc_serdes_reset_n_net_0      : std_logic;
signal DTCALIGN_RESETN_net_0         : std_logic;
signal DTCSIMADDR_net_0              : std_logic_vector(31 downto 0);
signal DTCSIMBLKADDR_net_0           : std_logic_vector(6 downto 0);
signal DTCSIMBLKDATA_net_0           : std_logic_vector(15 downto 0);
signal DTCSIMBLKEN_net_0             : std_logic;
signal DTCSIMDATA_net_0              : std_logic_vector(31 downto 0);
signal DTCSIMPARAM_net_0             : std_logic_vector(31 downto 0);
signal DTCSIMSPILLDATA_net_0         : std_logic_vector(31 downto 0);
signal DTCSIMSTART_net_0             : std_logic;
signal dummy_status_address_net_0    : std_logic_vector(3 downto 0);
signal enable_fiber_clock_net_0      : std_logic;
signal enable_fiber_marker_net_0     : std_logic;
signal event_window_early_cut_net_0  : std_logic_vector(15 downto 0);
signal event_window_expected_net_0   : std_logic_vector(15 downto 0);
signal event_window_late_cut_net_0   : std_logic_vector(15 downto 0);
signal ewm_50mhz_net_0               : std_logic;
signal ewm_delay_net_0               : std_logic_vector(15 downto 0);
signal ewm_enable_50mhz_net_0        : std_logic;
signal force_full_net_0              : std_logic;
signal GPIO_OUT_net_0                : std_logic_vector(3 downto 0);
signal hv_lane0_pcs_reset_n_net_0    : std_logic;
signal hv_lane0_pma_reset_n_net_0    : std_logic;
signal hv_lane1_pcs_reset_n_net_0    : std_logic;
signal hv_lane1_pma_reset_n_net_0    : std_logic;
signal HV_PREAMP_CE0n_net_0          : std_logic_vector(0 to 0);
signal HV_PREAMP_CE1n_net_0          : std_logic_vector(1 to 1);
signal HV_PREAMP_MOSI_net_0          : std_logic;
signal HV_PREAMP_SCLK_net_0          : std_logic;
signal hv_serdes_reset_n_net_0       : std_logic;
signal hvscl_net_0                   : std_logic;
signal INV_0_Y                       : std_logic;
signal pattern_err_switch_0_err_expc : std_logic_vector(63 downto 0);
signal pattern_err_switch_0_err_seen : std_logic_vector(63 downto 0);
signal PREAMPSPI_1_SPISCLKO          : std_logic;
signal PWM0_net_0                    : std_logic_vector(0 to 0);
signal Registers_0_DDRERRREQ         : std_logic_vector(1 downto 0);
signal Registers_0_INVERTCALSPICLCK  : std_logic;
signal Registers_0_ROCTVS_ADDR       : std_logic_vector(1 downto 0);
signal Registers_0_TIMERENABLE       : std_logic;
signal Registers_0_TIMERRESET        : std_logic;
signal Registers_0_TVS_RESETN        : std_logic;
signal reset_fifo_n_net_0            : std_logic;
signal SENSOR_MCP_CEn_net_0          : std_logic_vector(2 to 2);
signal SERDES_HOWMANY_net_0          : std_logic_vector(12 downto 0);
signal SERDES_RE_net_0               : std_logic;
signal serdes_re0_net_0              : std_logic;
signal serdes_re1_net_0              : std_logic;
signal serdes_re2_net_0              : std_logic;
signal serdes_re3_net_0              : std_logic;
signal SPI0_ADC0_CEn_net_0           : std_logic_vector(0 to 0);
signal SPI0_ADC1_CEn_net_0           : std_logic_vector(1 to 1);
signal SPI0_ADC2_CEn_net_0           : std_logic_vector(2 to 2);
signal SPI0_MOSI_net_0               : std_logic;
signal SPI0_SCLK_net_0               : std_logic;
signal SPI1_ADC0_CEn_net_0           : std_logic_vector(0 to 0);
signal SPI1_ADC1_CEn_net_0           : std_logic_vector(1 to 1);
signal SPI1_ADC2_CEn_net_0           : std_logic_vector(2 to 2);
signal SPI1_MOSI_net_0               : std_logic;
signal SPI1_SCLK_net_0               : std_logic;
signal SPI2_ADC0_CEn_net_0           : std_logic_vector(0 to 0);
signal SPI2_MOSI_net_0               : std_logic;
signal SPI2_SCLK_net_0               : std_logic;
signal TVS_Interface_0_R_DATA        : std_logic_vector(15 downto 0);
signal TX_net_0                      : std_logic;
signal use_lane_net_0                : std_logic_vector(3 downto 0);
signal use_uart_net_0                : std_logic;
signal write_to_fifo_net_0           : std_logic;
signal CAL_PREAMP_CE0n_net_1         : std_logic;
signal CAL_PREAMP_CE1n_net_1         : std_logic;
signal CAL_PREAMP_MOSI_net_1         : std_logic;
signal CAL_PREAMP_SCLK_net_1         : std_logic;
signal DDRCFOEN_net_1                : std_logic;
signal DDRCFOSTART_net_1             : std_logic;
signal DDRPREFETCHEN_net_1           : std_logic;
signal DDRPTTREN_net_1               : std_logic;
signal DDRSERIALSET_net_1            : std_logic;
signal DDR_RESETN_net_1              : std_logic;
signal DIGIDEVICE_RESETN_net_1       : std_logic;
signal DTCALIGN_RESETN_net_1         : std_logic;
signal DTCSIMBLKEN_net_1             : std_logic;
signal DTCSIMSTART_net_1             : std_logic;
signal HV_PREAMP_CE0n_net_1          : std_logic;
signal HV_PREAMP_CE1n_net_1          : std_logic;
signal HV_PREAMP_MOSI_net_1          : std_logic;
signal HV_PREAMP_SCLK_net_1          : std_logic;
signal APB3mmaster_PREADY_net_0      : std_logic;
signal APB3mmaster_PSLVERR_net_0     : std_logic;
signal PWM0_net_1                    : std_logic;
signal SENSOR_MCP_CEn_net_1          : std_logic;
signal SERDES_RE_net_1               : std_logic;
signal SPI0_ADC0_CEn_net_1           : std_logic;
signal SPI0_ADC1_CEn_net_1           : std_logic;
signal SPI0_ADC2_CEn_net_1           : std_logic;
signal SPI0_MOSI_net_1               : std_logic;
signal SPI0_SCLK_net_1               : std_logic;
signal SPI1_ADC0_CEn_net_1           : std_logic;
signal SPI1_ADC1_CEn_net_1           : std_logic;
signal SPI1_ADC2_CEn_net_1           : std_logic;
signal SPI1_MOSI_net_1               : std_logic;
signal SPI1_SCLK_net_1               : std_logic;
signal SPI2_ADC0_CEn_net_1           : std_logic;
signal SPI2_MOSI_net_1               : std_logic;
signal SPI2_SCLK_net_1               : std_logic;
signal TX_net_1                      : std_logic;
signal align_roc_to_digi_net_1       : std_logic;
signal cal_lane0_pcs_reset_n_net_1   : std_logic;
signal cal_lane0_pma_reset_n_net_1   : std_logic;
signal cal_lane1_pcs_reset_n_net_1   : std_logic;
signal cal_lane1_pma_reset_n_net_1   : std_logic;
signal cal_serdes_reset_n_net_1      : std_logic;
signal calscl_net_1                  : std_logic;
signal dtc_enable_reset_net_1        : std_logic;
signal dtc_serdes_reset_n_net_1      : std_logic;
signal enable_fiber_clock_net_1      : std_logic;
signal enable_fiber_marker_net_1     : std_logic;
signal ewm_50mhz_net_1               : std_logic;
signal ewm_enable_50mhz_net_1        : std_logic;
signal force_full_net_1              : std_logic;
signal hv_lane0_pcs_reset_n_net_1    : std_logic;
signal hv_lane0_pma_reset_n_net_1    : std_logic;
signal hv_lane1_pcs_reset_n_net_1    : std_logic;
signal hv_lane1_pma_reset_n_net_1    : std_logic;
signal hv_serdes_reset_n_net_1       : std_logic;
signal hvscl_net_1                   : std_logic;
signal reset_fifo_n_net_1            : std_logic;
signal serdes_re0_net_1              : std_logic;
signal serdes_re1_net_1              : std_logic;
signal serdes_re2_net_1              : std_logic;
signal serdes_re3_net_1              : std_logic;
signal use_uart_net_1                : std_logic;
signal write_to_fifo_net_1           : std_logic;
signal DDRCFODELTAHB_net_1           : std_logic_vector(31 downto 0);
signal DDRCFONUMBERHB_net_1          : std_logic_vector(31 downto 0);
signal DDRCFOOFFSET_net_1            : std_logic_vector(31 downto 0);
signal DTCSIMADDR_net_1              : std_logic_vector(31 downto 0);
signal DTCSIMBLKADDR_net_1           : std_logic_vector(6 downto 0);
signal DTCSIMBLKDATA_net_1           : std_logic_vector(15 downto 0);
signal DTCSIMDATA_net_1              : std_logic_vector(31 downto 0);
signal DTCSIMPARAM_net_1             : std_logic_vector(31 downto 0);
signal DTCSIMSPILLDATA_net_1         : std_logic_vector(31 downto 0);
signal GPIO_OUT_net_1                : std_logic_vector(3 downto 0);
signal APB3mmaster_PRDATA_net_0      : std_logic_vector(31 downto 0);
signal SERDES_HOWMANY_net_1          : std_logic_vector(12 downto 0);
signal dtc_error_address_net_1       : std_logic_vector(7 downto 0);
signal dummy_status_address_net_1    : std_logic_vector(3 downto 0);
signal event_window_early_cut_net_1  : std_logic_vector(15 downto 0);
signal event_window_expected_net_1   : std_logic_vector(15 downto 0);
signal event_window_late_cut_net_1   : std_logic_vector(15 downto 0);
signal ewm_delay_net_1               : std_logic_vector(15 downto 0);
signal use_lane_net_1                : std_logic_vector(3 downto 0);
signal SPISS_slice_0                 : std_logic_vector(7 downto 3);
signal SPISS_slice_1                 : std_logic_vector(7 downto 2);
signal PWM_slice_0                   : std_logic_vector(1 to 1);
signal SPISS_slice_2                 : std_logic_vector(7 downto 3);
signal SPISS_slice_3                 : std_logic_vector(7 downto 3);
signal SPISS_slice_4                 : std_logic_vector(7 downto 1);
signal SPISS_net_0                   : std_logic_vector(7 downto 0);
signal SPISS_net_1                   : std_logic_vector(7 downto 0);
signal PWM_net_0                     : std_logic_vector(1 downto 0);
signal SPISS_net_2                   : std_logic_vector(7 downto 0);
signal SPISS_net_3                   : std_logic_vector(7 downto 0);
signal SPISS_net_4                   : std_logic_vector(7 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GPIO_IN_const_net_0           : std_logic_vector(3 downto 0);
signal VCC_net                       : std_logic;
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal APB3_0_APBmslave0_PADDR       : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave0_PADDR_0     : std_logic_vector(7 downto 0);
signal APB3_0_APBmslave0_PADDR_0_7to0: std_logic_vector(7 downto 0);
signal APB3_0_APBmslave0_PADDR_1     : std_logic_vector(7 downto 0);
signal APB3_0_APBmslave0_PADDR_1_7to0: std_logic_vector(7 downto 0);
signal APB3_0_APBmslave0_PADDR_2     : std_logic_vector(4 downto 0);
signal APB3_0_APBmslave0_PADDR_2_4to0: std_logic_vector(4 downto 0);
signal APB3_0_APBmslave0_PADDR_3     : std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_3_6to0: std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_4     : std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_4_6to0: std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_5     : std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_5_6to0: std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_6     : std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_6_6to0: std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_7     : std_logic_vector(6 downto 0);
signal APB3_0_APBmslave0_PADDR_7_6to0: std_logic_vector(6 downto 0);

signal APB3_0_APBmslave0_PWDATA      : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave0_PWDATA_0    : std_logic_vector(7 downto 0);
signal APB3_0_APBmslave0_PWDATA_0_7to0: std_logic_vector(7 downto 0);

signal APB3_0_APBmslave3_PRDATA      : std_logic_vector(7 downto 0);
signal APB3_0_APBmslave3_PRDATA_0    : std_logic_vector(31 downto 0);
signal APB3_0_APBmslave3_PRDATA_0_31to8: std_logic_vector(31 downto 8);
signal APB3_0_APBmslave3_PRDATA_0_7to0: std_logic_vector(7 downto 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GPIO_IN_const_net_0 <= B"1111";
 VCC_net             <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CAL_PREAMP_CE0n_net_1               <= CAL_PREAMP_CE0n_net_0(0);
 CAL_PREAMP_CE0n                     <= CAL_PREAMP_CE0n_net_1;
 CAL_PREAMP_CE1n_net_1               <= CAL_PREAMP_CE1n_net_0(1);
 CAL_PREAMP_CE1n                     <= CAL_PREAMP_CE1n_net_1;
 CAL_PREAMP_MOSI_net_1               <= CAL_PREAMP_MOSI_net_0;
 CAL_PREAMP_MOSI                     <= CAL_PREAMP_MOSI_net_1;
 CAL_PREAMP_SCLK_net_1               <= CAL_PREAMP_SCLK_net_0;
 CAL_PREAMP_SCLK                     <= CAL_PREAMP_SCLK_net_1;
 DDRCFOEN_net_1                      <= DDRCFOEN_net_0;
 DDRCFOEN                            <= DDRCFOEN_net_1;
 DDRCFOSTART_net_1                   <= DDRCFOSTART_net_0;
 DDRCFOSTART                         <= DDRCFOSTART_net_1;
 DDRPREFETCHEN_net_1                 <= DDRPREFETCHEN_net_0;
 DDRPREFETCHEN                       <= DDRPREFETCHEN_net_1;
 DDRPTTREN_net_1                     <= DDRPTTREN_net_0;
 DDRPTTREN                           <= DDRPTTREN_net_1;
 DDRSERIALSET_net_1                  <= DDRSERIALSET_net_0;
 DDRSERIALSET                        <= DDRSERIALSET_net_1;
 DDR_RESETN_net_1                    <= DDR_RESETN_net_0;
 DDR_RESETN                          <= DDR_RESETN_net_1;
 DIGIDEVICE_RESETN_net_1             <= DIGIDEVICE_RESETN_net_0;
 DIGIDEVICE_RESETN                   <= DIGIDEVICE_RESETN_net_1;
 DTCALIGN_RESETN_net_1               <= DTCALIGN_RESETN_net_0;
 DTCALIGN_RESETN                     <= DTCALIGN_RESETN_net_1;
 DTCSIMBLKEN_net_1                   <= DTCSIMBLKEN_net_0;
 DTCSIMBLKEN                         <= DTCSIMBLKEN_net_1;
 DTCSIMSTART_net_1                   <= DTCSIMSTART_net_0;
 DTCSIMSTART                         <= DTCSIMSTART_net_1;
 HV_PREAMP_CE0n_net_1                <= HV_PREAMP_CE0n_net_0(0);
 HV_PREAMP_CE0n                      <= HV_PREAMP_CE0n_net_1;
 HV_PREAMP_CE1n_net_1                <= HV_PREAMP_CE1n_net_0(1);
 HV_PREAMP_CE1n                      <= HV_PREAMP_CE1n_net_1;
 HV_PREAMP_MOSI_net_1                <= HV_PREAMP_MOSI_net_0;
 HV_PREAMP_MOSI                      <= HV_PREAMP_MOSI_net_1;
 HV_PREAMP_SCLK_net_1                <= HV_PREAMP_SCLK_net_0;
 HV_PREAMP_SCLK                      <= HV_PREAMP_SCLK_net_1;
 APB3mmaster_PREADY_net_0            <= APB3mmaster_PREADY;
 PREADY                              <= APB3mmaster_PREADY_net_0;
 APB3mmaster_PSLVERR_net_0           <= APB3mmaster_PSLVERR;
 PSLVERR                             <= APB3mmaster_PSLVERR_net_0;
 PWM0_net_1                          <= PWM0_net_0(0);
 PWM0                                <= PWM0_net_1;
 SENSOR_MCP_CEn_net_1                <= SENSOR_MCP_CEn_net_0(2);
 SENSOR_MCP_CEn                      <= SENSOR_MCP_CEn_net_1;
 SERDES_RE_net_1                     <= SERDES_RE_net_0;
 SERDES_RE                           <= SERDES_RE_net_1;
 SPI0_ADC0_CEn_net_1                 <= SPI0_ADC0_CEn_net_0(0);
 SPI0_ADC0_CEn                       <= SPI0_ADC0_CEn_net_1;
 SPI0_ADC1_CEn_net_1                 <= SPI0_ADC1_CEn_net_0(1);
 SPI0_ADC1_CEn                       <= SPI0_ADC1_CEn_net_1;
 SPI0_ADC2_CEn_net_1                 <= SPI0_ADC2_CEn_net_0(2);
 SPI0_ADC2_CEn                       <= SPI0_ADC2_CEn_net_1;
 SPI0_MOSI_net_1                     <= SPI0_MOSI_net_0;
 SPI0_MOSI                           <= SPI0_MOSI_net_1;
 SPI0_SCLK_net_1                     <= SPI0_SCLK_net_0;
 SPI0_SCLK                           <= SPI0_SCLK_net_1;
 SPI1_ADC0_CEn_net_1                 <= SPI1_ADC0_CEn_net_0(0);
 SPI1_ADC0_CEn                       <= SPI1_ADC0_CEn_net_1;
 SPI1_ADC1_CEn_net_1                 <= SPI1_ADC1_CEn_net_0(1);
 SPI1_ADC1_CEn                       <= SPI1_ADC1_CEn_net_1;
 SPI1_ADC2_CEn_net_1                 <= SPI1_ADC2_CEn_net_0(2);
 SPI1_ADC2_CEn                       <= SPI1_ADC2_CEn_net_1;
 SPI1_MOSI_net_1                     <= SPI1_MOSI_net_0;
 SPI1_MOSI                           <= SPI1_MOSI_net_1;
 SPI1_SCLK_net_1                     <= SPI1_SCLK_net_0;
 SPI1_SCLK                           <= SPI1_SCLK_net_1;
 SPI2_ADC0_CEn_net_1                 <= SPI2_ADC0_CEn_net_0(0);
 SPI2_ADC0_CEn                       <= SPI2_ADC0_CEn_net_1;
 SPI2_MOSI_net_1                     <= SPI2_MOSI_net_0;
 SPI2_MOSI                           <= SPI2_MOSI_net_1;
 SPI2_SCLK_net_1                     <= SPI2_SCLK_net_0;
 SPI2_SCLK                           <= SPI2_SCLK_net_1;
 TX_net_1                            <= TX_net_0;
 TX                                  <= TX_net_1;
 align_roc_to_digi_net_1             <= align_roc_to_digi_net_0;
 align_roc_to_digi                   <= align_roc_to_digi_net_1;
 cal_lane0_pcs_reset_n_net_1         <= cal_lane0_pcs_reset_n_net_0;
 cal_lane0_pcs_reset_n               <= cal_lane0_pcs_reset_n_net_1;
 cal_lane0_pma_reset_n_net_1         <= cal_lane0_pma_reset_n_net_0;
 cal_lane0_pma_reset_n               <= cal_lane0_pma_reset_n_net_1;
 cal_lane1_pcs_reset_n_net_1         <= cal_lane1_pcs_reset_n_net_0;
 cal_lane1_pcs_reset_n               <= cal_lane1_pcs_reset_n_net_1;
 cal_lane1_pma_reset_n_net_1         <= cal_lane1_pma_reset_n_net_0;
 cal_lane1_pma_reset_n               <= cal_lane1_pma_reset_n_net_1;
 cal_serdes_reset_n_net_1            <= cal_serdes_reset_n_net_0;
 cal_serdes_reset_n                  <= cal_serdes_reset_n_net_1;
 calscl_net_1                        <= calscl_net_0;
 calscl                              <= calscl_net_1;
 dtc_enable_reset_net_1              <= dtc_enable_reset_net_0;
 dtc_enable_reset                    <= dtc_enable_reset_net_1;
 dtc_serdes_reset_n_net_1            <= dtc_serdes_reset_n_net_0;
 dtc_serdes_reset_n                  <= dtc_serdes_reset_n_net_1;
 enable_fiber_clock_net_1            <= enable_fiber_clock_net_0;
 enable_fiber_clock                  <= enable_fiber_clock_net_1;
 enable_fiber_marker_net_1           <= enable_fiber_marker_net_0;
 enable_fiber_marker                 <= enable_fiber_marker_net_1;
 ewm_50mhz_net_1                     <= ewm_50mhz_net_0;
 ewm_50mhz                           <= ewm_50mhz_net_1;
 ewm_enable_50mhz_net_1              <= ewm_enable_50mhz_net_0;
 ewm_enable_50mhz                    <= ewm_enable_50mhz_net_1;
 force_full_net_1                    <= force_full_net_0;
 force_full                          <= force_full_net_1;
 hv_lane0_pcs_reset_n_net_1          <= hv_lane0_pcs_reset_n_net_0;
 hv_lane0_pcs_reset_n                <= hv_lane0_pcs_reset_n_net_1;
 hv_lane0_pma_reset_n_net_1          <= hv_lane0_pma_reset_n_net_0;
 hv_lane0_pma_reset_n                <= hv_lane0_pma_reset_n_net_1;
 hv_lane1_pcs_reset_n_net_1          <= hv_lane1_pcs_reset_n_net_0;
 hv_lane1_pcs_reset_n                <= hv_lane1_pcs_reset_n_net_1;
 hv_lane1_pma_reset_n_net_1          <= hv_lane1_pma_reset_n_net_0;
 hv_lane1_pma_reset_n                <= hv_lane1_pma_reset_n_net_1;
 hv_serdes_reset_n_net_1             <= hv_serdes_reset_n_net_0;
 hv_serdes_reset_n                   <= hv_serdes_reset_n_net_1;
 hvscl_net_1                         <= hvscl_net_0;
 hvscl                               <= hvscl_net_1;
 reset_fifo_n_net_1                  <= reset_fifo_n_net_0;
 reset_fifo_n                        <= reset_fifo_n_net_1;
 serdes_re0_net_1                    <= serdes_re0_net_0;
 serdes_re0                          <= serdes_re0_net_1;
 serdes_re1_net_1                    <= serdes_re1_net_0;
 serdes_re1                          <= serdes_re1_net_1;
 serdes_re2_net_1                    <= serdes_re2_net_0;
 serdes_re2                          <= serdes_re2_net_1;
 serdes_re3_net_1                    <= serdes_re3_net_0;
 serdes_re3                          <= serdes_re3_net_1;
 use_uart_net_1                      <= use_uart_net_0;
 use_uart                            <= use_uart_net_1;
 write_to_fifo_net_1                 <= write_to_fifo_net_0;
 write_to_fifo                       <= write_to_fifo_net_1;
 DDRCFODELTAHB_net_1                 <= DDRCFODELTAHB_net_0;
 DDRCFODELTAHB(31 downto 0)          <= DDRCFODELTAHB_net_1;
 DDRCFONUMBERHB_net_1                <= DDRCFONUMBERHB_net_0;
 DDRCFONUMBERHB(31 downto 0)         <= DDRCFONUMBERHB_net_1;
 DDRCFOOFFSET_net_1                  <= DDRCFOOFFSET_net_0;
 DDRCFOOFFSET(31 downto 0)           <= DDRCFOOFFSET_net_1;
 DTCSIMADDR_net_1                    <= DTCSIMADDR_net_0;
 DTCSIMADDR(31 downto 0)             <= DTCSIMADDR_net_1;
 DTCSIMBLKADDR_net_1                 <= DTCSIMBLKADDR_net_0;
 DTCSIMBLKADDR(6 downto 0)           <= DTCSIMBLKADDR_net_1;
 DTCSIMBLKDATA_net_1                 <= DTCSIMBLKDATA_net_0;
 DTCSIMBLKDATA(15 downto 0)          <= DTCSIMBLKDATA_net_1;
 DTCSIMDATA_net_1                    <= DTCSIMDATA_net_0;
 DTCSIMDATA(31 downto 0)             <= DTCSIMDATA_net_1;
 DTCSIMPARAM_net_1                   <= DTCSIMPARAM_net_0;
 DTCSIMPARAM(31 downto 0)            <= DTCSIMPARAM_net_1;
 DTCSIMSPILLDATA_net_1               <= DTCSIMSPILLDATA_net_0;
 DTCSIMSPILLDATA(31 downto 0)        <= DTCSIMSPILLDATA_net_1;
 GPIO_OUT_net_1                      <= GPIO_OUT_net_0;
 GPIO_OUT(3 downto 0)                <= GPIO_OUT_net_1;
 APB3mmaster_PRDATA_net_0            <= APB3mmaster_PRDATA;
 PRDATA(31 downto 0)                 <= APB3mmaster_PRDATA_net_0;
 SERDES_HOWMANY_net_1                <= SERDES_HOWMANY_net_0;
 SERDES_HOWMANY(12 downto 0)         <= SERDES_HOWMANY_net_1;
 dtc_error_address_net_1             <= dtc_error_address_net_0;
 dtc_error_address(7 downto 0)       <= dtc_error_address_net_1;
 dummy_status_address_net_1          <= dummy_status_address_net_0;
 dummy_status_address(3 downto 0)    <= dummy_status_address_net_1;
 event_window_early_cut_net_1        <= event_window_early_cut_net_0;
 event_window_early_cut(15 downto 0) <= event_window_early_cut_net_1;
 event_window_expected_net_1         <= event_window_expected_net_0;
 event_window_expected(15 downto 0)  <= event_window_expected_net_1;
 event_window_late_cut_net_1         <= event_window_late_cut_net_0;
 event_window_late_cut(15 downto 0)  <= event_window_late_cut_net_1;
 ewm_delay_net_1                     <= ewm_delay_net_0;
 ewm_delay(15 downto 0)              <= ewm_delay_net_1;
 use_lane_net_1                      <= use_lane_net_0;
 use_lane(3 downto 0)                <= use_lane_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 CAL_PREAMP_CE0n_net_0(0) <= SPISS_net_1(0);
 CAL_PREAMP_CE1n_net_0(1) <= SPISS_net_1(1);
 HV_PREAMP_CE0n_net_0(0)  <= SPISS_net_0(0);
 HV_PREAMP_CE1n_net_0(1)  <= SPISS_net_0(1);
 PWM0_net_0(0)            <= PWM_net_0(0);
 SENSOR_MCP_CEn_net_0(2)  <= SPISS_net_0(2);
 SPI0_ADC0_CEn_net_0(0)   <= SPISS_net_2(0);
 SPI0_ADC1_CEn_net_0(1)   <= SPISS_net_2(1);
 SPI0_ADC2_CEn_net_0(2)   <= SPISS_net_2(2);
 SPI1_ADC0_CEn_net_0(0)   <= SPISS_net_3(0);
 SPI1_ADC1_CEn_net_0(1)   <= SPISS_net_3(1);
 SPI1_ADC2_CEn_net_0(2)   <= SPISS_net_3(2);
 SPI2_ADC0_CEn_net_0(0)   <= SPISS_net_4(0);
 SPISS_slice_0            <= SPISS_net_0(7 downto 3);
 SPISS_slice_1            <= SPISS_net_1(7 downto 2);
 PWM_slice_0(1)           <= PWM_net_0(1);
 SPISS_slice_2            <= SPISS_net_2(7 downto 3);
 SPISS_slice_3            <= SPISS_net_3(7 downto 3);
 SPISS_slice_4            <= SPISS_net_4(7 downto 1);
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 APB3_0_APBmslave0_PADDR_0(7 downto 0) <= ( APB3_0_APBmslave0_PADDR_0_7to0(7 downto 0) );
 APB3_0_APBmslave0_PADDR_0_7to0(7 downto 0) <= APB3_0_APBmslave0_PADDR(7 downto 0);
 APB3_0_APBmslave0_PADDR_1(7 downto 0) <= ( APB3_0_APBmslave0_PADDR_1_7to0(7 downto 0) );
 APB3_0_APBmslave0_PADDR_1_7to0(7 downto 0) <= APB3_0_APBmslave0_PADDR(7 downto 0);
 APB3_0_APBmslave0_PADDR_2(4 downto 0) <= ( APB3_0_APBmslave0_PADDR_2_4to0(4 downto 0) );
 APB3_0_APBmslave0_PADDR_2_4to0(4 downto 0) <= APB3_0_APBmslave0_PADDR(4 downto 0);
 APB3_0_APBmslave0_PADDR_3(6 downto 0) <= ( APB3_0_APBmslave0_PADDR_3_6to0(6 downto 0) );
 APB3_0_APBmslave0_PADDR_3_6to0(6 downto 0) <= APB3_0_APBmslave0_PADDR(6 downto 0);
 APB3_0_APBmslave0_PADDR_4(6 downto 0) <= ( APB3_0_APBmslave0_PADDR_4_6to0(6 downto 0) );
 APB3_0_APBmslave0_PADDR_4_6to0(6 downto 0) <= APB3_0_APBmslave0_PADDR(6 downto 0);
 APB3_0_APBmslave0_PADDR_5(6 downto 0) <= ( APB3_0_APBmslave0_PADDR_5_6to0(6 downto 0) );
 APB3_0_APBmslave0_PADDR_5_6to0(6 downto 0) <= APB3_0_APBmslave0_PADDR(6 downto 0);
 APB3_0_APBmslave0_PADDR_6(6 downto 0) <= ( APB3_0_APBmslave0_PADDR_6_6to0(6 downto 0) );
 APB3_0_APBmslave0_PADDR_6_6to0(6 downto 0) <= APB3_0_APBmslave0_PADDR(6 downto 0);
 APB3_0_APBmslave0_PADDR_7(6 downto 0) <= ( APB3_0_APBmslave0_PADDR_7_6to0(6 downto 0) );
 APB3_0_APBmslave0_PADDR_7_6to0(6 downto 0) <= APB3_0_APBmslave0_PADDR(6 downto 0);

 APB3_0_APBmslave0_PWDATA_0(7 downto 0) <= ( APB3_0_APBmslave0_PWDATA_0_7to0(7 downto 0) );
 APB3_0_APBmslave0_PWDATA_0_7to0(7 downto 0) <= APB3_0_APBmslave0_PWDATA(7 downto 0);

 APB3_0_APBmslave3_PRDATA_0(31 downto 0) <= ( APB3_0_APBmslave3_PRDATA_0_31to8(31 downto 8) & APB3_0_APBmslave3_PRDATA_0_7to0(7 downto 0) );
 APB3_0_APBmslave3_PRDATA_0_31to8(31 downto 8) <= B"000000000000000000000000";
 APB3_0_APBmslave3_PRDATA_0_7to0(7 downto 0) <= APB3_0_APBmslave3_PRDATA(7 downto 0);

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_0
AND2_0 : AND2
    port map( 
        -- Inputs
        A => PRESETN,
        B => Registers_0_TVS_RESETN,
        -- Outputs
        Y => AND2_0_Y 
        );
-- APB3_0
APB3_0 : APB3
    port map( 
        -- Inputs
        PADDR     => PADDR,
        PSEL      => PSEL,
        PENABLE   => PENABLE,
        PWRITE    => PWRITE,
        PWDATA    => PWDATA,
        PRDATAS0  => APB3_0_APBmslave0_PRDATA,
        PREADYS0  => APB3_0_APBmslave0_PREADY,
        PSLVERRS0 => APB3_0_APBmslave0_PSLVERR,
        PRDATAS1  => APB3_0_APBmslave1_PRDATA,
        PREADYS1  => APB3_0_APBmslave1_PREADY,
        PSLVERRS1 => APB3_0_APBmslave1_PSLVERR,
        PRDATAS2  => APB3_0_APBmslave2_PRDATA,
        PREADYS2  => APB3_0_APBmslave2_PREADY,
        PSLVERRS2 => APB3_0_APBmslave2_PSLVERR,
        PRDATAS3  => APB3_0_APBmslave3_PRDATA_0,
        PREADYS3  => APB3_0_APBmslave3_PREADY,
        PSLVERRS3 => APB3_0_APBmslave3_PSLVERR,
        PRDATAS4  => APB3_0_APBmslave4_PRDATA,
        PREADYS4  => APB3_0_APBmslave4_PREADY,
        PSLVERRS4 => APB3_0_APBmslave4_PSLVERR,
        PRDATAS5  => APB3_0_APBmslave5_PRDATA,
        PREADYS5  => APB3_0_APBmslave5_PREADY,
        PSLVERRS5 => APB3_0_APBmslave5_PSLVERR,
        PRDATAS6  => APB3_0_APBmslave6_PRDATA,
        PREADYS6  => APB3_0_APBmslave6_PREADY,
        PSLVERRS6 => APB3_0_APBmslave6_PSLVERR,
        PRDATAS7  => APB3_0_APBmslave7_PRDATA,
        PREADYS7  => APB3_0_APBmslave7_PREADY,
        PSLVERRS7 => APB3_0_APBmslave7_PSLVERR,
        PRDATAS8  => APB3_0_APBmslave8_PRDATA,
        PREADYS8  => APB3_0_APBmslave8_PREADY,
        PSLVERRS8 => APB3_0_APBmslave8_PSLVERR,
        PRDATAS9  => APB3_0_APBmslave9_PRDATA,
        PREADYS9  => APB3_0_APBmslave9_PREADY,
        PSLVERRS9 => APB3_0_APBmslave9_PSLVERR,
        -- Outputs
        PRDATA    => APB3mmaster_PRDATA,
        PREADY    => APB3mmaster_PREADY,
        PSLVERR   => APB3mmaster_PSLVERR,
        PADDRS    => APB3_0_APBmslave0_PADDR,
        PSELS0    => APB3_0_APBmslave0_PSELx,
        PENABLES  => APB3_0_APBmslave0_PENABLE,
        PWRITES   => APB3_0_APBmslave0_PWRITE,
        PWDATAS   => APB3_0_APBmslave0_PWDATA,
        PSELS1    => APB3_0_APBmslave1_PSELx,
        PSELS2    => APB3_0_APBmslave2_PSELx,
        PSELS3    => APB3_0_APBmslave3_PSELx,
        PSELS4    => APB3_0_APBmslave4_PSELx,
        PSELS5    => APB3_0_APBmslave5_PSELx,
        PSELS6    => APB3_0_APBmslave6_PSELx,
        PSELS7    => APB3_0_APBmslave7_PSELx,
        PSELS8    => APB3_0_APBmslave8_PSELx,
        PSELS9    => APB3_0_APBmslave9_PSELx 
        );
-- counter32_0
counter32_0 : counter32
    port map( 
        -- Inputs
        clk   => PCLK,
        en    => Registers_0_TIMERENABLE,
        rst_n => Registers_0_TIMERRESET,
        -- Outputs
        cnt   => counter32_0_cnt 
        );
-- GPIO_0
GPIO_0 : GPIO
    port map( 
        -- Inputs
        PRESETN  => PRESETN,
        PCLK     => PCLK,
        GPIO_IN  => GPIO_IN_const_net_0,
        PADDR    => APB3_0_APBmslave0_PADDR_0,
        PSEL     => APB3_0_APBmslave0_PSELx,
        PENABLE  => APB3_0_APBmslave0_PENABLE,
        PWRITE   => APB3_0_APBmslave0_PWRITE,
        PWDATA   => APB3_0_APBmslave0_PWDATA,
        -- Outputs
        INT      => OPEN,
        GPIO_OUT => GPIO_OUT_net_0,
        PRDATA   => APB3_0_APBmslave0_PRDATA,
        PREADY   => APB3_0_APBmslave0_PREADY,
        PSLVERR  => APB3_0_APBmslave0_PSLVERR 
        );
-- INV_0
INV_0 : INV
    port map( 
        -- Inputs
        A => PREAMPSPI_1_SPISCLKO,
        -- Outputs
        Y => INV_0_Y 
        );
-- MX2_0
MX2_0 : MX2
    port map( 
        -- Inputs
        A => PREAMPSPI_1_SPISCLKO,
        B => INV_0_Y,
        S => Registers_0_INVERTCALSPICLCK,
        -- Outputs
        Y => CAL_PREAMP_SCLK_net_0 
        );
-- pattern_err_switch_0
pattern_err_switch_0 : pattern_err_switch
    port map( 
        -- Inputs
        err_en    => Registers_0_DDRERRREQ,
        evt_expc  => evt_expc,
        evt_seen  => evt_seen,
        hdr1_expc => hdr1_expc,
        hdr1_seen => hdr1_seen,
        hdr2_expc => hdr2_expc,
        hdr2_seen => hdr2_seen,
        data_expc => data_expc,
        data_seen => data_seen,
        -- Outputs
        err_expc  => pattern_err_switch_0_err_expc,
        err_seen  => pattern_err_switch_0_err_seen 
        );
-- PF_SYSTEM_SERVICES_C0_0
PF_SYSTEM_SERVICES_C0_0 : PF_SYSTEM_SERVICES_C0
    port map( 
        -- Inputs
        CLK              => PCLK,
        RESETN           => PRESETN,
        APBS_PADDR       => APB3_0_APBmslave0_PADDR,
        APBS_PSEL        => APB3_0_APBmslave8_PSELx,
        APBS_PENABLE     => APB3_0_APBmslave0_PENABLE,
        APBS_PWRITE      => APB3_0_APBmslave0_PWRITE,
        APBS_PWDATA      => APB3_0_APBmslave0_PWDATA,
        -- Outputs
        USR_CMD_ERROR    => OPEN,
        USR_BUSY         => OPEN,
        SS_BUSY          => OPEN,
        USR_RDVLD        => OPEN,
        SYSSERV_INIT_REQ => OPEN,
        APBS_PRDATA      => APB3_0_APBmslave8_PRDATA,
        APBS_PREADY      => APB3_0_APBmslave8_PREADY,
        APBS_PSLVERR     => APB3_0_APBmslave8_PSLVERR 
        );
-- PREAMPSPI_0
PREAMPSPI_0 : PREAMPSPI
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        SPISSI     => VCC_net,
        SPISDI     => HV_PREAMP_MISO,
        SPICLKI    => VCC_net,
        PADDR      => APB3_0_APBmslave0_PADDR_5,
        PSEL       => APB3_0_APBmslave6_PSELx,
        PENABLE    => APB3_0_APBmslave0_PENABLE,
        PWRITE     => APB3_0_APBmslave0_PWRITE,
        PWDATA     => APB3_0_APBmslave0_PWDATA,
        -- Outputs
        SPIINT     => OPEN,
        SPIRXAVAIL => OPEN,
        SPITXRFM   => OPEN,
        SPISS      => SPISS_net_0,
        SPISCLKO   => HV_PREAMP_SCLK_net_0,
        SPIOEN     => OPEN,
        SPISDO     => HV_PREAMP_MOSI_net_0,
        SPIMODE    => OPEN,
        PRDATA     => APB3_0_APBmslave6_PRDATA,
        PREADY     => APB3_0_APBmslave6_PREADY,
        PSLVERR    => APB3_0_APBmslave6_PSLVERR 
        );
-- PREAMPSPI_1
PREAMPSPI_1 : PREAMPSPI
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        SPISSI     => VCC_net,
        SPISDI     => CAL_PREAMP_MISO,
        SPICLKI    => VCC_net,
        PADDR      => APB3_0_APBmslave0_PADDR_6,
        PSEL       => APB3_0_APBmslave7_PSELx,
        PENABLE    => APB3_0_APBmslave0_PENABLE,
        PWRITE     => APB3_0_APBmslave0_PWRITE,
        PWDATA     => APB3_0_APBmslave0_PWDATA,
        -- Outputs
        SPIINT     => OPEN,
        SPIRXAVAIL => OPEN,
        SPITXRFM   => OPEN,
        SPISS      => SPISS_net_1,
        SPISCLKO   => PREAMPSPI_1_SPISCLKO,
        SPIOEN     => OPEN,
        SPISDO     => CAL_PREAMP_MOSI_net_0,
        SPIMODE    => OPEN,
        PRDATA     => APB3_0_APBmslave7_PRDATA,
        PREADY     => APB3_0_APBmslave7_PREADY,
        PSLVERR    => APB3_0_APBmslave7_PSLVERR 
        );
-- pwm_0
pwm_0 : pwm
    port map( 
        -- Inputs
        PCLK    => PCLK,
        PRESETN => PRESETN,
        PADDR   => APB3_0_APBmslave0_PADDR_1,
        PENABLE => APB3_0_APBmslave0_PENABLE,
        PSEL    => APB3_0_APBmslave1_PSELx,
        PWDATA  => APB3_0_APBmslave0_PWDATA,
        PWRITE  => APB3_0_APBmslave0_PWRITE,
        -- Outputs
        PWM     => PWM_net_0,
        PRDATA  => APB3_0_APBmslave1_PRDATA,
        PREADY  => APB3_0_APBmslave1_PREADY,
        PSLVERR => APB3_0_APBmslave1_PSLVERR 
        );
-- Registers_0
Registers_0 : entity work.Registers
    generic map( 
        APB_ADDRESS_WIDTH    => ( 32 ),
        APB_DATA_WIDTH       => ( 32 ),
        CB_ADDRESS_WIDTH     => ( 6 ),
        SERDES_ADDRESS_WIDTH => ( 10 )
        )
    port map( 
        -- Inputs
        PCLK                   => PCLK,
        PRESETn                => PRESETN,
        PENABLE                => APB3_0_APBmslave0_PENABLE,
        PSEL                   => APB3_0_APBmslave2_PSELx,
        PADDR                  => APB3_0_APBmslave0_PADDR,
        PWRITE                 => APB3_0_APBmslave0_PWRITE,
        PWDATA                 => APB3_0_APBmslave0_PWDATA,
        SERDES_DATA            => SERDES_DATA,
        SERDES_FULL            => SERDES_FULL,
        SERDES_EMPTY           => SERDES_EMPTY,
        SERDES_RDCNT           => SERDES_RDCNT,
        serdes_aligned         => serdes_aligned,
        DDRERROR               => DDRERROR,
        DDRERRSEEN             => pattern_err_switch_0_err_seen,
        DDRERREXPC             => pattern_err_switch_0_err_expc,
        DDRSIZEWR              => DDRSIZEWR,
        DDRSIZERD              => DDRSIZERD,
        DDRHBCNT               => DDRHBCNT,
        DDRNULLHBCNT           => DDRNULLHBCNT,
        DDRHBONHOLD            => DDRHBONHOLD,
        DDRPREFCNT             => DDRPREFCNT,
        DDRDREQCNT             => DDRDREQCNT,
        DDRDREQREAD            => DDRDREQREAD,
        DDRDREQSENT            => DDRDREQSENT,
        DDRDREQNULL            => DDRDREQNULL,
        DDRSPILLCNT            => DDRSPILLCNT,
        DDRHBTAG               => DDRHBTAG,
        DDRPRETAG              => DDRPRETAG,
        DDRFETCHTAG            => DDRFETCHTAG,
        DDRDREQTAG             => DDRDREQTAG,
        DDROFFSETTAG           => DDROFFSETTAG,
        DDRCTRLREADY           => DDRCTRLREADY,
        DTCDATAREAD            => DTCDATAREAD,
        remote_token0          => remote_token0,
        remote_token1          => remote_token1,
        remote_token2          => remote_token2,
        remote_token3          => remote_token3,
        dummy_status_out0      => dummy_status_out0,
        dummy_status_out1      => dummy_status_out1,
        dummy_status_out2      => dummy_status_out2,
        dummy_status_out3      => dummy_status_out3,
        serdes_rdcnt0          => serdes_rdcnt0,
        serdes_rdcnt1          => serdes_rdcnt1,
        serdes_rdcnt2          => serdes_rdcnt2,
        serdes_rdcnt3          => serdes_rdcnt3,
        serdes_data0           => serdes_data0,
        serdes_data1           => serdes_data1,
        serdes_data2           => serdes_data2,
        serdes_data3           => serdes_data3,
        ROCTVS_VAL             => TVS_Interface_0_R_DATA,
        cal_lane0_aligned      => cal_lane0_aligned,
        cal_lane1_aligned      => cal_lane1_aligned,
        hv_lane0_aligned       => hv_lane0_aligned,
        hv_lane1_aligned       => hv_lane1_aligned,
        cal_lane0_alignment    => cal_lane0_alignment,
        cal_lane1_alignment    => cal_lane1_alignment,
        hv_lane0_alignment     => hv_lane0_alignment,
        hv_lane1_alignment     => hv_lane1_alignment,
        cal_lane0_error_count  => cal_lane0_error_count,
        cal_lane1_error_count  => cal_lane1_error_count,
        hv_lane0_error_count   => hv_lane0_error_count,
        hv_lane1_error_count   => hv_lane1_error_count,
        dtc_error_counter      => dtc_error_counter,
        TIMERCOUNTER           => counter32_0_cnt,
        -- Outputs
        PRDATA                 => APB3_0_APBmslave2_PRDATA,
        PREADY                 => APB3_0_APBmslave2_PREADY,
        PSLVERR                => APB3_0_APBmslave2_PSLVERR,
        SERDES_RE              => SERDES_RE_net_0,
        DIGIDEVICE_RESETN      => DIGIDEVICE_RESETN_net_0,
        SERDES_HOWMANY         => SERDES_HOWMANY_net_0,
        INVERTCALSPICLCK       => Registers_0_INVERTCALSPICLCK,
        DDR_RESETN             => DDR_RESETN_net_0,
        DTCALIGN_RESETN        => DTCALIGN_RESETN_net_0,
        TVS_RESETN             => Registers_0_TVS_RESETN,
        DDRSERIALSET           => DDRSERIALSET_net_0,
        DDRPTTREN              => DDRPTTREN_net_0,
        DDRCFOEN               => DDRCFOEN_net_0,
        DDRCFOSTART            => DDRCFOSTART_net_0,
        DDRPREFETCHEN          => DDRPREFETCHEN_net_0,
        DDRERRREQ              => Registers_0_DDRERRREQ,
        DDRCFOOFFSET           => DDRCFOOFFSET_net_0,
        DDRCFODELTAHB          => DDRCFODELTAHB_net_0,
        DDRCFONUMBERHB         => DDRCFONUMBERHB_net_0,
        DTCSIMSTART            => DTCSIMSTART_net_0,
        DTCSIMBLKEN            => DTCSIMBLKEN_net_0,
        DTCSIMPARAM            => DTCSIMPARAM_net_0,
        DTCSIMADDR             => DTCSIMADDR_net_0,
        DTCSIMDATA             => DTCSIMDATA_net_0,
        DTCSIMSPILLDATA        => DTCSIMSPILLDATA_net_0,
        DTCSIMBLKDATA          => DTCSIMBLKDATA_net_0,
        DTCSIMBLKADDR          => DTCSIMBLKADDR_net_0,
        hvscl                  => hvscl_net_0,
        calscl                 => calscl_net_0,
        ewm_50mhz              => ewm_50mhz_net_0,
        ewm_enable_50mhz       => ewm_enable_50mhz_net_0,
        ewm_delay              => ewm_delay_net_0,
        event_window_early_cut => event_window_early_cut_net_0,
        event_window_late_cut  => event_window_late_cut_net_0,
        reset_fifo_n           => reset_fifo_n_net_0,
        write_to_fifo          => write_to_fifo_net_0,
        dummy_status_address   => dummy_status_address_net_0,
        serdes_re0             => serdes_re0_net_0,
        serdes_re1             => serdes_re1_net_0,
        serdes_re2             => serdes_re2_net_0,
        serdes_re3             => serdes_re3_net_0,
        use_lane               => use_lane_net_0,
        use_uart               => use_uart_net_0,
        ROCTVS_ADDR            => Registers_0_ROCTVS_ADDR,
        enable_fiber_clock     => enable_fiber_clock_net_0,
        enable_fiber_marker    => enable_fiber_marker_net_0,
        cal_lane0_pcs_reset_n  => cal_lane0_pcs_reset_n_net_0,
        cal_lane1_pcs_reset_n  => cal_lane1_pcs_reset_n_net_0,
        cal_lane0_pma_reset_n  => cal_lane0_pma_reset_n_net_0,
        cal_lane1_pma_reset_n  => cal_lane1_pma_reset_n_net_0,
        hv_lane0_pcs_reset_n   => hv_lane0_pcs_reset_n_net_0,
        hv_lane1_pcs_reset_n   => hv_lane1_pcs_reset_n_net_0,
        hv_lane0_pma_reset_n   => hv_lane0_pma_reset_n_net_0,
        hv_lane1_pma_reset_n   => hv_lane1_pma_reset_n_net_0,
        dtc_enable_reset       => dtc_enable_reset_net_0,
        force_full             => force_full_net_0,
        align_roc_to_digi      => align_roc_to_digi_net_0,
        dtc_error_address      => dtc_error_address_net_0,
        cal_serdes_reset_n     => cal_serdes_reset_n_net_0,
        hv_serdes_reset_n      => hv_serdes_reset_n_net_0,
        dtc_serdes_reset_n     => dtc_serdes_reset_n_net_0,
        event_window_expected  => event_window_expected_net_0,
        TIMERENABLE            => Registers_0_TIMERENABLE,
        TIMERRESET             => Registers_0_TIMERRESET,
        -- Inouts
        hvsda                  => hvsda,
        calsda                 => calsda 
        );
-- SPI0_0
SPI0_0 : SPI0
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        SPISSI     => VCC_net,
        SPISDI     => SPI0_MISO,
        SPICLKI    => VCC_net,
        PADDR      => APB3_0_APBmslave0_PADDR_3,
        PSEL       => APB3_0_APBmslave4_PSELx,
        PENABLE    => APB3_0_APBmslave0_PENABLE,
        PWRITE     => APB3_0_APBmslave0_PWRITE,
        PWDATA     => APB3_0_APBmslave0_PWDATA,
        -- Outputs
        SPIINT     => OPEN,
        SPIRXAVAIL => OPEN,
        SPITXRFM   => OPEN,
        SPISS      => SPISS_net_2,
        SPISCLKO   => SPI0_SCLK_net_0,
        SPIOEN     => OPEN,
        SPISDO     => SPI0_MOSI_net_0,
        SPIMODE    => OPEN,
        PRDATA     => APB3_0_APBmslave4_PRDATA,
        PREADY     => APB3_0_APBmslave4_PREADY,
        PSLVERR    => APB3_0_APBmslave4_PSLVERR 
        );
-- SPI0_1
SPI0_1 : SPI0
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        SPISSI     => VCC_net,
        SPISDI     => SPI1_MISO,
        SPICLKI    => VCC_net,
        PADDR      => APB3_0_APBmslave0_PADDR_4,
        PSEL       => APB3_0_APBmslave5_PSELx,
        PENABLE    => APB3_0_APBmslave0_PENABLE,
        PWRITE     => APB3_0_APBmslave0_PWRITE,
        PWDATA     => APB3_0_APBmslave0_PWDATA,
        -- Outputs
        SPIINT     => OPEN,
        SPIRXAVAIL => OPEN,
        SPITXRFM   => OPEN,
        SPISS      => SPISS_net_3,
        SPISCLKO   => SPI1_SCLK_net_0,
        SPIOEN     => OPEN,
        SPISDO     => SPI1_MOSI_net_0,
        SPIMODE    => OPEN,
        PRDATA     => APB3_0_APBmslave5_PRDATA,
        PREADY     => APB3_0_APBmslave5_PREADY,
        PSLVERR    => APB3_0_APBmslave5_PSLVERR 
        );
-- SPI_KEY_0
SPI_KEY_0 : SPI_KEY
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        SPISSI     => VCC_net,
        SPISDI     => SPI2_MISO,
        SPICLKI    => VCC_net,
        PADDR      => APB3_0_APBmslave0_PADDR_7,
        PSEL       => APB3_0_APBmslave9_PSELx,
        PENABLE    => APB3_0_APBmslave0_PENABLE,
        PWRITE     => APB3_0_APBmslave0_PWRITE,
        PWDATA     => APB3_0_APBmslave0_PWDATA,
        -- Outputs
        SPIINT     => OPEN,
        SPIRXAVAIL => OPEN,
        SPITXRFM   => OPEN,
        SPISS      => SPISS_net_4,
        SPISCLKO   => SPI2_SCLK_net_0,
        SPIOEN     => OPEN,
        SPISDO     => SPI2_MOSI_net_0,
        SPIMODE    => OPEN,
        PRDATA     => APB3_0_APBmslave9_PRDATA,
        PREADY     => APB3_0_APBmslave9_PREADY,
        PSLVERR    => APB3_0_APBmslave9_PSLVERR 
        );
-- TVS_Interface_0
TVS_Interface_0 : TVS_Interface
    port map( 
        -- Inputs
        R_CLK    => PCLK,
        clk      => PCLK,
        resetn_i => AND2_0_Y,
        R_ADDR   => Registers_0_ROCTVS_ADDR,
        -- Outputs
        R_DATA   => TVS_Interface_0_R_DATA 
        );
-- UARTapb_0
UARTapb_0 : UARTapb
    port map( 
        -- Inputs
        PCLK        => PCLK,
        PRESETN     => PRESETN,
        RX          => RX,
        PADDR       => APB3_0_APBmslave0_PADDR_2,
        PSEL        => APB3_0_APBmslave3_PSELx,
        PENABLE     => APB3_0_APBmslave0_PENABLE,
        PWRITE      => APB3_0_APBmslave0_PWRITE,
        PWDATA      => APB3_0_APBmslave0_PWDATA_0,
        -- Outputs
        TXRDY       => OPEN,
        RXRDY       => OPEN,
        PARITY_ERR  => OPEN,
        OVERFLOW    => OPEN,
        TX          => TX_net_0,
        FRAMING_ERR => OPEN,
        PRDATA      => APB3_0_APBmslave3_PRDATA,
        PREADY      => APB3_0_APBmslave3_PREADY,
        PSLVERR     => APB3_0_APBmslave3_PSLVERR 
        );

end RTL;
