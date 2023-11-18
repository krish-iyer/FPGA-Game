
module _display_pos_to_map_index_tb();

    reg [10:0]display_pos_x; 
    reg [9:0]display_pos_y; 
    wire [6:0] matrix_idx_x; 
    wire [5:0] matrix_idx_y; 
    
    
   
        
   _display_pos_to_map_index uut_display_map_idx (.display_pos_x(display_pos_x), .display_pos_y(display_pos_y), 
                                                  .matrix_idx_x(matrix_idx_x), .matrix_idx_y(matrix_idx_y) ); 

    initial begin
       
       // I will reverse what I did in the map_index_to_display testbench 
       
        // basic test case 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (0,0)
        display_pos_x = 11'd343; 
        display_pos_y= 10'd34; 
        
        
        #5
        // middle equal indices 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (7,7)
        display_pos_x = 11'd455; 
        display_pos_y= 10'd146; 
        
        #5
        // not equal indices 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (9,5)
        display_pos_x = 11'd487; 
        display_pos_y= 10'd114; 
        
       

        #5 $finish;

    end
    


endmodule
