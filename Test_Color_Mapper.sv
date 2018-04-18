//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  test_color_mapper  (input  [15:0]  Color_Enum,
                       output logic [7:0] VGA_R, VGA_G, VGA_B
                      );

    always_comb
    begin
      case(Color_Enum)
		16'd0:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'h00;
			VGA_B = 8'h00;
		end
		16'd1:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'h00;
			VGA_B = 8'h00;
		end
		16'd2:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'h7F;
			VGA_B = 8'h00;
		end
		16'd3:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'h7F;
			VGA_B = 8'h00;
		end
		16'd4:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'hFF;
			VGA_B = 8'h00;
		end
		16'd5:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'hFF;
			VGA_B = 8'h00;
		end
		16'd6:
		begin
			VGA_R = 8'h00;
			VGA_G = 8'hFF;
			VGA_B = 8'h00;
		end
		16'd7:
		begin
			VGA_R = 8'h00;
			VGA_G = 8'hFF;
			VGA_B = 8'h00;
		end
		16'd8:
		begin
			VGA_R = 8'h00;
			VGA_G = 8'h00;
			VGA_B = 8'hFF;
		end
		16'd9:
		begin
			VGA_R = 8'h00;
			VGA_G = 8'h00;
			VGA_B = 8'hFF;
		end
		16'd10:
		begin
			VGA_R = 8'h4B;
			VGA_G = 8'h00;
			VGA_B = 8'h82;
		end
		16'd11:
		begin
			VGA_R = 8'h4B;
			VGA_G = 8'h00;
			VGA_B = 8'h82;
		end
		16'd12:
		begin
			VGA_R = 8'h94;
			VGA_G = 8'h00;
			VGA_B = 8'hD3;
		end
		16'd13:
		begin
			VGA_R = 8'h94;
			VGA_G = 8'h00;
			VGA_B = 8'hD3;
		end
		16'd14:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'h00;
			VGA_B = 8'h00;
		end
		16'd15:
		begin
			VGA_R = 8'hFF;
			VGA_G = 8'h00;
			VGA_B = 8'h00;
		end
		default:
		begin
			VGA_R = 8'h00;
			VGA_G = 8'h00;
			VGA_B = 8'h00;
		end
      endcase
    end

endmodule
