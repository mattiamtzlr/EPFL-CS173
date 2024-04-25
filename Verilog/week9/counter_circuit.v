module counter_circuit(
  input clk, clr,
  output reg [3:0] X, Y
);

  always @ (posedge clk) begin
    if (clr) begin
      X = 0;
      Y = 0;
    end else begin
      if (X > 8) begin
        X = 0;
        Y = Y + 1;
      end else begin
        X = X + 1;
        if (Y > 9)
          Y = 0;
      end
    end
  end

endmodule
