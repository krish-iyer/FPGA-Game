// this module takes all the positions of a ghost and pacman
// it returns if pacman is dead or not
// it should use the display to matrix index mapping function
module flush_eaten_food (

    input clk, 
    input rst,
    input slower_clk, 
	input [10:0]pacman_curr_pos_x, 
	input [9:0]pacman_curr_pos_y, 
	input food_map_clk, 
	input [5:0] food_map_read_y,
	output [79:0] food_row,
	output is_food,
	output en_game
	); 
	
    reg reset_en_game = 0;
    reg [6:0]pacman_matrix_idx_x;
    reg [5:0]pacman_matrix_idx_y;

        parameter MOVE_TO_CENTER= 0;
     parameter H_VISIBLE_START= 0; 
     parameter V_VISIBLE_START= 0; 


                               
                              

	wire [79:0] dina; 
    wire [79:0] douta;
    reg [79:0] reg_douta; 
    wire [79:0] douta2; 
    reg food_read_en=0; 
    reg reg_is_food; 
   reg wena =0; 
    food_map dual_mem_flush_food_inst (
      .clka(clk),    // input wire clka
      .ena(1),      // input wire ena
      .wea(wena),      // input wire [0 : 0] wea
      .addra($unsigned(pacman_matrix_idx_y)),  // input wire [5 : 0] addra
      .dina(reg_douta),    // input wire [79 : 0] dina
      .douta(douta),  // output wire [79 : 0] douta
      .clkb(food_map_clk),    // input wire clkb
      .enb(1),      // input wire enb

      .web(0),      // input wire [0 : 0] web
      .addrb($unsigned(food_map_read_y)),  // input wire [5 : 0] addrb
      .dinb(dina),    // input wire [79 : 0] dinb
      .doutb(food_row)  // output wire [79 : 0] doutb
    );

                

    reg [5:0] map_idx_y = 0;
    wire [79:0] map_row;

    pacman_map_blockmem map_food(
        .clka(clk),                            
        .addra($unsigned(map_idx_y)),
        .douta(map_row)
    );
    assign en_game = 1;
    reg [5:0] load_game_counter = 0;
    always @(posedge clk) begin
//        en_game <= 1;
        if(reset_en_game == 0) begin
            //en_game <= 1;
            reset_en_game <= 1;
        end
        else begin
            //load_game_counter <= load_game_counter + 1;
            if(en_game == 1'b0) begin
                if(load_game_counter > 49)begin
                    wena <= 0;
                    //en_game <= 1;
                end
                else begin
                    map_idx_y <= load_game_counter;
                    pacman_matrix_idx_y <= load_game_counter;
                    wena <= 1;
                    reg_douta <= map_row;
                    load_game_counter <= load_game_counter+1;
                end 
            
            end
            else begin
                pacman_matrix_idx_x <= (pacman_curr_pos_x - MOVE_TO_CENTER - H_VISIBLE_START) >> 4; 
                pacman_matrix_idx_y <= (pacman_curr_pos_y - MOVE_TO_CENTER - V_VISIBLE_START) >> 4; 
            end
            end
        end
   

										
    assign is_food = reg_is_food; 
endmodule