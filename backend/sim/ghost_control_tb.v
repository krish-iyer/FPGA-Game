
module ghost_control_tb();

    reg clka;
   
    
    reg [10:0]ghost_curr_pos_x; 
    reg [9:0]ghost_curr_pos_y; 
    reg [10:0]pacman_curr_pos_x; 
    reg [9:0]pacman_curr_pos_y;
    reg [3:0] prev_direction; 
    wire [3:0]move_direction;

    reg [6:0] ghost_mat_idx_x, pacman_mat_idx_x; 
    reg [5:0] ghost_mat_idx_y, pacman_mat_idx_y; 

    // I will make the index representing the center of 16X16 block 
    // also the visible area starting is 336 in horizontal and 27 vertical 
    // the equation to update this given that I have matrix_idx(x,y)
    // display_pos_x = (x << 4 )+ 7 + 336    // multiply by 16 and move to the center in the visible area  
     parameter MOVE_TO_CENTER= 7; 
     parameter H_VISIBLE_START= 336; 
     parameter V_VISIBLE_START= 27;
     parameter SCALING_FACTOR= 16; 
   
   
    ghost_control uut_ghost_control (
                                    .clk(clka),
                                    .ghost_curr_pos_x(ghost_curr_pos_x), 
                                    .ghost_curr_pos_y(ghost_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(prev_direction), 
                                    .move_direction(move_direction));  
   
                                         

    initial begin
        clka = 1 ; 
         
        // # 20     
        // which_sprite values -> 
        // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 

        
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // valid moves are already taken care of by another module
        // the prev_direction is right 0001
        // ghost will have only two directions right and down 
        // based on the distance it should move down 
        // moving_direction 0100;  
        ghost_mat_idx_x= 28; 
        ghost_mat_idx_y= 21; 
        pacman_mat_idx_x= 38; 
        pacman_mat_idx_y= 27; 
        ghost_curr_pos_x = ghost_mat_idx_x * SCALING_FACTOR + H_VISIBLE_START + MOVE_TO_CENTER; 
        ghost_curr_pos_y= ghost_mat_idx_y * SCALING_FACTOR + V_VISIBLE_START + MOVE_TO_CENTER;
        pacman_curr_pos_x = pacman_mat_idx_x * SCALING_FACTOR + H_VISIBLE_START + MOVE_TO_CENTER;; 
        pacman_curr_pos_y= pacman_mat_idx_y * SCALING_FACTOR + V_VISIBLE_START + MOVE_TO_CENTER;;
        prev_direction= 4'b0001; // right  
        

        #30
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // valid moves are already taken care of by another module
        // the prev_direction is right 0001
        // based on the distance it should move down 
        // moving_direction 0100;  
        ghost_mat_idx_x= 29; 
        ghost_mat_idx_y= 23; 
        pacman_mat_idx_x= 29; 
        pacman_mat_idx_y= 28; 
        ghost_curr_pos_x = ghost_mat_idx_x * SCALING_FACTOR + H_VISIBLE_START + MOVE_TO_CENTER; 
        ghost_curr_pos_y= ghost_mat_idx_y * SCALING_FACTOR + V_VISIBLE_START + MOVE_TO_CENTER;
        pacman_curr_pos_x = pacman_mat_idx_x * SCALING_FACTOR + H_VISIBLE_START + MOVE_TO_CENTER;; 
        pacman_curr_pos_y= pacman_mat_idx_y * SCALING_FACTOR + V_VISIBLE_START + MOVE_TO_CENTER;;
        prev_direction= 4'b0001; // right
        
        
       
       
       
        #100 $finish;

    end
    
    always #5 clka = ~clka;
    


endmodule
