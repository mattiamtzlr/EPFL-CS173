# Program to count the length of a string, represented as an array of characters,
# terminated by a null character (0x00). Each character takes 1 byte.

.data
  hello:  .asciiz "Hello, World!"
  output: .string " - Length: "

.text
  la   s0, hello                      # first character of string
  li   s1, 0                          # counter
  add  t0, s0, zero                   # character pointer

loop:
  lb   t1, 0(t0)                      # get current char
  addi s1, s1, 1                      # increment count
  addi t0, t0, 1                      # increment character pointer
  bne  t1, zero, loop                 # repeat until (and including) null char
  addi s1, s1, -1                     # remove null char from count

  li   a0, 4                          # print result
  la   a1, hello
  ecall

  la   a1, output
  ecall

  li   a0, 1
  add  a1, s1, zero
  ecall

  li   a0, 10
  ecall
