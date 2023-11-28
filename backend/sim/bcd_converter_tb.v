module bcd_converter_tb(); 


    parameter INPUT_WIDTH= 11;
    parameter DECIMAL_DIGITS= 4; 

    reg                         clka;
    reg [INPUT_WIDTH-1:0]       i_Binary;
    reg                         i_Start;
    //
    wire [DECIMAL_DIGITS*4-1:0] o_BCD;
    wire                        o_DV;

   

//    bcd_converter
//      #(.INPUT_WIDTH (INPUT_WIDTH),
//        .DECIMAL_DIGITS(DECIMAL_DIGITS)) uut_bcd_converter
//      (
//       .i_Clock(clka),
//       .i_Binary(i_Binary),
//       .i_Start(i_Start),
//       //
//       .o_BCD(o_BCD),
//       .o_DV (o_DV)
//       );

    bcd_converter uut_bcd_converter (
            .bin(i_Binary),
             .bcd(o_BCD));
    initial begin
        clka = 1 ; 
        i_Start = 1; 
         
        i_Binary = 11'd1024; 
        
         
        

//        #20
//         i_Binary = 5'd16; 
       
        
       
       
       
        #10000 $finish;

    end
    
    always #5 clka = ~clka;









endmodule