# Assembler on a Mac? Yes We Can!

[![Shippable](https://img.shields.io/badge/platform-OSX-lightgrey.svg)]()
[![Shippable](https://img.shields.io/badge/language-asm-orange.svg)]()
[![Shippable](https://img.shields.io/badge/build-passing-green.svg)]()
[![Shippable](https://img.shields.io/badge/tests-passing-green.svg)]()
[![Shippable](https://img.shields.io/badge/license-apache%202.0-blue.svg)]()

A list of sample Assembly programs that demonstrate how to program directly using machine code instructions.

## Prerequisites
Please note that you need to have the unix `as` (Assembler) and `ld` (Linker) utilities to use the sample programs included in this project. These utilities are automatically installed via the command line developers tools included in Xcode. The easiest way to install them is to  open terminal and run the `ld` command, if you don't have them you should get a prompt to start the download and installation.

<img src="images\InstallTools.png" alt="Install Tools">

## Usage

Use the included shell script utility asm.sh to compile, link and run assembly code. Format is:

     asm filename [norun] [parameters]
    
     - filename   = name of your assemply code program
     - noun      = use <norun> if you just need to compile & link without running it
     - parameters = pass any parameters to your assembly program


## What's Next
Implementation of a better design architecture: Model-View-ViewModel (MVVM) in combination of Protocol Oriented Programming (POP) .

<BR>    
---
*A continuos learning path where passion is the drive.*
