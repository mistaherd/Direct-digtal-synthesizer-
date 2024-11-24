LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
ENTITY DSS IS
	PORT
	(
		data_port_A	:	IN		STD_LOGIC_VECTOR(4 downto 0);
		--data_port_B	:	IN		STD_LOGIC_VECTOR(4 downto 0);
		clkin			:	IN		STD_LOGIC;
		--FSK_OUT		:	OUT STD_LOGIC_VECTOR(7 downto 0)
		ASK_OUT		: 	OUT	STD_LOGIC_VECTOR(7 downto 0);
		LFSR_OUTPUT		:	OUT	STD_LOGIC;
		LUT_OUT		:	OUT	STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY DSS;	
ARCHITECTURE mycomp OF DSS IS
	COMPONENT LPMROM is
	  PORT (
				address :	in		std_logic_vector(4 downto 0);  -- Adjust address width as needed
				clock   :	in		std_logic;
				q       :	out	std_logic_vector(7 downto 0)  -- Adjust data width as needed
				);
	end COMPONENT;
	COMPONENT mux is
		PORT
		(
			data_port0	:	In STD_LOGIC_VECTOR(7 downto 0);
			sel			:	In STD_LOGIC;
			data_port1	:	In STD_LOGIC_VECTOR(7 downto 0);
			out_port		:	OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	end COMPONENT;

	SIGNAL clk_lfsrin	:	STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL shiftreg_out	:	STD_LOGIC_VECTOR(9 downto 0);
	SIGNAL LFSR_in			:	STD_LOGIC;
	SIGNAL LFSR_out		:	STD_LOGIC;
	SIGNAL ROM_OUT 	:	STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL out_ADD		:	STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL out_DFF		:	STD_LOGIC_VECTOR (4 downto 0);
	BEGIN 
	--PA
		myADD :lpm_ADD_SUB
			GENERIC MAP(
								LPM_WIDTH =>5
							)
			PORT MAP(
					dataa 	=>	data_port_A	,
					datab 	=> out_DFF,
					result	=> out_ADD
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
	
		--lut
		MyROM : LPMROM
		PORT MAP(
						address	=>out_DFF,
						clock		=>	clkin,
						q			=>	ROM_OUT
					);
			
		LUT_OUT<=ROM_OUT;
		
		-- clock divider
		counter: LPM_COUNTER
		GENERIC MAP(
							LPM_WIDTH	=>	8	
						)
		PORT MAP(
						clock	=>	clkin,
						q		=>	clk_lfsrin
					);
		--LFSR
		LFSR_in<=not(shiftreg_out(6)xor shiftreg_out(3)xor shiftreg_out(1) xor shiftreg_out(0));
		shift_reg: LPM_SHIFTREG
		GENERIC MAP
			(
				LPM_WIDTH=>10,
				LPM_DIRECTION =>"LEFT"
			)
		PORT MAP
			(	
				clock 	=>	clk_lfsrin(2),
				Q			=>	shiftreg_out,
				shiftin	=>	LFSR_in,
				shiftout	=>	LFSR_out
			);
	
		
		LFSR_OUTPUT<=LFSR_out;
		ASK_MUX	:MUX
		PORT MAP(
						data_port0	=>	ROM_OUT,
						sel			=>	LFSR_out,
						data_port1	=> "00000000",
						out_port		=>	ASK_OUT
					);
		--ASK_OUT<=ROM_OUT when out_lfsr0='1'else"00000000";
END mycomp;
 