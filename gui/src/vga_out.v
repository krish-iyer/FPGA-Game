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
    
    // video parameters
    parameter H_COUNT_MAX = 1679;
    parameter V_COUNT_MAX = 827;

    parameter H_COUNT_ADDR_MIN = 336;
    parameter H_COUNT_ADDR_MAX = 1615;
    parameter V_COUNT_ADDR_MIN = 27;
    parameter V_COUNT_ADDR_MAX = 826;

    parameter CURR_X_MAX = 1279;
    parameter CURR_Y_MAX = 799;

    parameter H_SYNC_TOGGLE = 135;
    parameter V_SYNC_TOGGLE = 2;

    // counters
    reg [10:0] hcount = 0;      // max : 1679
    reg [9:0] vcount = 0;       // max : 827

    initial curr_x = 0;
    initial curr_y = 0;
    
    always@(posedge clk) begin
        
        hcount <= hcount + 1;   // blocking assignment will only take it to 1678
        if(hcount == H_COUNT_MAX) begin
            hcount <= 0;
            vcount <= vcount + 1;
        end
        if(vcount == V_COUNT_MAX) begin
            vcount <= 0;
        end
        
    end

    always@(posedge clk) begin
        
        if(hcount >= H_COUNT_ADDR_MIN && hcount <= H_COUNT_ADDR_MAX) begin
            curr_x <= curr_x + 1;
        end
        if(curr_x == CURR_X_MAX) begin
            curr_x <= 0;
            if(vcount >= V_COUNT_ADDR_MIN && vcount <= V_COUNT_ADDR_MAX) begin
                curr_y <= curr_y + 1;
            end
        end
        if(curr_y == CURR_X_MAX) begin
            curr_y <= 0;
        end

    end
    
assign hsync = hcount <= H_SYNC_TOGGLE ? 0 : 1;
assign vsync = vcount <= V_SYNC_TOGGLE ? 1 : 0;

assign pix_r = hcount >= H_COUNT_ADDR_MIN ? hcount <= H_COUNT_ADDR_MAX ? vcount >= V_COUNT_ADDR_MIN ? vcount <= V_COUNT_ADDR_MAX ? 
                r : 0 : 0 : 0 : 0;  
assign pix_g = hcount >= H_COUNT_ADDR_MIN ? hcount <= H_COUNT_ADDR_MAX ? vcount >= V_COUNT_ADDR_MIN ? vcount <= V_COUNT_ADDR_MAX ? 
                g : 0 : 0 : 0 : 0;  
assign pix_b = hcount >= H_COUNT_ADDR_MIN ? hcount <= H_COUNT_ADDR_MAX ? vcount >= V_COUNT_ADDR_MIN ? vcount <= V_COUNT_ADDR_MAX ?
                b : 0 : 0 : 0 : 0;


endmodule
