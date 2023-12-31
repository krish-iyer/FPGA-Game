
module flush_eaten_food_tb();

    reg clka;
   
    
    
    reg [10:0]pacman_curr_pos_x; 
    reg [9:0]pacman_curr_pos_y;
    

    reg [6:0]  pacman_mat_idx_x; 
    reg [5:0] pacman_mat_idx_y; 
//    reg [5:0] next_cycle_pacman_mat_idx_y; 
    // I will make the index representing the center of 16X16 block 
    // also the visible area starting is 336 in horizontal and 27 vertical 
    // the equation to update this given that I have matrix_idx(x,y)
    // display_pos_x = (x << 4 )+ 7 + 336    // multiply by 16 and move to the center in the visible area  
     parameter MOVE_TO_CENTER= 0; 
     parameter H_VISIBLE_START= 0; 
     parameter V_VISIBLE_START= 0;
     parameter SCALING_FACTOR= 16; 

//     wire [79:0] sim_dina; 
//    wire [79:0] sim_douta;
    
 

//    food_map uut_sim_flush_food_inst (
//        .clka(clka),    // input wire clka
//        .ena(1),      // input wire ena
//        .wea(0),      // input wire [0 : 0] wea
//        .addra($unsigned(next_cycle_pacman_mat_idx_y)),  // input wire [5 : 0] addra
//        .dina(sim_dina),    // input wire [79 : 0] dina
//        .douta(sim_douta)  // output wire [79 : 0] douta
//    );
   
   reg food_map_clk;
	reg [5:0] food_map_read_y;
	wire [79:0] food_row;
	wire is_food;
	
	 wire slower_clk_2; 
	 
	  
    clk_div  #(.DIV(2)) flush_uut_clkdiv2(
        .clk(clka),
        .clk_out (slower_clk_2)
    );
    
	
	
   
    flush_eaten_food uut_flush_eaten_food (
                                    
                                    .clk(clka), 
                                    .slower_clk(slower_clk_2), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y), 
                                    .food_map_clk(food_map_clk), 
                                    .food_map_read_y (food_map_read_y), 
                                    .food_row(food_row), 
                                    .is_food (is_food)
                                    );  
   
                                         

    initial begin
        clka = 0 ; 
        food_map_clk =0; 
         
        // # 20     
        // which_sprite values -> 
        // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 

        
        // see the block memory to see if the bit has flipped to zero   
        
        pacman_mat_idx_x= 38; 
        pacman_mat_idx_y= 27;
        food_map_read_y= 27;  
        pacman_curr_pos_x = pacman_mat_idx_x * SCALING_FACTOR 
                            + H_VISIBLE_START + MOVE_TO_CENTER; 
        pacman_curr_pos_y= pacman_mat_idx_y * SCALING_FACTOR 
                            + V_VISIBLE_START + MOVE_TO_CENTER;
         
        

        #90
         
        // see the contents of the block memory at this particular instance
//        next_cycle_pacman_mat_idx_y = pacman_mat_idx_y; 
        pacman_mat_idx_x= 29; 
        pacman_mat_idx_y= 23; 
        food_map_read_y= 23; 
        pacman_curr_pos_x = pacman_mat_idx_x * SCALING_FACTOR 
                            + H_VISIBLE_START + MOVE_TO_CENTER; 
        pacman_curr_pos_y= pacman_mat_idx_y * SCALING_FACTOR 
                            + V_VISIBLE_START + MOVE_TO_CENTER;
        
        
        #90
//        next_cycle_pacman_mat_idx_y = pacman_mat_idx_y; 
        
       
       
       
        #1000 $finish;

    end
    
    always #5 clka = ~clka;
    always #2 food_map_clk=~food_map_clk; 


endmodule
