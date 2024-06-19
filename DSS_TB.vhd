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
  SIGNAL clkin		:  STD_LOGIC; 
  SIGNAL datain	:  std_logic_vector (4 downto 0)  ; 
  SIGNAL dataout	:  std_logic_vector (7 downto 0)  ; 
  SIGNAL testout	:	std_logic_vector(4 downto 0);
  COMPONENT DSS  
    PORT ( 
      clkin  : in STD_LOGIC ; 
      datain  : in std_logic_vector (4 downto 0) ; 
      dataout  : out std_logic_vector (7 downto 0) ; 
		testout	: out std_logic_vector(4 downto 0));
  END COMPONENT ; 
  constant clk_period : time :=10 ns;
BEGIN
  DUT  : DSS  
    PORT MAP ( 
      clkin   => clkin  ,
      datain   => datain  ,
		testout => testout ,
      dataout   => dataout   ); 
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
			datain  <= "00010"  ;
			--wait for	clk_period ;

			wait for 30 ns;
		End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 100 ns
END;
