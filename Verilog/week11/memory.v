module memory (addr, dataIn, we, clk, dataOut);
  parameter addrWidth = 3; // default
  parameter dataWidth = 8; // default

  input      we, clk;
  input      [addrWidth-1 : 0] addr;
  input      [dataWidth-1 : 0] dataIn;
  output reg [dataWidth-1 : 0] dataOut;

  // memory array:
  reg [dataWidth-1 : 0] mem [2**addrWidth-1 : 0];

  always @ (posedge clk) begin
    if (we) mem[addr] <= dataIn;

    dataOut <= mem[addr];
  end

endmodule
