`timescale 1ns/1ps

module ALU(out, a,b , addsub);
    input [15:0] a, b;
    input addsub;
    output reg [15:0] out;
    
    always @(*)
        if (addsub) out = a+b;
        else out=a-b;
endmodule
       