module input_module(input rbtn,
                    input lbtn, 
                    input ubtn, 
                    input dbtn,
                    output [3:0] move_dir );

    // here defines the directions 
    parameter RIGHT= 4'b0001; 
	parameter LEFT=  4'b1000;	
	parameter UP=    4'b0010;
	parameter DOWN=  4'b0100; 

    reg [3:0] reg_move_dir; 
    // the priority is for up/down right/left if two buttons are pressed at the same time
    always @(*)begin 
        if (ubtn)
            reg_move_dir = UP; 
        else if (dbtn)
            reg_move_dir = DOWN; 
        else if (rbtn)
            reg_move_dir = RIGHT; 
        else if (lbtn)
            reg_move_dir= LEFT;
        else 
            reg_move_dir= 4'b0000; 

    end

    assign move_dir= reg_move_dir; 





endmodule 