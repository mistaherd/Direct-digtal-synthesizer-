LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
ENTITY LFSR IS
	PORT
	(
		clock		: 	IN		STD_LOGIC;
		dataout	: 	OUT	STD_LOGIC
	);
END ENTITY LFSR;
ARCHITECTURE comp OF LFSR IS
SIGNAL shiftreg_out	:	STD_LOGIC_VECTOR(9 downto 0);
SIGNAL LFSR_in			:	STD_LOGIC;
SIGNAL LFSR_out		:	STD_LOGIC;

BEGIN


LFSR_in<=not(shiftreg_out(6)xor shiftreg_out(3)xor shiftreg_out(1) xor shiftreg_out(0));
shift_reg: LPM_SHIFTREG
	GENERIC MAP
		(
			LPM_WIDTH=>10,
			LPM_DIRECTION =>"LEFT"
		)
	PORT MAP
		(	
			clock 	=>	clock,
			Q			=>	shiftreg_out,
			shiftin	=>	LFSR_in,
			shiftout	=>	LFSR_out
		);
dataout<=LFSR_out;
END comp;