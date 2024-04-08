module absolute_difference_calculator_tb;
  reg [3:0] A, B;
  wire [3:0] result;

  absolute_difference_calculator calc (.A(A), .B(B), .result(result));

  initial begin
    for (integer i = 0; i < 16; i = i + 1) begin
      for (integer j = 0; j < 16; j = j + 1) begin
        A = i;
        B = j;
        #1;

        if (
            (A > B & result != A - B) |
            (A < B & result != B - A) |
            (A == B & result != 0)
        ) begin
          $display("[%d, %d] ERROR: Wrong output", A, B);
        end else begin
          $display("[%d, %d] Correct output", A, B);
        end
      end
    end
  end
endmodule
