module up_down_counter(
  input            clk, reset, load, up,
  input      [3:0] load_val,
  output reg [3:0] count
);

  always @(posedge clk) begin
    if (reset)  count <= 4'b0;
    else begin
      if (load) count <= load_val;
      else      count <= count + (up ? 1 : -1);
    end
  end

endmodule
