// this is a random number generator using LFSR
// from this website: https://simplefpga.blogspot.com/2013/02/random-number-generator-in-verilog-fpga.html#:~:text=In%20verilog%20a%20random%20number,(Liner%20Feedback%20Shift%20Register).
module rand_num_gen (
    input clock,
    input reset,
     output [3:0] rand_four_bit
    );

    wire feedback = random[12] ^ random[3] ^ random[2] ^ random[0]; 
    wire [12:0] rnd; 
    reg [12:0] random, random_next, random_done;
    reg [3:0] count, count_next; //to keep track of the shifts

    always @ (posedge clock or posedge reset)
    begin
        if (reset)
        begin
        random <= 13'hF; //An LFSR cannot have an all 0 state, thus reset to FF
        count <= 0;
        end
        
        else
        begin
        random <= random_next;
        count <= count_next;
        end
    end

    always @ (*)
    begin
        random_next = random; //default state stays the same
        count_next = count;
        
        random_next = {random[11:0], feedback}; //shift left the xor'd every posedge clock
        count_next = count + 1;

        if (count == 13)
        begin
            count = 0;
            random_done = random; //assign the random number to output after 13 shifts
        end
    
    end
assign rnd = random_done;
assign rand_four_bit= rnd[3:0]; 

endmodule