library verilog;
use verilog.vl_types.all;
entity DSS_vlg_sample_tst is
    port(
        clkin           : in     vl_logic;
        data_port_0     : in     vl_logic_vector(4 downto 0);
        data_port_1     : in     vl_logic_vector(4 downto 0);
        sampler_tx      : out    vl_logic
    );
end DSS_vlg_sample_tst;
