LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
ENTITY PhasAccumulator is
	PORT
	(
		datain	:	IN	STD_LOGIC_VECTOR(4 downto 0);
		clkin		:	IN	STD_LOGIC;
		
		PA_out	: 	OUT	STD_LOGIC_VECTOR(4 downto 0);
	);
END ENTITY PhasAccumulator;
ARCHITECTURE mycomp1 OF DSS IS
begin
myADD :lpm_ADD_SUB
		GENERIC MAP
			(
				LPM_WIDTH =>5
			)
		PORT MAP
			(
				dataa => datain,
				datab => out_DFF,
				result=> out_ADD
			);
	
		myFF : lpm_FF
		GENERIC MAP
			(
				LPM_WIDTH =>5,
				LPM_FFTYPE => "DFF"
			)
		
		PORT MAP
			(
				DATA => out_ADD,
				CLOCK => clkin,
				Q => out_DFF
			);