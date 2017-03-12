# ------------------------------------------------------------- #
# registers.s v1.0 (c) 2017 Gaetano Causio                      #
#                                                               #
# Sample assembly program to show addressing of registers       #
# ------------------------------------------------------------- #

    .globl  _main               # set start point of program

# program starts here
# -------------------

_main:                             

# Assuming:
# eax = 0x00001f96
# esp = 0xbffffabc
# 0xbffffabc: b5 83 78 9f    01 00 00 00    f0 fa ff bf    f8 fa ff bf

    mov     $123, %eax          # move 123 to %eax register
# eax = 0x0000007b  (0x7B = 123)

    mov     %esp, %eax          # move content of registry %esp to %eax
# eax = 0xbffffabc

    mov     (%esp), %eax        # move value stored on memory location pointed by %esp to %eax
# eax = 0x9f7883b5

    mov     8(%esp), %eax       # move value stored on memory location pointed by (%esp + 4) to %eax
# eax = 0xbffffaf0

    mov     %eax, 4(%esp)       # move content of %eax register into memory location specified by (%esp + 4)
# 0xbffffabc: b5 83 78 9f    f0 fa ff bf    f0 fa ff bf    f8 fa ff bf

    mov     $2, %edi

    mov     8(%esp,%edi,2),%eax # move value stored in (8 + %esp + %edi * 2) into %eax register
# eax = 0xbffffaf8

    lea     8(%esp,%edi,2),%eax # load address given by (8 + %esp + %edi * 2) into %eax register
# eax = 0xbffffac8    

# exit program
# ------------

    xor     %eax, %eax          # set return code to zero
    ret                         # exit

