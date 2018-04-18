
module frame_drawer(input logic CLK, 
							input logic RESET,
							input logic ENABLE,  //blanking enable for drawing
							input logic DRAW_READY,
							input logic FD_ENABLE,  //software enable selecting which drawengine
							input logic [1:0] PLAYER_DIR,
							input logic [5:0] UI_ENABLE,
							input logic [5:0] PLAYER_X,
							input logic [5:0] PLAYER_Y,
							input logic DRAW_COMMAND,
							input logic [2:0] MAP_ID,
							output logic [19:0] WRITEADDR,
							output logic [15:0] DATA,
							output logic FD_WE_N,
							output logic [7:0] ocm_data_out
							);	

							
enum logic [3:0] {
	Await,  //0
	Reset,
	Background_Draw,
	Background_ReadData,
	Sleep1,
	Sleep2,  //5
	Background_ReadTile,
	Player_ReadData,
	Player_Sleep,
	Player_Draw,
	UI_ReadData,  //10
	UI_Sleep,
	UI_Draw
} State, Next_State;

  logic [19:0] tileCount_out, tileCount_next;

  logic [19:0] tilePixelCountH_out, tilePixelCountH_next;

  logic [19:0] tilePixelCountV_out,tilePixelCountV_next;

  logic [19:0] playerPixelCount_out, playerPixelCount_next;
  
  logic [7:0] UITileCount_out, UITileCount_next;
  
  logic [19:0] UITilePixelCount_out, UITilePixelCount_next;
  
  logic [15:0] map1description [15];
  logic [15:0] map2description [15];
  logic [15:0] map3description [15];
  logic [15:0] map4description [15];
  logic [15:0] map5description [15];
  always_comb
  begin
  map1description[0][15:0] = 48;
map1description[1][15:0] = 69;
map1description[2][15:0] = 76;
map1description[3][15:0] = 73;
map1description[4][15:0] = 67;
map1description[5][15:0] = 65;
map1description[6][15:0] = 78;
map1description[7][15:0] = 0;;
map1description[8][15:0] = 52;
map1description[9][15:0] = 79;
map1description[10][15:0] = 87;
map1description[11][15:0] = 78;
map1description[12][15:0] = 0;
map1description[13][15:0] = 0;
map1description[14][15:0] = 0;
map2description[0][15:0] = 33;
map2description[1][15:0] = 81;
map2description[2][15:0] = 85;
map2description[3][15:0] = 65;
map2description[4][15:0] = 84;
map2description[5][15:0] = 73;
map2description[6][15:0] = 67;
map2description[7][15:0] = 0;
map2description[8][15:0] = 44;
map2description[9][15:0] = 65;
map2description[10][15:0] = 75;
map2description[11][15:0] = 69;
map2description[12][15:0] = 0;
map2description[13][15:0] = 0;
map2description[14][15:0] = 0;
map3description[0][15:0] = 50;
map3description[1][15:0] = 79;
map3description[2][15:0] = 85;
map3description[3][15:0] = 84;
map3description[4][15:0] = 69;
map3description[5][15:0] = 0;
map3description[6][15:0] = 17;
map3description[7][15:0] = 0;
map3description[8][15:0] = 0;
map3description[9][15:0] = 0;
map3description[10][15:0] = 0;
map3description[11][15:0] = 0;
map3description[12][15:0] = 0;
map3description[13][15:0] = 0;
map3description[14][15:0] = 0;
map4description[0][15:0] = 41;
map4description[1][15:0] = 76;
map4description[2][15:0] = 76;
map4description[3][15:0] = 85;
map4description[4][15:0] = 77;
map4description[5][15:0] = 73;
map4description[6][15:0] = 78;
map4description[7][15:0] = 65;
map4description[8][15:0] = 84;
map4description[9][15:0] = 73;
map4description[10][15:0] = 0;
map4description[11][15:0] = 35;
map4description[12][15:0] = 65;
map4description[13][15:0] = 86;
map4description[14][15:0] = 69;
map5description[0][15:0] = 38;
map5description[1][15:0] = 76;
map5description[2][15:0] = 79;
map5description[3][15:0] = 82;
map5description[4][15:0] = 65;
map5description[5][15:0] = 0;
map5description[6][15:0] = 52;
map5description[7][15:0] = 79;
map5description[8][15:0] = 87;
map5description[9][15:0] = 78;
map5description[10][15:0] = 0;
map5description[11][15:0] = 0;
map5description[12][15:0] = 0;
map5description[13][15:0] = 0;
map5description[14][15:0] = 0; 
  end
  //SRAM
  logic write_n = 1'b1;
  logic [19:0]  address;
  logic [15:0]  data;			

  //OCM
	logic [18:0]  ocm_address, map_ocm_address, player_ocm_address, ocm_address_next, map_ocm_address_next, player_ocm_address_next, font_ocm_address, font_ocm_address_next;  
	logic [7:0] ocm_data, player_ocm_data, font_ocm_data;
	logic [11:0] map1_ocm_data, map2_ocm_data, map3_ocm_data, map5_ocm_data, map4_ocm_data, mapOver_ocm_data;
	int tilesheet_width = 15;


frameRAM frameRAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(ocm_data));

map1RAM map1RAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(map_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(map1_ocm_data));
											
map2RAM map2RAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(map_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(map2_ocm_data));
map3RAM map3RAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(map_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(map3_ocm_data));
map4RAM map4RAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(map_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(map4_ocm_data));
map5RAM map5RAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(map_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(map5_ocm_data));
											
mapOverRAM mapOverRAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(map_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(mapOver_ocm_data));
											
playerRAM playerRAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(player_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(player_ocm_data));

fontRAM fontRAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(font_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(font_ocm_data));
											
initial State = Await;

always_ff @ (posedge CLK) 
begin
	if (RESET)
		State <= Reset;
	else 
	begin
		State <= Next_State;
		tileCount_out <= tileCount_next;
		tilePixelCountH_out <= tilePixelCountH_next;
		tilePixelCountV_out <= tilePixelCountV_next;
		ocm_address <= ocm_address_next;
		map_ocm_address <= map_ocm_address_next;
		playerPixelCount_out <= playerPixelCount_next;
		player_ocm_address <= player_ocm_address_next;
		UITileCount_out <= UITileCount_next;
		UITilePixelCount_out <= UITilePixelCount_next;
		font_ocm_address <= font_ocm_address_next;
	end
end

always_comb
begin
	Next_State = State;
	
	//Next State Logic
	case (State) 
		Await :
		begin
      if(~ENABLE == 1'b1)
				Next_State = Background_ReadTile;
		end
		
		Reset :
		begin
		if(DRAW_COMMAND)
			Next_State = Await;
		end
		
		Background_ReadTile :
		begin
      //if(~ENABLE)
			Next_State = Sleep1;
		end
    
		Sleep1	:
			Next_State = Background_ReadData;
			
		Background_ReadData :
		begin
			if(~ENABLE)
				Next_State = Sleep2;
		end
		
		Sleep2 :
			Next_State = Background_Draw;
		
		Background_Draw :
		begin
      if(~ENABLE)
        begin
          Next_State = Background_ReadTile;
          if(tileCount_out == 20'd1199 && tilePixelCountH_out == 20'd15 && tilePixelCountV_out == 20'd15 && ENABLE == 1'b0)
            Next_State = Player_ReadData;
				//use Next_State = Reset to just draw background;
        end
		end
		
		Player_ReadData :
		begin
		if(~ENABLE)
			Next_State = Player_Sleep;
		end
		
		Player_Sleep :
			Next_State = Player_Draw;
		
		Player_Draw :
		begin
			if(~ENABLE)
			begin
				Next_State = Player_ReadData;
				if(playerPixelCount_out == 20'd424 && ENABLE == 1'b0)
				begin
					Next_State = Reset;
					if(UI_ENABLE)
						Next_State = UI_ReadData;
				end
			end
		end
		
		UI_ReadData:
		begin
		if(~ENABLE)
			Next_State = UI_Sleep;
		end
		
		UI_Sleep: 
			Next_State = UI_Draw;
		
		UI_Draw:
		begin
			if(~ENABLE) 
			begin
				Next_State = UI_ReadData;
				if(UITileCount_out >= 8'd14 && ENABLE == 1'b0)
				begin
					Next_State = Reset;
				end
			end
		end
		
	endcase
	
	//default cases
	write_n = 1'b1; //active low to SRAM
	address = 20'b0;
	data = 16'd0;
  
  tileCount_next 				= tileCount_out;
  tilePixelCountH_next 	= tilePixelCountH_out;
  tilePixelCountV_next	= tilePixelCountV_out;
  playerPixelCount_next = playerPixelCount_out;
  ocm_address_next			= ocm_address;
  map_ocm_address_next 	= map_ocm_address;
  player_ocm_address_next = player_ocm_address;
  font_ocm_address_next = font_ocm_address;
  UITileCount_next = UITileCount_out;
  UITilePixelCount_next = UITilePixelCount_out;
	
	//Control Logic
	//if(ENABLE == 1'b0)
	//begin
	case (State)
	
		Reset :
		begin
			tileCount_next = 20'b0;
			tilePixelCountH_next = 20'b0;
			tilePixelCountV_next = 20'b0;
			playerPixelCount_next = 20'b0;
			UITileCount_next = 20'b0;
			UITilePixelCount_next = 20'b0;
		end
		
		Background_ReadTile :
		begin
      //if(~ENABLE)
				map_ocm_address_next = tileCount_out;
		end
		
		Background_ReadData :
		begin
			case(MAP_ID)
				3'd1:
					ocm_address_next = (map1_ocm_data / tilesheet_width) * tilesheet_width * 16 * 16 + (map1_ocm_data % tilesheet_width) * 16 + tilePixelCountV_out * tilesheet_width * 16 + tilePixelCountH_out;
				3'd2:
					ocm_address_next = (map2_ocm_data / tilesheet_width) * tilesheet_width * 16 * 16 + (map2_ocm_data % tilesheet_width) * 16 + tilePixelCountV_out * tilesheet_width * 16 + tilePixelCountH_out;
				3'd3:
					ocm_address_next = (map3_ocm_data / tilesheet_width) * tilesheet_width * 16 * 16 + (map3_ocm_data % tilesheet_width) * 16 + tilePixelCountV_out * tilesheet_width * 16 + tilePixelCountH_out;
				3'd4:
					ocm_address_next = (map4_ocm_data / tilesheet_width) * tilesheet_width * 16 * 16 + (map4_ocm_data % tilesheet_width) * 16 + tilePixelCountV_out * tilesheet_width * 16 + tilePixelCountH_out;
				3'd5:
					ocm_address_next = (map5_ocm_data / tilesheet_width) * tilesheet_width * 16 * 16 + (map5_ocm_data % tilesheet_width) * 16 + tilePixelCountV_out * tilesheet_width * 16 + tilePixelCountH_out;
				3'd6:
					ocm_address_next = (mapOver_ocm_data / tilesheet_width) * tilesheet_width * 16 * 16 + (mapOver_ocm_data % tilesheet_width) * 16 + tilePixelCountV_out * tilesheet_width * 16 + tilePixelCountH_out;
				default:
					ocm_address_next = (map1_ocm_data / tilesheet_width) * tilesheet_width * 16 * 16 + (map1_ocm_data % tilesheet_width) * 16 + tilePixelCountV_out * tilesheet_width * 16 + tilePixelCountH_out;
			endcase
		
		end
	 
   Background_Draw:
		begin
      if(~ENABLE)
		begin
         write_n = 1'b0;

         if(tilePixelCountH_out == 20'd15)
         begin
            tilePixelCountH_next = 20'b0;
            if(tilePixelCountV_out == 20'd15)
            begin
              tilePixelCountV_next = 20'b0;
              tileCount_next = tileCount_out + 1;
            end
            else
              tilePixelCountV_next = tilePixelCountV_out + 1;
			end 
			else
				tilePixelCountH_next = tilePixelCountH_out + 1;

        address = (tileCount_out / 40 * 640 * 16) + (tileCount_out % 40 * 16) + 640 * tilePixelCountV_out + tilePixelCountH_out; 
		  if(UI_ENABLE == 1'b1 && tileCount_out >= 20'd1120)
		  begin
				data = 16'h049;
		  end 
		  else begin
				data = {8'b0,ocm_data};
		  end
			end
		end
		
		Player_ReadData: 
		begin
			player_ocm_address_next = (playerPixelCount_out / 17 * 204) + playerPixelCount_out % 17 + PLAYER_DIR * 51;
		end
			//image is 204*25, each sprite 17 by about 22-25
			
		Player_Draw:
		begin
			if(~ENABLE)
			begin
				write_n = 1'b0;
				data = {8'b0, player_ocm_data};
				if(player_ocm_data == 0)
				begin
					write_n = 1'b1;
				end
				playerPixelCount_next = playerPixelCount_out + 1'b1;
				/**
				Let's draw a generic tile:
				given x,y coordinates:
				tile = 
				certain tile:  (y * 640 * 16) + (x * 16) + 640
				since sprite is oversized, subtract about 6 rows
				
				*/
				address = (PLAYER_Y * 640 * 16) + (PLAYER_X * 16) - (6 * 640) + (playerPixelCount_out / 17 * 640) + playerPixelCount_out % 17;
			end
		end
		
		UI_ReadData:
		begin
			case(MAP_ID)
				3'd1:
					font_ocm_address_next = map1description[UITileCount_out] /16 * 256 * 16 + map1description[UITileCount_out] % 16 * 16  + (UITilePixelCount_out / 16 * 256) + (UITilePixelCount_out % 16);
			
				3'd2:
					font_ocm_address_next = map2description[UITileCount_out] /16 * 256 * 16 + map2description[UITileCount_out] % 16 * 16  + (UITilePixelCount_out / 16 * 256) + (UITilePixelCount_out % 16);

				3'd3:
					font_ocm_address_next = map3description[UITileCount_out] /16 * 256 * 16 + map3description[UITileCount_out] % 16 * 16  + (UITilePixelCount_out / 16 * 256) + (UITilePixelCount_out % 16);

				3'd4:
					font_ocm_address_next = map4description[UITileCount_out] /16 * 256 * 16 + map4description[UITileCount_out] % 16 * 16  + (UITilePixelCount_out / 16 * 256) + (UITilePixelCount_out % 16);

				3'd5:
					font_ocm_address_next = map5description[UITileCount_out] /16 * 256 * 16 + map5description[UITileCount_out] % 16 * 16  + (UITilePixelCount_out / 16 * 256) + (UITilePixelCount_out % 16);
				
				default:
					font_ocm_address_next = map1description[UITileCount_out] /16 * 256 * 16 + map1description[UITileCount_out] % 16 * 16  + (UITilePixelCount_out / 16 * 256) + (UITilePixelCount_out % 16);
			
			endcase
		end
		
		
		UI_Draw:
		begin
		if(~ENABLE)
		begin
			
			UITilePixelCount_next = UITilePixelCount_out + 1;
			if(UITilePixelCount_out + 1 == 256) 
			begin
				UITileCount_next = UITileCount_out + 1;
				UITilePixelCount_next = 0;
			end
			
			write_n = 1'b0;
			//for now lets say max message length is about 38 characters
			address = 289280 +640 +640+640 + 8 + UITileCount_out * 16 + (UITilePixelCount_out / 16 * 640) + (UITilePixelCount_out % 16);
			
			data = {8'b0, font_ocm_data};
			if(font_ocm_data == 0)
			begin
				write_n = 1'b1;
			end
			end
		end
		
	endcase
end

assign WRITEADDR = address;
assign DATA = data;
assign FD_WE_N = write_n;
assign ocm_data_out = ocm_data;
endmodule

module letter_mapper(input logic [7:0] letterCode,
							output logic [19:0] fontAddress);
endmodule
