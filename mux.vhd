LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
ENTITY mux IS
	PORT
	(
		data_port0	:	In STD_LOGIC_VECTOR(7 downto 0);
		sel			:	In STD_LOGIC;
		data_port1	:	In STD_LOGIC_VECTOR(7 downto 0);
		out_port		:	OUT STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY mux;
ARCHITECTURE mycomp OF mux IS
BEGIN	
	PROCESS(sel,data_port0,data_port1)
	BEGIN
		if sel = '1' then
			out_port	<=	data_port0;
		else
			out_port	<=	data_port1;
		end if;
	END PROCESS;
END mycomp;