// this function maps a matrix position to the actual display positions

// this function also should  the resolution of the VGA
// and the dimension of the matrix to represent how
// many pixels is at every index
// for now we will not make a division as the circuit is not 
// synthesizable; instead we will allow fixed combinations

// 1615 -> horizontal display max [11 bits]
// 826 -> vertical display max [10 bits]
// make sure you wrap around those two numbers
// The visible region is
// horizontally between 336 and 1615 inclusive,
// vertically between 27 and 826 inclusive.
// that gives us a display of 1280 X 800 

// we chose the matrix to be 80 X 50 
// this matches the original ratio as well 
// each pixel represents 16x16 pixels in the original display
// matrix_idx_x -> 7 bits
// matrix_idx_y -> 6 bits 
// this function takes the matrix id and it returns the actual position in the display
module _map_index_to_display (input [6:0]matrix_idx_x, input [5:0]matrix_idx_y,
                            output [10:0]display_pos_x, output [9:0]display_pos_y); 
                            

     // I will make the index representing the center of 16X16 block 
     // also the visible area starting is 336 in horizontal and 27 vertical 
     // the equation to update this given that I have matrix_idx(x,y)
     // display_pos_x = (x << 4 )+ 7 + 336    // multiply by 16 and move to the center in the visible area  
     parameter MOVE_TO_CENTER= 7; 
     parameter H_VISIBLE_START= 336; 
     parameter V_VISIBLE_START= 27; 
     assign display_pos_x= (matrix_idx_x << 4) + MOVE_TO_CENTER + H_VISIBLE_START; 
     assign display_pos_y= (matrix_idx_y << 4) + MOVE_TO_CENTER + V_VISIBLE_START; 
     
     

     
     
     
                   


endmodule
