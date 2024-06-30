.data
  text:   .string "Number of times where A[i] > B[i]: "

  vector: .word   0xFFFA0008, 0x00A20043, 0xFFF1FFE5, 0x000C002A, 0x00070003, 0x0
  # A = [-6, 162, -15, 12, 7, 0]
  # B = [ 8,  67, -27, 42, 3, 0]

  # Expected # of A[i] > B[i]: 3

.text
  la   s0, vector           # address of first element
  li   s1, 0                # initialise difference counter

  add  t1, s0, zero         # initialise vector pointer

loop:
  lw   t2, 0(t1)            # get current element

  srai t3, t2, 16           # get A[i]

  slli t4, t2, 16           # |
  srai t4, t4, 16           # |- get B[i]

  slt  t5, t4, t3           # t5 = (A[i] > B[i]) ? 1 : 0
  add  s1, s1, t5           # add t5 to counter

  addi t1, t1, 4            # increment vector pointer
  bne  t2, zero, loop       # repeat while current element isn't zero

  
  li   a0, 4                # print out text and difference counter
  la   a1, text
  ecall

  li   a0, 1
  add  a1, s1, zero
  ecall

  li   a0, 10               # exit
  ecall
