----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Mon Feb  6 12:20:44 2023
-- Parameters for COREFIFO
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant AE_STATIC_EN : integer := 0;
    constant AEVAL : integer := 4;
    constant AF_STATIC_EN : integer := 1;
    constant AFVAL : integer := 2047;
    constant CTRL_TYPE : integer := 2;
    constant DIE_SIZE : integer := 15;
    constant ECC : integer := 0;
    constant ESTOP : integer := 1;
    constant FAMILY : integer := 26;
    constant FSTOP : integer := 1;
    constant FWFT : integer := 0;
    constant HDL_License : string( 1 to 1 ) := "U";
    constant NUM_STAGES : integer := 2;
    constant OVERFLOW_EN : integer := 0;
    constant PIPE : integer := 1;
    constant PREFETCH : integer := 0;
    constant RAM_OPT : integer := 0;
    constant RDCNT_EN : integer := 0;
    constant RDEPTH : integer := 1024;
    constant RE_POLARITY : integer := 0;
    constant READ_DVALID : integer := 0;
    constant RWIDTH : integer := 64;
    constant SYNC : integer := 0;
    constant SYNC_RESET : integer := 0;
    constant testbench : string( 1 to 4 ) := "User";
    constant UNDERFLOW_EN : integer := 0;
    constant WDEPTH : integer := 2048;
    constant WE_POLARITY : integer := 0;
    constant WRCNT_EN : integer := 0;
    constant WRITE_ACK : integer := 0;
    constant WWIDTH : integer := 32;
end coreparameters;
