.data
    array: .word 2, -1, 10, 90, -7, 40, 96, 23

.text
    la   s0, array              # s0 points to the 1st array element
    li   s1, 8                  # s1 stores length of array

init:
    li   t0, 0                  # init element counter 
    add  t1, zero, s0           # t1 points to 1st element
    lw   t2, 0(s0)              # init min value with 1st element
    lw   t3, 0(s0)              # init max value with 1st element

calc_min:
    lw   t5, 0(t1)              # load current element
    slt  t4, t2, t5             # t4 = min < current ? 1 : 0
    bne  t4, zero, calc_max     # skip min update if min < current
    add  t2, zero, t5           # udpate min

calc_max:
    slt  t4, t5, t3             # t4 = current < max ? 1 : 0
    bne  t4, zero, loop         # skip max update if current < max
    add  t3, zero, t5           # update max value

loop:
    addi t0, t0, 1              # increment element counter
    addi t1, t1, 4              # move to next element
    bne  s1, t0, calc_min       # repeat as long as elements remain
    add  t4, t2, t3             # when done, add min and max
    srai s2, t4, 1              # divide (min + max) by 2 

    li   a0, 1                  # set ecall ID for print_int
    add  a1, zero, s2           # copy result to ecall argument
    ecall                       # print result

    li   a0, 10                 # set ecall ID for exit
    ecall                       # exit with zero exit code (OK)