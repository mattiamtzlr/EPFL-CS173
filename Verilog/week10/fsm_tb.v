module fsm_tb;
  reg clk, reset, W;
  wire Z;

  fsm DUT (.clk(clk), .reset(reset), .W(W), .Z(Z));

  initial begin
    $dumpfile("fsm.vcd");
    $dumpvars(0, fsm_tb);
    reset = 1;
    clk = 0;
    W = 0;
    #10 reset = 0; // State -> 00
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10; // 00 -> 10
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10; // 10 -> 11
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10 W = 1; // 11 -> 10
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10; // 10 -> 00
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10; // 00 -> 11
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10 W = 0; // 11 -> 01
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10 W = 1; // 01 -> 01
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10; // 01 -> 00
    $display("Internal State = %b, Output = %b", DUT.S, Z);
    #10 $finish;
  end

  always begin
    #5 clk = ~clk;
  end
endmodule
