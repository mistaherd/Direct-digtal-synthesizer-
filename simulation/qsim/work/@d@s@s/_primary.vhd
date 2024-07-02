library verilog;
use verilog.vl_types.all;
entity DSS is
    port(
        datain0         : in     vl_logic_vector(4 downto 0);
        datain1         : in     vl_logic_vector(4 downto 0);
        clkin           : in     vl_logic;
        dataout         : out    vl_logic_vector(7 downto 0);
        testout         : out    vl_logic_vector(4 downto 0)
    );
end DSS;
