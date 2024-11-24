library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
    Port ( A	:	in	STD_LOGIC;
           B	:	in	STD_LOGIC;
			  C	:	in	STD_LOGIC;
			  D	:	in	STD_LOGIC;
           Y : out STD_LOGIC);
end entity xor_gate;

architecture Behavioral of xor_gate is
begin
    Y <= not(A xor B xor C xor D );
end architecture Behavioral;