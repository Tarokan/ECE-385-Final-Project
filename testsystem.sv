module testsystem( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
				 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
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
	 logic [9:0]  DrawX_I, DrawY_I;
	 logic FD_write_request_n;
	 logic [19:0] fd_address;
	 logic [15:0] sram_data_in;
	 logic [19:0] address;
	 logic [15:0] data;
	 logic [7:0] ocm_data;
	
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end

	logic [15:0] SRAM_DATA;
  
	 logic SRAM_WE_CTRL;
	 logic enable, ready;
  	 sram_ctrl sram_ctrl_instance(  //inputs
												.clk(Clk),
												.reset_n(~Reset_h),
												.start_n(enable),
												.addr_in(address),
												.data_write(data),
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
    

	 assign enable = ~(VGA_BLANK_N | ~FD_write_request_n);  //set enable 0 when the VGA is trying to read, and the frame_drawer wants to write.
	 assign SRAM_WE_CTRL = VGA_BLANK_N | FD_write_request_n; //always read (1) when not blanking (1) and if not writing (1)
	 
	 assign address = SRAM_WE_CTRL ? (DrawY_I * 640 + DrawX_I) : 16'b1;
	 
	 always_comb
	 begin
			case(SRAM_DATA)
				16'b1:
				begin
					VGA_B = 8'd000; 
					VGA_G = 8'd255;
					VGA_R = 8'd000;
				end
				default:
				begin
					VGA_B = 8'd127;
					VGA_G = 8'd127;
					VGA_R = 8'd127;
				end
			endcase
	 end
	 
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
    
	 frame_drawer frame_drawer_instance(.CLK(Clk),
													.RESET(Reset_h),
													.ENABLE(VGA_BLANK_N),
													.DRAW_READY(ready),
													.FD_ENABLE(1'b1),
													.WRITEADDR(fd_address),
													.PLAYER_DIR(2'b0),
													.UI_ENABLE(1'b1),
													.PLAYER_X(6'b0),
													.PLAYER_Y(6'b0),
													.DRAW_COMMAND(1'b0),
													.DATA(data),
													.FD_WE_N(FD_write_request_n),
													.ocm_data_out(temp_data)); 

												
	battle_drawer battle_drawer_instance(.CLK(Clk),
					  .RESET(Reset_h),
					  .ENABLE(VGA_BLANK_N),
					  .DRAW_COMMAND(1'b1),
					  .POKE1_ID(3'b0),
					  .POKE2_ID(3'b0),
					  .POKE1_HP(8'b0),
					  .POKE2_HP(8'b0),
					  .BD_ENABLE(1'b1),
					  .WRITEADDR(),
					  .DATA(),
					  .FD_WE_N()
					  );
													
													
	 
endmodule
