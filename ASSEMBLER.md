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
    %esp           # refers to value of %esp register
    (%esp)         # refers to value stored on memory location pointed by %esp register
    8(%esp)        # refers to value stored on memory location pointed by (%esp + 4)
    8(%esp,%edi,2) # refers to value stored add memory location (8 + %esp + %edi * 2)
```
You can best debug assembly program `registers.s` to see more details on how it works.

**Basic Instructions**

```asm
    mov  4(%esp), %eax     # move value stored at memory address (%esp + 4) to %eax
    lea  4(%esp), %eax     # load address given by (%esp + 4) to %eax
```

