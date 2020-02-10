library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and2 is
port (
		i0, i1 : in std_logic;
		o : out std_logic
	);
end and2;

architecture behavior of and2 is

    begin
        o <= i0 and i1;

end behavior;