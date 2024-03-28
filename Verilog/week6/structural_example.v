module structural_example (
  input a, b, c,
  output f
);

  not (not_a, a);
  not (not_b, b);

  and (x, not_a, b);
  and (y, not_b, c);

  or  (x_y, x, y);
  not (f, x_y);

endmodule
