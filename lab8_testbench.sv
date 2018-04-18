module lab8_testbench();

timeunit 10ns;

timeprecision 1ns;


logic        CLOCK_50;
logic [3:0]  KEY;          //bit 0 is set up as Reset
logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

logic [7:0]  VGA_R,        //VGA Red
             VGA_G,        //VGA Green
             VGA_B;        //VGA Blue
logic        VGA_CLK,      //VGA Clock
             VGA_SYNC_N,   //VGA Sync signal
             VGA_BLANK_N,  //VGA Blank signal
             VGA_VS,       //VGA virtical sync signal
             VGA_HS;       //VGA horizontal sync signal

wire  [15:0] OTG_DATA;     //CY7C67200 Data bus 16 Bits
logic [1:0]  OTG_ADDR;     //CY7C67200 Address 2 Bits
logic        OTG_CS_N,     //CY7C67200 Chip Select
             OTG_RD_N,     //CY7C67200 Write
             OTG_WR_N,     //CY7C67200 Read
             OTG_RST_N,    //CY7C67200 Reset
             OTG_INT;      //CY7C67200 Interrupt

logic [12:0] DRAM_ADDR;    //SDRAM Address 13 Bits
wire  [31:0] DRAM_DQ;      //SDRAM Data 32 Bits
logic [1:0]  DRAM_BA;     //SDRAM Bank Address 2 Bits
logic [3:0]  DRAM_DQM;     //SDRAM Data Mast 4 Bits
logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                    DRAM_CAS_N,   //SDRAM Column Address Strobe
                    DRAM_CKE,     //SDRAM Clock Enable
                    DRAM_WE_N,    //SDRAM Write Enable
                    DRAM_CS_N,    //SDRAM Chip Select
                    DRAM_CLK;      //SDRAM Clock

logic [19:0] SRAM_ADDR;	// SRAM Address 20 Bits
wire [15:0] SRAM_DQ;			// SRAM Data 16 Bits
logic 	SRAM_CE_N,			// SRAM Chip Enable
			SRAM_LB_N,			// SRAM Lower Byte Enable (?)
			SRAM_OE_N,			// SRAM Output Enable(?)
			SRAM_UB_N,			// SRAM Upper Byte Enable (?)
			SRAM_WE_N;			// SRAM Write Enable (?)

logic ctrl_enable;
logic ctrl_rw;
logic [19:0] ctrl_address;
logic ctrl_internal_address;
			
lab8 lab8_instance(.*);
assign ctrl_enable = lab8_instance.enable;
assign ctrl_rw = lab8_instance.SRAM_WE_CTRL;
assign ctrl_address = lab8_instance.address;
assign ctrl_internal_address = lab8_instance.sram_ctrl_instance.addr_next;
			
always begin : CLOCK_GENERATION

#1 CLOCK_50 = ~CLOCK_50;

end

initial begin : CLOCK_INITIALIZATION
	CLOCK_50 = 0;
end

initial begin: TEST_VECTORS
KEY = 4'b1110;
#10
KEY = 4'b1111;

//SRAM_DQ = 16'b0;

end
endmodule
