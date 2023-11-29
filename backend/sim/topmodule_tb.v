module topmodule_tb(); 

 reg clk, rst;
    reg btn_u, btn_d, btn_l, btn_r, btn_c;
    wire [3:0] pix_r, pix_g, pix_b;
    wire pacman_dead;
    wire hsync, vsync;
    
    
game_top uut_game_top (
    .clk (clk), 
    .rst (rst),
    .btn_u (btn_u),
     .btn_d (btn_d),
      .btn_l (btn_l),
       .btn_r (btn_r),
        .btn_c (btn_c),
    .pix_r(pix_r),
     .pix_g (pix_g),
      .pix_b (pix_b),
    .pacman_dead(pacman_dead),
    .hsync (hsync),
     .vsync (vsync)
    );
    
    
    
    initial begin 
    
        clk =1; 
        rst = 1; 
        #20 
        rst =0; 
        
        btn_r=1; 
        btn_d =0;
        btn_u = 0; 
        btn_l = 0; 
        
    
    
    
    
    
    
    
    
    
    
    end 
    always #5 clk = ~clk;












endmodule