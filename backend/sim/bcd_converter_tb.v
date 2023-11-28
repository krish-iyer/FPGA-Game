module bcd_converter_tb(); 


    parameter INPUT_WIDTH= 5;
    parameter DECIMAL_DIGITS= 2; 

    reg                         clka;
    reg [INPUT_WIDTH-1:0]       i_Binary;
    reg                         i_Start;
    //
    wire [DECIMAL_DIGITS*4-1:0] o_BCD;
    wire                        o_DV;

   

    bcd_converter
      #(.INPUT_WIDTH (5),
        .DECIMAL_DIGITS(2)) uut_bcd_converter
      (
       .i_Clock(clka),
       .i_Binary(i_Binary),
       .i_Start(i_Start),
       //
       .o_BCD(o_BCD),
       .o_DV (o_DV)
       );

    initial begin
        clka = 1 ; 
        i_Start = 1; 
         
        i_Binary = 5'd23; 
        
         
        

//        #20
//         i_Binary = 5'd16; 
       
        
       
       
       
        #1000 $finish;

    end
    
    always #5 clka = ~clka;









endmodule