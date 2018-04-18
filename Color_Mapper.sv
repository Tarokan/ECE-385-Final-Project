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
module  color_mapper  (input  [15:0]  Color_Enum,
                       output logic [7:0] VGA_R, VGA_G, VGA_B
                      );

    always_comb
    begin
      case(Color_Enum)
      16'd0:
      begin
      	VGA_R = 8'h88;
      	VGA_G = 8'hca;
      	VGA_B = 8'h84;
      end
      16'd1:
      begin
      	VGA_R = 8'hFF;
      	VGA_G = 8'hFF;
      	VGA_B = 8'hFF;
      end
      16'd2:
      begin
      	VGA_R = 8'hF0;
      	VGA_G = 8'h03;
      	VGA_B = 8'hFC;
      end
      16'd3:
      begin
      	VGA_R = 8'hF5;
      	VGA_G = 8'hCA;
      	VGA_B = 8'h7A;
      end
      16'd4:
      begin
      	VGA_R = 8'hF5;
      	VGA_G = 8'h8C;
      	VGA_B = 8'h36;
      end
      16'd5:
      begin
      	VGA_R = 8'hF5;
      	VGA_G = 8'h94;
      	VGA_B = 8'h49;
      end
      16'd6:
      begin
      	VGA_R = 8'hF2;
      	VGA_G = 8'hA3;
      	VGA_B = 8'h0F;
      end
      16'd7:
      begin
      	VGA_R = 8'hF0;
      	VGA_G = 8'hD6;
      	VGA_B = 8'h90;
      end
      16'd8:
      begin
      	VGA_R = 8'hED;
      	VGA_G = 8'hAD;
      	VGA_B = 8'h5F;
      end
      16'd9:
      begin
      	VGA_R = 8'hEB;
      	VGA_G = 8'hD4;
      	VGA_B = 8'hA4;
      end
      16'd10:
      begin
      	VGA_R = 8'hE8;
      	VGA_G = 8'h13;
      	VGA_B = 8'hAF;
      end
      16'd11:
      begin
      	VGA_R = 8'hE3;
      	VGA_G = 8'h52;
      	VGA_B = 8'h32;
      end
      16'd12:
      begin
      	VGA_R = 8'hE3;
      	VGA_G = 8'h5A;
      	VGA_B = 8'h42;
      end
      16'd13:
      begin
      	VGA_R = 8'hD4;
      	VGA_G = 8'h52;
      	VGA_B = 8'h3B;
      end
      16'd14:
      begin
      	VGA_R = 8'hD1;
      	VGA_G = 8'h50;
      	VGA_B = 8'h30;
      end
      16'd15:
      begin
      	VGA_R = 8'hCC;
      	VGA_G = 8'h93;
      	VGA_B = 8'hCF;
      end
      16'd16:
      begin
      	VGA_R = 8'hCF;
      	VGA_G = 8'h94;
      	VGA_B = 8'h51;
      end
      16'd17:
      begin
      	VGA_R = 8'hCC;
      	VGA_G = 8'h10;
      	VGA_B = 8'hA0;
      end
      16'd18:
      begin
      	VGA_R = 8'h64;
      	VGA_G = 8'hCC;
      	VGA_B = 8'hB7;
      end
      16'd19:
      begin
      	VGA_R = 8'hCC;
      	VGA_G = 8'h87;
      	VGA_B = 8'h3D;
      end
      16'd20:
      begin
      	VGA_R = 8'h62;
      	VGA_G = 8'hCC;
      	VGA_B = 8'h2D;
      end
      16'd21:
      begin
      	VGA_R = 8'h7B;
      	VGA_G = 8'hC8;
      	VGA_B = 8'hC9;
      end
      16'd22:
      begin
      	VGA_R = 8'hB9;
      	VGA_G = 8'h26;
      	VGA_B = 8'hC9;
      end
      16'd23:
      begin
      	VGA_R = 8'hC3;
      	VGA_G = 8'h0C;
      	VGA_B = 8'hC9;
      end
      16'd24:
      begin
      	VGA_R = 8'h89;
      	VGA_G = 8'hC2;
      	VGA_B = 8'hC7;
      end
      16'd25:
      begin
      	VGA_R = 8'hAB;
      	VGA_G = 8'h24;
      	VGA_B = 8'hB5;
      end
      16'd26:
      begin
      	VGA_R = 8'hAD;
      	VGA_G = 8'h6E;
      	VGA_B = 8'hB5;
      end
      16'd27:
      begin
      	VGA_R = 8'hB5;
      	VGA_G = 8'h67;
      	VGA_B = 8'h07;
      end
      16'd28:
      begin
      	VGA_R = 8'hAF;
      	VGA_G = 8'h0B;
      	VGA_B = 8'hB5;
      end
      16'd29:
      begin
      	VGA_R = 8'hB2;
      	VGA_G = 8'h0E;
      	VGA_B = 8'h7C;
      end
      16'd30:
      begin
      	VGA_R = 8'h6B;
      	VGA_G = 8'hAE;
      	VGA_B = 8'hB2;
      end
      16'd31:
      begin
      	VGA_R = 8'h58;
      	VGA_G = 8'hAE;
      	VGA_B = 8'hB0;
      end
      16'd32:
      begin
      	VGA_R = 8'h44;
      	VGA_G = 8'hB0;
      	VGA_B = 8'h33;
      end
      16'd33:
      begin
      	VGA_R = 8'h78;
      	VGA_G = 8'hAD;
      	VGA_B = 8'h32;
      end
      16'd34:
      begin
      	VGA_R = 8'h70;
      	VGA_G = 8'hA1;
      	VGA_B = 8'h30;
      end
      16'd35:
      begin
      	VGA_R = 8'h2F;
      	VGA_G = 8'h9E;
      	VGA_B = 8'h46;
      end
      16'd36:
      begin
      	VGA_R = 8'h5C;
      	VGA_G = 8'h97;
      	VGA_B = 8'h9C;
      end
      16'd37:
      begin
      	VGA_R = 8'h4E;
      	VGA_G = 8'h9A;
      	VGA_B = 8'h9C;
      end
      16'd38:
      begin
      	VGA_R = 8'h99;
      	VGA_G = 8'h51;
      	VGA_B = 8'h09;
      end
      16'd39:
      begin
      	VGA_R = 8'h94;
      	VGA_G = 8'h5C;
      	VGA_B = 8'h99;
      end
      16'd40:
      begin
      	VGA_R = 8'h8F;
      	VGA_G = 8'h05;
      	VGA_B = 8'h99;
      end
      16'd41:
      begin
      	VGA_R = 8'h3C;
      	VGA_G = 8'h96;
      	VGA_B = 8'h95;
      end
      16'd42:
      begin
      	VGA_R = 8'h8B;
      	VGA_G = 8'h49;
      	VGA_B = 8'h91;
      end
      16'd43:
      begin
      	VGA_R = 8'h85;
      	VGA_G = 8'h45;
      	VGA_B = 8'h85;
      end
      16'd44:
      begin
      	VGA_R = 8'h82;
      	VGA_G = 8'h4D;
      	VGA_B = 8'h6E;
      end
      16'd45:
      begin
      	VGA_R = 8'h80;
      	VGA_G = 8'h4B;
      	VGA_B = 8'h82;
      end
      16'd46:
      begin
      	VGA_R = 8'h35;
      	VGA_G = 8'h82;
      	VGA_B = 8'h82;
      end
      16'd47:
      begin
      	VGA_R = 8'h79;
      	VGA_G = 8'h04;
      	VGA_B = 8'h80;
      end
      16'd48:
      begin
      	VGA_R = 8'h29;
      	VGA_G = 8'h65;
      	VGA_B = 8'h66;
      end
      16'd49:
      begin
      	VGA_R = 8'h5F;
      	VGA_G = 8'h04;
      	VGA_B = 8'h66;
      end
      16'd50:
      begin
      	VGA_R = 8'h4C;
      	VGA_G = 8'h02;
      	VGA_B = 8'h2F;
      end
      16'd51:
      begin
      	VGA_R = 8'h45;
      	VGA_G = 8'h03;
      	VGA_B = 8'h4C;
      end
      16'd52:
      begin
      	VGA_R = 8'hF9;
      	VGA_G = 8'hD8;
      	VGA_B = 8'hDF;
      end
      16'd53:
      begin
      	VGA_R = 8'hF4;
      	VGA_G = 8'hF1;
      	VGA_B = 8'hED;
      end
      16'd54:
      begin
      	VGA_R = 8'hE9;
      	VGA_G = 8'hF9;
      	VGA_B = 8'hF6;
      end
      16'd55:
      begin
      	VGA_R = 8'hC5;
      	VGA_G = 8'hC5;
      	VGA_B = 8'hC5;
      end
      16'd56:
      begin
      	VGA_R = 8'hA3;
      	VGA_G = 8'hA3;
      	VGA_B = 8'hA3;
      end
      16'd57:
      begin
      	VGA_R = 8'hAA;
      	VGA_G = 8'hA2;
      	VGA_B = 8'h9F;
      end
      16'd58:
      begin
      	VGA_R = 8'h6B;
      	VGA_G = 8'h64;
      	VGA_B = 8'h61;
      end
      16'd59:
      begin
      	VGA_R = 8'h63;
      	VGA_G = 8'h5D;
      	VGA_B = 8'h59;
      end
      16'd60:
      begin
      	VGA_R = 8'h45;
      	VGA_G = 8'h3F;
      	VGA_B = 8'h3A;
      end
      16'd61:
      begin
      	VGA_R = 8'hA6;
      	VGA_G = 8'h9D;
      	VGA_B = 8'h94;
      end
      16'd62:
      begin
      	VGA_R = 8'h95;
      	VGA_G = 8'h94;
      	VGA_B = 8'h82;
      end
      16'd63:
      begin
      	VGA_R = 8'h29;
      	VGA_G = 8'h2D;
      	VGA_B = 8'h2D;
      end
      16'd64:
      begin
      	VGA_R = 8'h81;
      	VGA_G = 8'h48;
      	VGA_B = 8'h45;
      end
      16'd65:
      begin
      	VGA_R = 8'hB6;
      	VGA_G = 8'h3B;
      	VGA_B = 8'h39;
      end
      16'd66:
      begin
      	VGA_R = 8'h5C;
      	VGA_G = 8'h4A;
      	VGA_B = 8'h3F;
      end
      16'd67:
      begin
      	VGA_R = 8'h68;
      	VGA_G = 8'h55;
      	VGA_B = 8'h4A;
      end
      16'd68:
      begin
      	VGA_R = 8'h61;
      	VGA_G = 8'h3B;
      	VGA_B = 8'h2B;
      end
      16'd69:
      begin
      	VGA_R = 8'h79;
      	VGA_G = 8'h47;
      	VGA_B = 8'h2F;
      end
      16'd70:
      begin
      	VGA_R = 8'hAD;
      	VGA_G = 8'h64;
      	VGA_B = 8'h50;
      end
      16'd71:
      begin
      	VGA_R = 8'hD4;
      	VGA_G = 8'h51;
      	VGA_B = 8'h42;
      end
      16'd72:
      begin
      	VGA_R = 8'hDF;
      	VGA_G = 8'h67;
      	VGA_B = 8'h5F;
      end
      16'd73:
      begin
      	VGA_R = 8'hEA;
      	VGA_G = 8'h7E;
      	VGA_B = 8'h78;
      end
      16'd74:
      begin
      	VGA_R = 8'h6E;
      	VGA_G = 8'h4B;
      	VGA_B = 8'h33;
      end
      16'd75:
      begin
      	VGA_R = 8'h8A;
      	VGA_G = 8'h5B;
      	VGA_B = 8'h38;
      end
      16'd76:
      begin
      	VGA_R = 8'hD7;
      	VGA_G = 8'h7E;
      	VGA_B = 8'h5C;
      end
      16'd77:
      begin
      	VGA_R = 8'hFD;
      	VGA_G = 8'hD1;
      	VGA_B = 8'hC1;
      end
      16'd78:
      begin
      	VGA_R = 8'h73;
      	VGA_G = 8'h5F;
      	VGA_B = 8'h4B;
      end
      16'd79:
      begin
      	VGA_R = 8'h7D;
      	VGA_G = 8'h5D;
      	VGA_B = 8'h42;
      end
      16'd80:
      begin
      	VGA_R = 8'h93;
      	VGA_G = 8'h78;
      	VGA_B = 8'h5C;
      end
      16'd81:
      begin
      	VGA_R = 8'h60;
      	VGA_G = 8'h40;
      	VGA_B = 8'h24;
      end
      16'd82:
      begin
      	VGA_R = 8'h99;
      	VGA_G = 8'h75;
      	VGA_B = 8'h56;
      end
      16'd83:
      begin
      	VGA_R = 8'hAF;
      	VGA_G = 8'h94;
      	VGA_B = 8'h78;
      end
      16'd84:
      begin
      	VGA_R = 8'hA3;
      	VGA_G = 8'h78;
      	VGA_B = 8'h49;
      end
      16'd85:
      begin
      	VGA_R = 8'h8A;
      	VGA_G = 8'h5C;
      	VGA_B = 8'h2F;
      end
      16'd86:
      begin
      	VGA_R = 8'hA3;
      	VGA_G = 8'h74;
      	VGA_B = 8'h42;
      end
      16'd87:
      begin
      	VGA_R = 8'hA4;
      	VGA_G = 8'h64;
      	VGA_B = 8'h3E;
      end
      16'd88:
      begin
      	VGA_R = 8'hB6;
      	VGA_G = 8'h8D;
      	VGA_B = 8'h5F;
      end
      16'd89:
      begin
      	VGA_R = 8'hBB;
      	VGA_G = 8'h6D;
      	VGA_B = 8'h3A;
      end
      16'd90:
      begin
      	VGA_R = 8'hCB;
      	VGA_G = 8'h7D;
      	VGA_B = 8'h4A;
      end
      16'd91:
      begin
      	VGA_R = 8'hDA;
      	VGA_G = 8'hA2;
      	VGA_B = 8'h7E;
      end
      16'd92:
      begin
      	VGA_R = 8'hE3;
      	VGA_G = 8'hB1;
      	VGA_B = 8'h93;
      end
      16'd93:
      begin
      	VGA_R = 8'hF6;
      	VGA_G = 8'hC4;
      	VGA_B = 8'hA6;
      end
      16'd94:
      begin
      	VGA_R = 8'h7C;
      	VGA_G = 8'h53;
      	VGA_B = 8'h1C;
      end
      16'd95:
      begin
      	VGA_R = 8'hBA;
      	VGA_G = 8'h90;
      	VGA_B = 8'h71;
      end
      16'd96:
      begin
      	VGA_R = 8'hE2;
      	VGA_G = 8'hDF;
      	VGA_B = 8'hDB;
      end
      16'd97:
      begin
      	VGA_R = 8'hC1;
      	VGA_G = 8'h9C;
      	VGA_B = 8'h6F;
      end
      16'd98:
      begin
      	VGA_R = 8'hCB;
      	VGA_G = 8'hB1;
      	VGA_B = 8'h94;
      end
      16'd99:
      begin
      	VGA_R = 8'hCB;
      	VGA_G = 8'hA4;
      	VGA_B = 8'h76;
      end
      16'd100:
      begin
      	VGA_R = 8'hCD;
      	VGA_G = 8'h9F;
      	VGA_B = 8'h6B;
      end
      16'd101:
      begin
      	VGA_R = 8'hD1;
      	VGA_G = 8'h93;
      	VGA_B = 8'h67;
      end
      16'd102:
      begin
      	VGA_R = 8'h8F;
      	VGA_G = 8'h5C;
      	VGA_B = 8'h10;
      end
      16'd103:
      begin
      	VGA_R = 8'hD0;
      	VGA_G = 8'hAB;
      	VGA_B = 8'h7D;
      end
      16'd104:
      begin
      	VGA_R = 8'hD7;
      	VGA_G = 8'hB3;
      	VGA_B = 8'h87;
      end
      16'd105:
      begin
      	VGA_R = 8'hBE;
      	VGA_G = 8'h78;
      	VGA_B = 8'h16;
      end
      16'd106:
      begin
      	VGA_R = 8'hDC;
      	VGA_G = 8'hB8;
      	VGA_B = 8'h8A;
      end
      16'd107:
      begin
      	VGA_R = 8'hDB;
      	VGA_G = 8'hAE;
      	VGA_B = 8'h78;
      end
      16'd108:
      begin
      	VGA_R = 8'hCF;
      	VGA_G = 8'h74;
      	VGA_B = 8'h00;
      end
      16'd109:
      begin
      	VGA_R = 8'hF5;
      	VGA_G = 8'hAE;
      	VGA_B = 8'h44;
      end
      16'd110:
      begin
      	VGA_R = 8'hFA;
      	VGA_G = 8'hBE;
      	VGA_B = 8'h66;
      end
      16'd111:
      begin
      	VGA_R = 8'h3C;
      	VGA_G = 8'h34;
      	VGA_B = 8'h24;
      end
      16'd112:
      begin
      	VGA_R = 8'h4F;
      	VGA_G = 8'h46;
      	VGA_B = 8'h2B;
      end
      16'd113:
      begin
      	VGA_R = 8'h48;
      	VGA_G = 8'h3C;
      	VGA_B = 8'h1E;
      end
      16'd114:
      begin
      	VGA_R = 8'h68;
      	VGA_G = 8'h54;
      	VGA_B = 8'h31;
      end
      16'd115:
      begin
      	VGA_R = 8'h8B;
      	VGA_G = 8'h66;
      	VGA_B = 8'h2C;
      end
      16'd116:
      begin
      	VGA_R = 8'h97;
      	VGA_G = 8'h5E;
      	VGA_B = 8'h06;
      end
      16'd117:
      begin
      	VGA_R = 8'hE2;
      	VGA_G = 8'h99;
      	VGA_B = 8'h24;
      end
      16'd118:
      begin
      	VGA_R = 8'h82;
      	VGA_G = 8'h6F;
      	VGA_B = 8'h45;
      end
      16'd119:
      begin
      	VGA_R = 8'h9D;
      	VGA_G = 8'h92;
      	VGA_B = 8'h6A;
      end
      16'd120:
      begin
      	VGA_R = 8'h76;
      	VGA_G = 8'h67;
      	VGA_B = 8'h2F;
      end
      16'd121:
      begin
      	VGA_R = 8'h99;
      	VGA_G = 8'h89;
      	VGA_B = 8'h50;
      end
      16'd122:
      begin
      	VGA_R = 8'hA5;
      	VGA_G = 8'h89;
      	VGA_B = 8'h58;
      end
      16'd123:
      begin
      	VGA_R = 8'hAD;
      	VGA_G = 8'h9D;
      	VGA_B = 8'h6D;
      end
      16'd124:
      begin
      	VGA_R = 8'hBB;
      	VGA_G = 8'hAB;
      	VGA_B = 8'h7B;
      end
      16'd125:
      begin
      	VGA_R = 8'hC2;
      	VGA_G = 8'hB7;
      	VGA_B = 8'h97;
      end
      16'd126:
      begin
      	VGA_R = 8'hD3;
      	VGA_G = 8'hC9;
      	VGA_B = 8'hA4;
      end
      16'd127:
      begin
      	VGA_R = 8'hD8;
      	VGA_G = 8'hC1;
      	VGA_B = 8'h96;
      end
      16'd128:
      begin
      	VGA_R = 8'hE2;
      	VGA_G = 8'hD9;
      	VGA_B = 8'hA3;
      end
      16'd129:
      begin
      	VGA_R = 8'hE3;
      	VGA_G = 8'hCB;
      	VGA_B = 8'h8B;
      end
      16'd130:
      begin
      	VGA_R = 8'hEB;
      	VGA_G = 8'hDB;
      	VGA_B = 8'h97;
      end
      16'd131:
      begin
      	VGA_R = 8'hE0;
      	VGA_G = 8'h9B;
      	VGA_B = 8'h00;
      end
      16'd132:
      begin
      	VGA_R = 8'hFC;
      	VGA_G = 8'hC1;
      	VGA_B = 8'h12;
      end
      16'd133:
      begin
      	VGA_R = 8'h70;
      	VGA_G = 8'h6E;
      	VGA_B = 8'h57;
      end
      16'd134:
      begin
      	VGA_R = 8'hF2;
      	VGA_G = 8'hD8;
      	VGA_B = 8'h86;
      end
      16'd135:
      begin
      	VGA_R = 8'h2C;
      	VGA_G = 8'h2E;
      	VGA_B = 8'h11;
      end
      16'd136:
      begin
      	VGA_R = 8'h89;
      	VGA_G = 8'h88;
      	VGA_B = 8'h52;
      end
      16'd137:
      begin
      	VGA_R = 8'h9E;
      	VGA_G = 8'h9C;
      	VGA_B = 8'h7B;
      end
      16'd138:
      begin
      	VGA_R = 8'hB7;
      	VGA_G = 8'hB6;
      	VGA_B = 8'hA6;
      end
      16'd139:
      begin
      	VGA_R = 8'hCA;
      	VGA_G = 8'hC8;
      	VGA_B = 8'hAC;
      end
      16'd140:
      begin
      	VGA_R = 8'hDC;
      	VGA_G = 8'hD9;
      	VGA_B = 8'hB1;
      end
      16'd141:
      begin
      	VGA_R = 8'hE3;
      	VGA_G = 8'hE1;
      	VGA_B = 8'hC1;
      end
      16'd142:
      begin
      	VGA_R = 8'hED;
      	VGA_G = 8'hE0;
      	VGA_B = 8'hA8;
      end
      16'd143:
      begin
      	VGA_R = 8'hEC;
      	VGA_G = 8'hE9;
      	VGA_B = 8'h80;
      end
      16'd144:
      begin
      	VGA_R = 8'hF5;
      	VGA_G = 8'hE0;
      	VGA_B = 8'h67;
      end
      16'd145:
      begin
      	VGA_R = 8'hF8;
      	VGA_G = 8'hF3;
      	VGA_B = 8'hA5;
      end
      16'd146:
      begin
      	VGA_R = 8'h42;
      	VGA_G = 8'h47;
      	VGA_B = 8'h2A;
      end
      16'd147:
      begin
      	VGA_R = 8'hA1;
      	VGA_G = 8'hB0;
      	VGA_B = 8'h6A;
      end
      16'd148:
      begin
      	VGA_R = 8'hAD;
      	VGA_G = 8'hC1;
      	VGA_B = 8'h8E;
      end
      16'd149:
      begin
      	VGA_R = 8'hC1;
      	VGA_G = 8'hD5;
      	VGA_B = 8'hA2;
      end
      16'd150:
      begin
      	VGA_R = 8'hB1;
      	VGA_G = 8'hD6;
      	VGA_B = 8'h6C;
      end
      16'd151:
      begin
      	VGA_R = 8'h91;
      	VGA_G = 8'hC3;
      	VGA_B = 8'h66;
      end
      16'd152:
      begin
      	VGA_R = 8'hA6;
      	VGA_G = 8'hD6;
      	VGA_B = 8'h74;
      end
      16'd153:
      begin
      	VGA_R = 8'hB2;
      	VGA_G = 8'hDB;
      	VGA_B = 8'h8E;
      end
      16'd154:
      begin
      	VGA_R = 8'hCE;
      	VGA_G = 8'hE2;
      	VGA_B = 8'hAF;
      end
      16'd155:
      begin
      	VGA_R = 8'hC9;
      	VGA_G = 8'hE2;
      	VGA_B = 8'h99;
      end
      16'd156:
      begin
      	VGA_R = 8'h64;
      	VGA_G = 8'h7F;
      	VGA_B = 8'h57;
      end
      16'd157:
      begin
      	VGA_R = 8'h71;
      	VGA_G = 8'hB4;
      	VGA_B = 8'h51;
      end
      16'd158:
      begin
      	VGA_R = 8'hA0;
      	VGA_G = 8'hCD;
      	VGA_B = 8'h81;
      end
      16'd159:
      begin
      	VGA_R = 8'h70;
      	VGA_G = 8'hAB;
      	VGA_B = 8'h5E;
      end
      16'd160:
      begin
      	VGA_R = 8'h56;
      	VGA_G = 8'hA8;
      	VGA_B = 8'h3E;
      end
      16'd161:
      begin
      	VGA_R = 8'h7B;
      	VGA_G = 8'hB9;
      	VGA_B = 8'h65;
      end
      16'd162:
      begin
      	VGA_R = 8'h99;
      	VGA_G = 8'hDC;
      	VGA_B = 8'h83;
      end
      16'd163:
      begin
      	VGA_R = 8'h54;
      	VGA_G = 8'h8F;
      	VGA_B = 8'h47;
      end
      16'd164:
      begin
      	VGA_R = 8'h6F;
      	VGA_G = 8'hA1;
      	VGA_B = 8'h64;
      end
      16'd165:
      begin
      	VGA_R = 8'h57;
      	VGA_G = 8'h9E;
      	VGA_B = 8'h52;
      end
      16'd166:
      begin
      	VGA_R = 8'h87;
      	VGA_G = 8'hB6;
      	VGA_B = 8'h7F;
      end
      16'd167:
      begin
      	VGA_R = 8'h74;
      	VGA_G = 8'hB5;
      	VGA_B = 8'h65;
      end
      16'd168:
      begin
      	VGA_R = 8'h7C;
      	VGA_G = 8'hBA;
      	VGA_B = 8'h77;
      end
      16'd169:
      begin
      	VGA_R = 8'h4B;
      	VGA_G = 8'h93;
      	VGA_B = 8'h52;
      end
      16'd170:
      begin
      	VGA_R = 8'h4F;
      	VGA_G = 8'h97;
      	VGA_B = 8'h56;
      end
      16'd171:
      begin
      	VGA_R = 8'h83;
      	VGA_G = 8'hC8;
      	VGA_B = 8'h7E;
      end
      16'd172:
      begin
      	VGA_R = 8'h8E;
      	VGA_G = 8'hCA;
      	VGA_B = 8'h82;
      end
      16'd173:
      begin
      	VGA_R = 8'h91;
      	VGA_G = 8'hD2;
      	VGA_B = 8'h88;
      end
      16'd174:
      begin
      	VGA_R = 8'h95;
      	VGA_G = 8'hD6;
      	VGA_B = 8'h8B;
      end
      16'd175:
      begin
      	VGA_R = 8'h49;
      	VGA_G = 8'hB8;
      	VGA_B = 8'h55;
      end
      16'd176:
      begin
      	VGA_R = 8'h84;
      	VGA_G = 8'hC7;
      	VGA_B = 8'h84;
      end
      16'd177:
      begin
      	VGA_R = 8'h98;
      	VGA_G = 8'hD8;
      	VGA_B = 8'h8E;
      end
      16'd178:
      begin
      	VGA_R = 8'h2F;
      	VGA_G = 8'h4A;
      	VGA_B = 8'h35;
      end
      16'd179:
      begin
      	VGA_R = 8'h5D;
      	VGA_G = 8'h92;
      	VGA_B = 8'h65;
      end
      16'd180:
      begin
      	VGA_R = 8'h49;
      	VGA_G = 8'h94;
      	VGA_B = 8'h5B;
      end
      16'd181:
      begin
      	VGA_R = 8'h56;
      	VGA_G = 8'hA4;
      	VGA_B = 8'h60;
      end
      16'd182:
      begin
      	VGA_R = 8'h3D;
      	VGA_G = 8'h7F;
      	VGA_B = 8'h58;
      end
      16'd183:
      begin
      	VGA_R = 8'h1B;
      	VGA_G = 8'h54;
      	VGA_B = 8'h3A;
      end
      16'd184:
      begin
      	VGA_R = 8'h28;
      	VGA_G = 8'h6C;
      	VGA_B = 8'h45;
      end
      16'd185:
      begin
      	VGA_R = 8'h0D;
      	VGA_G = 8'h51;
      	VGA_B = 8'h31;
      end
      16'd186:
      begin
      	VGA_R = 8'hA4;
      	VGA_G = 8'hBF;
      	VGA_B = 8'hB7;
      end
      16'd187:
      begin
      	VGA_R = 8'hC6;
      	VGA_G = 8'hE2;
      	VGA_B = 8'hDA;
      end
      16'd188:
      begin
      	VGA_R = 8'h70;
      	VGA_G = 8'hA6;
      	VGA_B = 8'hA3;
      end
      16'd189:
      begin
      	VGA_R = 8'h7B;
      	VGA_G = 8'hB1;
      	VGA_B = 8'hAD;
      end
      16'd190:
      begin
      	VGA_R = 8'h58;
      	VGA_G = 8'h8D;
      	VGA_B = 8'h8F;
      end
      16'd191:
      begin
      	VGA_R = 8'h3F;
      	VGA_G = 8'h6C;
      	VGA_B = 8'h82;
      end
      16'd192:
      begin
      	VGA_R = 8'h2F;
      	VGA_G = 8'h61;
      	VGA_B = 8'h7E;
      end
      16'd193:
      begin
      	VGA_R = 8'hB1;
      	VGA_G = 8'hBF;
      	VGA_B = 8'hC3;
      end
      16'd194:
      begin
      	VGA_R = 8'h67;
      	VGA_G = 8'hAA;
      	VGA_B = 8'hB8;
      end
      16'd195:
      begin
      	VGA_R = 8'h3B;
      	VGA_G = 8'h9F;
      	VGA_B = 8'hC6;
      end
      16'd196:
      begin
      	VGA_R = 8'h23;
      	VGA_G = 8'h86;
      	VGA_B = 8'hB1;
      end
      16'd197:
      begin
      	VGA_R = 8'h56;
      	VGA_G = 8'hAF;
      	VGA_B = 8'hD1;
      end
      16'd198:
      begin
      	VGA_R = 8'h47;
      	VGA_G = 8'h94;
      	VGA_B = 8'hE0;
      end
      16'd199:
      begin
      	VGA_R = 8'h61;
      	VGA_G = 8'hAA;
      	VGA_B = 8'hDF;
      end
      16'd200:
      begin
      	VGA_R = 8'h9A;
      	VGA_G = 8'hCE;
      	VGA_B = 8'hEF;
      end
      16'd201:
      begin
      	VGA_R = 8'hD1;
      	VGA_G = 8'hE8;
      	VGA_B = 8'hF9;
      end
      16'd202:
      begin
      	VGA_R = 8'h6B;
      	VGA_G = 8'h79;
      	VGA_B = 8'h8F;
      end
      16'd203:
      begin
      	VGA_R = 8'h97;
      	VGA_G = 8'hBB;
      	VGA_B = 8'hF7;
      end
      16'd204:
      begin
      	VGA_R = 8'h59;
      	VGA_G = 8'h57;
      	VGA_B = 8'h86;
      end
      16'd205:
      begin
      	VGA_R = 8'h73;
      	VGA_G = 8'h77;
      	VGA_B = 8'hE5;
      end
      16'd206:
      begin
      	VGA_R = 8'h5C;
      	VGA_G = 8'h48;
      	VGA_B = 8'h75;
      end
      16'd207:
      begin
      	VGA_R = 8'h79;
      	VGA_G = 8'h58;
      	VGA_B = 8'hC2;
      end
      16'd208:
      begin
      	VGA_R = 8'hD7;
      	VGA_G = 8'hB7;
      	VGA_B = 8'hFF;
      end
      16'd209:
      begin
      	VGA_R = 8'h99;
      	VGA_G = 8'h6C;
      	VGA_B = 8'hAA;
      end
      16'd210:
      begin
      	VGA_R = 8'hDD;
      	VGA_G = 8'hC8;
      	VGA_B = 8'hDB;
      end
      16'd211:
      begin
      	VGA_R = 8'hF7;
      	VGA_G = 8'h97;
      	VGA_B = 8'hE3;
      end
      16'd212:
      begin
      	VGA_R = 8'hFA;
      	VGA_G = 8'h87;
      	VGA_B = 8'hE9;
      end
      16'd213:
      begin
      	VGA_R = 8'h9B;
      	VGA_G = 8'h67;
      	VGA_B = 8'h85;
      end
      16'd214:
      begin
      	VGA_R = 8'h92;
      	VGA_G = 8'h55;
      	VGA_B = 8'h67;
      end
      16'd215:
      begin
      	VGA_R = 8'hDB;
      	VGA_G = 8'h90;
      	VGA_B = 8'hB1;
      end
      16'd216:
      begin
      	VGA_R = 8'hE5;
      	VGA_G = 8'h73;
      	VGA_B = 8'hA6;
      end
      16'd217:
      begin
      	VGA_R = 8'hC2;
      	VGA_G = 8'h58;
      	VGA_B = 8'h63;
      end
      16'd218:
      begin
      	VGA_R = 8'hF7;
      	VGA_G = 8'hF7;
      	VGA_B = 8'hF7;
      end
      16'd219:
      begin
      	VGA_R = 8'h2E;
      	VGA_G = 8'h2E;
      	VGA_B = 8'h2E;
      end
      16'd220:
      begin
      	VGA_R = 8'h5D;
      	VGA_G = 8'h65;
      	VGA_B = 8'h55;
      end
      16'd221:
      begin
      	VGA_R = 8'hF7;
      	VGA_G = 8'h3D;
      	VGA_B = 8'h2E;
      end
      16'd222:
      begin
      	VGA_R = 8'hF7;
      	VGA_G = 8'h8E;
      	VGA_B = 8'h8E;
      end
      16'd223:
      begin
      	VGA_R = 8'h36;
      	VGA_G = 8'h27;
      	VGA_B = 8'h20;
      end
      16'd224:
      begin
      	VGA_R = 8'h97;
      	VGA_G = 8'h9F;
      	VGA_B = 8'h86;
      end
      16'd225:
      begin
      	VGA_R = 8'hC2;
      	VGA_G = 8'hCB;
      	VGA_B = 8'hB9;
      end
      16'd226:
      begin
      	VGA_R = 8'h12;
      	VGA_G = 8'hB9;
      	VGA_B = 8'h19;
      end
      16'd227:
      begin
      	VGA_R = 8'h55;
      	VGA_G = 8'hF7;
      	VGA_B = 8'h55;
      end
      default:
      begin
      	VGA_R = 8'h7F;
      	VGA_G = 8'h7F;
      	VGA_B = 8'h7F;
      end
	endcase
	end
endmodule