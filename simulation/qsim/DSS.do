onerror {exit -code 1}
vlib work
vlog -work work DSS.vo
vlog -work work romtest.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.DSS_vlg_vec_tst -voptargs="+acc"
vcd file -direction DSS.msim.vcd
vcd add -internal DSS_vlg_vec_tst/*
vcd add -internal DSS_vlg_vec_tst/i1/*
run -all
quit -f
