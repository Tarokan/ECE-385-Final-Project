module testsystem_testbench();

timeunit 10ns;

timeprecision 1ns;

logic        CLOCK_50;
logic [3:0]  KEY;          //bit 0 is set up as Reset

logic [7:0]  VGA_R,        //VGA Red
             VGA_G,        //VGA Green
             VGA_B;        //VGA Blue
logic        VGA_CLK,      //VGA Clock
             VGA_SYNC_N,   //VGA Sync signal
             VGA_BLANK_N,  //VGA Blank signal
             VGA_VS,       //VGA virtical sync signal
             VGA_HS;       //VGA horizontal sync signal
logic [7:0] ocm_data_out;

logic [19:0] SRAM_ADDR;	// SRAM Address 20 Bits
wire [15:0] SRAM_DQ;			// SRAM Data 16 Bits
logic 	SRAM_CE_N,			// SRAM Chip Enable
			SRAM_LB_N,			// SRAM Lower Byte Enable (?)
			SRAM_OE_N,			// SRAM Output Enable(?)
			SRAM_UB_N,			// SRAM Upper Byte Enable (?)
			SRAM_WE_N;			// SRAM Write Enable (?)

logic [19:0] fd_address, address, bd_address;
logic [3:0] fd_state;
logic [5:0] bd_state;
logic SRAM_enable, SRAM_WE_CTRL;
//logic [2:0] sram_ctrl_state;
//logic [9:0] vga_ctrl_hcount, vga_ctrl_vcount;
logic [20:0] fd_tileCount_out, fd_tilePixelCountH_out, fd_tilePixelCountV_out;
logic [18:0] fd_ocm_address, fd_font_ocm_address;
logic [7:0] ocm_data, fd_font_ocm_data;
logic [15:0] to_sram_data;
logic [7:0] fd_map_ocm_data, bd_hpbars_ocm_data;
logic [18:0] fd_map_ocm_address, bd_hpbars_ocm_address;
logic [19:0] bd_UIBarsPixelCount, bd_UIBars2PixelCount, bd_UIPokePixelCount;
logic [15:0] bd_data;
testsystem testsystem_instance(.*);


assign bd_data = testsystem_instance.battle_drawer_instance.data;
assign fd_address = testsystem_instance.fd_address;
assign address = testsystem_instance.fd_address;
assign fd_state = testsystem_instance.frame_drawer_instance.State;
assign bd_state = testsystem_instance.battle_drawer_instance.State;
assign SRAM_enable = testsystem_instance.enable;
assign SRAM_WE_CTRL = testsystem_instance.SRAM_WE_CTRL;
assign ocm_data = testsystem_instance.ocm_data;

assign bd_address = testsystem_instance.battle_drawer_instance.address;
assign bd_hpbars_ocm_data = testsystem_instance.battle_drawer_instance.hpbars_ocm_data;
assign bd_hpbars_ocm_address = testsystem_instance.battle_drawer_instance.hpbars_ocm_address;

assign fd_font_ocm_address = testsystem_instance.frame_drawer_instance.font_ocm_address;
assign fd_font_ocm_data = testsystem_instance.frame_drawer_instance.font_ocm_data;


assign fd_tileCount_out = testsystem_instance.frame_drawer_instance.tileCount_out;
assign fd_tilePixelCountH_out = testsystem_instance.frame_drawer_instance.tilePixelCountH_out;
assign fd_tilePixelCountV_out = testsystem_instance.frame_drawer_instance.tilePixelCountV_out;
assign fd_ocm_address = testsystem_instance.frame_drawer_instance.ocm_address;
assign fd_map_ocm_data = testsystem_instance.frame_drawer_instance.map_ocm_data;
assign fd_map_ocm_address = testsystem_instance.frame_drawer_instance.map_ocm_address;
assign bd_UIBarsPixelCount = testsystem_instance.battle_drawer_instance.UIBarsPixelCount_out;
assign bd_UIBars2PixelCount = testsystem_instance.battle_drawer_instance.UIBars2PixelCount_out;
assign bd_UIPokePixelCount = testsystem_instance.battle_drawer_instance.PokePixelCount_out;

assign to_sram_data = testsystem_instance.data;

//assign sram_ctrl_state = testsystem_instance.sram_ctrl_instance.state_reg;

//assign vga_ctrl_hcount = testsystem_instance.vga_controller_instance.h_counter;
//assign vga_ctrl_vcount = testsystem_instance.vga_controller_instance.v_counter;
			
always begin : CLOCK_GENERATION

#1 CLOCK_50 = ~CLOCK_50;

end

initial begin : CLOCK_INITIALIZATION
	CLOCK_50 = 0;
end

initial begin: TEST_VECTORS
KEY = 4'b1111;
#10
KEY = 4'b1110;
#10
KEY = 4'b1111;

//SRAM_DQ = 16'b0;

end
endmodule
