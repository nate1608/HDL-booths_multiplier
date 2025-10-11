`timescale 1ns / 1ps

module tb_data_path_control();
    reg [15:0] data_in;
    reg start;
    wire done, eqz;
    reg clk;
    wire [2:0] state;
    wire [15:0] Aout, Qout;
    
    
    data_path DP(Aout, Qout, q0,qm1,eqz,data_in,ldA, clrA,  ldQ, clrQ, ldM, clrFF, shift, addsub, ldB, count, clk);
    control_path CP(state, ldA, clrA,  ldQ, clrQ, ldM, clrFF, shift, addsub, ldB, count, done,
                     q0, qm1, eqz, clk, start, data_in);
                     
                     
    initial 
        begin
            clk=1'b0;
           #11 start=1;
           #500 $finish;
        end
        
    always #5 clk=~clk;
    
    initial 
        begin
            #12 data_in=15;
            #10 data_in=-10;
            
        end
    
    initial $monitor ($time, " %b, %d" , {DP.A,DP.Q}, $signed({DP.A, DP.Q}));
    
endmodule
