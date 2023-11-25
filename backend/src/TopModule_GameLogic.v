module input_module(input rbtn,
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
                    output pacman_is_dead); 


    wire [3:0] pacman_move_dir; 

    wire [10:0] pacman_curr_pos_x; 
    wire [9:0]  pacman_curr_pos_y;
    wire [10:0] pacman_new_pos_x; 
    wire [9:0]  pacman_new_pos_y;
    reg [10:0]  pacman_reg_curr_pos_x; 
    reg [9:0]   pacman_reg_curr_pos_y;

    wire [10:0] blinky_curr_pos_x; 
    wire [9:0]  blinky_curr_pos_y;
    wire [10:0] blinky_new_pos_x; 
    wire [9:0]  blinky_new_pos_y;
    wire [10:0] blinky_reg_curr_pos_x; 
    wire [9:0]  blinky_reg_curr_pos_y;
    reg [3:0]   blinky_previous_direction;
    wire [3:0]   blinky_move_direction;
    wire blinky_killed_pacman;  


    wire [10:0] pinky_curr_pos_x; 
    wire [9:0]  pinky_curr_pos_y;
    wire [10:0] pinky_new_pos_x; 
    wire [9:0]  pinky_new_pos_y;
    wire [10:0] pinky_reg_curr_pos_x; 
    wire [9:0]  pinky_reg_curr_pos_y;
    reg [3:0]   pinky_previous_direction; 
    wire [3:0]   pinky_move_direction; 
    wire pinky_killed_pacman;  



    wire [10:0] inky_curr_pos_x; 
    wire [9:0]  inky_curr_pos_y;
    wire [10:0] inky_new_pos_x; 
    wire [9:0]  inky_new_pos_y;
    wire [10:0] inky_reg_curr_pos_x; 
    wire [9:0]  inky_reg_curr_pos_y;
    reg [3:0]   inky_previous_direction; 
    wire [3:0]   inky_move_direction; 
    wire inky_killed_pacman;  


    wire [10:0] clyde_curr_pos_x; 
    wire [9:0]  clyde_curr_pos_y;
    wire [10:0] clyde_new_pos_x; 
    wire [9:0]  clyde_new_pos_y;
    wire [10:0] clyde_reg_curr_pos_x; 
    wire [9:0]  clyde_reg_curr_pos_y;
    reg [3:0]   clyde_previous_direction; 
    wire [3:0]   clyde_move_direction; 
    wire inky_killed_pacman;  


    parameter PACMAN= 0;
    parameter BLINKY=1; 
    parameter PINKY=2; 
    parameter INKY=3; 
    parameter CLYDE=4; 
   

    input_module input_module_game_logic (  .rbtn(rbtn),
                                            .lbtn(lbtn), 
                                            .ubtn(ubtn), 
                                            .dbtn(dbtn),
                                            .move_dir(pacman_move_dir) );

    ghost_control blinky_ghost_control (
                                    .clk(clka),
                                    .ghost_curr_pos_x(blinky_curr_pos_x), 
                                    .ghost_curr_pos_y(blinky_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(blinky_previous_direction), 
                                    .move_direction(blinky_move_direction));


    ghost_control pinky_ghost_control (
                                    .clk(clka),
                                    .ghost_curr_pos_x(pinky_curr_pos_x), 
                                    .ghost_curr_pos_y(pinky_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(pinky_previous_direction), 
                                    .move_direction(pinky_move_direction));

    ghost_control inky_ghost_control (
                                    .clk(clka),
                                    .ghost_curr_pos_x(inky_curr_pos_x), 
                                    .ghost_curr_pos_y(inky_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(inky_previous_direction), 
                                    .move_direction(inky_move_direction));
    
    ghost_control clyde_ghost_control (
                                    .clk(clka),
                                    .ghost_curr_pos_x(clyde_curr_pos_x), 
                                    .ghost_curr_pos_y(clyde_curr_pos_y), 
                                    .pacman_curr_pos_x(pacman_curr_pos_x), 
                                    .pacman_curr_pos_y(pacman_curr_pos_y),
                                    .prev_direction(clyde_previous_direction), 
                                    .move_direction(clyde_move_direction));

    position_update_function pacman_position_update_function (
                                 .clk(clka),
                                 .rst(rst),
                                 .curr_pos_x(pacman_curr_pos_x),
                                 .curr_pos_y(pacman_curr_pos_y),
                                 .move_direction(pacman_move_direction),
                                  .which_sprite(PACMAN), 
                                  .new_pos_x(pacman_new_pos_x), 
                                  .new_pos_y(pacman_new_pos_y));
    
    position_update_function blinky_position_update_function (
                                 .clk(clka),
                                 .rst(rst),
                                 .curr_pos_x(blinky_curr_pos_x),
                                 .curr_pos_y(blinky_curr_pos_y),
                                 .move_direction(blinky_move_direction),
                                  .which_sprite(BLINKY), 
                                  .new_pos_x(blinky_new_pos_x), 
                                  .new_pos_y(blinky_new_pos_y));

    position_update_function pinky_position_update_function (
                                 .clk(clka),
                                 .rst(rst),
                                 .curr_pos_x(pinky_curr_pos_x),
                                 .curr_pos_y(pinky_curr_pos_y),
                                 .move_direction(pinky_move_direction),
                                  .which_sprite(PINKY), 
                                  .new_pos_x(pinky_new_pos_x), 
                                  .new_pos_y(pinky_new_pos_y));

    position_update_function inky_position_update_function (
                                 .clk(clka),
                                 .rst(rst),
                                 .curr_pos_x(inky_curr_pos_x),
                                 .curr_pos_y(inky_curr_pos_y),
                                 .move_direction(inky_move_direction),
                                  .which_sprite(INKY), 
                                  .new_pos_x(inky_new_pos_x), 
                                  .new_pos_y(inky_new_pos_y));

    position_update_function clyde_position_update_function (
                                 .clk(clka),
                                 .rst(rst),
                                 .curr_pos_x(clyde_curr_pos_x),
                                 .curr_pos_y(clyde_curr_pos_y),
                                 .move_direction(clyde_move_direction),
                                  .which_sprite(CLYDE), 
                                  .new_pos_x(clyde_new_pos_x), 
                                  .new_pos_y(clyde_new_pos_y));

    collision_detection blinky_collision_detection (
                                    
                                    .ghost_curr_pos_x(blinky_new_pos_x), 
                                    .ghost_curr_pos_y(blinky_new_pos_y), 
                                    .pacman_curr_pos_x(pacman_new_pos_x), 
                                    .pacman_curr_pos_y(pacman_new_pos_y),
                                    .pacman_is_dead(blinky_killed_pacman));

    collision_detection blinky_collision_detection (
                                    
                                    .ghost_curr_pos_x(blinky_new_pos_x), 
                                    .ghost_curr_pos_y(blinky_new_pos_y), 
                                    .pacman_curr_pos_x(pacman_new_pos_x), 
                                    .pacman_curr_pos_y(pacman_new_pos_y),
                                    .pacman_is_dead(blinky_killed_pacman));

    collision_detection pinky_collision_detection (
                                    
                                    .ghost_curr_pos_x(pinky_new_pos_x), 
                                    .ghost_curr_pos_y(pinky_new_pos_y), 
                                    .pacman_curr_pos_x(pacman_new_pos_x), 
                                    .pacman_curr_pos_y(pacman_new_pos_y),
                                    .pacman_is_dead(pinky_killed_pacman));

    collision_detection inky_collision_detection (
                                    
                                    .ghost_curr_pos_x(inky_new_pos_x), 
                                    .ghost_curr_pos_y(inky_new_pos_y), 
                                    .pacman_curr_pos_x(pacman_new_pos_x), 
                                    .pacman_curr_pos_y(pacman_new_pos_y),
                                    .pacman_is_dead(inky_killed_pacman));

    collision_detection clyde_collision_detection (
                                    
                                    .ghost_curr_pos_x(clyde_new_pos_x), 
                                    .ghost_curr_pos_y(clyde_new_pos_y), 
                                    .pacman_curr_pos_x(pacman_new_pos_x), 
                                    .pacman_curr_pos_y(pacman_new_pos_y),
                                    .pacman_is_dead(clyde_killed_pacman));                                

    assign pacman_is_dead = blinky_killed_pacman 
                          ||pinky_killed_pacman
                          ||inky_killed_pacman
                          ||clyde_killed_pacman; 

    always @(posedge clk)begin 
        
        blinky_previous_direction <= blinky_move_direction; 
        pinky_previous_direction <=  pinky_move_direction; 
        inky_previous_direction <=   inky_move_direction; 
        clyde_previous_direction <= clyde_move_direction; 

        pacman_curr_pos_x <= pacman_new_pos_x; 
        pacman_curr_pos_y <= pacman_new_pos_y; 
        blinky_curr_pos_x <= blinky_new_pos_x; 
        blinky_curr_pos_y <= blinky_new_pos_y;
        pinky_curr_pos_x <= pinky_new_pos_x; 
        pinky_curr_pos_y <= pinky_new_pos_y;
        inky_curr_pos_x <= inky_new_pos_x; 
        inky_curr_pos_y <= inky_new_pos_y;
        clyde_curr_pos_x <= clyde_new_pos_x; 
        clyde_curr_pos_y <= clyde_new_pos_y;

    end   
                            



endmodule 