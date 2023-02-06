----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:24:44 2023
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
-- TOP_SERDES entity declaration
----------------------------------------------------------------------
entity TOP_SERDES is
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
end TOP_SERDES;
----------------------------------------------------------------------
-- TOP_SERDES architecture body
----------------------------------------------------------------------
architecture RTL of TOP_SERDES is
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
-- crc
component crc
    -- Port list
    port(
        -- Inputs
        CLK     : in  std_logic;
        CRC_EN  : in  std_logic;
        DATA_IN : in  std_logic_vector(15 downto 0);
        RST     : in  std_logic;
        -- Outputs
        CRC_OUT : out std_logic_vector(15 downto 0)
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
-- DCSProcessor
component DCSProcessor
    -- Port list
    port(
        -- Inputs
        clk           : in  std_logic;
        crc_data_in   : in  std_logic_vector(15 downto 0);
        fifo_data_in  : in  std_logic_vector(15 downto 0);
        fifo_rdcnt    : in  std_logic_vector(10 downto 0);
        ready_reg     : in  std_logic;
        reg_data_out  : in  std_logic_vector(15 downto 0);
        reset_n       : in  std_logic;
        -- Outputs
        crc_data_out  : out std_logic_vector(15 downto 0);
        crc_en        : out std_logic;
        crc_rst       : out std_logic;
        error_count   : out std_logic_vector(15 downto 0);
        fifo_data_out : out std_logic_vector(17 downto 0);
        fifo_re       : out std_logic;
        fifo_we       : out std_logic;
        read_reg      : out std_logic;
        reg_address   : out std_logic_vector(15 downto 0);
        reg_data_in   : out std_logic_vector(15 downto 0);
        state_count   : out std_logic_vector(7 downto 0);
        write_reg     : out std_logic
        );
end component;
-- DRACRegisters
component DRACRegisters
    -- Port list
    port(
        -- Inputs
        ADDR_IN             : in  std_logic_vector(15 downto 0);
        DATA_IN             : in  std_logic_vector(15 downto 0);
        DCS_CAL_LANE0_EMPTY : in  std_logic;
        DCS_CAL_LANE1_EMPTY : in  std_logic;
        DCS_CLK             : in  std_logic;
        DCS_DATA_ERR        : in  std_logic;
        DCS_DREQCNT         : in  std_logic_vector(31 downto 0);
        DCS_DREQNULL        : in  std_logic_vector(31 downto 0);
        DCS_DREQREAD        : in  std_logic_vector(31 downto 0);
        DCS_DREQSENT        : in  std_logic_vector(31 downto 0);
        DCS_DREQTAG         : in  std_logic_vector(47 downto 0);
        DCS_DREQ_FIFO_EMPTY : in  std_logic;
        DCS_DREQ_FIFO_FULL  : in  std_logic;
        DCS_ERR_EXPC        : in  std_logic_vector(63 downto 0);
        DCS_ERR_SEEN        : in  std_logic_vector(63 downto 0);
        DCS_EVT_ERR         : in  std_logic;
        DCS_FETCHTAG        : in  std_logic_vector(47 downto 0);
        DCS_FETCH_CNT       : in  std_logic_vector(19 downto 0);
        DCS_FETCH_POS       : in  std_logic_vector(1 downto 0);
        DCS_HBCNT           : in  std_logic_vector(31 downto 0);
        DCS_HBONHOLD        : in  std_logic_vector(31 downto 0);
        DCS_HBTAG           : in  std_logic_vector(47 downto 0);
        DCS_HDR1_ERR        : in  std_logic;
        DCS_HDR2_ERR        : in  std_logic;
        DCS_HV_LANE0_EMPTY  : in  std_logic;
        DCS_HV_LANE1_EMPTY  : in  std_logic;
        DCS_NULLHBCNT       : in  std_logic_vector(31 downto 0);
        DCS_OFFSETTAG       : in  std_logic_vector(47 downto 0);
        DCS_PREFCNT         : in  std_logic_vector(31 downto 0);
        DCS_PREFTAG         : in  std_logic_vector(47 downto 0);
        DCS_SPILLCNT        : in  std_logic_vector(19 downto 0);
        DCS_STORE_CNT       : in  std_logic_vector(19 downto 0);
        DCS_STORE_POS       : in  std_logic_vector(1 downto 0);
        DEBUG_REG_0         : in  std_logic_vector(15 downto 0);
        READ_REG            : in  std_logic;
        RESET_N             : in  std_logic;
        WRITE_REG           : in  std_logic;
        -- Outputs
        DATA_OUT            : out std_logic_vector(15 downto 0);
        DCS_DDRRESET        : out std_logic;
        DCS_ERR_REQ         : out std_logic_vector(1 downto 0);
        DCS_PATTERN_EN      : out std_logic;
        DCS_TAG_OFFSET      : out std_logic_vector(47 downto 0);
        DCS_USE_LANE        : out std_logic_vector(3 downto 0);
        PREREAD_PULSE       : out std_logic;
        READY_REG           : out std_logic;
        SEL_RST             : out std_logic
        );
end component;
-- DREQProcessor
component DREQProcessor
    -- Port list
    port(
        -- Inputs
        DATAREQ_DATA             : in  std_logic_vector(63 downto 0);
        DATAREQ_DATA_READY       : in  std_logic;
        DATAREQ_LAST_WORD        : in  std_logic;
        DATAREQ_PACKETS_IN_EVT   : in  std_logic_vector(9 downto 0);
        DATAREQ_STATUS           : in  std_logic_vector(7 downto 0);
        clk                      : in  std_logic;
        crc_data_in              : in  std_logic_vector(15 downto 0);
        dreq_fifo_in             : in  std_logic_vector(15 downto 0);
        dreq_rdcnt               : in  std_logic_vector(10 downto 0);
        reset_n                  : in  std_logic;
        -- Outputs
        DATAREQ_EVENT_WINDOW_TAG : out std_logic_vector(47 downto 0);
        DATAREQ_RE_FIFO          : out std_logic;
        DATAREQ_START_EVENT      : out std_logic;
        FETCH_EVENT_WINDOW_TAG   : out std_logic_vector(47 downto 0);
        FETCH_START              : out std_logic;
        crc_data_out             : out std_logic_vector(15 downto 0);
        crc_en                   : out std_logic;
        crc_rst                  : out std_logic;
        dreq_error_count         : out std_logic_vector(15 downto 0);
        dreq_fifo_out            : out std_logic_vector(17 downto 0);
        dreq_fifo_re             : out std_logic;
        dreq_fifo_we             : out std_logic;
        dreq_state_count         : out std_logic_vector(7 downto 0)
        );
end component;
-- ErrorCounter
component ErrorCounter
    -- Port list
    port(
        -- Inputs
        address              : in  std_logic_vector(7 downto 0);
        aligned              : in  std_logic;
        b_cerr               : in  std_logic_vector(1 downto 0);
        clk                  : in  std_logic;
        clock_marker_counter : in  std_logic_vector(15 downto 0);
        cntrl_state_count    : in  std_logic_vector(7 downto 0);
        code_err_n           : in  std_logic_vector(1 downto 0);
        dreq_crc_error       : in  std_logic_vector(15 downto 0);
        dtc_seq_error        : in  std_logic_vector(15 downto 0);
        event_marker_counter : in  std_logic_vector(15 downto 0);
        ewm                  : in  std_logic;
        ewm_out_counter      : in  std_logic_vector(15 downto 0);
        invalid_k            : in  std_logic_vector(1 downto 0);
        loop_marker_counter  : in  std_logic_vector(15 downto 0);
        marker_error         : in  std_logic_vector(15 downto 0);
        other_marker_counter : in  std_logic_vector(15 downto 0);
        rd_err               : in  std_logic_vector(1 downto 0);
        reset_n              : in  std_logic;
        retr_marker_counter  : in  std_logic_vector(15 downto 0);
        rx_crc_error         : in  std_logic_vector(15 downto 0);
        rx_err               : in  std_logic;
        rx_packet_error      : in  std_logic_vector(15 downto 0);
        rx_val               : in  std_logic;
        -- Outputs
        counter_out          : out std_logic_vector(15 downto 0)
        );
end component;
-- req_err_switch
component req_err_switch
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
        expc_err  : out std_logic_vector(63 downto 0);
        seen_err  : out std_logic_vector(63 downto 0)
        );
end component;
-- RxPacketFIFO
component RxPacketFIFO
    -- Port list
    port(
        -- Inputs
        DATA     : in  std_logic_vector(19 downto 0);
        RCLOCK   : in  std_logic;
        RE       : in  std_logic;
        RRESET_N : in  std_logic;
        WCLOCK   : in  std_logic;
        WE       : in  std_logic;
        WRESET_N : in  std_logic;
        -- Outputs
        EMPTY    : out std_logic;
        FULL     : out std_logic;
        Q        : out std_logic_vector(19 downto 0);
        RDCNT    : out std_logic_vector(10 downto 0)
        );
end component;
-- RxPacketReader
component RxPacketReader
    -- Port list
    port(
        -- Inputs
        aligned                    : in  std_logic;
        clk                        : in  std_logic;
        reset_n                    : in  std_logic;
        rx_data_in                 : in  std_logic_vector(15 downto 0);
        rx_kchar_in                : in  std_logic_vector(1 downto 0);
        -- Outputs
        EVT_MODE                   : out std_logic_vector(31 downto 0);
        HEARTBEAT_EVENT_WINDOW_TAG : out std_logic_vector(47 downto 0);
        HEARTBEAT_SEEN             : out std_logic;
        NEWSPILL                   : out std_logic;
        NULL_HEARTBEAT_SEEN        : out std_logic;
        ONSPILL                    : out std_logic;
        PREFETCH_EVENT_WINDOW_TAG  : out std_logic_vector(47 downto 0);
        PREFETCH_SEEN              : out std_logic;
        SPILL_EVENT_WINDOW_TAG     : out std_logic_vector(19 downto 0);
        clock_marker_count         : out std_logic_vector(15 downto 0);
        clockmarker                : out std_logic;
        event_marker_count         : out std_logic_vector(15 downto 0);
        eventmarker                : out std_logic;
        loop_marker_count          : out std_logic_vector(15 downto 0);
        loopmarker                 : out std_logic;
        marker_error_count         : out std_logic_vector(15 downto 0);
        other_marker_count         : out std_logic_vector(15 downto 0);
        othermarker                : out std_logic;
        req_we                     : out std_logic;
        retr_marker_count          : out std_logic_vector(15 downto 0);
        retr_seq                   : out std_logic_vector(2 downto 0);
        retrmarker                 : out std_logic;
        rx_data_out                : out std_logic_vector(15 downto 0);
        rx_error_count             : out std_logic_vector(15 downto 0);
        rx_we                      : out std_logic;
        seq_error_count            : out std_logic_vector(15 downto 0)
        );
end component;
-- TxPacketWriter
component TxPacketWriter
    -- Port list
    port(
        -- Inputs
        clk               : in  std_logic;
        dcs_fifo_data_in  : in  std_logic_vector(17 downto 0);
        dcs_fifo_rdcnt    : in  std_logic_vector(10 downto 0);
        dreq_fifo_data_in : in  std_logic_vector(17 downto 0);
        dreq_fifo_rdcnt   : in  std_logic_vector(10 downto 0);
        reset_n           : in  std_logic;
        -- Outputs
        dcs_fifo_re       : out std_logic;
        dreq_fifo_re      : out std_logic;
        tx_data_out       : out std_logic_vector(15 downto 0);
        tx_kchar_out      : out std_logic_vector(1 downto 0)
        );
end component;
-- XCVR_Block
component XCVR_Block
    -- Port list
    port(
        -- Inputs
        ALIGN_RESETN           : in  std_logic;
        CTRL_ARST_N            : in  std_logic;
        CTRL_CLK               : in  std_logic;
        DTCSIM_DATA            : in  std_logic_vector(15 downto 0);
        DTCSIM_EN              : in  std_logic;
        DTCSIM_KCHAR           : in  std_logic_vector(1 downto 0);
        ENABLE_ALIGNMENT       : in  std_logic;
        LANE0_RXD_N            : in  std_logic;
        LANE0_RXD_P            : in  std_logic;
        PRBS_DATA              : in  std_logic_vector(15 downto 0);
        PRBS_EN                : in  std_logic;
        PRBS_KCHAR             : in  std_logic_vector(1 downto 0);
        REF_CLK_PAD_N          : in  std_logic;
        REF_CLK_PAD_P          : in  std_logic;
        TX_DATA                : in  std_logic_vector(15 downto 0);
        TX_K_CHAR              : in  std_logic_vector(1 downto 0);
        TX_RESETN              : in  std_logic;
        -- Outputs
        ALIGNMENT_LOSS_COUNTER : out std_logic_vector(7 downto 0);
        B_CERR                 : out std_logic_vector(1 downto 0);
        CLOCK_ALIGNED          : out std_logic;
        CODE_ERR_N             : out std_logic_vector(1 downto 0);
        DTCDATA_OUT            : out std_logic_vector(31 downto 0);
        EPCS_RxERR             : out std_logic;
        INVALID_K              : out std_logic_vector(1 downto 0);
        LANE0_RX_CLK_R         : out std_logic;
        LANE0_RX_READY         : out std_logic;
        LANE0_RX_VAL           : out std_logic;
        LANE0_TXD_N            : out std_logic;
        LANE0_TXD_P            : out std_logic;
        LANE0_TX_CLK_R         : out std_logic;
        LANE0_TX_CLK_STABLE    : out std_logic;
        PCS_ALIGNED            : out std_logic;
        RD_ERR                 : out std_logic_vector(1 downto 0);
        RX_DATA                : out std_logic_vector(15 downto 0);
        RX_K_CHAR              : out std_logic_vector(1 downto 0);
        resetn_align           : out std_logic;
        word_aligned           : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal ALIGNMENT_LOSS_COUNTER_net_0        : std_logic_vector(7 downto 0);
signal AND2_1_Y                            : std_logic;
signal CLOCK_ALIGNED_net_0                 : std_logic;
signal counter_out_net_0                   : std_logic_vector(15 downto 0);
signal crc_0_CRC_OUT                       : std_logic_vector(15 downto 0);
signal crc_1_CRC_OUT                       : std_logic_vector(15 downto 0);
signal DATAREQ_EVENT_WINDOW_TAG_net_0      : std_logic_vector(47 downto 0);
signal DATAREQ_RE_FIFO_net_0               : std_logic;
signal DATAREQ_START_EVENT_net_0           : std_logic;
signal DCS_DDRRESET_net_0                  : std_logic;
signal DCS_PATTERN_EN_net_0                : std_logic;
signal DCS_TAG_OFFSET_net_0                : std_logic_vector(47 downto 0);
signal DCS_USE_LANE_net_0                  : std_logic_vector(3 downto 0);
signal DCSClkReset_FABRIC_RESET_N          : std_logic;
signal DCSProcessor_0_crc_data_out         : std_logic_vector(15 downto 0);
signal DCSProcessor_0_crc_en               : std_logic;
signal DCSProcessor_0_crc_rst              : std_logic;
signal DCSProcessor_0_error_count          : std_logic_vector(15 downto 0);
signal DCSProcessor_0_fifo_data_out        : std_logic_vector(17 downto 0);
signal DCSProcessor_0_fifo_re              : std_logic;
signal DCSProcessor_0_fifo_we              : std_logic;
signal DCSProcessor_0_read_reg             : std_logic;
signal DCSProcessor_0_reg_address          : std_logic_vector(15 downto 0);
signal DCSProcessor_0_reg_data_in          : std_logic_vector(15 downto 0);
signal DCSProcessor_0_write_reg            : std_logic;
signal DRACRegisters_0_DATA_OUT            : std_logic_vector(15 downto 0);
signal DRACRegisters_0_DCS_ERR_REQ         : std_logic_vector(1 downto 0);
signal DRACRegisters_0_READY_REG           : std_logic;
signal DREQProcessor_0_crc_data_out        : std_logic_vector(15 downto 0);
signal DREQProcessor_0_crc_en              : std_logic;
signal DREQProcessor_0_crc_rst             : std_logic;
signal DREQProcessor_0_dreq_error_count    : std_logic_vector(15 downto 0);
signal DREQProcessor_0_dreq_fifo_out       : std_logic_vector(17 downto 0);
signal DREQProcessor_0_dreq_fifo_re        : std_logic;
signal DREQProcessor_0_dreq_fifo_we        : std_logic;
signal DTCDATA_OUT_net_0                   : std_logic_vector(31 downto 0);
signal EVT_MODE_net_0                      : std_logic_vector(31 downto 0);
signal EWM_SEEN_net_0                      : std_logic;
signal FETCH_EVENT_WINDOW_TAG_net_0        : std_logic_vector(47 downto 0);
signal FETCH_START_net_0                   : std_logic;
signal HEARTBEAT_EVENT_WINDOW_TAG_net_0    : std_logic_vector(47 downto 0);
signal HEARTBEAT_SEEN_net_0                : std_logic;
signal LANE0_RX_CLK_R_net_0                : std_logic;
signal LANE0_TX_CLK_R_net_0                : std_logic;
signal LANE0_TXD_N_net_0                   : std_logic;
signal LANE0_TXD_P_net_0                   : std_logic;
signal NEWSPILL_net_0                      : std_logic;
signal NULL_HEARTBEAT_SEEN_net_0           : std_logic;
signal ONSPILL_net_0                       : std_logic;
signal PCS_ALIGNED_net_0                   : std_logic;
signal PREFETCH_EVENT_WINDOW_TAG_net_0     : std_logic_vector(47 downto 0);
signal PREFETCH_SEEN_net_0                 : std_logic;
signal req_err_switch_0_expc_err           : std_logic_vector(63 downto 0);
signal req_err_switch_0_seen_err           : std_logic_vector(63 downto 0);
signal RXCLK_RESETN_net_0                  : std_logic;
signal RxPacketFIFO_0_Q15to0               : std_logic_vector(15 downto 0);
signal RxPacketFIFO_0_RDCNT                : std_logic_vector(10 downto 0);
signal RxPacketFIFO_1_Q17to0               : std_logic_vector(17 downto 0);
signal RxPacketFIFO_1_RDCNT                : std_logic_vector(10 downto 0);
signal RxPacketFIFO_2_Q15to0               : std_logic_vector(15 downto 0);
signal RxPacketFIFO_2_RDCNT                : std_logic_vector(10 downto 0);
signal RxPacketFIFO_3_Q17to0               : std_logic_vector(17 downto 0);
signal RxPacketFIFO_3_RDCNT                : std_logic_vector(10 downto 0);
signal RxPacketReader_0_clock_marker_count : std_logic_vector(15 downto 0);
signal RxPacketReader_0_event_marker_count : std_logic_vector(15 downto 0);
signal RxPacketReader_0_loop_marker_count  : std_logic_vector(15 downto 0);
signal RxPacketReader_0_marker_error_count : std_logic_vector(15 downto 0);
signal RxPacketReader_0_other_marker_count : std_logic_vector(15 downto 0);
signal RxPacketReader_0_req_we             : std_logic;
signal RxPacketReader_0_retr_marker_count  : std_logic_vector(15 downto 0);
signal RxPacketReader_0_rx_data_out        : std_logic_vector(15 downto 0);
signal RxPacketReader_0_rx_error_count     : std_logic_vector(15 downto 0);
signal RxPacketReader_0_rx_we              : std_logic;
signal RxPacketReader_0_seq_error_count    : std_logic_vector(15 downto 0);
signal SPILL_EVENT_WINDOW_TAG_net_0        : std_logic_vector(19 downto 0);
signal TXCLK_RESETN_net_0                  : std_logic;
signal TxPacketWriter_0_dcs_fifo_re        : std_logic;
signal TxPacketWriter_0_dreq_fifo_re       : std_logic;
signal TxPacketWriter_0_tx_data_out        : std_logic_vector(15 downto 0);
signal TxPacketWriter_0_tx_kchar_out       : std_logic_vector(1 downto 0);
signal word_aligned_net_0                  : std_logic;
signal XCVR_Block_0_B_CERR                 : std_logic_vector(1 downto 0);
signal XCVR_Block_0_CODE_ERR_N             : std_logic_vector(1 downto 0);
signal XCVR_Block_0_EPCS_RxERR             : std_logic;
signal XCVR_Block_0_INVALID_K              : std_logic_vector(1 downto 0);
signal XCVR_Block_0_LANE0_RX_READY         : std_logic;
signal XCVR_Block_0_LANE0_RX_VAL           : std_logic;
signal XCVR_Block_0_LANE0_TX_CLK_STABLE    : std_logic;
signal XCVR_Block_0_RD_ERR                 : std_logic_vector(1 downto 0);
signal XCVR_Block_0_resetn_align           : std_logic;
signal XCVR_Block_0_RX_DATA                : std_logic_vector(15 downto 0);
signal XCVR_Block_0_RX_K_CHAR              : std_logic_vector(1 downto 0);
signal CLOCK_ALIGNED_net_1                 : std_logic;
signal DATAREQ_RE_FIFO_net_1               : std_logic;
signal DATAREQ_START_EVENT_net_1           : std_logic;
signal DCS_DDRRESET_net_1                  : std_logic;
signal DCS_PATTERN_EN_net_1                : std_logic;
signal EWM_SEEN_net_1                      : std_logic;
signal FETCH_START_net_1                   : std_logic;
signal HEARTBEAT_SEEN_net_1                : std_logic;
signal LANE0_RX_CLK_R_net_1                : std_logic;
signal LANE0_TXD_N_net_1                   : std_logic;
signal LANE0_TXD_P_net_1                   : std_logic;
signal LANE0_TX_CLK_R_net_1                : std_logic;
signal NEWSPILL_net_1                      : std_logic;
signal NULL_HEARTBEAT_SEEN_net_1           : std_logic;
signal ONSPILL_net_1                       : std_logic;
signal PCS_ALIGNED_net_1                   : std_logic;
signal PREFETCH_SEEN_net_1                 : std_logic;
signal RXCLK_RESETN_net_1                  : std_logic;
signal TXCLK_RESETN_net_1                  : std_logic;
signal word_aligned_net_1                  : std_logic;
signal ALIGNMENT_LOSS_COUNTER_net_1        : std_logic_vector(7 downto 0);
signal DATAREQ_EVENT_WINDOW_TAG_net_1      : std_logic_vector(47 downto 0);
signal DCS_TAG_OFFSET_net_1                : std_logic_vector(47 downto 0);
signal DCS_USE_LANE_net_1                  : std_logic_vector(3 downto 0);
signal DTCDATA_OUT_net_1                   : std_logic_vector(31 downto 0);
signal EVT_MODE_net_1                      : std_logic_vector(31 downto 0);
signal FETCH_EVENT_WINDOW_TAG_net_1        : std_logic_vector(47 downto 0);
signal HEARTBEAT_EVENT_WINDOW_TAG_net_1    : std_logic_vector(47 downto 0);
signal PREFETCH_EVENT_WINDOW_TAG_net_1     : std_logic_vector(47 downto 0);
signal SPILL_EVENT_WINDOW_TAG_net_1        : std_logic_vector(19 downto 0);
signal counter_out_net_1                   : std_logic_vector(15 downto 0);
signal Q_slice_0                           : std_logic_vector(19 downto 16);
signal Q_slice_1                           : std_logic_vector(19 downto 18);
signal Q_slice_2                           : std_logic_vector(19 downto 16);
signal Q_slice_3                           : std_logic_vector(19 downto 18);
signal DATA_net_0                          : std_logic_vector(19 downto 0);
signal Q_net_0                             : std_logic_vector(19 downto 0);
signal DATA_net_1                          : std_logic_vector(19 downto 0);
signal Q_net_1                             : std_logic_vector(19 downto 0);
signal DATA_net_2                          : std_logic_vector(19 downto 0);
signal Q_net_2                             : std_logic_vector(19 downto 0);
signal DATA_net_3                          : std_logic_vector(19 downto 0);
signal Q_net_3                             : std_logic_vector(19 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                             : std_logic;
signal GND_net                             : std_logic;
signal DEBUG_REG_0_const_net_0             : std_logic_vector(15 downto 0);
signal DATA_const_net_0                    : std_logic_vector(19 downto 16);
signal DATA_const_net_1                    : std_logic_vector(19 downto 18);
signal DATA_const_net_2                    : std_logic_vector(19 downto 16);
signal DATA_const_net_3                    : std_logic_vector(19 downto 18);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net                 <= '1';
 GND_net                 <= '0';
 DEBUG_REG_0_const_net_0 <= B"0001001000110100";
 DATA_const_net_0        <= B"0000";
 DATA_const_net_1        <= B"00";
 DATA_const_net_2        <= B"0000";
 DATA_const_net_3        <= B"00";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CLOCK_ALIGNED_net_1                     <= CLOCK_ALIGNED_net_0;
 CLOCK_ALIGNED                           <= CLOCK_ALIGNED_net_1;
 DATAREQ_RE_FIFO_net_1                   <= DATAREQ_RE_FIFO_net_0;
 DATAREQ_RE_FIFO                         <= DATAREQ_RE_FIFO_net_1;
 DATAREQ_START_EVENT_net_1               <= DATAREQ_START_EVENT_net_0;
 DATAREQ_START_EVENT                     <= DATAREQ_START_EVENT_net_1;
 DCS_DDRRESET_net_1                      <= DCS_DDRRESET_net_0;
 DCS_DDRRESET                            <= DCS_DDRRESET_net_1;
 DCS_PATTERN_EN_net_1                    <= DCS_PATTERN_EN_net_0;
 DCS_PATTERN_EN                          <= DCS_PATTERN_EN_net_1;
 EWM_SEEN_net_1                          <= EWM_SEEN_net_0;
 EWM_SEEN                                <= EWM_SEEN_net_1;
 FETCH_START_net_1                       <= FETCH_START_net_0;
 FETCH_START                             <= FETCH_START_net_1;
 HEARTBEAT_SEEN_net_1                    <= HEARTBEAT_SEEN_net_0;
 HEARTBEAT_SEEN                          <= HEARTBEAT_SEEN_net_1;
 LANE0_RX_CLK_R_net_1                    <= LANE0_RX_CLK_R_net_0;
 LANE0_RX_CLK_R                          <= LANE0_RX_CLK_R_net_1;
 LANE0_TXD_N_net_1                       <= LANE0_TXD_N_net_0;
 LANE0_TXD_N                             <= LANE0_TXD_N_net_1;
 LANE0_TXD_P_net_1                       <= LANE0_TXD_P_net_0;
 LANE0_TXD_P                             <= LANE0_TXD_P_net_1;
 LANE0_TX_CLK_R_net_1                    <= LANE0_TX_CLK_R_net_0;
 LANE0_TX_CLK_R                          <= LANE0_TX_CLK_R_net_1;
 NEWSPILL_net_1                          <= NEWSPILL_net_0;
 NEWSPILL                                <= NEWSPILL_net_1;
 NULL_HEARTBEAT_SEEN_net_1               <= NULL_HEARTBEAT_SEEN_net_0;
 NULL_HEARTBEAT_SEEN                     <= NULL_HEARTBEAT_SEEN_net_1;
 ONSPILL_net_1                           <= ONSPILL_net_0;
 ONSPILL                                 <= ONSPILL_net_1;
 PCS_ALIGNED_net_1                       <= PCS_ALIGNED_net_0;
 PCS_ALIGNED                             <= PCS_ALIGNED_net_1;
 PREFETCH_SEEN_net_1                     <= PREFETCH_SEEN_net_0;
 PREFETCH_SEEN                           <= PREFETCH_SEEN_net_1;
 RXCLK_RESETN_net_1                      <= RXCLK_RESETN_net_0;
 RXCLK_RESETN                            <= RXCLK_RESETN_net_1;
 TXCLK_RESETN_net_1                      <= TXCLK_RESETN_net_0;
 TXCLK_RESETN                            <= TXCLK_RESETN_net_1;
 word_aligned_net_1                      <= word_aligned_net_0;
 word_aligned                            <= word_aligned_net_1;
 ALIGNMENT_LOSS_COUNTER_net_1            <= ALIGNMENT_LOSS_COUNTER_net_0;
 ALIGNMENT_LOSS_COUNTER(7 downto 0)      <= ALIGNMENT_LOSS_COUNTER_net_1;
 DATAREQ_EVENT_WINDOW_TAG_net_1          <= DATAREQ_EVENT_WINDOW_TAG_net_0;
 DATAREQ_EVENT_WINDOW_TAG(47 downto 0)   <= DATAREQ_EVENT_WINDOW_TAG_net_1;
 DCS_TAG_OFFSET_net_1                    <= DCS_TAG_OFFSET_net_0;
 DCS_TAG_OFFSET(47 downto 0)             <= DCS_TAG_OFFSET_net_1;
 DCS_USE_LANE_net_1                      <= DCS_USE_LANE_net_0;
 DCS_USE_LANE(3 downto 0)                <= DCS_USE_LANE_net_1;
 DTCDATA_OUT_net_1                       <= DTCDATA_OUT_net_0;
 DTCDATA_OUT(31 downto 0)                <= DTCDATA_OUT_net_1;
 EVT_MODE_net_1                          <= EVT_MODE_net_0;
 EVT_MODE(31 downto 0)                   <= EVT_MODE_net_1;
 FETCH_EVENT_WINDOW_TAG_net_1            <= FETCH_EVENT_WINDOW_TAG_net_0;
 FETCH_EVENT_WINDOW_TAG(47 downto 0)     <= FETCH_EVENT_WINDOW_TAG_net_1;
 HEARTBEAT_EVENT_WINDOW_TAG_net_1        <= HEARTBEAT_EVENT_WINDOW_TAG_net_0;
 HEARTBEAT_EVENT_WINDOW_TAG(47 downto 0) <= HEARTBEAT_EVENT_WINDOW_TAG_net_1;
 PREFETCH_EVENT_WINDOW_TAG_net_1         <= PREFETCH_EVENT_WINDOW_TAG_net_0;
 PREFETCH_EVENT_WINDOW_TAG(47 downto 0)  <= PREFETCH_EVENT_WINDOW_TAG_net_1;
 SPILL_EVENT_WINDOW_TAG_net_1            <= SPILL_EVENT_WINDOW_TAG_net_0;
 SPILL_EVENT_WINDOW_TAG(19 downto 0)     <= SPILL_EVENT_WINDOW_TAG_net_1;
 counter_out_net_1                       <= counter_out_net_0;
 counter_out(15 downto 0)                <= counter_out_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 RxPacketFIFO_0_Q15to0 <= Q_net_0(15 downto 0);
 RxPacketFIFO_1_Q17to0 <= Q_net_1(17 downto 0);
 RxPacketFIFO_2_Q15to0 <= Q_net_2(15 downto 0);
 RxPacketFIFO_3_Q17to0 <= Q_net_3(17 downto 0);
 Q_slice_0             <= Q_net_0(19 downto 16);
 Q_slice_1             <= Q_net_1(19 downto 18);
 Q_slice_2             <= Q_net_2(19 downto 16);
 Q_slice_3             <= Q_net_3(19 downto 18);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 DATA_net_0 <= ( B"0000" & RxPacketReader_0_rx_data_out );
 DATA_net_1 <= ( B"00" & DCSProcessor_0_fifo_data_out );
 DATA_net_2 <= ( B"0000" & RxPacketReader_0_rx_data_out );
 DATA_net_3 <= ( B"00" & DREQProcessor_0_dreq_fifo_out );
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_1
AND2_1 : AND2
    port map( 
        -- Inputs
        A => HRESETN,
        B => DTCALIGN_RESETN,
        -- Outputs
        Y => AND2_1_Y 
        );
-- crc_0
crc_0 : crc
    port map( 
        -- Inputs
        CLK     => DCS_CLK,
        RST     => DCSProcessor_0_crc_rst,
        CRC_EN  => DCSProcessor_0_crc_en,
        DATA_IN => DCSProcessor_0_crc_data_out,
        -- Outputs
        CRC_OUT => crc_0_CRC_OUT 
        );
-- crc_1
crc_1 : crc
    port map( 
        -- Inputs
        CLK     => DREQ_CLK,
        RST     => DREQProcessor_0_crc_rst,
        CRC_EN  => DREQProcessor_0_crc_en,
        DATA_IN => DREQProcessor_0_crc_data_out,
        -- Outputs
        CRC_OUT => crc_1_CRC_OUT 
        );
-- DCSClkReset
DCSClkReset : CORERESET
    port map( 
        -- Inputs
        CLK                => DCS_CLK,
        EXT_RST_N          => EXT_RST_N,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => VCC_net,
        PLL_LOCK           => PLL_LOCK,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => FPGA_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => DCSClkReset_FABRIC_RESET_N 
        );
-- DCSProcessor_0
DCSProcessor_0 : DCSProcessor
    port map( 
        -- Inputs
        reset_n       => DCSClkReset_FABRIC_RESET_N,
        clk           => DCS_CLK,
        fifo_rdcnt    => RxPacketFIFO_0_RDCNT,
        fifo_data_in  => RxPacketFIFO_0_Q15to0,
        crc_data_in   => crc_0_CRC_OUT,
        ready_reg     => DRACRegisters_0_READY_REG,
        reg_data_out  => DRACRegisters_0_DATA_OUT,
        -- Outputs
        fifo_re       => DCSProcessor_0_fifo_re,
        fifo_data_out => DCSProcessor_0_fifo_data_out,
        fifo_we       => DCSProcessor_0_fifo_we,
        crc_en        => DCSProcessor_0_crc_en,
        crc_rst       => DCSProcessor_0_crc_rst,
        crc_data_out  => DCSProcessor_0_crc_data_out,
        read_reg      => DCSProcessor_0_read_reg,
        write_reg     => DCSProcessor_0_write_reg,
        reg_address   => DCSProcessor_0_reg_address,
        reg_data_in   => DCSProcessor_0_reg_data_in,
        state_count   => OPEN,
        error_count   => DCSProcessor_0_error_count 
        );
-- DRACRegisters_0
DRACRegisters_0 : DRACRegisters
    port map( 
        -- Inputs
        DCS_CLK             => DCS_CLK,
        READ_REG            => DCSProcessor_0_read_reg,
        WRITE_REG           => DCSProcessor_0_write_reg,
        RESET_N             => DCSClkReset_FABRIC_RESET_N,
        ADDR_IN             => DCSProcessor_0_reg_address,
        DATA_IN             => DCSProcessor_0_reg_data_in,
        DEBUG_REG_0         => DEBUG_REG_0_const_net_0,
        DCS_CAL_LANE0_EMPTY => DCS_CAL_LANE0_EMPTY,
        DCS_CAL_LANE1_EMPTY => DCS_CAL_LANE1_EMPTY,
        DCS_HV_LANE0_EMPTY  => DCS_HV_LANE0_EMPTY,
        DCS_HV_LANE1_EMPTY  => DCS_HV_LANE1_EMPTY,
        DCS_EVT_ERR         => DCS_EVT_ERR,
        DCS_HDR1_ERR        => DCS_HDR1_ERR,
        DCS_HDR2_ERR        => DCS_HDR2_ERR,
        DCS_DATA_ERR        => DCS_DATA_ERR,
        DCS_ERR_EXPC        => req_err_switch_0_expc_err,
        DCS_ERR_SEEN        => req_err_switch_0_seen_err,
        DCS_DREQ_FIFO_FULL  => DCS_DREQ_FIFO_FULL,
        DCS_STORE_POS       => DCS_STORE_POS,
        DCS_STORE_CNT       => DCS_STORE_CNT,
        DCS_DREQ_FIFO_EMPTY => DCS_DREQ_FIFO_EMPTY,
        DCS_FETCH_POS       => DCS_FETCH_POS,
        DCS_FETCH_CNT       => DCS_FETCH_CNT,
        DCS_HBCNT           => DCS_HBCNT,
        DCS_NULLHBCNT       => DCS_NULLHBCNT,
        DCS_HBONHOLD        => DCS_HBONHOLD,
        DCS_PREFCNT         => DCS_PREFCNT,
        DCS_DREQCNT         => DCS_DREQCNT,
        DCS_DREQREAD        => DCS_DREQREAD,
        DCS_DREQSENT        => DCS_DREQSENT,
        DCS_DREQNULL        => DCS_DREQNULL,
        DCS_SPILLCNT        => SPILL_EVENT_WINDOW_TAG_net_0,
        DCS_HBTAG           => HEARTBEAT_EVENT_WINDOW_TAG_net_0,
        DCS_PREFTAG         => PREFETCH_EVENT_WINDOW_TAG_net_0,
        DCS_FETCHTAG        => FETCH_EVENT_WINDOW_TAG_net_0,
        DCS_DREQTAG         => DATAREQ_EVENT_WINDOW_TAG_net_0,
        DCS_OFFSETTAG       => DCS_OFFSETTAG,
        -- Outputs
        READY_REG           => DRACRegisters_0_READY_REG,
        DATA_OUT            => DRACRegisters_0_DATA_OUT,
        PREREAD_PULSE       => OPEN,
        SEL_RST             => OPEN,
        DCS_DDRRESET        => DCS_DDRRESET_net_0,
        DCS_PATTERN_EN      => DCS_PATTERN_EN_net_0,
        DCS_USE_LANE        => DCS_USE_LANE_net_0,
        DCS_ERR_REQ         => DRACRegisters_0_DCS_ERR_REQ,
        DCS_TAG_OFFSET      => DCS_TAG_OFFSET_net_0 
        );
-- DREQProcessor_0
DREQProcessor_0 : DREQProcessor
    port map( 
        -- Inputs
        reset_n                  => DREQCLK_RESETN,
        clk                      => DREQ_CLK,
        dreq_rdcnt               => RxPacketFIFO_2_RDCNT,
        dreq_fifo_in             => RxPacketFIFO_2_Q15to0,
        crc_data_in              => crc_1_CRC_OUT,
        DATAREQ_DATA_READY       => DATAREQ_DATA_READY,
        DATAREQ_LAST_WORD        => DATAREQ_LAST_WORD,
        DATAREQ_STATUS           => DATAREQ_STATUS,
        DATAREQ_DATA             => DATAREQ_DATA,
        DATAREQ_PACKETS_IN_EVT   => DATAREQ_PACKETS_IN_EVT,
        -- Outputs
        dreq_fifo_re             => DREQProcessor_0_dreq_fifo_re,
        dreq_fifo_out            => DREQProcessor_0_dreq_fifo_out,
        dreq_fifo_we             => DREQProcessor_0_dreq_fifo_we,
        crc_en                   => DREQProcessor_0_crc_en,
        crc_rst                  => DREQProcessor_0_crc_rst,
        crc_data_out             => DREQProcessor_0_crc_data_out,
        FETCH_START              => FETCH_START_net_0,
        FETCH_EVENT_WINDOW_TAG   => FETCH_EVENT_WINDOW_TAG_net_0,
        DATAREQ_START_EVENT      => DATAREQ_START_EVENT_net_0,
        DATAREQ_EVENT_WINDOW_TAG => DATAREQ_EVENT_WINDOW_TAG_net_0,
        DATAREQ_RE_FIFO          => DATAREQ_RE_FIFO_net_0,
        dreq_state_count         => OPEN,
        dreq_error_count         => DREQProcessor_0_dreq_error_count 
        );
-- ErrorCounter_0
ErrorCounter_0 : ErrorCounter
    port map( 
        -- Inputs
        reset_n              => XCVR_Block_0_resetn_align,
        clk                  => LANE0_RX_CLK_R_net_0,
        rx_val               => XCVR_Block_0_LANE0_RX_VAL,
        aligned              => PCS_ALIGNED_net_0,
        rx_err               => XCVR_Block_0_EPCS_RxERR,
        b_cerr               => XCVR_Block_0_B_CERR,
        invalid_k            => XCVR_Block_0_INVALID_K,
        code_err_n           => XCVR_Block_0_CODE_ERR_N,
        rd_err               => XCVR_Block_0_RD_ERR,
        rx_crc_error         => DCSProcessor_0_error_count,
        rx_packet_error      => RxPacketReader_0_rx_error_count,
        dreq_crc_error       => DREQProcessor_0_dreq_error_count,
        dtc_seq_error        => RxPacketReader_0_seq_error_count,
        marker_error         => RxPacketReader_0_marker_error_count,
        event_marker_counter => RxPacketReader_0_event_marker_count,
        clock_marker_counter => RxPacketReader_0_clock_marker_count,
        loop_marker_counter  => RxPacketReader_0_loop_marker_count,
        other_marker_counter => RxPacketReader_0_other_marker_count,
        retr_marker_counter  => RxPacketReader_0_retr_marker_count,
        ewm_out_counter      => ewm_out_counter,
        cntrl_state_count    => cntrl_state_count,
        ewm                  => EWM_SEEN_net_0,
        address              => address_counter,
        -- Outputs
        counter_out          => counter_out_net_0 
        );
-- req_err_switch_0
req_err_switch_0 : req_err_switch
    port map( 
        -- Inputs
        err_en    => DRACRegisters_0_DCS_ERR_REQ,
        evt_expc  => evt_expc,
        evt_seen  => evt_seen,
        hdr1_expc => hdr1_expc,
        hdr1_seen => hdr1_seen,
        hdr2_expc => hdr2_expc,
        hdr2_seen => hdr2_seen,
        data_expc => data_expc,
        data_seen => data_seen,
        -- Outputs
        expc_err  => req_err_switch_0_expc_err,
        seen_err  => req_err_switch_0_seen_err 
        );
-- RXClkReset
RXClkReset : CORERESET
    port map( 
        -- Inputs
        CLK                => LANE0_RX_CLK_R_net_0,
        EXT_RST_N          => EXT_RST_N,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => VCC_net,
        PLL_LOCK           => XCVR_Block_0_LANE0_RX_READY,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => FPGA_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => RXCLK_RESETN_net_0 
        );
-- RxPacketFIFO_0
RxPacketFIFO_0 : RxPacketFIFO
    port map( 
        -- Inputs
        WCLOCK   => LANE0_RX_CLK_R_net_0,
        RCLOCK   => DCS_CLK,
        WRESET_N => EXT_RST_N,
        RRESET_N => EXT_RST_N,
        DATA     => DATA_net_0,
        WE       => RxPacketReader_0_rx_we,
        RE       => DCSProcessor_0_fifo_re,
        -- Outputs
        Q        => Q_net_0,
        FULL     => OPEN,
        EMPTY    => OPEN,
        RDCNT    => RxPacketFIFO_0_RDCNT 
        );
-- RxPacketFIFO_1
RxPacketFIFO_1 : RxPacketFIFO
    port map( 
        -- Inputs
        WCLOCK   => DCS_CLK,
        RCLOCK   => LANE0_TX_CLK_R_net_0,
        WRESET_N => EXT_RST_N,
        RRESET_N => EXT_RST_N,
        DATA     => DATA_net_1,
        WE       => DCSProcessor_0_fifo_we,
        RE       => TxPacketWriter_0_dcs_fifo_re,
        -- Outputs
        Q        => Q_net_1,
        FULL     => OPEN,
        EMPTY    => OPEN,
        RDCNT    => RxPacketFIFO_1_RDCNT 
        );
-- RxPacketFIFO_2
RxPacketFIFO_2 : RxPacketFIFO
    port map( 
        -- Inputs
        WCLOCK   => LANE0_RX_CLK_R_net_0,
        RCLOCK   => DREQ_CLK,
        WRESET_N => EXT_RST_N,
        RRESET_N => EXT_RST_N,
        DATA     => DATA_net_2,
        WE       => RxPacketReader_0_req_we,
        RE       => DREQProcessor_0_dreq_fifo_re,
        -- Outputs
        Q        => Q_net_2,
        FULL     => OPEN,
        EMPTY    => OPEN,
        RDCNT    => RxPacketFIFO_2_RDCNT 
        );
-- RxPacketFIFO_3
RxPacketFIFO_3 : RxPacketFIFO
    port map( 
        -- Inputs
        WCLOCK   => DREQ_CLK,
        RCLOCK   => LANE0_TX_CLK_R_net_0,
        WRESET_N => EXT_RST_N,
        RRESET_N => EXT_RST_N,
        DATA     => DATA_net_3,
        WE       => DREQProcessor_0_dreq_fifo_we,
        RE       => TxPacketWriter_0_dreq_fifo_re,
        -- Outputs
        Q        => Q_net_3,
        FULL     => OPEN,
        EMPTY    => OPEN,
        RDCNT    => RxPacketFIFO_3_RDCNT 
        );
-- RxPacketReader_0
RxPacketReader_0 : RxPacketReader
    port map( 
        -- Inputs
        reset_n                    => RXCLK_RESETN_net_0,
        clk                        => LANE0_RX_CLK_R_net_0,
        aligned                    => PCS_ALIGNED_net_0,
        rx_data_in                 => XCVR_Block_0_RX_DATA,
        rx_kchar_in                => XCVR_Block_0_RX_K_CHAR,
        -- Outputs
        rx_we                      => RxPacketReader_0_rx_we,
        rx_data_out                => RxPacketReader_0_rx_data_out,
        req_we                     => RxPacketReader_0_req_we,
        HEARTBEAT_SEEN             => HEARTBEAT_SEEN_net_0,
        NULL_HEARTBEAT_SEEN        => NULL_HEARTBEAT_SEEN_net_0,
        PREFETCH_SEEN              => PREFETCH_SEEN_net_0,
        ONSPILL                    => ONSPILL_net_0,
        NEWSPILL                   => NEWSPILL_net_0,
        HEARTBEAT_EVENT_WINDOW_TAG => HEARTBEAT_EVENT_WINDOW_TAG_net_0,
        PREFETCH_EVENT_WINDOW_TAG  => PREFETCH_EVENT_WINDOW_TAG_net_0,
        SPILL_EVENT_WINDOW_TAG     => SPILL_EVENT_WINDOW_TAG_net_0,
        EVT_MODE                   => EVT_MODE_net_0,
        eventmarker                => EWM_SEEN_net_0,
        clockmarker                => OPEN,
        loopmarker                 => OPEN,
        othermarker                => OPEN,
        retrmarker                 => OPEN,
        retr_seq                   => OPEN,
        event_marker_count         => RxPacketReader_0_event_marker_count,
        clock_marker_count         => RxPacketReader_0_clock_marker_count,
        loop_marker_count          => RxPacketReader_0_loop_marker_count,
        other_marker_count         => RxPacketReader_0_other_marker_count,
        retr_marker_count          => RxPacketReader_0_retr_marker_count,
        rx_error_count             => RxPacketReader_0_rx_error_count,
        seq_error_count            => RxPacketReader_0_seq_error_count,
        marker_error_count         => RxPacketReader_0_marker_error_count 
        );
-- TXClkReset
TXClkReset : CORERESET
    port map( 
        -- Inputs
        CLK                => LANE0_TX_CLK_R_net_0,
        EXT_RST_N          => EXT_RST_N,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => VCC_net,
        PLL_LOCK           => XCVR_Block_0_LANE0_TX_CLK_STABLE,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => FPGA_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => TXCLK_RESETN_net_0 
        );
-- TxPacketWriter_0
TxPacketWriter_0 : TxPacketWriter
    port map( 
        -- Inputs
        reset_n           => TXCLK_RESETN_net_0,
        clk               => LANE0_TX_CLK_R_net_0,
        dcs_fifo_rdcnt    => RxPacketFIFO_1_RDCNT,
        dcs_fifo_data_in  => RxPacketFIFO_1_Q17to0,
        dreq_fifo_rdcnt   => RxPacketFIFO_3_RDCNT,
        dreq_fifo_data_in => RxPacketFIFO_3_Q17to0,
        -- Outputs
        dcs_fifo_re       => TxPacketWriter_0_dcs_fifo_re,
        dreq_fifo_re      => TxPacketWriter_0_dreq_fifo_re,
        tx_data_out       => TxPacketWriter_0_tx_data_out,
        tx_kchar_out      => TxPacketWriter_0_tx_kchar_out 
        );
-- XCVR_Block_0
XCVR_Block_0 : XCVR_Block
    port map( 
        -- Inputs
        ALIGN_RESETN           => AND2_1_Y,
        CTRL_ARST_N            => CTRL_ARST_N,
        CTRL_CLK               => CTRL_CLK,
        DTCSIM_EN              => DTCSIM_EN,
        ENABLE_ALIGNMENT       => ENABLE_ALIGNMENT,
        LANE0_RXD_N            => LANE0_RXD_N,
        LANE0_RXD_P            => LANE0_RXD_P,
        PRBS_EN                => PRBS_EN,
        REF_CLK_PAD_N          => REF_CLK_PAD_N,
        REF_CLK_PAD_P          => REF_CLK_PAD_P,
        TX_RESETN              => TXCLK_RESETN_net_0,
        DTCSIM_DATA            => DTCSIM_DATA,
        DTCSIM_KCHAR           => DTCSIM_KCHAR,
        PRBS_DATA              => PRBS_DATA,
        PRBS_KCHAR             => PRBS_KCHAR,
        TX_DATA                => TxPacketWriter_0_tx_data_out,
        TX_K_CHAR              => TxPacketWriter_0_tx_kchar_out,
        -- Outputs
        CLOCK_ALIGNED          => CLOCK_ALIGNED_net_0,
        EPCS_RxERR             => XCVR_Block_0_EPCS_RxERR,
        LANE0_RX_CLK_R         => LANE0_RX_CLK_R_net_0,
        LANE0_RX_READY         => XCVR_Block_0_LANE0_RX_READY,
        LANE0_RX_VAL           => XCVR_Block_0_LANE0_RX_VAL,
        LANE0_TXD_N            => LANE0_TXD_N_net_0,
        LANE0_TXD_P            => LANE0_TXD_P_net_0,
        LANE0_TX_CLK_R         => LANE0_TX_CLK_R_net_0,
        LANE0_TX_CLK_STABLE    => XCVR_Block_0_LANE0_TX_CLK_STABLE,
        PCS_ALIGNED            => PCS_ALIGNED_net_0,
        resetn_align           => XCVR_Block_0_resetn_align,
        word_aligned           => word_aligned_net_0,
        ALIGNMENT_LOSS_COUNTER => ALIGNMENT_LOSS_COUNTER_net_0,
        B_CERR                 => XCVR_Block_0_B_CERR,
        CODE_ERR_N             => XCVR_Block_0_CODE_ERR_N,
        DTCDATA_OUT            => DTCDATA_OUT_net_0,
        INVALID_K              => XCVR_Block_0_INVALID_K,
        RD_ERR                 => XCVR_Block_0_RD_ERR,
        RX_DATA                => XCVR_Block_0_RX_DATA,
        RX_K_CHAR              => XCVR_Block_0_RX_K_CHAR 
        );

end RTL;
