module lfsr_tb;
  reg clock, reset, load;
  wire [2:0] Q;

  lfsr LFSR (.clock(clock), .reset(reset), .load(load), .seed(3'b001), .Q(Q));

  initial begin
    $dumpfile("lfsr.vcd");
    $dumpvars(0, lfsr_tb);

    reset = 1;
    load = 0;
    clock = 0;

    #10 reset = 0; load = 1;
    #10 load = 0;
    $display("Output = %b", Q);
    #10;
    $display("Output = %b", Q);
    #10;
    $display("Output = %b", Q);
    #10;
    $display("Output = %b", Q);
    #10;
    $display("Output = %b", Q);
    #10;
    $display("Output = %b", Q);
    #10;
    $display("Output = %b", Q);

    #5 $finish;
  end

  always begin
    #5 clock = ~clock;
  end
endmodule
