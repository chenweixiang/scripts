#!/bin/bash

################################################################################
#
# Replace TAB with four spaces & Remove tail spaces from source file
#
# Usage: replace-tab-rm-tail-spaces.sh <file1> <file2> ...
#
################################################################################

sed -i 's/\t/    /g;s/[[:blank:]]*$//g' $@

