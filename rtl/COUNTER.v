`timescale 1ns/1ps

module COUNTER(out, data, load, count , clk);
    input [15:0] data;
    input load , count, clk;
    output reg [15:0] out;
    
    always @(posedge clk)
        if (load) out<=16;
        else if(count) out<=out-1;
        
endmodule