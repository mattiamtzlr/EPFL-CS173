.data
  matrix:   .byte   12, 78, 35, 11, 34, 113, 46, 122, 56, 24, 57, 33
  max_text: .string "Position of max element:"
  row_text: .string "\n  row: "
  col_text: .string "\n  col: "

.text
  la   s0, matrix           # s0 points to first element of matrix
  li   s1, 4                # matrix has four rows
  li   s2, 3                # matrix has three columns
  li   s3, 8                # arbitrary
  li   t6, 255              # max value for 8-bit unsigned

  add  t0, zero, zero       # initialise row counter to 0
  add  t1, zero, zero       # initialise column counter to 0
  add  t3, zero, zero       # initialise max value to 0
  add  t5, s0, zero         # initialise element pointer

loop:
  lbu  t2, 0(t5)            # load current element
  add  t2, t2, s3           # add arbitrary offset defined in s3
  bltu t2, t6, loop_ctd     # if t2 + s3 is less than max value, don't clamp it
  add  t2, t6, zero         # clamp t2 to 8-bit unsigned max value

loop_ctd:
  slt  t4, t2, t3           # t4 = current < max ? 1 : 0
  bne  t4, zero, skip       # skip updating max if current < max

  add  s4, t0, zero         # row index of current max
  add  s5, t1, zero         # col index of current max
  add  t3, t2, zero         # update max

skip:
  sb   t2, 0(t5)            # store current element back in matrix
  addi t5, t5, 1            # update element pointer
  addi t0, t0, 1            # update row counter
  bne  t0, s1, loop         # repeat while rows remain

  add  t0, zero, zero       # reset row counter for every new column
  addi t1, t1, 1            # update column counter
  bne  t1, s2, loop         # repeat while columns remain

print:
  li   a0, 4                # print_string ecall
  la   a1, max_text
  ecall

  la   a1, row_text
  ecall
  li   a0, 1                # print_int ecall
  add  a1, s4, zero         # load row index
  ecall

  li   a0, 4
  la   a1, col_text
  ecall

  li   a0, 1
  add  a1, s5, zero         # load col index
  ecall

  # expected: row = 3, col = 1

  li   a0, 10               # exit ecall
  ecall
