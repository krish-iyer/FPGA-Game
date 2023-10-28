`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 11:52:29 AM
// Design Name: 
// Module Name: vga_out
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



module vga_out(
    input clk,
    output [3:0] pix_r, pix_g, pix_b,
    output hsync, vsync
    );

    wire clk_83_MHz;



    reg [11:0] hcount = 0;      // max : 1679
    reg [9:0] vcount = 0;       // max : 827

    wire [3:0] pix_r_val, pix_g_val, pix_b_val;

    assign pix_r_val = 2;
    assign pix_g_val = 6;
    assign pix_b_val = 3;

    always@(posedge clk) begin
        
        hcount <= hcount + 1;   // blocking assignment will only take it to 1678
        if(hcount == 1679) begin
            hcount <= 0;
            vcount <= vcount + 1;
        end
        if(vcount == 827) begin
            vcount <= 0;
        end
    end

assign hsync = hcount <= 135 ? 0 : 1;
assign vsync = vcount <= 2 ? 1 : 0;

assign pix_r = hcount >= 336 ? hcount <= 1615 ? vcount >= 27 ? vcount <= 826 ? 
                pix_r_val : 0 : 0 : 0 : 0;  
assign pix_g = hcount >= 336 ? hcount <= 1615 ? vcount >= 27 ? vcount <= 826 ? 
                pix_g_val : 0 : 0 : 0 : 0;  
assign pix_b = hcount >= 336 ? hcount <= 1615 ? vcount >= 27 ? vcount <= 826 ?
                pix_b_val : 0 : 0 : 0 : 0;


endmodule
