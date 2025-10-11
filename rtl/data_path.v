`timescale 1ns / 1ps
//implementing booths algorithm for signed multiplication
//MOORE LIKE STYLE 
module data_path(A,Q, q0,qm1,eqz, data_in,ldA, clrA,  ldQ, clrQ, ldM, clrFF, shift, addsub, ldB, count, clk);
    input [15:0] data_in;
    input ldA, clrA, ldQ, clrQ,ldM, clrFF, shift,addsub, ldB, count, clk;
    output q0, qm1, eqz;
    
    output [15:0] A,Q;
    wire [15:0] M, Z, B;
    assign eqz = |B;
    assign q0 = Q[0];
    
    //shift plus pipo reg
    SPIPO regA(A,Z, A[15], ldA, clrA, shift, clk);
    SPIPO regQ(Q,data_in, A[0], ldQ, clrQ, shift, clk);
    
    //flip flop
    FF ffqm1(qm1, Q[0],shift, clrFF, clk);
    
    //M register
    PIPO regM(M, data_in, ldM, clk);
    
    //adder subtractor'
    ALU as(Z, A, M, addsub); //addsub=1 corresponds to additoi
    
    //counter connected to data_in for loading and; gives decrement count output
    COUNTER countB( B,data_in, ldB,count, clk);
    //commparator for B
    
   
endmodule
