/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0 : Player Coordinates (Top 8: x, Bottom 8: y)
 1	: Player Info (First two bits - direction: 11 = left, 01 = right 10 = up, 00 = down)(Third bit: Redraw/Change in coordinates)
	  (Fourth bit: Encounter true/false)(5-7 bits: Map ID)
	  4th bit: 0 - frame_drawer, 1 - battle_drawer
 2	: Encounter Enemy (Top 8: Health, Bottom 8: ID)
 3	: Current Pokemon (Top 8: Health, Bottom 8: ID)
 4	: Inventory1 (Top 8: Pokeballs, Bottom 8: Potion)
 5	: Inventory2 (Top 8: Revive, Bottom 8: PP UP)
 6	: Dialogue text (ID, 0 for no text)
 7	: ???
************************************************************************/

module avalon_interface (
	// Avalon Clock Input
	input logic CLK,

	// Avalon Reset Input
	input logic RESET,

	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [15:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [15:0] AVL_READDATA,	// Avalon-MM Read Data

	// Exported Conduit
	output logic [255:0] EXPORT_DATA
);

	logic [15:0] register_file[16];

	always_ff @ (posedge CLK) begin
		if(RESET) begin
			for(int i = 0; i< 16; i++) begin
				register_file[i] <= 15'b0;
			end
		end
		else if(AVL_WRITE && AVL_CS) begin
			register_file[AVL_ADDR][15:0] <= AVL_WRITEDATA[15:0];
		end
	end

	always_comb begin
		if(AVL_READ)
			AVL_READDATA = register_file[AVL_ADDR];
		else
			AVL_READDATA = 16'b0;
	end

	assign EXPORT_DATA = {register_file[15][15:0],register_file[14][15:0],
                        register_file[13][15:0],register_file[12][15:0],
                        register_file[11][15:0],register_file[10][15:0],
                        register_file[9][15:0],register_file[8][15:0],
                        register_file[7][15:0],register_file[6][15:0],
                        register_file[5][15:0],register_file[4][15:0],
                        register_file[3][15:0],register_file[2][15:0],
                        register_file[1][15:0], register_file[0][15:0]};

endmodule
