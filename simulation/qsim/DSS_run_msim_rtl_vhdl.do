transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/DSS.vhd}
vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/LPMROM.vhd}
vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/LFSR.vhd}
vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/xor_gate.vhd}
vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/PhaseAccumulator.vhd}
vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/mux.vhd}
vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/nclkdlivder.vhd}

vcom -93 -work work {C:/Users/lanzb/Documents/Github/Direct-digtal-synthesizer-/simulation/modelsim/DSS_TB.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiii -L rtl_work -L work -voptargs="+acc"  DSS_tb

add wave *
view structure
view signals
run -all
