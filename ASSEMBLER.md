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

Registers have a special meaning and usage in Assembly langauage, it is therefore a good habit to save their content (via a push) before you change them, and then restore them back (via a pop) when done.

```asm
eax: Accumulator
ebx: Base index (i.e. arrays)
ecx: Counter (i.e. loops)
edx: Extend the precision of the accumulator
esi: Source index
edi: Destination index
esp: Stack pointer 
ebp: Stack base pointer 
eip: Instruction pointer 
cs:  Code segment
ds:  Data segment
ss:  Stack segment
es:  Extra data segment
fs:  Extra data #2 segment
gs:  Extra data #3 segment
eFlags: Boolean values to store the results of operations
```


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

Also note that instructions may be suffixed based on your target architecture:

`movq` for 64bit architecture     
`movl` or `mov` for 32bit architecture     
`movw` for 16bit architecture     

## Stack Layout

It is very important to understand how the stack memory works to be able to properly code in assembly.
The stack is used when parameters are passed to your program or when you call a subroutine. By using `push` you can add data to the stack, while using `pop` gets data from the stack. You can also directly access the stack as the `%esp` register is actually a pointer to the stack itself. Once a program is started or control is given to a subroutine `%esp` always point to the return address. When parameters are used the stack will point to the total number of arguments and to the location in memory where these arguments are stored to. Therefore a standard stack layout is as follow:

```asm
(%esp)    -> return address
4(%esp)   -> number of parameters being passed (argc) 
8(%esp)   -> memory location where parameters are stored to (argv)
```
Please note that `4(%esp)` **argc** also includes the program name as first parameter. And also note that `8(%esp)` **argv** actually points to a memory location containing two address: first one to the name of the program, the second one to the actual parameters:

```asm
(argv)    ->  memory location where program name is stored
4(argv)   ->  memory location where actual parameters are stored
```

This should become clear with an example. Debug the `hello` executable and pass some parameters to it:

<img src="images\StackMemory.png" alt="Stack Memory"  width="933" height="537">

The layout of the stack may vary based on the specification of the function being called. For example for `_printf` uses the following structure:

```asm
(%esp)    -> address of the string to be displayed
4(%esp)   -> first argument passed to a formatted string 
8(%esp)   -> second argument passed to a formatted string ... and so on ...
```
See sample assembly code in  `formatstring.s`.

### Important Note

On Mac OS X the stack pointer needs to be always aligned to a 16-byte boundary prior to a function call.
i.e. `%esp` should always be 0xnnnnnnn0 at the point of function call.  Take this into consideration when reserving area from the stack. See examples below:

```asm
_main:           -> at program start esp = 16-byte boundary - 4 (return address)                            
   push %ebp     -> a resister is pushed into the stack, esp = esp - 4 (pushed address)  
   sub  $8,%esp  -> to align esp to 16-bytes we need to subtract 8 bytes more (i.e. hello.s)
   sub  $24,%esp -> or subtract 24 bytes if more stack area is needed (i.e. formatstring.s)
```
## Internal Variables

In assembly you can generate data of various format using the following directives:

```asm
.ascii   -> a sequence of ASCII characters
.asciz   -> fsame as .ascii but the string is terminated with a null character \0
.byte    -> generate a 1 byte expression
.short   -> generate a 2 bytes expression
.long    -> generate a 3 bytes expression
.quad    -> generate a 4 bytes expression
.single  -> generate  a single-precision floating point number (4 bytes)
.double  -> generate double-precision floating point number (8 bytes)
.align 3,0 -> align at 2^3 (8) byte alignment, zeroes fill
```

See some examples in sample code `formatstring.s`

## Usefull Links

[Mac OS X Assembler Reference](https://developer.apple.com/library/mac/documentation/DeveloperTools/Reference/Assembler/)     
[lldb Quick Reference Guide](https://developer.apple.com/library/mac/documentation/IDEs/Conceptual/gdb_to_lldb_transition_guide/document/lldb-command-examples.html)     
