----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:21:27 2023
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
-- NewDDRInterface entity declaration
----------------------------------------------------------------------
entity NewDDRInterface is
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
end NewDDRInterface;
----------------------------------------------------------------------
-- NewDDRInterface architecture body
----------------------------------------------------------------------
architecture RTL of NewDDRInterface is
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
-- AXI4_Interconnect
component AXI4_Interconnect
    -- Port list
    port(
        -- Inputs
        ACLK             : in  std_logic;
        ARESETN          : in  std_logic;
        MASTER0_ARADDR   : in  std_logic_vector(31 downto 0);
        MASTER0_ARBURST  : in  std_logic_vector(1 downto 0);
        MASTER0_ARCACHE  : in  std_logic_vector(3 downto 0);
        MASTER0_ARID     : in  std_logic_vector(3 downto 0);
        MASTER0_ARLEN    : in  std_logic_vector(7 downto 0);
        MASTER0_ARLOCK   : in  std_logic_vector(1 downto 0);
        MASTER0_ARPROT   : in  std_logic_vector(2 downto 0);
        MASTER0_ARQOS    : in  std_logic_vector(3 downto 0);
        MASTER0_ARREGION : in  std_logic_vector(3 downto 0);
        MASTER0_ARSIZE   : in  std_logic_vector(2 downto 0);
        MASTER0_ARUSER   : in  std_logic_vector(0 to 0);
        MASTER0_ARVALID  : in  std_logic;
        MASTER0_AWADDR   : in  std_logic_vector(31 downto 0);
        MASTER0_AWBURST  : in  std_logic_vector(1 downto 0);
        MASTER0_AWCACHE  : in  std_logic_vector(3 downto 0);
        MASTER0_AWID     : in  std_logic_vector(3 downto 0);
        MASTER0_AWLEN    : in  std_logic_vector(7 downto 0);
        MASTER0_AWLOCK   : in  std_logic_vector(1 downto 0);
        MASTER0_AWPROT   : in  std_logic_vector(2 downto 0);
        MASTER0_AWQOS    : in  std_logic_vector(3 downto 0);
        MASTER0_AWREGION : in  std_logic_vector(3 downto 0);
        MASTER0_AWSIZE   : in  std_logic_vector(2 downto 0);
        MASTER0_AWUSER   : in  std_logic_vector(0 to 0);
        MASTER0_AWVALID  : in  std_logic;
        MASTER0_BREADY   : in  std_logic;
        MASTER0_RREADY   : in  std_logic;
        MASTER0_WDATA    : in  std_logic_vector(63 downto 0);
        MASTER0_WLAST    : in  std_logic;
        MASTER0_WSTRB    : in  std_logic_vector(7 downto 0);
        MASTER0_WUSER    : in  std_logic_vector(0 to 0);
        MASTER0_WVALID   : in  std_logic;
        SLAVE0_ARREADY   : in  std_logic;
        SLAVE0_AWREADY   : in  std_logic;
        SLAVE0_BID       : in  std_logic_vector(4 downto 0);
        SLAVE0_BRESP     : in  std_logic_vector(1 downto 0);
        SLAVE0_BUSER     : in  std_logic_vector(0 to 0);
        SLAVE0_BVALID    : in  std_logic;
        SLAVE0_RDATA     : in  std_logic_vector(63 downto 0);
        SLAVE0_RID       : in  std_logic_vector(4 downto 0);
        SLAVE0_RLAST     : in  std_logic;
        SLAVE0_RRESP     : in  std_logic_vector(1 downto 0);
        SLAVE0_RUSER     : in  std_logic_vector(0 to 0);
        SLAVE0_RVALID    : in  std_logic;
        SLAVE0_WREADY    : in  std_logic;
        -- Outputs
        MASTER0_ARREADY  : out std_logic;
        MASTER0_AWREADY  : out std_logic;
        MASTER0_BID      : out std_logic_vector(3 downto 0);
        MASTER0_BRESP    : out std_logic_vector(1 downto 0);
        MASTER0_BUSER    : out std_logic_vector(0 to 0);
        MASTER0_BVALID   : out std_logic;
        MASTER0_RDATA    : out std_logic_vector(63 downto 0);
        MASTER0_RID      : out std_logic_vector(3 downto 0);
        MASTER0_RLAST    : out std_logic;
        MASTER0_RRESP    : out std_logic_vector(1 downto 0);
        MASTER0_RUSER    : out std_logic_vector(0 to 0);
        MASTER0_RVALID   : out std_logic;
        MASTER0_WREADY   : out std_logic;
        SLAVE0_ARADDR    : out std_logic_vector(31 downto 0);
        SLAVE0_ARBURST   : out std_logic_vector(1 downto 0);
        SLAVE0_ARCACHE   : out std_logic_vector(3 downto 0);
        SLAVE0_ARID      : out std_logic_vector(4 downto 0);
        SLAVE0_ARLEN     : out std_logic_vector(7 downto 0);
        SLAVE0_ARLOCK    : out std_logic_vector(1 downto 0);
        SLAVE0_ARPROT    : out std_logic_vector(2 downto 0);
        SLAVE0_ARQOS     : out std_logic_vector(3 downto 0);
        SLAVE0_ARREGION  : out std_logic_vector(3 downto 0);
        SLAVE0_ARSIZE    : out std_logic_vector(2 downto 0);
        SLAVE0_ARUSER    : out std_logic_vector(0 to 0);
        SLAVE0_ARVALID   : out std_logic;
        SLAVE0_AWADDR    : out std_logic_vector(31 downto 0);
        SLAVE0_AWBURST   : out std_logic_vector(1 downto 0);
        SLAVE0_AWCACHE   : out std_logic_vector(3 downto 0);
        SLAVE0_AWID      : out std_logic_vector(4 downto 0);
        SLAVE0_AWLEN     : out std_logic_vector(7 downto 0);
        SLAVE0_AWLOCK    : out std_logic_vector(1 downto 0);
        SLAVE0_AWPROT    : out std_logic_vector(2 downto 0);
        SLAVE0_AWQOS     : out std_logic_vector(3 downto 0);
        SLAVE0_AWREGION  : out std_logic_vector(3 downto 0);
        SLAVE0_AWSIZE    : out std_logic_vector(2 downto 0);
        SLAVE0_AWUSER    : out std_logic_vector(0 to 0);
        SLAVE0_AWVALID   : out std_logic;
        SLAVE0_BREADY    : out std_logic;
        SLAVE0_RREADY    : out std_logic;
        SLAVE0_WDATA     : out std_logic_vector(63 downto 0);
        SLAVE0_WLAST     : out std_logic;
        SLAVE0_WSTRB     : out std_logic_vector(7 downto 0);
        SLAVE0_WUSER     : out std_logic_vector(0 to 0);
        SLAVE0_WVALID    : out std_logic
        );
end component;
-- DDR4_Cntrl
component DDR4_Cntrl
    -- Port list
    port(
        -- Inputs
        PLL_REF_CLK  : in    std_logic;
        SYS_RESET_N  : in    std_logic;
        axi0_araddr  : in    std_logic_vector(31 downto 0);
        axi0_arburst : in    std_logic_vector(1 downto 0);
        axi0_arcache : in    std_logic_vector(3 downto 0);
        axi0_arid    : in    std_logic_vector(3 downto 0);
        axi0_arlen   : in    std_logic_vector(7 downto 0);
        axi0_arlock  : in    std_logic_vector(1 downto 0);
        axi0_arprot  : in    std_logic_vector(2 downto 0);
        axi0_arsize  : in    std_logic_vector(2 downto 0);
        axi0_arvalid : in    std_logic;
        axi0_awaddr  : in    std_logic_vector(31 downto 0);
        axi0_awburst : in    std_logic_vector(1 downto 0);
        axi0_awcache : in    std_logic_vector(3 downto 0);
        axi0_awid    : in    std_logic_vector(3 downto 0);
        axi0_awlen   : in    std_logic_vector(7 downto 0);
        axi0_awlock  : in    std_logic_vector(1 downto 0);
        axi0_awprot  : in    std_logic_vector(2 downto 0);
        axi0_awsize  : in    std_logic_vector(2 downto 0);
        axi0_awvalid : in    std_logic;
        axi0_bready  : in    std_logic;
        axi0_rready  : in    std_logic;
        axi0_wdata   : in    std_logic_vector(63 downto 0);
        axi0_wlast   : in    std_logic;
        axi0_wstrb   : in    std_logic_vector(7 downto 0);
        axi0_wvalid  : in    std_logic;
        -- Outputs
        A            : out   std_logic_vector(13 downto 0);
        ACT_N        : out   std_logic;
        BA           : out   std_logic_vector(1 downto 0);
        BG           : out   std_logic;
        CAS_N        : out   std_logic;
        CK0          : out   std_logic;
        CK0_N        : out   std_logic;
        CKE          : out   std_logic;
        CS_N         : out   std_logic;
        CTRLR_READY  : out   std_logic;
        DM_N         : out   std_logic_vector(3 downto 0);
        ODT          : out   std_logic;
        PLL_LOCK     : out   std_logic;
        RAS_N        : out   std_logic;
        RESET_N      : out   std_logic;
        SHIELD0      : out   std_logic;
        SHIELD1      : out   std_logic;
        SHIELD2      : out   std_logic;
        SHIELD3      : out   std_logic;
        SYS_CLK      : out   std_logic;
        WE_N         : out   std_logic;
        axi0_arready : out   std_logic;
        axi0_awready : out   std_logic;
        axi0_bid     : out   std_logic_vector(3 downto 0);
        axi0_bresp   : out   std_logic_vector(1 downto 0);
        axi0_bvalid  : out   std_logic;
        axi0_rdata   : out   std_logic_vector(63 downto 0);
        axi0_rid     : out   std_logic_vector(3 downto 0);
        axi0_rlast   : out   std_logic;
        axi0_rresp   : out   std_logic_vector(1 downto 0);
        axi0_rvalid  : out   std_logic;
        axi0_wready  : out   std_logic;
        -- Inouts
        DQ           : inout std_logic_vector(31 downto 0);
        DQS          : inout std_logic_vector(3 downto 0);
        DQS_N        : inout std_logic_vector(3 downto 0)
        );
end component;
-- DREQ_FIFO
component DREQ_FIFO
    -- Port list
    port(
        -- Inputs
        DATA     : in  std_logic_vector(39 downto 0);
        RCLOCK   : in  std_logic;
        RE       : in  std_logic;
        RRESET_N : in  std_logic;
        WCLOCK   : in  std_logic;
        WE       : in  std_logic;
        WRESET_N : in  std_logic;
        -- Outputs
        EMPTY    : out std_logic;
        FULL     : out std_logic;
        Q        : out std_logic_vector(39 downto 0)
        );
end component;
-- edge_generator
component edge_generator
    -- Port list
    port(
        -- Inputs
        clk         : in  std_logic;
        gate        : in  std_logic;
        resetn      : in  std_logic;
        -- Outputs
        fallingEdge : out std_logic;
        risingEdge  : out std_logic
        );
end component;
-- EW_FIFO_controller
component EW_FIFO_controller
    generic( 
        BURST_LENGTH : integer := 127 ;
        BURST_SIZE   : integer := 3 
        );
    -- Port list
    port(
        -- Inputs
        arready_i              : in  std_logic;
        awready_i              : in  std_logic;
        bid_i                  : in  std_logic_vector(3 downto 0);
        bresp_i                : in  std_logic_vector(1 downto 0);
        bvalid_i               : in  std_logic;
        curr_ewfifo_wr         : in  std_logic;
        dreqclk                : in  std_logic;
        et_fifo_re             : in  std_logic;
        ew_data                : in  std_logic_vector(31 downto 0);
        ew_done                : in  std_logic;
        ew_fifo_we             : in  std_logic;
        ew_ovfl                : in  std_logic;
        ew_size                : in  std_logic_vector(9 downto 0);
        ew_tag                 : in  std_logic_vector(19 downto 0);
        ewtag_offset_in        : in  std_logic_vector(47 downto 0);
        ewtag_offset_seen      : in  std_logic;
        last_word              : in  std_logic;
        rdata_i                : in  std_logic_vector(63 downto 0);
        resetn_dreqclk         : in  std_logic;
        resetn_fifo            : in  std_logic;
        resetn_serdesclk       : in  std_logic;
        resetn_sysclk          : in  std_logic;
        rid_i                  : in  std_logic_vector(3 downto 0);
        rlast_i                : in  std_logic;
        rresp_i                : in  std_logic_vector(1 downto 0);
        rvalid_i               : in  std_logic;
        serdesclk              : in  std_logic;
        sysclk                 : in  std_logic;
        tag_cnt                : in  std_logic_vector(19 downto 0);
        tag_evt                : in  std_logic_vector(47 downto 0);
        tag_ovfl               : in  std_logic;
        tag_size               : in  std_logic_vector(9 downto 0);
        tag_valid              : in  std_logic;
        wready_i               : in  std_logic;
        -- Outputs
        araddr_o               : out std_logic_vector(31 downto 0);
        arburst_o              : out std_logic_vector(1 downto 0);
        arid_o                 : out std_logic_vector(3 downto 0);
        arlen_o                : out std_logic_vector(7 downto 0);
        arsize_o               : out std_logic_vector(1 downto 0);
        arvalid_o              : out std_logic;
        awaddr_o               : out std_logic_vector(31 downto 0);
        awburst_o              : out std_logic_vector(1 downto 0);
        awid_o                 : out std_logic_vector(3 downto 0);
        awlen_o                : out std_logic_vector(7 downto 0);
        awsize_o               : out std_logic_vector(1 downto 0);
        awvalid_o              : out std_logic;
        axi_start_on_serdesclk : out std_logic;
        bready_o               : out std_logic;
        data_error             : out std_logic;
        data_expc              : out std_logic_vector(63 downto 0);
        data_seen              : out std_logic_vector(63 downto 0);
        ddr_done_on_serdesclk  : out std_logic;
        et_fifo_emptied        : out std_logic;
        et_fifo_rdata          : out std_logic_vector(63 downto 0);
        et_pckts               : out std_logic_vector(9 downto 0);
        event_error            : out std_logic;
        evt_expc               : out std_logic_vector(63 downto 0);
        evt_seen               : out std_logic_vector(63 downto 0);
        ew_DDRwrap_to_store    : out std_logic;
        ew_fifo_emptied        : out std_logic;
        ew_fifo_full           : out std_logic;
        ew_ovfl_to_store       : out std_logic;
        ew_size_to_store       : out std_logic_vector(9 downto 0);
        ew_tag_to_store        : out std_logic_vector(47 downto 0);
        ew_we_store            : out std_logic;
        hdr1_expc              : out std_logic_vector(63 downto 0);
        hdr1_seen              : out std_logic_vector(63 downto 0);
        hdr2_expc              : out std_logic_vector(63 downto 0);
        hdr2_seen              : out std_logic_vector(63 downto 0);
        header1_error          : out std_logic;
        header2_error          : out std_logic;
        rready_o               : out std_logic;
        tag_null               : out std_logic;
        tag_sent               : out std_logic;
        wdata_o                : out std_logic_vector(63 downto 0);
        wlast_o                : out std_logic;
        wstrb_o                : out std_logic_vector(7 downto 0);
        wvalid_o               : out std_logic
        );
end component;
-- ew_size_store_and_fetch_controller
component ew_size_store_and_fetch_controller
    -- Port list
    port(
        -- Inputs
        fetch                  : in  std_logic;
        fetch_event_tag        : in  std_logic_vector(47 downto 0);
        fetch_newspill         : in  std_logic;
        rclk                   : in  std_logic;
        rreset_n               : in  std_logic;
        size_fifo_empty        : in  std_logic;
        size_fifo_rdata        : in  std_logic_vector(39 downto 0);
        store_event_size       : in  std_logic_vector(9 downto 0);
        store_event_tag        : in  std_logic_vector(47 downto 0);
        store_event_we         : in  std_logic;
        store_event_wraparound : in  std_logic;
        store_newspill         : in  std_logic;
        store_overflow         : in  std_logic;
        wclk                   : in  std_logic;
        wreset_n               : in  std_logic;
        -- Outputs
        fetch_address_valid    : out std_logic;
        fetch_cnt              : out std_logic_vector(19 downto 0);
        fetch_ddr_address      : out std_logic_vector(19 downto 0);
        fetch_missing_error    : out std_logic;
        fetch_overflow         : out std_logic;
        fetch_pos_cnt          : out std_logic_vector(1 downto 0);
        fetch_re               : out std_logic;
        fetch_size             : out std_logic_vector(9 downto 0);
        fetch_tag              : out std_logic_vector(47 downto 0);
        fetch_timeout_error    : out std_logic;
        store_cnt              : out std_logic_vector(19 downto 0);
        store_pos_cnt          : out std_logic_vector(1 downto 0);
        store_we               : out std_logic;
        store_word             : out std_logic_vector(39 downto 0)
        );
end component;
-- ewtag_cntrl
component ewtag_cntrl
    -- Port list
    port(
        -- Inputs
        dreqclk            : in  std_logic;
        event_start        : in  std_logic;
        event_window_fetch : in  std_logic_vector(47 downto 0);
        ew_fifo_emptied    : in  std_logic;
        hb_null_valid      : in  std_logic;
        hb_valid           : in  std_logic;
        pref_valid         : in  std_logic;
        reg_ewtag_offset   : in  std_logic_vector(47 downto 0);
        resetn_dreqclk     : in  std_logic;
        resetn_fifo        : in  std_logic;
        resetn_serdesclk   : in  std_logic;
        resetn_xcvrclk     : in  std_logic;
        serdesclk          : in  std_logic;
        spill_hbtag_in     : in  std_logic_vector(19 downto 0);
        start_fetch        : in  std_logic;
        start_spill        : in  std_logic;
        tag_done           : in  std_logic;
        tag_null           : in  std_logic;
        tag_sent           : in  std_logic;
        tag_valid          : in  std_logic;
        xcvrclk            : in  std_logic;
        -- Outputs
        data_ready         : out std_logic;
        evt_tag_fetch      : out std_logic_vector(47 downto 0);
        ewtag_offset_latch : out std_logic;
        ewtag_offset_out   : out std_logic_vector(47 downto 0);
        hb_cnt             : out std_logic_vector(31 downto 0);
        hb_null_cnt        : out std_logic_vector(31 downto 0);
        hb_seen_cnt        : out std_logic_vector(31 downto 0);
        last_word          : out std_logic;
        pattern_init       : out std_logic;
        pref_seen_cnt      : out std_logic_vector(31 downto 0);
        spill_ewtag_out    : out std_logic_vector(19 downto 0);
        start_tag_cnt      : out std_logic_vector(31 downto 0);
        tag_done_cnt       : out std_logic_vector(31 downto 0);
        tag_fetch          : out std_logic;
        tag_null_cnt       : out std_logic_vector(31 downto 0);
        tag_sent_cnt       : out std_logic_vector(31 downto 0)
        );
end component;
-- offset_switch
component offset_switch
    -- Port list
    port(
        -- Inputs
        run_offset    : in  std_logic_vector(47 downto 0);
        serial_en     : in  std_logic;
        serial_offset : in  std_logic_vector(47 downto 0);
        -- Outputs
        ewtag_offset  : out std_logic_vector(47 downto 0)
        );
end component;
-- OR2
component OR2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- pattern_FIFO_filler
component pattern_FIFO_filler
    -- Port list
    port(
        -- Inputs
        axi_start_on_serdesclk : in  std_logic;
        ddr_done               : in  std_logic;
        ewtag_in               : in  std_logic_vector(19 downto 0);
        pattern_init           : in  std_logic;
        resetn_serdesclk       : in  std_logic;
        serdesclk              : in  std_logic;
        -- Outputs
        curr_ewfifo_wr         : out std_logic;
        ew_data                : out std_logic_vector(31 downto 0);
        ew_done                : out std_logic;
        ew_fifo_we             : out std_logic;
        ew_ovfl                : out std_logic;
        ew_size                : out std_logic_vector(9 downto 0);
        ew_tag                 : out std_logic_vector(19 downto 0)
        );
end component;
-- pattern_switch
component pattern_switch
    -- Port list
    port(
        -- Inputs
        DIGI_curr_ewfifo_wr           : in  std_logic;
        DIGI_ew_done                  : in  std_logic;
        DIGI_ew_fifo_data             : in  std_logic_vector(31 downto 0);
        DIGI_ew_fifo_we               : in  std_logic;
        DIGI_ew_ovfl                  : in  std_logic;
        DIGI_ew_size                  : in  std_logic_vector(9 downto 0);
        DIGI_ew_tag                   : in  std_logic_vector(19 downto 0);
        PATTRN_curr_ewfifo_wr         : in  std_logic;
        PATTRN_ew_done                : in  std_logic;
        PATTRN_ew_fifo_data           : in  std_logic_vector(31 downto 0);
        PATTRN_ew_fifo_we             : in  std_logic;
        PATTRN_ew_ovfl                : in  std_logic;
        PATTRN_ew_size                : in  std_logic_vector(9 downto 0);
        PATTRN_ew_tag                 : in  std_logic_vector(19 downto 0);
        axi_start_on_serdesclk        : in  std_logic;
        pattern_en                    : in  std_logic;
        -- Outputs
        DIGI_axi_start_on_serdesclk   : out std_logic;
        PATTRN_axi_start_on_serdesclk : out std_logic;
        curr_ewfifo_wr                : out std_logic;
        ew_done                       : out std_logic;
        ew_fifo_data                  : out std_logic_vector(31 downto 0);
        ew_fifo_we                    : out std_logic;
        ew_ovfl                       : out std_logic;
        ew_size                       : out std_logic_vector(9 downto 0);
        ew_tag                        : out std_logic_vector(19 downto 0)
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
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal A_net_0                                                  : std_logic_vector(13 downto 0);
signal ACT_N_net_0                                              : std_logic;
signal AND2_0_Y                                                 : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_ARADDR                   : std_logic_vector(31 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARBURST                  : std_logic_vector(1 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARCACHE                  : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARLEN                    : std_logic_vector(7 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARLOCK                   : std_logic_vector(1 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARPROT                   : std_logic_vector(2 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARQOS                    : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARREADY                  : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_ARREGION                 : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARSIZE                   : std_logic_vector(2 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARUSER                   : std_logic_vector(0 to 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARVALID                  : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_AWADDR                   : std_logic_vector(31 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWBURST                  : std_logic_vector(1 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWCACHE                  : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWLEN                    : std_logic_vector(7 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWLOCK                   : std_logic_vector(1 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWPROT                   : std_logic_vector(2 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWQOS                    : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWREADY                  : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_AWREGION                 : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWSIZE                   : std_logic_vector(2 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWUSER                   : std_logic_vector(0 to 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWVALID                  : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_BREADY                   : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_BRESP                    : std_logic_vector(1 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_BVALID                   : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_RDATA                    : std_logic_vector(63 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_RLAST                    : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_RREADY                   : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_RRESP                    : std_logic_vector(1 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_RVALID                   : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_WDATA                    : std_logic_vector(63 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_WLAST                    : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_WREADY                   : std_logic;
signal AXI4_Interconnect_0_AXI4mslave0_WSTRB                    : std_logic_vector(7 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_WUSER                    : std_logic_vector(0 to 0);
signal AXI4_Interconnect_0_AXI4mslave0_WVALID                   : std_logic;
signal axi_start_on_serdesclk_net_0                             : std_logic;
signal BA_net_0                                                 : std_logic_vector(1 downto 0);
signal BG_net_0                                                 : std_logic;
signal CAS_N_net_0                                              : std_logic;
signal CK0_net_0                                                : std_logic;
signal CK0_N_net_0                                              : std_logic;
signal CKE_net_0                                                : std_logic;
signal CS_N_net_0                                               : std_logic;
signal CTRLR_READY_net_0                                        : std_logic;
signal data_error_net_0                                         : std_logic;
signal data_expc_net_0                                          : std_logic_vector(63 downto 0);
signal data_ready_net_0                                         : std_logic;
signal data_seen_net_0                                          : std_logic_vector(63 downto 0);
signal DDR4_Cntrl_0_PLL_LOCK                                    : std_logic;
signal DDR4_Cntrl_0_SYS_CLK                                     : std_logic;
signal DM_N_net_0                                               : std_logic_vector(3 downto 0);
signal DREQ_FIFO_1_Q                                            : std_logic_vector(39 downto 0);
signal DREQ_FIFO_EMPTY_net_0                                    : std_logic;
signal DREQ_FIFO_FULL_net_0                                     : std_logic;
signal edge_generator_0_risingEdge                              : std_logic;
signal edge_generator_2_risingEdge                              : std_logic;
signal et_fifo_rdata_net_0                                      : std_logic_vector(63 downto 0);
signal et_pckts_net_0                                           : std_logic_vector(9 downto 0);
signal event_error_net_0                                        : std_logic;
signal evt_expc_net_0                                           : std_logic_vector(63 downto 0);
signal evt_seen_net_0                                           : std_logic_vector(63 downto 0);
signal ew_DDR_wrap_net_0                                        : std_logic;
signal EW_FIFO_controller_0_AXI4_M_ARADDR                       : std_logic_vector(31 downto 0);
signal EW_FIFO_controller_0_AXI4_M_ARBURST                      : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_ARID                         : std_logic_vector(3 downto 0);
signal EW_FIFO_controller_0_AXI4_M_ARLEN                        : std_logic_vector(7 downto 0);
signal EW_FIFO_controller_0_AXI4_M_ARREADY                      : std_logic;
signal EW_FIFO_controller_0_AXI4_M_ARVALID                      : std_logic;
signal EW_FIFO_controller_0_AXI4_M_AWADDR                       : std_logic_vector(31 downto 0);
signal EW_FIFO_controller_0_AXI4_M_AWBURST                      : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_AWID                         : std_logic_vector(3 downto 0);
signal EW_FIFO_controller_0_AXI4_M_AWLEN                        : std_logic_vector(7 downto 0);
signal EW_FIFO_controller_0_AXI4_M_AWREADY                      : std_logic;
signal EW_FIFO_controller_0_AXI4_M_AWVALID                      : std_logic;
signal EW_FIFO_controller_0_AXI4_M_BID                          : std_logic_vector(3 downto 0);
signal EW_FIFO_controller_0_AXI4_M_BREADY                       : std_logic;
signal EW_FIFO_controller_0_AXI4_M_BRESP                        : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_BUSER                        : std_logic_vector(0 to 0);
signal EW_FIFO_controller_0_AXI4_M_BVALID                       : std_logic;
signal EW_FIFO_controller_0_AXI4_M_RDATA                        : std_logic_vector(63 downto 0);
signal EW_FIFO_controller_0_AXI4_M_RID                          : std_logic_vector(3 downto 0);
signal EW_FIFO_controller_0_AXI4_M_RLAST                        : std_logic;
signal EW_FIFO_controller_0_AXI4_M_RREADY                       : std_logic;
signal EW_FIFO_controller_0_AXI4_M_RRESP                        : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_RUSER                        : std_logic_vector(0 to 0);
signal EW_FIFO_controller_0_AXI4_M_RVALID                       : std_logic;
signal EW_FIFO_controller_0_AXI4_M_WDATA                        : std_logic_vector(63 downto 0);
signal EW_FIFO_controller_0_AXI4_M_WLAST                        : std_logic;
signal EW_FIFO_controller_0_AXI4_M_WREADY                       : std_logic;
signal EW_FIFO_controller_0_AXI4_M_WSTRB                        : std_logic_vector(7 downto 0);
signal EW_FIFO_controller_0_AXI4_M_WVALID                       : std_logic;
signal EW_FIFO_controller_0_axi_start_on_serdesclk              : std_logic;
signal EW_FIFO_controller_0_ddr_done_on_serdesclk               : std_logic;
signal EW_FIFO_controller_0_et_fifo_emptied                     : std_logic;
signal EW_FIFO_controller_0_ew_fifo_emptied                     : std_logic;
signal EW_FIFO_controller_0_ew_ovfl_to_store                    : std_logic;
signal EW_FIFO_controller_0_ew_size_to_store                    : std_logic_vector(9 downto 0);
signal EW_FIFO_controller_0_ew_tag_to_store                     : std_logic_vector(47 downto 0);
signal EW_FIFO_controller_0_ew_we_store                         : std_logic;
signal EW_FIFO_controller_0_tag_null                            : std_logic;
signal EW_FIFO_controller_0_tag_sent                            : std_logic;
signal ew_fifo_full_net_0                                       : std_logic;
signal ew_size_store_and_fetch_controller_0_fetch_address_valid : std_logic;
signal ew_size_store_and_fetch_controller_0_fetch_ddr_address   : std_logic_vector(19 downto 0);
signal ew_size_store_and_fetch_controller_0_fetch_overflow      : std_logic;
signal ew_size_store_and_fetch_controller_0_fetch_re            : std_logic;
signal ew_size_store_and_fetch_controller_0_fetch_size          : std_logic_vector(9 downto 0);
signal ew_size_store_and_fetch_controller_0_fetch_tag           : std_logic_vector(47 downto 0);
signal ew_size_store_and_fetch_controller_0_store_we            : std_logic;
signal ew_size_store_and_fetch_controller_0_store_word          : std_logic_vector(39 downto 0);
signal ewtag_cntrl_0_evt_tag_fetch                              : std_logic_vector(47 downto 0);
signal ewtag_cntrl_0_ewtag_offset_latch                         : std_logic;
signal ewtag_cntrl_0_pattern_init                               : std_logic;
signal ewtag_cntrl_0_spill_ewtag_out                            : std_logic_vector(19 downto 0);
signal ewtag_cntrl_0_tag_fetch                                  : std_logic;
signal ewtag_offset_out_net_0                                   : std_logic_vector(47 downto 0);
signal fetch_cnt_net_0                                          : std_logic_vector(19 downto 0);
signal fetch_pos_cnt_net_0                                      : std_logic_vector(1 downto 0);
signal hb_cnt_net_0                                             : std_logic_vector(31 downto 0);
signal hb_null_cnt_net_0                                        : std_logic_vector(31 downto 0);
signal hb_seen_cnt_net_0                                        : std_logic_vector(31 downto 0);
signal hdr1_expc_net_0                                          : std_logic_vector(63 downto 0);
signal hdr1_seen_net_0                                          : std_logic_vector(63 downto 0);
signal hdr2_expc_net_0                                          : std_logic_vector(63 downto 0);
signal hdr2_seen_net_0                                          : std_logic_vector(63 downto 0);
signal header1_error_net_0                                      : std_logic;
signal header2_error_net_0                                      : std_logic;
signal last_word_net_0                                          : std_logic;
signal ODT_net_0                                                : std_logic;
signal offset_switch_0_ewtag_offset                             : std_logic_vector(47 downto 0);
signal OR2_0_Y                                                  : std_logic;
signal OR2_1_Y                                                  : std_logic;
signal pattern_FIFO_filler_0_curr_ewfifo_wr                     : std_logic;
signal pattern_FIFO_filler_0_ew_data                            : std_logic_vector(31 downto 0);
signal pattern_FIFO_filler_0_ew_done                            : std_logic;
signal pattern_FIFO_filler_0_ew_fifo_we                         : std_logic;
signal pattern_FIFO_filler_0_ew_ovfl                            : std_logic;
signal pattern_FIFO_filler_0_ew_size                            : std_logic_vector(9 downto 0);
signal pattern_FIFO_filler_0_ew_tag                             : std_logic_vector(19 downto 0);
signal pattern_switch_0_curr_ewfifo_wr                          : std_logic;
signal pattern_switch_0_ew_done                                 : std_logic;
signal pattern_switch_0_ew_fifo_data                            : std_logic_vector(31 downto 0);
signal pattern_switch_0_ew_fifo_we                              : std_logic;
signal pattern_switch_0_ew_ovfl                                 : std_logic;
signal pattern_switch_0_ew_size                                 : std_logic_vector(9 downto 0);
signal pattern_switch_0_ew_tag                                  : std_logic_vector(19 downto 0);
signal pattern_switch_0_PATTRN_axi_start_on_serdesclk           : std_logic;
signal pref_seen_cnt_net_0                                      : std_logic_vector(31 downto 0);
signal RAS_N_net_0                                              : std_logic;
signal RESET_N_net_0                                            : std_logic;
signal SHIELD0_net_0                                            : std_logic;
signal SHIELD1_net_0                                            : std_logic;
signal SHIELD2_net_0                                            : std_logic;
signal SHIELD3_net_0                                            : std_logic;
signal start_tag_cnt_net_0                                      : std_logic_vector(31 downto 0);
signal store_cnt_net_0                                          : std_logic_vector(19 downto 0);
signal store_pos_cnt_net_0                                      : std_logic_vector(1 downto 0);
signal SYSCLKReset_FABRIC_RESET_N                               : std_logic;
signal tag_done_cnt_net_0                                       : std_logic_vector(31 downto 0);
signal tag_null_cnt_net_0                                       : std_logic_vector(31 downto 0);
signal tag_sent_cnt_net_0                                       : std_logic_vector(31 downto 0);
signal WE_N_net_0                                               : std_logic;
signal ACT_N_net_1                                              : std_logic;
signal BG_net_1                                                 : std_logic;
signal CAS_N_net_1                                              : std_logic;
signal CK0_N_net_1                                              : std_logic;
signal CK0_net_1                                                : std_logic;
signal CKE_net_1                                                : std_logic;
signal CS_N_net_1                                               : std_logic;
signal CTRLR_READY_net_1                                        : std_logic;
signal DREQ_FIFO_EMPTY_net_1                                    : std_logic;
signal DREQ_FIFO_FULL_net_1                                     : std_logic;
signal ODT_net_1                                                : std_logic;
signal RAS_N_net_1                                              : std_logic;
signal RESET_N_net_1                                            : std_logic;
signal SHIELD0_net_1                                            : std_logic;
signal SHIELD1_net_1                                            : std_logic;
signal SHIELD2_net_1                                            : std_logic;
signal SHIELD3_net_1                                            : std_logic;
signal WE_N_net_1                                               : std_logic;
signal axi_start_on_serdesclk_net_1                             : std_logic;
signal data_error_net_1                                         : std_logic;
signal data_ready_net_1                                         : std_logic;
signal event_error_net_1                                        : std_logic;
signal ew_DDR_wrap_net_1                                        : std_logic;
signal ew_fifo_full_net_1                                       : std_logic;
signal header1_error_net_1                                      : std_logic;
signal header2_error_net_1                                      : std_logic;
signal last_word_net_1                                          : std_logic;
signal A_net_1                                                  : std_logic_vector(13 downto 0);
signal BA_net_1                                                 : std_logic_vector(1 downto 0);
signal DM_N_net_1                                               : std_logic_vector(3 downto 0);
signal data_expc_net_1                                          : std_logic_vector(63 downto 0);
signal data_seen_net_1                                          : std_logic_vector(63 downto 0);
signal et_fifo_rdata_net_1                                      : std_logic_vector(63 downto 0);
signal et_pckts_net_1                                           : std_logic_vector(9 downto 0);
signal evt_expc_net_1                                           : std_logic_vector(63 downto 0);
signal evt_seen_net_1                                           : std_logic_vector(63 downto 0);
signal ewtag_offset_out_net_1                                   : std_logic_vector(47 downto 0);
signal fetch_cnt_net_1                                          : std_logic_vector(19 downto 0);
signal fetch_pos_cnt_net_1                                      : std_logic_vector(1 downto 0);
signal hb_cnt_net_1                                             : std_logic_vector(31 downto 0);
signal hb_null_cnt_net_1                                        : std_logic_vector(31 downto 0);
signal hb_seen_cnt_net_1                                        : std_logic_vector(31 downto 0);
signal hdr1_expc_net_1                                          : std_logic_vector(63 downto 0);
signal hdr1_seen_net_1                                          : std_logic_vector(63 downto 0);
signal hdr2_expc_net_1                                          : std_logic_vector(63 downto 0);
signal hdr2_seen_net_1                                          : std_logic_vector(63 downto 0);
signal pref_seen_cnt_net_1                                      : std_logic_vector(31 downto 0);
signal start_tag_cnt_net_1                                      : std_logic_vector(31 downto 0);
signal store_cnt_net_1                                          : std_logic_vector(19 downto 0);
signal store_pos_cnt_net_1                                      : std_logic_vector(1 downto 0);
signal tag_done_cnt_net_1                                       : std_logic_vector(31 downto 0);
signal tag_null_cnt_net_1                                       : std_logic_vector(31 downto 0);
signal tag_sent_cnt_net_1                                       : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                                  : std_logic;
signal GND_net                                                  : std_logic;
signal MASTER0_AWLOCK_const_net_0                               : std_logic_vector(1 downto 0);
signal MASTER0_AWCACHE_const_net_0                              : std_logic_vector(3 downto 0);
signal MASTER0_AWPROT_const_net_0                               : std_logic_vector(2 downto 0);
signal MASTER0_AWQOS_const_net_0                                : std_logic_vector(3 downto 0);
signal MASTER0_AWREGION_const_net_0                             : std_logic_vector(3 downto 0);
signal MASTER0_ARLOCK_const_net_0                               : std_logic_vector(1 downto 0);
signal MASTER0_ARCACHE_const_net_0                              : std_logic_vector(3 downto 0);
signal MASTER0_ARPROT_const_net_0                               : std_logic_vector(2 downto 0);
signal MASTER0_ARQOS_const_net_0                                : std_logic_vector(3 downto 0);
signal MASTER0_ARREGION_const_net_0                             : std_logic_vector(3 downto 0);
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal AXI4_Interconnect_0_AXI4mslave0_ARID                     : std_logic_vector(4 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARID_0                   : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_ARID_0_3to0              : std_logic_vector(3 downto 0);

signal AXI4_Interconnect_0_AXI4mslave0_AWID                     : std_logic_vector(4 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWID_0                   : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_AWID_0_3to0              : std_logic_vector(3 downto 0);

signal AXI4_Interconnect_0_AXI4mslave0_BID                      : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_BID_0                    : std_logic_vector(4 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_BID_0_3to0               : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_BID_0_4to4               : std_logic_vector(4 to 4);

signal AXI4_Interconnect_0_AXI4mslave0_RID                      : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_RID_0                    : std_logic_vector(4 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_RID_0_3to0               : std_logic_vector(3 downto 0);
signal AXI4_Interconnect_0_AXI4mslave0_RID_0_4to4               : std_logic_vector(4 to 4);

signal EW_FIFO_controller_0_AXI4_M_ARSIZE                       : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_ARSIZE_0                     : std_logic_vector(2 downto 0);
signal EW_FIFO_controller_0_AXI4_M_ARSIZE_0_1to0                : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_ARSIZE_0_2to2                : std_logic_vector(2 to 2);

signal EW_FIFO_controller_0_AXI4_M_AWSIZE                       : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_AWSIZE_0                     : std_logic_vector(2 downto 0);
signal EW_FIFO_controller_0_AXI4_M_AWSIZE_0_1to0                : std_logic_vector(1 downto 0);
signal EW_FIFO_controller_0_AXI4_M_AWSIZE_0_2to2                : std_logic_vector(2 to 2);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net                      <= '1';
 GND_net                      <= '0';
 MASTER0_AWLOCK_const_net_0   <= B"00";
 MASTER0_AWCACHE_const_net_0  <= B"0000";
 MASTER0_AWPROT_const_net_0   <= B"000";
 MASTER0_AWQOS_const_net_0    <= B"0000";
 MASTER0_AWREGION_const_net_0 <= B"0000";
 MASTER0_ARLOCK_const_net_0   <= B"00";
 MASTER0_ARCACHE_const_net_0  <= B"0000";
 MASTER0_ARPROT_const_net_0   <= B"000";
 MASTER0_ARQOS_const_net_0    <= B"0000";
 MASTER0_ARREGION_const_net_0 <= B"0000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 ACT_N_net_1                   <= ACT_N_net_0;
 ACT_N                         <= ACT_N_net_1;
 BG_net_1                      <= BG_net_0;
 BG                            <= BG_net_1;
 CAS_N_net_1                   <= CAS_N_net_0;
 CAS_N                         <= CAS_N_net_1;
 CK0_N_net_1                   <= CK0_N_net_0;
 CK0_N                         <= CK0_N_net_1;
 CK0_net_1                     <= CK0_net_0;
 CK0                           <= CK0_net_1;
 CKE_net_1                     <= CKE_net_0;
 CKE                           <= CKE_net_1;
 CS_N_net_1                    <= CS_N_net_0;
 CS_N                          <= CS_N_net_1;
 CTRLR_READY_net_1             <= CTRLR_READY_net_0;
 CTRLR_READY                   <= CTRLR_READY_net_1;
 DREQ_FIFO_EMPTY_net_1         <= DREQ_FIFO_EMPTY_net_0;
 DREQ_FIFO_EMPTY               <= DREQ_FIFO_EMPTY_net_1;
 DREQ_FIFO_FULL_net_1          <= DREQ_FIFO_FULL_net_0;
 DREQ_FIFO_FULL                <= DREQ_FIFO_FULL_net_1;
 ODT_net_1                     <= ODT_net_0;
 ODT                           <= ODT_net_1;
 RAS_N_net_1                   <= RAS_N_net_0;
 RAS_N                         <= RAS_N_net_1;
 RESET_N_net_1                 <= RESET_N_net_0;
 RESET_N                       <= RESET_N_net_1;
 SHIELD0_net_1                 <= SHIELD0_net_0;
 SHIELD0                       <= SHIELD0_net_1;
 SHIELD1_net_1                 <= SHIELD1_net_0;
 SHIELD1                       <= SHIELD1_net_1;
 SHIELD2_net_1                 <= SHIELD2_net_0;
 SHIELD2                       <= SHIELD2_net_1;
 SHIELD3_net_1                 <= SHIELD3_net_0;
 SHIELD3                       <= SHIELD3_net_1;
 WE_N_net_1                    <= WE_N_net_0;
 WE_N                          <= WE_N_net_1;
 axi_start_on_serdesclk_net_1  <= axi_start_on_serdesclk_net_0;
 axi_start_on_serdesclk        <= axi_start_on_serdesclk_net_1;
 data_error_net_1              <= data_error_net_0;
 data_error                    <= data_error_net_1;
 data_ready_net_1              <= data_ready_net_0;
 data_ready                    <= data_ready_net_1;
 event_error_net_1             <= event_error_net_0;
 event_error                   <= event_error_net_1;
 ew_DDR_wrap_net_1             <= ew_DDR_wrap_net_0;
 ew_DDR_wrap                   <= ew_DDR_wrap_net_1;
 ew_fifo_full_net_1            <= ew_fifo_full_net_0;
 ew_fifo_full                  <= ew_fifo_full_net_1;
 header1_error_net_1           <= header1_error_net_0;
 header1_error                 <= header1_error_net_1;
 header2_error_net_1           <= header2_error_net_0;
 header2_error                 <= header2_error_net_1;
 last_word_net_1               <= last_word_net_0;
 last_word                     <= last_word_net_1;
 A_net_1                       <= A_net_0;
 A(13 downto 0)                <= A_net_1;
 BA_net_1                      <= BA_net_0;
 BA(1 downto 0)                <= BA_net_1;
 DM_N_net_1                    <= DM_N_net_0;
 DM_N(3 downto 0)              <= DM_N_net_1;
 data_expc_net_1               <= data_expc_net_0;
 data_expc(63 downto 0)        <= data_expc_net_1;
 data_seen_net_1               <= data_seen_net_0;
 data_seen(63 downto 0)        <= data_seen_net_1;
 et_fifo_rdata_net_1           <= et_fifo_rdata_net_0;
 et_fifo_rdata(63 downto 0)    <= et_fifo_rdata_net_1;
 et_pckts_net_1                <= et_pckts_net_0;
 et_pckts(9 downto 0)          <= et_pckts_net_1;
 evt_expc_net_1                <= evt_expc_net_0;
 evt_expc(63 downto 0)         <= evt_expc_net_1;
 evt_seen_net_1                <= evt_seen_net_0;
 evt_seen(63 downto 0)         <= evt_seen_net_1;
 ewtag_offset_out_net_1        <= ewtag_offset_out_net_0;
 ewtag_offset_out(47 downto 0) <= ewtag_offset_out_net_1;
 fetch_cnt_net_1               <= fetch_cnt_net_0;
 fetch_cnt(19 downto 0)        <= fetch_cnt_net_1;
 fetch_pos_cnt_net_1           <= fetch_pos_cnt_net_0;
 fetch_pos_cnt(1 downto 0)     <= fetch_pos_cnt_net_1;
 hb_cnt_net_1                  <= hb_cnt_net_0;
 hb_cnt(31 downto 0)           <= hb_cnt_net_1;
 hb_null_cnt_net_1             <= hb_null_cnt_net_0;
 hb_null_cnt(31 downto 0)      <= hb_null_cnt_net_1;
 hb_seen_cnt_net_1             <= hb_seen_cnt_net_0;
 hb_seen_cnt(31 downto 0)      <= hb_seen_cnt_net_1;
 hdr1_expc_net_1               <= hdr1_expc_net_0;
 hdr1_expc(63 downto 0)        <= hdr1_expc_net_1;
 hdr1_seen_net_1               <= hdr1_seen_net_0;
 hdr1_seen(63 downto 0)        <= hdr1_seen_net_1;
 hdr2_expc_net_1               <= hdr2_expc_net_0;
 hdr2_expc(63 downto 0)        <= hdr2_expc_net_1;
 hdr2_seen_net_1               <= hdr2_seen_net_0;
 hdr2_seen(63 downto 0)        <= hdr2_seen_net_1;
 pref_seen_cnt_net_1           <= pref_seen_cnt_net_0;
 pref_seen_cnt(31 downto 0)    <= pref_seen_cnt_net_1;
 start_tag_cnt_net_1           <= start_tag_cnt_net_0;
 start_tag_cnt(31 downto 0)    <= start_tag_cnt_net_1;
 store_cnt_net_1               <= store_cnt_net_0;
 store_cnt(19 downto 0)        <= store_cnt_net_1;
 store_pos_cnt_net_1           <= store_pos_cnt_net_0;
 store_pos_cnt(1 downto 0)     <= store_pos_cnt_net_1;
 tag_done_cnt_net_1            <= tag_done_cnt_net_0;
 tag_done_cnt(31 downto 0)     <= tag_done_cnt_net_1;
 tag_null_cnt_net_1            <= tag_null_cnt_net_0;
 tag_null_cnt(31 downto 0)     <= tag_null_cnt_net_1;
 tag_sent_cnt_net_1            <= tag_sent_cnt_net_0;
 tag_sent_cnt(31 downto 0)     <= tag_sent_cnt_net_1;
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 AXI4_Interconnect_0_AXI4mslave0_ARID_0(3 downto 0) <= ( AXI4_Interconnect_0_AXI4mslave0_ARID_0_3to0(3 downto 0) );
 AXI4_Interconnect_0_AXI4mslave0_ARID_0_3to0(3 downto 0) <= AXI4_Interconnect_0_AXI4mslave0_ARID(3 downto 0);

 AXI4_Interconnect_0_AXI4mslave0_AWID_0(3 downto 0) <= ( AXI4_Interconnect_0_AXI4mslave0_AWID_0_3to0(3 downto 0) );
 AXI4_Interconnect_0_AXI4mslave0_AWID_0_3to0(3 downto 0) <= AXI4_Interconnect_0_AXI4mslave0_AWID(3 downto 0);

 AXI4_Interconnect_0_AXI4mslave0_BID_0(4 downto 0) <= ( AXI4_Interconnect_0_AXI4mslave0_BID_0_4to4(4) & AXI4_Interconnect_0_AXI4mslave0_BID_0_3to0(3 downto 0) );
 AXI4_Interconnect_0_AXI4mslave0_BID_0_3to0(3 downto 0) <= AXI4_Interconnect_0_AXI4mslave0_BID(3 downto 0);
 AXI4_Interconnect_0_AXI4mslave0_BID_0_4to4(4) <= '0';

 AXI4_Interconnect_0_AXI4mslave0_RID_0(4 downto 0) <= ( AXI4_Interconnect_0_AXI4mslave0_RID_0_4to4(4) & AXI4_Interconnect_0_AXI4mslave0_RID_0_3to0(3 downto 0) );
 AXI4_Interconnect_0_AXI4mslave0_RID_0_3to0(3 downto 0) <= AXI4_Interconnect_0_AXI4mslave0_RID(3 downto 0);
 AXI4_Interconnect_0_AXI4mslave0_RID_0_4to4(4) <= '0';

 EW_FIFO_controller_0_AXI4_M_ARSIZE_0(2 downto 0) <= ( EW_FIFO_controller_0_AXI4_M_ARSIZE_0_2to2(2) & EW_FIFO_controller_0_AXI4_M_ARSIZE_0_1to0(1 downto 0) );
 EW_FIFO_controller_0_AXI4_M_ARSIZE_0_1to0(1 downto 0) <= EW_FIFO_controller_0_AXI4_M_ARSIZE(1 downto 0);
 EW_FIFO_controller_0_AXI4_M_ARSIZE_0_2to2(2) <= '0';

 EW_FIFO_controller_0_AXI4_M_AWSIZE_0(2 downto 0) <= ( EW_FIFO_controller_0_AXI4_M_AWSIZE_0_2to2(2) & EW_FIFO_controller_0_AXI4_M_AWSIZE_0_1to0(1 downto 0) );
 EW_FIFO_controller_0_AXI4_M_AWSIZE_0_1to0(1 downto 0) <= EW_FIFO_controller_0_AXI4_M_AWSIZE(1 downto 0);
 EW_FIFO_controller_0_AXI4_M_AWSIZE_0_2to2(2) <= '0';

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_0
AND2_0 : AND2
    port map( 
        -- Inputs
        A => DDR_BANK_CALIB,
        B => EXT_RST_N,
        -- Outputs
        Y => AND2_0_Y 
        );
-- AXI4_Interconnect_0
AXI4_Interconnect_0 : AXI4_Interconnect
    port map( 
        -- Inputs
        ACLK              => DDR4_Cntrl_0_SYS_CLK,
        ARESETN           => SYSCLKReset_FABRIC_RESET_N,
        SLAVE0_AWREADY    => AXI4_Interconnect_0_AXI4mslave0_AWREADY,
        SLAVE0_WREADY     => AXI4_Interconnect_0_AXI4mslave0_WREADY,
        SLAVE0_BID        => AXI4_Interconnect_0_AXI4mslave0_BID_0,
        SLAVE0_BRESP      => AXI4_Interconnect_0_AXI4mslave0_BRESP,
        SLAVE0_BVALID     => AXI4_Interconnect_0_AXI4mslave0_BVALID,
        SLAVE0_ARREADY    => AXI4_Interconnect_0_AXI4mslave0_ARREADY,
        SLAVE0_RID        => AXI4_Interconnect_0_AXI4mslave0_RID_0,
        SLAVE0_RDATA      => AXI4_Interconnect_0_AXI4mslave0_RDATA,
        SLAVE0_RRESP      => AXI4_Interconnect_0_AXI4mslave0_RRESP,
        SLAVE0_RLAST      => AXI4_Interconnect_0_AXI4mslave0_RLAST,
        SLAVE0_RVALID     => AXI4_Interconnect_0_AXI4mslave0_RVALID,
        SLAVE0_BUSER(0)   => GND_net, -- tied to '0' from definition
        SLAVE0_RUSER(0)   => GND_net, -- tied to '0' from definition
        MASTER0_AWID      => EW_FIFO_controller_0_AXI4_M_AWID,
        MASTER0_AWADDR    => EW_FIFO_controller_0_AXI4_M_AWADDR,
        MASTER0_AWLEN     => EW_FIFO_controller_0_AXI4_M_AWLEN,
        MASTER0_AWSIZE    => EW_FIFO_controller_0_AXI4_M_AWSIZE_0,
        MASTER0_AWBURST   => EW_FIFO_controller_0_AXI4_M_AWBURST,
        MASTER0_AWLOCK    => MASTER0_AWLOCK_const_net_0, -- tied to X"0" from definition
        MASTER0_AWCACHE   => MASTER0_AWCACHE_const_net_0, -- tied to X"0" from definition
        MASTER0_AWPROT    => MASTER0_AWPROT_const_net_0, -- tied to X"0" from definition
        MASTER0_AWQOS     => MASTER0_AWQOS_const_net_0, -- tied to X"0" from definition
        MASTER0_AWREGION  => MASTER0_AWREGION_const_net_0, -- tied to X"0" from definition
        MASTER0_AWVALID   => EW_FIFO_controller_0_AXI4_M_AWVALID,
        MASTER0_WDATA     => EW_FIFO_controller_0_AXI4_M_WDATA,
        MASTER0_WSTRB     => EW_FIFO_controller_0_AXI4_M_WSTRB,
        MASTER0_WLAST     => EW_FIFO_controller_0_AXI4_M_WLAST,
        MASTER0_WVALID    => EW_FIFO_controller_0_AXI4_M_WVALID,
        MASTER0_BREADY    => EW_FIFO_controller_0_AXI4_M_BREADY,
        MASTER0_ARID      => EW_FIFO_controller_0_AXI4_M_ARID,
        MASTER0_ARADDR    => EW_FIFO_controller_0_AXI4_M_ARADDR,
        MASTER0_ARLEN     => EW_FIFO_controller_0_AXI4_M_ARLEN,
        MASTER0_ARSIZE    => EW_FIFO_controller_0_AXI4_M_ARSIZE_0,
        MASTER0_ARBURST   => EW_FIFO_controller_0_AXI4_M_ARBURST,
        MASTER0_ARLOCK    => MASTER0_ARLOCK_const_net_0, -- tied to X"0" from definition
        MASTER0_ARCACHE   => MASTER0_ARCACHE_const_net_0, -- tied to X"0" from definition
        MASTER0_ARPROT    => MASTER0_ARPROT_const_net_0, -- tied to X"0" from definition
        MASTER0_ARQOS     => MASTER0_ARQOS_const_net_0, -- tied to X"0" from definition
        MASTER0_ARREGION  => MASTER0_ARREGION_const_net_0, -- tied to X"0" from definition
        MASTER0_ARVALID   => EW_FIFO_controller_0_AXI4_M_ARVALID,
        MASTER0_RREADY    => EW_FIFO_controller_0_AXI4_M_RREADY,
        MASTER0_AWUSER(0) => GND_net, -- tied to '0' from definition
        MASTER0_WUSER(0)  => GND_net, -- tied to '0' from definition
        MASTER0_ARUSER(0) => GND_net, -- tied to '0' from definition
        -- Outputs
        SLAVE0_AWID       => AXI4_Interconnect_0_AXI4mslave0_AWID,
        SLAVE0_AWADDR     => AXI4_Interconnect_0_AXI4mslave0_AWADDR,
        SLAVE0_AWLEN      => AXI4_Interconnect_0_AXI4mslave0_AWLEN,
        SLAVE0_AWSIZE     => AXI4_Interconnect_0_AXI4mslave0_AWSIZE,
        SLAVE0_AWBURST    => AXI4_Interconnect_0_AXI4mslave0_AWBURST,
        SLAVE0_AWLOCK     => AXI4_Interconnect_0_AXI4mslave0_AWLOCK,
        SLAVE0_AWCACHE    => AXI4_Interconnect_0_AXI4mslave0_AWCACHE,
        SLAVE0_AWPROT     => AXI4_Interconnect_0_AXI4mslave0_AWPROT,
        SLAVE0_AWQOS      => AXI4_Interconnect_0_AXI4mslave0_AWQOS,
        SLAVE0_AWREGION   => AXI4_Interconnect_0_AXI4mslave0_AWREGION,
        SLAVE0_AWVALID    => AXI4_Interconnect_0_AXI4mslave0_AWVALID,
        SLAVE0_WDATA      => AXI4_Interconnect_0_AXI4mslave0_WDATA,
        SLAVE0_WSTRB      => AXI4_Interconnect_0_AXI4mslave0_WSTRB,
        SLAVE0_WLAST      => AXI4_Interconnect_0_AXI4mslave0_WLAST,
        SLAVE0_WVALID     => AXI4_Interconnect_0_AXI4mslave0_WVALID,
        SLAVE0_BREADY     => AXI4_Interconnect_0_AXI4mslave0_BREADY,
        SLAVE0_ARID       => AXI4_Interconnect_0_AXI4mslave0_ARID,
        SLAVE0_ARADDR     => AXI4_Interconnect_0_AXI4mslave0_ARADDR,
        SLAVE0_ARLEN      => AXI4_Interconnect_0_AXI4mslave0_ARLEN,
        SLAVE0_ARSIZE     => AXI4_Interconnect_0_AXI4mslave0_ARSIZE,
        SLAVE0_ARBURST    => AXI4_Interconnect_0_AXI4mslave0_ARBURST,
        SLAVE0_ARLOCK     => AXI4_Interconnect_0_AXI4mslave0_ARLOCK,
        SLAVE0_ARCACHE    => AXI4_Interconnect_0_AXI4mslave0_ARCACHE,
        SLAVE0_ARPROT     => AXI4_Interconnect_0_AXI4mslave0_ARPROT,
        SLAVE0_ARQOS      => AXI4_Interconnect_0_AXI4mslave0_ARQOS,
        SLAVE0_ARREGION   => AXI4_Interconnect_0_AXI4mslave0_ARREGION,
        SLAVE0_ARVALID    => AXI4_Interconnect_0_AXI4mslave0_ARVALID,
        SLAVE0_RREADY     => AXI4_Interconnect_0_AXI4mslave0_RREADY,
        SLAVE0_AWUSER     => AXI4_Interconnect_0_AXI4mslave0_AWUSER,
        SLAVE0_WUSER      => AXI4_Interconnect_0_AXI4mslave0_WUSER,
        SLAVE0_ARUSER     => AXI4_Interconnect_0_AXI4mslave0_ARUSER,
        MASTER0_AWREADY   => EW_FIFO_controller_0_AXI4_M_AWREADY,
        MASTER0_WREADY    => EW_FIFO_controller_0_AXI4_M_WREADY,
        MASTER0_BID       => EW_FIFO_controller_0_AXI4_M_BID,
        MASTER0_BRESP     => EW_FIFO_controller_0_AXI4_M_BRESP,
        MASTER0_BVALID    => EW_FIFO_controller_0_AXI4_M_BVALID,
        MASTER0_ARREADY   => EW_FIFO_controller_0_AXI4_M_ARREADY,
        MASTER0_RID       => EW_FIFO_controller_0_AXI4_M_RID,
        MASTER0_RDATA     => EW_FIFO_controller_0_AXI4_M_RDATA,
        MASTER0_RRESP     => EW_FIFO_controller_0_AXI4_M_RRESP,
        MASTER0_RLAST     => EW_FIFO_controller_0_AXI4_M_RLAST,
        MASTER0_RVALID    => EW_FIFO_controller_0_AXI4_M_RVALID,
        MASTER0_BUSER     => EW_FIFO_controller_0_AXI4_M_BUSER,
        MASTER0_RUSER     => EW_FIFO_controller_0_AXI4_M_RUSER 
        );
-- DDR4_Cntrl_0
DDR4_Cntrl_0 : DDR4_Cntrl
    port map( 
        -- Inputs
        PLL_REF_CLK  => MEM_CLK,
        SYS_RESET_N  => AND2_0_Y,
        axi0_awid    => AXI4_Interconnect_0_AXI4mslave0_AWID_0,
        axi0_awaddr  => AXI4_Interconnect_0_AXI4mslave0_AWADDR,
        axi0_awlen   => AXI4_Interconnect_0_AXI4mslave0_AWLEN,
        axi0_awsize  => AXI4_Interconnect_0_AXI4mslave0_AWSIZE,
        axi0_awburst => AXI4_Interconnect_0_AXI4mslave0_AWBURST,
        axi0_awlock  => AXI4_Interconnect_0_AXI4mslave0_AWLOCK,
        axi0_awcache => AXI4_Interconnect_0_AXI4mslave0_AWCACHE,
        axi0_awprot  => AXI4_Interconnect_0_AXI4mslave0_AWPROT,
        axi0_awvalid => AXI4_Interconnect_0_AXI4mslave0_AWVALID,
        axi0_wdata   => AXI4_Interconnect_0_AXI4mslave0_WDATA,
        axi0_wstrb   => AXI4_Interconnect_0_AXI4mslave0_WSTRB,
        axi0_wlast   => AXI4_Interconnect_0_AXI4mslave0_WLAST,
        axi0_wvalid  => AXI4_Interconnect_0_AXI4mslave0_WVALID,
        axi0_bready  => AXI4_Interconnect_0_AXI4mslave0_BREADY,
        axi0_arid    => AXI4_Interconnect_0_AXI4mslave0_ARID_0,
        axi0_araddr  => AXI4_Interconnect_0_AXI4mslave0_ARADDR,
        axi0_arlen   => AXI4_Interconnect_0_AXI4mslave0_ARLEN,
        axi0_arsize  => AXI4_Interconnect_0_AXI4mslave0_ARSIZE,
        axi0_arburst => AXI4_Interconnect_0_AXI4mslave0_ARBURST,
        axi0_arlock  => AXI4_Interconnect_0_AXI4mslave0_ARLOCK,
        axi0_arcache => AXI4_Interconnect_0_AXI4mslave0_ARCACHE,
        axi0_arprot  => AXI4_Interconnect_0_AXI4mslave0_ARPROT,
        axi0_arvalid => AXI4_Interconnect_0_AXI4mslave0_ARVALID,
        axi0_rready  => AXI4_Interconnect_0_AXI4mslave0_RREADY,
        -- Outputs
        DM_N         => DM_N_net_0,
        CKE          => CKE_net_0,
        CS_N         => CS_N_net_0,
        ODT          => ODT_net_0,
        RAS_N        => RAS_N_net_0,
        CAS_N        => CAS_N_net_0,
        WE_N         => WE_N_net_0,
        ACT_N        => ACT_N_net_0,
        BG           => BG_net_0,
        BA           => BA_net_0,
        RESET_N      => RESET_N_net_0,
        A            => A_net_0,
        CK0          => CK0_net_0,
        CK0_N        => CK0_N_net_0,
        SHIELD0      => SHIELD0_net_0,
        SHIELD1      => SHIELD1_net_0,
        SHIELD2      => SHIELD2_net_0,
        SHIELD3      => SHIELD3_net_0,
        SYS_CLK      => DDR4_Cntrl_0_SYS_CLK,
        PLL_LOCK     => DDR4_Cntrl_0_PLL_LOCK,
        axi0_awready => AXI4_Interconnect_0_AXI4mslave0_AWREADY,
        axi0_wready  => AXI4_Interconnect_0_AXI4mslave0_WREADY,
        axi0_bid     => AXI4_Interconnect_0_AXI4mslave0_BID,
        axi0_bresp   => AXI4_Interconnect_0_AXI4mslave0_BRESP,
        axi0_bvalid  => AXI4_Interconnect_0_AXI4mslave0_BVALID,
        axi0_arready => AXI4_Interconnect_0_AXI4mslave0_ARREADY,
        axi0_rid     => AXI4_Interconnect_0_AXI4mslave0_RID,
        axi0_rdata   => AXI4_Interconnect_0_AXI4mslave0_RDATA,
        axi0_rresp   => AXI4_Interconnect_0_AXI4mslave0_RRESP,
        axi0_rlast   => AXI4_Interconnect_0_AXI4mslave0_RLAST,
        axi0_rvalid  => AXI4_Interconnect_0_AXI4mslave0_RVALID,
        CTRLR_READY  => CTRLR_READY_net_0,
        -- Inouts
        DQ           => DQ,
        DQS          => DQS,
        DQS_N        => DQS_N 
        );
-- DREQ_FIFO_1
DREQ_FIFO_1 : DREQ_FIFO
    port map( 
        -- Inputs
        WCLOCK   => DDR4_Cntrl_0_SYS_CLK,
        RCLOCK   => dreqclk,
        WRESET_N => EXT_RST_N,
        RRESET_N => EXT_RST_N,
        DATA     => ew_size_store_and_fetch_controller_0_store_word,
        WE       => ew_size_store_and_fetch_controller_0_store_we,
        RE       => ew_size_store_and_fetch_controller_0_fetch_re,
        -- Outputs
        Q        => DREQ_FIFO_1_Q,
        FULL     => DREQ_FIFO_FULL_net_0,
        EMPTY    => DREQ_FIFO_EMPTY_net_0 
        );
-- edge_generator_0
edge_generator_0 : edge_generator
    port map( 
        -- Inputs
        clk         => dreqclk,
        resetn      => dreqclk_resetn,
        gate        => OR2_0_Y,
        -- Outputs
        risingEdge  => edge_generator_0_risingEdge,
        fallingEdge => OPEN 
        );
-- edge_generator_2
edge_generator_2 : edge_generator
    port map( 
        -- Inputs
        clk         => DDR4_Cntrl_0_SYS_CLK,
        resetn      => SYSCLKReset_FABRIC_RESET_N,
        gate        => OR2_0_Y,
        -- Outputs
        risingEdge  => edge_generator_2_risingEdge,
        fallingEdge => OPEN 
        );
-- EW_FIFO_controller_0
EW_FIFO_controller_0 : EW_FIFO_controller
    generic map( 
        BURST_LENGTH => ( 127 ),
        BURST_SIZE   => ( 3 )
        )
    port map( 
        -- Inputs
        resetn_fifo            => EXT_RST_N,
        sysclk                 => DDR4_Cntrl_0_SYS_CLK,
        resetn_sysclk          => SYSCLKReset_FABRIC_RESET_N,
        dreqclk                => dreqclk,
        resetn_dreqclk         => dreqclk_resetn,
        serdesclk              => serdesclk,
        resetn_serdesclk       => resetn_serdesclk,
        curr_ewfifo_wr         => pattern_switch_0_curr_ewfifo_wr,
        ew_done                => pattern_switch_0_ew_done,
        ew_fifo_we             => pattern_switch_0_ew_fifo_we,
        ew_ovfl                => pattern_switch_0_ew_ovfl,
        ew_data                => pattern_switch_0_ew_fifo_data,
        ew_size                => pattern_switch_0_ew_size,
        ew_tag                 => pattern_switch_0_ew_tag,
        ewtag_offset_seen      => ewtag_cntrl_0_ewtag_offset_latch,
        ewtag_offset_in        => ewtag_offset_out_net_0,
        tag_valid              => ew_size_store_and_fetch_controller_0_fetch_address_valid,
        tag_ovfl               => ew_size_store_and_fetch_controller_0_fetch_overflow,
        tag_size               => ew_size_store_and_fetch_controller_0_fetch_size,
        tag_cnt                => ew_size_store_and_fetch_controller_0_fetch_ddr_address,
        tag_evt                => ew_size_store_and_fetch_controller_0_fetch_tag,
        et_fifo_re             => et_fifo_re,
        last_word              => last_word_net_0,
        awready_i              => EW_FIFO_controller_0_AXI4_M_AWREADY,
        wready_i               => EW_FIFO_controller_0_AXI4_M_WREADY,
        bid_i                  => EW_FIFO_controller_0_AXI4_M_BID,
        bresp_i                => EW_FIFO_controller_0_AXI4_M_BRESP,
        bvalid_i               => EW_FIFO_controller_0_AXI4_M_BVALID,
        arready_i              => EW_FIFO_controller_0_AXI4_M_ARREADY,
        rid_i                  => EW_FIFO_controller_0_AXI4_M_RID,
        rdata_i                => EW_FIFO_controller_0_AXI4_M_RDATA,
        rresp_i                => EW_FIFO_controller_0_AXI4_M_RRESP,
        rlast_i                => EW_FIFO_controller_0_AXI4_M_RLAST,
        rvalid_i               => EW_FIFO_controller_0_AXI4_M_RVALID,
        -- Outputs
        axi_start_on_serdesclk => EW_FIFO_controller_0_axi_start_on_serdesclk,
        ddr_done_on_serdesclk  => EW_FIFO_controller_0_ddr_done_on_serdesclk,
        ew_fifo_emptied        => EW_FIFO_controller_0_ew_fifo_emptied,
        ew_fifo_full           => ew_fifo_full_net_0,
        ew_we_store            => EW_FIFO_controller_0_ew_we_store,
        ew_ovfl_to_store       => EW_FIFO_controller_0_ew_ovfl_to_store,
        ew_DDRwrap_to_store    => ew_DDR_wrap_net_0,
        ew_size_to_store       => EW_FIFO_controller_0_ew_size_to_store,
        ew_tag_to_store        => EW_FIFO_controller_0_ew_tag_to_store,
        et_fifo_rdata          => et_fifo_rdata_net_0,
        et_pckts               => et_pckts_net_0,
        tag_sent               => EW_FIFO_controller_0_tag_sent,
        tag_null               => EW_FIFO_controller_0_tag_null,
        et_fifo_emptied        => EW_FIFO_controller_0_et_fifo_emptied,
        header1_error          => header1_error_net_0,
        header2_error          => header2_error_net_0,
        data_error             => data_error_net_0,
        event_error            => event_error_net_0,
        hdr1_expc              => hdr1_expc_net_0,
        hdr1_seen              => hdr1_seen_net_0,
        hdr2_expc              => hdr2_expc_net_0,
        hdr2_seen              => hdr2_seen_net_0,
        evt_expc               => evt_expc_net_0,
        evt_seen               => evt_seen_net_0,
        data_expc              => data_expc_net_0,
        data_seen              => data_seen_net_0,
        awid_o                 => EW_FIFO_controller_0_AXI4_M_AWID,
        awaddr_o               => EW_FIFO_controller_0_AXI4_M_AWADDR,
        awlen_o                => EW_FIFO_controller_0_AXI4_M_AWLEN,
        awsize_o               => EW_FIFO_controller_0_AXI4_M_AWSIZE,
        awburst_o              => EW_FIFO_controller_0_AXI4_M_AWBURST,
        awvalid_o              => EW_FIFO_controller_0_AXI4_M_AWVALID,
        wstrb_o                => EW_FIFO_controller_0_AXI4_M_WSTRB,
        wlast_o                => EW_FIFO_controller_0_AXI4_M_WLAST,
        wvalid_o               => EW_FIFO_controller_0_AXI4_M_WVALID,
        wdata_o                => EW_FIFO_controller_0_AXI4_M_WDATA,
        bready_o               => EW_FIFO_controller_0_AXI4_M_BREADY,
        arid_o                 => EW_FIFO_controller_0_AXI4_M_ARID,
        araddr_o               => EW_FIFO_controller_0_AXI4_M_ARADDR,
        arlen_o                => EW_FIFO_controller_0_AXI4_M_ARLEN,
        arsize_o               => EW_FIFO_controller_0_AXI4_M_ARSIZE,
        arburst_o              => EW_FIFO_controller_0_AXI4_M_ARBURST,
        arvalid_o              => EW_FIFO_controller_0_AXI4_M_ARVALID,
        rready_o               => EW_FIFO_controller_0_AXI4_M_RREADY 
        );
-- ew_size_store_and_fetch_controller_0
ew_size_store_and_fetch_controller_0 : ew_size_store_and_fetch_controller
    port map( 
        -- Inputs
        wclk                   => DDR4_Cntrl_0_SYS_CLK,
        wreset_n               => SYSCLKReset_FABRIC_RESET_N,
        store_newspill         => edge_generator_2_risingEdge,
        store_event_we         => EW_FIFO_controller_0_ew_we_store,
        store_event_wraparound => ew_DDR_wrap_net_0,
        store_overflow         => EW_FIFO_controller_0_ew_ovfl_to_store,
        store_event_size       => EW_FIFO_controller_0_ew_size_to_store,
        store_event_tag        => EW_FIFO_controller_0_ew_tag_to_store,
        rclk                   => dreqclk,
        rreset_n               => dreqclk_resetn,
        fetch_newspill         => edge_generator_0_risingEdge,
        fetch                  => ewtag_cntrl_0_tag_fetch,
        fetch_event_tag        => ewtag_cntrl_0_evt_tag_fetch,
        size_fifo_empty        => DREQ_FIFO_EMPTY_net_0,
        size_fifo_rdata        => DREQ_FIFO_1_Q,
        -- Outputs
        store_word             => ew_size_store_and_fetch_controller_0_store_word,
        store_we               => ew_size_store_and_fetch_controller_0_store_we,
        store_cnt              => store_cnt_net_0,
        store_pos_cnt          => store_pos_cnt_net_0,
        fetch_timeout_error    => OPEN,
        fetch_missing_error    => OPEN,
        fetch_address_valid    => ew_size_store_and_fetch_controller_0_fetch_address_valid,
        fetch_overflow         => ew_size_store_and_fetch_controller_0_fetch_overflow,
        fetch_ddr_address      => ew_size_store_and_fetch_controller_0_fetch_ddr_address,
        fetch_size             => ew_size_store_and_fetch_controller_0_fetch_size,
        fetch_tag              => ew_size_store_and_fetch_controller_0_fetch_tag,
        fetch_cnt              => fetch_cnt_net_0,
        fetch_pos_cnt          => fetch_pos_cnt_net_0,
        fetch_re               => ew_size_store_and_fetch_controller_0_fetch_re 
        );
-- ewtag_cntrl_0
ewtag_cntrl_0 : ewtag_cntrl
    port map( 
        -- Inputs
        xcvrclk            => RX_CLK,
        resetn_xcvrclk     => RXCLK_RESETN,
        hb_valid           => hb_valid,
        hb_null_valid      => hb_null_valid,
        pref_valid         => pref_valid,
        spill_hbtag_in     => spill_hbtag_in,
        serdesclk          => serdesclk,
        resetn_serdesclk   => resetn_serdesclk,
        ew_fifo_emptied    => EW_FIFO_controller_0_ew_fifo_emptied,
        dreqclk            => dreqclk,
        resetn_dreqclk     => dreqclk_resetn,
        reg_ewtag_offset   => offset_switch_0_ewtag_offset,
        resetn_fifo        => EXT_RST_N,
        start_fetch        => start_fetch,
        event_window_fetch => event_window_fetch,
        event_start        => event_start,
        start_spill        => edge_generator_0_risingEdge,
        tag_sent           => EW_FIFO_controller_0_tag_sent,
        tag_null           => EW_FIFO_controller_0_tag_null,
        tag_done           => EW_FIFO_controller_0_et_fifo_emptied,
        tag_valid          => ew_size_store_and_fetch_controller_0_fetch_address_valid,
        -- Outputs
        pattern_init       => ewtag_cntrl_0_pattern_init,
        spill_ewtag_out    => ewtag_cntrl_0_spill_ewtag_out,
        ewtag_offset_latch => ewtag_cntrl_0_ewtag_offset_latch,
        ewtag_offset_out   => ewtag_offset_out_net_0,
        data_ready         => data_ready_net_0,
        last_word          => last_word_net_0,
        hb_cnt             => hb_cnt_net_0,
        hb_seen_cnt        => hb_seen_cnt_net_0,
        hb_null_cnt        => hb_null_cnt_net_0,
        pref_seen_cnt      => pref_seen_cnt_net_0,
        start_tag_cnt      => start_tag_cnt_net_0,
        tag_done_cnt       => tag_done_cnt_net_0,
        tag_null_cnt       => tag_null_cnt_net_0,
        tag_sent_cnt       => tag_sent_cnt_net_0,
        tag_fetch          => ewtag_cntrl_0_tag_fetch,
        evt_tag_fetch      => ewtag_cntrl_0_evt_tag_fetch 
        );
-- offset_switch_0
offset_switch_0 : offset_switch
    port map( 
        -- Inputs
        serial_en     => set_serial_offset,
        serial_offset => serial_offset,
        run_offset    => run_offset,
        -- Outputs
        ewtag_offset  => offset_switch_0_ewtag_offset 
        );
-- OR2_0
OR2_0 : OR2
    port map( 
        -- Inputs
        A => ONSPILL,
        B => NEWSPILL,
        -- Outputs
        Y => OR2_0_Y 
        );
-- OR2_1
OR2_1 : OR2
    port map( 
        -- Inputs
        A => SERIAL_pattern_en,
        B => DCS_pattern_en,
        -- Outputs
        Y => OR2_1_Y 
        );
-- pattern_FIFO_filler_0
pattern_FIFO_filler_0 : pattern_FIFO_filler
    port map( 
        -- Inputs
        axi_start_on_serdesclk => pattern_switch_0_PATTRN_axi_start_on_serdesclk,
        ddr_done               => EW_FIFO_controller_0_ddr_done_on_serdesclk,
        pattern_init           => ewtag_cntrl_0_pattern_init,
        resetn_serdesclk       => resetn_serdesclk,
        serdesclk              => serdesclk,
        ewtag_in               => ewtag_cntrl_0_spill_ewtag_out,
        -- Outputs
        curr_ewfifo_wr         => pattern_FIFO_filler_0_curr_ewfifo_wr,
        ew_done                => pattern_FIFO_filler_0_ew_done,
        ew_fifo_we             => pattern_FIFO_filler_0_ew_fifo_we,
        ew_ovfl                => pattern_FIFO_filler_0_ew_ovfl,
        ew_data                => pattern_FIFO_filler_0_ew_data,
        ew_size                => pattern_FIFO_filler_0_ew_size,
        ew_tag                 => pattern_FIFO_filler_0_ew_tag 
        );
-- pattern_switch_0
pattern_switch_0 : pattern_switch
    port map( 
        -- Inputs
        pattern_en                    => OR2_1_Y,
        DIGI_curr_ewfifo_wr           => DIGI_curr_ewfifo_wr,
        DIGI_ew_done                  => DIGI_ew_done,
        DIGI_ew_ovfl                  => DIGI_ew_ovfl,
        DIGI_ew_fifo_we               => DIGI_ew_fifo_we,
        DIGI_ew_fifo_data             => DIGI_ew_fifo_data,
        DIGI_ew_size                  => DIGI_ew_size,
        DIGI_ew_tag                   => DIGI_ew_tag,
        PATTRN_curr_ewfifo_wr         => pattern_FIFO_filler_0_curr_ewfifo_wr,
        PATTRN_ew_done                => pattern_FIFO_filler_0_ew_done,
        PATTRN_ew_ovfl                => pattern_FIFO_filler_0_ew_ovfl,
        PATTRN_ew_fifo_we             => pattern_FIFO_filler_0_ew_fifo_we,
        PATTRN_ew_fifo_data           => pattern_FIFO_filler_0_ew_data,
        PATTRN_ew_size                => pattern_FIFO_filler_0_ew_size,
        PATTRN_ew_tag                 => pattern_FIFO_filler_0_ew_tag,
        axi_start_on_serdesclk        => EW_FIFO_controller_0_axi_start_on_serdesclk,
        -- Outputs
        curr_ewfifo_wr                => pattern_switch_0_curr_ewfifo_wr,
        ew_done                       => pattern_switch_0_ew_done,
        ew_ovfl                       => pattern_switch_0_ew_ovfl,
        ew_fifo_we                    => pattern_switch_0_ew_fifo_we,
        ew_fifo_data                  => pattern_switch_0_ew_fifo_data,
        ew_size                       => pattern_switch_0_ew_size,
        ew_tag                        => pattern_switch_0_ew_tag,
        DIGI_axi_start_on_serdesclk   => axi_start_on_serdesclk_net_0,
        PATTRN_axi_start_on_serdesclk => pattern_switch_0_PATTRN_axi_start_on_serdesclk 
        );
-- SYSCLKReset
SYSCLKReset : CORERESET
    port map( 
        -- Inputs
        CLK                => DDR4_Cntrl_0_SYS_CLK,
        EXT_RST_N          => EXT_RST_N,
        BANK_x_VDDI_STATUS => VCC_net,
        BANK_y_VDDI_STATUS => VCC_net,
        PLL_LOCK           => DDR4_Cntrl_0_PLL_LOCK,
        SS_BUSY            => GND_net,
        INIT_DONE          => INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => FPGA_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => OPEN,
        FABRIC_RESET_N     => SYSCLKReset_FABRIC_RESET_N 
        );

end RTL;
