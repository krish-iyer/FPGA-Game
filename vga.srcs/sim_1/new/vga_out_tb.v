`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 04:45:23 PM
// Design Name: 
// Module Name: vga_out_tb
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


module vga_out_tb();

reg clk;
wire [3:0] pix_r, pix_g, pix_b;
wire hsync, vsync;

vga_out vga_out_inst(
    .clk(clk),
    .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b),
    .hsync(hsync), .vsync(vsync)
);

initial begin
    clk = 0;
end

always #5 clk = ~clk;

endmodule
