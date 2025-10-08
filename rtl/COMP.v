`timescale 1ns/1ps

module COMP(lt, gt, eq, in1, in2);
    input [15:0] in1, in2;
    output lt, gt, eq;
    
    assign lt= (in1<in2);
    assign gt= (in1>in2);
    assign eq= (in1==in2);

endmodule