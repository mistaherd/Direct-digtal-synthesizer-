transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/MWT2/DSS/DSS.vhd}
vcom -93 -work work {C:/MWT2/DSS/LPMROM.vhd}

vcom -93 -work work {C:/MWT2/DSS/simulation/modelsim/DSS_TB.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiii -L rtl_work -L work -voptargs="+acc"  DSS_tb

add wave *
view structure
view signals
run -all
