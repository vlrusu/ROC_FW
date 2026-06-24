library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RxController is
port (
    rx_clk         : in  std_logic;
    reset_n        : in  std_logic;

    rx_val         : in  std_logic;
    k_in           : in  std_logic_vector(3 downto 0);
    data_in        : in  std_logic_vector(31 downto 0);

    code_violation : in  std_logic_vector(3 downto 0);
    disp_error     : in  std_logic_vector(3 downto 0);

    aligned        : out std_logic;
    alignment      : out std_logic_vector(3 downto 0);

    error_count    : out std_logic_vector(7 downto 0);

    data_out       : out std_logic_vector(31 downto 0);  -- aligned word to FIFO
    data_valid     : out std_logic
);
end RxController;

architecture architecture_RxController of RxController is

    signal valid_seen    : std_logic;
    signal error_counter : unsigned(7 downto 0);

    signal aligned_i     : std_logic;
    signal alignment_i   : std_logic_vector(3 downto 0);

    signal prev_data     : std_logic_vector(31 downto 0);
    signal prev_valid    : std_logic;  -- prev_data holds a real captured word
    signal prev_k_in     : std_logic_vector(3 downto 0);

begin

    aligned   <= aligned_i;
    alignment <= alignment_i;
    error_count <= std_logic_vector(error_counter);

    process(rx_clk, reset_n)
        variable k_out : std_logic_vector(3 downto 0);
    begin
    if reset_n = '0' then
        valid_seen    <= '0';
        alignment_i   <= (others => '0');
        aligned_i     <= '0';
        error_counter <= (others => '0');
        prev_data     <= (others => '0');
        prev_valid    <= '0';
        prev_k_in     <= (others => '0');
        data_out      <= (others => '0');
        data_valid    <= '0';

    elsif rising_edge(rx_clk) then

        -- default: no write this cycle
        data_valid <= '0';
        prev_k_in <= k_in;
        prev_data  <= data_in;

        -- ----- alignment detection (unchanged in spirit) -----
        case k_in is
            when "0000" =>
                -- no comma this cycle; keep current alignment
                null;
            when "0001" =>
                alignment_i <= "0001";
                aligned_i   <= '1';
            when "0010" =>
                alignment_i <= "0010";
                aligned_i   <= '1';
            when "0100" =>
                alignment_i <= "0100";
                aligned_i   <= '1';
            when "1000" =>
                alignment_i <= "1000";
                aligned_i   <= '1';
            when others =>
                -- multiple commas / unexpected k pattern: not aligned
                alignment_i <= "1111";
                aligned_i   <= '0';
        end case;

        -- ----- capture current word into the history register -----
        if rx_val = '1' then
            prev_valid <= '1';
            valid_seen <= '1';
        else
            alignment_i <= "0000";
            aligned_i   <= '0';
            prev_valid  <= '0';   -- history is stale; must re-prime
        end if;

        -- ----- assemble and write the aligned word -----
        -- We need prev_data (valid) AND current data_in to form one output.
        -- One output word per input cycle once aligned and history is primed.
        if rx_val = '1' and aligned_i = '1' and prev_valid = '1' then
            case alignment_i is
                when "0001" =>
                    data_out <= prev_data;
                    k_out    := prev_k_in;
                when "0010" =>
                    data_out <= data_in(7  downto 0) & prev_data(31 downto 8);
                    k_out    := k_in(0 downto 0) & prev_k_in(3 downto 1);
                when "0100" =>
                    data_out <= data_in(15 downto 0) & prev_data(31 downto 16);
                    k_out    := k_in(1 downto 0) & prev_k_in(3 downto 2);
                when "1000" =>
                    data_out <= data_in(23 downto 0) & prev_data(31 downto 24);
                    k_out    := k_in(2 downto 0) & prev_k_in(3 downto 3);
                when others =>
                    data_out <= (others => '0');
                    k_out    := "1111";   -- force discard on bad alignment
            end case;
            if k_out = "0000" then
                data_valid <= '1';
            else
                data_valid <= '0';
            end if;
        end if;

        -- ----- error counting -----
        if (rx_val = '0' or disp_error /= "0000" or code_violation /= "0000")
           and valid_seen = '1' then
            error_counter <= error_counter + 1;
        end if;

    end if;
    end process;

end architecture_RxController;