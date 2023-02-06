----------------------------------------------------------------------
-- Created by SmartDesign Mon Feb  6 12:24:15 2023
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
-- XCVR_Block entity declaration
----------------------------------------------------------------------
entity XCVR_Block is
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
end XCVR_Block;
----------------------------------------------------------------------
-- XCVR_Block architecture body
----------------------------------------------------------------------
architecture RTL of XCVR_Block is
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
-- ClockAligner
component ClockAligner
    -- Port list
    port(
        -- Inputs
        CTRL_CLK               : in  std_logic;
        CTRL_RESET_N           : in  std_logic;
        ENABLE_ALIGNMENT       : in  std_logic;
        PCS_ALIGNED            : in  std_logic;
        RX_CLK                 : in  std_logic;
        RX_DATA                : in  std_logic_vector(19 downto 0);
        RX_RESET_N             : in  std_logic;
        RX_VAL                 : in  std_logic;
        -- Outputs
        ALIGNMENT_LOSS_COUNTER : out std_logic_vector(7 downto 0);
        ALIGNMENT_RESET_N      : out std_logic;
        CLOCK_ALIGNED          : out std_logic
        );
end component;
-- CorePCS_C0
component CorePCS_C0
    -- Port list
    port(
        -- Inputs
        DISP_SEL    : in  std_logic_vector(1 downto 0);
        EPCS_READY  : in  std_logic;
        EPCS_RxCLK  : in  std_logic;
        EPCS_RxDATA : in  std_logic_vector(19 downto 0);
        EPCS_RxIDLE : in  std_logic;
        EPCS_RxRSTn : in  std_logic;
        EPCS_RxVAL  : in  std_logic;
        EPCS_TxCLK  : in  std_logic;
        EPCS_TxRSTn : in  std_logic;
        FORCE_DISP  : in  std_logic_vector(1 downto 0);
        RESET_N     : in  std_logic;
        TX_DATA     : in  std_logic_vector(15 downto 0);
        TX_K_CHAR   : in  std_logic_vector(1 downto 0);
        WA_RSTn     : in  std_logic;
        -- Outputs
        ALIGNED     : out std_logic;
        B_CERR      : out std_logic_vector(1 downto 0);
        CODE_ERR_N  : out std_logic_vector(1 downto 0);
        EPCS_PWRDN  : out std_logic;
        EPCS_RxERR  : out std_logic;
        EPCS_TXOOB  : out std_logic;
        EPCS_TxDATA : out std_logic_vector(19 downto 0);
        EPCS_TxVAL  : out std_logic;
        INVALID_K   : out std_logic_vector(1 downto 0);
        RD_ERR      : out std_logic_vector(1 downto 0);
        RX_DATA     : out std_logic_vector(15 downto 0);
        RX_K_CHAR   : out std_logic_vector(1 downto 0)
        );
end component;
-- MUX_TX
component MUX_TX
    -- Port list
    port(
        -- Inputs
        DTCSIM_DATA  : in  std_logic_vector(15 downto 0);
        DTCSIM_EN    : in  std_logic;
        DTCSIM_KCHAR : in  std_logic_vector(1 downto 0);
        FIBER_DATA   : in  std_logic_vector(15 downto 0);
        FIBER_KCHAR  : in  std_logic_vector(1 downto 0);
        PRBS_DATA    : in  std_logic_vector(15 downto 0);
        PRBS_EN      : in  std_logic;
        PRBS_KCHAR   : in  std_logic_vector(1 downto 0);
        TX_CLK       : in  std_logic;
        -- Outputs
        TX_DATA      : out std_logic_vector(15 downto 0);
        TX_KCHAR     : out std_logic_vector(1 downto 0)
        );
end component;
-- ReplyPktDecoder
component ReplyPktDecoder
    -- Port list
    port(
        -- Inputs
        TX_CLK      : in  std_logic;
        TX_RESETN   : in  std_logic;
        data_in     : in  std_logic_vector(15 downto 0);
        kchar_in    : in  std_logic_vector(1 downto 0);
        -- Outputs
        TX_DATA_OUT : out std_logic_vector(31 downto 0)
        );
end component;
-- WordAligner
component WordAligner
    -- Port list
    port(
        -- Inputs
        clk          : in  std_logic;
        data_in      : in  std_logic_vector(15 downto 0);
        k_char_in    : in  std_logic_vector(1 downto 0);
        reset_n      : in  std_logic;
        -- Outputs
        data_out     : out std_logic_vector(15 downto 0);
        k_char_out   : out std_logic_vector(1 downto 0);
        word_aligned : out std_logic
        );
end component;
-- WordFlipper
component WordFlipper
    -- Port list
    port(
        -- Inputs
        data_in    : in  std_logic_vector(15 downto 0);
        k_char_in  : in  std_logic_vector(1 downto 0);
        -- Outputs
        data_out   : out std_logic_vector(15 downto 0);
        k_char_out : out std_logic_vector(1 downto 0)
        );
end component;
-- PF_XCVR_REF_CLK_C0
component PF_XCVR_REF_CLK_C0
    -- Port list
    port(
        -- Inputs
        REF_CLK_PAD_N : in  std_logic;
        REF_CLK_PAD_P : in  std_logic;
        -- Outputs
        REF_CLK       : out std_logic
        );
end component;
-- PF_XCVR_ERM_C0
component PF_XCVR_ERM_C0
    -- Port list
    port(
        -- Inputs
        CTRL_ARST_N          : in  std_logic;
        CTRL_CLK             : in  std_logic;
        LANE0_CDR_REF_CLK_0  : in  std_logic;
        LANE0_LOS            : in  std_logic;
        LANE0_PCS_ARST_N     : in  std_logic;
        LANE0_PMA_ARST_N     : in  std_logic;
        LANE0_RXD_N          : in  std_logic;
        LANE0_RXD_P          : in  std_logic;
        LANE0_RX_SLIP        : in  std_logic;
        LANE0_TX_DATA        : in  std_logic_vector(19 downto 0);
        TX_BIT_CLK_0         : in  std_logic;
        TX_PLL_LOCK_0        : in  std_logic;
        TX_PLL_REF_CLK_0     : in  std_logic;
        -- Outputs
        LANE0_RX_BYPASS_DATA : out std_logic;
        LANE0_RX_CLK_R       : out std_logic;
        LANE0_RX_DATA        : out std_logic_vector(19 downto 0);
        LANE0_RX_IDLE        : out std_logic;
        LANE0_RX_READY       : out std_logic;
        LANE0_RX_VAL         : out std_logic;
        LANE0_TXD_N          : out std_logic;
        LANE0_TXD_P          : out std_logic;
        LANE0_TX_CLK_R       : out std_logic;
        LANE0_TX_CLK_STABLE  : out std_logic
        );
end component;
-- XCVR_PLL_0
component XCVR_PLL_0
    -- Port list
    port(
        -- Inputs
        REF_CLK         : in  std_logic;
        -- Outputs
        BIT_CLK         : out std_logic;
        LOCK            : out std_logic;
        PLL_LOCK        : out std_logic;
        REF_CLK_TO_LANE : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal ALIGNMENT_LOSS_COUNTER_net_0            : std_logic_vector(7 downto 0);
signal B_CERR_net_0                            : std_logic_vector(1 downto 0);
signal CLOCK_ALIGNED_net_0                     : std_logic;
signal ClockAligner_0_ALIGNMENT_RESET_N        : std_logic;
signal CODE_ERR_N_net_0                        : std_logic_vector(1 downto 0);
signal Core_PCS_0_EPCS_TxDATA                  : std_logic_vector(19 downto 0);
signal Core_PCS_0_RX_DATA                      : std_logic_vector(15 downto 0);
signal Core_PCS_0_RX_K_CHAR                    : std_logic_vector(1 downto 0);
signal DTCDATA_OUT_net_0                       : std_logic_vector(31 downto 0);
signal EPCS_RxERR_net_0                        : std_logic;
signal INVALID_K_net_0                         : std_logic_vector(1 downto 0);
signal LANE0_RX_CLK_R_net_0                    : std_logic;
signal LANE0_RX_READY_net_0                    : std_logic;
signal LANE0_RX_VAL_net_0                      : std_logic;
signal LANE0_TX_CLK_R_net_0                    : std_logic;
signal LANE0_TX_CLK_STABLE_net_0               : std_logic;
signal LANE0_TXD_N_net_0                       : std_logic;
signal LANE0_TXD_P_net_0                       : std_logic;
signal MUX_TX_0_TX_DATA                        : std_logic_vector(15 downto 0);
signal MUX_TX_0_TX_KCHAR                       : std_logic_vector(1 downto 0);
signal PCS_ALIGNED_net_0                       : std_logic;
signal RD_ERR_net_0                            : std_logic_vector(1 downto 0);
signal resetn_align_net_0                      : std_logic;
signal RX_DATA_net_0                           : std_logic_vector(15 downto 0);
signal RX_K_CHAR_net_0                         : std_logic_vector(1 downto 0);
signal word_aligned_net_0                      : std_logic;
signal WordFlipper_0_data_out                  : std_logic_vector(15 downto 0);
signal WordFlipper_0_k_char_out                : std_logic_vector(1 downto 0);
signal WordFlipper_1_data_out                  : std_logic_vector(15 downto 0);
signal WordFlipper_1_k_char_out                : std_logic_vector(1 downto 0);
signal XCVR_CLK_0_REF_CLK                      : std_logic;
signal XCVR_IF_0_LANE0_RX_DATA                 : std_logic_vector(19 downto 0);
signal XCVR_IF_0_LANE0_RX_IDLE                 : std_logic;
signal XCVR_PLL_0_CLKS_TO_XCVR_BIT_CLK         : std_logic;
signal XCVR_PLL_0_CLKS_TO_XCVR_LOCK            : std_logic;
signal XCVR_PLL_0_CLKS_TO_XCVR_REF_CLK_TO_LANE : std_logic;
signal CLOCK_ALIGNED_net_1                     : std_logic;
signal EPCS_RxERR_net_1                        : std_logic;
signal LANE0_RX_CLK_R_net_1                    : std_logic;
signal LANE0_RX_READY_net_1                    : std_logic;
signal LANE0_RX_VAL_net_1                      : std_logic;
signal LANE0_TXD_N_net_1                       : std_logic;
signal LANE0_TXD_P_net_1                       : std_logic;
signal LANE0_TX_CLK_R_net_1                    : std_logic;
signal LANE0_TX_CLK_STABLE_net_1               : std_logic;
signal PCS_ALIGNED_net_1                       : std_logic;
signal resetn_align_net_1                      : std_logic;
signal word_aligned_net_1                      : std_logic;
signal ALIGNMENT_LOSS_COUNTER_net_1            : std_logic_vector(7 downto 0);
signal B_CERR_net_1                            : std_logic_vector(1 downto 0);
signal CODE_ERR_N_net_1                        : std_logic_vector(1 downto 0);
signal DTCDATA_OUT_net_1                       : std_logic_vector(31 downto 0);
signal INVALID_K_net_1                         : std_logic_vector(1 downto 0);
signal RD_ERR_net_1                            : std_logic_vector(1 downto 0);
signal RX_DATA_net_1                           : std_logic_vector(15 downto 0);
signal RX_K_CHAR_net_1                         : std_logic_vector(1 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                 : std_logic;
signal FORCE_DISP_const_net_0                  : std_logic_vector(1 downto 0);
signal DISP_SEL_const_net_0                    : std_logic_vector(1 downto 0);
signal GND_net                                 : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net                <= '1';
 FORCE_DISP_const_net_0 <= B"00";
 DISP_SEL_const_net_0   <= B"00";
 GND_net                <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CLOCK_ALIGNED_net_1                <= CLOCK_ALIGNED_net_0;
 CLOCK_ALIGNED                      <= CLOCK_ALIGNED_net_1;
 EPCS_RxERR_net_1                   <= EPCS_RxERR_net_0;
 EPCS_RxERR                         <= EPCS_RxERR_net_1;
 LANE0_RX_CLK_R_net_1               <= LANE0_RX_CLK_R_net_0;
 LANE0_RX_CLK_R                     <= LANE0_RX_CLK_R_net_1;
 LANE0_RX_READY_net_1               <= LANE0_RX_READY_net_0;
 LANE0_RX_READY                     <= LANE0_RX_READY_net_1;
 LANE0_RX_VAL_net_1                 <= LANE0_RX_VAL_net_0;
 LANE0_RX_VAL                       <= LANE0_RX_VAL_net_1;
 LANE0_TXD_N_net_1                  <= LANE0_TXD_N_net_0;
 LANE0_TXD_N                        <= LANE0_TXD_N_net_1;
 LANE0_TXD_P_net_1                  <= LANE0_TXD_P_net_0;
 LANE0_TXD_P                        <= LANE0_TXD_P_net_1;
 LANE0_TX_CLK_R_net_1               <= LANE0_TX_CLK_R_net_0;
 LANE0_TX_CLK_R                     <= LANE0_TX_CLK_R_net_1;
 LANE0_TX_CLK_STABLE_net_1          <= LANE0_TX_CLK_STABLE_net_0;
 LANE0_TX_CLK_STABLE                <= LANE0_TX_CLK_STABLE_net_1;
 PCS_ALIGNED_net_1                  <= PCS_ALIGNED_net_0;
 PCS_ALIGNED                        <= PCS_ALIGNED_net_1;
 resetn_align_net_1                 <= resetn_align_net_0;
 resetn_align                       <= resetn_align_net_1;
 word_aligned_net_1                 <= word_aligned_net_0;
 word_aligned                       <= word_aligned_net_1;
 ALIGNMENT_LOSS_COUNTER_net_1       <= ALIGNMENT_LOSS_COUNTER_net_0;
 ALIGNMENT_LOSS_COUNTER(7 downto 0) <= ALIGNMENT_LOSS_COUNTER_net_1;
 B_CERR_net_1                       <= B_CERR_net_0;
 B_CERR(1 downto 0)                 <= B_CERR_net_1;
 CODE_ERR_N_net_1                   <= CODE_ERR_N_net_0;
 CODE_ERR_N(1 downto 0)             <= CODE_ERR_N_net_1;
 DTCDATA_OUT_net_1                  <= DTCDATA_OUT_net_0;
 DTCDATA_OUT(31 downto 0)           <= DTCDATA_OUT_net_1;
 INVALID_K_net_1                    <= INVALID_K_net_0;
 INVALID_K(1 downto 0)              <= INVALID_K_net_1;
 RD_ERR_net_1                       <= RD_ERR_net_0;
 RD_ERR(1 downto 0)                 <= RD_ERR_net_1;
 RX_DATA_net_1                      <= RX_DATA_net_0;
 RX_DATA(15 downto 0)               <= RX_DATA_net_1;
 RX_K_CHAR_net_1                    <= RX_K_CHAR_net_0;
 RX_K_CHAR(1 downto 0)              <= RX_K_CHAR_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_0
AND2_0 : AND2
    port map( 
        -- Inputs
        A => ALIGN_RESETN,
        B => ClockAligner_0_ALIGNMENT_RESET_N,
        -- Outputs
        Y => resetn_align_net_0 
        );
-- ClockAligner_0
ClockAligner_0 : ClockAligner
    port map( 
        -- Inputs
        RX_RESET_N             => ALIGN_RESETN,
        RX_CLK                 => LANE0_RX_CLK_R_net_0,
        CTRL_RESET_N           => CTRL_ARST_N,
        CTRL_CLK               => CTRL_CLK,
        RX_DATA                => XCVR_IF_0_LANE0_RX_DATA,
        PCS_ALIGNED            => PCS_ALIGNED_net_0,
        RX_VAL                 => LANE0_RX_VAL_net_0,
        ENABLE_ALIGNMENT       => ENABLE_ALIGNMENT,
        -- Outputs
        CLOCK_ALIGNED          => CLOCK_ALIGNED_net_0,
        ALIGNMENT_LOSS_COUNTER => ALIGNMENT_LOSS_COUNTER_net_0,
        ALIGNMENT_RESET_N      => ClockAligner_0_ALIGNMENT_RESET_N 
        );
-- Core_PCS_0
Core_PCS_0 : CorePCS_C0
    port map( 
        -- Inputs
        RESET_N     => resetn_align_net_0,
        EPCS_READY  => LANE0_RX_READY_net_0,
        EPCS_TxRSTn => VCC_net,
        EPCS_TxCLK  => LANE0_TX_CLK_R_net_0,
        EPCS_RxRSTn => LANE0_RX_VAL_net_0,
        EPCS_RxCLK  => LANE0_RX_CLK_R_net_0,
        EPCS_RxVAL  => LANE0_RX_VAL_net_0,
        EPCS_RxDATA => XCVR_IF_0_LANE0_RX_DATA,
        EPCS_RxIDLE => XCVR_IF_0_LANE0_RX_IDLE,
        TX_DATA     => WordFlipper_1_data_out,
        TX_K_CHAR   => WordFlipper_1_k_char_out,
        WA_RSTn     => ClockAligner_0_ALIGNMENT_RESET_N,
        FORCE_DISP  => FORCE_DISP_const_net_0,
        DISP_SEL    => DISP_SEL_const_net_0,
        -- Outputs
        EPCS_PWRDN  => OPEN,
        EPCS_TXOOB  => OPEN,
        EPCS_TxVAL  => OPEN,
        EPCS_TxDATA => Core_PCS_0_EPCS_TxDATA,
        EPCS_RxERR  => EPCS_RxERR_net_0,
        INVALID_K   => INVALID_K_net_0,
        RX_DATA     => Core_PCS_0_RX_DATA,
        CODE_ERR_N  => CODE_ERR_N_net_0,
        RX_K_CHAR   => Core_PCS_0_RX_K_CHAR,
        B_CERR      => B_CERR_net_0,
        RD_ERR      => RD_ERR_net_0,
        ALIGNED     => PCS_ALIGNED_net_0 
        );
-- MUX_TX_0
MUX_TX_0 : MUX_TX
    port map( 
        -- Inputs
        TX_CLK       => LANE0_TX_CLK_R_net_0,
        PRBS_EN      => PRBS_EN,
        PRBS_DATA    => PRBS_DATA,
        PRBS_KCHAR   => PRBS_KCHAR,
        DTCSIM_EN    => DTCSIM_EN,
        DTCSIM_DATA  => DTCSIM_DATA,
        DTCSIM_KCHAR => DTCSIM_KCHAR,
        FIBER_DATA   => TX_DATA,
        FIBER_KCHAR  => TX_K_CHAR,
        -- Outputs
        TX_DATA      => MUX_TX_0_TX_DATA,
        TX_KCHAR     => MUX_TX_0_TX_KCHAR 
        );
-- ReplyPktDecoder_0
ReplyPktDecoder_0 : ReplyPktDecoder
    port map( 
        -- Inputs
        TX_CLK      => LANE0_TX_CLK_R_net_0,
        TX_RESETN   => TX_RESETN,
        data_in     => TX_DATA,
        kchar_in    => TX_K_CHAR,
        -- Outputs
        TX_DATA_OUT => DTCDATA_OUT_net_0 
        );
-- WordAligner_0
WordAligner_0 : WordAligner
    port map( 
        -- Inputs
        reset_n      => resetn_align_net_0,
        clk          => LANE0_RX_CLK_R_net_0,
        k_char_in    => WordFlipper_0_k_char_out,
        data_in      => WordFlipper_0_data_out,
        -- Outputs
        word_aligned => word_aligned_net_0,
        k_char_out   => RX_K_CHAR_net_0,
        data_out     => RX_DATA_net_0 
        );
-- WordFlipper_0
WordFlipper_0 : WordFlipper
    port map( 
        -- Inputs
        k_char_in  => Core_PCS_0_RX_K_CHAR,
        data_in    => Core_PCS_0_RX_DATA,
        -- Outputs
        k_char_out => WordFlipper_0_k_char_out,
        data_out   => WordFlipper_0_data_out 
        );
-- WordFlipper_1
WordFlipper_1 : WordFlipper
    port map( 
        -- Inputs
        k_char_in  => MUX_TX_0_TX_KCHAR,
        data_in    => MUX_TX_0_TX_DATA,
        -- Outputs
        k_char_out => WordFlipper_1_k_char_out,
        data_out   => WordFlipper_1_data_out 
        );
-- XCVR_CLK_0
XCVR_CLK_0 : PF_XCVR_REF_CLK_C0
    port map( 
        -- Inputs
        REF_CLK_PAD_P => REF_CLK_PAD_P,
        REF_CLK_PAD_N => REF_CLK_PAD_N,
        -- Outputs
        REF_CLK       => XCVR_CLK_0_REF_CLK 
        );
-- XCVR_IF_0
XCVR_IF_0 : PF_XCVR_ERM_C0
    port map( 
        -- Inputs
        LANE0_RXD_P          => LANE0_RXD_P,
        LANE0_RXD_N          => LANE0_RXD_N,
        LANE0_TX_DATA        => Core_PCS_0_EPCS_TxDATA,
        LANE0_CDR_REF_CLK_0  => XCVR_CLK_0_REF_CLK,
        LANE0_RX_SLIP        => GND_net,
        LANE0_PCS_ARST_N     => ClockAligner_0_ALIGNMENT_RESET_N,
        LANE0_PMA_ARST_N     => ClockAligner_0_ALIGNMENT_RESET_N,
        TX_PLL_LOCK_0        => XCVR_PLL_0_CLKS_TO_XCVR_LOCK,
        TX_BIT_CLK_0         => XCVR_PLL_0_CLKS_TO_XCVR_BIT_CLK,
        TX_PLL_REF_CLK_0     => XCVR_PLL_0_CLKS_TO_XCVR_REF_CLK_TO_LANE,
        CTRL_CLK             => CTRL_CLK,
        CTRL_ARST_N          => CTRL_ARST_N,
        LANE0_LOS            => GND_net,
        -- Outputs
        LANE0_TXD_P          => LANE0_TXD_P_net_0,
        LANE0_TXD_N          => LANE0_TXD_N_net_0,
        LANE0_RX_DATA        => XCVR_IF_0_LANE0_RX_DATA,
        LANE0_TX_CLK_R       => LANE0_TX_CLK_R_net_0,
        LANE0_RX_CLK_R       => LANE0_RX_CLK_R_net_0,
        LANE0_RX_IDLE        => XCVR_IF_0_LANE0_RX_IDLE,
        LANE0_TX_CLK_STABLE  => LANE0_TX_CLK_STABLE_net_0,
        LANE0_RX_BYPASS_DATA => OPEN,
        LANE0_RX_READY       => LANE0_RX_READY_net_0,
        LANE0_RX_VAL         => LANE0_RX_VAL_net_0 
        );
-- XCVR_PLL_0_inst_0
XCVR_PLL_0_inst_0 : XCVR_PLL_0
    port map( 
        -- Inputs
        REF_CLK         => XCVR_CLK_0_REF_CLK,
        -- Outputs
        PLL_LOCK        => OPEN,
        LOCK            => XCVR_PLL_0_CLKS_TO_XCVR_LOCK,
        BIT_CLK         => XCVR_PLL_0_CLKS_TO_XCVR_BIT_CLK,
        REF_CLK_TO_LANE => XCVR_PLL_0_CLKS_TO_XCVR_REF_CLK_TO_LANE 
        );

end RTL;
