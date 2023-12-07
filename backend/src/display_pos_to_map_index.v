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

// if these values are taken care of by the FrontEnd, just make it all zeros in a parameterized fashion

// this function takes the actual position of the display and returns back matrix_indices

module _display_pos_to_map_index (input [10:0]display_pos_x, input [9:0]display_pos_y, 
                                  output [6:0]matrix_idx_x, output [5:0]matrix_idx_y
                            ); 
                            

     // I will make the index representing the center of 16X16 block 
     // also the visible area starting is 336 in horizontal and 27 vertical 
     // the equation to update this given that I have display_pos(x,y)
     // matrix_idx = (x - 7-336 ) >> 4   // move it back from the center and out of the visible region and divide by the ratio which is 16
     
//     parameter MOVE_TO_CENTER= 7; 
//      parameter H_VISIBLE_START= 336; 
//      parameter V_VISIBLE_START= 27; 

    parameter MOVE_TO_CENTER= 0;
     parameter H_VISIBLE_START= 0; 
     parameter V_VISIBLE_START= 0; 
     assign matrix_idx_x= (display_pos_x - MOVE_TO_CENTER - H_VISIBLE_START) >> 4; 
     assign matrix_idx_y= (display_pos_y - MOVE_TO_CENTER - V_VISIBLE_START) >> 4; 
     
                           


endmodule
