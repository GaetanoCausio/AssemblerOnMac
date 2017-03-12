# Assembler on a Mac? Yes We Can!

[![Shippable](https://img.shields.io/badge/platform-OSX-lightgrey.svg)]()
[![Shippable](https://img.shields.io/badge/language-asm-orange.svg)]()
[![Shippable](https://img.shields.io/badge/build-passing-green.svg)]()
[![Shippable](https://img.shields.io/badge/tests-passing-green.svg)]()
[![Shippable](https://img.shields.io/badge/license-apache%202.0-blue.svg)]()

A list of sample Assembly programs that demonstrate how to program using machine code instructions. Each program in this project is well self documented.

| Program  | Description |
| ------------- | ------------- |
| `hello.s`  | Have a look at this first *Hello World* assembly code |


## Prerequisites
Please note that you need to have the unix `as` (Assembler) and `ld` (Linker) utilities to use the sample programs included in this project. These utilities are automatically installed via the command line developers tools included in Xcode. The easiest way to install them is to  open terminal and run the `ld` command, if you don't have them you should get a prompt to start install.

<img src="images\InstallTools.png" alt="Install Tools"  width="463" height="195" >

## Usage

Use the included shell script utility `asm.sh` to compile, link and run assembly code. Format is:

```sh
asm filename [norun] [parameters]  

- filename   = name of your assemply code program
- norun      = use <norun> if you just need to compile & link without running it
- parameters = pass any parameters to your assembly program
```

This utility will automatically call `as` to compile an assembly source code into an object code program (.o). It will then call the linker `ld` to create an executable from the object code. For example following command will compile, link and run *hello.s* assembly code:

```sh
./asm.sh hello.s
```
<img src="images\HelloCompile.png" alt="Compile Hello Program" width="463" height="215">

This will produce `hello.o` object code and `hello` executable. This last one can also be directly started from the command line:

```sh
./hello
```
<img src="images\HelloRun.png" alt="Run Hello Program"  width="463" height="46">

## Debug assembly code

You can use `lldb` to debug an executable program. For example the following command will start a debug session:

```sh
lldb hello
```
<img src="images\HelloLldb.png" alt="Debug Hello Program"  width="763" height="359"> 

## Some handy shell commands
| | |
| ------------- | ------------- |
| `hexdump -C FileName` | Hexadecimal dump of *FileName*. Tip: pipe using `head -n10`  |
| `gcc -S prg.c -m32 -Os` | Generate assembly code from a C program |
| `lldb Program` | Debug an executable program |
 
## What's Next
Even more sample code...

<BR>    
---
*A continuos learning path where passion is the drive.*
