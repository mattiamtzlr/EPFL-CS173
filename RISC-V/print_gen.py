from sys import argv

match argv:
    case [_, *args] if len(args) != 0:
        for arg in args:
            try:
                a = int(arg)
                print(f"li   a0, 1")
                print(f"li   a1, {a}")
            except:
                if len(arg) == 3 and arg[0] == ".": 
                    print(f"li   a0, 1")
                    print(f"add  a1, {arg[1:3]}, zero")

                else:
                    print(f"text: .string \"{arg}\"")
                    print()
                    print("li   a0, 4")
                    print("la   a1, text")

            print("ecall")

    case _:
        print("Usage: pass the following as argument:")
        print(" - an integer: generate ecall to print an integer.")
        print(" - a register: generate ecall to print the value in a register.")
        print("               specify the register by using a period in front of the reg name, e.g. '.t5'")
        print(" - a string:   generate ecall to print a string, as well as that string's data entry.")
        exit(1)

print("li   a0, 10")
print("ecall")
