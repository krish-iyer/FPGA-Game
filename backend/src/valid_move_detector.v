// this function takes the position of pacman or ghosts 
// it returns valid moves 
// this module interacts with the block memory 
// it should read the map in the four directions
// it returns the valid moves
// it is one_hot_encoded 
// 0001-> right [most right position is 1]
// 1000-> left
// 0010-> up
// 0100-> down
// 0110 -> it can move up and down but not right and left
module valid_move_detector (input clk, input rst, 
                            input [10:0]curr_pos_x, input [9:0]curr_pos_y, 
							output [3:0] valid_moves);
	
	reg [3:0] reg_valid_moves; 	
	parameter RIGHT= 4'b0001; 
	parameter LEFT=  4'b1000;	
	parameter UP=    4'b0010;
	parameter DOWN=  4'b0100;  	
	
	// TODO TODO TODO TODO TODO	
	// TODO TODO TODO TODO TODO	
	// TODO TODO TODO TODO TODO	
	// TODO TODO TODO TODO TODO	
	// TODO TODO TODO TODO TODO	
	// TODO TODO TODO TODO TODO	
    // this code will be updated later 
    // it is now allowing all moves, but later it will use the memory block 
    // to extract the date from it and return the valid moves 
    always @(posedge clk, rst) begin
     
        if (rst)
            reg_valid_moves= 4'b0000;
        
        else begin 
            reg_valid_moves= RIGHT & LEFT & UP & DOWN; 
        end  
            
    end 	
    
    assign valid_moves= reg_valid_moves; 						
    



endmodule 