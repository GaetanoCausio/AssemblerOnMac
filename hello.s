# ------------------------------------------------------------- #
# hello.s v1.0 (c) 2017 Gaetano Causio                          #
#                                                               #
# Sample assembly program. It display a string on console by    #
# calling the _printf subroutine.                               #
# ------------------------------------------------------------- #

    .globl  _main               # set start point of program

# program internal memory
# -----------------------

message:                                 
    .asciz "Hello, Yes We Can! 🍀 \n"

# program starts here
# -------------------

_main:                             
                             
    push    %ebp                # save base-pointer register 

# display message on console
# --------------------------

    sub     $8, %esp            # reserve bytes from the stack to call _printf

    lea     message, %eax       # get memory address of message string...
    mov     %eax, (%esp)        # ...and store it into _printf parameters stack (%esp)

    call    _printf             # display a string on console

    add     $8, %esp            # free up reserved stack memory

# exit program
# ------------

    pop     %ebp                # restore base-pointer register 

    xor     %eax, %eax          # set return code to zero
    ret                         # exit

