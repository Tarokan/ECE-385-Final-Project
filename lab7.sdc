#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {main_clk_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {nios_system|sdram_pll|sd1|pll7|clk[0]} -source [get_pins {nios_system|sdram_pll|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -phase -54.000 -master_clock {main_clk_50} [get_pins {nios_system|sdram_pll|sd1|pll7|clk[0]}] 
create_generated_clock -name {nios_system|sdram_pll|sd1|pll7|clk[1]} -source [get_pins {nios_system|sdram_pll|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -phase -54.000 -master_clock {main_clk_50} [get_pins {nios_system|sdram_pll|sd1|pll7|clk[1]}] 

