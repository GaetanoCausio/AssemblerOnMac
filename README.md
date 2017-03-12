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

<img src="images\InstallTools.png" alt="Install Tools">

## Usage

Use the included shell script utility `asm.sh` to compile, link and run assembly code. Format is:

```
asm filename [norun] [parameters]  

- filename   = name of your assemply code program
- noun      = use <norun> if you just need to compile & link without running it
- parameters = pass any parameters to your assembly program
```

## What's Next
Even more sample code...

<BR>    
---
*A continuos learning path where passion is the drive.*
