`timescale 1ns/1ps

module SUBTRACT(sub, a, b);
    input [15:0] a, b;
    output [15:0] sub;
    
    assign sub=a-b;
endmodule