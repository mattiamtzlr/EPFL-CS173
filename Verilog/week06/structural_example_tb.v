module test_structural_example;
  reg a, b, c; // inputs that can be procedurally assigned
  wire f;

  structural_example ex (.a(a), .b(b), .c(c), .f(f));

  integer i;

  initial begin
    $dumpfile("structural_example.vcd");
    $dumpvars;

    $monitor("At time %2t, a=%b, b=%b, c=%b, f=%b", $time, a, b, c, f);

    for (i = 0; i < 8; i += 1) begin
      {a, b, c} = i; // assigns the binary value of i to a, b, c
      #1;
    end

    $finish;
  end
endmodule
