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
    input [10:0] pacman_blkpos_x, 
    input [9:0] pacman_blkpos_y,
    input [10:0] ghost_1_blkpos_x, 
    input [9:0] ghost_1_blkpos_y,
    input [10:0] ghost_2_blkpos_x, 
    input [9:0] ghost_2_blkpos_y,
    input [10:0] ghost_3_blkpos_x, 
    input [9:0] ghost_3_blkpos_y,
    input [10:0] ghost_4_blkpos_x, 
    input [9:0] ghost_4_blkpos_y,
    input [3:0] pacman_dir,
    input [3:0] ghost_1_dir,
    input [3:0] ghost_2_dir,
    input [3:0] ghost_3_dir,
    input [3:0] ghost_4_dir,
    input [15:0] score,
    input [10:0] draw_x, 
    input [9:0] draw_y,
    input [79:0] food_row, 
//    input food_map_read_clk,
//    output reg [6:0] food_idx_x,
    output reg [5:0] food_idx_y,
    output reg [3:0] r,g,b
);

reg [3:0] bg_r, bg_g, bg_b;
reg [3:0] blk_r = 15; 
reg [3:0] blk_g = 13; 
reg [3:0] blk_b = 9;

reg [3:0] ghost_1_body_r = 15; 
reg [3:0] ghost_1_body_g = 12; 
reg [3:0] ghost_1_body_b = 14;

reg [3:0] ghost_2_body_r = 15; 
reg [3:0] ghost_2_body_g = 0; 
reg [3:0] ghost_2_body_b = 0;

reg [3:0] ghost_3_body_r = 15; 
reg [3:0] ghost_3_body_g = 0; 
reg [3:0] ghost_3_body_b = 15;

reg [3:0] ghost_4_body_r = 0; 
reg [3:0] ghost_4_body_g = 7; 
reg [3:0] ghost_4_body_b = 0;

reg [3:0] ghost_eyes_r = 15; 
reg [3:0] ghost_eyes_g = 15; 
reg [3:0] ghost_eyes_b = 15;

reg [3:0] num_r = 15; 
reg [3:0] num_g = 15; 
reg [3:0] num_b = 15;

reg [5:0] map_idx_y = 0;
reg [6:0] map_idx_x = 0;



wire [79:0] map_row;
//wire [79:0] food_row;
wire [79:0] dina;

reg mod_y = 0;
reg mod_x = 0;
reg map_pix = 0;
reg food_pix=1; 
reg draw_food = 0;

reg [6:0] pacman_sprite_idx = 0;
wire [15:0] pacman_sprite_row;

reg [6:0]   ghost_1_sprite_idx = 0;
wire [63:0] ghost_1_sprite_row;

reg [6:0]   ghost_2_sprite_idx = 0;
wire [63:0] ghost_2_sprite_row;

reg [6:0]   ghost_3_sprite_idx = 0;
wire [63:0] ghost_3_sprite_row;

reg [6:0]   ghost_4_sprite_idx = 0;
wire [63:0] ghost_4_sprite_row;

reg [7:0]   num_sprite_idx = 0;
wire [15:0] num_sprite_row;

reg [10:0] num_sprite_blkpos_x = 1100; 
reg [9:0]  num_sprite_blkpos_y = 16;

reg [5:0] num_sprite_score_idx = 0;

reg [6:0] food_idx_x;
//reg [5:0] food_idx_y;  

//output [79:0] food_row;
//    wire is_food; 
//    flush_eaten_food gamelogic_flush_eaten_food (
                                    
//                                    .clk(clk),
//                                    .slower_clk(slower_clk_4), 
//                                    .pacman_curr_pos_x(pacman_pos_x), 
//                                    .pacman_curr_pos_y(pacman_pos_y), 
//                                    .food_map_clk(food_map_read_clk), 
//                                    .food_map_read_y (food_map_read_y), 
//                                    .food_row(food_row), 
//                                    .is_food(is_food)
//                                    );
                                    
                                    
always @(posedge clk) begin
    if(draw_y[4] ^ mod_y) begin
        mod_y <= draw_y[4];
        map_idx_y <= map_idx_y + 1;
        food_idx_y <= map_idx_y + 1;
       
    end
    if(draw_x[4] ^ mod_x) begin
        mod_x <= draw_x[4];
        map_idx_x <= map_idx_x + 1;
        food_idx_x <= map_idx_x + 1;
    end
    if(map_idx_y == 50) begin
        map_idx_y <= 0;
    end
    if(map_idx_x == 80) begin
        map_idx_x <= 0;
    end
end

always @(posedge clk) begin
    map_pix <= map_row[map_idx_x];
    food_pix <= food_row [food_idx_x]; 
    
end

always @(posedge clk) begin
    if(draw_x[3:0] >=6 && draw_x[3:0] <= 9 && draw_y[3:0] >= 6  && draw_y[3:0] <= 9 && map_pix && food_pix) begin
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

pacman_sprite pacman_sprite_inst(
    .clka(clk),                            
    .addra($unsigned(pacman_sprite_idx)),
    .douta(pacman_sprite_row)
);

ghost_sprite ghost_1_sprite_inst(
    .clka(clk),                            
    .addra($unsigned(ghost_1_sprite_idx)),
    .douta(ghost_1_sprite_row)
);

ghost_sprite ghost_2_sprite_inst(
    .clka(clk),                            
    .addra($unsigned(ghost_2_sprite_idx)),
    .douta(ghost_2_sprite_row)
);

ghost_sprite ghost_3_sprite_inst(
    .clka(clk),                            
    .addra($unsigned(ghost_3_sprite_idx)),
    .douta(ghost_3_sprite_row)
);

ghost_sprite ghost_4_sprite_inst(
    .clka(clk),                            
    .addra($unsigned(ghost_4_sprite_idx)),
    .douta(ghost_4_sprite_row)
);

num_sprite num_sprite_inst(
    .clka(clk),                            
    .addra($unsigned(num_sprite_idx)),
    .douta(num_sprite_row)
);

always@(posedge clk) begin
    // if(((draw_x >= 0 && draw_x <= 10) || (draw_x >= 1269 && draw_x <= 1279)) || ((draw_y >= 0 && draw_y <= 10)  || (draw_y >= 789 && draw_y <= 799))) begin
    //     bg_r <= 15;
    //     bg_g <= 15;
    //     bg_b <= 15;
    // end
    if(map_pix == 0) begin
        bg_r <= 9;
        bg_g <= 5;
        bg_b <= 1;
    end
    else begin
        bg_r <= 0;
        bg_g <= 0;
        bg_b <= 0;
    end
end

always@(posedge clk) begin

    if((draw_x > pacman_blkpos_x && draw_x < (pacman_blkpos_x+16)) && (draw_y > pacman_blkpos_y && 
        draw_y < (pacman_blkpos_y+16)) 
        || (draw_x > ghost_1_blkpos_x && draw_x < (ghost_1_blkpos_x+16)) && (draw_y > ghost_1_blkpos_y && 
        draw_y < (ghost_1_blkpos_y+16)) 
        || (draw_x > ghost_2_blkpos_x && draw_x < (ghost_2_blkpos_x+16)) && (draw_y > ghost_2_blkpos_y && 
        draw_y < (ghost_2_blkpos_y+16))
        || (draw_x > ghost_3_blkpos_x && draw_x < (ghost_3_blkpos_x+16)) && (draw_y > ghost_3_blkpos_y && 
        draw_y < (ghost_3_blkpos_y+16))
        || (draw_x > ghost_4_blkpos_x && draw_x < (ghost_4_blkpos_x+16)) && (draw_y > ghost_4_blkpos_y && 
        draw_y < (ghost_4_blkpos_y+16))
        || (draw_x > num_sprite_blkpos_x && draw_x < (num_sprite_blkpos_x+64)) && (draw_y > num_sprite_blkpos_y && 
        draw_y < (num_sprite_blkpos_y+16))) begin
        
        if ((draw_x > pacman_blkpos_x && draw_x < (pacman_blkpos_x+16)) && (draw_y > pacman_blkpos_y && 
        draw_y < (pacman_blkpos_y+16))) begin
            
            pacman_sprite_idx <= (draw_y - pacman_blkpos_y)+pacman_dir*16;
            if(pacman_sprite_row[draw_x - pacman_blkpos_x]) begin
                r <= blk_r;
                g <= blk_g;
                b <= blk_b;
            end
            else begin
                r <= 0;
                g <= 0;
                b <= 0;
            end
        end
        else if ((draw_x > ghost_1_blkpos_x && draw_x < (ghost_1_blkpos_x+16)) && (draw_y > ghost_1_blkpos_y && 
        draw_y < (ghost_1_blkpos_y+16))) begin
            ghost_1_sprite_idx <= (draw_y - ghost_1_blkpos_y)+ghost_1_dir*16;
            case (ghost_1_sprite_row[(draw_x - ghost_1_blkpos_x)*4+:4])
                16'h02:begin
                    r <= ghost_1_body_r;
                    g <= ghost_1_body_g;
                    b <= ghost_1_body_b;     
                end
                16'h07: begin
                    r <= ghost_eyes_r;
                    g <= ghost_eyes_g;
                    b <= ghost_eyes_b;  
                end
                default: begin 
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end
            endcase
        end
        else if ((draw_x > ghost_2_blkpos_x && draw_x < (ghost_2_blkpos_x+16)) && (draw_y > ghost_2_blkpos_y && 
        draw_y < (ghost_2_blkpos_y+16))) begin
            ghost_2_sprite_idx <= (draw_y - ghost_2_blkpos_y)+ghost_2_dir*16;
            case (ghost_2_sprite_row[(draw_x - ghost_2_blkpos_x)*4+:4])
                16'h02:begin
                    r <= ghost_2_body_r;
                    g <= ghost_2_body_g;
                    b <= ghost_2_body_b;     
                end
                16'h07: begin
                    r <= ghost_eyes_r;
                    g <= ghost_eyes_g;
                    b <= ghost_eyes_b;  
                end
                default: begin 
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end
            endcase
        end
        else if ((draw_x > ghost_3_blkpos_x && draw_x < (ghost_3_blkpos_x+16)) && (draw_y > ghost_3_blkpos_y && 
        draw_y < (ghost_3_blkpos_y+16))) begin
            ghost_3_sprite_idx <= (draw_y - ghost_3_blkpos_y)+ghost_3_dir*16;
            case (ghost_3_sprite_row[(draw_x - ghost_3_blkpos_x)*4+:4])
                16'h02:begin
                    r <= ghost_3_body_r;
                    g <= ghost_3_body_g;
                    b <= ghost_3_body_b;     
                end
                16'h07: begin
                    r <= ghost_eyes_r;
                    g <= ghost_eyes_g;
                    b <= ghost_eyes_b;  
                end
                default: begin 
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end
            endcase
        end
        else if ((draw_x > ghost_4_blkpos_x && draw_x < (ghost_4_blkpos_x+16)) && (draw_y > ghost_4_blkpos_y && 
        draw_y < (ghost_4_blkpos_y+16))) begin
            ghost_4_sprite_idx <= (draw_y - ghost_4_blkpos_y)+ghost_4_dir*16;
            case (ghost_4_sprite_row[(draw_x - ghost_4_blkpos_x)*4+:4])
                16'h02:begin
                    r <= ghost_4_body_r;
                    g <= ghost_4_body_g;
                    b <= ghost_4_body_b;     
                end
                16'h07: begin
                    r <= ghost_eyes_r;
                    g <= ghost_eyes_g;
                    b <= ghost_eyes_b;  
                end
                default: begin 
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end
            endcase
        end
        else if ((draw_x > num_sprite_blkpos_x && draw_x < (num_sprite_blkpos_x+64)) && (draw_y > num_sprite_blkpos_y && 
        draw_y < (num_sprite_blkpos_y+16))) begin
            num_sprite_score_idx <= (draw_x - num_sprite_blkpos_x);
            case (num_sprite_score_idx[5:4])
                2'b00: begin
                    num_sprite_idx <= (draw_y - num_sprite_blkpos_y)+score[15:12]*16;
                end
                2'b01: begin
                    num_sprite_idx <= (draw_y - num_sprite_blkpos_y)+score[11:8]*16;
                end
                2'b10: begin
                    num_sprite_idx <= (draw_y - num_sprite_blkpos_y)+score[7:4]*16;
                end
                2'b11: begin
                    num_sprite_idx <= (draw_y - num_sprite_blkpos_y)+score[3:0]*16;
                end
            endcase
            if(num_sprite_row[num_sprite_score_idx[3:0]]) begin
                r <= num_r;
                g <= num_g;
                b <= num_b;
            end
            else begin
                r <= 0;
                g <= 0;
                b <= 0;
            end
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