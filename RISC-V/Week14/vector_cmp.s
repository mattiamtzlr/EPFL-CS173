.data
  vector: .half 3751, 8413,  423, -120, 9138, 2391, -374,  746, 5672, 2410
  #             A[0], B[0], A[1], B[1], A[2], B[2], A[3], B[3], A[4], B[4]

  # Because of little-endian byte-ordering A[i] will actually be in the LSB 
  # and B[i] in the MSB

  # Expected # of A[i] > B[i]: 3

.text
  la   s0, vector           # address of first element
  li   s2, 5                # vector has 5 elements
  li   s1, 0                # initialise difference counter

  li   t0, 0                # initialise vector index
  add  t1, s0, zero         # initialise vector pointer

loop_body:
  lw   t2, 0(t1)            # get current element

  slli t3, t2, 16           # |
  srai t3, t3, 16           # |- get A[i]

  srai t4, t2, 16           # get B[i]

  bge  t4, t3, loop_head    # if B[i] >= A[i] == !(A[i] > B[i]) skip incrementing counter
  addi s1, s1, 1            # increment difference counter

loop_head:
  addi t0, t0, 1            # increment vector index
  addi t1, t1, 4            # increment vector pointer

  bne  t0, s2, loop_body    # repeat while elements remain

  # print out difference counter
  li   a0, 1
  add  a1, s1, zero
  ecall
  li   a0, 10
  ecall
