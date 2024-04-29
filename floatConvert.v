module fConv (S, E, F, D);

output reg S;
output reg [2:0] E;
output reg [3:0] F;
input [11:0] D;
reg [11:0] bit; // holds D
reg [3:0] E_check;
reg [4:0] F_check;
reg [3:0] count;
reg round;
integer i;
integer j;

always @(*) begin
    if (D == 12'b100000000000) // special case
        begin
            S = 1'b1; // answers for special case
            E = 3'b111;
            F = 4'b1111;
//            $display("F:%b", F);
        end
    else
        begin
            F = 4'b0;
            S = D[11]; // set the sign bit to the MSB of the input
            count = 0; // this will hold the # of leading zeros
            i = 11; // used for looping through from MSB to LSB
            if (S) // if the input is negative
                begin
                bit = ~D + 1; // swap the sign of the input
//                $display("negative: bit %b", bit);
                end
            else
                begin
                bit = D; // otherwise just keep D
//                $display("positive: bit %b", bit);
                end
           
            while (i >= 0 && bit[i] == 0) begin // loop to count the number of leading zeros
                count = count + 1;
                i = i - 1;
            end
//            $display("count: %d, i:%d", count, i);
            
            if (count < 8)
                E_check[3:0] = 8 - count; // assigning E
            else
                E_check[3:0] = 0; // assigning E
                
//             $display(" E_check:%b", E_check);
            
            if((i-4)<0)
                begin
                    round = 0;
                    for (j = i; j>=0; j=j-1)
                        begin
                            F[j] = bit[j]; // assigning F to the 4 bits following the 0s
                        end
                end
            else
                begin
                    round = bit[i-4];
                    for (j = 1; j <= 4;j = j + 1)
                        begin
//                         $display(" i: %d, j:%d, setting F: %d, to bit: %d", i, j, (4-j), (i-j+1));
                            F[4-j] = bit[i-j+1]; // assigning F to the 4 bits following the 0s
                        end
                end
//            $display(" F before rounding: %b", F);
            
            
            if (round)
                F_check = F + 1;
            else
                F_check = F;
        
//        $display("F_check: %b", F_check);
        
            if (F_check[4])
                begin
                    F_check = F_check >> 1;
                    E_check = E_check + 1;
//                    $display(" E_check overflow:%b", E_check);
                end

            
            
            if (E_check[3])
                begin
                    S = 1'b0; // answers for special case
                    E = 3'b111;
                    F = 4'b1111;
//                    $display("F value E over flow:%b", F);
                end 
            else
                begin
                    E = E_check[2:0];
                    F = F_check[3:0];
//                    $display("F value E normal:%b, F_check: %b", F, F_check);
                end
                $display("input:%b, E: %b, F: %b, S:%b", D, E, F, S);
        end
end

endmodule
