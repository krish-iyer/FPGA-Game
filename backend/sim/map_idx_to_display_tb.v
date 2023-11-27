


module _map_index_to_display_tb();

    reg [6:0] matrix_idx_x; 
    reg [5:0] matrix_idx_y; 
    wire [10:0]display_pos_x; 
    wire [9:0]display_pos_y; 
    
   
        
   _map_index_to_display uut_map_idx_display (.matrix_idx_x(matrix_idx_x), .matrix_idx_y(matrix_idx_y), 
                                                 .display_pos_x(display_pos_x), .display_pos_y(display_pos_y)); 

    initial begin
       
        // basic test case 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (343,34)
        matrix_idx_x = 7'd0; 
        matrix_idx_y= 6'd0; 
        
        # 5
        
        // middle equal indices 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (455,146)
        matrix_idx_x = 7'd7; 
        matrix_idx_y= 6'd7; 
        
        #5
        // not equal indices 
        // keeping the movement to the center with 7 pixels and 
        // keeping the visible area in mind (336,27)
        // should produce (487,114)
        matrix_idx_x = 7'd9; 
        matrix_idx_y= 6'd5;
  
        
       

        #5 $finish;

    end
    


endmodule
