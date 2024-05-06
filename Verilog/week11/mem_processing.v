`include "memory.v"

module memProcessing (
  input clock,
  input reset,
  input init,
  input [7:0] dataInA
);
  reg  [2:0] addrA;
  reg  [1:0] addrB;
  wire [7:0] dOut1;
  reg  [7:0] dOut2, addOut, subOut, dataInB;
  reg weA, weB, incA, incB, sign;

  parameter READA = 2'b00, COMP = 2'b01, HALT = 2'b10;
  reg [1:0] state, stateNext;

  memory MemoryA (
    .addr(addrA),
    .dataIn(dataInA),
    .we(weA),
    .clk(clock),
    .dataOut(dOut1)
  );

  memory #(.addrWidth(2)) MemoryB (
    .addr(addrB),
    .dataIn(dataInB),
    .we(weB),
    .clk(clock)
  );


  // controller logic - next state:
  always @* begin
    stateNext = state;

    case (state)
      READA: begin
        if (init)            stateNext = READA;
        else if (addrA == 7) stateNext = COMP;
        else                 stateNext = READA;

      end
      COMP: begin
        if (init)                          stateNext = READA;
        else if (addrA == 0 && addrB == 3) stateNext = HALT;
        else                               stateNext = COMP;

      end
      HALT: begin
        if (init) stateNext = READA;
        else      stateNext = HALT;

      end

      default: stateNext = HALT;
    endcase
  end


  // controller logic - state memory:
  always @(posedge clock or posedge reset) begin
    if (reset) state <= READA;
    else       state <= stateNext;
  end


  // controller logic - outputs:
  always @* begin
    weA = 0; incA = 0; weB = 0; incB = 0;

    case (state)
      READA: begin
        weA = 1; incA = 1;
        weB = 0; incB = 0;

      end
      COMP: begin
        weA = 0;

        if (addrA == 0 && addrB == 3) incA = 0;
        else                          incA = 1;

        if (addrA[0] == 0 && !(addrA == 0 && addrB == 0)) begin
          weB = 1; incB = 1;
        end else begin
          weB = 0; incB = 0;
        end

      end
      HALT: begin
        weA = 0; incA = 0; weB = 0; incB = 0;

      end

      default: begin
        weA = 0; incA = 0; weB = 0; incB = 0;
      end
    endcase
  end


  // counter for addrA
  always @(posedge clock or posedge reset) begin
    if (reset)     addrA <= 0;
    else if (init) addrA <= 0;
    else if (incA) addrA <= addrA + 1;

  end


  // counter for addrB
  always @(posedge clock or posedge reset) begin
    if (reset)     addrB <= 0;
    else if (init) addrB <= 0;
    else if (incB) addrB <= addrB + 1;

  end


  // dOut2 logic
  always @(posedge clock or posedge reset) begin
    if (reset)     dOut2 <= 0;
    else if (init) dOut2 <= 0;
    else           dOut2 <= dOut1;

  end


  // data processing logic
  always @* begin
    addOut = 0; subOut = 0; sign = 0; dataInB = 0;

    addOut = dOut1 + dOut2;
    subOut = dOut2 - dOut1;
    sign =   dOut2 <= dOut1;

    if (sign) dataInB = addOut;
    else      dataInB = subOut;

  end

endmodule
