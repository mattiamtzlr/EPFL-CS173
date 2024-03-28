module full_adder (a, b, c_in, s, c_out);
  // ----- port definitions -----
  input a, b, c_in;
  output s, c_out;

  // ----- intermediate signals -----
  wire w1, w2, w3;

  // ----- design implementation -----
  and And1 (w1, a, b);
  and And2 (w2, a, c_in);
  and And3 (w3, b, c_in);
  or Or1 (c_out, w1, w2, w3);
  xor Xor1 (s, a, b, c_in);
endmodule
