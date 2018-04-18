//---------------------------------------------
//  DrawEngine.sv
//  Nick Leung
//  Fall 2017
//---------------------------------------------


module DrawEngine( input logic vga_blank,
						 output logic [19:0] SRAM_address,
						 inout logic [15:0] SRAM_data,
						 output logic SRAM_lower,
						 output logic SRAM_upper,
						 output logic SRAM_chip,
						 output logic SRAM_write,
						 output logic SRAM_output );

logic [12:0]
						 
always_comb:
		
		if(vga_blank == 1'b0)
		begin
			