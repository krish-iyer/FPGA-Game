// this function takes the position of pacman or ghosts 
// it returns valid moves 
// this module interacts with the block memory 
// it should read the map in the four directions
// it returns the valid moves
// it is one_hot_encoded 
// 0001-> right [most right position is 1]
// 1000-> left
// 0010-> up
// 0100-> down
// 0110 -> it can move up and down but not right and left
module valid_move_detector (input clk, 
                            input [10:0]curr_pos_x, input [9:0]curr_pos_y, 
							output [3:0] valid_moves);
	

	
    
    wire [6:0]matrix_idx_x; // this represents the index in the data read
    wire [5:0] matrix_idx_y;  // this represents the address in the block memory 
                                  
                                  
	
	_display_pos_to_map_index valid_move_pos_to_map_index_inst (   .display_pos_x(curr_pos_x),
	                                                           .display_pos_y(curr_pos_y), 
                                                               .matrix_idx_x(matrix_idx_x),
                                                               .matrix_idx_y(matrix_idx_y)
                                                            ); 
	
    
      wire [79:0] dout_same_row, dout_below_row, dout_above_row;
        
     // gets the row where the pacman or ghost is in                    
     pacman_map_blockmem valid_move_map_same_row_blockmem (.clka(clk),
                                         
                                         .addra($unsigned(matrix_idx_y)),
                                         
                                         .douta(dout_same_row));
      // gets the row below the character                                   
     pacman_map_blockmem valid_move_map_below_row_blockmem (.clka(clk),
                                         
                                         .addra($unsigned(matrix_idx_y + 1)),
                                         
                                         .douta(dout_below_row));
     
     // gets teh row above the character                                    
     pacman_map_blockmem valid_move_map_above_row_blockmem (.clka(clk),
                                         
                                         .addra($unsigned(matrix_idx_y - 1)),
                                         
                                         .douta(dout_above_row));  
                                         
     
     // don't forget 0 means wall and 1 means food 
     // this means if the value in the direction is 1; then the character can move in that direction; 
     // also the current position for any ghost or pacman will never be at the edges
     // we just need to handle the wrap_around boundary cases 
     
     wire Right, Left, Up, Down;
     parameter MAT_LAST_IDX = 79;
     wire [6:0] right_index=  $unsigned( matrix_idx_x + 1);
     wire [6:0] left_index=  $unsigned( matrix_idx_x - 1);
     assign Right= (matrix_idx_x == MAT_LAST_IDX)? 1 : dout_same_row [ right_index ];                                    
//     assign Left= (matrix_idx_x == 0) ? 1 : dout_same_row [ left_index];   
     assign Left= dout_same_row [ left_index];   
     assign Up = dout_above_row [ $unsigned( matrix_idx_x) ]; 
     assign Down= dout_below_row [ $unsigned( matrix_idx_x) ];                                  
                                                                                                                               
    assign valid_moves= {Left, Down, Up, Right}; 						
    



endmodule 