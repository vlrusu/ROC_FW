--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: TxController.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TxController is
port (
    reset_n : in std_logic;
    clk : in std_logic;
    wrcnt : in std_logic_vector(12 downto 0);
    force_full : in std_logic;
    align : in std_logic;
    
    kchar_out : out std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(31 downto 0)
);
end TxController;
architecture architecture_TxController of TxController is

    signal align_1q : std_logic;
    signal align_2q : std_logic;
    signal align_3q : std_logic;
    signal aligned_count : unsigned(7 downto 0);
    signal force_full_1q : std_logic;
    signal force_full_2q : std_logic;
    
    type sm_type is (ALIGNING, START);
    signal sm : sm_type;

begin
    
    process(reset_n, clk)
    begin
    if reset_n = '0' then
        sm <= ALIGNING;
        align_1q <= '0';
        align_2q <= '0';
        align_3q <= '0';
        aligned_count <= (others => '0');
        force_full_1q <= '0';
        force_full_2q <= '0';
        
        
        data_out <= X"000000BC";
        kchar_out <= "0001";
        
    elsif rising_edge(clk) then
        align_1q <= align;
        align_2q <= align_1q;
        align_3q <= align_2q;
        if align_2q = '1' and align_3q = '0' then
            aligned_count <= (others => '0');
            sm <= ALIGNING;
        end if;
        force_full_1q <= force_full;
        force_full_2q <= force_full_1q;
        
        case sm is
            when ALIGNING =>
                data_out <= X"000000BC";
                kchar_out <= "0001";
                aligned_count <= aligned_count + 1;
                if aligned_count = X"FF" then
                    sm <= START;
                end if;
                
            when START =>
                data_out <= X"00000000";
                kchar_out <= "0000";
                if unsigned(wrcnt) < 2048 - 1024 and force_full_2q = '0' then
                    data_out <= X"01010101";
                    kchar_out <= "0000";
                end if;
                
            when others =>
                data_out <= X"000000BC";
                kchar_out <= "0001";
                sm <= ALIGNING;
                
        end case;
              
    end if;
    end process;


end architecture_TxController;
