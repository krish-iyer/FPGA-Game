// this function takes the move direction from the input function
// it also takes the current position (x,y)
// it returns the updated position for any sprite
// it uses Map index to display Helper Function
// it also uses teh valid move detector function to detect if the move is valid 
module position_update_function (input clk,
                                 input rst,
                                 input [10:0]curr_pos_x,
                                 input [9:0]curr_pos_y,
                                 input [3:0]move_direction,
                                 input [2:0] which_sprite, 
                                 output [10:0]new_pos_x, 
                                 output [9:0]new_pos_y);
 
    // here defines the reset positions for the sprites 
    parameter PACMAN= 0;
    parameter PACMAN_RESET_POS_X= 11'd10;
    parameter PACMAN_RESET_POS_Y= 10'd10;
    
    parameter BLINKY=1; 
    parameter BLINKY_POS_X= 11'd10;
    parameter BLINKY_RESET_POS_Y= 10'd10;
    
    parameter PINKY=2; 
    parameter PINKY_RESET_POS_X= 11'd10;
    parameter PINKY_RESET_POS_Y= 10'd10;
    
    parameter INKY=3; 
    parameter INKY_RESET_POS_X= 11'd10;
    parameter INKY_RESET_POS_Y= 10'd10;
    
    parameter CLYDE=4; 
    parameter CLYDE_RESET_POS_X= 11'd10;
    parameter CLYDE_RESET_POS_Y= 10'd10;
    
    
    // here defines the directions 
    parameter RIGHT= 4'b0001; 
	parameter LEFT=  4'b1000;	
	parameter UP=    4'b0010;
	parameter DOWN=  4'b0100; 
	
	parameter DISTANCE_BETWEEN_BLOCKS= 15; 
	
	wire [3:0] valid_moves;
	reg [10:0]reg_new_pos_x; 
	reg [9:0]reg_new_pos_y; 
	
	
	valid_move_detector inside_pos_update_valid_move_detector (.curr_pos_x(curr_pos_x), .curr_pos_y(curr_pos_y), 
							.valid_moves(valid_moves));
	
	always @(posedge clk, rst) begin
     
        if (rst)begin 
            case (which_sprite)
                PACMAN:begin 
                        reg_new_pos_x = PACMAN_RESET_POS_X; 
                        reg_new_pos_y= PACMAN_RESET_POS_Y; 
                        end 
                BLINKY:begin 
                        reg_new_pos_x = BLINKY_RESET_POS_X; 
                        reg_new_pos_y= BLINKY_RESET_POS_Y; 
                        end 
                PINKY:begin 
                        reg_new_pos_x = PINKY_RESET_POS_X; 
                        reg_new_pos_y= PINKY_RESET_POS_Y; 
                        end 
                INKY:begin 
                        reg_new_pos_x = INKY_RESET_POS_X; 
                        reg_new_pos_y= INKY_RESET_POS_Y; 
                        end 
                CLYDE:begin 
                        reg_new_pos_x = CLYDE_RESET_POS_X; 
                        reg_new_pos_y= CLYDE_RESET_POS_Y; 
                        end                                                                                    
            
            endcase
        
         
        end 
            
        
        else begin 
            if ((move_direction == RIGHT) && 
                 ((valid_moves & RIGHT) != 0)) begin  
                 
                 reg_new_pos_x= curr_pos_x + DISTANCE_BETWEEN_BLOCKS; 
                 reg_new_pos_y= curr_pos_y; 
            
            
            end 
            else if ((move_direction == LEFT) && 
                    ((valid_moves & LEFT) != 0)) begin  
                    
                 reg_new_pos_x= curr_pos_x - DISTANCE_BETWEEN_BLOCKS; 
                 reg_new_pos_y= curr_pos_y; 
            
            
            end 
            else if ((move_direction == UP) && 
                     ((valid_moves & UP) != 0)) begin 
                     
                     reg_new_pos_x= curr_pos_x; 
                     reg_new_pos_y= curr_pos_y + DISTANCE_BETWEEN_BLOCKS;  
            
            
            end 
            else if ((move_direction == DOWN) && 
                    ((valid_moves & DOWN) != 0)) begin  
                    
                    reg_new_pos_x= curr_pos_x; 
                    reg_new_pos_y= curr_pos_y - DISTANCE_BETWEEN_BLOCKS;
            
            
            end          
            else begin 
                    reg_new_pos_x = curr_pos_x; 
                    reg_new_pos_y = curr_pos_y; 
            
            end 
        end  
            
    end 
    
    assign new_pos_x = reg_new_pos_x; 
    assign new_pos_y = reg_new_pos_y; 
	


endmodule