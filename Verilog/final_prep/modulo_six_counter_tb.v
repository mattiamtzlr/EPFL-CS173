module modulo_six_counter_tb;

  reg        clk, reset, enable;
  wire [2:0] count;

  modulo_six_counter dut (.clk(clk), .reset(reset), .enable(enable), .count(count));
  integer expected;

  initial begin
    $dumpfile("modulo_six_counter.vcd");
    $dumpvars(0, modulo_six_counter_tb);

    clk = 0;
    reset = 0;
    enable = 0;

    #10 reset = 1;
    #10 reset = 0;
    $display("Reset test %s", (count == 3'b0) ? "passed" : "failed");
    
    #10 enable = 1;
    for (integer i = 1; i <= 10; i = i + 1) begin
      #10
      expected = i % 6;
      
      $display(
        "%2d: count = %d | expected = %1d | %s", 
        i, count, expected, (count == expected) ? "passed" : "failed"
      );
    end

    enable = 0;
    #10
    $display("Disable test %s", (count == 4) ? "passed" : "failed");

    $finish;
  end

  always #5 clk = ~clk;

endmodule
