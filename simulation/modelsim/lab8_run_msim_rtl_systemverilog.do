transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/sram2.v}
vlib nios_system
vmap nios_system nios_system
vlog -sv -work nios_system +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/nios_system/synthesis/submodules {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/nios_system/synthesis/submodules/avalon_interface.sv}
vlog -sv -work work +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/VGA_controller.sv}
vlog -sv -work work +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/frame_drawer.sv}
vlog -sv -work work +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/ram.sv}
vlog -sv -work work +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/testsystem.sv}
vlog -sv -work work +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/battle_drawer.sv}

vlog -sv -work work +incdir+C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject {C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/testsystem_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L nios_system -voptargs="+acc"  testsystem_testbench

add wave *
view structure
view signals
run 1 us
