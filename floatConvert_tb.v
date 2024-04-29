`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 10:50:48 AM
// Design Name: 
// Module Name: floatConvert_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module floatConvert_tb;

reg [12:0] input_T;
reg [11:0] input_D;
wire out_S;
wire [2:0] out_E;
wire [3:0] out_F;



 fConv temp(.S(out_S), .E(out_E), .F(out_F), .D(input_D));


initial
    begin
        #100;
        input_D = 12'b000001111101;

        #50 input_D = 12'b011111111111;

        #50 input_D = 12'b000110100110;

        #50 input_D = 12'b111111111111;

                

               //                    $display("INPUT: %b", input_D))
           
    end
endmodule
