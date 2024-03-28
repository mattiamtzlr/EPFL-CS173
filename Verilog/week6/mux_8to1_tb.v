module test_mux_8to1;

  // Define all inputs as 3-bit reg variables
  // that can procedurally be assigned values.
  reg  [2:0] x1, x2, x3, x4;
  reg  [2:0] x5, x6, x7, x8;
  reg  [2:0] sel;
  // One 3-bit output.
  wire [2:0] out;

  // Connect them to an instantiated mux_8to1 module.
  mux_8to1 mux (.x1(x1), .x2(x2), .x3(x3), .x4(x4),
                .x5(x5), .x6(x6), .x7(x7), .x8(x8),
                .s(sel), .f(out));

  initial begin
    // Write this test's data to a .vcd file that GTKWave can read.
    $dumpfile ("mux_8to1.vcd");
    $dumpvars;

    // Print selector and output whenever they change.
    $monitor ("Time %2t, sel=%d, out=%d", $time, sel, out);

    // Initialize each input to a unique value.
    x1  = 3'b000;
    x2  = 3'b001;
    x3  = 3'b010;
    x4  = 3'b011;
    x5  = 3'b100;
    x6  = 3'b101;
    x7  = 3'b110;
    x8  = 3'b111;

    // Exhaust all selector combinations,
    // each time followed by a delay of 1 time unit.
    sel = 3'b111; #1;
    sel = 3'b110; #1;
    sel = 3'b101; #1;
    sel = 3'b100; #1;
    sel = 3'b011; #1;
    sel = 3'b010; #1;
    sel = 3'b001; #1;
    sel = 3'b000; #1;

    // Done.
    $finish;
  end

endmodule
