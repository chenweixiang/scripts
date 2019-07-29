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
commit="HEAD"
parentCommit="HEAD~"

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
            commit=${OPTARG}
            parentCommit=${OPTARG}~
            ;;
        n)  # -n
            newLine="Yes"
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
# 4) Get all changed files between <commit>~ and <commit>
#-------------------------------------------------------------------------------

commitFiles=`git diff-tree --no-commit-id --name-only -r ${parentCommit} ${commit}`

#-------------------------------------------------------------------------------
# 5) Print absolute path of each commit file
#-------------------------------------------------------------------------------

topPath=`git rev-parse --show-toplevel`

unset absoluteFiles

if [ ${newLine} == "Yes" ]; then
    for file in ${commitFiles}; do
        echo ${topPath}/${file}
    done
else
    for file in ${commitFiles}; do
        absoluteFiles+="${topPath}/${file} "
    done
    echo ${absoluteFiles}
fi


