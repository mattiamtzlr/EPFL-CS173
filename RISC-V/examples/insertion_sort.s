# Ver. 25-May-2024
# RIVS-V ISA: RV32I
# Author: Mirjana Stojilovic

# .data segment starts at the address 0x1000 0000
# addresses grow towards higher addresses
# example initialization of arr[]
.data
  .word 7    # mem[0x1000 0000]
  .word 15   # mem[0x1000 0004]
  .word 0    # mem[0x1000 0008]
  .word 4    # mem[0x1000 000C]
  .word -5   # mem[0x1000 0010]
  .word -99  # mem[0x1000 0014]
  .word 1    # mem[0x1000 0018]
  .word 100  # mem[0x1000 001C]
  .word 17   # mem[0x1000 0020]
  .word -1   # mem[0x1000 0024]

# .text segment starts at the address zero
# it is where code is stored
# addresses grow towards higher addresses

.text

# a1 is the number of array elemenets
# a0 is the memory address of the first element of the array (i.e., arr[0])

# initialize the starting address of the array
# to the beginning of the .data region
lui   a0, 0x10000 # high 20 bits of the address
addi  a0, a0, 0   # 0 in the low 12 bits

# initialize n
addi  a1, zero, 10

# call the function
jal ra, insertion_sort

# function
insertion_sort:
  addi  t0, zero, 1     # i = 1
  addi  t1, a0, 4       # t1 is pointer to arr[i]

outer_loop:             # loop condition check
  # if i < n, go to continue_outer_loop
  bltu  t0, a1, continue_outer_loop  

exit_outer_loop:
  jalr  zero, 0(ra)     # return from the function

continue_outer_loop:    # loop body starts
  lw    t3, 0(t1)       # var = arr[i]
  addi  t4, t0, 0       # j = i
  addi  t5, t1, 0       # t5 is pointer to arr[j]

inner_loop:             # loop condition check
  lw    t6, -4(t5)      # t6 = arr[j-1]
  # if arr[j-1] <= arr[i], go to exit_inner_loop
  bge   t3, t6, exit_inner_loop

continue_inner_loop:    # loop body starts
  sw    t6, 0(t5)       # arr[j] = arr[j-1]
  addi  t4, t4, -1      # j--
  addi  t5, t5, -4      # decrement t5 to point to arr[j]
  # loop condition check
  # if j != 0, go to inner_loop
  bne   t4, zero, inner_loop

exit_inner_loop:
  sw    t3, 0(t5)       # arr[j] = var
  addi  t0, t0, 1       # i++
  addi  t1, t1, 4       # update t1, points to arr[i]
  j     outer_loop      # go to outer_loop