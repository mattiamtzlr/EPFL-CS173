`include "comparator.v"

module absolute_difference_calculator (
  input  [3:0]     A, B,
  output reg [3:0] result
);
  wire A_eq_B, A_gt_B, A_lt_B;
  
  comparator comp (.A(A), .B(B), .A_eq_B(A_eq_B), .A_gt_B(A_gt_B), .A_lt_B(A_lt_B));

  initial begin
    case ({A_eq_B, A_gt_B, A_lt_B})
      3'b100: result = 4'b0;
      3'b010: result = A - B;
      3'b001: result = B - A;
    endcase
  end
endmodule
