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
    input [3:0] r, g, b,
    output [3:0] pix_r, pix_g, pix_b,
    output hsync, vsync,
    output reg [10:0] curr_x,
    output reg [9:0] curr_y
    );
    
    reg [10:0] hcount = 0;      // max : 1679
    reg [9:0] vcount = 0;       // max : 827

    initial curr_x = 0;
    initial curr_y = 0;
    
    always@(posedge clk) begin
        
        hcount <= hcount + 1;   // blocking assignment will only take it to 1678
        if(hcount == 1678) begin
            hcount <= 0;
            vcount <= vcount + 1;
        end
        if(vcount == 826) begin
            vcount <= 0;
        end
        
    end

    always@(posedge clk) begin
        
        if(hcount >= 336 && hcount <= 1615) begin
            curr_x <= curr_x + 1;
        end
        if(curr_x == 1279) begin
            curr_x <= 0;
            if(vcount >= 27 && vcount <= 826) begin
                curr_y <= curr_y + 1;
            end
        end
        if(curr_y == 799) begin
            curr_y <= 0;
        end

    end
    
assign hsync = hcount <= 135 ? 0 : 1;
assign vsync = vcount <= 2 ? 1 : 0;

assign pix_r = hcount >= 336 ? hcount <= 1615 ? vcount >= 27 ? vcount <= 826 ? 
                r : 0 : 0 : 0 : 0;  
assign pix_g = hcount >= 336 ? hcount <= 1615 ? vcount >= 27 ? vcount <= 826 ? 
                g : 0 : 0 : 0 : 0;  
assign pix_b = hcount >= 336 ? hcount <= 1615 ? vcount >= 27 ? vcount <= 826 ?
                b : 0 : 0 : 0 : 0;


endmodule
