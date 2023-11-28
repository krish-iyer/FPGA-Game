// this function takes the positions of the ghost and the pacman
// it also takes the previous ghost_control
// as ghosts don't reverse direction while moving
// return move_direction for the ghost
module ghost_control (
                     input clk, 
                     input slower_clk, 
                     input rst, 
                     input [10:0]ghost_curr_pos_x, 
                    input [9:0]ghost_curr_pos_y, 
                    input [10:0]pacman_curr_pos_x, 
                    input [9:0]pacman_curr_pos_y,
                    input [3:0] prev_direction, 
                    output [3:0]move_direction);
 

   // wire [3:0] rand_four_bit; 
   // rand_num_gen ghost_rand_num_gen (.clock(clk), .reset(rst), .rand_four_bit(rand_four_bit)); 

	wire [3:0] valid_moves;
	valid_move_detector inside_pos_update_valid_move_detector (.clk(clk), .curr_pos_x(ghost_curr_pos_x), .curr_pos_y(ghost_curr_pos_y), 
							.valid_moves(valid_moves)); 
							
						
    
    
    // here defines the directions 
    parameter RIGHT= 4'b0001; 
	parameter LEFT=  4'b1000;	
	parameter UP=    4'b0010;
	parameter DOWN=  4'b0100; 
   parameter ZEROS= 4'b0000;
	
	reg [3:0] no_reverse_valid_moves;
	reg [10:0] vertical_distance; 
	reg [11:0] horizontal_distance;
	
	reg [3:0] reg_move_dir; 
   reg [3:0] relative_ghost_location_x;
   reg [3:0] relative_ghost_location_y; 
   reg [3:0] final_valid_movements;  

   reg [3:0] mask_rand_bits;  
    
    // evaluate valid moves based on the fact that ghosts don't reverse directions
	always @(posedge slower_clk) begin
	   
	   case(prev_direction)
	   
           RIGHT:   no_reverse_valid_moves <= valid_moves & ~LEFT;
           LEFT:    no_reverse_valid_moves <= valid_moves & ~RIGHT;
           UP:      no_reverse_valid_moves <= valid_moves & ~DOWN;
           DOWN:    no_reverse_valid_moves <= valid_moves & ~UP; 
           default: no_reverse_valid_moves <= valid_moves;    
	   
	   endcase 
   
    end 
    
    // evaluate the horizontal and vertical absolute distances between 
    // pacman and the ghost at hand 
	always @(*) begin
	   
	   if (pacman_curr_pos_x > ghost_curr_pos_x)begin 
	       horizontal_distance  = pacman_curr_pos_x - ghost_curr_pos_x;
          relative_ghost_location_x = RIGHT;
          
      end
      else begin 

	   	   horizontal_distance  = ghost_curr_pos_x - pacman_curr_pos_x;
            relative_ghost_location_x = LEFT; 

        
      end 
	   
	   if (pacman_curr_pos_y > ghost_curr_pos_y)begin 

	       vertical_distance  = pacman_curr_pos_y - ghost_curr_pos_y;
          relative_ghost_location_y= DOWN; 
        
      end  
	   else begin 

	   	   vertical_distance  = ghost_curr_pos_y - pacman_curr_pos_y;  
             relative_ghost_location_y= UP; 
            
      end 

      final_valid_movements = no_reverse_valid_moves & (relative_ghost_location_x | relative_ghost_location_y);
      // mask_rand_bits = no_reverse_valid_moves & rand_four_bit; 
    
    end 
    


   always @(posedge slower_clk) begin
	
	   case(final_valid_movements)
	   
           RIGHT | UP: begin  
               if (horizontal_distance == 0)
                  reg_move_dir  <= UP;
               else if (vertical_distance == 0)
                  reg_move_dir  <= RIGHT; 
               else begin        
                  if (horizontal_distance < vertical_distance)
                     reg_move_dir  <= RIGHT;
                  else 
                     reg_move_dir <= UP; 
               end 
            end

           RIGHT | DOWN: begin  
            if (horizontal_distance == 0)
                  reg_move_dir  <= DOWN;
               else if (vertical_distance == 0)
                  reg_move_dir  <= RIGHT; 
               else begin    
                if (horizontal_distance < vertical_distance)
                   reg_move_dir  <= RIGHT;
                else 
                   reg_move_dir <= DOWN; 
               end 
            end

           LEFT | UP: begin 
               if (horizontal_distance == 0)
                  reg_move_dir  <= UP;
               else if (vertical_distance == 0)
                  reg_move_dir  <= LEFT; 
               else begin     
                if (horizontal_distance < vertical_distance)
                   reg_move_dir  <= LEFT;
                else 
                   reg_move_dir <= UP; 
               end 
            end

           LEFT | DOWN: begin  
               if (horizontal_distance == 0)
                  reg_move_dir  <= DOWN;
               else if (vertical_distance == 0)
                  reg_move_dir  <= LEFT; 
               else begin  
                if (horizontal_distance < vertical_distance)
                   reg_move_dir  <= LEFT;
                else 
                   reg_move_dir <= DOWN;    
               end
            end

             // here we made the priority  right/left for then up/down  
            RIGHT: reg_move_dir  <= RIGHT; 
            LEFT: reg_move_dir <= LEFT;
            UP:  reg_move_dir  <= UP;
            DOWN: reg_move_dir  <= DOWN;
            

	         default: begin  
	           
                
               // if (no_reverse_valid_moves == (RIGHT | UP)) begin 

               //    if (horizontal_distance == 0)
               //       reg_move_dir  <= UP;
               //    else if (vertical_distance == 0)
               //       reg_move_dir  <= RIGHT; 
               //    else begin        
               //       if (horizontal_distance < vertical_distance)
               //          reg_move_dir  <= RIGHT;
               //       else 
               //          reg_move_dir <= UP; 
               //    end

               // end 
               // else if (no_reverse_valid_moves == ( RIGHT | DOWN)) begin 

               //    if (horizontal_distance == 0)
               //       reg_move_dir  <= DOWN;
               //    else if (vertical_distance == 0)
               //       reg_move_dir  <= RIGHT; 
               //    else begin    
               //    if (horizontal_distance < vertical_distance)
               //       reg_move_dir  <= RIGHT;
               //    else 
               //       reg_move_dir <= DOWN; 
               //    end 

               // end
               // else if (no_reverse_valid_moves == ( LEFT | UP)) begin 

               //    if (horizontal_distance == 0)
               //       reg_move_dir  <= UP;
               //    else if (vertical_distance == 0)
               //       reg_move_dir  <= LEFT; 
               //    else begin     
               //    if (horizontal_distance < vertical_distance)
               //       reg_move_dir  <= LEFT;
               //    else 
               //       reg_move_dir <= UP; 
               //    end

               // end 
               // else if (no_reverse_valid_moves == ( LEFT | DOWN)) begin 

               //    if (horizontal_distance == 0)
               //       reg_move_dir  <= DOWN;
               //    else if (vertical_distance == 0)
               //       reg_move_dir  <= LEFT; 
               //    else begin  
               //    if (horizontal_distance < vertical_distance)
               //       reg_move_dir  <= LEFT;
               //    else 
               //       reg_move_dir <= DOWN;    
               //    end

               // end 

            // here we made the priority  right/left for then up/down 
	           // these are not cases we should provide based on the mask 
	           // we created earlier with the previous direction 
	           // it can't assert the right and the left at once 
	           // so is for up and down 
               // if (mask_rand_bits != 0) begin 
               //    if ((mask_rand_bits & RIGHT) !=0)
               //       reg_move_dir <= RIGHT; 
               //    else if ((mask_rand_bits & LEFT) != 0 )
               //       reg_move_dir <= LEFT;  
               //    else if ((mask_rand_bits & UP) != 0)
               //       reg_move_dir  <= UP;
               //    else if ((mask_rand_bits & DOWN) !=0)
               //       reg_move_dir <= DOWN;  
               // end 
               // else begin 
                  if ((no_reverse_valid_moves & RIGHT) !=0)
                     reg_move_dir <= RIGHT; 
                  else if ((no_reverse_valid_moves & LEFT) != 0 )
                     reg_move_dir <= LEFT;  
                  else if ((no_reverse_valid_moves & UP) != 0)
                     reg_move_dir  <= UP;
                  else if ((no_reverse_valid_moves & DOWN) !=0)
                     reg_move_dir <= DOWN; 
               // end
                
                  
            end 
                  
	   endcase 
   
    end 
    
    assign move_direction= reg_move_dir; 
    
    
	


endmodule