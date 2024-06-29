module periodic_tb;
  reg  clk, reset;
  wire out;

  periodic dut (.clk(clk), .reset(reset), .out(out));

  integer expected;

  initial begin
    clk = 0;
    reset = 0;

    #10 reset = 1;
    #10 reset = 0;
    $display("Reset test %s", (out == 0) ? "passed" : "failed");


    for (integer i = 1; i <= 10_000; i = i + 1) begin
      #10;
      // 0 for the first 2048 clock cycles, 1 for the next 2048 clock cycles, etc.
      expected = (i % 4096) / 2048;

      if (out != expected) begin
        $display(
          "Count test failed at time %d, with value %b instead of %b",
          i, out, expected
        );
        $finish;
      end
    end

    $display("Count test passed");
    $finish;
  end

  always #5 clk = ~clk;

endmodule
