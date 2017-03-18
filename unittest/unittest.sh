#!/bin/bash

# ------------------------------------------------------------- #
# unittest.sh v1.1 (c) 2017 Gaetano Causio                      #
#                                                               #
# Script to perform unittest of all sample assembly codes       #
#                                                               #
# ------------------------------------------------------------- #

echo "unittest v1.0 (c) 2017 Gaetano Causio"
echo

echo "Unit Tests" >unittest.out
   
# Start Unit Tests
# ----------------

for f in ../*.s; do 
   echo "Testing $f"
   echo "Starting test for $f" >>unittest.out
   ../asm.sh $f ABC 123 "just a test" >>unittest.out
   ../asm.sh $f >>unittest.out   
done

echo "END" >>unittest.out

md5Old=$(md5 -q unittest.base)
md5New=$(md5 -q unittest.out)

echo "Checksum original tests: $md5Old"
echo "Checksum new tests:      $md5New"

if [ "$md5Old" == "$md5New" ] ; then 
   echo "Unit Tests PASSED ✅  "
else   
   echo "Unit Tests FAILED 🔴  "
fi

