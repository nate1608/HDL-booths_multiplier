`timescale 1ns / 1ps

module SPIPO(pout, pin, din, load,clr,  shift, clk);
    input [15:0] pin;
    input din, load,clr,  shift, clk;
    output reg [15:0] pout;
    
    always @(posedge clk)
        if (clr) pout<=16'b0;
        else if (load) pout<=pin;
        else if (shift) pout<={din, pout[15:1]};
        
endmodule
