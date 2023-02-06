----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:25:43 2023
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
-- ROC entity declaration
----------------------------------------------------------------------
entity ROC is
    -- Port list
    port(
        -- Inputs
        CAL_PREAMP_MISO        : in    std_logic;
        CALtoROC_SERDES_TXD0_N : in    std_logic;
        CALtoROC_SERDES_TXD0_P : in    std_logic;
        CALtoROC_SERDES_TXD1_N : in    std_logic;
        CALtoROC_SERDES_TXD1_P : in    std_logic;
        HV_PREAMP_MISO         : in    std_logic;
        HVtoROC_SERDES_TXD0_N  : in    std_logic;
        HVtoROC_SERDES_TXD0_P  : in    std_logic;
        HVtoROC_SERDES_TXD1_N  : in    std_logic;
        HVtoROC_SERDES_TXD1_P  : in    std_logic;
        KEY_IO1                : in    std_logic;
        ROC_CLK_N              : in    std_logic;
        ROC_CLK_P              : in    std_logic;
        ROC_DTC_SERDES_RXD0_N  : in    std_logic;
        ROC_DTC_SERDES_RXD0_P  : in    std_logic;
        ROC_SPI0_MISO          : in    std_logic;
        ROC_SPI1_MISO          : in    std_logic;
        ROCtoCAL_SERDES_CLK0_N : in    std_logic;
        ROCtoCAL_SERDES_CLK0_P : in    std_logic;
        ROCtoDTC_SERDES_CLK_N  : in    std_logic;
        ROCtoDTC_SERDES_CLK_P  : in    std_logic;
        ROCtoHV_SERDES_CLK0_N  : in    std_logic;
        ROCtoHV_SERDES_CLK0_P  : in    std_logic;
        TCK                    : in    std_logic;
        TDI                    : in    std_logic;
        TMS                    : in    std_logic;
        TRSTB                  : in    std_logic;
        -- Outputs
        ALIGNMENT_LOSS_COUNTER : out   std_logic_vector(7 downto 0);
        CAL_CALEVEN_N          : out   std_logic;
        CAL_CALEVEN_P          : out   std_logic;
        CAL_CALODD_N           : out   std_logic;
        CAL_CALODD_P           : out   std_logic;
        CAL_PREAMP_CE0n        : out   std_logic;
        CAL_PREAMP_CE1n        : out   std_logic;
        CAL_PREAMP_MOSI        : out   std_logic;
        CAL_PREAMP_SCLK        : out   std_logic;
        CLOCK_ALIGNED          : out   std_logic;
        DDR4_ACTn              : out   std_logic;
        DDR4_ADDR              : out   std_logic_vector(13 downto 0);
        DDR4_ADDR14            : out   std_logic;
        DDR4_ADDR15            : out   std_logic;
        DDR4_ADDR16            : out   std_logic;
        DDR4_BA                : out   std_logic_vector(1 downto 0);
        DDR4_BG0               : out   std_logic;
        DDR4_CKE0              : out   std_logic;
        DDR4_CLK0_N            : out   std_logic;
        DDR4_CLK0_P            : out   std_logic;
        DDR4_CS0N              : out   std_logic;
        DDR4_DQM               : out   std_logic_vector(3 downto 0);
        DDR4_ODT0              : out   std_logic;
        DDR4_RESETn            : out   std_logic;
        HV_PREAMP_CE0n         : out   std_logic;
        HV_PREAMP_CE1n         : out   std_logic;
        HV_PREAMP_MOSI         : out   std_logic;
        HV_PREAMP_SCLK         : out   std_logic;
        KEY_IO0                : out   std_logic;
        ROC_ACCEL_CLK0_N       : out   std_logic;
        ROC_ACCEL_CLK0_P       : out   std_logic;
        ROC_ACCEL_CLK1_N       : out   std_logic;
        ROC_ACCEL_CLK1_P       : out   std_logic;
        ROC_CAL_DEVRSTn        : out   std_logic;
        ROC_CAL_LVDS0_N        : out   std_logic;
        ROC_CAL_LVDS0_P        : out   std_logic;
        ROC_DTC_SERDES_TXD0_N  : out   std_logic;
        ROC_DTC_SERDES_TXD0_P  : out   std_logic;
        ROC_HV_DEVRSTn         : out   std_logic;
        ROC_HV_LVDS0_N         : out   std_logic;
        ROC_HV_LVDS0_P         : out   std_logic;
        ROC_LED0_n             : out   std_logic;
        ROC_SPI0_ADC0_CEn      : out   std_logic;
        ROC_SPI0_ADC1_CEn      : out   std_logic;
        ROC_SPI0_ADC2_CEn      : out   std_logic;
        ROC_SPI0_MOSI          : out   std_logic;
        ROC_SPI0_SCLK          : out   std_logic;
        ROC_SPI1_ADC0_CEn      : out   std_logic;
        ROC_SPI1_ADC1_CEn      : out   std_logic;
        ROC_SPI1_ADC2_CEn      : out   std_logic;
        ROC_SPI1_MOSI          : out   std_logic;
        ROC_SPI1_SCLK          : out   std_logic;
        ROCtoCAL_CLK0_N        : out   std_logic;
        ROCtoCAL_CLK0_P        : out   std_logic;
        ROCtoCAL_LVTTL1        : out   std_logic;
        ROCtoCAL_SERDES_TXD0_N : out   std_logic;
        ROCtoCAL_SERDES_TXD0_P : out   std_logic;
        ROCtoCAL_SERDES_TXD1_N : out   std_logic;
        ROCtoCAL_SERDES_TXD1_P : out   std_logic;
        ROCtoHV_CLK0_N         : out   std_logic;
        ROCtoHV_CLK0_P         : out   std_logic;
        ROCtoHV_LVTTL0         : out   std_logic;
        ROCtoHV_SERDES_TXD0_N  : out   std_logic;
        ROCtoHV_SERDES_TXD0_P  : out   std_logic;
        ROCtoHV_SERDES_TXD1_N  : out   std_logic;
        ROCtoHV_SERDES_TXD1_P  : out   std_logic;
        SHIELD0                : out   std_logic;
        SHIELD1                : out   std_logic;
        SHIELD2                : out   std_logic;
        SHIELD3                : out   std_logic;
        TDO                    : out   std_logic;
        word_aligned           : out   std_logic;
        -- Inouts
        DDR4_DQ                : inout std_logic_vector(31 downto 0);
        DDR4_DQS_N             : inout std_logic_vector(3 downto 0);
        DDR4_DQS_P             : inout std_logic_vector(3 downto 0);
        ROCtoCAL_LVTTL2        : inout std_logic;
        ROCtoHV_LVTTL1         : inout std_logic
        );
end ROC;
----------------------------------------------------------------------
-- ROC architecture body
----------------------------------------------------------------------
architecture RTL of ROC is
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
-- AND3
component AND3
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        C : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- CLKINT
component CLKINT
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- COREJTAGDEBUG_C0
component COREJTAGDEBUG_C0
    -- Port list
    port(
        -- Inputs
        TCK        : in  std_logic;
        TDI        : in  std_logic;
        TGT_TDO_0  : in  std_logic;
        TMS        : in  std_logic;
        TRSTB      : in  std_logic;
        -- Outputs
        TDO        : out std_logic;
        TGT_TCK_0  : out std_logic;
        TGT_TDI_0  : out std_logic;
        TGT_TMS_0  : out std_logic;
        TGT_TRST_0 : out std_logic
        );
end component;
-- CORERESET
component CORERESET
    -- Port list
    port(
        -- Inputs
        BANK_x_VDDI_STATUS : in  std_logic;
        BANK_y_VDDI_STATUS : in  std_logic;
        CLK                : in  std_logic;
        EXT_RST_N          : in  std_logic;
        FF_US_RESTORE      : in  std_logic;
        FPGA_POR_N         : in  std_logic;
        INIT_DONE          : in  std_logic;
        PLL_LOCK           : in  std_logic;
        SS_BUSY            : in  std_logic;
        -- Outputs
        FABRIC_RESET_N     : out std_logic;
        PLL_POWERDOWN_B    : out std_logic
        );
end component;
-- counter_16bit
component counter_16bit
    -- Port list
    port(
        -- Inputs
        clk   : in  std_logic;
        en    : in  std_logic;
        rst_n : in  std_logic;
        -- Outputs
        cnt   : out std_logic_vector(15 downto 0)
        );
end component;
-- DFN1
component DFN1
    -- Port list
    port(
        -- Inputs
        CLK : in  std_logic;
        D   : in  std_logic;
        -- Outputs
        Q   : out std_logic
        );
end component;
-- DigiInterface
component DigiInterface
    -- Port list
    port(
        -- Inputs
        CTRL_ARST_N            : in  std_logic;
        CTRL_CLK               : in  std_logic;
        DCS_use_lane           : in  std_logic_vector(3 downto 0);
        FPGA_POR_N             : in  std_logic;
        INIT_DONE              : in  std_logic;
        LANE0_PCS_ARST_N       : in  std_logic;
        LANE0_PCS_ARST_N_0     : in  std_logic;
        LANE0_PMA_ARST_N       : in  std_logic;
        LANE0_PMA_ARST_N_0     : in  std_logic;
        LANE0_RXD_N            : in  std_logic;
        LANE0_RXD_N_0          : in  std_logic;
        LANE0_RXD_P            : in  std_logic;
        LANE0_RXD_P_0          : in  std_logic;
        LANE1_PCS_ARST_N       : in  std_logic;
        LANE1_PCS_ARST_N_0     : in  std_logic;
        LANE1_PMA_ARST_N       : in  std_logic;
        LANE1_PMA_ARST_N_0     : in  std_logic;
        LANE1_RXD_N            : in  std_logic;
        LANE1_RXD_N_0          : in  std_logic;
        LANE1_RXD_P            : in  std_logic;
        LANE1_RXD_P_0          : in  std_logic;
        REF_CLK_PAD_N          : in  std_logic;
        REF_CLK_PAD_N_0        : in  std_logic;
        REF_CLK_PAD_P          : in  std_logic;
        REF_CLK_PAD_P_0        : in  std_logic;
        SERIAL_use_lane        : in  std_logic_vector(3 downto 0);
        align                  : in  std_logic;
        axi_start_on_serdesclk : in  std_logic;
        ew_fifo_full           : in  std_logic;
        fifo_rclk              : in  std_logic;
        fifo_resetn            : in  std_logic;
        force_full             : in  std_logic;
        serdesclk_resetn       : in  std_logic;
        serialfifo_rclk        : in  std_logic;
        serialfifo_re          : in  std_logic;
        use_uart               : in  std_logic;
        -- Outputs
        CAL_lane0_empty        : out std_logic;
        CAL_lane1_empty        : out std_logic;
        HV_lane0_empty         : out std_logic;
        HV_lane1_empty         : out std_logic;
        LANE0_TXD_N            : out std_logic;
        LANE0_TXD_N_0          : out std_logic;
        LANE0_TXD_P            : out std_logic;
        LANE0_TXD_P_0          : out std_logic;
        LANE1_TXD_N            : out std_logic;
        LANE1_TXD_N_0          : out std_logic;
        LANE1_TXD_P            : out std_logic;
        LANE1_TXD_P_0          : out std_logic;
        cal_lane0_aligned      : out std_logic;
        cal_lane0_alignment    : out std_logic_vector(3 downto 0);
        cal_lane0_error_count  : out std_logic_vector(7 downto 0);
        cal_lane1_aligned      : out std_logic;
        cal_lane1_alignment    : out std_logic_vector(3 downto 0);
        cal_lane1_error_count  : out std_logic_vector(7 downto 0);
        curr_ewfifo_wr         : out std_logic;
        ew_done                : out std_logic;
        ew_fifo_data           : out std_logic_vector(31 downto 0);
        ew_fifo_we             : out std_logic;
        ew_ovfl                : out std_logic;
        ew_size                : out std_logic_vector(9 downto 0);
        ew_tag                 : out std_logic_vector(19 downto 0);
        hv_lane0_aligned       : out std_logic;
        hv_lane0_alignment     : out std_logic_vector(3 downto 0);
        hv_lane0_error_count   : out std_logic_vector(7 downto 0);
        hv_lane1_aligned       : out std_logic;
        hv_lane1_alignment     : out std_logic_vector(3 downto 0);
        hv_lane1_error_count   : out std_logic_vector(7 downto 0);
        serialfifo_data        : out std_logic_vector(31 downto 0);
        serialfifo_empty       : out std_logic;
        serialfifo_full        : out std_logic;
        serialfifo_rdcnt       : out std_logic_vector(16 downto 0);
        state_count            : out std_logic_vector(7 downto 0)
        );
end component;
-- DTCSimulator
component DTCSimulator
    -- Port list
    port(
        -- Inputs
        ADDR               : in  std_logic_vector(15 downto 0);
        ALIGN              : in  std_logic;
        BLOCK_CNT          : in  std_logic_vector(15 downto 0);
        DATAREQ_LAST_WORD  : in  std_logic;
        DREQCLK_RESETN     : in  std_logic;
        DREQ_CLK           : in  std_logic;
        EVENT_MODE         : in  std_logic_vector(31 downto 0);
        EVENT_WINDOW_TAG   : in  std_logic_vector(47 downto 0);
        EXT_RST_N          : in  std_logic;
        MARKER_SEL         : in  std_logic;
        MARKER_TYPE        : in  std_logic_vector(3 downto 0);
        MODULE_ID          : in  std_logic_vector(7 downto 0);
        ON_SPILL           : in  std_logic;
        OP_CODE            : in  std_logic_vector(5 downto 0);
        PACKET_TYPE        : in  std_logic_vector(3 downto 0);
        RF_MARKER          : in  std_logic_vector(7 downto 0);
        RXCLK_RESETN       : in  std_logic;
        RX_CLK             : in  std_logic;
        SEQ_NUM            : in  std_logic_vector(3 downto 0);
        SERDESCLK_RESETN   : in  std_logic;
        SERDES_CLK         : in  std_logic;
        SERIAL_CFO_EN      : in  std_logic;
        SERIAL_CFO_PREF_EN : in  std_logic;
        SERIAL_CFO_START   : in  std_logic;
        SERIAL_DELTAHB     : in  std_logic_vector(31 downto 0);
        SERIAL_NUMBERHB    : in  std_logic_vector(31 downto 0);
        SERIAL_OFFSETHB    : in  std_logic_vector(31 downto 0);
        SIM_START          : in  std_logic;
        TXCLK_RESETN       : in  std_logic;
        TX_CLK             : in  std_logic;
        WDATA              : in  std_logic_vector(15 downto 0);
        dreq_ewtag         : in  std_logic_vector(47 downto 0);
        dreq_start         : in  std_logic;
        hb_ewtag           : in  std_logic_vector(47 downto 0);
        hb_start           : in  std_logic;
        -- Outputs
        SIM_TX_DATA        : out std_logic_vector(15 downto 0);
        SIM_TX_KCHAR       : out std_logic_vector(1 downto 0)
        );
end component;
-- EWMaker
component EWMaker
    -- Port list
    port(
        -- Inputs
        digi_clk           : in  std_logic;
        digi_reset_n       : in  std_logic;
        ewm_enable_50mhz   : in  std_logic;
        ewm_period_5ns     : in  std_logic_vector(15 downto 0);
        external_ewm_50mhz : in  std_logic;
        -- Outputs
        ewm                : out std_logic
        );
end component;
-- INBUF_DIFF
component INBUF_DIFF
    -- Port list
    port(
        -- Inputs
        PADN : in  std_logic;
        PADP : in  std_logic;
        -- Outputs
        Y    : out std_logic
        );
end component;
-- INIT_component
component INIT_component
    -- Port list
    port(
        -- Outputs
        AUTOCALIB_DONE             : out std_logic;
        BANK_0_CALIB_STATUS        : out std_logic;
        BANK_1_CALIB_STATUS        : out std_logic;
        BANK_2_VDDI_STATUS         : out std_logic;
        DEVICE_INIT_DONE           : out std_logic;
        FABRIC_POR_N               : out std_logic;
        PCIE_INIT_DONE             : out std_logic;
        SRAM_INIT_DONE             : out std_logic;
        SRAM_INIT_FROM_SNVM_DONE   : out std_logic;
        SRAM_INIT_FROM_SPI_DONE    : out std_logic;
        SRAM_INIT_FROM_UPROM_DONE  : out std_logic;
        USRAM_INIT_DONE            : out std_logic;
        USRAM_INIT_FROM_SNVM_DONE  : out std_logic;
        USRAM_INIT_FROM_SPI_DONE   : out std_logic;
        USRAM_INIT_FROM_UPROM_DONE : out std_logic;
        XCVR_INIT_DONE             : out std_logic
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
-- MIV_RV32IMC_C0
component MIV_RV32IMC_C0
    -- Port list
    port(
        -- Inputs
        AHB_MSTR_HRDATA    : in  std_logic_vector(31 downto 0);
        AHB_MSTR_HREADY    : in  std_logic;
        AHB_MSTR_HRESP     : in  std_logic;
        APB_MSTR_PRDATA    : in  std_logic_vector(31 downto 0);
        APB_MSTR_PREADY    : in  std_logic;
        APB_MSTR_PSLVERR   : in  std_logic;
        CLK                : in  std_logic;
        EXT_IRQ            : in  std_logic;
        EXT_SYS_IRQ        : in  std_logic_vector(5 downto 0);
        JTAG_TCK           : in  std_logic;
        JTAG_TDI           : in  std_logic;
        JTAG_TMS           : in  std_logic;
        JTAG_TRST          : in  std_logic;
        RESETN             : in  std_logic;
        -- Outputs
        AHB_MSTR_HADDR     : out std_logic_vector(31 downto 0);
        AHB_MSTR_HBURST    : out std_logic_vector(2 downto 0);
        AHB_MSTR_HMASTLOCK : out std_logic;
        AHB_MSTR_HPROT     : out std_logic_vector(3 downto 0);
        AHB_MSTR_HSEL      : out std_logic;
        AHB_MSTR_HSIZE     : out std_logic_vector(2 downto 0);
        AHB_MSTR_HTRANS    : out std_logic_vector(1 downto 0);
        AHB_MSTR_HWDATA    : out std_logic_vector(31 downto 0);
        AHB_MSTR_HWRITE    : out std_logic;
        APB_MSTR_PADDR     : out std_logic_vector(31 downto 0);
        APB_MSTR_PENABLE   : out std_logic;
        APB_MSTR_PSEL      : out std_logic;
        APB_MSTR_PWDATA    : out std_logic_vector(31 downto 0);
        APB_MSTR_PWRITE    : out std_logic;
        EXT_RESETN         : out std_logic;
        JTAG_TDO           : out std_logic;
        JTAG_TDO_DR        : out std_logic;
        TIME_COUNT_OUT     : out std_logic_vector(63 downto 0)
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
-- NewDDRInterface
component NewDDRInterface
    -- Port list
    port(
        -- Inputs
        DCS_pattern_en         : in    std_logic;
        DDR_BANK_CALIB         : in    std_logic;
        DIGI_curr_ewfifo_wr    : in    std_logic;
        DIGI_ew_done           : in    std_logic;
        DIGI_ew_fifo_data      : in    std_logic_vector(31 downto 0);
        DIGI_ew_fifo_we        : in    std_logic;
        DIGI_ew_ovfl           : in    std_logic;
        DIGI_ew_size           : in    std_logic_vector(9 downto 0);
        DIGI_ew_tag            : in    std_logic_vector(19 downto 0);
        EXT_RST_N              : in    std_logic;
        FPGA_POR_N             : in    std_logic;
        INIT_DONE              : in    std_logic;
        MEM_CLK                : in    std_logic;
        NEWSPILL               : in    std_logic;
        ONSPILL                : in    std_logic;
        RXCLK_RESETN           : in    std_logic;
        RX_CLK                 : in    std_logic;
        SERIAL_pattern_en      : in    std_logic;
        dreqclk                : in    std_logic;
        dreqclk_resetn         : in    std_logic;
        et_fifo_re             : in    std_logic;
        event_start            : in    std_logic;
        event_window_fetch     : in    std_logic_vector(47 downto 0);
        hb_null_valid          : in    std_logic;
        hb_valid               : in    std_logic;
        pref_valid             : in    std_logic;
        resetn_serdesclk       : in    std_logic;
        run_offset             : in    std_logic_vector(47 downto 0);
        serdesclk              : in    std_logic;
        serial_offset          : in    std_logic_vector(47 downto 0);
        set_serial_offset      : in    std_logic;
        spill_hbtag_in         : in    std_logic_vector(19 downto 0);
        start_fetch            : in    std_logic;
        -- Outputs
        A                      : out   std_logic_vector(13 downto 0);
        ACT_N                  : out   std_logic;
        BA                     : out   std_logic_vector(1 downto 0);
        BG                     : out   std_logic;
        CAS_N                  : out   std_logic;
        CK0                    : out   std_logic;
        CK0_N                  : out   std_logic;
        CKE                    : out   std_logic;
        CS_N                   : out   std_logic;
        CTRLR_READY            : out   std_logic;
        DM_N                   : out   std_logic_vector(3 downto 0);
        DREQ_FIFO_EMPTY        : out   std_logic;
        DREQ_FIFO_FULL         : out   std_logic;
        ODT                    : out   std_logic;
        RAS_N                  : out   std_logic;
        RESET_N                : out   std_logic;
        SHIELD0                : out   std_logic;
        SHIELD1                : out   std_logic;
        SHIELD2                : out   std_logic;
        SHIELD3                : out   std_logic;
        WE_N                   : out   std_logic;
        axi_start_on_serdesclk : out   std_logic;
        data_error             : out   std_logic;
        data_expc              : out   std_logic_vector(63 downto 0);
        data_ready             : out   std_logic;
        data_seen              : out   std_logic_vector(63 downto 0);
        et_fifo_rdata          : out   std_logic_vector(63 downto 0);
        et_pckts               : out   std_logic_vector(9 downto 0);
        event_error            : out   std_logic;
        evt_expc               : out   std_logic_vector(63 downto 0);
        evt_seen               : out   std_logic_vector(63 downto 0);
        ew_DDR_wrap            : out   std_logic;
        ew_fifo_full           : out   std_logic;
        ewtag_offset_out       : out   std_logic_vector(47 downto 0);
        fetch_cnt              : out   std_logic_vector(19 downto 0);
        fetch_pos_cnt          : out   std_logic_vector(1 downto 0);
        hb_cnt                 : out   std_logic_vector(31 downto 0);
        hb_null_cnt            : out   std_logic_vector(31 downto 0);
        hb_seen_cnt            : out   std_logic_vector(31 downto 0);
        hdr1_expc              : out   std_logic_vector(63 downto 0);
        hdr1_seen              : out   std_logic_vector(63 downto 0);
        hdr2_expc              : out   std_logic_vector(63 downto 0);
        hdr2_seen              : out   std_logic_vector(63 downto 0);
        header1_error          : out   std_logic;
        header2_error          : out   std_logic;
        last_word              : out   std_logic;
        pref_seen_cnt          : out   std_logic_vector(31 downto 0);
        start_tag_cnt          : out   std_logic_vector(31 downto 0);
        store_cnt              : out   std_logic_vector(19 downto 0);
        store_pos_cnt          : out   std_logic_vector(1 downto 0);
        tag_done_cnt           : out   std_logic_vector(31 downto 0);
        tag_null_cnt           : out   std_logic_vector(31 downto 0);
        tag_sent_cnt           : out   std_logic_vector(31 downto 0);
        -- Inouts
        DQ                     : inout std_logic_vector(31 downto 0);
        DQS                    : inout std_logic_vector(3 downto 0);
        DQS_N                  : inout std_logic_vector(3 downto 0)
        );
end component;
-- OUTBUF_DIFF
component OUTBUF_DIFF
    -- Port list
    port(
        -- Inputs
        D    : in  std_logic;
        -- Outputs
        PADN : out std_logic;
        PADP : out std_logic
        );
end component;
-- PF_CCC_111
component PF_CCC_111
    -- Port list
    port(
        -- Inputs
        PLL_POWERDOWN_N_0 : in  std_logic;
        REF_CLK_0         : in  std_logic;
        -- Outputs
        OUT0_FABCLK_0     : out std_logic;
        OUT1_FABCLK_0     : out std_logic;
        PLL_LOCK_0        : out std_logic
        );
end component;
-- PF_CCC_C0
component PF_CCC_C0
    -- Port list
    port(
        -- Inputs
        PLL_POWERDOWN_N_0 : in  std_logic;
        REF_CLK_0         : in  std_logic;
        -- Outputs
        OUT0_FABCLK_0     : out std_logic;
        OUT1_FABCLK_0     : out std_logic;
        OUT2_FABCLK_0     : out std_logic;
        OUT3_FABCLK_0     : out std_logic;
        PLL_LOCK_0        : out std_logic
        );
end component;
-- PF_CCC_C1
component PF_CCC_C1
    -- Port list
    port(
        -- Inputs
        PLL_POWERDOWN_N_0 : in  std_logic;
        REF_CLK_0         : in  std_logic;
        -- Outputs
        OUT0_FABCLK_0     : out std_logic;
        OUT1_FABCLK_0     : out std_logic;
        PLL_LOCK_0        : out std_logic
        );
end component;
-- PF_CLK_DIV_C0
component PF_CLK_DIV_C0
    -- Port list
    port(
        -- Inputs
        CLK_IN  : in  std_logic;
        -- Outputs
        CLK_OUT : out std_logic
        );
end component;
-- PF_NGMUX_C0
component PF_NGMUX_C0
    -- Port list
    port(
        -- Inputs
        CLK0    : in  std_logic;
        CLK1    : in  std_logic;
        SEL     : in  std_logic;
        -- Outputs
        CLK_OUT : out std_logic
        );
end component;
-- PF_OSC_0
component PF_OSC_0
    -- Port list
    port(
        -- Outputs
        RCOSC_160MHZ_CLK_DIV : out std_logic;
        RCOSC_160MHZ_GL      : out std_logic
        );
end component;
-- PF_SRAM
component PF_SRAM
    -- Port list
    port(
        -- Inputs
        HADDR     : in  std_logic_vector(31 downto 0);
        HBURST    : in  std_logic_vector(2 downto 0);
        HCLK      : in  std_logic;
        HREADYIN  : in  std_logic;
        HRESETN   : in  std_logic;
        HSEL      : in  std_logic;
        HSIZE     : in  std_logic_vector(2 downto 0);
        HTRANS    : in  std_logic_vector(1 downto 0);
        HWDATA    : in  std_logic_vector(31 downto 0);
        HWRITE    : in  std_logic;
        -- Outputs
        HRDATA    : out std_logic_vector(31 downto 0);
        HREADYOUT : out std_logic;
        HRESP     : out std_logic_vector(1 downto 0)
        );
end component;
-- pulse_stretcher
component pulse_stretcher
    -- Port list
    port(
        -- Inputs
        clk_i      : in  std_logic;
        polarity_i : in  std_logic;
        pulse_i    : in  std_logic;
        resetn_i   : in  std_logic;
        -- Outputs
        gate_o     : out std_logic
        );
end component;
-- SLOWCONTROLS
component SLOWCONTROLS
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
end component;
-- TOP_SERDES
component TOP_SERDES
    -- Port list
    port(
        -- Inputs
        CTRL_ARST_N                : in  std_logic;
        CTRL_CLK                   : in  std_logic;
        DATAREQ_DATA               : in  std_logic_vector(63 downto 0);
        DATAREQ_DATA_READY         : in  std_logic;
        DATAREQ_LAST_WORD          : in  std_logic;
        DATAREQ_PACKETS_IN_EVT     : in  std_logic_vector(9 downto 0);
        DATAREQ_STATUS             : in  std_logic_vector(7 downto 0);
        DCS_CAL_LANE0_EMPTY        : in  std_logic;
        DCS_CAL_LANE1_EMPTY        : in  std_logic;
        DCS_CLK                    : in  std_logic;
        DCS_DATA_ERR               : in  std_logic;
        DCS_DREQCNT                : in  std_logic_vector(31 downto 0);
        DCS_DREQNULL               : in  std_logic_vector(31 downto 0);
        DCS_DREQREAD               : in  std_logic_vector(31 downto 0);
        DCS_DREQSENT               : in  std_logic_vector(31 downto 0);
        DCS_DREQ_FIFO_EMPTY        : in  std_logic;
        DCS_DREQ_FIFO_FULL         : in  std_logic;
        DCS_EVT_ERR                : in  std_logic;
        DCS_FETCH_CNT              : in  std_logic_vector(19 downto 0);
        DCS_FETCH_POS              : in  std_logic_vector(1 downto 0);
        DCS_HBCNT                  : in  std_logic_vector(31 downto 0);
        DCS_HBONHOLD               : in  std_logic_vector(31 downto 0);
        DCS_HDR1_ERR               : in  std_logic;
        DCS_HDR2_ERR               : in  std_logic;
        DCS_HV_LANE0_EMPTY         : in  std_logic;
        DCS_HV_LANE1_EMPTY         : in  std_logic;
        DCS_NULLHBCNT              : in  std_logic_vector(31 downto 0);
        DCS_OFFSETTAG              : in  std_logic_vector(47 downto 0);
        DCS_PREFCNT                : in  std_logic_vector(31 downto 0);
        DCS_STORE_CNT              : in  std_logic_vector(19 downto 0);
        DCS_STORE_POS              : in  std_logic_vector(1 downto 0);
        DREQCLK_RESETN             : in  std_logic;
        DREQ_CLK                   : in  std_logic;
        DTCALIGN_RESETN            : in  std_logic;
        DTCSIM_DATA                : in  std_logic_vector(15 downto 0);
        DTCSIM_EN                  : in  std_logic;
        DTCSIM_KCHAR               : in  std_logic_vector(1 downto 0);
        ENABLE_ALIGNMENT           : in  std_logic;
        EXT_RST_N                  : in  std_logic;
        FPGA_POR_N                 : in  std_logic;
        HRESETN                    : in  std_logic;
        INIT_DONE                  : in  std_logic;
        LANE0_RXD_N                : in  std_logic;
        LANE0_RXD_P                : in  std_logic;
        PLL_LOCK                   : in  std_logic;
        PRBS_DATA                  : in  std_logic_vector(15 downto 0);
        PRBS_EN                    : in  std_logic;
        PRBS_KCHAR                 : in  std_logic_vector(1 downto 0);
        REF_CLK_PAD_N              : in  std_logic;
        REF_CLK_PAD_P              : in  std_logic;
        address_counter            : in  std_logic_vector(7 downto 0);
        cntrl_state_count          : in  std_logic_vector(7 downto 0);
        data_expc                  : in  std_logic_vector(63 downto 0);
        data_seen                  : in  std_logic_vector(63 downto 0);
        evt_expc                   : in  std_logic_vector(63 downto 0);
        evt_seen                   : in  std_logic_vector(63 downto 0);
        ewm_out_counter            : in  std_logic_vector(15 downto 0);
        hdr1_expc                  : in  std_logic_vector(63 downto 0);
        hdr1_seen                  : in  std_logic_vector(63 downto 0);
        hdr2_expc                  : in  std_logic_vector(63 downto 0);
        hdr2_seen                  : in  std_logic_vector(63 downto 0);
        -- Outputs
        ALIGNMENT_LOSS_COUNTER     : out std_logic_vector(7 downto 0);
        CLOCK_ALIGNED              : out std_logic;
        DATAREQ_EVENT_WINDOW_TAG   : out std_logic_vector(47 downto 0);
        DATAREQ_RE_FIFO            : out std_logic;
        DATAREQ_START_EVENT        : out std_logic;
        DCS_DDRRESET               : out std_logic;
        DCS_PATTERN_EN             : out std_logic;
        DCS_TAG_OFFSET             : out std_logic_vector(47 downto 0);
        DCS_USE_LANE               : out std_logic_vector(3 downto 0);
        DTCDATA_OUT                : out std_logic_vector(31 downto 0);
        EVT_MODE                   : out std_logic_vector(31 downto 0);
        EWM_SEEN                   : out std_logic;
        FETCH_EVENT_WINDOW_TAG     : out std_logic_vector(47 downto 0);
        FETCH_START                : out std_logic;
        HEARTBEAT_EVENT_WINDOW_TAG : out std_logic_vector(47 downto 0);
        HEARTBEAT_SEEN             : out std_logic;
        LANE0_RX_CLK_R             : out std_logic;
        LANE0_TXD_N                : out std_logic;
        LANE0_TXD_P                : out std_logic;
        LANE0_TX_CLK_R             : out std_logic;
        NEWSPILL                   : out std_logic;
        NULL_HEARTBEAT_SEEN        : out std_logic;
        ONSPILL                    : out std_logic;
        PCS_ALIGNED                : out std_logic;
        PREFETCH_EVENT_WINDOW_TAG  : out std_logic_vector(47 downto 0);
        PREFETCH_SEEN              : out std_logic;
        RXCLK_RESETN               : out std_logic;
        SPILL_EVENT_WINDOW_TAG     : out std_logic_vector(19 downto 0);
        TXCLK_RESETN               : out std_logic;
        counter_out                : out std_logic_vector(15 downto 0);
        word_aligned               : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal ALIGNMENT_LOSS_COUNTER_net_0                 : std_logic_vector(7 downto 0);
signal AND2_1_Y                                     : std_logic;
signal AND2_3_Y                                     : std_logic;
signal AND3_0_Y                                     : std_logic;
signal AND3_1_Y                                     : std_logic;
signal CAL_CALEVEN_N_net_0                          : std_logic;
signal CAL_CALEVEN_P_net_0                          : std_logic;
signal CAL_CALODD_N_net_0                           : std_logic;
signal CAL_CALODD_P_net_0                           : std_logic;
signal CAL_PREAMP_CE0n_net_0                        : std_logic;
signal CAL_PREAMP_CE1n_net_0                        : std_logic;
signal CAL_PREAMP_MOSI_net_0                        : std_logic;
signal CAL_PREAMP_SCLK_net_0                        : std_logic;
signal CLKINT_0_Y                                   : std_logic;
signal CLOCK_ALIGNED_net_0                          : std_logic;
signal COREJTAGDEBUG_C0_0_TGT_TCK_0                 : std_logic;
signal COREJTAGDEBUG_C0_0_TGT_TDI_0                 : std_logic;
signal COREJTAGDEBUG_C0_0_TGT_TMS_0                 : std_logic;
signal COREJTAGDEBUG_C0_0_TGT_TRST_0                : std_logic;
signal CORERESET_2_LOCK_0_PLL_POWERDOWN_B           : std_logic;
signal CORERESET_2_LOCK_1_PLL_POWERDOWN_B           : std_logic;
signal counter_16bit_0_cnt                          : std_logic_vector(15 downto 0);
signal DDR4_ACTn_net_0                              : std_logic;
signal DDR4_ADDR_net_0                              : std_logic_vector(13 downto 0);
signal DDR4_ADDR14_net_0                            : std_logic;
signal DDR4_ADDR15_net_0                            : std_logic;
signal DDR4_ADDR16_net_0                            : std_logic;
signal DDR4_BA_net_0                                : std_logic_vector(1 downto 0);
signal DDR4_BG0_net_0                               : std_logic;
signal DDR4_CKE0_net_0                              : std_logic;
signal DDR4_CLK0_N_net_0                            : std_logic;
signal DDR4_CLK0_P_net_0                            : std_logic;
signal DDR4_CS0N_net_0                              : std_logic;
signal DDR4_DQM_net_0                               : std_logic_vector(3 downto 0);
signal DDR4_ODT0_net_0                              : std_logic;
signal DDR4_RESETn_net_0                            : std_logic;
signal DFN1_0_Q                                     : std_logic;
signal DigiClkReset_0_FABRIC_RESET_N                : std_logic;
signal DigiFIFOReset_0_FABRIC_RESET_N               : std_logic;
signal DigiInterface_0_cal_lane0_aligned            : std_logic;
signal DigiInterface_0_cal_lane0_alignment          : std_logic_vector(3 downto 0);
signal DigiInterface_0_CAL_lane0_empty              : std_logic;
signal DigiInterface_0_cal_lane0_error_count        : std_logic_vector(7 downto 0);
signal DigiInterface_0_cal_lane1_aligned            : std_logic;
signal DigiInterface_0_cal_lane1_alignment          : std_logic_vector(3 downto 0);
signal DigiInterface_0_CAL_lane1_empty              : std_logic;
signal DigiInterface_0_cal_lane1_error_count        : std_logic_vector(7 downto 0);
signal DigiInterface_0_curr_ewfifo_wr               : std_logic;
signal DigiInterface_0_ew_done                      : std_logic;
signal DigiInterface_0_ew_fifo_data                 : std_logic_vector(31 downto 0);
signal DigiInterface_0_ew_fifo_we                   : std_logic;
signal DigiInterface_0_ew_ovfl                      : std_logic;
signal DigiInterface_0_ew_size                      : std_logic_vector(9 downto 0);
signal DigiInterface_0_ew_tag                       : std_logic_vector(19 downto 0);
signal DigiInterface_0_hv_lane0_aligned             : std_logic;
signal DigiInterface_0_hv_lane0_alignment           : std_logic_vector(3 downto 0);
signal DigiInterface_0_HV_lane0_empty               : std_logic;
signal DigiInterface_0_hv_lane0_error_count         : std_logic_vector(7 downto 0);
signal DigiInterface_0_hv_lane1_aligned             : std_logic;
signal DigiInterface_0_hv_lane1_alignment           : std_logic_vector(3 downto 0);
signal DigiInterface_0_HV_lane1_empty               : std_logic;
signal DigiInterface_0_hv_lane1_error_count         : std_logic_vector(7 downto 0);
signal DigiInterface_0_serialfifo_data              : std_logic_vector(31 downto 0);
signal DigiInterface_0_serialfifo_empty             : std_logic;
signal DigiInterface_0_serialfifo_full              : std_logic;
signal DigiInterface_0_serialfifo_rdcnt             : std_logic_vector(16 downto 0);
signal DigiInterface_0_state_count                  : std_logic_vector(7 downto 0);
signal DigiReset_0_PLL_POWERDOWN_B                  : std_logic;
signal DReqClkReset_FABRIC_RESET_N                  : std_logic;
signal DTCSimulator_0_SIM_TX_DATA                   : std_logic_vector(15 downto 0);
signal DTCSimulator_0_SIM_TX_KCHAR                  : std_logic_vector(1 downto 0);
signal EWMaker_0_ewm                                : std_logic;
signal HV_PREAMP_CE0n_net_0                         : std_logic;
signal HV_PREAMP_CE1n_net_0                         : std_logic;
signal HV_PREAMP_MOSI_net_0                         : std_logic;
signal HV_PREAMP_SCLK_net_0                         : std_logic;
signal INBUF_DIFF_0_Y                               : std_logic;
signal INIT_component_0_BANK_0_CALIB_STATUS         : std_logic;
signal INIT_component_0_BANK_1_CALIB_STATUS         : std_logic;
signal INIT_component_0_BANK_2_VDDI_STATUS          : std_logic;
signal INIT_component_0_DEVICE_INIT_DONE            : std_logic;
signal INIT_component_0_FABRIC_POR_N                : std_logic;
signal INIT_component_0_XCVR_INIT_DONE              : std_logic;
signal INV_1_Y                                      : std_logic;
signal INV_2_Y                                      : std_logic;
signal KEY_IO0_net_0                                : std_logic;
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HADDR            : std_logic_vector(31 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HBURST           : std_logic_vector(2 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HMASTLOCK        : std_logic;
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HPROT            : std_logic_vector(3 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HRDATA           : std_logic_vector(31 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HREADYOUT        : std_logic;
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HSELx            : std_logic;
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HSIZE            : std_logic_vector(2 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HTRANS           : std_logic_vector(1 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HWDATA           : std_logic_vector(31 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HWRITE           : std_logic;
signal MIV_RV32IMC_C0_0_APB_MSTR_PADDR              : std_logic_vector(31 downto 0);
signal MIV_RV32IMC_C0_0_APB_MSTR_PENABLE            : std_logic;
signal MIV_RV32IMC_C0_0_APB_MSTR_PRDATA             : std_logic_vector(31 downto 0);
signal MIV_RV32IMC_C0_0_APB_MSTR_PREADY             : std_logic;
signal MIV_RV32IMC_C0_0_APB_MSTR_PSELx              : std_logic;
signal MIV_RV32IMC_C0_0_APB_MSTR_PSLVERR            : std_logic;
signal MIV_RV32IMC_C0_0_APB_MSTR_PWDATA             : std_logic_vector(31 downto 0);
signal MIV_RV32IMC_C0_0_APB_MSTR_PWRITE             : std_logic;
signal MIV_RV32IMC_C0_0_JTAG_TDO                    : std_logic;
signal MX2_0_Y                                      : std_logic;
signal NewDDRInterface_0_axi_start_on_serdesclk     : std_logic;
signal NewDDRInterface_0_CTRLR_READY                : std_logic;
signal NewDDRInterface_0_data_error                 : std_logic;
signal NewDDRInterface_0_data_expc                  : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_data_ready                 : std_logic;
signal NewDDRInterface_0_data_seen                  : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_DREQ_FIFO_EMPTY            : std_logic;
signal NewDDRInterface_0_DREQ_FIFO_FULL             : std_logic;
signal NewDDRInterface_0_et_fifo_rdata              : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_et_pckts                   : std_logic_vector(9 downto 0);
signal NewDDRInterface_0_event_error                : std_logic;
signal NewDDRInterface_0_evt_expc                   : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_evt_seen                   : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_ew_fifo_full               : std_logic;
signal NewDDRInterface_0_ewtag_offset_out           : std_logic_vector(47 downto 0);
signal NewDDRInterface_0_ewtag_offset_out31to0      : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_fetch_cnt                  : std_logic_vector(19 downto 0);
signal NewDDRInterface_0_fetch_pos_cnt              : std_logic_vector(1 downto 0);
signal NewDDRInterface_0_hb_cnt                     : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_hb_null_cnt                : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_hb_seen_cnt                : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_hdr1_expc                  : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_hdr1_seen                  : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_hdr2_expc                  : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_hdr2_seen                  : std_logic_vector(63 downto 0);
signal NewDDRInterface_0_header1_error              : std_logic;
signal NewDDRInterface_0_header2_error              : std_logic;
signal NewDDRInterface_0_last_word                  : std_logic;
signal NewDDRInterface_0_pref_seen_cnt              : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_start_tag_cnt              : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_store_cnt                  : std_logic_vector(19 downto 0);
signal NewDDRInterface_0_store_pos_cnt              : std_logic_vector(1 downto 0);
signal NewDDRInterface_0_tag_done_cnt               : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_tag_null_cnt               : std_logic_vector(31 downto 0);
signal NewDDRInterface_0_tag_sent_cnt               : std_logic_vector(31 downto 0);
signal PF_CCC_111_0_OUT0_FABCLK_0                   : std_logic;
signal PF_CCC_111_0_OUT1_FABCLK_0                   : std_logic;
signal PF_CCC_111_0_PLL_LOCK_0                      : std_logic;
signal PF_CCC_C0_0_OUT0_FABCLK_0                    : std_logic;
signal PF_CCC_C0_0_OUT1_FABCLK_0                    : std_logic;
signal PF_CCC_C0_0_OUT2_FABCLK_0                    : std_logic;
signal PF_CCC_C0_0_OUT3_FABCLK_0                    : std_logic;
signal PF_CCC_C0_0_PLL_LOCK_0                       : std_logic;
signal PF_CCC_C1_0_OUT0_FABCLK_0                    : std_logic;
signal PF_CCC_C1_0_OUT1_FABCLK_0                    : std_logic;
signal PF_CCC_C1_0_PLL_LOCK_0                       : std_logic;
signal PF_CLK_DIV_C0_0_CLK_OUT                      : std_logic;
signal PF_NGMUX_C0_0_CLK_OUT                        : std_logic;
signal PF_OSC_0_0_RCOSC_160MHZ_CLK_DIV              : std_logic;
signal pulse_stretcher_0_gate_o                     : std_logic;
signal pulse_stretcher_1_gate_o                     : std_logic;
signal Reset50MHz_FABRIC_RESET_N                    : std_logic;
signal ROC_ACCEL_CLK0_N_net_0                       : std_logic;
signal ROC_ACCEL_CLK0_P_net_0                       : std_logic;
signal ROC_ACCEL_CLK1_N_net_0                       : std_logic;
signal ROC_ACCEL_CLK1_P_net_0                       : std_logic;
signal ROC_CAL_LVDS0_N_net_0                        : std_logic;
signal ROC_CAL_LVDS0_P_net_0                        : std_logic;
signal ROC_DTC_SERDES_TXD0_N_net_0                  : std_logic;
signal ROC_DTC_SERDES_TXD0_P_net_0                  : std_logic;
signal ROC_HV_DEVRSTn_net_0                         : std_logic;
signal ROC_HV_LVDS0_N_net_0                         : std_logic;
signal ROC_HV_LVDS0_P_net_0                         : std_logic;
signal ROC_LED0_n_net_0                             : std_logic_vector(0 to 0);
signal ROC_SPI0_ADC0_CEn_net_0                      : std_logic;
signal ROC_SPI0_ADC1_CEn_net_0                      : std_logic;
signal ROC_SPI0_ADC2_CEn_net_0                      : std_logic;
signal ROC_SPI0_MOSI_net_0                          : std_logic;
signal ROC_SPI0_SCLK_net_0                          : std_logic;
signal ROC_SPI1_ADC0_CEn_net_0                      : std_logic;
signal ROC_SPI1_ADC1_CEn_net_0                      : std_logic;
signal ROC_SPI1_ADC2_CEn_net_0                      : std_logic;
signal ROC_SPI1_MOSI_net_0                          : std_logic;
signal ROC_SPI1_SCLK_net_0                          : std_logic;
signal ROCtoCAL_CLK0_N_net_0                        : std_logic;
signal ROCtoCAL_CLK0_P_net_0                        : std_logic;
signal ROCtoCAL_LVTTL1_net_0                        : std_logic;
signal ROCtoCAL_SERDES_TXD0_N_net_0                 : std_logic;
signal ROCtoCAL_SERDES_TXD0_P_net_0                 : std_logic;
signal ROCtoCAL_SERDES_TXD1_N_net_0                 : std_logic;
signal ROCtoCAL_SERDES_TXD1_P_net_0                 : std_logic;
signal ROCtoHV_CLK0_N_net_0                         : std_logic;
signal ROCtoHV_CLK0_P_net_0                         : std_logic;
signal ROCtoHV_LVTTL0_net_0                         : std_logic;
signal ROCtoHV_SERDES_TXD0_N_net_0                  : std_logic;
signal ROCtoHV_SERDES_TXD0_P_net_0                  : std_logic;
signal ROCtoHV_SERDES_TXD1_N_net_0                  : std_logic;
signal ROCtoHV_SERDES_TXD1_P_net_0                  : std_logic;
signal SerdesClkReset_FABRIC_RESET_N                : std_logic;
signal SHIELD0_net_0                                : std_logic;
signal SHIELD1_net_0                                : std_logic;
signal SHIELD2_net_0                                : std_logic;
signal SHIELD3_net_0                                : std_logic;
signal SLOWCONTROLS_0_align_roc_to_digi             : std_logic;
signal SLOWCONTROLS_0_cal_lane0_pcs_reset_n         : std_logic;
signal SLOWCONTROLS_0_cal_lane0_pma_reset_n         : std_logic;
signal SLOWCONTROLS_0_cal_lane1_pcs_reset_n         : std_logic;
signal SLOWCONTROLS_0_cal_lane1_pma_reset_n         : std_logic;
signal SLOWCONTROLS_0_DDR_RESETN                    : std_logic;
signal SLOWCONTROLS_0_DDRCFODELTAHB                 : std_logic_vector(31 downto 0);
signal SLOWCONTROLS_0_DDRCFOEN                      : std_logic;
signal SLOWCONTROLS_0_DDRCFONUMBERHB                : std_logic_vector(31 downto 0);
signal SLOWCONTROLS_0_DDRCFOOFFSET                  : std_logic_vector(31 downto 0);
signal SLOWCONTROLS_0_DDRCFOSTART                   : std_logic;
signal SLOWCONTROLS_0_DDRPREFETCHEN                 : std_logic;
signal SLOWCONTROLS_0_DDRPTTREN                     : std_logic;
signal SLOWCONTROLS_0_DDRSERIALSET                  : std_logic;
signal SLOWCONTROLS_0_DIGIDEVICE_RESETN             : std_logic;
signal SLOWCONTROLS_0_dtc_enable_reset              : std_logic;
signal SLOWCONTROLS_0_dtc_error_address             : std_logic_vector(7 downto 0);
signal SLOWCONTROLS_0_dtc_serdes_reset_n            : std_logic;
signal SLOWCONTROLS_0_DTCALIGN_RESETN               : std_logic;
signal SLOWCONTROLS_0_DTCSIMADDR15to0               : std_logic_vector(15 downto 0);
signal SLOWCONTROLS_0_DTCSIMADDR23to16              : std_logic_vector(23 downto 16);
signal SLOWCONTROLS_0_DTCSIMDATA15to0               : std_logic_vector(15 downto 0);
signal SLOWCONTROLS_0_DTCSIMDATA31to16              : std_logic_vector(31 downto 16);
signal SLOWCONTROLS_0_DTCSIMPARAM3to0               : std_logic_vector(3 downto 0);
signal SLOWCONTROLS_0_DTCSIMPARAM7to4               : std_logic_vector(7 downto 4);
signal SLOWCONTROLS_0_DTCSIMPARAM11to8              : std_logic_vector(11 downto 8);
signal SLOWCONTROLS_0_DTCSIMPARAM21to16             : std_logic_vector(21 downto 16);
signal SLOWCONTROLS_0_DTCSIMPARAM24to24             : std_logic_vector(24 to 24);
signal SLOWCONTROLS_0_DTCSIMPARAM28to28             : std_logic_vector(28 to 28);
signal SLOWCONTROLS_0_DTCSIMSPILLDATA15to0          : std_logic_vector(15 downto 0);
signal SLOWCONTROLS_0_DTCSIMSPILLDATA23to16         : std_logic_vector(23 downto 16);
signal SLOWCONTROLS_0_DTCSIMSPILLDATA30to24         : std_logic_vector(30 downto 24);
signal SLOWCONTROLS_0_DTCSIMSPILLDATA31to31         : std_logic_vector(31 to 31);
signal SLOWCONTROLS_0_DTCSIMSTART                   : std_logic;
signal SLOWCONTROLS_0_enable_fiber_clock            : std_logic;
signal SLOWCONTROLS_0_enable_fiber_marker           : std_logic;
signal SLOWCONTROLS_0_ewm_50mhz                     : std_logic;
signal SLOWCONTROLS_0_ewm_delay                     : std_logic_vector(15 downto 0);
signal SLOWCONTROLS_0_ewm_enable_50mhz              : std_logic;
signal SLOWCONTROLS_0_force_full                    : std_logic;
signal SLOWCONTROLS_0_hv_lane0_pcs_reset_n          : std_logic;
signal SLOWCONTROLS_0_hv_lane0_pma_reset_n          : std_logic;
signal SLOWCONTROLS_0_hv_lane1_pcs_reset_n          : std_logic;
signal SLOWCONTROLS_0_hv_lane1_pma_reset_n          : std_logic;
signal SLOWCONTROLS_0_PWM0                          : std_logic;
signal SLOWCONTROLS_0_reset_fifo_n                  : std_logic;
signal SLOWCONTROLS_0_SERDES_RE                     : std_logic;
signal SLOWCONTROLS_0_use_lane                      : std_logic_vector(3 downto 0);
signal SLOWCONTROLS_0_use_uart                      : std_logic;
signal TDO_net_0                                    : std_logic;
signal TOP_SERDES_0_counter_out                     : std_logic_vector(15 downto 0);
signal TOP_SERDES_0_DATAREQ_EVENT_WINDOW_TAG        : std_logic_vector(47 downto 0);
signal TOP_SERDES_0_DATAREQ_EVENT_WINDOW_TAG31to0   : std_logic_vector(31 downto 0);
signal TOP_SERDES_0_DATAREQ_RE_FIFO                 : std_logic;
signal TOP_SERDES_0_DATAREQ_START_EVENT             : std_logic;
signal TOP_SERDES_0_DCS_DDRRESET                    : std_logic;
signal TOP_SERDES_0_DCS_PATTERN_EN                  : std_logic;
signal TOP_SERDES_0_DCS_USE_LANE                    : std_logic_vector(3 downto 0);
signal TOP_SERDES_0_DTCDATA_OUT                     : std_logic_vector(31 downto 0);
signal TOP_SERDES_0_EWM_SEEN                        : std_logic;
signal TOP_SERDES_0_FETCH_EVENT_WINDOW_TAG          : std_logic_vector(47 downto 0);
signal TOP_SERDES_0_FETCH_EVENT_WINDOW_TAG31to0     : std_logic_vector(31 downto 0);
signal TOP_SERDES_0_FETCH_START                     : std_logic;
signal TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG      : std_logic_vector(47 downto 0);
signal TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG31to0 : std_logic_vector(31 downto 0);
signal TOP_SERDES_0_HEARTBEAT_SEEN                  : std_logic;
signal TOP_SERDES_0_LANE0_RX_CLK_R                  : std_logic;
signal TOP_SERDES_0_LANE0_TX_CLK_R                  : std_logic;
signal TOP_SERDES_0_NEWSPILL                        : std_logic;
signal TOP_SERDES_0_NULL_HEARTBEAT_SEEN             : std_logic;
signal TOP_SERDES_0_ONSPILL                         : std_logic;
signal TOP_SERDES_0_PCS_ALIGNED                     : std_logic;
signal TOP_SERDES_0_PREFETCH_EVENT_WINDOW_TAG31to0  : std_logic_vector(31 downto 0);
signal TOP_SERDES_0_PREFETCH_SEEN                   : std_logic;
signal TOP_SERDES_0_RXCLK_RESETN                    : std_logic;
signal TOP_SERDES_0_SPILL_EVENT_WINDOW_TAG          : std_logic_vector(19 downto 0);
signal TOP_SERDES_0_TXCLK_RESETN                    : std_logic;
signal word_aligned_net_0                           : std_logic;
signal CAL_CALEVEN_N_net_1                          : std_logic;
signal CAL_CALEVEN_P_net_1                          : std_logic;
signal CAL_CALODD_N_net_1                           : std_logic;
signal CAL_CALODD_P_net_1                           : std_logic;
signal CAL_PREAMP_CE0n_net_1                        : std_logic;
signal CAL_PREAMP_CE1n_net_1                        : std_logic;
signal CAL_PREAMP_MOSI_net_1                        : std_logic;
signal CAL_PREAMP_SCLK_net_1                        : std_logic;
signal CLOCK_ALIGNED_net_1                          : std_logic;
signal DDR4_ACTn_net_1                              : std_logic;
signal DDR4_ADDR14_net_1                            : std_logic;
signal DDR4_ADDR15_net_1                            : std_logic;
signal DDR4_ADDR16_net_1                            : std_logic;
signal DDR4_BG0_net_1                               : std_logic;
signal DDR4_CKE0_net_1                              : std_logic;
signal DDR4_CLK0_N_net_1                            : std_logic;
signal DDR4_CLK0_P_net_1                            : std_logic;
signal DDR4_CS0N_net_1                              : std_logic;
signal DDR4_ODT0_net_1                              : std_logic;
signal DDR4_RESETn_net_1                            : std_logic;
signal HV_PREAMP_CE0n_net_1                         : std_logic;
signal HV_PREAMP_CE1n_net_1                         : std_logic;
signal HV_PREAMP_MOSI_net_1                         : std_logic;
signal HV_PREAMP_SCLK_net_1                         : std_logic;
signal KEY_IO0_net_1                                : std_logic;
signal ROC_ACCEL_CLK0_N_net_1                       : std_logic;
signal ROC_ACCEL_CLK0_P_net_1                       : std_logic;
signal ROC_ACCEL_CLK1_N_net_1                       : std_logic;
signal ROC_ACCEL_CLK1_P_net_1                       : std_logic;
signal ROC_HV_DEVRSTn_net_1                         : std_logic;
signal ROC_CAL_LVDS0_N_net_1                        : std_logic;
signal ROC_CAL_LVDS0_P_net_1                        : std_logic;
signal ROC_DTC_SERDES_TXD0_N_net_1                  : std_logic;
signal ROC_DTC_SERDES_TXD0_P_net_1                  : std_logic;
signal ROC_HV_DEVRSTn_net_2                         : std_logic;
signal ROC_HV_LVDS0_N_net_1                         : std_logic;
signal ROC_HV_LVDS0_P_net_1                         : std_logic;
signal ROC_LED0_n_net_1                             : std_logic;
signal ROC_SPI0_ADC0_CEn_net_1                      : std_logic;
signal ROC_SPI0_ADC1_CEn_net_1                      : std_logic;
signal ROC_SPI0_ADC2_CEn_net_1                      : std_logic;
signal ROC_SPI0_MOSI_net_1                          : std_logic;
signal ROC_SPI0_SCLK_net_1                          : std_logic;
signal ROC_SPI1_ADC0_CEn_net_1                      : std_logic;
signal ROC_SPI1_ADC1_CEn_net_1                      : std_logic;
signal ROC_SPI1_ADC2_CEn_net_1                      : std_logic;
signal ROC_SPI1_MOSI_net_1                          : std_logic;
signal ROC_SPI1_SCLK_net_1                          : std_logic;
signal ROCtoCAL_CLK0_N_net_1                        : std_logic;
signal ROCtoCAL_CLK0_P_net_1                        : std_logic;
signal ROCtoCAL_LVTTL1_net_1                        : std_logic;
signal ROCtoCAL_SERDES_TXD0_N_net_1                 : std_logic;
signal ROCtoCAL_SERDES_TXD0_P_net_1                 : std_logic;
signal ROCtoCAL_SERDES_TXD1_N_net_1                 : std_logic;
signal ROCtoCAL_SERDES_TXD1_P_net_1                 : std_logic;
signal ROCtoHV_CLK0_N_net_1                         : std_logic;
signal ROCtoHV_CLK0_P_net_1                         : std_logic;
signal ROCtoHV_LVTTL0_net_1                         : std_logic;
signal ROCtoHV_SERDES_TXD0_N_net_1                  : std_logic;
signal ROCtoHV_SERDES_TXD0_P_net_1                  : std_logic;
signal ROCtoHV_SERDES_TXD1_N_net_1                  : std_logic;
signal ROCtoHV_SERDES_TXD1_P_net_1                  : std_logic;
signal SHIELD0_net_1                                : std_logic;
signal SHIELD1_net_1                                : std_logic;
signal SHIELD2_net_1                                : std_logic;
signal SHIELD3_net_1                                : std_logic;
signal TDO_net_1                                    : std_logic;
signal word_aligned_net_1                           : std_logic;
signal ALIGNMENT_LOSS_COUNTER_net_1                 : std_logic_vector(7 downto 0);
signal DDR4_ADDR_net_1                              : std_logic_vector(13 downto 0);
signal DDR4_BA_net_1                                : std_logic_vector(1 downto 0);
signal DDR4_DQM_net_1                               : std_logic_vector(3 downto 0);
signal GPIO_OUT_slice_0                             : std_logic_vector(3 downto 1);
signal EVENT_MODE_net_0                             : std_logic_vector(31 downto 0);
signal EVENT_WINDOW_TAG_net_0                       : std_logic_vector(47 downto 0);
signal RF_MARKER_net_0                              : std_logic_vector(7 downto 0);
signal EXT_SYS_IRQ_net_0                            : std_logic_vector(5 downto 0);
signal serial_offset_net_0                          : std_logic_vector(47 downto 0);
signal DDRERROR_net_0                               : std_logic_vector(3 downto 0);
signal DDRSIZERD_net_0                              : std_logic_vector(31 downto 0);
signal DDRSIZEWR_net_0                              : std_logic_vector(31 downto 0);
signal DTCSIMADDR_net_0                             : std_logic_vector(31 downto 0);
signal DTCSIMDATA_net_0                             : std_logic_vector(31 downto 0);
signal DTCSIMPARAM_net_0                            : std_logic_vector(31 downto 0);
signal DTCSIMSPILLDATA_net_0                        : std_logic_vector(31 downto 0);
signal GPIO_OUT_net_0                               : std_logic_vector(3 downto 0);
signal PREFETCH_EVENT_WINDOW_TAG_net_0              : std_logic_vector(47 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                      : std_logic;
signal GND_net                                      : std_logic;
signal EVENT_MODE_const_net_0                       : std_logic_vector(15 downto 8);
signal EVENT_MODE_const_net_1                       : std_logic_vector(23 downto 16);
signal EVENT_MODE_const_net_2                       : std_logic_vector(31 downto 24);
signal EVENT_WINDOW_TAG_const_net_0                 : std_logic_vector(31 downto 16);
signal EVENT_WINDOW_TAG_const_net_1                 : std_logic_vector(47 downto 32);
signal serial_offset_const_net_0                    : std_logic_vector(47 downto 32);
signal DDRSIZERD_const_net_0                        : std_logic_vector(23 downto 20);
signal DDRSIZERD_const_net_1                        : std_logic_vector(27 downto 26);
signal DDRSIZERD_const_net_2                        : std_logic_vector(31 downto 29);
signal DDRSIZEWR_const_net_0                        : std_logic_vector(23 downto 20);
signal DDRSIZEWR_const_net_1                        : std_logic_vector(27 downto 26);
signal DDRSIZEWR_const_net_2                        : std_logic_vector(31 downto 29);
signal dummy_status_out0_const_net_0                : std_logic_vector(7 downto 0);
signal dummy_status_out1_const_net_0                : std_logic_vector(7 downto 0);
signal dummy_status_out2_const_net_0                : std_logic_vector(7 downto 0);
signal dummy_status_out3_const_net_0                : std_logic_vector(7 downto 0);
signal remote_token0_const_net_0                    : std_logic_vector(7 downto 0);
signal remote_token1_const_net_0                    : std_logic_vector(7 downto 0);
signal remote_token2_const_net_0                    : std_logic_vector(7 downto 0);
signal remote_token3_const_net_0                    : std_logic_vector(7 downto 0);
signal serdes_aligned_const_net_0                   : std_logic_vector(3 downto 0);
signal serdes_data0_const_net_0                     : std_logic_vector(31 downto 0);
signal serdes_data1_const_net_0                     : std_logic_vector(31 downto 0);
signal serdes_data2_const_net_0                     : std_logic_vector(31 downto 0);
signal serdes_data3_const_net_0                     : std_logic_vector(31 downto 0);
signal serdes_rdcnt0_const_net_0                    : std_logic_vector(12 downto 0);
signal serdes_rdcnt1_const_net_0                    : std_logic_vector(12 downto 0);
signal serdes_rdcnt2_const_net_0                    : std_logic_vector(12 downto 0);
signal serdes_rdcnt3_const_net_0                    : std_logic_vector(12 downto 0);
signal DATAREQ_STATUS_const_net_0                   : std_logic_vector(7 downto 0);
signal PRBS_DATA_const_net_0                        : std_logic_vector(15 downto 0);
signal PRBS_KCHAR_const_net_0                       : std_logic_vector(1 downto 0);
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP            : std_logic_vector(1 downto 0);
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP_0          : std_logic;
signal MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP_0_0to0     : std_logic_vector(0 to 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net                       <= '1';
 GND_net                       <= '0';
 EVENT_MODE_const_net_0        <= B"00000000";
 EVENT_MODE_const_net_1        <= B"00000000";
 EVENT_MODE_const_net_2        <= B"00000000";
 EVENT_WINDOW_TAG_const_net_0  <= B"0000000000000000";
 EVENT_WINDOW_TAG_const_net_1  <= B"0000000000000000";
 serial_offset_const_net_0     <= B"0000000000000000";
 DDRSIZERD_const_net_0         <= B"0000";
 DDRSIZERD_const_net_1         <= B"00";
 DDRSIZERD_const_net_2         <= B"000";
 DDRSIZEWR_const_net_0         <= B"0000";
 DDRSIZEWR_const_net_1         <= B"00";
 DDRSIZEWR_const_net_2         <= B"000";
 dummy_status_out0_const_net_0 <= B"00000000";
 dummy_status_out1_const_net_0 <= B"00000000";
 dummy_status_out2_const_net_0 <= B"00000000";
 dummy_status_out3_const_net_0 <= B"00000000";
 remote_token0_const_net_0     <= B"00000000";
 remote_token1_const_net_0     <= B"00000000";
 remote_token2_const_net_0     <= B"00000000";
 remote_token3_const_net_0     <= B"00000000";
 serdes_aligned_const_net_0    <= B"0000";
 serdes_data0_const_net_0      <= B"00000000000000000000000000000000";
 serdes_data1_const_net_0      <= B"00000000000000000000000000000000";
 serdes_data2_const_net_0      <= B"00000000000000000000000000000000";
 serdes_data3_const_net_0      <= B"00000000000000000000000000000000";
 serdes_rdcnt0_const_net_0     <= B"0000000000000";
 serdes_rdcnt1_const_net_0     <= B"0000000000000";
 serdes_rdcnt2_const_net_0     <= B"0000000000000";
 serdes_rdcnt3_const_net_0     <= B"0000000000000";
 DATAREQ_STATUS_const_net_0    <= B"01010101";
 PRBS_DATA_const_net_0         <= B"0000000000000000";
 PRBS_KCHAR_const_net_0        <= B"00";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CAL_CALEVEN_N_net_1                <= CAL_CALEVEN_N_net_0;
 CAL_CALEVEN_N                      <= CAL_CALEVEN_N_net_1;
 CAL_CALEVEN_P_net_1                <= CAL_CALEVEN_P_net_0;
 CAL_CALEVEN_P                      <= CAL_CALEVEN_P_net_1;
 CAL_CALODD_N_net_1                 <= CAL_CALODD_N_net_0;
 CAL_CALODD_N                       <= CAL_CALODD_N_net_1;
 CAL_CALODD_P_net_1                 <= CAL_CALODD_P_net_0;
 CAL_CALODD_P                       <= CAL_CALODD_P_net_1;
 CAL_PREAMP_CE0n_net_1              <= CAL_PREAMP_CE0n_net_0;
 CAL_PREAMP_CE0n                    <= CAL_PREAMP_CE0n_net_1;
 CAL_PREAMP_CE1n_net_1              <= CAL_PREAMP_CE1n_net_0;
 CAL_PREAMP_CE1n                    <= CAL_PREAMP_CE1n_net_1;
 CAL_PREAMP_MOSI_net_1              <= CAL_PREAMP_MOSI_net_0;
 CAL_PREAMP_MOSI                    <= CAL_PREAMP_MOSI_net_1;
 CAL_PREAMP_SCLK_net_1              <= CAL_PREAMP_SCLK_net_0;
 CAL_PREAMP_SCLK                    <= CAL_PREAMP_SCLK_net_1;
 CLOCK_ALIGNED_net_1                <= CLOCK_ALIGNED_net_0;
 CLOCK_ALIGNED                      <= CLOCK_ALIGNED_net_1;
 DDR4_ACTn_net_1                    <= DDR4_ACTn_net_0;
 DDR4_ACTn                          <= DDR4_ACTn_net_1;
 DDR4_ADDR14_net_1                  <= DDR4_ADDR14_net_0;
 DDR4_ADDR14                        <= DDR4_ADDR14_net_1;
 DDR4_ADDR15_net_1                  <= DDR4_ADDR15_net_0;
 DDR4_ADDR15                        <= DDR4_ADDR15_net_1;
 DDR4_ADDR16_net_1                  <= DDR4_ADDR16_net_0;
 DDR4_ADDR16                        <= DDR4_ADDR16_net_1;
 DDR4_BG0_net_1                     <= DDR4_BG0_net_0;
 DDR4_BG0                           <= DDR4_BG0_net_1;
 DDR4_CKE0_net_1                    <= DDR4_CKE0_net_0;
 DDR4_CKE0                          <= DDR4_CKE0_net_1;
 DDR4_CLK0_N_net_1                  <= DDR4_CLK0_N_net_0;
 DDR4_CLK0_N                        <= DDR4_CLK0_N_net_1;
 DDR4_CLK0_P_net_1                  <= DDR4_CLK0_P_net_0;
 DDR4_CLK0_P                        <= DDR4_CLK0_P_net_1;
 DDR4_CS0N_net_1                    <= DDR4_CS0N_net_0;
 DDR4_CS0N                          <= DDR4_CS0N_net_1;
 DDR4_ODT0_net_1                    <= DDR4_ODT0_net_0;
 DDR4_ODT0                          <= DDR4_ODT0_net_1;
 DDR4_RESETn_net_1                  <= DDR4_RESETn_net_0;
 DDR4_RESETn                        <= DDR4_RESETn_net_1;
 HV_PREAMP_CE0n_net_1               <= HV_PREAMP_CE0n_net_0;
 HV_PREAMP_CE0n                     <= HV_PREAMP_CE0n_net_1;
 HV_PREAMP_CE1n_net_1               <= HV_PREAMP_CE1n_net_0;
 HV_PREAMP_CE1n                     <= HV_PREAMP_CE1n_net_1;
 HV_PREAMP_MOSI_net_1               <= HV_PREAMP_MOSI_net_0;
 HV_PREAMP_MOSI                     <= HV_PREAMP_MOSI_net_1;
 HV_PREAMP_SCLK_net_1               <= HV_PREAMP_SCLK_net_0;
 HV_PREAMP_SCLK                     <= HV_PREAMP_SCLK_net_1;
 KEY_IO0_net_1                      <= KEY_IO0_net_0;
 KEY_IO0                            <= KEY_IO0_net_1;
 ROC_ACCEL_CLK0_N_net_1             <= ROC_ACCEL_CLK0_N_net_0;
 ROC_ACCEL_CLK0_N                   <= ROC_ACCEL_CLK0_N_net_1;
 ROC_ACCEL_CLK0_P_net_1             <= ROC_ACCEL_CLK0_P_net_0;
 ROC_ACCEL_CLK0_P                   <= ROC_ACCEL_CLK0_P_net_1;
 ROC_ACCEL_CLK1_N_net_1             <= ROC_ACCEL_CLK1_N_net_0;
 ROC_ACCEL_CLK1_N                   <= ROC_ACCEL_CLK1_N_net_1;
 ROC_ACCEL_CLK1_P_net_1             <= ROC_ACCEL_CLK1_P_net_0;
 ROC_ACCEL_CLK1_P                   <= ROC_ACCEL_CLK1_P_net_1;
 ROC_HV_DEVRSTn_net_1               <= ROC_HV_DEVRSTn_net_0;
 ROC_CAL_DEVRSTn                    <= ROC_HV_DEVRSTn_net_1;
 ROC_CAL_LVDS0_N_net_1              <= ROC_CAL_LVDS0_N_net_0;
 ROC_CAL_LVDS0_N                    <= ROC_CAL_LVDS0_N_net_1;
 ROC_CAL_LVDS0_P_net_1              <= ROC_CAL_LVDS0_P_net_0;
 ROC_CAL_LVDS0_P                    <= ROC_CAL_LVDS0_P_net_1;
 ROC_DTC_SERDES_TXD0_N_net_1        <= ROC_DTC_SERDES_TXD0_N_net_0;
 ROC_DTC_SERDES_TXD0_N              <= ROC_DTC_SERDES_TXD0_N_net_1;
 ROC_DTC_SERDES_TXD0_P_net_1        <= ROC_DTC_SERDES_TXD0_P_net_0;
 ROC_DTC_SERDES_TXD0_P              <= ROC_DTC_SERDES_TXD0_P_net_1;
 ROC_HV_DEVRSTn_net_2               <= ROC_HV_DEVRSTn_net_0;
 ROC_HV_DEVRSTn                     <= ROC_HV_DEVRSTn_net_2;
 ROC_HV_LVDS0_N_net_1               <= ROC_HV_LVDS0_N_net_0;
 ROC_HV_LVDS0_N                     <= ROC_HV_LVDS0_N_net_1;
 ROC_HV_LVDS0_P_net_1               <= ROC_HV_LVDS0_P_net_0;
 ROC_HV_LVDS0_P                     <= ROC_HV_LVDS0_P_net_1;
 ROC_LED0_n_net_1                   <= ROC_LED0_n_net_0(0);
 ROC_LED0_n                         <= ROC_LED0_n_net_1;
 ROC_SPI0_ADC0_CEn_net_1            <= ROC_SPI0_ADC0_CEn_net_0;
 ROC_SPI0_ADC0_CEn                  <= ROC_SPI0_ADC0_CEn_net_1;
 ROC_SPI0_ADC1_CEn_net_1            <= ROC_SPI0_ADC1_CEn_net_0;
 ROC_SPI0_ADC1_CEn                  <= ROC_SPI0_ADC1_CEn_net_1;
 ROC_SPI0_ADC2_CEn_net_1            <= ROC_SPI0_ADC2_CEn_net_0;
 ROC_SPI0_ADC2_CEn                  <= ROC_SPI0_ADC2_CEn_net_1;
 ROC_SPI0_MOSI_net_1                <= ROC_SPI0_MOSI_net_0;
 ROC_SPI0_MOSI                      <= ROC_SPI0_MOSI_net_1;
 ROC_SPI0_SCLK_net_1                <= ROC_SPI0_SCLK_net_0;
 ROC_SPI0_SCLK                      <= ROC_SPI0_SCLK_net_1;
 ROC_SPI1_ADC0_CEn_net_1            <= ROC_SPI1_ADC0_CEn_net_0;
 ROC_SPI1_ADC0_CEn                  <= ROC_SPI1_ADC0_CEn_net_1;
 ROC_SPI1_ADC1_CEn_net_1            <= ROC_SPI1_ADC1_CEn_net_0;
 ROC_SPI1_ADC1_CEn                  <= ROC_SPI1_ADC1_CEn_net_1;
 ROC_SPI1_ADC2_CEn_net_1            <= ROC_SPI1_ADC2_CEn_net_0;
 ROC_SPI1_ADC2_CEn                  <= ROC_SPI1_ADC2_CEn_net_1;
 ROC_SPI1_MOSI_net_1                <= ROC_SPI1_MOSI_net_0;
 ROC_SPI1_MOSI                      <= ROC_SPI1_MOSI_net_1;
 ROC_SPI1_SCLK_net_1                <= ROC_SPI1_SCLK_net_0;
 ROC_SPI1_SCLK                      <= ROC_SPI1_SCLK_net_1;
 ROCtoCAL_CLK0_N_net_1              <= ROCtoCAL_CLK0_N_net_0;
 ROCtoCAL_CLK0_N                    <= ROCtoCAL_CLK0_N_net_1;
 ROCtoCAL_CLK0_P_net_1              <= ROCtoCAL_CLK0_P_net_0;
 ROCtoCAL_CLK0_P                    <= ROCtoCAL_CLK0_P_net_1;
 ROCtoCAL_LVTTL1_net_1              <= ROCtoCAL_LVTTL1_net_0;
 ROCtoCAL_LVTTL1                    <= ROCtoCAL_LVTTL1_net_1;
 ROCtoCAL_SERDES_TXD0_N_net_1       <= ROCtoCAL_SERDES_TXD0_N_net_0;
 ROCtoCAL_SERDES_TXD0_N             <= ROCtoCAL_SERDES_TXD0_N_net_1;
 ROCtoCAL_SERDES_TXD0_P_net_1       <= ROCtoCAL_SERDES_TXD0_P_net_0;
 ROCtoCAL_SERDES_TXD0_P             <= ROCtoCAL_SERDES_TXD0_P_net_1;
 ROCtoCAL_SERDES_TXD1_N_net_1       <= ROCtoCAL_SERDES_TXD1_N_net_0;
 ROCtoCAL_SERDES_TXD1_N             <= ROCtoCAL_SERDES_TXD1_N_net_1;
 ROCtoCAL_SERDES_TXD1_P_net_1       <= ROCtoCAL_SERDES_TXD1_P_net_0;
 ROCtoCAL_SERDES_TXD1_P             <= ROCtoCAL_SERDES_TXD1_P_net_1;
 ROCtoHV_CLK0_N_net_1               <= ROCtoHV_CLK0_N_net_0;
 ROCtoHV_CLK0_N                     <= ROCtoHV_CLK0_N_net_1;
 ROCtoHV_CLK0_P_net_1               <= ROCtoHV_CLK0_P_net_0;
 ROCtoHV_CLK0_P                     <= ROCtoHV_CLK0_P_net_1;
 ROCtoHV_LVTTL0_net_1               <= ROCtoHV_LVTTL0_net_0;
 ROCtoHV_LVTTL0                     <= ROCtoHV_LVTTL0_net_1;
 ROCtoHV_SERDES_TXD0_N_net_1        <= ROCtoHV_SERDES_TXD0_N_net_0;
 ROCtoHV_SERDES_TXD0_N              <= ROCtoHV_SERDES_TXD0_N_net_1;
 ROCtoHV_SERDES_TXD0_P_net_1        <= ROCtoHV_SERDES_TXD0_P_net_0;
 ROCtoHV_SERDES_TXD0_P              <= ROCtoHV_SERDES_TXD0_P_net_1;
 ROCtoHV_SERDES_TXD1_N_net_1        <= ROCtoHV_SERDES_TXD1_N_net_0;
 ROCtoHV_SERDES_TXD1_N              <= ROCtoHV_SERDES_TXD1_N_net_1;
 ROCtoHV_SERDES_TXD1_P_net_1        <= ROCtoHV_SERDES_TXD1_P_net_0;
 ROCtoHV_SERDES_TXD1_P              <= ROCtoHV_SERDES_TXD1_P_net_1;
 SHIELD0_net_1                      <= SHIELD0_net_0;
 SHIELD0                            <= SHIELD0_net_1;
 SHIELD1_net_1                      <= SHIELD1_net_0;
 SHIELD1                            <= SHIELD1_net_1;
 SHIELD2_net_1                      <= SHIELD2_net_0;
 SHIELD2                            <= SHIELD2_net_1;
 SHIELD3_net_1                      <= SHIELD3_net_0;
 SHIELD3                            <= SHIELD3_net_1;
 TDO_net_1                          <= TDO_net_0;
 TDO                                <= TDO_net_1;
 word_aligned_net_1                 <= word_aligned_net_0;
 word_aligned                       <= word_aligned_net_1;
 ALIGNMENT_LOSS_COUNTER_net_1       <= ALIGNMENT_LOSS_COUNTER_net_0;
 ALIGNMENT_LOSS_COUNTER(7 downto 0) <= ALIGNMENT_LOSS_COUNTER_net_1;
 DDR4_ADDR_net_1                    <= DDR4_ADDR_net_0;
 DDR4_ADDR(13 downto 0)             <= DDR4_ADDR_net_1;
 DDR4_BA_net_1                      <= DDR4_BA_net_0;
 DDR4_BA(1 downto 0)                <= DDR4_BA_net_1;
 DDR4_DQM_net_1                     <= DDR4_DQM_net_0;
 DDR4_DQM(3 downto 0)               <= DDR4_DQM_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 NewDDRInterface_0_ewtag_offset_out31to0      <= NewDDRInterface_0_ewtag_offset_out(31 downto 0);
 ROC_LED0_n_net_0(0)                          <= GPIO_OUT_net_0(0);
 SLOWCONTROLS_0_DTCSIMADDR15to0               <= DTCSIMADDR_net_0(15 downto 0);
 SLOWCONTROLS_0_DTCSIMADDR23to16              <= DTCSIMADDR_net_0(23 downto 16);
 SLOWCONTROLS_0_DTCSIMDATA15to0               <= DTCSIMDATA_net_0(15 downto 0);
 SLOWCONTROLS_0_DTCSIMDATA31to16              <= DTCSIMDATA_net_0(31 downto 16);
 SLOWCONTROLS_0_DTCSIMPARAM3to0               <= DTCSIMPARAM_net_0(3 downto 0);
 SLOWCONTROLS_0_DTCSIMPARAM7to4               <= DTCSIMPARAM_net_0(7 downto 4);
 SLOWCONTROLS_0_DTCSIMPARAM11to8              <= DTCSIMPARAM_net_0(11 downto 8);
 SLOWCONTROLS_0_DTCSIMPARAM21to16             <= DTCSIMPARAM_net_0(21 downto 16);
 SLOWCONTROLS_0_DTCSIMPARAM24to24(24)         <= DTCSIMPARAM_net_0(24);
 SLOWCONTROLS_0_DTCSIMPARAM28to28(28)         <= DTCSIMPARAM_net_0(28);
 SLOWCONTROLS_0_DTCSIMSPILLDATA15to0          <= DTCSIMSPILLDATA_net_0(15 downto 0);
 SLOWCONTROLS_0_DTCSIMSPILLDATA23to16         <= DTCSIMSPILLDATA_net_0(23 downto 16);
 SLOWCONTROLS_0_DTCSIMSPILLDATA30to24         <= DTCSIMSPILLDATA_net_0(30 downto 24);
 SLOWCONTROLS_0_DTCSIMSPILLDATA31to31(31)     <= DTCSIMSPILLDATA_net_0(31);
 TOP_SERDES_0_DATAREQ_EVENT_WINDOW_TAG31to0   <= TOP_SERDES_0_DATAREQ_EVENT_WINDOW_TAG(31 downto 0);
 TOP_SERDES_0_FETCH_EVENT_WINDOW_TAG31to0     <= TOP_SERDES_0_FETCH_EVENT_WINDOW_TAG(31 downto 0);
 TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG31to0 <= TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG(31 downto 0);
 TOP_SERDES_0_PREFETCH_EVENT_WINDOW_TAG31to0  <= PREFETCH_EVENT_WINDOW_TAG_net_0(31 downto 0);
 GPIO_OUT_slice_0                             <= GPIO_OUT_net_0(3 downto 1);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 EVENT_MODE_net_0       <= ( B"00000000" & B"00000000" & B"00000000" & SLOWCONTROLS_0_DTCSIMSPILLDATA23to16 );
 EVENT_WINDOW_TAG_net_0 <= ( B"0000000000000000" & B"0000000000000000" & SLOWCONTROLS_0_DTCSIMSPILLDATA15to0 );
 RF_MARKER_net_0        <= ( '0' & SLOWCONTROLS_0_DTCSIMSPILLDATA30to24 );
 EXT_SYS_IRQ_net_0      <= ( '0' & '0' & '0' & '0' & '0' & '0' );
 serial_offset_net_0    <= ( B"0000000000000000" & SLOWCONTROLS_0_DDRCFOOFFSET );
 DDRERROR_net_0         <= ( NewDDRInterface_0_data_error & NewDDRInterface_0_header2_error & NewDDRInterface_0_header1_error & NewDDRInterface_0_event_error );
 DDRSIZERD_net_0        <= ( B"000" & NewDDRInterface_0_DREQ_FIFO_EMPTY & B"00" & NewDDRInterface_0_fetch_pos_cnt & B"0000" & NewDDRInterface_0_fetch_cnt );
 DDRSIZEWR_net_0        <= ( B"000" & NewDDRInterface_0_DREQ_FIFO_FULL & B"00" & NewDDRInterface_0_store_pos_cnt & B"0000" & NewDDRInterface_0_store_cnt );
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP_0 <= ( MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP_0_0to0(0) );
 MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP_0_0to0(0) <= MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP(0);

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_1
AND2_1 : AND2
    port map( 
        -- Inputs
        A => SLOWCONTROLS_0_DDRPTTREN,
        B => SLOWCONTROLS_0_DTCSIMPARAM28to28(28),
        -- Outputs
        Y => AND2_1_Y 
        );
-- AND2_3
AND2_3 : AND2
    port map( 
        -- Inputs
        A => INIT_component_0_XCVR_INIT_DONE,
        B => SLOWCONTROLS_0_dtc_serdes_reset_n,
        -- Outputs
        Y => AND2_3_Y 
        );
-- AND3_0
AND3_0 : AND3
    port map( 
        -- Inputs
        A => INIT_component_0_BANK_0_CALIB_STATUS,
        B => INIT_component_0_BANK_1_CALIB_STATUS,
        C => VCC_net,
        -- Outputs
        Y => AND3_0_Y 
        );
-- AND3_1
AND3_1 : AND3
    port map( 
        -- Inputs
        A => Reset50MHz_FABRIC_RESET_N,
        B => INV_2_Y,
        C => INV_1_Y,
        -- Outputs
        Y => AND3_1_Y 
        );
-- CLKINT_0
CLKINT_0 : CLKINT
    port map( 
        -- Inputs
        A => INBUF_DIFF_0_Y,
        -- Outputs
        Y => CLKINT_0_Y 
        );
-- COREJTAGDEBUG_C0_0
COREJTAGDEBUG_C0_0 : COREJTAGDEBUG_C0
    port map( 
        -- Inputs
        TRSTB      => TRSTB,
        TCK        => TCK,
        TMS        => TMS,
        TDI        => TDI,
        TGT_TDO_0  => MIV_RV32IMC_C0_0_JTAG_TDO,
        -- Outputs
        TDO        => TDO_net_0,
        TGT_TCK_0  => COREJTAGDEBUG_C0_0_TGT_TCK_0,
        TGT_TMS_0  => COREJTAGDEBUG_C0_0_TGT_TMS_0,
        TGT_TDI_0  => COREJTAGDEBUG_C0_0_TGT_TDI_0,
        TGT_TRST_0 => COREJTAGDEBUG_C0_0_TGT_TRST_0 
        );
-- CORERESET_2_LOCK_0
CORERESET_2_LOCK_0 : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_C0_0_OUT0_FABCLK_0,
        EXT_RST_N          => VCC_net,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_C0_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => CORERESET_2_LOCK_0_PLL_POWERDOWN_B,
        FABRIC_RESET_N     => OPEN 
        );
-- CORERESET_2_LOCK_1
CORERESET_2_LOCK_1 : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_111_0_OUT0_FABCLK_0,
        EXT_RST_N          => VCC_net,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_111_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => CORERESET_2_LOCK_1_PLL_POWERDOWN_B,
        FABRIC_RESET_N     => OPEN 
        );
-- counter_16bit_0
counter_16bit_0 : counter_16bit
    port map( 
        -- Inputs
        clk   => PF_CCC_C1_0_OUT0_FABCLK_0,
        en    => MX2_0_Y,
        rst_n => SLOWCONTROLS_0_reset_fifo_n,
        -- Outputs
        cnt   => counter_16bit_0_cnt 
        );
-- DFN1_0
DFN1_0 : DFN1
    port map( 
        -- Inputs
        D   => MX2_0_Y,
        CLK => PF_CCC_C1_0_OUT0_FABCLK_0,
        -- Outputs
        Q   => DFN1_0_Q 
        );
-- DigiClkReset_0
DigiClkReset_0 : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_C1_0_OUT0_FABCLK_0,
        EXT_RST_N          => VCC_net,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_C1_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => DigiClkReset_0_FABRIC_RESET_N 
        );
-- DigiFIFOReset_0
DigiFIFOReset_0 : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_C0_0_OUT1_FABCLK_0,
        EXT_RST_N          => SLOWCONTROLS_0_reset_fifo_n,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_C0_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => DigiFIFOReset_0_FABRIC_RESET_N 
        );
-- DigiInterface_0
DigiInterface_0 : DigiInterface
    port map( 
        -- Inputs
        CTRL_ARST_N            => AND2_3_Y,
        CTRL_CLK               => PF_CLK_DIV_C0_0_CLK_OUT,
        FPGA_POR_N             => INIT_component_0_FABRIC_POR_N,
        INIT_DONE              => INIT_component_0_DEVICE_INIT_DONE,
        LANE0_PCS_ARST_N_0     => SLOWCONTROLS_0_hv_lane0_pcs_reset_n,
        LANE0_PCS_ARST_N       => SLOWCONTROLS_0_cal_lane0_pcs_reset_n,
        LANE0_PMA_ARST_N_0     => SLOWCONTROLS_0_hv_lane0_pma_reset_n,
        LANE0_PMA_ARST_N       => SLOWCONTROLS_0_cal_lane0_pma_reset_n,
        LANE0_RXD_N_0          => HVtoROC_SERDES_TXD0_N,
        LANE0_RXD_N            => CALtoROC_SERDES_TXD0_N,
        LANE0_RXD_P_0          => HVtoROC_SERDES_TXD0_P,
        LANE0_RXD_P            => CALtoROC_SERDES_TXD0_P,
        LANE1_PCS_ARST_N_0     => SLOWCONTROLS_0_hv_lane1_pcs_reset_n,
        LANE1_PCS_ARST_N       => SLOWCONTROLS_0_cal_lane1_pcs_reset_n,
        LANE1_PMA_ARST_N_0     => SLOWCONTROLS_0_hv_lane1_pma_reset_n,
        LANE1_PMA_ARST_N       => SLOWCONTROLS_0_cal_lane1_pma_reset_n,
        LANE1_RXD_N_0          => HVtoROC_SERDES_TXD1_N,
        LANE1_RXD_N            => CALtoROC_SERDES_TXD1_N,
        LANE1_RXD_P_0          => HVtoROC_SERDES_TXD1_P,
        LANE1_RXD_P            => CALtoROC_SERDES_TXD1_P,
        REF_CLK_PAD_N_0        => ROCtoCAL_SERDES_CLK0_N,
        REF_CLK_PAD_N          => ROCtoHV_SERDES_CLK0_N,
        REF_CLK_PAD_P_0        => ROCtoCAL_SERDES_CLK0_P,
        REF_CLK_PAD_P          => ROCtoHV_SERDES_CLK0_P,
        align                  => SLOWCONTROLS_0_align_roc_to_digi,
        axi_start_on_serdesclk => NewDDRInterface_0_axi_start_on_serdesclk,
        ew_fifo_full           => NewDDRInterface_0_ew_fifo_full,
        fifo_rclk              => PF_CCC_C0_0_OUT1_FABCLK_0,
        fifo_resetn            => DigiFIFOReset_0_FABRIC_RESET_N,
        force_full             => SLOWCONTROLS_0_force_full,
        serdesclk_resetn       => SerdesClkReset_FABRIC_RESET_N,
        serialfifo_rclk        => PF_CCC_C0_0_OUT3_FABCLK_0,
        serialfifo_re          => SLOWCONTROLS_0_SERDES_RE,
        use_uart               => SLOWCONTROLS_0_use_uart,
        DCS_use_lane           => TOP_SERDES_0_DCS_USE_LANE,
        SERIAL_use_lane        => SLOWCONTROLS_0_use_lane,
        -- Outputs
        CAL_lane0_empty        => DigiInterface_0_CAL_lane0_empty,
        CAL_lane1_empty        => DigiInterface_0_CAL_lane1_empty,
        HV_lane0_empty         => DigiInterface_0_HV_lane0_empty,
        HV_lane1_empty         => DigiInterface_0_HV_lane1_empty,
        LANE0_TXD_N_0          => ROCtoHV_SERDES_TXD0_N_net_0,
        LANE0_TXD_N            => ROCtoCAL_SERDES_TXD0_N_net_0,
        LANE0_TXD_P_0          => ROCtoHV_SERDES_TXD0_P_net_0,
        LANE0_TXD_P            => ROCtoCAL_SERDES_TXD0_P_net_0,
        LANE1_TXD_N_0          => ROCtoHV_SERDES_TXD1_N_net_0,
        LANE1_TXD_N            => ROCtoCAL_SERDES_TXD1_N_net_0,
        LANE1_TXD_P_0          => ROCtoHV_SERDES_TXD1_P_net_0,
        LANE1_TXD_P            => ROCtoCAL_SERDES_TXD1_P_net_0,
        cal_lane0_aligned      => DigiInterface_0_cal_lane0_aligned,
        cal_lane1_aligned      => DigiInterface_0_cal_lane1_aligned,
        curr_ewfifo_wr         => DigiInterface_0_curr_ewfifo_wr,
        ew_done                => DigiInterface_0_ew_done,
        ew_fifo_we             => DigiInterface_0_ew_fifo_we,
        ew_ovfl                => DigiInterface_0_ew_ovfl,
        hv_lane0_aligned       => DigiInterface_0_hv_lane0_aligned,
        hv_lane1_aligned       => DigiInterface_0_hv_lane1_aligned,
        serialfifo_empty       => DigiInterface_0_serialfifo_empty,
        serialfifo_full        => DigiInterface_0_serialfifo_full,
        cal_lane0_alignment    => DigiInterface_0_cal_lane0_alignment,
        cal_lane0_error_count  => DigiInterface_0_cal_lane0_error_count,
        cal_lane1_alignment    => DigiInterface_0_cal_lane1_alignment,
        cal_lane1_error_count  => DigiInterface_0_cal_lane1_error_count,
        ew_fifo_data           => DigiInterface_0_ew_fifo_data,
        ew_size                => DigiInterface_0_ew_size,
        ew_tag                 => DigiInterface_0_ew_tag,
        hv_lane0_alignment     => DigiInterface_0_hv_lane0_alignment,
        hv_lane0_error_count   => DigiInterface_0_hv_lane0_error_count,
        hv_lane1_alignment     => DigiInterface_0_hv_lane1_alignment,
        hv_lane1_error_count   => DigiInterface_0_hv_lane1_error_count,
        serialfifo_data        => DigiInterface_0_serialfifo_data,
        serialfifo_rdcnt       => DigiInterface_0_serialfifo_rdcnt,
        state_count            => DigiInterface_0_state_count 
        );
-- DigiReset_0
DigiReset_0 : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_C1_0_OUT0_FABCLK_0,
        EXT_RST_N          => SLOWCONTROLS_0_DIGIDEVICE_RESETN,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_C1_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => DigiReset_0_PLL_POWERDOWN_B,
        FABRIC_RESET_N     => ROC_HV_DEVRSTn_net_0 
        );
-- DReqClkReset
DReqClkReset : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_C0_0_OUT2_FABCLK_0,
        EXT_RST_N          => AND3_1_Y,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_C0_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => DReqClkReset_FABRIC_RESET_N 
        );
-- DTCSimulator_0
DTCSimulator_0 : DTCSimulator
    port map( 
        -- Inputs
        ALIGN              => TOP_SERDES_0_PCS_ALIGNED,
        DATAREQ_LAST_WORD  => NewDDRInterface_0_last_word,
        DREQCLK_RESETN     => DReqClkReset_FABRIC_RESET_N,
        DREQ_CLK           => PF_CCC_C0_0_OUT2_FABCLK_0,
        EXT_RST_N          => AND3_1_Y,
        MARKER_SEL         => SLOWCONTROLS_0_DTCSIMPARAM24to24(24),
        ON_SPILL           => SLOWCONTROLS_0_DTCSIMSPILLDATA31to31(31),
        RXCLK_RESETN       => TOP_SERDES_0_RXCLK_RESETN,
        RX_CLK             => TOP_SERDES_0_LANE0_RX_CLK_R,
        SERDESCLK_RESETN   => SerdesClkReset_FABRIC_RESET_N,
        SERDES_CLK         => PF_CCC_C0_0_OUT1_FABCLK_0,
        SERIAL_CFO_EN      => SLOWCONTROLS_0_DDRCFOEN,
        SERIAL_CFO_PREF_EN => SLOWCONTROLS_0_DDRPREFETCHEN,
        SERIAL_CFO_START   => SLOWCONTROLS_0_DDRCFOSTART,
        SIM_START          => SLOWCONTROLS_0_DTCSIMSTART,
        TXCLK_RESETN       => TOP_SERDES_0_TXCLK_RESETN,
        TX_CLK             => TOP_SERDES_0_LANE0_TX_CLK_R,
        dreq_start         => TOP_SERDES_0_DATAREQ_START_EVENT,
        hb_start           => TOP_SERDES_0_HEARTBEAT_SEEN,
        ADDR               => SLOWCONTROLS_0_DTCSIMADDR15to0,
        BLOCK_CNT          => SLOWCONTROLS_0_DTCSIMDATA31to16,
        EVENT_MODE         => EVENT_MODE_net_0,
        EVENT_WINDOW_TAG   => EVENT_WINDOW_TAG_net_0,
        MARKER_TYPE        => SLOWCONTROLS_0_DTCSIMPARAM7to4,
        MODULE_ID          => SLOWCONTROLS_0_DTCSIMADDR23to16,
        OP_CODE            => SLOWCONTROLS_0_DTCSIMPARAM21to16,
        PACKET_TYPE        => SLOWCONTROLS_0_DTCSIMPARAM3to0,
        RF_MARKER          => RF_MARKER_net_0,
        SEQ_NUM            => SLOWCONTROLS_0_DTCSIMPARAM11to8,
        SERIAL_DELTAHB     => SLOWCONTROLS_0_DDRCFODELTAHB,
        SERIAL_NUMBERHB    => SLOWCONTROLS_0_DDRCFONUMBERHB,
        SERIAL_OFFSETHB    => SLOWCONTROLS_0_DDRCFOOFFSET,
        WDATA              => SLOWCONTROLS_0_DTCSIMDATA15to0,
        dreq_ewtag         => TOP_SERDES_0_DATAREQ_EVENT_WINDOW_TAG,
        hb_ewtag           => TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG,
        -- Outputs
        SIM_TX_DATA        => DTCSimulator_0_SIM_TX_DATA,
        SIM_TX_KCHAR       => DTCSimulator_0_SIM_TX_KCHAR 
        );
-- EWMaker_0
EWMaker_0 : EWMaker
    port map( 
        -- Inputs
        digi_reset_n       => DigiClkReset_0_FABRIC_RESET_N,
        digi_clk           => PF_CCC_C1_0_OUT0_FABCLK_0,
        external_ewm_50mhz => SLOWCONTROLS_0_ewm_50mhz,
        ewm_enable_50mhz   => SLOWCONTROLS_0_ewm_enable_50mhz,
        ewm_period_5ns     => SLOWCONTROLS_0_ewm_delay,
        -- Outputs
        ewm                => EWMaker_0_ewm 
        );
-- INBUF_DIFF_0
INBUF_DIFF_0 : INBUF_DIFF
    port map( 
        -- Inputs
        PADP => ROC_CLK_P,
        PADN => ROC_CLK_N,
        -- Outputs
        Y    => INBUF_DIFF_0_Y 
        );
-- INIT_component_0
INIT_component_0 : INIT_component
    port map( 
        -- Outputs
        FABRIC_POR_N               => INIT_component_0_FABRIC_POR_N,
        PCIE_INIT_DONE             => OPEN,
        USRAM_INIT_DONE            => OPEN,
        SRAM_INIT_DONE             => OPEN,
        DEVICE_INIT_DONE           => INIT_component_0_DEVICE_INIT_DONE,
        BANK_0_CALIB_STATUS        => INIT_component_0_BANK_0_CALIB_STATUS,
        BANK_1_CALIB_STATUS        => INIT_component_0_BANK_1_CALIB_STATUS,
        BANK_2_VDDI_STATUS         => INIT_component_0_BANK_2_VDDI_STATUS,
        XCVR_INIT_DONE             => INIT_component_0_XCVR_INIT_DONE,
        USRAM_INIT_FROM_SNVM_DONE  => OPEN,
        USRAM_INIT_FROM_UPROM_DONE => OPEN,
        USRAM_INIT_FROM_SPI_DONE   => OPEN,
        SRAM_INIT_FROM_SNVM_DONE   => OPEN,
        SRAM_INIT_FROM_UPROM_DONE  => OPEN,
        SRAM_INIT_FROM_SPI_DONE    => OPEN,
        AUTOCALIB_DONE             => OPEN 
        );
-- INV_1
INV_1 : INV
    port map( 
        -- Inputs
        A => pulse_stretcher_1_gate_o,
        -- Outputs
        Y => INV_1_Y 
        );
-- INV_2
INV_2 : INV
    port map( 
        -- Inputs
        A => pulse_stretcher_0_gate_o,
        -- Outputs
        Y => INV_2_Y 
        );
-- MIV_RV32IMC_C0_0
MIV_RV32IMC_C0_0 : MIV_RV32IMC_C0
    port map( 
        -- Inputs
        CLK                => PF_CCC_C0_0_OUT3_FABCLK_0,
        RESETN             => Reset50MHz_FABRIC_RESET_N,
        APB_MSTR_PRDATA    => MIV_RV32IMC_C0_0_APB_MSTR_PRDATA,
        APB_MSTR_PREADY    => MIV_RV32IMC_C0_0_APB_MSTR_PREADY,
        APB_MSTR_PSLVERR   => MIV_RV32IMC_C0_0_APB_MSTR_PSLVERR,
        AHB_MSTR_HRDATA    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HRDATA,
        AHB_MSTR_HRESP     => MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP_0,
        AHB_MSTR_HREADY    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HREADYOUT,
        JTAG_TRST          => COREJTAGDEBUG_C0_0_TGT_TRST_0,
        JTAG_TCK           => COREJTAGDEBUG_C0_0_TGT_TCK_0,
        JTAG_TDI           => COREJTAGDEBUG_C0_0_TGT_TDI_0,
        JTAG_TMS           => COREJTAGDEBUG_C0_0_TGT_TMS_0,
        EXT_IRQ            => GND_net,
        EXT_SYS_IRQ        => EXT_SYS_IRQ_net_0,
        -- Outputs
        TIME_COUNT_OUT     => OPEN,
        APB_MSTR_PADDR     => MIV_RV32IMC_C0_0_APB_MSTR_PADDR,
        APB_MSTR_PENABLE   => MIV_RV32IMC_C0_0_APB_MSTR_PENABLE,
        APB_MSTR_PWRITE    => MIV_RV32IMC_C0_0_APB_MSTR_PWRITE,
        APB_MSTR_PWDATA    => MIV_RV32IMC_C0_0_APB_MSTR_PWDATA,
        APB_MSTR_PSEL      => MIV_RV32IMC_C0_0_APB_MSTR_PSELx,
        AHB_MSTR_HADDR     => MIV_RV32IMC_C0_0_AHBL_M_SLV_HADDR,
        AHB_MSTR_HTRANS    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HTRANS,
        AHB_MSTR_HWRITE    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HWRITE,
        AHB_MSTR_HSIZE     => MIV_RV32IMC_C0_0_AHBL_M_SLV_HSIZE,
        AHB_MSTR_HBURST    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HBURST,
        AHB_MSTR_HPROT     => MIV_RV32IMC_C0_0_AHBL_M_SLV_HPROT,
        AHB_MSTR_HWDATA    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HWDATA,
        AHB_MSTR_HMASTLOCK => MIV_RV32IMC_C0_0_AHBL_M_SLV_HMASTLOCK,
        AHB_MSTR_HSEL      => MIV_RV32IMC_C0_0_AHBL_M_SLV_HSELx,
        JTAG_TDO           => MIV_RV32IMC_C0_0_JTAG_TDO,
        JTAG_TDO_DR        => OPEN,
        EXT_RESETN         => OPEN 
        );
-- MX2_0
MX2_0 : MX2
    port map( 
        -- Inputs
        A => EWMaker_0_ewm,
        B => TOP_SERDES_0_EWM_SEEN,
        S => SLOWCONTROLS_0_enable_fiber_marker,
        -- Outputs
        Y => MX2_0_Y 
        );
-- NewDDRInterface_0
NewDDRInterface_0 : NewDDRInterface
    port map( 
        -- Inputs
        DCS_pattern_en         => TOP_SERDES_0_DCS_PATTERN_EN,
        DDR_BANK_CALIB         => AND3_0_Y,
        DIGI_curr_ewfifo_wr    => DigiInterface_0_curr_ewfifo_wr,
        DIGI_ew_done           => DigiInterface_0_ew_done,
        DIGI_ew_fifo_we        => DigiInterface_0_ew_fifo_we,
        DIGI_ew_ovfl           => DigiInterface_0_ew_ovfl,
        EXT_RST_N              => AND3_1_Y,
        FPGA_POR_N             => INIT_component_0_FABRIC_POR_N,
        INIT_DONE              => INIT_component_0_DEVICE_INIT_DONE,
        MEM_CLK                => PF_CCC_111_0_OUT1_FABCLK_0,
        NEWSPILL               => TOP_SERDES_0_NEWSPILL,
        ONSPILL                => TOP_SERDES_0_ONSPILL,
        RXCLK_RESETN           => TOP_SERDES_0_RXCLK_RESETN,
        RX_CLK                 => TOP_SERDES_0_LANE0_RX_CLK_R,
        SERIAL_pattern_en      => SLOWCONTROLS_0_DDRPTTREN,
        dreqclk_resetn         => DReqClkReset_FABRIC_RESET_N,
        dreqclk                => PF_CCC_C0_0_OUT2_FABCLK_0,
        et_fifo_re             => TOP_SERDES_0_DATAREQ_RE_FIFO,
        event_start            => TOP_SERDES_0_DATAREQ_START_EVENT,
        hb_null_valid          => TOP_SERDES_0_NULL_HEARTBEAT_SEEN,
        hb_valid               => TOP_SERDES_0_HEARTBEAT_SEEN,
        pref_valid             => TOP_SERDES_0_PREFETCH_SEEN,
        resetn_serdesclk       => SerdesClkReset_FABRIC_RESET_N,
        serdesclk              => PF_CCC_C0_0_OUT1_FABCLK_0,
        set_serial_offset      => SLOWCONTROLS_0_DDRSERIALSET,
        start_fetch            => TOP_SERDES_0_FETCH_START,
        DIGI_ew_fifo_data      => DigiInterface_0_ew_fifo_data,
        DIGI_ew_size           => DigiInterface_0_ew_size,
        DIGI_ew_tag            => DigiInterface_0_ew_tag,
        event_window_fetch     => TOP_SERDES_0_FETCH_EVENT_WINDOW_TAG,
        run_offset             => TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG,
        serial_offset          => serial_offset_net_0,
        spill_hbtag_in         => TOP_SERDES_0_SPILL_EVENT_WINDOW_TAG,
        -- Outputs
        ACT_N                  => DDR4_ACTn_net_0,
        BG                     => DDR4_BG0_net_0,
        CAS_N                  => DDR4_ADDR15_net_0,
        CK0_N                  => DDR4_CLK0_N_net_0,
        CK0                    => DDR4_CLK0_P_net_0,
        CKE                    => DDR4_CKE0_net_0,
        CS_N                   => DDR4_CS0N_net_0,
        CTRLR_READY            => NewDDRInterface_0_CTRLR_READY,
        DREQ_FIFO_EMPTY        => NewDDRInterface_0_DREQ_FIFO_EMPTY,
        DREQ_FIFO_FULL         => NewDDRInterface_0_DREQ_FIFO_FULL,
        ODT                    => DDR4_ODT0_net_0,
        RAS_N                  => DDR4_ADDR16_net_0,
        RESET_N                => DDR4_RESETn_net_0,
        SHIELD0                => SHIELD0_net_0,
        SHIELD1                => SHIELD1_net_0,
        SHIELD2                => SHIELD2_net_0,
        SHIELD3                => SHIELD3_net_0,
        WE_N                   => DDR4_ADDR14_net_0,
        axi_start_on_serdesclk => NewDDRInterface_0_axi_start_on_serdesclk,
        data_error             => NewDDRInterface_0_data_error,
        data_ready             => NewDDRInterface_0_data_ready,
        event_error            => NewDDRInterface_0_event_error,
        ew_DDR_wrap            => OPEN,
        ew_fifo_full           => NewDDRInterface_0_ew_fifo_full,
        header1_error          => NewDDRInterface_0_header1_error,
        header2_error          => NewDDRInterface_0_header2_error,
        last_word              => NewDDRInterface_0_last_word,
        A                      => DDR4_ADDR_net_0,
        BA                     => DDR4_BA_net_0,
        DM_N                   => DDR4_DQM_net_0,
        data_expc              => NewDDRInterface_0_data_expc,
        data_seen              => NewDDRInterface_0_data_seen,
        et_fifo_rdata          => NewDDRInterface_0_et_fifo_rdata,
        et_pckts               => NewDDRInterface_0_et_pckts,
        evt_expc               => NewDDRInterface_0_evt_expc,
        evt_seen               => NewDDRInterface_0_evt_seen,
        ewtag_offset_out       => NewDDRInterface_0_ewtag_offset_out,
        fetch_cnt              => NewDDRInterface_0_fetch_cnt,
        fetch_pos_cnt          => NewDDRInterface_0_fetch_pos_cnt,
        hb_cnt                 => NewDDRInterface_0_hb_cnt,
        hb_null_cnt            => NewDDRInterface_0_hb_null_cnt,
        hb_seen_cnt            => NewDDRInterface_0_hb_seen_cnt,
        hdr1_expc              => NewDDRInterface_0_hdr1_expc,
        hdr1_seen              => NewDDRInterface_0_hdr1_seen,
        hdr2_expc              => NewDDRInterface_0_hdr2_expc,
        hdr2_seen              => NewDDRInterface_0_hdr2_seen,
        pref_seen_cnt          => NewDDRInterface_0_pref_seen_cnt,
        start_tag_cnt          => NewDDRInterface_0_start_tag_cnt,
        store_cnt              => NewDDRInterface_0_store_cnt,
        store_pos_cnt          => NewDDRInterface_0_store_pos_cnt,
        tag_done_cnt           => NewDDRInterface_0_tag_done_cnt,
        tag_null_cnt           => NewDDRInterface_0_tag_null_cnt,
        tag_sent_cnt           => NewDDRInterface_0_tag_sent_cnt,
        -- Inouts
        DQS_N                  => DDR4_DQS_N,
        DQS                    => DDR4_DQS_P,
        DQ                     => DDR4_DQ 
        );
-- OUTBUF_DIFF_0
OUTBUF_DIFF_0 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => DFN1_0_Q,
        -- Outputs
        PADP => ROC_HV_LVDS0_P_net_0,
        PADN => ROC_HV_LVDS0_N_net_0 
        );
-- OUTBUF_DIFF_1
OUTBUF_DIFF_1 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => PF_CCC_C1_0_OUT0_FABCLK_0,
        -- Outputs
        PADP => ROCtoCAL_CLK0_P_net_0,
        PADN => ROCtoCAL_CLK0_N_net_0 
        );
-- OUTBUF_DIFF_2
OUTBUF_DIFF_2 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => DFN1_0_Q,
        -- Outputs
        PADP => ROC_CAL_LVDS0_P_net_0,
        PADN => ROC_CAL_LVDS0_N_net_0 
        );
-- OUTBUF_DIFF_3
OUTBUF_DIFF_3 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => PF_CCC_C1_0_OUT0_FABCLK_0,
        -- Outputs
        PADP => ROCtoHV_CLK0_P_net_0,
        PADN => ROCtoHV_CLK0_N_net_0 
        );
-- OUTBUF_DIFF_4
OUTBUF_DIFF_4 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => PF_CCC_C1_0_OUT1_FABCLK_0,
        -- Outputs
        PADP => ROC_ACCEL_CLK0_P_net_0,
        PADN => ROC_ACCEL_CLK0_N_net_0 
        );
-- OUTBUF_DIFF_4_0
OUTBUF_DIFF_4_0 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => PF_CCC_C1_0_OUT1_FABCLK_0,
        -- Outputs
        PADP => ROC_ACCEL_CLK1_P_net_0,
        PADN => ROC_ACCEL_CLK1_N_net_0 
        );
-- OUTBUF_DIFF_5
OUTBUF_DIFF_5 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => SLOWCONTROLS_0_PWM0,
        -- Outputs
        PADP => CAL_CALODD_P_net_0,
        PADN => CAL_CALODD_N_net_0 
        );
-- OUTBUF_DIFF_6
OUTBUF_DIFF_6 : OUTBUF_DIFF
    port map( 
        -- Inputs
        D    => SLOWCONTROLS_0_PWM0,
        -- Outputs
        PADP => CAL_CALEVEN_P_net_0,
        PADN => CAL_CALEVEN_N_net_0 
        );
-- PF_CCC_111_0
PF_CCC_111_0 : PF_CCC_111
    port map( 
        -- Inputs
        REF_CLK_0         => CLKINT_0_Y,
        PLL_POWERDOWN_N_0 => CORERESET_2_LOCK_1_PLL_POWERDOWN_B,
        -- Outputs
        OUT0_FABCLK_0     => PF_CCC_111_0_OUT0_FABCLK_0,
        OUT1_FABCLK_0     => PF_CCC_111_0_OUT1_FABCLK_0,
        PLL_LOCK_0        => PF_CCC_111_0_PLL_LOCK_0 
        );
-- PF_CCC_C0_0
PF_CCC_C0_0 : PF_CCC_C0
    port map( 
        -- Inputs
        REF_CLK_0         => CLKINT_0_Y,
        PLL_POWERDOWN_N_0 => CORERESET_2_LOCK_0_PLL_POWERDOWN_B,
        -- Outputs
        OUT0_FABCLK_0     => PF_CCC_C0_0_OUT0_FABCLK_0,
        OUT1_FABCLK_0     => PF_CCC_C0_0_OUT1_FABCLK_0,
        OUT2_FABCLK_0     => PF_CCC_C0_0_OUT2_FABCLK_0,
        OUT3_FABCLK_0     => PF_CCC_C0_0_OUT3_FABCLK_0,
        PLL_LOCK_0        => PF_CCC_C0_0_PLL_LOCK_0 
        );
-- PF_CCC_C1_0
PF_CCC_C1_0 : PF_CCC_C1
    port map( 
        -- Inputs
        REF_CLK_0         => PF_NGMUX_C0_0_CLK_OUT,
        PLL_POWERDOWN_N_0 => DigiReset_0_PLL_POWERDOWN_B,
        -- Outputs
        OUT0_FABCLK_0     => PF_CCC_C1_0_OUT0_FABCLK_0,
        OUT1_FABCLK_0     => PF_CCC_C1_0_OUT1_FABCLK_0,
        PLL_LOCK_0        => PF_CCC_C1_0_PLL_LOCK_0 
        );
-- PF_CLK_DIV_C0_0
PF_CLK_DIV_C0_0 : PF_CLK_DIV_C0
    port map( 
        -- Inputs
        CLK_IN  => PF_OSC_0_0_RCOSC_160MHZ_CLK_DIV,
        -- Outputs
        CLK_OUT => PF_CLK_DIV_C0_0_CLK_OUT 
        );
-- PF_NGMUX_C0_0
PF_NGMUX_C0_0 : PF_NGMUX_C0
    port map( 
        -- Inputs
        CLK0    => PF_CCC_C0_0_OUT0_FABCLK_0,
        CLK1    => TOP_SERDES_0_LANE0_RX_CLK_R,
        SEL     => SLOWCONTROLS_0_enable_fiber_clock,
        -- Outputs
        CLK_OUT => PF_NGMUX_C0_0_CLK_OUT 
        );
-- PF_OSC_0_0
PF_OSC_0_0 : PF_OSC_0
    port map( 
        -- Outputs
        RCOSC_160MHZ_GL      => OPEN,
        RCOSC_160MHZ_CLK_DIV => PF_OSC_0_0_RCOSC_160MHZ_CLK_DIV 
        );
-- PF_SRAM_0
PF_SRAM_0 : PF_SRAM
    port map( 
        -- Inputs
        HCLK      => PF_CCC_C0_0_OUT3_FABCLK_0,
        HRESETN   => Reset50MHz_FABRIC_RESET_N,
        HADDR     => MIV_RV32IMC_C0_0_AHBL_M_SLV_HADDR,
        HTRANS    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HTRANS,
        HWRITE    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HWRITE,
        HSIZE     => MIV_RV32IMC_C0_0_AHBL_M_SLV_HSIZE,
        HBURST    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HBURST,
        HWDATA    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HWDATA,
        HSEL      => MIV_RV32IMC_C0_0_AHBL_M_SLV_HSELx,
        HREADYIN  => VCC_net, -- tied to '1' from definition
        -- Outputs
        HRDATA    => MIV_RV32IMC_C0_0_AHBL_M_SLV_HRDATA,
        HREADYOUT => MIV_RV32IMC_C0_0_AHBL_M_SLV_HREADYOUT,
        HRESP     => MIV_RV32IMC_C0_0_AHBL_M_SLV_HRESP 
        );
-- pulse_stretcher_0
pulse_stretcher_0 : pulse_stretcher
    port map( 
        -- Inputs
        clk_i      => PF_CCC_C0_0_OUT3_FABCLK_0,
        polarity_i => GND_net,
        resetn_i   => Reset50MHz_FABRIC_RESET_N,
        pulse_i    => SLOWCONTROLS_0_DDR_RESETN,
        -- Outputs
        gate_o     => pulse_stretcher_0_gate_o 
        );
-- pulse_stretcher_1
pulse_stretcher_1 : pulse_stretcher
    port map( 
        -- Inputs
        clk_i      => PF_CCC_C0_0_OUT0_FABCLK_0,
        polarity_i => VCC_net,
        resetn_i   => Reset50MHz_FABRIC_RESET_N,
        pulse_i    => TOP_SERDES_0_DCS_DDRRESET,
        -- Outputs
        gate_o     => pulse_stretcher_1_gate_o 
        );
-- Reset50MHz
Reset50MHz : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_C0_0_OUT3_FABCLK_0,
        EXT_RST_N          => VCC_net,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_C0_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => Reset50MHz_FABRIC_RESET_N 
        );
-- SerdesClkReset
SerdesClkReset : CORERESET
    port map( 
        -- Inputs
        CLK                => PF_CCC_C0_0_OUT1_FABCLK_0,
        EXT_RST_N          => AND3_1_Y,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => INIT_component_0_BANK_2_VDDI_STATUS,
        PLL_LOCK           => PF_CCC_C0_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_component_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => INIT_component_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => SerdesClkReset_FABRIC_RESET_N 
        );
-- SLOWCONTROLS_0
SLOWCONTROLS_0 : SLOWCONTROLS
    port map( 
        -- Inputs
        CAL_PREAMP_MISO        => CAL_PREAMP_MISO,
        DDRCTRLREADY           => NewDDRInterface_0_CTRLR_READY,
        HV_PREAMP_MISO         => HV_PREAMP_MISO,
        PCLK                   => PF_CCC_C0_0_OUT3_FABCLK_0,
        PENABLE                => MIV_RV32IMC_C0_0_APB_MSTR_PENABLE,
        PRESETN                => Reset50MHz_FABRIC_RESET_N,
        PSEL                   => MIV_RV32IMC_C0_0_APB_MSTR_PSELx,
        PWRITE                 => MIV_RV32IMC_C0_0_APB_MSTR_PWRITE,
        RX                     => KEY_IO1,
        SERDES_EMPTY           => DigiInterface_0_serialfifo_empty,
        SERDES_FULL            => DigiInterface_0_serialfifo_full,
        SPI0_MISO              => ROC_SPI0_MISO,
        SPI1_MISO              => ROC_SPI1_MISO,
        SPI2_MISO              => GND_net,
        cal_lane0_aligned      => DigiInterface_0_cal_lane0_aligned,
        cal_lane1_aligned      => DigiInterface_0_cal_lane1_aligned,
        hv_lane0_aligned       => DigiInterface_0_hv_lane0_aligned,
        hv_lane1_aligned       => DigiInterface_0_hv_lane1_aligned,
        DDRDREQCNT             => NewDDRInterface_0_start_tag_cnt,
        DDRDREQNULL            => NewDDRInterface_0_tag_null_cnt,
        DDRDREQREAD            => NewDDRInterface_0_tag_sent_cnt,
        DDRDREQSENT            => NewDDRInterface_0_tag_done_cnt,
        DDRDREQTAG             => TOP_SERDES_0_DATAREQ_EVENT_WINDOW_TAG31to0,
        DDRERROR               => DDRERROR_net_0,
        DDRFETCHTAG            => TOP_SERDES_0_FETCH_EVENT_WINDOW_TAG31to0,
        DDRHBCNT               => NewDDRInterface_0_hb_seen_cnt,
        DDRHBONHOLD            => NewDDRInterface_0_hb_cnt,
        DDRHBTAG               => TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG31to0,
        DDRNULLHBCNT           => NewDDRInterface_0_hb_null_cnt,
        DDROFFSETTAG           => NewDDRInterface_0_ewtag_offset_out31to0,
        DDRPREFCNT             => NewDDRInterface_0_pref_seen_cnt,
        DDRPRETAG              => TOP_SERDES_0_PREFETCH_EVENT_WINDOW_TAG31to0,
        DDRSIZERD              => DDRSIZERD_net_0,
        DDRSIZEWR              => DDRSIZEWR_net_0,
        DDRSPILLCNT            => TOP_SERDES_0_SPILL_EVENT_WINDOW_TAG,
        DTCDATAREAD            => TOP_SERDES_0_DTCDATA_OUT,
        PADDR                  => MIV_RV32IMC_C0_0_APB_MSTR_PADDR,
        PWDATA                 => MIV_RV32IMC_C0_0_APB_MSTR_PWDATA,
        SERDES_DATA            => DigiInterface_0_serialfifo_data,
        SERDES_RDCNT           => DigiInterface_0_serialfifo_rdcnt,
        cal_lane0_alignment    => DigiInterface_0_cal_lane0_alignment,
        cal_lane0_error_count  => DigiInterface_0_cal_lane0_error_count,
        cal_lane1_alignment    => DigiInterface_0_cal_lane1_alignment,
        cal_lane1_error_count  => DigiInterface_0_cal_lane1_error_count,
        data_expc              => NewDDRInterface_0_data_expc,
        data_seen              => NewDDRInterface_0_data_seen,
        dtc_error_counter      => TOP_SERDES_0_counter_out,
        dummy_status_out0      => dummy_status_out0_const_net_0,
        dummy_status_out1      => dummy_status_out1_const_net_0,
        dummy_status_out2      => dummy_status_out2_const_net_0,
        dummy_status_out3      => dummy_status_out3_const_net_0,
        evt_expc               => NewDDRInterface_0_evt_expc,
        evt_seen               => NewDDRInterface_0_evt_seen,
        hdr1_expc              => NewDDRInterface_0_hdr1_expc,
        hdr1_seen              => NewDDRInterface_0_hdr1_seen,
        hdr2_expc              => NewDDRInterface_0_hdr2_expc,
        hdr2_seen              => NewDDRInterface_0_hdr2_seen,
        hv_lane0_alignment     => DigiInterface_0_hv_lane0_alignment,
        hv_lane0_error_count   => DigiInterface_0_hv_lane0_error_count,
        hv_lane1_alignment     => DigiInterface_0_hv_lane1_alignment,
        hv_lane1_error_count   => DigiInterface_0_hv_lane1_error_count,
        remote_token0          => remote_token0_const_net_0,
        remote_token1          => remote_token1_const_net_0,
        remote_token2          => remote_token2_const_net_0,
        remote_token3          => remote_token3_const_net_0,
        serdes_aligned         => serdes_aligned_const_net_0,
        serdes_data0           => serdes_data0_const_net_0,
        serdes_data1           => serdes_data1_const_net_0,
        serdes_data2           => serdes_data2_const_net_0,
        serdes_data3           => serdes_data3_const_net_0,
        serdes_rdcnt0          => serdes_rdcnt0_const_net_0,
        serdes_rdcnt1          => serdes_rdcnt1_const_net_0,
        serdes_rdcnt2          => serdes_rdcnt2_const_net_0,
        serdes_rdcnt3          => serdes_rdcnt3_const_net_0,
        -- Outputs
        CAL_PREAMP_CE0n        => CAL_PREAMP_CE0n_net_0,
        CAL_PREAMP_CE1n        => CAL_PREAMP_CE1n_net_0,
        CAL_PREAMP_MOSI        => CAL_PREAMP_MOSI_net_0,
        CAL_PREAMP_SCLK        => CAL_PREAMP_SCLK_net_0,
        DDRCFOEN               => SLOWCONTROLS_0_DDRCFOEN,
        DDRCFOSTART            => SLOWCONTROLS_0_DDRCFOSTART,
        DDRPREFETCHEN          => SLOWCONTROLS_0_DDRPREFETCHEN,
        DDRPTTREN              => SLOWCONTROLS_0_DDRPTTREN,
        DDRSERIALSET           => SLOWCONTROLS_0_DDRSERIALSET,
        DDR_RESETN             => SLOWCONTROLS_0_DDR_RESETN,
        DIGIDEVICE_RESETN      => SLOWCONTROLS_0_DIGIDEVICE_RESETN,
        DTCALIGN_RESETN        => SLOWCONTROLS_0_DTCALIGN_RESETN,
        DTCSIMBLKEN            => OPEN,
        DTCSIMSTART            => SLOWCONTROLS_0_DTCSIMSTART,
        HV_PREAMP_CE0n         => HV_PREAMP_CE0n_net_0,
        HV_PREAMP_CE1n         => HV_PREAMP_CE1n_net_0,
        HV_PREAMP_MOSI         => HV_PREAMP_MOSI_net_0,
        HV_PREAMP_SCLK         => HV_PREAMP_SCLK_net_0,
        PREADY                 => MIV_RV32IMC_C0_0_APB_MSTR_PREADY,
        PSLVERR                => MIV_RV32IMC_C0_0_APB_MSTR_PSLVERR,
        PWM0                   => SLOWCONTROLS_0_PWM0,
        SENSOR_MCP_CEn         => OPEN,
        SERDES_RE              => SLOWCONTROLS_0_SERDES_RE,
        SPI0_ADC0_CEn          => ROC_SPI0_ADC0_CEn_net_0,
        SPI0_ADC1_CEn          => ROC_SPI0_ADC1_CEn_net_0,
        SPI0_ADC2_CEn          => ROC_SPI0_ADC2_CEn_net_0,
        SPI0_MOSI              => ROC_SPI0_MOSI_net_0,
        SPI0_SCLK              => ROC_SPI0_SCLK_net_0,
        SPI1_ADC0_CEn          => ROC_SPI1_ADC0_CEn_net_0,
        SPI1_ADC1_CEn          => ROC_SPI1_ADC1_CEn_net_0,
        SPI1_ADC2_CEn          => ROC_SPI1_ADC2_CEn_net_0,
        SPI1_MOSI              => ROC_SPI1_MOSI_net_0,
        SPI1_SCLK              => ROC_SPI1_SCLK_net_0,
        SPI2_ADC0_CEn          => OPEN,
        SPI2_MOSI              => OPEN,
        SPI2_SCLK              => OPEN,
        TX                     => KEY_IO0_net_0,
        align_roc_to_digi      => SLOWCONTROLS_0_align_roc_to_digi,
        cal_lane0_pcs_reset_n  => SLOWCONTROLS_0_cal_lane0_pcs_reset_n,
        cal_lane0_pma_reset_n  => SLOWCONTROLS_0_cal_lane0_pma_reset_n,
        cal_lane1_pcs_reset_n  => SLOWCONTROLS_0_cal_lane1_pcs_reset_n,
        cal_lane1_pma_reset_n  => SLOWCONTROLS_0_cal_lane1_pma_reset_n,
        cal_serdes_reset_n     => OPEN,
        calscl                 => ROCtoCAL_LVTTL1_net_0,
        dtc_enable_reset       => SLOWCONTROLS_0_dtc_enable_reset,
        dtc_serdes_reset_n     => SLOWCONTROLS_0_dtc_serdes_reset_n,
        enable_fiber_clock     => SLOWCONTROLS_0_enable_fiber_clock,
        enable_fiber_marker    => SLOWCONTROLS_0_enable_fiber_marker,
        ewm_50mhz              => SLOWCONTROLS_0_ewm_50mhz,
        ewm_enable_50mhz       => SLOWCONTROLS_0_ewm_enable_50mhz,
        force_full             => SLOWCONTROLS_0_force_full,
        hv_lane0_pcs_reset_n   => SLOWCONTROLS_0_hv_lane0_pcs_reset_n,
        hv_lane0_pma_reset_n   => SLOWCONTROLS_0_hv_lane0_pma_reset_n,
        hv_lane1_pcs_reset_n   => SLOWCONTROLS_0_hv_lane1_pcs_reset_n,
        hv_lane1_pma_reset_n   => SLOWCONTROLS_0_hv_lane1_pma_reset_n,
        hv_serdes_reset_n      => OPEN,
        hvscl                  => ROCtoHV_LVTTL0_net_0,
        reset_fifo_n           => SLOWCONTROLS_0_reset_fifo_n,
        serdes_re0             => OPEN,
        serdes_re1             => OPEN,
        serdes_re2             => OPEN,
        serdes_re3             => OPEN,
        use_uart               => SLOWCONTROLS_0_use_uart,
        write_to_fifo          => OPEN,
        DDRCFODELTAHB          => SLOWCONTROLS_0_DDRCFODELTAHB,
        DDRCFONUMBERHB         => SLOWCONTROLS_0_DDRCFONUMBERHB,
        DDRCFOOFFSET           => SLOWCONTROLS_0_DDRCFOOFFSET,
        DTCSIMADDR             => DTCSIMADDR_net_0,
        DTCSIMBLKADDR          => OPEN,
        DTCSIMBLKDATA          => OPEN,
        DTCSIMDATA             => DTCSIMDATA_net_0,
        DTCSIMPARAM            => DTCSIMPARAM_net_0,
        DTCSIMSPILLDATA        => DTCSIMSPILLDATA_net_0,
        GPIO_OUT               => GPIO_OUT_net_0,
        PRDATA                 => MIV_RV32IMC_C0_0_APB_MSTR_PRDATA,
        SERDES_HOWMANY         => OPEN,
        dtc_error_address      => SLOWCONTROLS_0_dtc_error_address,
        dummy_status_address   => OPEN,
        event_window_early_cut => OPEN,
        event_window_expected  => OPEN,
        event_window_late_cut  => OPEN,
        ewm_delay              => SLOWCONTROLS_0_ewm_delay,
        use_lane               => SLOWCONTROLS_0_use_lane,
        -- Inouts
        calsda                 => ROCtoCAL_LVTTL2,
        hvsda                  => ROCtoHV_LVTTL1 
        );
-- TOP_SERDES_0
TOP_SERDES_0 : TOP_SERDES
    port map( 
        -- Inputs
        CTRL_ARST_N                => AND2_3_Y,
        CTRL_CLK                   => PF_CLK_DIV_C0_0_CLK_OUT,
        DATAREQ_DATA_READY         => NewDDRInterface_0_data_ready,
        DATAREQ_LAST_WORD          => NewDDRInterface_0_last_word,
        DCS_CAL_LANE0_EMPTY        => DigiInterface_0_CAL_lane0_empty,
        DCS_CAL_LANE1_EMPTY        => DigiInterface_0_CAL_lane1_empty,
        DCS_CLK                    => PF_CCC_C0_0_OUT0_FABCLK_0,
        DCS_DATA_ERR               => NewDDRInterface_0_data_error,
        DCS_DREQ_FIFO_EMPTY        => NewDDRInterface_0_DREQ_FIFO_EMPTY,
        DCS_DREQ_FIFO_FULL         => NewDDRInterface_0_DREQ_FIFO_FULL,
        DCS_EVT_ERR                => NewDDRInterface_0_event_error,
        DCS_HDR1_ERR               => NewDDRInterface_0_header1_error,
        DCS_HDR2_ERR               => NewDDRInterface_0_header2_error,
        DCS_HV_LANE0_EMPTY         => DigiInterface_0_HV_lane0_empty,
        DCS_HV_LANE1_EMPTY         => DigiInterface_0_HV_lane1_empty,
        DREQCLK_RESETN             => DReqClkReset_FABRIC_RESET_N,
        DREQ_CLK                   => PF_CCC_C0_0_OUT2_FABCLK_0,
        DTCALIGN_RESETN            => SLOWCONTROLS_0_DTCALIGN_RESETN,
        DTCSIM_EN                  => AND2_1_Y,
        ENABLE_ALIGNMENT           => SLOWCONTROLS_0_dtc_enable_reset,
        EXT_RST_N                  => AND3_1_Y,
        FPGA_POR_N                 => INIT_component_0_FABRIC_POR_N,
        HRESETN                    => Reset50MHz_FABRIC_RESET_N,
        INIT_DONE                  => INIT_component_0_DEVICE_INIT_DONE,
        LANE0_RXD_N                => ROC_DTC_SERDES_RXD0_N,
        LANE0_RXD_P                => ROC_DTC_SERDES_RXD0_P,
        PLL_LOCK                   => PF_CCC_C0_0_PLL_LOCK_0,
        PRBS_EN                    => GND_net,
        REF_CLK_PAD_N              => ROCtoDTC_SERDES_CLK_N,
        REF_CLK_PAD_P              => ROCtoDTC_SERDES_CLK_P,
        DATAREQ_DATA               => NewDDRInterface_0_et_fifo_rdata,
        DATAREQ_PACKETS_IN_EVT     => NewDDRInterface_0_et_pckts,
        DATAREQ_STATUS             => DATAREQ_STATUS_const_net_0,
        DCS_DREQCNT                => NewDDRInterface_0_start_tag_cnt,
        DCS_DREQNULL               => NewDDRInterface_0_tag_null_cnt,
        DCS_DREQREAD               => NewDDRInterface_0_tag_sent_cnt,
        DCS_DREQSENT               => NewDDRInterface_0_tag_done_cnt,
        DCS_FETCH_CNT              => NewDDRInterface_0_fetch_cnt,
        DCS_FETCH_POS              => NewDDRInterface_0_fetch_pos_cnt,
        DCS_HBCNT                  => NewDDRInterface_0_hb_seen_cnt,
        DCS_HBONHOLD               => NewDDRInterface_0_hb_cnt,
        DCS_NULLHBCNT              => NewDDRInterface_0_hb_null_cnt,
        DCS_OFFSETTAG              => NewDDRInterface_0_ewtag_offset_out,
        DCS_PREFCNT                => NewDDRInterface_0_pref_seen_cnt,
        DCS_STORE_CNT              => NewDDRInterface_0_store_cnt,
        DCS_STORE_POS              => NewDDRInterface_0_store_pos_cnt,
        DTCSIM_DATA                => DTCSimulator_0_SIM_TX_DATA,
        DTCSIM_KCHAR               => DTCSimulator_0_SIM_TX_KCHAR,
        PRBS_DATA                  => PRBS_DATA_const_net_0,
        PRBS_KCHAR                 => PRBS_KCHAR_const_net_0,
        address_counter            => SLOWCONTROLS_0_dtc_error_address,
        cntrl_state_count          => DigiInterface_0_state_count,
        data_expc                  => NewDDRInterface_0_data_expc,
        data_seen                  => NewDDRInterface_0_data_seen,
        evt_expc                   => NewDDRInterface_0_evt_expc,
        evt_seen                   => NewDDRInterface_0_evt_seen,
        ewm_out_counter            => counter_16bit_0_cnt,
        hdr1_expc                  => NewDDRInterface_0_hdr1_expc,
        hdr1_seen                  => NewDDRInterface_0_hdr1_seen,
        hdr2_expc                  => NewDDRInterface_0_hdr2_expc,
        hdr2_seen                  => NewDDRInterface_0_hdr2_seen,
        -- Outputs
        CLOCK_ALIGNED              => CLOCK_ALIGNED_net_0,
        DATAREQ_RE_FIFO            => TOP_SERDES_0_DATAREQ_RE_FIFO,
        DATAREQ_START_EVENT        => TOP_SERDES_0_DATAREQ_START_EVENT,
        DCS_DDRRESET               => TOP_SERDES_0_DCS_DDRRESET,
        DCS_PATTERN_EN             => TOP_SERDES_0_DCS_PATTERN_EN,
        EWM_SEEN                   => TOP_SERDES_0_EWM_SEEN,
        FETCH_START                => TOP_SERDES_0_FETCH_START,
        HEARTBEAT_SEEN             => TOP_SERDES_0_HEARTBEAT_SEEN,
        LANE0_RX_CLK_R             => TOP_SERDES_0_LANE0_RX_CLK_R,
        LANE0_TXD_N                => ROC_DTC_SERDES_TXD0_N_net_0,
        LANE0_TXD_P                => ROC_DTC_SERDES_TXD0_P_net_0,
        LANE0_TX_CLK_R             => TOP_SERDES_0_LANE0_TX_CLK_R,
        NEWSPILL                   => TOP_SERDES_0_NEWSPILL,
        NULL_HEARTBEAT_SEEN        => TOP_SERDES_0_NULL_HEARTBEAT_SEEN,
        ONSPILL                    => TOP_SERDES_0_ONSPILL,
        PCS_ALIGNED                => TOP_SERDES_0_PCS_ALIGNED,
        PREFETCH_SEEN              => TOP_SERDES_0_PREFETCH_SEEN,
        RXCLK_RESETN               => TOP_SERDES_0_RXCLK_RESETN,
        TXCLK_RESETN               => TOP_SERDES_0_TXCLK_RESETN,
        word_aligned               => word_aligned_net_0,
        ALIGNMENT_LOSS_COUNTER     => ALIGNMENT_LOSS_COUNTER_net_0,
        DATAREQ_EVENT_WINDOW_TAG   => TOP_SERDES_0_DATAREQ_EVENT_WINDOW_TAG,
        DCS_TAG_OFFSET             => OPEN,
        DCS_USE_LANE               => TOP_SERDES_0_DCS_USE_LANE,
        DTCDATA_OUT                => TOP_SERDES_0_DTCDATA_OUT,
        EVT_MODE                   => OPEN,
        FETCH_EVENT_WINDOW_TAG     => TOP_SERDES_0_FETCH_EVENT_WINDOW_TAG,
        HEARTBEAT_EVENT_WINDOW_TAG => TOP_SERDES_0_HEARTBEAT_EVENT_WINDOW_TAG,
        PREFETCH_EVENT_WINDOW_TAG  => PREFETCH_EVENT_WINDOW_TAG_net_0,
        SPILL_EVENT_WINDOW_TAG     => TOP_SERDES_0_SPILL_EVENT_WINDOW_TAG,
        counter_out                => TOP_SERDES_0_counter_out 
        );

end RTL;
