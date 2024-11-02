library verilog;
use verilog.vl_types.all;
entity DSS is
    port(
        data_port_0     : in     vl_logic_vector(4 downto 0);
        data_port_1     : in     vl_logic_vector(4 downto 0);
        clkin           : in     vl_logic;
        FSK_OUT         : out    vl_logic_vector(7 downto 0)
    );
end DSS;
