# ------------------------------------------------------------- #
# formatstring.s v1.0 (c) 2017 Gaetano Causio                   #
#                                                               #
# Sample assembly program to demostrate the display of a        #
# formatted string to standard out                              #
#                                                               #
# GitHub: https://github.com/GaetanoCausio/AssemblerOnMac       #
# ------------------------------------------------------------- #

    .globl  _main                  # set start point of program

# program internal memory
# -----------------------

message:   .asciz    "This is a %s String with a number: %d  \n"

param1:    .asciz    "formatted"
param2:    .long     0x23       # 35

# program starts here
# -------------------

_main:

    push   %ebp                 # save base-pointer register 
    
# display formatted string on console
# -----------------------------------
    
    sub    $24, %esp            # reserve bytes from the stack to call _printf

    lea    message, %eax        # get memory address of message string...
    mov    %eax, (%esp)         # ...and store it into _printf parameters stack at (%esp)
    
    lea     param1, %eax        # get memory address of string parameter...
    mov     %eax, 4(%esp)       # ...and store it into _printf parameters stack at (%esp+4)

    mov     (param2), %eax      # get memory address of numeric parameter...
    mov     %eax, 8(%esp)       # ...and store it into _printf parameters stack at (%esp+8)

    call   _printf              # print a formatted string using param1 & param2

    add    $24, %esp            # free up reserved stack memory

# exit program
# ------------
    
    pop     %ebp                # restore base-pointer register 

    xor     %eax, %eax          # set return code to zero
    ret                         # exit

