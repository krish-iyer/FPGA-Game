`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 01:02:54 AM
// Design Name: 
// Module Name: clk_div
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


module clk_div #(parameter DIV=1)
    (
        input clk,
        output clk_out 
    );
    
    reg [31:0] count = 32'h00000000;
    always @(posedge clk ) begin
        count <= count + 1;
    end
    assign clk_out = count[DIV];

endmodule
