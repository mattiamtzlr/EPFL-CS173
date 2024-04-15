module gray_encoder_tb;
  reg   [2:0] binary_in;
  reg         select;
  wire  [2:0] out;
  reg   [2:0] expected;

  gray_encoder enc (.binary_in(binary_in), .select(select), .out(out));

  initial begin
    for (integer j = 0; j < 2; j = j + 1) begin
      select = j;
      if (select == 0) begin
        for (integer i = 0; i < 8; i = i + 1) begin
          binary_in = i;
          #1;

          if (out != binary_in) begin
            $display("[%d] ERROR: Wrong output", binary_in);
          end else begin 
            $display("[%d] Correct output", binary_in);
          end
        end

      end else begin
        for (integer j = 0; j < 8; j = j + 1) begin
          binary_in = j;
          #1;

          case (binary_in)
            3'b000: expected = 3'b000;
            3'b001: expected = 3'b001;
            3'b010: expected = 3'b011;
            3'b011: expected = 3'b010;
            3'b100: expected = 3'b110;
            3'b101: expected = 3'b111;
            3'b110: expected = 3'b101;
            3'b111: expected = 3'b100;
          endcase

          if (out == expected) begin
            $display("[%d] Correct output", binary_in);
          end else begin
            $display("[%d] ERROR: Wrong output", binary_in);
          end
        end
      end
    end
  end
endmodule
