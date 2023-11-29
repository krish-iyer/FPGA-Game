// this module takes all the positions of a ghost and pacman
// it returns if pacman is dead or not
// it should use the display to matrix index mapping function
module flush_eaten_food (

    input clk, 
    input slower_clk, 
	input [10:0]pacman_curr_pos_x, 
	input [9:0]pacman_curr_pos_y, 
	input food_map_clk, 
	input [5:0] food_map_read_y,
	output [79:0] food_row,
	output is_food
	
	); 
	
	
    wire [6:0]pacman_matrix_idx_x;
    wire [5:0]pacman_matrix_idx_y;

    
                                  
                                  
	
	_display_pos_to_map_index pacman_pos_to_map_index_inst (   
                                .display_pos_x(pacman_curr_pos_x),
                                .display_pos_y(pacman_curr_pos_y), 
                                .matrix_idx_x(pacman_matrix_idx_x),
                                .matrix_idx_y(pacman_matrix_idx_y)); 
	
	wire [79:0] dina; 
    wire [79:0] douta;
    reg [79:0] reg_douta; 
    wire [79:0] douta2; 
    reg food_read_en=0; 
    reg reg_is_food; 
   reg wena =0; 
    food_map dual_mem_flush_food_inst (
      .clka(clk),    // input wire clka
      .ena(1),      // input wire ena
      .wea(wena),      // input wire [0 : 0] wea
      .addra($unsigned(pacman_matrix_idx_y)),  // input wire [5 : 0] addra
      .dina(reg_douta),    // input wire [79 : 0] dina
      .douta(douta),  // output wire [79 : 0] douta
      .clkb(food_map_clk),    // input wire clkb
      .enb(1),      // input wire enb
//      .enb(food_read_en),      // input wire enb
      .web(0),      // input wire [0 : 0] web
      .addrb($unsigned(food_map_read_y)),  // input wire [5 : 0] addrb
      .dinb(dina),    // input wire [79 : 0] dinb
      .doutb(food_row)  // output wire [79 : 0] doutb
    );


//    food_map flush_food_inst (
//        .clka(clk),    // input wire clka
//        .ena(1),      // input wire ena
//        .wea(0),      // input wire [0 : 0] wea
//        .addra($unsigned(pacman_matrix_idx_y)),  // input wire [5 : 0] addra
//        .dina(dina),    // input wire [79 : 0] dina
//        .douta(douta)  // output wire [79 : 0] douta
//    );                     

     
    always @(posedge slower_clk)begin 
        if (wena) begin 
            wena <= 0; // at the next clock cycle now the writing is done 
            // now it is time for read 
            food_read_en <= 1;
        
        end 
        else begin 
            food_read_en <= 0; // this means the value has been read already 
            reg_douta <= douta ;
            reg_is_food <= douta [pacman_matrix_idx_x]; 
            reg_douta [pacman_matrix_idx_x] <= 0; 
            wena <=1;  
        end 
    end 
    
//    always @(posedge clk) begin 
//        wen <=0; 
//    end 
    // assign douta[pacman_matrix_idx_x] = 0;              
    // assign dina = reg_douta;  
	
//    food_map write_flushed_food (
//        .clka(clk),    // input wire clka
//        .ena(1),      // input wire ena
//        .wea(wen),      // input wire [0 : 0] wea
//        .addra($unsigned(pacman_matrix_idx_y)),  // input wire [5 : 0] addra
//        .dina(reg_douta),    // input wire [79 : 0] dina
//        .douta(douta2)  // output wire [79 : 0] douta
//    );  
										
    assign is_food = reg_is_food; 
endmodule