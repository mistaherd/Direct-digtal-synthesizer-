library verilog;
use verilog.vl_types.all;
entity DSS is
    port(
        data_port_A     : in     vl_logic_vector(4 downto 0);
        clkin           : in     vl_logic;
        ASK_OUT         : out    vl_logic_vector(7 downto 0);
        PA_out          : out    vl_logic_vector(4 downto 0);
        LFSR_OUTPUT     : out    vl_logic;
        LFSR_BUS        : out    vl_logic_vector(8 downto 0);
        LUT_OUT         : out    vl_logic_vector(7 downto 0)
    );
end DSS;
