// minecraft reference ???
module comparator(
  input  [3:0] A, B,
  output reg   A_eq_B, A_gt_B, A_lt_B
);
  initial begin
    if (A > B) begin
      A_gt_B = 1;
    end else if (A < B) begin
      A_lt_B = 1;
    end else begin
      A_eq_B = 1;
    end
  end
endmodule
