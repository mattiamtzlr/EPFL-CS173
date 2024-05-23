    li   t1, 0x7FFFFFFE
    li   t2, 1

    add  t0, t1, t2     
    slti t3, t2, 0              # t3 = t2 < 0  ? 1 : 0
    slt  t4, t0, t1             # t4 = t0 < t1 ? 1 : 0
    bne  t3, t4, overflow       # overflow if t3 != t4


exit:
    li   a0, 17
    add  a1, x0, t6
    ecall
    


overflow:
    li   t6, 1
    j exit


# An overflow happened if operand 2 is negative and the 
# result is not smaller than operand 1, or, if operand 2 is
# positive and the result is not greater than operand 1

# In the first case t3 = 1 and t4 = 0, in the second case
# t3 = 0 and t4 = 1.