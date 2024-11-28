LIBRARY ieee  ; 
LIBRARY lpm  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_arith.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE lpm.LPM_COMPONENTS.all  ; 
USE std.textio.all  ; 
ENTITY DSS_TB  IS 
END ; 
 
ARCHITECTURE DSS_TB_arch OF DSS_TB IS
  SIGNAL  clkin         :   STD_LOGIC; 
  SIGNAL  data_port_A   :   STD_LOGIC_VECTOR(4 downto 0);
  --SIGNAL  data_port_B	:   STD_LOGIC_VECTOR(4 downto 0); 
  SIGNAL  LFSR_OUTPUT   :   STD_LOGIC;
  SIGNAL  LFSR_BUS		    :   STD_LOGIC_VECTOR(8 downto 0);
  SIGNAL  ASK_OUT      	:   STD_LOGIC_VECTOR(9 downto 0);
  SIGNAL  LUT_OUT      	:   STD_LOGIC_VECTOR(9 downto 0);
  COMPONENT DSS  
    PORT ( 
				data_port_A : IN  STD_LOGIC_VECTOR(4 downto 0);
				--data_port_B	: IN  STD_LOGIC_VECTOR(4 downto 0);
				clkin			    : IN   STD_LOGIC;
			  LFSR_OUTPUT : OUT  STD_LOGIC; 
				ASK_OUT		   :	OUT  STD_LOGIC_VECTOR(9 downto 0);
				LFSR_BUS    :	OUT  STD_LOGIC_VECTOR(8 downto 0);
				LUT_OUT		   :	OUT  STD_LOGIC_VECTOR(9 downto 0)
				--FSK_OUT		:	OUT STD_LOGIC_VECTOR(7 downto 0)
			);
      
  END COMPONENT ; 
  constant clk_period : time :=4 ns;
BEGIN
  DUT  : DSS  
    PORT MAP ( 
					clkin        =>  clkin,
					data_port_A  =>  data_port_A,
					--data_port_1	=>	data_port_1,
					--FSK_OUT		=>	FSK_OUT,
					LFSR_OUTPUT     =>  LFSR_OUTPUT,
					LFSR_BUS     =>  LFSR_BUS,
					ASK_OUT      =>  ASK_OUT,
					LUT_OUT      =>  LUT_OUT
				); 
 clk_process :process
   begin
		clkin <=  '0';
		wait for clk_period/2;
		clkin <=  '1';
		wait for clk_period/2;
   end process;
 
-- "Constant Pattern"
 --Start Time = 0 ns, End Time = 30 ns, Period = 0 ns
stimulus_process: Process
	Begin
	  
			data_port_A<=	"00010";
		--data_port_B<=	"00101";
		wait	for clk_period ;
		wait ;
	End Process;
END;




