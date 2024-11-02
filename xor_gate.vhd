library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Y : out STD_LOGIC);
end entity xor_gate;

architecture Behavioral of xor_gate is
begin
    Y <= not(A xor B);
end architecture Behavioral;