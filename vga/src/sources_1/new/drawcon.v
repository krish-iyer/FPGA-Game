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


always@(posedge clk) begin
    if(((draw_x >= 0 && draw_x <= 10) || (draw_x >= 1269 && draw_x <= 1279)) || ((draw_y >= 0 && draw_y <= 10)  || (draw_y >= 789 && draw_y <= 799))) begin
        bg_r <= 15;
        bg_g <= 15;
        bg_b <= 15;
    end
    else begin
        bg_r <= 0;
        bg_g <= 6;
        bg_b <= 0;
    end
end

always@(posedge clk) begin

    if((draw_x > blkpos_x && draw_x < (blkpos_x+32)) && (draw_y > blkpos_y && 
        draw_y < (blkpos_y+32))) begin

        if(blk_r != 0 && blk_g !=0 && blk_b !=0 ) begin
            r <= blk_r;
            g <= blk_g;
            b <= blk_b;
        end
    end
    else begin
        r <= bg_r;
        g <= bg_g;
        b <= bg_b;        
    end
    
end

endmodule
