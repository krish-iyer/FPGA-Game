// this function takes the move direction from the input function
// it also takes the current position (x,y)
// it returns the updated position for any sprite
// it uses Map index to display Helper Function
// it also uses teh valid move detector function to detect if the move is valid 
module position_update_function (
                                input clk, 
                                input slower_clk,
                                 input rst,
                                 input [10:0]curr_pos_x,
                                 input [9:0]curr_pos_y,
                                 input [3:0]move_direction,
                                 input [2:0] which_sprite, 
                                 output [10:0]new_pos_x, 
                                 output [9:0]new_pos_y);
 
    // here defines the reset positions for the sprites 
    // we assume the  matrix 
    // all default positions are taken from the random_position file 
    // created on the create_map branch 
    // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 
        
//        parameter MOVE_TO_CENTER= 7; 
     // parameter H_VISIBLE_START= 336; 
     // parameter V_VISIBLE_START= 27; 

        parameter RATIO = 16; 
        parameter MOVE_TO_CENTER= 0; 
     parameter H_VISIBLE_START= 0; 
     parameter V_VISIBLE_START= 0;

    parameter PACMAN= 0;
    parameter PACMAN_X=39;
    parameter PACMAN_Y=2;
    parameter PACMAN_RESET_POS_X= PACMAN_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter PACMAN_RESET_POS_Y= PACMAN_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter BLINKY=1; 
    parameter BLINKY_X=20; 
    parameter BLINKY_Y=25; 
    parameter BLINKY_RESET_POS_X= BLINKY_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter BLINKY_RESET_POS_Y= BLINKY_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter PINKY=2;
    parameter PINKY_X=17; 
    parameter PINKY_Y=14; 
    parameter PINKY_RESET_POS_X= PINKY_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter PINKY_RESET_POS_Y= PINKY_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter INKY=3;
    parameter INKY_X=10; 
    parameter INKY_Y=2; 
    parameter INKY_RESET_POS_X= INKY_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter INKY_RESET_POS_Y= INKY_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter CLYDE=4;
    parameter CLYDE_X=17; 
    parameter CLYDE_Y=21; 
    parameter CLYDE_RESET_POS_X= CLYDE_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter CLYDE_RESET_POS_Y= CLYDE_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    
    // here defines the directions 
    parameter RIGHT= 4'b0001; 
	parameter LEFT=  4'b1000;	
	parameter UP=    4'b0010;
	parameter DOWN=  4'b0100; 
	
	// this is the distance between the center of blocks 
	parameter DISTANCE_BETWEEN_BLOCKS= 16; 
	
	// here defines the wrap_around positions
	// if pacman or ghosts are at the right most and 
	// they get out of the screen it will come to the left most 
	// also this check will be good to make sure the characters 
	// are not out of display 
    // here Right and Left wrap around positions corresponds to x 	
    // otherwise corresponds to y
    // Keep in mind that the starting visible area are: 
    // horizontally 336 
    // vertically 27 

     

    parameter WRAP_RIGHT= 1 * RATIO + H_VISIBLE_START + MOVE_TO_CENTER; // get it to the the left of the screen [x=7+336]
    parameter WRAP_LEFT= 79 * RATIO + H_VISIBLE_START + MOVE_TO_CENTER; // assuming that matrix is 80X50 [x=79*16+7+336]
    parameter WRAP_UP= 49 * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;  //get it to the bottom of the screen [y=49*16+7+27]
    parameter WRAP_DOWN= 0 * RATIO + V_VISIBLE_START + MOVE_TO_CENTER; // get it to the top of the screen [y=7+27]
    
	wire [3:0] valid_moves;
	reg [10:0]reg_new_pos_x; 
	reg [9:0]reg_new_pos_y; 
	
	
	
	
	valid_move_detector inside_pos_update_valid_move_detector (.clk(clk),.curr_pos_x(curr_pos_x), .curr_pos_y(curr_pos_y), 
							.valid_moves(valid_moves));
	
	always @(posedge slower_clk or posedge rst) begin
     
        if (rst)begin 
            case (which_sprite)
                PACMAN:begin 
                        reg_new_pos_x <= PACMAN_RESET_POS_X; 
                        reg_new_pos_y <= PACMAN_RESET_POS_Y; 
                        end 
                BLINKY:begin 
                        reg_new_pos_x <= BLINKY_RESET_POS_X; 
                        reg_new_pos_y<= BLINKY_RESET_POS_Y; 
                        end 
                PINKY:begin 
                        reg_new_pos_x <= PINKY_RESET_POS_X; 
                        reg_new_pos_y<= PINKY_RESET_POS_Y; 
                        end 
                INKY:begin 
                        reg_new_pos_x <= INKY_RESET_POS_X; 
                        reg_new_pos_y<= INKY_RESET_POS_Y; 
                        end 
                CLYDE:begin 
                        reg_new_pos_x <= CLYDE_RESET_POS_X; 
                        reg_new_pos_y<= CLYDE_RESET_POS_Y; 
                        end                                                                                    
            
            endcase
        
         
        end 
            
        
        else begin 
            if ((move_direction == RIGHT) && 
                 ((valid_moves & RIGHT) != 0)) begin 
                 
                 // wrap around for the right move 
                 if ((curr_pos_x + DISTANCE_BETWEEN_BLOCKS) > WRAP_LEFT) 
                        reg_new_pos_x <= WRAP_RIGHT; 
                 else 
                    reg_new_pos_x<= curr_pos_x + DISTANCE_BETWEEN_BLOCKS; 
                    
                 reg_new_pos_y<= curr_pos_y; 
            
            
            end 
            else if ((move_direction == LEFT) && 
                    ((valid_moves & LEFT) != 0)) begin  
                 
                 if ((curr_pos_x - DISTANCE_BETWEEN_BLOCKS)< WRAP_RIGHT)
                    reg_new_pos_x<= WRAP_LEFT; 
                 else 
                    reg_new_pos_x<= curr_pos_x - DISTANCE_BETWEEN_BLOCKS;
                     
                 reg_new_pos_y<= curr_pos_y; 
            
            
            end 
            else if ((move_direction == UP) && 
                     ((valid_moves & UP) != 0)) begin 
                     
                     reg_new_pos_x<= curr_pos_x; 
                     
                     if ((curr_pos_y - DISTANCE_BETWEEN_BLOCKS) < WRAP_DOWN)
                        reg_new_pos_y <= WRAP_UP; 
                     else 
                        reg_new_pos_y<= curr_pos_y - DISTANCE_BETWEEN_BLOCKS;
                        
                     
                       
            
            
            end 
            else if ((move_direction == DOWN) && 
                    ((valid_moves & DOWN) != 0)) begin 

                    reg_new_pos_x<= curr_pos_x;  
                    
                    if ((curr_pos_y + DISTANCE_BETWEEN_BLOCKS)> WRAP_UP)
                        reg_new_pos_y <= WRAP_DOWN; 
                    else 
                        reg_new_pos_y<= curr_pos_y + DISTANCE_BETWEEN_BLOCKS;
                        
                    
                    
            
            
            end          
            else begin 
                    reg_new_pos_x <= curr_pos_x; 
                    reg_new_pos_y <= curr_pos_y; 
            
            end 
        end  
            
    end 
    
    assign new_pos_x = reg_new_pos_x; 
    assign new_pos_y = reg_new_pos_y; 
	


endmodule