

module pacman_map_blockmem (input clka,
                            input ena,
                            
                           input [5:0] addra, 
                           
                           output [127:0] douta 
                            
                            ); 



    pacman_map_blk_mem_gen pacman_map_inst(.clka(clka),
                                         .ena(ena),
                                       
                                         .addra(addra),
                                        
                                         .douta(douta)); 






endmodule