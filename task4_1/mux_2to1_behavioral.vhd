--------------------------------------------
-- Module Name: mux_2to1_behavioral
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mux_2to1_behavioral is
port (
		io_swt_a : inout std_logic_vector(7 downto 0);
		clk_in : in std_logic;
		led : out std_logic_vector(7 downto 0)
	);
end mux_2to1_behavioral;

architecture behavior of mux_2to1_behavioral is

    -- internal net for outputs from pulldown module
    signal io_swt_a_out : std_logic_vector(7 downto 0);

    -- internal nets for 2-to-1 mux
    signal and_out0 : std_logic;
    signal and_out1 : std_logic;
    signal x, y, s, m : std_logic;

    -- pull-down component
	component pulldown
		port (
        	in_swt : inout std_logic_vector(7 downto 0);
        	clk : in std_logic;
			swt_state : out std_logic_vector(7 downto 0)
		);
    end component;

	begin
        -- wire pulldown component (SWTA switches)
		swta_pd: pulldown port map(io_swt_a, clk_in, io_swt_a_out);

        -- Implement 2-to-1 mux using dataflow modeling
        x <= io_swt_a_out(0); -- SWT_A DIP1 = x input
        y <= io_swt_a_out(1); -- SWT_A DIP2 = y input
        s <= io_swt_a_out(2); -- SWT_A DIP3 = s input
        led(0) <= m; -- LED0 = m output;

        -- behavioral modeling
        process(x, y, s)

            begin
            
            if s = '0' then
                m <= x;
            else
                m <= y;
            end if;

        end process;

end behavior;
