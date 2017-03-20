#!/bin/bash

# ------------------------------------------------------------- #
# asm.sh v1.1 (c) 2017 Gaetano Causio                           #
#                                                               #
# Script to compile, link and run an assembly program           #
#                                                               #
# please note that you may need to change option of 'ld'        #
# from -macosx_version_min 10.12 to your current OSX version    # 
# ------------------------------------------------------------- #

# set your Mac OSX version:
MacOSX="10.12"

# get command line parameters
prmProgramName="$1"
prmNorun="$2"
prmCount=$#

# set handy variables
bold="\033[1m"
normal="\033[0m"
underline="\033[4m" 
baseName="${prmProgramName%.*}"

echo "asm v1.1 (c) 2017 Gaetano Causio"
echo

# Check command line parameters
# -----------------------------

if [ $prmCount == 0 ] ; then # no input parameters
   echo "Wrong number of parameters. Usage is:"
   echo
   echo -e "   asm ${underline}filename${normal} [norun] [parameters]"
   echo
   echo "   - filename   = name of your assemply code program"
   echo "   - norun      = use <norun> if you just need to compile & link without running it"
   echo "   - parameters = pass any parameters to your assembly program"   
   echo
   exit 0
fi

if [ ! -r "$prmProgramName" ]; then # assembly program not readable
   echo -e "Unable to access file: ${bold}$prmProgramName${normal}"
   echo
   echo "Please specify a valid file name"
   echo
   exit 0
fi

# Compile and Link
# ----------------

echo -e "Compile, link and run for assemply code: ${bold}$prmProgramName${normal}"
echo

echo -n "Compiling... "
as $prmProgramName -o $baseName.o -arch i386
if [ $? == 0 ] ; then # if exit code is zero
   echo "Ok"
else
   echo
   exit 1   
fi   

echo -n "Linking... "
ld $baseName.o -e _main -lc -macosx_version_min $MacOSX -o $baseName -arch i386 -no_pie
if [ $? == 0 ] ; then # if exit code is zero
   echo "Ok"
else
   echo
   exit 1   
fi   

# Execute Assembly program
# ------------------------

if [ "$prmNorun" != "norun" ] ; then
   if [ $prmCount != 1 ] ; then # parameters for assembly program are prensent
      echo "Running with parameters: $2 $3 $4 $5 $6 $7 $8 $9"
   else
      echo "Running:"
   fi
   echo
   ./$baseName $2 $3 $4 $5 $6 $7 $8 $9
fi

echo
echo "Completed. 👍 "

