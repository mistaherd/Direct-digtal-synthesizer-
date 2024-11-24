transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {DSS.vo}

vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/simulation/modelsim/DSS_TB.vhd}

vsim -t 1ps -L altera_ver -L cycloneiii_ver -L gate_work -L work -voptargs="+acc"  DSS_tb

add wave *
view structure
view signals
run -all
