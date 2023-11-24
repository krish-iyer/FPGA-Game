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

    reg [10:0] blkpos_x = 471; 
    reg [9:0] blkpos_y = 386;
    
    wire clk_50_Hz;

    clk_div #(.DIV(2)) clk_div(
        .clk(clk),
        .clk_out(clk_50_Hz)
    );

    always@(posedge clk_50_Hz) begin

        if(btn_c == 1) begin
            blkpos_x <= 650;
            blkpos_y <= 376;
        end
        else if(btn_d == 1 && blkpos_y <= 753) begin
            blkpos_y <= blkpos_y + 4;
        end
        else if(btn_u == 1 && blkpos_y >= 14 ) begin
            blkpos_y <= blkpos_y - 4;
        end
        else if(btn_l == 1 && blkpos_x >= 14) begin
            blkpos_x <= blkpos_x - 4;
        end
        else if(btn_r == 1 && blkpos_x <= 1233) begin
            blkpos_x <= blkpos_x + 4;
        end
    end

    drawcon drawcon_inst(
        .clk(clk_83_MHz),
        .r(r), .g(g), .b(b),
        .draw_x(curr_x), .draw_y(curr_y),
        .blkpos_x(blkpos_x), .blkpos_y(blkpos_y)
    );  

    vga_out vga_out_inst(
        .clk(clk_83_MHz),
        .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b),
        .hsync(hsync), .vsync(vsync),
        .curr_x(curr_x), .curr_y(curr_y),
        .r(r), .g(g), .b(b)
    );

endmodule
