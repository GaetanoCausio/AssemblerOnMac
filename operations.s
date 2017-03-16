# ------------------------------------------------------------- #
# operationss.s v1.0 (c) 2017 Gaetano Causio                    #
#                                                               #
# Sample assembly program to show use of common instructions    #
#                                                               #
# GitHub: https://github.com/GaetanoCausio/AssemblerOnMac       #
# ------------------------------------------------------------- #

    .globl  _main               # set start point of program

# program starts here
# -------------------

_main:                             

    mov     $2, %esi            # move 2 to %esi register
    mov     $2, %edi            # move 2 to %edi register
    dec     %edi                # decrement %edi register %edi by 1
    cmp     %edi, %esi          # comapare registers
    je      _end                # %edi = 1, %esi = 2, they are not equal, therefore it should not jump
    dec     %edi                # decrement %edi register %edi by 1
    jz      _cont               # %edi is now 0, therefore it should jump to address _cont
    jmp     _end                # this should never be exxecuted in our test
    
_cont:
    xchg    %eax, %esi          # swap content of registers

# exit program
# ------------

_end:
    xor     %eax, %eax          # set return code to zero
    ret                         # exit

