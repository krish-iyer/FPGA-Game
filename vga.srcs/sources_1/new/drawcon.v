`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 11:50:05 PM
// Design Name: 
// Module Name: drawcon
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


module drawcon(
    input clk,
    input [10:0] blkpos_x, 
    input [9:0] blkpos_y,
    input [10:0] draw_x, 
    input [9:0] draw_y,
    output reg [3:0] r,g,b
);

reg [3:0] bg_r, bg_g, bg_b;
reg [3:0] blk_r = 10; 
reg [3:0] blk_g  = 2; 
reg [3:0] blk_b  = 2;


reg [5:0] map_idx_y = 0;
reg [6:0] map_idx_x = 0;

wire [79:0] map_row;

reg mod_y = 0;
reg mod_x = 0;
reg map_pix = 0;
reg draw_food = 0;

always @(posedge clk) begin
    if(map_idx_y == 50) begin
        map_idx_y <= 0;
    end
    if(map_idx_x == 80) begin
        map_idx_x <= 0;
    end
    if(draw_y[4] ^ mod_y) begin
        mod_y <= draw_y[4];
        map_idx_y <= map_idx_y + 1;
    end
    if(draw_x[4] ^ mod_x) begin
        mod_x <= draw_x[4];
        map_pix <= map_row[map_idx_x];
        map_idx_x <= map_idx_x + 1;
    end
end

always @(posedge clk) begin
    if(draw_x[3:0] >=6 && draw_x[3:0] <= 9 && draw_y[3:0] >= 6  && draw_y[3:0] <= 9 && map_pix) begin
            draw_food <= 1;
    end
    else begin
        draw_food <= 0;
    end
end

pacman_map_blockmem map(
    .clka(clk),                            
    .addra($unsigned(map_idx_y)),
    .douta(map_row)
);

always@(posedge clk) begin
    if(((draw_x >= 0 && draw_x <= 10) || (draw_x >= 1269 && draw_x <= 1279)) || ((draw_y >= 0 && draw_y <= 10)  || (draw_y >= 789 && draw_y <= 799))) begin
        bg_r <= 15;
        bg_g <= 15;
        bg_b <= 15;
    end
    else if(map_pix == 0) begin
        bg_r <= 0;
        bg_g <= 0;
        bg_b <= 10;
    end
    else begin
        bg_r <= 0;
        bg_g <= 0;
        bg_b <= 0;
    end
end

always@(posedge clk) begin

    if((draw_x > blkpos_x && draw_x < (blkpos_x+16)) && (draw_y > blkpos_y && 
        draw_y < (blkpos_y+16))) begin

        if(blk_r != 0 && blk_g !=0 && blk_b !=0 ) begin
            r <= blk_r;
            g <= blk_g;
            b <= blk_b;
        end
    end
    else if(draw_food) begin
        r <= 15;
        g <= 15;
        b <= 15;
    end
    else begin
        r <= bg_r;
        g <= bg_g;
        b <= bg_b;        
    end
    
end

endmodule
