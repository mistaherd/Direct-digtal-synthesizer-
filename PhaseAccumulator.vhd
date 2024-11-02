LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
ENTITY PhaseAccumulator is
	PORT
	(
		FSW	:	IN	STD_LOGIC_VECTOR(4 downto 0);
		clock	:	IN	STD_LOGIC;
		
		PA_out	: 	OUT	STD_LOGIC_VECTOR(4 downto 0)
	);
END ENTITY PhaseAccumulator;
ARCHITECTURE mycomp OF PhaseAccumulator IS
	SIGNAL out_ADD		:	STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL out_DFF		:	STD_LOGIC_VECTOR (4 downto 0);
	begin
	myADD :lpm_ADD_SUB
		GENERIC MAP
			(
				LPM_WIDTH =>5
			)
		PORT MAP
			(
				dataa => FSW,
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
				CLOCK => clock,
				Q => out_DFF
			);
	PA_out<=out_DFF;
end mycomp ;