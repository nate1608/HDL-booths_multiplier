`timescale 1ns/1ps

module FF(dout, din,shift, clr, clk);
    input din,clr ,clk, shift;
    output reg dout;
    
    always @(posedge clk)
        if (clr) dout<=0;
        else if (shift) dout<=din;
        
endmodule