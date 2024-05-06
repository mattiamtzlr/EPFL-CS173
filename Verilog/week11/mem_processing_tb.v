module memProcessingTB ();
    
    reg clk;
    reg [7:0] dataInA;
    reg reset;
    reg init;

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    memProcessing uut (
        .clock(clk),
        .reset(reset),
        .init(init),
        .dataInA(dataInA)
    );

    initial begin
        $dumpfile("mem_processing.vcd");
        $dumpvars(0, memProcessingTB);

        dataInA = 0;
        reset = 1;
        init = 1;
        #10 reset = 0;
        #2 init = 0;
        #2 dataInA = 1;
        #2 dataInA = 2;
        #2 dataInA = 3;
        #2 dataInA = 7;
        #2 dataInA = 6;
        #2 dataInA = 5;
        #2 dataInA = 4;
        // Setting Init to 1 to check the state returns to READA from HALT
        #80 init = 1;
        #50

        // check if it is correct
        if (uut.MemoryB.mem[0] == 1 && uut.MemoryB.mem[1] == 5 && uut.MemoryB.mem[2] == 1 && uut.MemoryB.mem[3] == 1) begin
            $display("Test passed");
        end else begin
            $display("Test failed");
            $display("Expected: 1 5 1 1");
            $display("Actual: %d %d %d %d", uut.MemoryB.mem[0], uut.MemoryB.mem[1], uut.MemoryB.mem[2], uut.MemoryB.mem[3]);
        end
        $finish;
    end
endmodule
