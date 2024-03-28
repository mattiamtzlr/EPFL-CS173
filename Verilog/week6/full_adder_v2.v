module half_adder (
  input  x, y,
  output s, c
);

  xor (s, x, y);
  and (c, x, y);

endmodule

module full_adder_v2 (
  input  x, y, c_in,
  output s, c_out
);

  half_adder ha1 (.x(x),    .y(y),       .s(x_xor_y), .c(x_and_y));
  half_adder ha2 (.x(c_in), .y(x_xor_y), .s(s),       .c(ha_2_result));

  or (c_out, x_and_y, ha_2_result);
  
endmodule
