module TopModule_GameLogic(
                    input rbtn,
                    input lbtn, 
                    input ubtn, 
                    input dbtn,
                    input very_fast_clk,
                    input clk, 
                    input rst, 
                    output [10:0]pacman_pos_x, 
                    output [9:0]pacman_pos_y, 
                    output [10:0]blinky_pos_x, 
                    output [9:0]blinky_pos_y, 
                    output [10:0]pinky_pos_x, 
                    output [9:0]pinky_pos_y, 
                    output [10:0]inky_pos_x, 
                    output [9:0]inky_pos_y, 
                    output [10:0]clyde_pos_x, 
                    output [9:0]clyde_pos_y, 
                    output pacman_is_dead, 
                    output [3:0] pacman_moving_dir_out,
                    output [15:0] total_score_bcd); 

    
    
    
   // here defines the reset positions for the sprites 
    // we assume the  matrix 
    // all default positions are taken from the random_position file 
    // created on the create_map branch 
    // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 
        
    //        parameter MOVE_TO_CENTER= 7; 
     // parameter H_VISIBLE_START= 336; 
     // parameter V_VISIBLE_START= 27; 

        parameter RATIO = 16; 
        parameter MOVE_TO_CENTER= 0; 
     parameter H_VISIBLE_START= 0; 
     parameter V_VISIBLE_START= 0;

    parameter PACMAN= 0;
    parameter PACMAN_X=39;
    parameter PACMAN_Y=2;
    parameter PACMAN_RESET_POS_X= PACMAN_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter PACMAN_RESET_POS_Y= PACMAN_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter BLINKY=1; 
    parameter BLINKY_X=20; 
    parameter BLINKY_Y=25; 
    parameter BLINKY_RESET_POS_X= BLINKY_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter BLINKY_RESET_POS_Y= BLINKY_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter PINKY=2;
    parameter PINKY_X=17; 
    parameter PINKY_Y=14; 
    parameter PINKY_RESET_POS_X= PINKY_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter PINKY_RESET_POS_Y= PINKY_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter INKY=3;
    parameter INKY_X=10; 
    parameter INKY_Y=2; 
    parameter INKY_RESET_POS_X= INKY_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter INKY_RESET_POS_Y= INKY_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
    
    parameter CLYDE=4;
    parameter CLYDE_X=17; 
    parameter CLYDE_Y=21; 
    parameter CLYDE_RESET_POS_X= CLYDE_X * RATIO + H_VISIBLE_START + MOVE_TO_CENTER;
    parameter CLYDE_RESET_POS_Y= CLYDE_Y * RATIO + V_VISIBLE_START + MOVE_TO_CENTER;
   



    wire [3:0] pacman_move_direction; 

    reg [10:0] pacman_curr_pos_x; 
    reg [9:0]  pacman_curr_pos_y;
   

    reg [10:0] blinky_curr_pos_x; 
    reg [9:0]  blinky_curr_pos_y;
    reg [3:0]   blinky_previous_direction;
    wire [3:0]   blinky_move_direction;
    wire blinky_killed_pacman;  


    reg [10:0] pinky_curr_pos_x; 
    reg [9:0]  pinky_curr_pos_y;
    reg [3:0]   pinky_previous_direction; 
    wire [3:0]   pinky_move_direction; 
    wire pinky_killed_pacman;  



    reg [10:0] inky_curr_pos_x; 
    reg [9:0]  inky_curr_pos_y;
    reg [3:0]   inky_previous_direction; 
    wire [3:0]   inky_move_direction; 
    wire inky_killed_pacman;  


    reg [10:0] clyde_curr_pos_x; 
    reg [9:0]  clyde_curr_pos_y;
    reg [3:0]   clyde_previous_direction; 
    wire [3:0]   clyde_move_direction; 
    wire clyde_killed_pacman;  


    
    
    
    
    // here defines the directions 
    parameter RIGHT= 4'b0001; 
	parameter LEFT=  4'b1000;	
	parameter UP=    4'b0010;
	parameter DOWN=  4'b0100;  
    
    wire slower_clk_2; 
    clk_div  #(.DIV(1)) topmodule_gamelogic_clkdiv2(
        .clk(clk),
        .clk_out (slower_clk_2)
    );

    wire slower_clk_4; 
    clk_div  #(.DIV(2)) topmodule_gamelogic_clkdiv4(
        .clk(clk),
        .clk_out (slower_clk_4)
    );

    

    input_module input_module_game_logic (  .rbtn(rbtn),
                                            .lbtn(lbtn), 
                                            .ubtn(ubtn), 
                                            .dbtn(dbtn),
                                            .clk(slower_clk_2),
                                            .move_dir(pacman_move_direction) );

    ghost_control blinky_ghost_control (
                                    .clk(clk),
                                    .slower_clk(slower_clk_2),
                                    .ghost_curr_pos_x(blinky_curr_pos_x), 
                                    .ghost_curr_pos_y(blinky_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(blinky_previous_direction), 
                                    .move_direction(blinky_move_direction));


    ghost_control pinky_ghost_control (
                                    .clk(clk),
                                    .slower_clk(slower_clk_2), 
                                    .ghost_curr_pos_x(pinky_curr_pos_x), 
                                    .ghost_curr_pos_y(pinky_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(pinky_previous_direction), 
                                    .move_direction(pinky_move_direction));

    ghost_control inky_ghost_control (
                                    .clk(clk),
                                    .slower_clk(slower_clk_2),
                                    .ghost_curr_pos_x(inky_curr_pos_x), 
                                    .ghost_curr_pos_y(inky_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(inky_previous_direction), 
                                    .move_direction(inky_move_direction));
    
    ghost_control clyde_ghost_control (
                                    .clk(clk),
                                    .slower_clk(slower_clk_2),
                                    .rst(rst),
                                    .ghost_curr_pos_x(clyde_curr_pos_x), 
                                    .ghost_curr_pos_y(clyde_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(clyde_previous_direction), 
                                    .move_direction(clyde_move_direction));

    position_update_function pacman_position_update_function (
                                 .clk(clk),
                                 .slower_clk(slower_clk_2),
                                 .rst(rst),
                                 .curr_pos_x(pacman_curr_pos_x),
                                 .curr_pos_y(pacman_curr_pos_y),
                                 .move_direction(pacman_move_direction),
                                  .which_sprite(PACMAN), 
                                  .new_pos_x(pacman_pos_x), 
                                  .new_pos_y(pacman_pos_y));
    
    position_update_function blinky_position_update_function (
                                 .clk(clk),
                                 .slower_clk(slower_clk_2),
                                 .rst(rst),
                                 .curr_pos_x(blinky_curr_pos_x),
                                 .curr_pos_y(blinky_curr_pos_y),
                                 .move_direction(blinky_move_direction),
                                  .which_sprite(BLINKY), 
                                  .new_pos_x(blinky_pos_x), 
                                  .new_pos_y(blinky_pos_y));

    position_update_function pinky_position_update_function (
                                 .clk(clk),
                                 .slower_clk(slower_clk_2),
                                 .rst(rst),
                                 .curr_pos_x(pinky_curr_pos_x),
                                 .curr_pos_y(pinky_curr_pos_y),
                                 .move_direction(pinky_move_direction),
                                  .which_sprite(PINKY), 
                                  .new_pos_x(pinky_pos_x), 
                                  .new_pos_y(pinky_pos_y));

    position_update_function inky_position_update_function (
                                 .clk(clk),
                                 .slower_clk(slower_clk_2),
                                 .rst(rst),
                                 .curr_pos_x(inky_curr_pos_x),
                                 .curr_pos_y(inky_curr_pos_y),
                                 .move_direction(inky_move_direction),
                                  .which_sprite(INKY), 
                                  .new_pos_x(inky_pos_x), 
                                  .new_pos_y(inky_pos_y));

    position_update_function clyde_position_update_function (
                                 .clk(clk),
                                 .slower_clk(slower_clk_2),
                                 .rst(rst),
                                 .curr_pos_x(clyde_curr_pos_x),
                                 .curr_pos_y(clyde_curr_pos_y),
                                 .move_direction(clyde_move_direction),
                                  .which_sprite(CLYDE), 
                                  .new_pos_x(clyde_pos_x), 
                                  .new_pos_y(clyde_pos_y));

  

    collision_detection blinky_collision_detection (
                                    .clk(clk),
                                    .ghost_curr_pos_x(blinky_pos_x), 
                                    .ghost_curr_pos_y(blinky_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(blinky_killed_pacman));

    collision_detection pinky_collision_detection (
                                    .clk(clk),
                                    .ghost_curr_pos_x(pinky_pos_x), 
                                    .ghost_curr_pos_y(pinky_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(pinky_killed_pacman));

    collision_detection inky_collision_detection (
                                    .clk(clk),
                                    .ghost_curr_pos_x(inky_pos_x), 
                                    .ghost_curr_pos_y(inky_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(inky_killed_pacman));

    collision_detection clyde_collision_detection (
                                    .clk(clk),
                                    .ghost_curr_pos_x(clyde_pos_x), 
                                    .ghost_curr_pos_y(clyde_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(clyde_killed_pacman));                                

    wire is_food; 
    flush_eaten_food gamelogic_flush_eaten_food (
                                    
                                    .clk(clk), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y), 
                                    .is_food(is_food)
                                    );
                                    
    assign pacman_is_dead = blinky_killed_pacman 
                          ||pinky_killed_pacman
                          ||inky_killed_pacman
                          ||clyde_killed_pacman; 


     parameter INPUT_WIDTH= 12;
    parameter DECIMAL_DIGITS= 4; 
    reg [15:0] reg_bcd_score; 
//    reg [15:0] reg_bcd_module_out; 
    reg [11:0] reg_total_score; 
    wire [15:0] bcd_module_out; 
    wire bcd_done; 
    bcd_converter
      #(.INPUT_WIDTH (INPUT_WIDTH),
        .DECIMAL_DIGITS(DECIMAL_DIGITS)) gamelogic_bcd_converter
      (
            .i_Clock(very_fast_clk),
            .slower_clk(clk),
           .i_Binary(reg_total_score),
           .i_Start(1),
           //
           .o_BCD(bcd_module_out),
           .o_DV (bcd_done)
       );
       
//    always @(posedge bcd_done)begin   
//        if (bcd_done) 
//              reg_bcd_module_out <= bcd_module_out; 
        
//    end 
    
    always @(posedge clk or posedge rst)begin 
        if (rst || pacman_is_dead) begin 
            reg_total_score <= 12'd0; 
//            reg_bcd_module_out <= 0; 
//            reg_total_score <= 0; 
//            reg_total_score <= 12'd1567;
            blinky_previous_direction <= 4'b0000; 
            pinky_previous_direction <=  4'b0000; 
            inky_previous_direction <=   4'b0000; 
            clyde_previous_direction <= 4'b0000; 
            
            pacman_curr_pos_x <= PACMAN_RESET_POS_X; 
            pacman_curr_pos_y <= PACMAN_RESET_POS_Y; 
            blinky_curr_pos_x <= BLINKY_RESET_POS_X; 
            blinky_curr_pos_y <= BLINKY_RESET_POS_Y;
            pinky_curr_pos_x <= PINKY_RESET_POS_X; 
            pinky_curr_pos_y <= PINKY_RESET_POS_Y;
            inky_curr_pos_x <= INKY_RESET_POS_X; 
            inky_curr_pos_y <= INKY_RESET_POS_Y;
            clyde_curr_pos_x <= CLYDE_RESET_POS_X; 
            clyde_curr_pos_y <= CLYDE_RESET_POS_Y;
            
            
//            pacman_move_direction <= 4'b0000; 
        end 

        else begin 
//            if (is_food) 
                reg_total_score <= reg_total_score +1; 
        
//             reg_total_score <= 12'd1567;
//            if (bcd_done)
                reg_bcd_score <= bcd_module_out; 
//            else 
//                reg_bcd_score <= reg_bcd_module_out; 
           
                
            pacman_curr_pos_x <= pacman_pos_x; 
            pacman_curr_pos_y <= pacman_pos_y; 
            blinky_curr_pos_x <= blinky_pos_x; 
            blinky_curr_pos_y <= blinky_pos_y;
            pinky_curr_pos_x <= pinky_pos_x; 
            pinky_curr_pos_y <= pinky_pos_y;
            inky_curr_pos_x <= inky_pos_x; 
            inky_curr_pos_y <= inky_pos_y;
            clyde_curr_pos_x <= clyde_pos_x; 
            clyde_curr_pos_y <= clyde_pos_y;
            blinky_previous_direction <= blinky_move_direction; 
            pinky_previous_direction <=  pinky_move_direction; 
            inky_previous_direction <=   inky_move_direction; 
            clyde_previous_direction <= clyde_move_direction; 
        end 
            
        end
       
    assign pacman_moving_dir_out = pacman_move_direction;  
//    assign total_score_bcd= reg_bcd_score;                
    assign total_score_bcd= bcd_module_out;                




endmodule 