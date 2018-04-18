//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
				// SRAM controls (may be missing a clk signal??)
				output logic [19:0] SRAM_ADDR,	// SRAM Address 20 Bits
				inout wire [15:0] SRAM_DQ,			// SRAM Data 16 Bits
				output logic 	SRAM_CE_N,			// SRAM Chip Enable
									SRAM_LB_N,			// SRAM Lower Byte Enable (?)
									SRAM_OE_N,			// SRAM Output Enable(?)
									SRAM_UB_N,			// SRAM Upper Byte Enable (?)
									SRAM_WE_N			// SRAM Write Enable (?)
                    );
						 

    logic Reset_h, Clk;
    logic [15:0] keycode;
	 logic [9:0]  DrawX_I, DrawY_I;
	 logic [15:0] fd_data, bd_data;
	 
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs;
	 
	 logic [255:0] software_data;
	 logic [15:0] player_coords, player_info, enemy_info, ally_info;
    
    // Interface between NIOS II and EZ-OTG chip
   hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),    
                            .OTG_RST_N(OTG_RST_N)
    ); 
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     nios_system nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_out_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
									  .export_data_export_data(software_data),
    );
  
	logic [15:0] SRAM_DATA;
  
	 logic SRAM_WE_CTRL;
	 logic enable, ready;
	 logic [15:0] toSRAM_ctrl_data;
	 
	 always_comb
	 begin
	 //if(FD_write_request_n == 1'b0)
		toSRAM_ctrl_data = fd_data;
	 //else 
	//	toSRAM_ctrl_data = bd_data;
	 end
	 
  	 sram_ctrl sram_ctrl_instance(  //inputs
												.clk(Clk),
												.reset_n(~Reset_h),
												.start_n(enable),
												.addr_in(address),
												.data_write(toSRAM_ctrl_data),
												.rw(SRAM_WE_CTRL),  // 1  means read, 0 means write
												//outputs
												.ready(ready),
												.data_read(SRAM_DATA),
												.sram_addr(SRAM_ADDR),
												.we_n(SRAM_WE_N),
												.oe_n(SRAM_OE_N),
												.ce_a_n(SRAM_CE_N),
												.ub_a_n(SRAM_UB_N),
												.lb_a_n(SRAM_LB_N),
												.data_io(SRAM_DQ));
  

    always_ff @ (posedge Clk) begin
        if(Reset_h)
            VGA_CLK <= 1'b0;
        else
            VGA_CLK <= ~VGA_CLK;
    end
    
	 logic FD_write_request_n, BD_write_request_n;
	 logic [19:0] fd_address, bd_address;
	  
	 //assign enable = ~VGA_BLANK_N & FD_write_request_n & BD_write_request_n;  //set enable 0 when the VGA is trying to read, and the frame_drawer wants to write.
	 //assign SRAM_WE_CTRL = VGA_BLANK_N | (FD_write_request_n & BD_write_request_n); //always read (1) when not blanking (1) and if not writing (1)
	 assign enable = ~(VGA_BLANK_N | ~FD_write_request_n);  //set enable 0 when the VGA is trying to read, and the frame_drawer wants to write.
	 assign SRAM_WE_CTRL = VGA_BLANK_N | FD_write_request_n; //always read (1) when not blanking (1) and if not writing (1)
	 
	 
	 logic [19:0] pixel_address;
	 logic [19:0] address;
	 always_comb
	 begin
		pixel_address = DrawY_I * 19'd640 + DrawX_I;
		if (SRAM_WE_CTRL == 1'b1)
			address = pixel_address;
		else 
			address = fd_address;
	 end
	 /*always_comb 
	 begin
		pixel_address = DrawY_I * 19'd640 + DrawX_I;
		if (SRAM_WE_CTRL == 1'b1)
			address = pixel_address;
		else if(FD_write_request_n == 1'b0)
			address = fd_address;
		else
			address = bd_address;
	 end*/
	 
	 color_mapper color_mapper_instance(.Color_Enum(SRAM_DATA),
													.VGA_R(VGA_R),
													.VGA_G(VGA_G),
													.VGA_B(VGA_B));
	 

    VGA_controller vga_controller_instance(.Clk(Clk),        
	                                        .Reset(Reset_h),      
	                                        .VGA_HS(VGA_HS),     
	                                        .VGA_VS(VGA_VS),     
	                                        .VGA_CLK(VGA_CLK),    
	                                        .VGA_BLANK_N(VGA_BLANK_N),
	                                        .VGA_SYNC_N(VGA_SYNC_N), 
	                                        .DrawX(DrawX_I),      
														 .DrawY(DrawY_I)       
	 );
	 
	 logic [7:0] temp_data;
    
	 frame_drawer frame_drawer_instance(.CLK(Clk),
													.RESET(Reset_h),
													.ENABLE(VGA_BLANK_N),
													.DRAW_READY(ready),
													.WRITEADDR(fd_address),
													.PLAYER_X(player_coords[15:8]),
													.PLAYER_Y(player_coords[7:0]),
													.PLAYER_DIR(player_info[1:0]),
													.UI_ENABLE(1'b1),
													.DATA(fd_data),
													.DRAW_COMMAND(~KEY[3] | player_info[2]),
													.MAP_ID(player_info[6:4]),
													.FD_WE_N(FD_write_request_n),
													.ocm_data_out(temp_data)); 

    
	 /*battle_drawer battle_drawer_instance(.CLK(Clk),
													  .RESET(Reset_h),
													  .ENABLE(VGA_BLANK_N),
													  .DRAW_COMMAND(~KEY[2]),
													  .POKE1_ID(2'b0),
													  .POKE2_ID(2'b0),
													  .POKE1_HP(8'b0),
													  .POKE2_HP(8'b0),
													  .BD_ENABLE(1'b1),
													  .DATA(bd_data),
													  .BD_WE_N(BD_write_request_n),
													  .WRITEADDR(bd_address)
													  );*/
	 
    HexDriver hex_inst_0 (enemy_info[3:0]		, HEX0);
    HexDriver hex_inst_1 (enemy_info[7:4]		, HEX1);
    HexDriver hex_inst_2 (enemy_info[11:8]	, HEX2);
    HexDriver hex_inst_3 (enemy_info[15:12]	, HEX3);
    HexDriver hex_inst_4 (ally_info[3:0]		, HEX4);
    HexDriver hex_inst_5 (ally_info[7:4]		, HEX5);
    HexDriver hex_inst_6 (ally_info[11:8]		, HEX6);
	 HexDriver hex_inst_7 (ally_info[15:12]	, HEX7);
	 
	 assign player_coords = software_data[15:0];
	 assign player_info = software_data[47:32];
	 assign enemy_info = software_data[79:64];
	 assign ally_info = software_data[111:96];
	 
endmodule
