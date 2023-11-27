module TopModule_GameLogic(
                    input rbtn,
                    input lbtn, 
                    input ubtn, 
                    input dbtn,
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
                    output [3:0] pacman_moving_dir_out); 


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


    
    // here defines the reset positions for the sprites 
    // we assume the  matrix 
    // all default positions are taken from the random_position file 
    // created on the create_map branch 
    // pacman -> 0; blinky -> 1; pinky -> 2; inky -> 3; clyde -> 4; 
    parameter PACMAN= 0;
    parameter PACMAN_RESET_POS_X= 11'd967;
    parameter PACMAN_RESET_POS_Y= 10'd66;
    
    parameter BLINKY=1; 
    parameter BLINKY_RESET_POS_X= 11'd663;
    parameter BLINKY_RESET_POS_Y= 10'd434;
    
    parameter PINKY=2; 
    parameter PINKY_RESET_POS_X= 11'd615;
    parameter PINKY_RESET_POS_Y= 10'd258;
    
    parameter INKY=3; 
    parameter INKY_RESET_POS_X= 11'd503;
    parameter INKY_RESET_POS_Y= 10'd66;
    
    parameter CLYDE=4; 
    parameter CLYDE_RESET_POS_X= 11'd615;
    parameter CLYDE_RESET_POS_Y= 10'd370;
    
    
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
                                    
                                    .ghost_curr_pos_x(blinky_pos_x), 
                                    .ghost_curr_pos_y(blinky_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(blinky_killed_pacman));

    collision_detection pinky_collision_detection (
                                    
                                    .ghost_curr_pos_x(pinky_pos_x), 
                                    .ghost_curr_pos_y(pinky_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(pinky_killed_pacman));

    collision_detection inky_collision_detection (
                                    
                                    .ghost_curr_pos_x(inky_pos_x), 
                                    .ghost_curr_pos_y(inky_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(inky_killed_pacman));

    collision_detection clyde_collision_detection (
                                    
                                    .ghost_curr_pos_x(clyde_pos_x), 
                                    .ghost_curr_pos_y(clyde_pos_y), 
                                    .pacman_curr_pos_x(pacman_pos_x), 
                                    .pacman_curr_pos_y(pacman_pos_y),
                                    .pacman_is_dead(clyde_killed_pacman));                                

    assign pacman_is_dead = blinky_killed_pacman 
                          ||pinky_killed_pacman
                          ||inky_killed_pacman
                          ||clyde_killed_pacman; 


    always @(posedge slower_clk_2)begin 

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
       
    assign pacman_moving_dir_out = pacman_move_direction;                 



endmodule 