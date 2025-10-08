`timescale 1ns/1ps

module tb_data_path_control();
    reg [15:0] data_in;
    reg start, clk;
    wire done;
    wire [15:0] Aout, Bout,subout;
    wire [2:0] state;
    
    data_path DP(Aout, Bout,subout,lt,gt,eq, ldA, ldB, sel1, sel2, sel_in, data_in, clk);
    control_path2 CP(done, state, ldA, ldB, sel1, sel2, sel_in, lt, gt, eq, data_in, start, clk);
    
    initial 
        begin
            clk=1'b0;
            #11 start=1;
            #500 $finish;
        end
        
    always #5 clk=~clk;
    
    initial
        begin
            #12 data_in = 48048;
            #10 data_in= 15015;
        end
        
    initial $monitor($time, "A=%d , Done=%b", DP.Aout, done);
    
endmodule