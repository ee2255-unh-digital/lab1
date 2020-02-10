--------------------------------------------
-- Module Name: mux_2to1_struct
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mux_2to1_struct is
port (
		io_swt_a : inout std_logic_vector(7 downto 0);
		clk_in : in std_logic;
		led : out std_logic_vector(7 downto 0)
	);
end mux_2to1_struct;

architecture behavior of mux_2to1_struct is

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
    
    -- 2-input AND component
    component and2
        port (
            i0, i1 : in std_logic;
            o : out std_logic
        );
    end component;

    -- 2-input OR component
    component or2
        port (
            i0, i1 : in std_logic;
            o : out std_logic
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

        --structural assignment
        and_0: and2 port map (
            i0 => x,
            i1 => (not s),
            o => and_out0
        );

        and_1: and2 port map (
            i0 => y,
            i1 => s,
            o => and_out1
        );

        or_0: or2 port map (
            i0 => and_out0,
            i1 => and_out1,
            o => m
        );

end behavior;
		

