module test_full_adder_v2;

  // Define three inputs that can procedurally be assigned values.
  reg  x, y, cin;
  // And two outputs that respond to them.
  wire s, cout;

  // Connect them to an instantiated full_adder_v2 module.
  full_adder_v2 fa2 (.x(x), .y(y), .c_in(cin), .s(s), .c_out(cout));

  // Loop variable.
  integer i;

  initial begin
    // Write this test's data to a .vcd file that GTKWave can read.
    $dumpfile ("full_adder_v2.vcd");
    $dumpvars;

    // Print values whenever they change.
    $monitor ("Time %2t, x=%b, y=%b, cin=%b, s=%b, cout=%b",
              $time, x, y, cin, s, cout);

    // Exhaust all input combinations,
    // each time followed by a delay of 1 time unit.
    for (i = 0; i < 8; i += 1) begin
      // Each variable gets one bit from i.
      // First 0, 0, 0
      // then  0, 0, 1, etc.
      {x, y, cin} = i;
      #1;
    end

    // Done.
    $finish;
  end

endmodule
