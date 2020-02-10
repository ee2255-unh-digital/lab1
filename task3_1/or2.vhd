library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or2 is
port (
		i0, i1 : in std_logic;
		o : out std_logic
	);
end or2;

architecture behavior of or2 is

    begin
        o <= i0 or i1;

end behavior;