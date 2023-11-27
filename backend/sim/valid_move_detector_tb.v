
module valid_move_detector_tb();

    reg clka;
    
    reg [10:0]display_pos_x; 
    reg [9:0]display_pos_y; 
    wire [3:0] valid_moves; 
   
    valid_move_detector uut_valid_move_detector (.clk(clka), .curr_pos_x(display_pos_x), .curr_pos_y(display_pos_y), 
							.valid_moves(valid_moves));  
   
                                         

    initial begin
        clka = 1 ; 
        // # 20     
        // I will reverse what I did in the map_index_to_display testbench 

        // middle equal indices 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (7,7) 
        // also this allows movement in all directions but the right  
        // valid_moves = 4'b 1110; 
        display_pos_x = 11'd455; 
        display_pos_y= 10'd146; 
        
        
       
       
       #30
        // not equal indices 
        // different values than the previous test cases 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (1,25)
        // also this allows movement in all directions  but up
        // valid_moves = 4'b 1101; 
        display_pos_x = 11'd359; 
        display_pos_y= 10'd434; 
        
        #30
        // not equal indices 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (13,5)
        // also this allows movement in all directions 
        // valid_moves = 4'b 1111; 
        display_pos_x = 11'd551; 
        display_pos_y= 10'd114; 

        #30
        // right boundary point
        // wrap around areas where the character is at the right most gate way
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (79,25)
        // also this allows movement in all directions but up
        // right will move it the left most of the screen   
        // valid_moves = 4'b 1101; 
        display_pos_x = 11'd1607; 
        display_pos_y= 10'd443; 
        #100 $finish;

    end
    
    always #5 clka = ~clka;
    


endmodule
