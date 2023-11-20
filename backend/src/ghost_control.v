// this function takes the positions of the ghost and the pacman
// it also takes the previous ghost_control
// as ghosts don't reverse direction while moving
// return move_direction for the ghost
module ghost_control (
                     input [10:0]ghost_curr_pos_x, 
                    input [9:0]ghost_curr_pos_y, 
                    input [10:0]pacman_curr_pos_x, 
                    input [9:0]pacman_curr_pos_y,
                    input [3:0] prev_direction, 
                    output [3:0]move_direction);
 
  
    
    
	
	
	
	
	wire [3:0] valid_moves;
	valid_move_detector inside_pos_update_valid_move_detector (.curr_pos_x(ghost_curr_pos_x), .curr_pos_y(ghost_curr_pos_y), 
							.valid_moves(valid_moves)); 
							
						
    
    
    // here defines the directions 
    parameter RIGHT= 4'b0001; 
	parameter LEFT=  4'b1000;	
	parameter UP=    4'b0010;
	parameter DOWN=  4'b0100; 
	
	reg [3:0] no_reverse_valid_moves; 
	reg [10:0] vertical_distance; 
	reg [11:0] horizontal_distance;
	
	reg [3:0] reg_move_dir;  
    
    // evaluate valid moves based on the fact that ghosts don't reverse directions
	always @(*) begin
	   
	   case(prev_direction)
	   
           RIGHT:   no_reverse_valid_moves= valid_moves & ~LEFT;
           LEFT:    no_reverse_valid_moves= valid_moves & ~RIGHT;
           UP:      no_reverse_valid_moves= valid_moves & ~DOWN;
           DOWN:    no_reverse_valid_moves= valid_moves & ~UP;    
	   
	   endcase 
   
    end 
    
    // evaluate the horizontal and vertical absolute distances between 
    // pacman and the ghost at hand 
	always @(*) begin
	   
	   if (pacman_curr_pos_x > ghost_curr_pos_x)
	       horizontal_distance = pacman_curr_pos_x - ghost_curr_pos_x; 
	   else 
	   	   horizontal_distance = ghost_curr_pos_x - pacman_curr_pos_x; 

	   
	   if (pacman_curr_pos_y > ghost_curr_pos_y)
	       vertical_distance = pacman_curr_pos_y - ghost_curr_pos_y; 
	   else 
	   	   vertical_distance = ghost_curr_pos_y - pacman_curr_pos_y;    
	  
   
    end 
    
    always @(*) begin
	
	   case(no_reverse_valid_moves)
	   
           RIGHT | UP:      
                if (horizontal_distance < vertical_distance)
                   reg_move_dir = RIGHT;
                else 
                   reg_move_dir= UP; 
               
           RIGHT | DOWN:    
                if (horizontal_distance < vertical_distance)
                   reg_move_dir = RIGHT;
                else 
                   reg_move_dir= DOWN; 
                   
           LEFT | UP:     
                if (horizontal_distance < vertical_distance)
                   reg_move_dir = LEFT;
                else 
                   reg_move_dir= UP; 
           LEFT | DOWN:   
                if (horizontal_distance < vertical_distance)
                   reg_move_dir = LEFT;
                else 
                   reg_move_dir= DOWN;    
	   
	       default:  
	           // here we made the priority for up/down then right/left 
	           // these are not cases we should provide based on the mask 
	           // we created earlier with the previous direction 
	           // it can't assert the right and the left at once 
	           // so is for up and down  
                if (no_reverse_valid_moves & UP == UP)
                   reg_move_dir = UP;
                else if (no_reverse_valid_moves & DOWN == DOWN)
                   reg_move_dir= DOWN; 
                else if (no_reverse_valid_moves & RIGHT == RIGHT)
                   reg_move_dir= RIGHT; 
                else if (no_reverse_valid_moves & LEFT == LEFT)
                   reg_move_dir= LEFT; 
                
                else 
                    reg_move_dir = 4'b0000;   
                  
	   endcase 
   
    end 
    
    assign move_direction= reg_move_dir; 
    
    
	


endmodule