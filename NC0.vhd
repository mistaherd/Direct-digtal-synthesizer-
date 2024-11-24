LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
--clock is 5ns
ENTITY NC0 is
	Port
		(
			clock		:	IN	STD_LOGIC;
			output	:	OUT STD_LOGIC_VECTOR(4 downto 0)
		);
END ENTITY NC0;
ARCHITECTURE mycomp OF NC0 IS

COMPONENT  LFSR1
		PORT (
					clock		:	IN		STD_LOGIC;
					dataout	: 	OUT	STD_LOGIC_VECTOR(4 downto 0)
				);
end COMPONENT ;

BEGIN
	myLFSR	:	LFSR1
		PORT MAP (
						clock=>clock,
						dataout=>output
					);

end mycomp;
