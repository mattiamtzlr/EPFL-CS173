module up_down_counter_tb;
  reg        clk, reset, load, up;
  reg  [3:0] load_val;
  wire [3:0] count;

  up_down_counter dut (
    .clk(clk), .reset(reset), .load(load), .up(up), .load_val(load_val), .count(count)
  );

  initial begin
    $dumpfile("up_down_counter.vcd");
    $dumpvars(0, up_down_counter_tb);

    clk = 0;
    reset = 0;
    up = 0;
    load = 0;
    load_val = 4'b0;

    #10 reset = 1;
    #10 reset = 0;
    $display("Reset test %s", (count == 4'b0) ? "passed" : "failed");

    up = 1;
    #100 
    // count 10 times up: 100 / 5 = 20 clock cycles = 10 posedges
    // expected value: 1010 = -6 (TC)
    $display("Up count test %s", (count == 4'b1010) ? "passed" : "failed");

    up = 0;
    #50
    // count 5 times down, expected value: 0101 = 5
    $display("Down count test %s", (count == 4'b0101) ? "passed" : "failed");

    #10 load = 1;
    load_val = 4'b1101;
    #10 load = 0;
    $display("Load test %s", (count == 4'b1101) ? "passed" : "failed");

    $finish;
  end

  always #5 clk = ~clk;
endmodule
