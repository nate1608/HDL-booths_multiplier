`timescale 1ns/1ps

//MOORE LIKE STYLE 
// SO THE CONDITIONS ARE CHECKED IN S2
// ARITHMATICS IS DONE IN S3 AND S4
// SHIFTING IS DONE IN S5
// TAKES TWO CYCLES(ONE FOR LOADING THE ARITHMETIC AND OTHER FOR SHIFTING)


module control_path(PS, ldA, clrA,  ldQ, clrQ, ldM, clrFF, shift, addsub, ldB, count, done,
                     q0, qm1, eqz, clk, start, data_in);
    input q0, qm1, eqz, clk, start;
    input [15:0] data_in;
    output reg ldA, clrA,  ldQ, clrQ, ldM, clrFF, shift, addsub, ldB, count, done;
    reg [2:0] NS;
    output reg [2:0] PS;
    parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6;
    
    
    always @(posedge clk)
        if (start) PS<=NS;
        else PS<=s0;
        
    always @(PS or q0 or qm1 or eqz)
        begin
            ldA=0; clrA=0;  ldQ=0; clrQ=0; ldM=0; clrFF=0; shift=0; addsub=0; ldB=0; count=0; done=0;
            case(PS)
            s0: begin
                    clrA=1; clrFF=1; ldQ=1; ldB=1; NS=s1; 
                end
            s1: begin
                    ldM=1; NS=s2;
                end
            s2: begin
                    if (eqz==0) NS=s6;
                    else if (q0~^qm1)  NS=s5; 
                    else if (q0&(~qm1)) NS=s4;     
                    else if ((~q0)&qm1)  NS=s3;
                end
             
            s3: begin
                    addsub=1; ldA=1;
                    NS=s5;
                end
                
            s4: begin
                    addsub=0; ldA=1;
                    NS=s5;
                end
                
            s5: begin
                   shift=1; count=1;
                    NS=s2;
                end
            s6: begin
                    done=1; NS=s6;
                end
            endcase
        end   
        

endmodule
