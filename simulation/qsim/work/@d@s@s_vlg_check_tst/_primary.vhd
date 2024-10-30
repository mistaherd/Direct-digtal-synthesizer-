library verilog;
use verilog.vl_types.all;
entity DSS_vlg_check_tst is
    port(
        dataout         : in     vl_logic_vector(7 downto 0);
        testout         : in     vl_logic_vector(0 downto 0);
        testout1        : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end DSS_vlg_check_tst;
