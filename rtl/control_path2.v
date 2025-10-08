`timescale 1ns / 1ps

module control_path2(done,PS, ldA, ldB, sel1, sel2, sel_in, lt, gt, eq, data_in, start, clk);
    input lt, gt, eq, start, clk;
    input [15:0] data_in;
    output reg done, ldA, ldB, sel1, sel2, sel_in;
    parameter s0=0, s1=1,s2=2,s3=3,s4=4, s5=5;
    reg [2:0] NS;
    output reg [2:0] PS;
    
    always @(posedge clk)
        if (start) PS<=NS;
        else PS<=s0;
        
        
    //PS is the state and output of the comparotor act as inputs(kind of)
    always @(PS or eq or gt or lt)
        begin ldA=0; ldB=0; sel1=0; sel2=0; sel_in=0; 
        case(PS)
            s0: begin sel1=0; sel2=0; sel_in=1; NS=s1;
                      ldB=0; ldA=1; done=0; end
            s1: begin sel1=0; sel2=0; sel_in=1; NS=s2;
                      ldA=0; ldB=1; end
            s2: begin 
                if (lt) begin sel1=1; sel2=0; sel_in=0; NS=s3;
                        ldA=0; ldB=1; end
                else if(gt) begin sel1=0; sel2=1; sel_in=0; NS=s4;
                        ldB=0; ldA=1; end
                else if (eq) begin done=1; NS=s5; end
                end
            s3: begin 
                if (lt) begin sel1=1; sel2=0; sel_in=0; NS=s3;
                        ldA=0; ldB=1; end
                else if(gt) begin sel1=0; sel2=1; sel_in=0; NS=s4;
                        ldB=0; ldA=1; end
                else if (eq) begin done=1; NS=s5; end
                end
            s4: begin 
                if (lt) begin sel1=1; sel2=0; sel_in=0; NS=s3;
                        ldA=0; ldB=1; end
                else if(gt) begin sel1=0; sel2=1; sel_in=0; NS=s4;
                        ldB=0; ldA=1; end
                else if (eq) begin done=1; NS=s5; end
                end
                
            s5: begin done=1; sel1=0; sel2=0; sel_in=0; NS=s5;
                 ldA=0; ldB=0; end
        
            
        endcase
        end
        
endmodule
