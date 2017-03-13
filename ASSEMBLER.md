# Assembler

Here you'll find some basic notions about how to program in assembly. This is definitely not an exhaustive explanation but should give you a good starting point on how to code in assembly.
 
## Compile and linking an assembly code

Compile `hello.s` into `hello.o` object code:

```sh
as hello.s -o hello.o -arch i386`
```

Link `hello.o` with system libraries and build `hello` executable:

```sh
ld hello.o -e _main -lc -macosx_version_min 10.12 -o hello -arch i386 -no_pie
```

Finally run the executable by typing:

```sh
./hello
```

## The Assembly Language

You can find the complete reference to the Mac OS X Assembler [here](https://developer.apple.com/library/mac/documentation/DeveloperTools/Reference/Assembler/). 

I will just highlight some of the most important aspect of coding in Assembly. 
First of all Assembly makes extensive use of **registers** like `%esp`, `%eax` and so on. These contains either direct values or addresses to memory locations containing values.

**Addressing Registers**

```asm
%esp             # refers to value of %esp register
(%esp)           # refers to value stored on memory location pointed by %esp register
8(%esp)          # refers to value stored on memory location pointed by (%esp + 4)
8(%esp,%edi,2)   # refers to value stored add memory location (8 + %esp + %edi * 2)
```
You can best debug assembly program `registers.s` to see more details on how it works.

Please note that registers are named based on the target architecture of your compiled assembly code:

`RAX RCX RDX RBX RSP RBP RSI RDI` for 64bit architecture     
`EAX ECX EDX EBX ESP EBP ESI EDI` for 32bit architecture     
`AX  CX  DX  BX  SP  BP  SI  DI` for 16bit architecture     



**Basic Instructions**

```asm
mov   %esp, %eax       # move value of registry %esp to %eax
mov   4(%esp), %eax    # move value stored at memory address (%esp + 4) to %eax
lea   4(%esp), %eax    # load address given by %esp + 4 to %eax
sub   $8, %esp         # rsubtract 8 from value of register %esp
dec   %edi             # decrement value of register %edi by 1
push  %ebp             # push content of %ebp register into stack
pop   %ebp             # pop content of %ebp register from stack
call  _initParams      # call a subroutine at address of _initParams
ret                    # return back to caller
xchg %eax, %esi        # swap content of registers
cmp  %edi,%eax         # compare contents of registers
jz   _noParams         # jump to address of _noParams when result previous operation is zero
jge  _noParams         # jump to address of _noParams when greater of equal
jmp  _endProg          # unconditional jump to address of _endProg
```

You can best debug assembly program `operations.s` to see more details on how it works.

Please note that instructions may be suffixed based on your target architecture:

`movq` for 64bit architecture     
`movl` or `mov` for 32bit architecture     
`movw` for 16bit architecture     

## Stack Layout

It is very important to understand how the stack memory works to be able to properly code in assembly.
The stack is used when parameters are passed to your program or when you call a subroutine. By using `push` you can add data to the stack, while using `pop` gets data from the stack. You can also directly access the stack as the `%esp` register is actually a pointer to the stack itself. Once a program is started or control is given to a subroutine `%esp` always point to the return address. When parameters are used the stack will point to the total number of arguments and to the location in memory where these arguments are stored to. Therefore a standard stack layout is as follow:

```
(%esp)    -> return address
4(%esp)   -> number of parameters being passed (argc) 
8(%esp)   -> memory location where parameters are stored to (argv)
```
Please note that `4(%esp)` **argc** also includes the program name as first parameter. And also note that `8(%esp)` **argv** actually points to a memory location containing two address: first one to the name of the program, the second one to the actual parameters:

```
(argv)    ->  memory location where program name is stored
4(argv)   ->  memory location where actual parameters are stored
```

This should become clear with an example. Debug the `hello` executable and pass some parameters to it:

<img src="images\StackMemory.png" alt="Stack Memory"  width="933" height="537">


## Usefull Links

[Mac OS X Assembler Reference](https://developer.apple.com/library/mac/documentation/DeveloperTools/Reference/Assembler/)     
[lldb Quick Reference Guide](https://developer.apple.com/library/mac/documentation/IDEs/Conceptual/gdb_to_lldb_transition_guide/document/lldb-command-examples.html)     
