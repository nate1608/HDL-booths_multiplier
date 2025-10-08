`timescale 1ns/1ps

module data_path(Aout, Bout,subout, lt,gt,eq, ldA, ldB, sel1, sel2, sel_in, data_in, clk);
    input ldA, ldB, sel1, sel2, sel_in, clk;
    input [15:0] data_in;
    output lt, gt, eq;
    output [15:0] Aout,Bout,subout;
    wire [15:0] bus, x,y;
    
    PIPO A(Aout, bus, ldA, clk);
    PIPO B(Bout, bus, ldB, clk);
    MUX selx(x, Aout, Bout, sel1);
    MUX sely(y, Aout, Bout, sel2);
    MUX sel_data(bus, subout, data_in, sel_in);
    
    SUBTRACT sub( subout, x,y);
    COMP cmp(lt,gt,eq, Aout, Bout);
endmodule