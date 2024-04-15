module d_flip_flop_tb;
  reg  clk, reset, set, D;
  wire Q, Q_n;

  D_FF dff (.clk(clk), .reset(reset), .set(set), .D(D), .Q(Q), .Q_n(Q_n));

  initial begin
    $dumpfile("d_flip_flop.vcd");
    $dumpvars(0, d_flip_flop_tb);

    clk = 0; reset = 1; set = 0; D = 1;
    #7;
    D = 0;
    #2;
    reset = 0;
    #3;
    D = 1;
    #5;
    D = 0;
    #10;
    set = 1;
    #13;
    $finish;
  end
  always begin
    #5 clk = ~clk;
  end
endmodule
