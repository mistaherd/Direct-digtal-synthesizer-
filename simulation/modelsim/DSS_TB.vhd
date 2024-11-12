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
  SIGNAL  clkin			:   STD_LOGIC; 
  SIGNAL  data_port_0	:   STD_LOGIC_VECTOR(4 downto 0);
  SIGNAL  data_port_1	:   STD_LOGIC_VECTOR(4 downto 0);
  SIGNAL  LFSR_ASK	:   STD_LOGIC_VECTOR(4 downto 0);
  --SIGNAL FSK_OUT      :  STD_LOGIC_VECTOR(7 downto 0); 
  SIGNAL  ASK_OUT      	:  STD_LOGIC_VECTOR(7 downto 0);
  SIGNAL  LUT_OUT      	:  STD_LOGIC_VECTOR(7 downto 0);
  COMPONENT DSS  
    PORT ( 
				data_port_0		: 	IN  	STD_LOGIC_VECTOR(4 downto 0);
				data_port_1		: 	IN  	STD_LOGIC_VECTOR(4 downto 0);
				clkin			   :	IN  	STD_LOGIC;
				ASK_OUT		   :	OUT 	STD_LOGIC_VECTOR(7 downto 0);
				LUT_OUT		   :	OUT 	STD_LOGIC_VECTOR(7 downto 0);
				LFSR_ASK			:	OUT	STD_LOGIC_VECTOR(4 downto 0)
				--FSK_OUT		:	OUT STD_LOGIC_VECTOR(7 downto 0)
			);
      
  END COMPONENT ; 
  constant clk_period : time :=2 ns;
BEGIN
  DUT  : DSS  
    PORT MAP ( 
					clkin			=>	clkin,
					data_port_0	=>	data_port_0,
					data_port_1	=>	data_port_1,
					--FSK_OUT		=>	FSK_OUT
					ASK_OUT  =>  ASK_OUT,
					LUT_OUT  => LUT_OUT,
					LFSR_ASK => LFSR_ASK
				); 
 clk_process :process
   begin
		clkin <= '0';
		wait for clk_period/2;
		clkin <= '1';
		wait for clk_period/2;
   end process;
 
-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 1 us, Period = 0 ns
	stimulus_process: Process
		Begin
		  wait	for clk_period ;
		    data_port_0<=	"00010";
		    data_port_1<=	"00101";
			

		  wait ;
		End Process;
END;


