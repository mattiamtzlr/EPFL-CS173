.data
    array0: .word  7, -3, -5, -5,  2,  4, -5,  0,  4, -6,  3,  9,  4, -5,  3, -5, -7, -7,  5, -1,  1,  2,  0, -8, -8,  2,  9, -4,  7, -1, -4, -8
    array1: .word  7,  9, -5,  9,  9,  7,  9,  3, -8,  9, -4,  0,  9, -3, -8,  6,  1, -6, -3,  4,  8, -1,  9, -6, -4, -7,  0, -8,  5, -9,  6, -3

    # expected difference count: ???

.text
    la   s0, array0
    la   s1, array1
    li   s2, 32

init:
    li   t6, 0                  # initialise element counter
    add  t0, zero, s0           # t0 points to array0[0]
    add  t1, zero, s1           # t0 points to array1[0]

    li   s3, 0                  # initialise difference counter

loop_body:
    lw   t2, 0(t0)              # load array0[i]
    lw   t3, 0(t1)              # load array1[i]

    srli t2, t2, 31             # isolate sign of array0[i]
    srli t3, t3, 31             # isolate sign of array1[i]

    xor  t4, t2, t3             # check if signs are different

    add  s3, s3, t4             # adjust difference counter

loop_head:
    addi t6, t6, 1              # update program counter
    addi t0, t0, 4              # udpate array0 pointer
    addi t1, t1, 4              # udpate array1 pointer

    bne  s2, t6, loop_body      # repeat while more elements

    li   a0, 1                  # set ecall ID for print_int
    add  a1, zero, s3           # copy result to ecall argument
    ecall                       # print result

    li   a0, 10                 # set ecall ID for exit
    ecall                       # exit with zero exit code (OK)
    