// this function takes the positions of the ghost and the pacman
// it also takes the previous ghost_control
// as ghosts don't reverse direction while moving
// return move_direction for the ghost
module ghost_control (
                     input clk, 
                     input [10:0]ghost_curr_pos_x, 
                    input [9:0]ghost_curr_pos_y, 
                    input [10:0]pacman_curr_pos_x, 
                    input [9:0]pacman_curr_pos_y,
                    input [3:0] prev_direction, 
                    output [3:0]move_direction);
 
  
    
    
	
	
	
	
	wire [3:0] valid_moves;
	valid_move_detector inside_pos_update_valid_move_detector (.clk(clk), .curr_pos_x(ghost_curr_pos_x), .curr_pos_y(ghost_curr_pos_y), 
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
   reg [3:0] relative_ghost_location_x;
   reg [3:0] relative_ghost_location_y; 
   wire [3:0] final_valid_movements;  

    
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
	   
	   if (pacman_curr_pos_x > ghost_curr_pos_x)begin 
	       horizontal_distance = pacman_curr_pos_x - ghost_curr_pos_x;
          // if right and left are valid moves, then mask one based on the relative position
          // in this case, it is right
          if ((no_reverse_valid_moves & RIGHT != 0) && (no_reverse_valid_moves & LEFT != 0)  ) 
               relative_ghost_location_x = no_reverse_valid_moves & ~LEFT;
               // relative_ghost_location = 4'b0000;
            else 
               relative_ghost_location_x= no_reverse_valid_moves; 
      end
      else begin 
	   	   horizontal_distance = ghost_curr_pos_x - pacman_curr_pos_x;
            // if right and left are valid moves, then mask one based on the relative position
          // in this case, it is left
            if ((no_reverse_valid_moves & RIGHT != 0) && (no_reverse_valid_moves & LEFT != 0)  ) 
               relative_ghost_location_x = no_reverse_valid_moves & ~RIGHT; 
               // relative_ghost_location = 4'b0000;
            else 
               relative_ghost_location_x= no_reverse_valid_moves; 
      end 
	   
	   if (pacman_curr_pos_y > ghost_curr_pos_y)begin 
	       vertical_distance = pacman_curr_pos_y - ghost_curr_pos_y;
           // if up and down are valid moves, then mask one based on the relative position
          // in this case, it is down 
            if ((no_reverse_valid_moves & UP != 0) && (no_reverse_valid_moves & DOWN != 0)  ) 
               relative_ghost_location_y = no_reverse_valid_moves & ~UP; 
               // relative_ghost_location = 4'b0000;
            else 
               relative_ghost_location_y= no_reverse_valid_moves; 
      end  
	   else begin 
	   	   vertical_distance = ghost_curr_pos_y - pacman_curr_pos_y;  
             // if up and down are valid moves, then mask one based on the relative position
            // in this case, it is up 
            if ((no_reverse_valid_moves & UP != 0) && (no_reverse_valid_moves & DOWN != 0)  ) 
               relative_ghost_location_y = no_reverse_valid_moves & ~DOWN;  
               // relative_ghost_location = 4'b0000;
            else 
               relative_ghost_location_y= no_reverse_valid_moves; 
      end 
   
    end 
    
   assign final_valid_movements = no_reverse_valid_moves & relative_ghost_location_x & relative_ghost_location_x; 
    always @(*) begin
	
	   case(final_valid_movements)
	   
           RIGHT | UP:
               if (horizontal_distance == 0)
                  reg_move_dir = UP;
               else if (vertical_distance == 0)
                  reg_move_dir = RIGHT; 
               else begin        
                  if (horizontal_distance < vertical_distance)
                     reg_move_dir = RIGHT;
                  else 
                     reg_move_dir= UP; 
               end 
           RIGHT | DOWN:
            if (horizontal_distance == 0)
                  reg_move_dir = DOWN;
               else if (vertical_distance == 0)
                  reg_move_dir = RIGHT; 
               else begin    
                if (horizontal_distance < vertical_distance)
                   reg_move_dir = RIGHT;
                else 
                   reg_move_dir= DOWN; 
               end 
           LEFT | UP:
               if (horizontal_distance == 0)
                  reg_move_dir = UP;
               else if (vertical_distance == 0)
                  reg_move_dir = LEFT; 
               else begin     
                if (horizontal_distance < vertical_distance)
                   reg_move_dir = LEFT;
                else 
                   reg_move_dir= UP; 
               end 
           LEFT | DOWN: 
               if (horizontal_distance == 0)
                  reg_move_dir = DOWN;
               else if (vertical_distance == 0)
                  reg_move_dir = LEFT; 
               else begin  
                if (horizontal_distance < vertical_distance)
                   reg_move_dir = LEFT;
                else 
                   reg_move_dir= DOWN;    
               end 
	       default:  
	           // here we made the priority for up/down then right/left 
	           // these are not cases we should provide based on the mask 
	           // we created earlier with the previous direction 
	           // it can't assert the right and the left at once 
	           // so is for up and down  
                if (final_valid_movements & UP == UP)
                   reg_move_dir = UP;
                else if (final_valid_movements & DOWN == DOWN)
                   reg_move_dir= DOWN; 
                else if (final_valid_movements & RIGHT == RIGHT)
                   reg_move_dir= RIGHT; 
                else if (final_valid_movements & LEFT == LEFT)
                   reg_move_dir= LEFT; 
                
                else 
                    reg_move_dir = UP;
                  //   reg_move_dir = 4'b0000;   

                  
	   endcase 
   
    end 
    
    assign move_direction= reg_move_dir; 
    
    
	


endmodule