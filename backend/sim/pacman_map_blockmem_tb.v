
module pacman_map_blockmem_tb();

    reg clka;
    reg ena;
    reg wea;
    reg [5:0] addra;
    reg [127:0] dina; 
    wire [127:0] douta; 
    
    
   
        
   pacman_map_blockmem uut_pacman_map_blockmem (.clka(clka),
                                         .ena(ena),
                                         
                                         .addra(addra),
                                         
                                         .douta(douta)); 
                                         

    initial begin
    
        // initial values for the enables 
        ena= 0; // this is to read 
        wea=0; // this is to disable writing 
        dina=-128'd1; // this will not be written 
        clka=0; 
        
       
       
        // I will change the address 
        addra= $unsigned(6'd0); // read the first row with 80 values [128 bit padded with zeros]
        
        #10
       addra= $unsigned(6'd63); // read the last row 
        

        #10 $finish;

    end
    
    always #5 clka = ~clka;
    


endmodule
