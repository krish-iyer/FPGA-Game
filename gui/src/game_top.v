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

    reg [10:0] pacman_blkpos_x = 471; 
    reg [9:0] pacman_blkpos_y = 386;
    
    reg [10:0] ghost_1_blkpos_x = 200; 
    reg [9:0] ghost_1_blkpos_y = 200;
    reg [10:0] ghost_2_blkpos_x = 300; 
    reg [9:0] ghost_2_blkpos_y = 300;
    reg [10:0] ghost_3_blkpos_x = 400;
    reg [9:0] ghost_3_blkpos_y = 400;
    reg [10:0] ghost_4_blkpos_x = 100; 
    reg [9:0] ghost_4_blkpos_y = 100;
    reg [3:0] pacman_dir =  0;
    reg [3:0] ghost_1_dir = 0;
    reg [3:0] ghost_2_dir = 0;
    reg [3:0] ghost_3_dir = 0;
    reg [3:0] ghost_4_dir = 0;
    
    reg [15:0] score = 16'h12_34;

    wire clk_50_Hz;
    wire clk_wide_sprite_Hz;

    clk_div #(.DIV(8)) clk_div_in(
        .clk(clk),
        .clk_out(clk_50_Hz)
    );

    clk_div #(.DIV(24)) clk_div_sprite_wide(
        .clk(clk),
        .clk_out(clk_wide_sprite_Hz)
    );

    always @(posedge clk_wide_sprite_Hz) begin
        pacman_dir[0] <= pacman_dir[0] ^ 1;
        ghost_1_dir[0] <= ghost_1_dir[0] ^ 1;
        ghost_2_dir[0] <= ghost_2_dir[0] ^ 1;
        ghost_3_dir[0] <= ghost_3_dir[0] ^ 1;
        ghost_4_dir[0] <= ghost_4_dir[0] ^ 1;

    end

    always@(posedge clk_50_Hz) begin
        if(btn_d == 1) begin
            pacman_dir[3:1] <= 4'b011;
        end
        else if(btn_u == 1 ) begin
            pacman_dir[3:1] <= 4'b0100;
        end
        else if(btn_l == 1) begin
            pacman_dir[3:1] <= 4'b0010;
        end
        else if(btn_r == 1) begin
            pacman_dir[3:1] <= 4'b0000;
        end
    end 

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
