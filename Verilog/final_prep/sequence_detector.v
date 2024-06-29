// Moore FSM with inputs w1, w1 that outputs 1 if w1 == w2 for four or more (4+) 
// clock cycles, otherwise 0. Asynchronous power-on active-high reset.

module sequence_detector (
  input      clk, reset, w1, w2,
  output reg out
);

  parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;
  reg [2:0] state, next_state;
  
  always @* begin
    next_state = A;
    if (w1 == w2) begin
      case (state)
        A: next_state = B;
        B: next_state = C;
        C: next_state = D;
        D: next_state = E;
        E: next_state = E;
      endcase
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) state <= A;
    else       state <= next_state;
  end

  always @* begin
    out = (state == E);
  end

endmodule
