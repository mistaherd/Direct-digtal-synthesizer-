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
	SIGNAL out_ADD : STD_LOGIC_VECTOR (4 downto 0);
	
	SIGNAL out_DFF : STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL out_DFF1: STD_LOGIC_VECTOR(0 downto 0);
	SIGNAL out_DFF2: STD_LOGIC_VECTOR(0 downto 0);
	SIGNAL clkdata : STD_LOGIC_VECTOR(0 downto 0);
	SIGNAL out_MUX : STD_LOGIC_VECTOR (4 downto 0);
	type array2d is array(1 downto 0) of std_logic_vector(4 downto 0);
	SIGNAL in_mux_arry : array2d;
	COMPONENT LPMROM
	  PORT (
				address : in std_logic_vector(4 downto 0);  -- Adjust address width as needed
				clock   : in std_logic;
				q       : out std_logic_vector(7 downto 0)  -- Adjust data width as needed
				);
	end COMPONENT;

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
		clkdata(0)<=clkin;
		FF1:lpm_FF
		GENERIC MAP
		(
			LPM_WIDTH =>1,
			LPM_FFTYPE =>"DFF"
		)
		PORT MAP
		(
			DATA=>clkdata,
			CLOCK =>clkin,
			Q=>out_DFF1
		);
		FF2:lpm_FF
		GENERIC MAP
		(
			LPM_WIDTH =>1,
			LPM_FFTYPE =>"DFF"
		)
		PORT MAP
		(
			DATA=>out_DFF1,
			CLOCK =>clkin,
			Q=>out_DFF2
		);
		in_mux_arry(0) <= (others => '0');
		in_mux_arry(1) <=out_DFF;
		MYMuX:lpm_MUX
		GENERIC MAP
		(
			LPM_WIDTH =>1,
			LPM_SIZE =>5,
			LPM_WIDTHS=>2
		)
		PORT MAP
		(
			Data=>in_mux_arry,
			Sel=>out_DFF2,
			Result=>out_MUX
		);
		
		MyROM : LPMROM
			PORT MAP
			(
			address => out_MUX,
			clock => clkin,
			q =>dataout
			);
	END mycomp;
 