// this module takes all the positions of a ghost and pacman
// it returns if pacman is dead or not
// it should use the display to matrix index mapping function
module collision_detection (

    input clk, 
	input [10:0]pacman_curr_pos_x, 
	input [9:0]pacman_curr_pos_y
	
	); 
	
	
    wire [6:0]pacman_matrix_idx_x;
    wire [5:0]pacman_matrix_idx_y;

    
                                  
                                  
	
	_display_pos_to_map_index pacman_pos_to_map_index_inst (   .display_pos_x(pacman_curr_pos_x),
	                                                           .display_pos_y(pacman_curr_pos_x), 
                                                               .matrix_idx_x(pacman_matrix_idx_x),
                                                               .matrix_idx_y(pacman_matrix_idx_y)
                            ); 
	
	wire [79:0] dina; 
    wire [79:0] douta;
    wire [79:0] douta2; 

    food_map flush_food_inst (
        .clka(clk),    // input wire clka
        .ena(1),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra($unsigned(pacman_matrix_idx_y)),  // input wire [5 : 0] addra
        .dina(dina),    // input wire [79 : 0] dina
        .douta(douta)  // output wire [79 : 0] douta
    );                     

    assign douta[pacman_matrix_idx_x] = 0;              
    assign dina = douta 
	
    food_map flush_food_inst2 (
        .clka(clk),    // input wire clka
        .ena(1),      // input wire ena
        .wea(1),      // input wire [0 : 0] wea
        .addra($unsigned(pacman_matrix_idx_y)),  // input wire [5 : 0] addra
        .dina(dina),    // input wire [79 : 0] dina
        .douta(douta2)  // output wire [79 : 0] douta
    );  
											

endmodule