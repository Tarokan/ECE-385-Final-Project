module ram_testbench();

timeunit 10ns;

timeprecision 1ns;

logic        Clk;
logic [5:0] data_In;
logic [18:0] write_address, read_address;
logic we;
logic [7:0] data_Out;

frameRAM frameRAM_instance(.*);
			
always begin : CLOCK_GENERATION

#1 Clk = ~Clk;

end

initial begin : CLOCK_INITIALIZATION
	Clk = 0;
end

always begin : address_increment

#5 read_address = read_address + 1;

end

initial begin: TEST_VECTORS
data_In = 6'b0;
write_address = 19'b0;
read_address = 19'b0;
we = 1'b0;
//SRAM_DQ = 16'b0;
end
endmodule
