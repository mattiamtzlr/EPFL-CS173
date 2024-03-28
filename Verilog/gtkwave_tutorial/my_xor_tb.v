// testbench for my_xor.v
module test_my_xor;

// define inputs that can store a value
reg a, b, c;
// and one output that responds to them
wire f;

// connect them to an instance of my_xor;
my_xor my_gate(f, a, b, c);

initial begin
  // write data to .vcd file
  $dumpfile("my_xor.vcd");
  $dumpvars(0, test_my_xor);

  // print values whenever they change
  $monitor("At time %2t, a=%b, b=%b, c=%b, f=%b", $time, a, b, c, f);

  // start with all inputs 0
  a = 0; b = 0; c = 0;

  // small time delay of 5 time units
  #5

  // toggle each input with small delays in-between
  a = 1; #5 b = 1; #5 c = 1; #5

  $finish;
end

endmodule
