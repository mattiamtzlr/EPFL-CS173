module bit_counter_tb;
  reg [7:0] load_data;
  reg clk, reset, load, enable;

  wire [3:0] count;
  wire done;

  bit_counter dut (
    .clk(clk), .reset(reset),
    .load_data(load_data), .load(load),
    .enable(enable), .count(count), .done(done)
  );

  initial begin
    $dumpfile("bit_counter.vcd");
    $dumpvars(0, bit_counter_tb);

    clk = 0;
    reset = 1;
    enable = 0;
    load = 0;
    load_data = 8'b10111001;

    #10 reset = 0;
    load = 1;
    #10 load = 0;
    #10 enable = 1;
    #150
    $display("Binary string: %b | One count: %1d", load_data, count);
    $finish;
  end

  always #5 clk = ~clk;
endmodule
