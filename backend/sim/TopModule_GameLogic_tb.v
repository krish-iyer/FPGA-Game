
module TopModule_GameLogic_tb();

    reg clka;
   
    reg rbtn; 
    reg lbtn; 
    reg ubtn; 
    reg dbtn;
    reg clk; 
    reg rst; 
    wire [10:0]pacman_pos_x; 
    wire [9:0]pacman_pos_y; 
    wire [10:0]blinky_pos_x; 
    wire [9:0]blinky_pos_y; 
    wire [10:0]pinky_pos_x; 
    wire [9:0]pinky_pos_y; 
    wire [10:0]inky_pos_x; 
    wire [9:0]inky_pos_y; 
    wire [10:0]clyde_pos_x; 
    wire [9:0]clyde_pos_y; 
    wire pacman_is_dead;
    wire [3:0]pacman_moving_dir_out; 


    

    wire [6:0] pacman_mat_idx_x, blinky_mat_idx_x, pinky_mat_idx_x, inky_mat_idx_x, clyde_mat_idx_x; 
    wire [5:0] pacman_mat_idx_y, blinky_mat_idx_y, pinky_mat_idx_y, inky_mat_idx_y, clyde_mat_idx_y; 
    // I will make the index representing the center of 16X16 block 
    // also the visible area starting is 336 in horizontal and 27 vertical 
    // the equation to update this given that I have matrix_idx(x,y)
    // display_pos_x = (x << 4 )+ 7 + 336    // multiply by 16 and move to the center in the visible area  
     parameter MOVE_TO_CENTER= 7; 
     parameter H_VISIBLE_START= 336; 
     parameter V_VISIBLE_START= 27;
     parameter SCALING_FACTOR= 16; 
   
    _display_pos_to_map_index topmodule_tb_pacman_pos_to_mat (   
            .display_pos_x(pacman_pos_x),
            .display_pos_y(pacman_pos_y), 
            .matrix_idx_x(pacman_mat_idx_x),
            .matrix_idx_y(pacman_mat_idx_y));
   
    _display_pos_to_map_index topmodule_tb_blinky_pos_to_mat (   
            .display_pos_x(blinky_pos_x),
            .display_pos_y(blinky_pos_y), 
            .matrix_idx_x(blinky_mat_idx_x),
            .matrix_idx_y(blinky_mat_idx_y));

    _display_pos_to_map_index topmodule_tb_pinky_pos_to_mat (   
            .display_pos_x(pinky_pos_x),
            .display_pos_y(pinky_pos_y), 
            .matrix_idx_x(pinky_mat_idx_x),
            .matrix_idx_y(pinky_mat_idx_y));        

    _display_pos_to_map_index topmodule_tb_inky_pos_to_mat (   
            .display_pos_x(inky_pos_x),
            .display_pos_y(inky_pos_y), 
            .matrix_idx_x(inky_mat_idx_x),
            .matrix_idx_y(inky_mat_idx_y));

    _display_pos_to_map_index topmodule_tb_clyde_pos_to_mat (   
            .display_pos_x(clyde_pos_x),
            .display_pos_y(clyde_pos_y), 
            .matrix_idx_x(clyde_mat_idx_x),
            .matrix_idx_y(clyde_mat_idx_y));  

    TopModule_GameLogic uut_TopModule_GameLogic (
                            .rbtn(rbtn), 
                            .lbtn(lbtn),  
                            .ubtn(ubtn), 
                            .dbtn(dbtn),
                            .clk(clka), 
                            .rst(rst), 
                             .pacman_pos_x(pacman_pos_x), 
                             .pacman_pos_y(pacman_pos_y), 
                             .blinky_pos_x(blinky_pos_x), 
                             .blinky_pos_y(blinky_pos_y), 
                             .pinky_pos_x(pinky_pos_x), 
                             .pinky_pos_y(pinky_pos_y), 
                             .inky_pos_x(inky_pos_x), 
                             .inky_pos_y(inky_pos_y), 
                             .clyde_pos_x(clyde_pos_x), 
                             .clyde_pos_y(clyde_pos_y), 
                            .pacman_is_dead(pacman_is_dead),
                             .pacman_moving_dir_out(pacman_moving_dir_out));  
   
                                         

    initial begin
        clka = 1 ; 
        rst =1; 
        # 40 
        rst = 0; 

         
        // # 20     
        // which_sprite values -> 
        // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 

      
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // valid moves are already taken care of by another module
        // the prev_direction is right 0001
        // ghost and pacman are in totally different positions
        // pacman_is_dead -> 0 ;   
         rbtn= 1; 
         lbtn= 0; 
         ubtn= 0; 
         dbtn= 0;
       
         
        

       
        
        
       
       
       
        #11000 $finish;

    end
    
    always #5 clka = ~clka;
    


endmodule
