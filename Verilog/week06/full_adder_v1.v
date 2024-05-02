module full_adder_v1 (
  input   x, y, c_in,
  output  s, c_out
);

  xor (p, x, y);
  and (q, x, y);

  xor (s, c_in, p);
  and (r, c_in, p);

  or  (c_out, r, q);

endmodule
