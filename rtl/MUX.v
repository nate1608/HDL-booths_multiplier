`timescale 1ns/1ps

module MUX(out, i0, i1, sel);
    input [15:0] i0, i1;
    input sel;
    output [15:0] out;
    
    assign out = sel?i1:i0;

endmodule