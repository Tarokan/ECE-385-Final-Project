
module battle_drawer(input logic CLK, 
							input logic RESET,
							input logic ENABLE,	//blanking enable
							input logic DRAW_COMMAND,  //signal from software to update dynamic elements
							input logic [2:0] POKE1_ID,  // players pokemon
							input logic [2:0] POKE2_ID,  // enemy's pokemon
							input logic [7:0] POKE1_HP, 
							input logic [7:0] POKE2_HP,
							input logic BD_ENABLE,   //signal from software to enable this drawer  (active high)
							output logic [19:0] WRITEADDR,  
							output logic [15:0] DATA,
							output logic BD_WE_N
							);	

enum logic [5:0] {
	Await,  
	Reset,
	Clear_Screen_Draw,
	Clear_Screen_Sleep,
	UI_Bars_ReadData,   // draw lower (player) bar
	UI_Bars_Sleep,
	UI_Bars_Draw,
	UI_Bars_Sleep2,
	UI_Bars2_ReadData,
	UI_Bars2_Sleep,
	UI_Bars2_Draw,
	UI_Bars2_Sleep2,
	Poke1_ReadData,
	Poke1_Sleep,
	Poke1_Draw,
	Poke1_Sleep2,
	Poke2_ReadData,
	Poke2_Sleep,
	Poke2_Draw,
	Poke2_Sleep2,
	HealthBar_Draw,
	HealthBar_Sleep,
	HealthBar2_Draw,
	HealthBar2_Sleep,
	UI_Text_Draw,
	UI_Text_Sleep,
	UI_Text_ReadData,
	UI_Text_Sleep2
} State, Next_State;
  
  //SRAM
  logic write_n = 1'b1;
  logic [19:0]  address;
  logic [15:0]  data;	
  
  logic [7:0] UITileCount_out, UITileCount_next;
  logic [19:0] UITilePixelCount_out, UITilePixelCount_next;
  logic [19:0] UIBarsPixelCount_out, UIBarsPixelCount_next;
  logic [19:0] UIBars2PixelCount_out, UIBars2PixelCount_next;
  logic [19:0] PokePixelCount_out, PokePixelCount_next;
  logic [19:0] Poke2PixelCount_out, Poke2PixelCount_next;
  logic [19:0] UITextOptionPixelCount_out, UITextOptionPixelCount_next;
  logic [19:0] ClearPixelCount_out, ClearPixelCount_next;
  
  logic [3:0] UITextCharCount_out, UITextCharCount_next;
  logic [3:0] UITextOptionCount_out, UITextOptionCount_next;
  
  logic [9:0] HPBarPixelCount_out, HPBarPixelCount_next;
  logic [9:0] HPBar2PixelCount_out, HPBar2PixelCount_next;
  logic [7:0] Poke1HP_out, Poke2HP_out, Poke1HP_next, Poke2HP_next;
  
	logic init_draw_done_next = 0;
	logic init_draw_done = 0;
	
	logic [15:0] option0 [6];
	logic [15:0] option1 [6];
	logic [15:0] option2 [6];
	logic [15:0] option3 [6];
	logic [15:0] option4 [6];
	logic [15:0] option5 [6];
	always_comb
	begin
	option0[0][15:0] = 16'd52;  //these are ascii values that are shifted by -32 for our font sheet.
   option0[1][15:0] = 16'd65;
   option0[2][15:0] = 16'd67;
   option0[3][15:0] = 16'd75;
   option0[4][15:0] = 16'd76;
   option0[5][15:0] = 16'd69;
   option1[0][15:0] = 16'd48;
   option1[1][15:0] = 16'd79;
   option1[2][15:0] = 16'd85;
   option1[3][15:0] = 16'd78;
   option1[4][15:0] = 16'd68;
   option1[5][15:0] = 16'd0;
   option2[0][15:0] = 16'd34;
   option2[1][15:0] = 16'd65;
   option2[2][15:0] = 16'd76;
   option2[3][15:0] = 16'd76;
   option2[4][15:0] = 16'd0;
   option2[5][15:0] = 16'd0;
   option3[0][15:0] = 16'd48;
   option3[1][15:0] = 16'd79;
   option3[2][15:0] = 16'd84;
   option3[3][15:0] = 16'd73;
   option3[4][15:0] = 16'd79;
   option3[5][15:0] = 16'd78;
   option4[0][15:0] = 16'd50;
   option4[1][15:0] = 16'd85;
   option4[2][15:0] = 16'd78;
   option4[3][15:0] = 16'd0;
   option4[4][15:0] = 16'd0;
   option4[5][15:0] = 16'd0;
   option5[0][15:0] = 16'd44;
   option5[1][15:0] = 16'd69;
   option5[2][15:0] = 16'd69;
   option5[3][15:0] = 16'd82;
   option5[4][15:0] = 16'd0;
   option5[5][15:0] = 16'd0;
	end

//	for (i = 0; i < 6; i = i + 1) 
//	begin
//		option[i][15:0] = op0.getc(i);
//	end
	
	//OCM
	logic [18:0] pokemon_ocm_address, font_ocm_address, hpbars_ocm_address,
						pokemon_ocm_address_next, font_ocm_address_next, hpbars_ocm_address_next;
	logic [7:0] pokemon_ocm_data, font_ocm_data, hpbars_ocm_data;


fontRAM fontRAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(font_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(font_ocm_data));
											
pokemonRAM pokemonRAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(pokemon_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(pokemon_ocm_data));
											
HPBarsRAM HPBarsRAM_instance(.data_In(6'b0),
											.write_address(6'b0),
											.read_address(hpbars_ocm_address),
											.we(1'b0), //let's say we never write for now..
											.Clk(CLK),
											.data_Out(hpbars_ocm_data));
initial State = Reset;

always_ff @ (posedge CLK) 
begin
	if (RESET)
		State <= Reset;
	else 
	begin
		State <= Next_State;
		pokemon_ocm_address <= pokemon_ocm_address_next;
		font_ocm_address <= font_ocm_address_next;
		hpbars_ocm_address <= hpbars_ocm_address_next;
		init_draw_done <= init_draw_done_next;
		UITileCount_out <= UITileCount_next;
		UITilePixelCount_out <= UITilePixelCount_next;
		UIBarsPixelCount_out <= UIBarsPixelCount_next;
		UIBars2PixelCount_out <= UIBars2PixelCount_next;
		PokePixelCount_out <= PokePixelCount_next;
		Poke2PixelCount_out <= Poke2PixelCount_next;
		UITextCharCount_out <= UITextCharCount_next;
		UITextOptionCount_out <= UITextOptionCount_next;
		UITextOptionPixelCount_out <= UITextOptionPixelCount_next;
		ClearPixelCount_out <= ClearPixelCount_next;
		HPBarPixelCount_out <= HPBarPixelCount_next;
		HPBar2PixelCount_out <= HPBar2PixelCount_next;
		Poke1HP_out <= Poke1HP_next;
		Poke2HP_out <= Poke2HP_next;
	end
end

always_comb
begin
	Next_State = State;
	 
	//Next State Logic
	case (State) 

		Reset :
		begin
			Next_State = Await;
		end
		
		Await : 
		begin
			if(BD_ENABLE == 1'b1 && DRAW_COMMAND == 1'b1)
				Next_State = Clear_Screen_Draw;
		end
		
		Clear_Screen_Draw:
		begin
		if(~ENABLE)
		begin
			Next_State = Clear_Screen_Sleep;
			if(ClearPixelCount_out == 20'd307199)
				Next_State = UI_Bars_ReadData;
		end
		end
		
		Clear_Screen_Sleep:
			Next_State = Clear_Screen_Draw;
		
		UI_Bars_ReadData :
			Next_State = UI_Bars_Sleep;
		
		UI_Bars_Sleep:
			Next_State = UI_Bars_Draw;
			
		UI_Bars_Draw :
		begin
			if(~ENABLE)
			begin
				Next_State = UI_Bars_Sleep2;
				if(UIBarsPixelCount_out == 20'd3599)
					Next_State = UI_Bars2_ReadData; // for now
			end
		end
		
		UI_Bars_Sleep2:
			Next_State = UI_Bars_ReadData;
		
		UI_Bars2_ReadData:
			Next_State = UI_Bars2_Sleep;
		
		UI_Bars2_Sleep:
			Next_State = UI_Bars2_Draw;
			
		UI_Bars2_Draw:
		begin
			if(~ENABLE)
			begin
				Next_State = UI_Bars2_Sleep2;
				if(UIBars2PixelCount_out == 4559)  //120*38 - 1
					Next_State = Poke1_ReadData;
			end
		end
		
		UI_Bars2_Sleep2:
			Next_State = UI_Bars2_ReadData;
		
		Poke1_ReadData:
			Next_State = Poke1_Sleep;
		
		Poke1_Sleep:
			Next_State = Poke1_Draw;
			
			
		Poke1_Draw:
		begin
			if(~ENABLE)
			begin
				Next_State = Poke1_Sleep2;
				if(PokePixelCount_out == 2303)
					Next_State = Poke2_ReadData;
			end
		end
		
		Poke1_Sleep2:
			Next_State = Poke1_ReadData;

		
		Poke2_ReadData:
			Next_State = Poke2_Sleep;
		
		Poke2_Sleep:
			Next_State = Poke2_Draw;
			
			
		Poke2_Draw:
		begin
			if(~ENABLE)
			begin
				Next_State = Poke2_Sleep2;
				if(Poke2PixelCount_out == 2303)
					Next_State = UI_Text_ReadData;
			end
		end
		
		Poke2_Sleep2:
			Next_State = Poke2_ReadData;
		
		UI_Text_ReadData:
			Next_State = UI_Text_Sleep;
		
		UI_Text_Sleep:
			Next_State = UI_Text_Draw;
		
		UI_Text_Draw:
		begin
			if(~ENABLE)
			begin
				Next_State = UI_Text_Sleep2;
				if(UITextOptionCount_out == 5 && UITextCharCount_out == 5 && UITilePixelCount_out == 255)
					Next_State = HealthBar_Draw;
			end
		end
		
		UI_Text_Sleep2:
			Next_State = UI_Text_ReadData;
		
		HealthBar_Draw:
		begin
			if(~ENABLE)
			begin
				Next_State = HealthBar_Sleep;
				if(HPBarPixelCount_out == 60)
					Next_State = HealthBar2_Draw;
			end
		end
		
		HealthBar_Sleep:
			Next_State = HealthBar_Draw;
		
		HealthBar2_Draw:
		begin
			if(~ENABLE)
			begin
				Next_State = HealthBar2_Sleep;
				if(HPBar2PixelCount_out == 60)
					Next_State = Reset;
			end
		end
		
		HealthBar2_Sleep:
			Next_State = HealthBar2_Draw;
		
	endcase
	
	//default cases
	write_n = 1'b1; //active low to SRAM
	address = 20'b0;
	data = 16'd0;
	
	
  font_ocm_address_next = font_ocm_address;
  UITileCount_next = UITileCount_out;
  UITilePixelCount_next = UITilePixelCount_out;
	UIBarsPixelCount_next = UIBarsPixelCount_out;
	UIBars2PixelCount_next = UIBars2PixelCount_out;
	hpbars_ocm_address_next = hpbars_ocm_address;
	init_draw_done_next = init_draw_done;
	PokePixelCount_next = PokePixelCount_out;
	Poke2PixelCount_next = Poke2PixelCount_out;
	pokemon_ocm_address_next = pokemon_ocm_address;
	UITextCharCount_next = UITextCharCount_out;
	UITextOptionCount_next = UITextOptionCount_out;
	UITextOptionPixelCount_next = UITextOptionPixelCount_out;
	ClearPixelCount_next = ClearPixelCount_out;
	HPBarPixelCount_next = HPBarPixelCount_out;
	HPBar2PixelCount_next = HPBar2PixelCount_out;
 
	case (State)
	
		Reset :
		begin
			init_draw_done_next = 1'b0;
			UITileCount_next = 0;
			UITilePixelCount_next = 0;
			UIBarsPixelCount_next = 0;
			UIBars2PixelCount_next = 0;
			init_draw_done_next = 0;
			hpbars_ocm_address_next = 0;
			PokePixelCount_next = 0;
			Poke2PixelCount_next = 0;
			HPBarPixelCount_next = 0;
			HPBar2PixelCount_next = 0;
		end
		
		Clear_Screen_Draw:
		begin
		if(~ENABLE)
		begin
			ClearPixelCount_next = ClearPixelCount_out + 1;
			write_n = 1'b0;
			address = ClearPixelCount_out;
			data = 16'd4891;
		end
		end
		
		UI_Bars_ReadData:
		begin
			hpbars_ocm_address_next = UIBarsPixelCount_out / 120 * 120 + UIBarsPixelCount_out % 120;
		end
		
		UI_Bars_Draw:
		begin
			if(~ENABLE)
			begin
				UIBarsPixelCount_next = UIBarsPixelCount_out + 1;
				
				write_n = 1'b0;
				
				address = 192000 + 500 + 5 + UIBarsPixelCount_out / 120 * 640 + UIBarsPixelCount_out % 120;
				data = {8'b0, hpbars_ocm_data};
				if(hpbars_ocm_data == 0)
					write_n = 1'b1;
			
			end
		end
		
		UI_Bars2_ReadData:
		begin
			hpbars_ocm_address_next = 3840 + UIBars2PixelCount_out / 120 * 120 + UIBars2PixelCount_out % 120;
		end
		
		UI_Bars2_Draw:
		begin
			if(~ENABLE)
			begin
				UIBars2PixelCount_next = UIBars2PixelCount_out + 1;
				
				write_n = 1'b0;
				
				address = 32000 + 5 + UIBars2PixelCount_out / 120 * 640 + UIBars2PixelCount_out % 120;
				data = {8'b0, hpbars_ocm_data};
				if(hpbars_ocm_data == 0)
					write_n = 1'b1;
			
			end
		end
		
		Poke1_ReadData: 
			pokemon_ocm_address_next = POKE1_ID * 48 + PokePixelCount_out / 48 * 240 + PokePixelCount_out % 48;
		
		Poke1_Draw:
		begin
			if(~ENABLE)
			begin
				PokePixelCount_next = PokePixelCount_out + 1;
				write_n = 1'b0;
				
				address = 153600 + 48 + PokePixelCount_out / 48 * 640 + PokePixelCount_out % 48;
				data = {8'b0, pokemon_ocm_data};
				if(pokemon_ocm_data == 0)
					write_n = 1'b1;
			end
		end

		Poke2_ReadData: 
			pokemon_ocm_address_next = POKE2_ID * 48 + Poke2PixelCount_out / 48 * 240 + Poke2PixelCount_out % 48;
		
		Poke2_Draw:
		begin
			if(~ENABLE)
			begin
				Poke2PixelCount_next = Poke2PixelCount_out + 1;
				write_n = 1'b0;
				
				address = 32480 - 640 + 48 + Poke2PixelCount_out / 48 * 640 + Poke2PixelCount_out % 48;
				data = {8'b0, pokemon_ocm_data};
				if(pokemon_ocm_data == 0)
					write_n = 1'b1;
			end
		end

		UI_Text_ReadData:
		begin
			case(UITextOptionCount_out)
				0:
					font_ocm_address_next = option0[UITextCharCount_out][15:0] / 16 * 16 * 256 + option0[UITextCharCount_out][15:0] % 16 * 16 + UITextOptionPixelCount_out / 16 * 256 + UITextOptionPixelCount_out % 16;
				1:
					font_ocm_address_next = option1[UITextCharCount_out][15:0] / 16 * 16 * 256 + option1[UITextCharCount_out][15:0] % 16 * 16 + UITextOptionPixelCount_out / 16 * 256 + UITextOptionPixelCount_out % 16;
				2:
					font_ocm_address_next = option2[UITextCharCount_out][15:0] / 16 * 16 * 256 + option2[UITextCharCount_out][15:0] % 16 * 16 + UITextOptionPixelCount_out / 16 * 256 + UITextOptionPixelCount_out % 16;
				3:
					font_ocm_address_next = option3[UITextCharCount_out][15:0] / 16 * 16 * 256 + option3[UITextCharCount_out][15:0] % 16 * 16 + UITextOptionPixelCount_out / 16 * 256 + UITextOptionPixelCount_out % 16;
				4:
					font_ocm_address_next = option4[UITextCharCount_out][15:0] / 16 * 16 * 256 + option4[UITextCharCount_out][15:0] % 16 * 16 + UITextOptionPixelCount_out / 16 * 256 + UITextOptionPixelCount_out % 16;
				5:
					font_ocm_address_next = option5[UITextCharCount_out][15:0] / 16 * 16 * 256 + option5[UITextCharCount_out][15:0] % 16 * 16 + UITextOptionPixelCount_out / 16 * 256 + UITextOptionPixelCount_out % 16;
			endcase
		end
		
		UI_Text_Draw:
		begin
			if(~ENABLE)
			begin
				write_n = 1'b1;
				
				if(UITextOptionPixelCount_out == 20'd255)
				begin
					UITextOptionPixelCount_next = 20'b0;
					if(UITextCharCount_out == 20'd5)
					begin
						UITextCharCount_next = 20'b0;
						UITextOptionPixelCount_next = UITextOptionPixelCount_out + 1;
					end
					else
						UITextCharCount_next = UITextCharCount_out + 1;
				end 
				else
					UITextOptionPixelCount_next = UITextOptionPixelCount_out + 1;
					
				address = 276480 + 8 + UITextOptionCount_out % 5 * 118 + UITextOptionCount_out / 5 * 640 * 18 + UITextCharCount_out * 16 + UITextOptionPixelCount_out / 16 * 640 + UITextOptionCount_out % 16;
				data = {8'b0, font_ocm_data};
				if(font_ocm_data == 0) 
					write_n = 1'b0;
			end
		end
		
		HealthBar_Draw:
		begin
			if(~ENABLE)
			begin
				HPBarPixelCount_next = HPBarPixelCount_out + 1;
				if(HPBarPixelCount_out < (POKE1_HP + 1))
					data = 16'd227;
				else
				begin
					data = 16'b0;
					write_n = 1'b1;
				end
				address = HPBarPixelCount_out;
			end
		end

		HealthBar2_Draw:
		begin
			if(~ENABLE)
			begin
				HPBar2PixelCount_next = HPBar2PixelCount_out + 1;
				if(HPBar2PixelCount_out < (POKE2_HP + 1))
					data = 16'd227;
				else
				begin
					data = 16'b0;
					write_n = 1'b1;
				end
				address = HPBar2PixelCount_out;
			end
		end
	endcase
end

assign WRITEADDR = address;
assign DATA = data;
assign BD_WE_N = write_n;
endmodule

