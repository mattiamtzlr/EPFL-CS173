module modulo_six_counter(
  input            clk, reset, enable,
  output reg [2:0] count
);

  always @(posedge clk) begin
    if (reset) count <= 3'b0;
    else if (enable) begin 
      count <= (count < 5) ? count + 1 : 3'b0;
    end
  end

endmodule
