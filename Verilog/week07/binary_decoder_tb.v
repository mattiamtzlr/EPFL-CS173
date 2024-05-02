module binary_decoder_tb;
  reg  [2:0] in;
  wire [7:0] out;

  binary_decoder bd (.in(in), .out(out));

  initial begin
    $dumpfile("binary_decoder.vcd");
    $dumpvars;

    for (integer i = 0; i < 8; i = i + 1) begin
      in = i;
      #1;
      if (out != 8'b1 << i) begin
        $display("[%d] ERROR: Wrong output", i);
      end else begin
        $display("[%d] Correct output", i);
      end
    end
  end
endmodule
