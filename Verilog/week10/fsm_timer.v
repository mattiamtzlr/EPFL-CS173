module fsm_timer (
  input clk,
  input resetn, // "n" for negated, active-low
  input in,
  output reg out
);

  parameter IDLE = 2'b00, A = 2'b01, B = 2'b10;
  reg [1:0] current_state, next_state;
  reg [3:0] count;

  // state transitions
  always @(*) begin
    next_state = current_state;
    case (current_state)
      IDLE: begin
        if (in) next_state = A;
        else    next_state = IDLE;
      end

      A: begin
        if (in && count == 9) next_state = B;
        else if (in)          next_state = A;
        else                  next_state = IDLE;
      end

      B: begin
        next_state = IDLE;
      end

      default: next_state = IDLE;
    endcase 
  end

  // output logic
  always @(*) begin
    out = (current_state == B);
  end

  // next state assignment at rising clk edge
  always @(posedge clk) begin
    if (resetn) current_state <= IDLE;
    else        current_state <= next_state;
  end

  // increment count until it reaches 9, if in is high, reset count when in is
  // high in IDLE state and when reset is active
  always @(posedge clk) begin
    if (resetn)                                     count <= 0;
    else if (current_state == A && in && count < 9) count <= count + 1;
    else if (current_state == IDLE && in)           count <= 0;
  end
endmodule
