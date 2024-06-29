module periodic(
  input      clk, reset,
  output reg out
);

  reg [11:0] count;

  always @(posedge clk) begin
    if (reset) count <= 12'b0;
    else       count <= count + 1;
  end

  always @* begin
    out = count[11];
  end

endmodule
