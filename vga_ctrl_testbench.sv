module vga_ctrl_testbench();

timeunit 10ns;

timeprecision 1ns;

logic        CLOCK_50;
logic 		 Reset_h;

			
always begin : CLOCK_GENERATION

#1 CLOCK_50 = ~CLOCK_50;

end

initial begin : CLOCK_INITIALIZATION
	CLOCK_50 = 0;
end

initial begin: TEST_VECTORS
Reset_h = 1'b1;

#10
Reset_h = 1'b0;

#10 
Reset_h = 1'b1;
//SRAM_DQ = 16'b0;

end
endmodule
