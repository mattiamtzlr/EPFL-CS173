module mux_2to1 (
  input x1, x2, s,
  output reg f
);

  always @* begin
    if (s == 0) begin
      f = x1;
    end
    else begin
      f = x2;
    end
  end
endmodule
