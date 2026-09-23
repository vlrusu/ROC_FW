-- Independent read-only cache of the same samples written to the CPU TVS RAM.
-- At 50 MHz, a channel expires after one second without a new sample.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TVSReadback is
    generic (STALE_CLKS : positive := 50000000);
    port (
        clk, resetn_i, sample_valid : in std_logic;
        sample_channel : in std_logic_vector(1 downto 0);
        sample_value : in std_logic_vector(15 downto 0);
        values_o : out std_logic_vector(63 downto 0);
        fresh_o : out std_logic_vector(3 downto 0)
    );
end TVSReadback;

architecture rtl of TVSReadback is
    type ages_t is array(0 to 3) of natural range 0 to STALE_CLKS-1;
    signal age : ages_t;
    signal fresh : std_logic_vector(3 downto 0);
begin
    fresh_o <= fresh;
    process(clk, resetn_i)
    begin
        if resetn_i = '0' then
            values_o <= (others => '0');
            fresh <= (others => '0');
            age <= (others => 0);
        elsif rising_edge(clk) then
            for channel in 0 to 3 loop
                if sample_valid = '1' and sample_channel = std_logic_vector(to_unsigned(channel, 2)) then
                    values_o(16*channel+15 downto 16*channel) <= sample_value;
                    fresh(channel) <= '1';
                    age(channel) <= 0;
                elsif fresh(channel) = '1' then
                    if age(channel) = STALE_CLKS-1 then
                        fresh(channel) <= '0';
                    else
                        age(channel) <= age(channel) + 1;
                    end if;
                end if;
            end loop;
        end if;
    end process;
end rtl;
