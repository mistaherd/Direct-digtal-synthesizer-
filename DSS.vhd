LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;




ENTITY DSS IS
	PORT
	(
		datain	:	IN	STD_LOGIC_VECTOR(4 downto 0);
		clkin		:	IN	STD_LOGIC;
		
		dataout	: 	OUT	STD_LOGIC_VECTOR(7 downto 0);
		testout	:	OUT	STD_LOGIC_VECTOR(4 downto 0)
	);
	END ENTITY DSS;
	
	ARCHITECTURE mycomp OF DSS IS
	SIGNAL out_ADD	: STD_LOGIC_VECTOR (4 DOWNTO 0);
	
	SIGNAL out_DFF	: STD_LOGIC_VECTOR (4 DOWNTO 0);
	
	BEGIN
		
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
		testout<=out_DFF;
		MyROM : LPMROM
			PORT MAP
			(
			address => out_DFF,
			clock => clkin,
			q =>dataout
			);
	END mycomp;
 