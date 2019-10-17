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

# Flag for options
opt_p=
opt_c=

# Show all commit files in one line by default if option '-n' is not specified
newLine="No"

#-------------------------------------------------------------------------------
# 2) Usage
#-------------------------------------------------------------------------------

function usage(){
    echo
    echo "Usage:"
    echo "${scriptName} [-h]"
    echo "${scriptName} [-p <previous-commit>] [-c <current-commit>] [-e | -n]"
    echo
    echo " -p <previous-commit>"
    echo "    Specify the previous commit that you want to check commit files of."
    echo "    If this option is not specified, use <current-commit>~ as commit ID"
    echo "    by default."
    echo
    echo " -c <current-commit>"
    echo "    Specify the current commit that you want to check commit files of."
    echo "    If this option is not specified, use HEAD as commit ID by default."
    echo
    echo " -e"
    echo "    Open the commit files by gedit. Exit if gedit is not found."
    echo
    echo " -n"
    echo "    By default, all commit files are shown in one line. One commit file"
    echo "    per line if this option is specified."
    echo
    echo " -h"
    echo "    Show the usage of this script."
    echo
}

#-------------------------------------------------------------------------------
# 3) Check script options
#-------------------------------------------------------------------------------

while getopts "p:c:enh" arg
do
    case ${arg} in
        p)  # -p <previous-commit>
            opt_p=Yes
            prevCommit=${OPTARG}
            ;;
        c)  # -c <current-commit>
            opt_c=Yes
            currCommit=${OPTARG}
            ;;
        e)  # -e
            openByGedit=Yes
            ;;
        n)  # -n
            newLine=Yes
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

#--------------------------------------
# Set default commit ID
#--------------------------------------

# If no option "-c <current-commit>", use HEAD by default
if [ x${opt_c} == x ]; then
    currCommit="HEAD"
fi

# If no option "-p <previous-commit>", the parent commit of ${currCommit} by default
if [ x${opt_p} == x ]; then
    prevCommit="${currCommit}~"
fi

#-------------------------------------------------------------------------------
# 4) Get all changed files between <prevCommit> and <currCommit>
#-------------------------------------------------------------------------------

commitFiles=`git diff-tree --no-commit-id --name-only -r ${prevCommit} ${currCommit}`

#-------------------------------------------------------------------------------
# 5) Print absolute path of each commit file
#-------------------------------------------------------------------------------

topPath=`git rev-parse --show-toplevel`

unset absoluteFiles

if [ x${openByGedit} == xYes ]; then
    geditBin=`which gedit`
    if [ x${geditBin} == x ]; then
        echo "ERROR: gedit is not found"
    else
        for file in ${commitFiles}; do
            absoluteFiles+="${topPath}/${file} "
        done
        ${geditBin} ${absoluteFiles} &
    fi
elif [ x${newLine} == xYes ]; then
    for file in ${commitFiles}; do
        echo ${topPath}/${file}
    done
else
    for file in ${commitFiles}; do
        absoluteFiles+="${topPath}/${file} "
    done
    echo ${absoluteFiles}
fi


