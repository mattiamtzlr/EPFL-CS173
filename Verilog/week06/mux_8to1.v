module mux_8to1 (
  input  [2:0] x1, x2, x3, x4, x5, x6, x7, x8,

  // as there are 8 inputs we need log_2(8) = 3 select bits:
  input  [2:0] s,

  output reg [2:0] f
);

  always @* begin

    case (s)
      3'b000: f = x1;
      3'b001: f = x2;
      3'b010: f = x3;
      3'b011: f = x4;
      3'b100: f = x5;
      3'b101: f = x6;
      3'b110: f = x7;
      3'b111: f = x8;
    endcase

  end
endmodule
