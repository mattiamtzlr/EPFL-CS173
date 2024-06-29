// Moore FSM with an 8-bit input, that counts the Hamming weight of that input.
// Active-high asynchronous reset.

module bit_counter(
  input            clk, reset, enable, load,
  input [7:0]      load_data,
  output reg [3:0] count,
  output reg       done
);

  parameter S1 = 2'b00, S2 = 2'b01, S3 = 2'b10;
  reg [1:0] state, next_state;
  reg [7:0] value, next_value;
  reg [3:0] next_count;

  always @* begin
    case (state)
      S1: begin
        next_state = enable ? S2        : S1;
        next_value = load   ? load_data : value;
        next_count = 0;

      end
      S2: begin
        next_state = (value == 0)        ? S3         : S2;
        next_value = enable              ? value >> 1 : value;
        next_count = (value[0] & enable) ? count + 1  : count;
        
      end
      S3: begin
        next_state = load ? S1 : S3;
        next_value = value;
        next_count = count;

      end
      default: begin
        next_state = S1;
        next_value = 0;
        next_count = 0;

      end
    endcase
  end

  always @(posedge clk, reset) begin
    if (reset) begin
      state <= S1;
      value <= 0;
      count <= 0;
    end else begin
      state <= next_state;
      value <= next_value;
      count <= next_count;
    end

  end

  always @* done = (state == S3);
endmodule
