#!/bin/bash

################################################################################
# This Bash script is used to print the files changed by commit with absolute  #
# path. The commit is specified by input parameter $1. Use HEAD as the commit  #
# if no input parameter is specified.                                          #
################################################################################

#-------------------------------------------------------------------------------
# 1) Global variables
#-------------------------------------------------------------------------------

# Script name and location of this script
scriptName="git-dt.sh"

# Default commit ID
commit="HEAD"
parentCommit="HEAD~"

#-------------------------------------------------------------------------------
# 2) Usage
#-------------------------------------------------------------------------------

function usage(){
    echo
    echo "Usage:"
    echo "  ${scriptName} [-h]"
    echo "  ${scriptName} [-c <commit>]"
    echo
    echo "  -c <commit>"
    echo "     Specify the git commit that you want to check committed changes."
    echo "     If this option is not specified, use HEAD as commit ID by default."
    echo
    echo "  -h"
    echo "     Show the usage of this script."
    echo
}

#-------------------------------------------------------------------------------
# 3) Check script options
#-------------------------------------------------------------------------------

while getopts "c:h" arg
do
    case ${arg} in
        c)  # -c <commit>
            commit=${OPTARG}
            parentCommit=${OPTARG}~
            ;;
        h)  # -h
            usage
            exit 1
            ;;
        ?)  # unkonw argument
            echo "ERROR: Unknown argument"
            exit 1
            ;;
    esac
done

#-------------------------------------------------------------------------------
# 4) Print log of specified commit
#-------------------------------------------------------------------------------

echo
echo "###### Commit message of ${commit} ######"
echo

git log --stat -1 -c --decorate --pretty=fuller ${commit}

#-------------------------------------------------------------------------------
# 5) Use git difftool to show changes of each committed file
#-------------------------------------------------------------------------------

echo
echo "###### Use 'git difftool' to show changes between commit ${parentCommit} and ${commit} ######"
echo

git difftool ${parentCommit} ${commit}

echo

