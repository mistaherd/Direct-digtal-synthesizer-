library verilog;
use verilog.vl_types.all;
entity DSS_vlg_check_tst is
    port(
        ASK_OUT         : in     vl_logic_vector(7 downto 0);
        LUT_OUT         : in     vl_logic_vector(7 downto 0);
        PA              : in     vl_logic_vector(4 downto 0);
        sampler_rx      : in     vl_logic
    );
end DSS_vlg_check_tst;
