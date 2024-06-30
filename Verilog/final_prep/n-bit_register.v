// parametrized n-bit register with synchronous clear signal
module n_bit_register(CLK, CLR, D, Q);
  parameter N = 1; // default: 1 bit

  input      CLK, CLR;
  input      [N-1:0] D;
  output reg [N-1:0] Q;

  always @(posedge CLK) begin
    if (CLR)
      Q <= 0;
    else
      Q <= D;
  end
endmodule


module main;
  reg         CLK, CLR;
  reg  [7:0]  D8;
  wire [7:0]  Q8;

  reg  [15:0] D16;
  wire [15:0] Q16;

  n_bit_register #(.N(8))  register_8bit  (.CLK(CLK), .CLR(CLR), .D(D8),  .Q(Q8));
  n_bit_register #(.N(16)) register_16bit (.CLK(CLK), .CLR(CLR), .D(D16), .Q(Q16));

endmodule
