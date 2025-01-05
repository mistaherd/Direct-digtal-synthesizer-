LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
ENTITY DSS IS
	PORT
	(
		--- we dont want 2^n<2^p of lut
		data_port_A	:	IN		STD_LOGIC_VECTOR(4 downto 0);
		data_port_B	:	IN		STD_LOGIC_VECTOR(4 downto 0);
		clkin			:	IN		STD_LOGIC;
		FSK_OUT		:	OUT STD_LOGIC_VECTOR(7 downto 0);
		--ASK_OUT		: 	OUT	STD_LOGIC_VECTOR(7 downto 0);
		PA_out		:	OUT	STD_LOGIC_VECTOR(4 downto 0);
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

	SIGNAL clk_lfsrin			:	STD_LOGIC_VECTOR(8 downto 0);
	SIGNAL shiftreg_ask_out	:	STD_LOGIC_VECTOR(8 downto 0);
	SIGNAL LFSR_ask_in		:	STD_LOGIC;
	SIGNAL LFSR_ask_out		:	STD_LOGIC;
	SIGNAL shiftreg_FSK_out	:	STD_LOGIC_VECTOR(8 downto 0);
	SIGNAL LFSR_FSK_in		:	STD_LOGIC;
	SIGNAL LFSR_FSK_out		:	STD_LOGIC;
	SIGNAL ROM_OUT 			:	STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL PA_IN				:	STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL out_ADD				:	STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL out_DFF				:	STD_LOGIC_VECTOR(4 downto 0);
	BEGIN 
		LFSR_FSK_in<=not(shiftreg_FSK_out(8) xor shiftreg_FSK_out(4)xor shiftreg_FSK_out(0));
		shift_FSK_reg: LPM_SHIFTREG
		GENERIC MAP
			(
				LPM_WIDTH=>9,
				LPM_DIRECTION =>"RIGHT"
			)
		PORT MAP
			(	
				clock 	=>	clkin,
				Q			=>	shiftreg_FSK_out,
				shiftin	=>	LFSR_FSK_in,
				shiftout	=>	LFSR_FSK_out
			);
	process(LFSR_FSK_out)
		begin
		if (LFSR_FSK_out= '1') then
			PA_IN	<=	data_port_A;
		else
			PA_IN	<=data_port_B;
		end if;
	end process;
	--PA
		myADD :lpm_ADD_SUB
			GENERIC MAP(
								LPM_WIDTH =>5
							)
			PORT MAP(
					dataa 	=>	PA_IN,
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
		Pa_out<=out_DFF;
		--lut
		MyROM : LPMROM
		PORT MAP(
						address	=>out_DFF,
						clock		=>	clkin,
						q			=>	ROM_OUT
					);
			
		LUT_OUT<=ROM_OUT;
		FSK_OUT<=ROM_OUT;
		--p6
		-- clock divider
		--counter_ask: LPM_COUNTER
		--GENERIC MAP(
							--LPM_WIDTH	=>	9	
						--)
		--PORT MAP(
						--clock	=>	clkin,
						--q		=>	clk_lfsrin
					--);
		--LFSR ask 
		--LFSR_ask_in<=not(shiftreg_ask_out(8) xor shiftreg_ask_out(4)xor shiftreg_ask_out(0));
		--shift_ask_reg: LPM_SHIFTREG
		--GENERIC MAP
			--(
				--LPM_WIDTH=>9,
				--LPM_DIRECTION =>"RIGHT"
			--)
		--PORT MAP
			--(	
				--clock 	=>	clk_lfsrin(1),
				--Q			=>	shiftreg_ask_out,
				--shiftin	=>	LFSR_ask_in,
				--shiftout	=>	LFSR_ask_out
			--);
		
		--process(LFSR_ask_out)
		--begin
		--if (LFSR_ask_out= '1') then
			--ASK_OUT	<=	ROM_OUT;
		--else
			--ASK_OUT	<=	"00000000";
		--end if;
		--end process;
END mycomp;
 