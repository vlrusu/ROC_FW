library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity delay_sreg_4bit is
  generic (
    ADDR_W : integer := 10                        -- 10 -> delays up to 2**10-1 = 1023
  );
  port (
    clk      : in  std_logic;
    resetn   : in  std_logic;
    sr_delay : in  std_logic_vector(ADDR_W-1 downto 0);
    sr_in    : in  std_logic_vector(3 downto 0);  -- 4 signals packed into one word
    sr_out   : out std_logic_vector(3 downto 0)
  );
end delay_sreg_4bit;


architecture rtl of delay_sreg_4bit is

    constant DEPTH : integer := 2**ADDR_W;

    type ram_t is array (0 to DEPTH-1) of std_logic_vector(3 downto 0);
    signal sr_ram       : ram_t;

    signal wr_ptr       : unsigned(ADDR_W-1 downto 0);
    signal rd_ptr       : unsigned(ADDR_W-1 downto 0);
    signal stored_count : unsigned(ADDR_W-1 downto 0);

    signal ram_q        : std_logic_vector(3 downto 0);  -- registered RAM read data

    -- registered control flags (kept off the critical path)
    signal delay_is_0   : std_logic;
    signal not_ready    : std_logic;

    -- track the last delay value so we only re-seed rd_ptr when it changes
    signal sr_delay_q   : unsigned(ADDR_W-1 downto 0);

begin

    -- Output select. delay_is_0 and not_ready are registered, so this is
    -- just a small 2-level mux on the back end.
    sr_out <= sr_in              when delay_is_0 = '1' else
              (others => '0')    when not_ready  = '1' else
              ram_q;

    process(clk, resetn)
        variable dly : unsigned(ADDR_W-1 downto 0);
    begin
        if resetn = '0' then
            wr_ptr       <= (others => '0');
            rd_ptr       <= (others => '0');
            stored_count <= (others => '0');
            ram_q        <= (others => '0');
            delay_is_0   <= '0';
            not_ready    <= '0';
            sr_delay_q   <= (others => '0');
        elsif rising_edge(clk) then

            dly := unsigned(sr_delay);
            sr_delay_q <= dly;

            -- ---- Write path: one 4-bit-wide write per cycle ----
            sr_ram(to_integer(wr_ptr)) <= sr_in;
            wr_ptr <= wr_ptr + 1;

            -- ---- Read pointer: lockstep increment, no subtractor in steady state ----
            -- Re-seed rd_ptr only when the delay value changes; otherwise just
            -- increment it in lockstep with wr_ptr. This keeps the per-cycle
            -- critical path free of the wide subtractor.
            if dly /= sr_delay_q then
                rd_ptr <= wr_ptr - dly;          -- subtractor used only on change
            else
                rd_ptr <= rd_ptr + 1;
            end if;

            -- ---- Registered RAM read ----
            ram_q <= sr_ram(to_integer(rd_ptr));

            -- ---- Fill counter (saturates at delay) ----
            if stored_count < dly then
                stored_count <= stored_count + 1;
            end if;

            -- ---- Registered control flags ----
            if dly = 0 then
                delay_is_0 <= '1';
            else
                delay_is_0 <= '0';
            end if;

            if stored_count < dly then
                not_ready <= '1';
            else
                not_ready <= '0';
            end if;

        end if;
    end process;

end architecture rtl;