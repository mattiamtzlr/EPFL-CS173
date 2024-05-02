module D_FF (
  input      clk, reset, set, D,
  output reg Q, Q_n
);
  always @ (posedge clk) begin
    if (reset) begin
      Q   <= 0;
      Q_n <= 1;
    end else if (set) begin
      Q   <= 1;
      Q_n <= 0;
    end else begin
      Q   <= D;
      Q_n <= ~D;
    end
  end
endmodule
