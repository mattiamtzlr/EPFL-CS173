module lfsr (
  input clock,
  input reset,
  input load,
  input [2:0] seed,
  output reg [2:0] Q
);
  always @(posedge clock) begin
    if (load) Q <= seed;
    else begin
      Q[0] <= Q[2];
      Q[1] <= Q[0] ^ Q[2];
      Q[2] <= Q[1];
    end
  end

  always @* begin
    if (reset) Q = 0;
  end
endmodule
