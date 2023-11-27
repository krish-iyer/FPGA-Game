
module pacman_map_blockmem_tb();

    reg clka;
    
    reg [5:0] addra;
    wire [79:0] douta; 
    
    
   
        
   pacman_map_blockmem uut_pacman_map_blockmem (.clka(clka),
                                         
                                         .addra(addra),
                                         
                                         .douta(douta)); 
                                         

    initial begin
    
        // initial values for the clock  
        
        clka=1; 
        
       
       
        // I will change the address 
        addra= $unsigned(6'd0); // read the first row with 80 values [128 bit padded with zeros]
        
        #10
       addra= $unsigned(6'd3); // read the fourth row
        

        #100 $finish;

    end
    
    always #5 clka = ~clka;
    


endmodule
