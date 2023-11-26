// this module takes all the positions of a ghost and pacman
// it returns if pacman is dead or not
// it should use the display to matrix index mapping function
module collision_detection (

    input [10:0]ghost_curr_pos_x, 
	input [9:0]ghost_curr_pos_y,
	input [10:0]pacman_curr_pos_x, 
	input [9:0]pacman_curr_pos_y, 
	output pacman_is_dead
	
	); 
	
	
    wire [6:0]pacman_matrix_idx_x;
    wire [5:0]pacman_matrix_idx_y;

    wire [6:0]ghost_matrix_idx_x;
    wire [5:0] ghost_matrix_idx_y;
                                  
                                  
	
	_display_pos_to_map_index pacman_pos_to_map_index_inst (   .display_pos_x(pacman_curr_pos_x),
	                                                           .display_pos_y(pacman_curr_pos_y), 
                                                               .matrix_idx_x(pacman_matrix_idx_x),
                                                               .matrix_idx_y(pacman_matrix_idx_y)
                            ); 
	
	_display_pos_to_map_index ghost_pos_to_map_index_inst (   .display_pos_x(ghost_curr_pos_x),
	                                                           .display_pos_y(ghost_curr_pos_y), 
                                                               .matrix_idx_x(ghost_matrix_idx_x),
                                                               .matrix_idx_y(ghost_matrix_idx_y)
                            );
                         
	
	assign pacman_is_dead = (pacman_matrix_idx_x == ghost_matrix_idx_x) && (pacman_matrix_idx_y == ghost_matrix_idx_y); 

	
											

endmodule