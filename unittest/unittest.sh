#!/bin/bash
shopt -s expand_aliases

# ------------------------------------------------------------- #
# unittest.sh v1.1 (c) 2017 Gaetano Causio                      #
#                                                               #
# Script to perform unittest of all sample assembly codes       #
#                                                               #
# ------------------------------------------------------------- #

echo "unittest v1.0 (c) 2017 Gaetano Causio"
echo

# filter out all escape sequences and convert output to plain ASCII
# alias FilterOut="sed 's/[\x01-\x1F\x7F]//g' | iconv -c -t ascii"
alias FilterOut="cat -v | iconv -c -t ascii"
# alias FilterOut="cat -v"

echo "Unit Tests" | FilterOut >unittest.out
   
# process all assembly (*.s) files found
# --------------------------------------

for f in ../*.s; do 
   # perform unit test of program with and without parameters
   echo "Testing $f"
   echo "Starting test for $f" | FilterOut >>unittest.out
   ../asm.sh $f ABC 123 "just a test" | FilterOut >>unittest.out
   ../asm.sh $f | FilterOut >>unittest.out   
done

echo "END"  | FilterOut >>unittest.out

# compute MD5 hash codes and compare them
# ---------------------------------------

md5Old=$(md5 -q unittest.base)
md5New=$(md5 -q unittest.out)

echo "Checksum original tests: $md5Old"
echo "Checksum new tests:      $md5New"

if [ "$md5Old" == "$md5New" ] ; then 
   echo "Unit Tests PASSED ✅  "
else   
   echo "Unit Tests FAILED 🔴  "
fi

