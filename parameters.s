# ------------------------------------------------------------- #
# parameters.s v1.0 (c) 2017 Gaetano Causio                     #
#                                                               #
# Sample assembly program. It shows usage of parameters.        #
#                                                               #
# GitHub: https://github.com/GaetanoCausio/AssemblerOnMac       #
# ------------------------------------------------------------- #

    .globl  _main                  # set start point of program

# program internal memory
# -----------------------

message:   .asciz    "argv[%d]: %s\n"
noParams:  .asciz    "no parameters.\n"

# program starts here
# -------------------

_main:

    push   %ebp                   # save base-pointer register 
    
    mov    %esp, %ebp             # %ebp now points to the stack
    add    $8, %ebp               # %ebp = start of command line parameters

    call   _displayParameters     # call function to display parameters

# exit program
# ------------

    pop     %ebp                  # restore base-pointer register 

    xor     %eax, %eax            # set return code to zero
    ret                           # exit

#------------------               ------------
_displayParameters:               # Function #
#------------------               ------------

# Display parameters from %ebp on standard out

# input:  %ebp register points to the start of command line parameters
# output: %eax contains exit code

    sub    $20, %esp              # reserve bytes from the stack to call _printf

# verify and get input data
# -------------------------

    mov    (%ebp), %edi           # %edi = total number of parameters (argc)
    mov    4(%ebp), %esi          # %esi = memory address of parameters array (argv)          
    lea    -4(%esi,%edi,4), %esi  # %esi = point to last element in argv array

    dec    %edi                   # check if any input parameters (excl. program name)
    jz     _noParameters          # if no parameters, display message and exit

    lea    message, %eax          # get memory address of message string...
    mov    %eax, (%esp)           # ...and store it into _printf parameters stack (%esp)

# loop to display each parameter on separate line
# -----------------------------------------------

_loop:

    mov    %edi, 4(%esp)          # store %edi index into _printf parameters stack (esp+4)

    mov    (%esi), %eax           # get parameter memory address of argv[index] ...
    mov    %eax, 8(%esp)          # ...and store it into _printf parameters stack (%esp+8)

    call   _printf                # print formatted string using index, argv[index]

    sub    $4,%esi                # point to next parameter in argv array                                    
    dec    %edi                   # decrement paramaters count

    jnz    _loop                  # repeat while parameters left

    jmp    _endFunction           # no more parameters, exit function

# display message no parameters present and exit
# ----------------------------------------------

_noParameters:

    lea    noParams, %eax         # get memory address of message string...
    mov    %eax, (%esp)           # ...and store it into _printf parameters stack (%esp)

    call   _printf                # print formatted string 

# exit function
# -------------

_endFunction:

    add    $20, %esp              # free up reserved stack memory
    
    xor    %eax, %eax             # set return code to zero
    ret                           # exit

