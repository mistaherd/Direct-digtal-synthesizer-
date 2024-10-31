LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
USE lpm.lpm_components.std_logic_2D;
ENTITY LFSR IS
	PORT
	(
		dataout	: 	OUT STD_LOGIC
	);
END ENTITY LFSR;
ARCHITECTURE comp OF LFSR IS
SIGNAL reg	:	STD_LOGIC_VECTOR (9 downto 0);
SIGNAL reg_q : STD_LOGIC_VECTOR (9 downto 0);
COMPONENT xor_gate
	PORT (
			A	: in std_logic;  -- Adjust address width as needed
			B	: in std_logic;
			Y	: out std_logic-- Adjust data width as needed
			);
end COMPONENT;
BEGIN
xo1:xor_gate
PORT MAP (
	A=>reg(9),
	B=>reg(7),
	Y=>reg(0)
);
reg(0)<=not(reg(0));
shift_reg: LPM_SHIFTREG
	GENERIC MAP
		(
			LPM_WIDTH=>10,
			LPM_DIRECTION =>"RIGHT",
			LPM_TYPE=>"L_SHIFTREG"
		)
	PORT MAP
		(
			DATA	=>	reg,
			Q		=>	reg_q
			
		);
dataout<=reg_q(9);
END comp;