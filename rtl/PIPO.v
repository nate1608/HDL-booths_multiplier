`timescale 1ns/1ps

module PIPO(dout, din, load, clk);
    input [15:0] din;
    input load, clk;
    output reg [15:0] dout;
    
    always @(posedge clk)
        if (load) dout<=din;
endmodule