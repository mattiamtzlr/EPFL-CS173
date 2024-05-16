.data
    hello: .string "Hello, World!\n"

.text
    li a0, 4        # print_string env call ID
    la a1, hello    # load hello into argument reg
    ecall           # env call

    li a0, 10       # exit env call ID
    ecall           # env call
