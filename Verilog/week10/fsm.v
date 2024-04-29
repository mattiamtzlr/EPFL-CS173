module fsm (
  input clk,
  input reset,
  input W,
  output reg Z
);
  reg [1:0] S_next, S;
  parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

  always @(*) begin
    case (S)
      A: if (W == 0) S_next = C;
         else        S_next = D;

      B: if (W == 0) S_next = B;
         else        S_next = A;

      C: if (W == 0) S_next = D;
         else        S_next = A;

      D: if (W == 0) S_next = C;
         else        S_next = B;

      default:       S_next = 2'bxx;
    endcase
  end

  always @(posedge clk or posedge reset) begin
    if (reset) S <= A;
    else       S <= S_next;
  end

  always @(*) begin
    Z = (S == D);
  end

endmodule
