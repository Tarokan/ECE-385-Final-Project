/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

logic [7:0] mem [0:76799];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/sprite_bytes/tilemap12.9b.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/sprite_bytes/tilemap12.9b.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  map1RAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [11:0] data_Out
);

logic [11:0] mem [0:1199];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/maps/map1.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/maps/map1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule
module  map2RAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [11:0] data_Out
);

logic [11:0] mem [0:1199];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/maps/map2.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/maps/map2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  map3RAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [11:0] data_Out
);

logic [11:0] mem [0:1199];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/maps/map3.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/maps/map3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  map4RAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [11:0] data_Out
);

logic [11:0] mem [0:1199];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/maps/map4.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/maps/map4.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  map5RAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [11:0] data_Out
);

logic [11:0] mem [0:1199];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/maps/map5.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/maps/map5.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  mapOverRAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [11:0] data_Out
);

logic [11:0] mem [0:1199];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/maps/map5.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/maps/gameovermap.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  playerRAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

logic [7:0] mem [0:5099];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/sprite_bytes/char.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/sprite_bytes/char.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  fontRAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

logic [7:0] mem [0:24575];

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/sprite_bytes/font.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/sprite_bytes/font.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule


module  pokemonRAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

logic [7:0] mem [0:23039];  //change this too

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/sprite_bytes/newpokemon.txt", mem);
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/sprite_bytes/newpokemon.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  HPBarsRAM
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

logic [7:0] mem [0:8399];  //change this too

initial
begin
	 //$readmemh("C:/Users/leung/OneDrive/Documents/ECE_385/Final/finalproject/sprite_bytes/hpbars.txt", mem); 
	 $readmemh("C:/Users/zhao106/Desktop/Final-Project/sprite_bytes/hpbars.txt", mem); 
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

