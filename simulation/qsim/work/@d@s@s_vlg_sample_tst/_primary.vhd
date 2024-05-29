library verilog;
use verilog.vl_types.all;
entity DSS_vlg_sample_tst is
    port(
        clkin           : in     vl_logic;
        datain          : in     vl_logic_vector(4 downto 0);
        sampler_tx      : out    vl_logic
    );
end DSS_vlg_sample_tst;
