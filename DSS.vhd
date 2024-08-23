LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
USE lpm.lpm_components.std_logic_2D;
ENTITY DSS IS
	PORT
	(
		datain0	:	IN	STD_LOGIC_VECTOR(4 downto 0);
		datain1	:	IN	STD_LOGIC_VECTOR(4 downto 0);
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
	SIGNAL ROM_OUT : STD_LOGIC_VECTOR(7 downto 0);
	
	SIGNAL in_mux1 : STD_LOGIC_VECTOR(4 downto 0); -- Declare in_mux1
	SIGNAL mux_sel	: STD_LOGIC_VECTOR(0 downto 0);
	SIGNAL mux_out : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL shift_out: STD_LOGIC_VECTOR(2 downto 0);
	COMPONENT MUX
				PORT(
						in_mux0 :	in		STD_LOGIC_VECTOR(4 downto 0);
						in_mux1 :	in		STD_LOGIC_VECTOR(4 downto 0);
						sel :	in		STD_LOGIC_VECTOR(0 downto 0);
						mux_out:		out	STD_LOGIC_VECTOR(4 downto 0)
					);
	END COMPONENT;
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
				dataa => datain0,
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
		Mux_ASK: MUX
		PORT MAP
		(
			in_mux0 =>out_DFF,
			in_mux1 =>datain1,
			sel=>out_DFF1,
			mux_out=>mux_out
		);
		MyROM : LPMROM
			PORT MAP
			(
			address => mux_out,
			clock => clkin,
			q =>dataout
			);
		
		
		
	END mycomp;
 