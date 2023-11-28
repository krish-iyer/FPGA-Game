`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 08:12:00 PM
// Design Name: 
// Module Name: game_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module game_top(
    input clk, rst,
    input btn_u, btn_d, btn_l, btn_r, btn_c,
    output [3:0] pix_r, pix_g, pix_b,
    output pacman_dead,
    output hsync, vsync
    );

    wire clk_83_MHz;

    clk_wiz_0 clk_wiz_0_inst(   // set clock
        .clk_out1(clk_83_MHz),  // Clock out ports
        .clk_in1(clk)           // Clock in ports
    );

    wire [10:0] curr_x;
    wire [9:0] curr_y;
    wire [3:0] r,g,b;
    reg [15:0] score = 16'h12_34;

    
     
    
    wire [10:0] pacman_blkpos_x; 
    wire [9:0] pacman_blkpos_y ;
    wire [10:0] ghost_1_blkpos_x; 
    wire [9:0] ghost_1_blkpos_y;
    wire [10:0] ghost_2_blkpos_x; 
    wire [9:0] ghost_2_blkpos_y;
    wire [10:0] ghost_3_blkpos_x;
    wire [9:0] ghost_3_blkpos_y;
    wire [10:0] ghost_4_blkpos_x; 
    wire [9:0] ghost_4_blkpos_y;
    wire [3:0] pacman_dir ;
    wire [3:0] ghost_1_dir;
    wire [3:0] ghost_2_dir;
    wire [3:0] ghost_3_dir;
    wire [3:0] ghost_4_dir;
    wire rst_synth;
    assign rst_synth = ~rst;

    wire clk_game_logic; 
    clk_div  #(.DIV(20)) clk_div_game_logic_inst(
        .clk(clk),
        .clk_out (clk_game_logic)
    );


    TopModule_GameLogic Game_Logic_inst (
                            .rbtn(btn_r), 
                            .lbtn(btn_l),  
                            .ubtn(btn_u), 
                            .dbtn(btn_d),
                            .clk(clk_game_logic), 
                            .rst(rst_synth), 
                             .pacman_pos_x(pacman_blkpos_x), 
                             .pacman_pos_y(pacman_blkpos_y), 
                             .blinky_pos_x(ghost_1_blkpos_x), 
                             .blinky_pos_y(ghost_1_blkpos_y), 
                             .pinky_pos_x(ghost_2_blkpos_x), 
                             .pinky_pos_y(ghost_2_blkpos_y), 
                             .inky_pos_x(ghost_3_blkpos_x), 
                             .inky_pos_y(ghost_3_blkpos_y), 
                             .clyde_pos_x(ghost_4_blkpos_x), 
                             .clyde_pos_y(ghost_4_blkpos_y), 
                            .pacman_is_dead(pacman_dead),
                             .pacman_moving_dir_out(pacman_dir));

    drawcon drawcon_inst(
        .clk(clk_83_MHz),
        .r(r), .g(g), .b(b),
        .draw_x(curr_x), .draw_y(curr_y),
        .pacman_blkpos_x(pacman_blkpos_x), 
        .pacman_blkpos_y(pacman_blkpos_y),
        .ghost_1_blkpos_x(ghost_1_blkpos_x), 
        .ghost_1_blkpos_y(ghost_1_blkpos_y),
        .ghost_2_blkpos_x(ghost_2_blkpos_x), 
        .ghost_2_blkpos_y(ghost_2_blkpos_y),
        .ghost_3_blkpos_x(ghost_3_blkpos_x), 
        .ghost_3_blkpos_y(ghost_3_blkpos_y),
        .ghost_4_blkpos_x(ghost_4_blkpos_x), 
        .ghost_4_blkpos_y(ghost_4_blkpos_y),
        .pacman_dir (pacman_dir),
        .ghost_1_dir(ghost_1_dir),
        .ghost_2_dir(ghost_2_dir),
        .ghost_3_dir(ghost_3_dir),
        .ghost_4_dir(ghost_4_dir),
        .score(score)
    );

    vga_out vga_out_inst(
        .clk(clk_83_MHz),
        .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b),
        .hsync(hsync), .vsync(vsync),
        .curr_x(curr_x), .curr_y(curr_y),
        .r(r), .g(g), .b(b)
    );

endmodule