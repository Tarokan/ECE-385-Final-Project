/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  testframeRAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
//logic [2:0] mem [0:399];

// range from h'0-37 (0-55)??, with 61016 rows of data 
logic [7:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/sprite_bytes/simple2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule
