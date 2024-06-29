module sequence_detector_tb;
  reg  clk, reset, w1, w2;
  wire out;

  sequence_detector dut (.clk(clk), .reset(reset), .w1(w1), .w2(w2), .out(out));

  initial begin
    $dumpfile("sequence_detector.vcd");
    $dumpvars(0, sequence_detector_tb);

    clk = 0;
    reset = 0;

    #6 reset = 1;
    #2 $display("Async reset test %s", (out == 0) ? "passed" : "failed");
    #2 reset = 0;

    
    w1 = 0; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 1; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 1; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 0; w2 = 0; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 1; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 1) ? "passed" : "failed");

    w1 = 1; w2 = 0; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 1; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 0; w2 = 0; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 0; w2 = 0; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");

    w1 = 0; w2 = 0; #10
    $display("Time: %3d | %s", $time, (out == 1) ? "passed" : "failed");

    w1 = 1; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 1) ? "passed" : "failed");

    w1 = 1; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 1) ? "passed" : "failed");

    w1 = 0; w2 = 1; #10
    $display("Time: %3d | %s", $time, (out == 0) ? "passed" : "failed");


    $finish;
  end

  always #5 clk = ~clk;

endmodule
