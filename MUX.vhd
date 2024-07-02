library IEEE;
use IEEE.std_logic_1164.all;

entity MUX is
port(
  in_mux0	:	in		std_logic_vector(4 downto 0);
  in_mux1	:	in		std_logic_vector(4 downto 0);
  sel			:	in		std_logic_vector(0 downto 0);
  mux_out	:	out	std_logic_vector(4 downto 0));
end MUX;

architecture rtl of MUX is
  -- declarative part: empty
begin

p_mux : process(in_mux0,in_mux1,sel)
begin
  case sel is
    when "1" => mux_out <= in_mux0;
    
   
    when others => mux_out <= in_mux1 ;
  end case;
end process p_mux;

end rtl;