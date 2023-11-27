

module pacman_map_blockmem (input clka,
                            
                           
                           input [5:0] addra, 
                             
                           output [79:0] douta 
                            
                            ); 


    wire ena=1; 
    pacman_map_blk_mem_gen pacman_map_inst(.clka(clka),
                                         .ena(ena),
                                         
                                         .addra(addra),
                                        
                                         .douta(douta)); 







endmodule