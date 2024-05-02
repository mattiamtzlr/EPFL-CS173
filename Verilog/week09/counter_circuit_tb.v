module tb_counter_circuit;
    reg clk, clr;
    wire [3:0] X, Y;

    counter_circuit DUT(
        .clk(clk),
        .clr(clr),
        .X(X),
        .Y(Y)
    );

    initial begin
        $dumpfile("tb_counter_circuit.vcd");
        $dumpvars(0, tb_counter_circuit);

        clk = 0;
        clr = 1;
        #10 clr = 0;
        #5 $display("Y = %d, X = %d", X, Y);
        for(integer i = 0; i < 103; i = i + 1) begin
            #10 $display("Y = %d, X = %d", Y, X);
        end
        $finish;
    end

    always begin
        #5 clk = ~clk;
    end

endmodule

