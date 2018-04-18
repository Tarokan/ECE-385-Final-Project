// TODO

module testbench();

timeunit 10ns;

timeprecision 1ns;

logic           CLK;
logic           RESET;
logic ENABLE, DRAW_READY, FD_WE_N;
logic [19:0] WRITEADDR;
logic [15:0] DATA;

logic [3:0] state;

frame_drawer fd(.CLK(CLK),
					.RESET(RESET),
					.ENABLE(ENABLE),
					.DRAW_READY(DRAW_READY),
					.WRITEADDR(WRITEADDR),
					.DATA(DATA),
					.FD_WE_N(FD_WE_N));

assign state = fd.State;
					
always begin : CLOCK_GENERATION

#1 CLK = ~CLK;

end

initial begin : CLOCK_INITIALIZATION
	CLK = 0;
end

initial begin: TEST_VECTORS
RESET = 1;

#5
RESET = 0;
ENABLE = 1'b1;
DRAW_READY = 1'b0;

#5
ENABLE = 1'b0;
DRAW_READY = 1'b1;

#500000
DRAW_READY = 1'b0;

#100000
DRAW_READY = 1'b1;

#500000
ENABLE = 1'b1;

#100000
ENABLE = 1'b0;


end
endmodule
