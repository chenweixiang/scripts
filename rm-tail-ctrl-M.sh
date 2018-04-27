#!/bin/bash

################################################################################
#                                                                              #
# Remove tail ^M from source file                                              #
#                                                                              #
################################################################################

#-------------------------------------------------------------------------------
# 1) Global variables
#-------------------------------------------------------------------------------

# Script name and location of this script
scriptName="rm-tail-ctrl-M.sh"

#-------------------------------------------------------------------------------
# 2) Usage
#-------------------------------------------------------------------------------

function usage(){
    echo
    echo "Usage:"
    echo "${scriptName}"
    echo "${scriptName} <files>"
    echo
    echo "${scriptName}"
    echo "    Show the usage of this script."
    echo
    echo "${scriptName} <files>"
    echo "    Specify the files you want to process. In order to reach the file,"
    echo "    absolute path or relative path should be included in <files>."
    echo
}

#-------------------------------------------------------------------------------
# 3) Check script options
#-------------------------------------------------------------------------------

if [ $# == 0 ]; then
	usage
	exit 1
fi

#-------------------------------------------------------------------------------
# 4) Remove ^M from specified files
#-------------------------------------------------------------------------------

sed -i -e 's/\^M$//g' $@

