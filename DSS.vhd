LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY lpm;
USE lpm.lpm_components.all;
USE lpm.lpm_components.std_logic_2D;
ENTITY DSS IS
	PORT
	(
		data_port_0	:	IN	STD_LOGIC_VECTOR(4 downto 0);
		data_port_1	:	IN	STD_LOGIC_VECTOR(4 downto 0);
		clkin			:	IN	STD_LOGIC;
		
		--FSK_OUT		:	OUT STD_LOGIC_VECTOR(7 downto 0)
		ASK_OUT		: 	OUT	STD_LOGIC_VECTOR(7 downto 0);
		LFSR_ASK		:	OUT	STD_LOGIC_VECTOR(4 downto 0);
		LUT_OUT		:	OUT	STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY DSS;	
ARCHITECTURE mycomp OF DSS IS
	SIGNAL out_lfsr	:	STD_LOGIC;
	SIGNAL out_lfsr1	:	STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL out_DFF1	:	STD_LOGIC_VECTOR(4 downto 0);
	
	SIGNAL in_PA		:	STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL out_PA		:	STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL clkdata		:	STD_LOGIC_VECTOR(0 downto 0);
	SIGNAL clk_sync	:	STD_LOGIC;
	SIGNAL ROM_OUT 	:	STD_LOGIC_VECTOR(7 downto 0);
	
	COMPONENT LPMROM
	  PORT (
				address : in std_logic_vector(4 downto 0);  -- Adjust address width as needed
				clock   : in std_logic;
				q       : out std_logic_vector(7 downto 0)  -- Adjust data width as needed
				);
	end COMPONENT;
	COMPONENT  LFSR
		PORT (
					clock		:	IN		STD_LOGIC;
					dataout	: 	OUT	STD_LOGIC
				);
	end COMPONENT ;
	COMPONENT PhaseAccumulator
	PORT (
				FSW		:	IN	STD_LOGIC_VECTOR(4 downto 0);
				clock		:	IN	STD_LOGIC;
				PA_out	: 	OUT	STD_LOGIC_VECTOR(4 downto 0)
			);
	end COMPONENT;
	COMPONENT mux
		PORT
		(
			data_port0	:	In STD_LOGIC_VECTOR(7 downto 0);
			sel			:	In STD_LOGIC;
			data_port1	:	In STD_LOGIC_VECTOR(7 downto 0);
			out_port		:	OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	end COMPONENT;
	COMPONENT LFSR1
		PORT
		(
			clock		: 	IN		STD_LOGIC;
			dataout	: 	OUT	STD_LOGIC_VECTOR(4 downto 0)
		);
	end COMPONENT;
	COMPONENT NC0
		PORT
			(
				clock		:	IN		STD_LOGIC;
				output	:	OUT	STD_LOGIC_VECTOR(4 downto 0)
			);
	end COMPONENT;
	BEGIN 
		--FSK_LFSR	:	LFSR
			--PORT MAP (
							--clock		=>	clkin,
							--dataout	=>	out_lfsr
						--);
		--FSK_MUX	:	mux
			--PORT MAP(
				--data_port0	=> data_port_0;
				--sel			=>	out_lfsr;
				--data_port1	=> data_port_1;
				--out_port		=> in_PA
			--);
		-- uncomment this below for ask 
		ASK_LFSR	:	LFSR1
		PORT MAP(
						clock		=>	clkin,
						dataout	=>	out_lfsr1
					);
		LFSR_ASK<=out_lfsr1;
		mypa	:	PhaseAccumulator
			PORT MAP (
							--FSW		=>	in_PA,
							FSW		=>	data_port_0,
							clock		=>	clkin,
							PA_out	=>	out_PA
						);
			
		FF1		:	lpm_FF
			GENERIC MAP
				(
					LPM_WIDTH =>5,
					LPM_FFTYPE =>"DFF"
				)
			
			PORT MAP
				(
					DATA=>out_PA,
					CLOCK =>clkin,
					Q=>out_DFF1
				);
		

		MyROM : LPMROM
			PORT MAP
				(
					address => out_lfsr1,
					clock => clkin,
					q =>ROM_OUT
				);
			
			LUT_OUT<=ROM_OUT;
			ASK_MUX	:	mux
			PORT MAP(
							data_port0	=> ROM_OUT,
							sel			=>	out_DFF1(0),
							data_port1	=> "00000000",
							out_port		=> ASK_OUT
						);
			
END mycomp;
 