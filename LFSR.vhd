LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
USE lpm.lpm_components.std_logic_2D;
ENTITY LFSR IS
	PORT
	(
		dataout	: 	OUT STD_LOGIC;
		clock : In STD_LOGIC
	);
END ENTITY LFSR;
ARCHITECTURE comp OF LFSR IS
SIGNAL reg	:	STD_LOGIC_VECTOR (9 downto 0);
SIGNAL reg_q : STD_LOGIC_VECTOR (9 downto 0);
X01:LPM_XOR
	GENERIC MAP
		(
			LPM_WIDTH =>1
		)
	PORT MAP
		(
			DATA		=>	(reg(9),reg(7)),
			RESULT	=>	reg(0)
		);
		reg(0)<='1'
shitreg: LPM_SHIFTREG
	GENERIC MAP
		(
			LPM_DIRECTION =>"RIGHT",
			LPM_TYPE="L_SHIFTREG"
		)
	PORT MAP
		(
			DATA	=>	reg
			Q		=>	reg_out
			
		);

END comp;