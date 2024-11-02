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
		
		FSK_OUT		:	OUT STD_LOGIC_VECTOR(7 downto 0)
		--ASK_OUT		: 	OUT	STD_LOGIC_VECTOR(7 downto 0);
		--LUT_OUT		:	OUT	STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY DSS;	
ARCHITECTURE mycomp OF DSS IS
	SIGNAL out_lfsr	:	STD_LOGIC;
	SIGNAL in_PA		:	STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL out_PA		:	STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL out_DFF1	:	STD_LOGIC_VECTOR (4 downto 0);
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
	BEGIN 
		myLFSR	:	LFSR
			PORT MAP (
							clock=>clkin,
							dataout=>out_lfsr
						);
		in_PA<=data_port_0 when out_lfsr='1'else data_port_1;
		mypa		: PhaseAccumulator
			PORT MAP (
							FSW =>in_PA,
							clock=>clkin,
							PA_out=>out_PA
						);
			
			
			--clk_sync <=clkin;

			--clkdata(0)<=clk_sync;
		--FF1		:	lpm_FF
			--GENERIC MAP
			--(
				--LPM_WIDTH =>5,
				--LPM_FFTYPE =>"DFF"
			--)
			
			--PORT MAP
			--(
				--DATA=>out_PA,
				--CLOCK =>clkin,
				--Q=>out_DFF1
			--);
		
			
			MyROM : LPMROM
				PORT MAP
				(
					address => out_PA,
					clock => clkin,
					q =>FSK_OUT
				);
			
			--LUT_OUT<=ROM_OUT;
		
			--ASK_OUT<=ROM_OUT when out_DFF1(1)='1'else"00000000";
END mycomp;
 