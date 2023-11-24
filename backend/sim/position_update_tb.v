
module position_update_function_tb();

    reg clka;
    reg rst; 
    
    reg [10:0] curr_pos_x; 
    reg [9:0]  curr_pos_y; 
    reg [3:0]  move_direction;
    reg [2:0]  which_sprite; 
    wire [10:0]new_pos_x; 
    wire [9:0]new_pos_y;
   
    position_update_function uut_position_update_function (
                                 .clk(clka),
                                 .rst(rst),
                                 .curr_pos_x(curr_pos_x),
                                 .curr_pos_y(curr_pos_y),
                                 .move_direction(move_direction),
                                  .which_sprite(which_sprite), 
                                  .new_pos_x(new_pos_x), 
                                  .new_pos_y(new_pos_y));  
   
                                         

    initial begin
        clka = 1 ; 
        rst=0; 
        // # 20     
        // which_sprite values -> 
        // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 

        // middle equal indices 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (7,7) in the curr_position 
        // valid moves are already taken care of by another module
        // the move_direction is left 1000
        // new position: (6, 7) -> (439, 146) 
        
        curr_pos_x = 11'd455; 
        curr_pos_y= 10'd146;
        move_direction= 4'b1000; 
        
        
        
       
       
       #30
        // not equal indices 
        // different values than the previous test cases 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (1,25) in the current position
        // also this allows movement in all directions  but up
        // valid_moves = 4'b 1101; 
        // let say we want to move it down 
        // move_dir= 0100; 
        // new position will be (1,26) -> (359, 450)
        curr_pos_x = 11'd359; 
        curr_pos_y= 10'd434;
        move_direction = 4'b0100;  
    

        #30
        // right boundary point
        // wrap around areas where the character is at the right most gate way
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (79,25)
        // also this allows movement in all directions but up
        // right will move it the left most of the screen   
        // valid_moves = 4'b 1101;
        // if we move it to the right, it should be at the left most of the screen 
        // new position -> (0,25) -> (343,443)
        curr_pos_x = 11'd1607; 
        curr_pos_y= 10'd443; 
        move_direction = 4'b0001; 

        # 30
        // right boundary point
        // it should get the default position for the ghost or pacman depending 
        // on which_sprite because rst is asserted
        // which_sprite values -> 
        // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 
        // reset position for pacman -> (1367, 306)
        rst= 1;
        which_sprite = 0; // pacman  
        



        #100 $finish;

    end
    
    always #5 clka = ~clka;
    


endmodule
