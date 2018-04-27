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
scriptName="git-ls.sh"

# Default commit ID
cmt="HEAD"
parent_cmt="HEAD~"

# Show all commit files in one line by default if option '-n' is not specified
newLine="No"

#-------------------------------------------------------------------------------
# 2) Usage
#-------------------------------------------------------------------------------

function usage(){
    echo
    echo "Usage:"
    echo "${scriptName} [-h]"
    echo "${scriptName} [-c <commit>] [-n]"
    echo
    echo "-c <commit>"
    echo "    Specify the git commit that you want to check commit files of it."
    echo "    If this option is not specified, use HEAD as commit ID by default."
    echo
    echo "-n"
    echo "    By default, all commit files are shown in one line. One commit file"
    echo "    per line if this option is specified."
    echo
    echo "-h"
    echo "    Show the usage of this script."
    echo
}

#-------------------------------------------------------------------------------
# 3) Check script options
#-------------------------------------------------------------------------------

while getopts "c:nh" arg
do
    case ${arg} in
        c)  # -c <commit>
            cmt=${OPTARG}
            parent_cmt=${OPTARG}~
            ;;
        n)  # -n
            newLine="Yes"
            ;;
        h)  # -h
            usage
            exit 1
            ;;
        ?)  # unkonw argument
            echo "ERROR: Unkonw argument"
            exit 1
            ;;
    esac
done

#-------------------------------------------------------------------------------
# 4) Get all changed files in <commit>~ and <commit>
#-------------------------------------------------------------------------------

files=`git diff-tree --no-commit-id --name-only -r ${parent_cmt} ${cmt}`

#-------------------------------------------------------------------------------
# 5) Print the absolute path of each file
#-------------------------------------------------------------------------------

topPath=`git rev-parse --show-toplevel`

unset absoluteFiles

if [ ${newLine} == "Yes" ]; then
    for f in $files; do
        echo ${f}
    done
else
    for f in $files; do
        absoluteFiles+="${topPath}/${f} "
    done
    echo ${absoluteFiles}
fi


