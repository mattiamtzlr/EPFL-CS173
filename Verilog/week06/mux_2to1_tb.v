module test_mux_2to1;

  // Define three inputs that can procedurally be assigned values.
  reg  x1, x2, sel;
  // And one output that responds to them.
  wire out;

  // Connect them to an instantiated mux_2to1 module.
  mux_2to1 mux2 (.x1(x1), .x2(x2), .s(sel), .f(out));

  initial begin
    // Write this test's data to a .vcd file that GTKWave can read.
    $dumpfile ("mux_2to1.vcd");
    $dumpvars;

    // Print values whenever they change.
    $monitor ("Time %2t, sel=%b, x1=%b, x2=%b, out=%b",
              $time, sel, x1, x2, out);

    // Exhaust all input combinations,
    // each time followed by a delay of 1 time unit.
    sel = 0; x1 = 0; x2 = 0; #1;
    sel = 0; x1 = 0; x2 = 1; #1;
    sel = 0; x1 = 1; x2 = 0; #1;
    sel = 0; x1 = 1; x2 = 1; #1;

    sel = 1; x1 = 0; x2 = 0; #1;
    sel = 1; x1 = 0; x2 = 1; #1;
    sel = 1; x1 = 1; x2 = 0; #1;
    sel = 1; x1 = 1; x2 = 1; #1;

    // Done.
    $finish;
  end

endmodule
