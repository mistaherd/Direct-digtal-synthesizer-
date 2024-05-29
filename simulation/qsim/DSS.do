onerror {quit -f}
vlib work
vlog -work work DSS.vo
vlog -work work DSS.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.DSS_vlg_vec_tst
vcd file -direction DSS.msim.vcd
vcd add -internal DSS_vlg_vec_tst/*
vcd add -internal DSS_vlg_vec_tst/i1/*
add wave /*
run -all
