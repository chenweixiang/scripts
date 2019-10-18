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

# Flags to specify options
opt_p=
opt_c=

# Default file
file=

#-------------------------------------------------------------------------------
# 2) Usage
#-------------------------------------------------------------------------------

function usage(){
    echo
    echo "Usage:"
    echo "  ${scriptName} [-h]"
    echo "  ${scriptName} [-p <previous-commit>] [-c <current-commit>] [-f <file>]"
    echo
    echo "  -p <previous-commit>"
    echo "     Specify the previous commit that you want to check the changes from."
    echo "     If this option is not specified, use <current-commit>~ as commit ID"
    echo "     by default."
    echo
    echo "  -c <current-commit>"
    echo "     Specify the current commit that you want to check the changes to."
    echo "     If this option is not specified, use HEAD as commit ID by default."
    echo
    echo "  -f <file>"
    echo "     Specify the file that you want to check changes between specified"
    echo "     commits. If this option is not specified, show all changed files"
    echo "     between specified commits by default. The format of <file> can be:"
    echo "       a) file name, such as: git-dt.sh"
    echo "       b) a part of file name, such as: git-dt"
    echo "       c) a part of file name with absolute path, such as: scripts/git-dt"
    echo
    echo "  -h"
    echo "     Show the usage of this script."
    echo
}

#-------------------------------------------------------------------------------
# 3) Check script options
#-------------------------------------------------------------------------------

while getopts "c:p:f:h" arg
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
        f)  # -f <file>
            file=${OPTARG}
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
# 4) Print log of specified commits
#-------------------------------------------------------------------------------

echo
echo "###### 1) Short commit history from commit ${prevCommit} to ${currCommit} ######"
echo

git log --date=short --pretty=format:'%Cgreen%h %Cred%ad %Cblue%cn %Cred%d %Creset%s' --graph --topo-order --decorate ${prevCommit}~..${currCommit}

echo
echo "###### 2) Detail commit history from commit ${prevCommit} to ${currCommit} ######"
echo

git log --stat -c --decorate --pretty=fuller ${prevCommit}~..${currCommit}

#-------------------------------------------------------------------------------
# 5) Get matched files with absolute path
#-------------------------------------------------------------------------------

matchedFiles=
notFoundFile=

if [ x${file} != x ]; then
    commitFiles=`git diff-tree --no-commit-id --name-only -r ${prevCommit} ${currCommit}`
    topPath=`git rev-parse --show-toplevel`

    for f in ${commitFiles}; do
        case ${topPath}/${f} in
            *${file}*) matchedFiles+="${topPath}/${f} ";;
        esac
    done

    if [ x${matchedFiles} == x ]; then
        notFoundFile=Yes
    fi
fi

#-------------------------------------------------------------------------------
# 6) Use git difftool to show changes
#-------------------------------------------------------------------------------

if [ x"${matchedFiles}" == x ]; then
    echo
    echo "###### 3) Use 'git difftool' to show all changes between commit ${prevCommit} and ${currCommit} ######"

    if [ x${notFoundFile} != x ]; then
        echo "          NOTE: Not found file ${file}"
    fi

    echo
    echo "git difftool ${prevCommit} ${currCommit}"
    git difftool ${prevCommit} ${currCommit}
    echo
else
    echo
    echo "###### 3) Use 'git difftool' to show changes in following file(s) between commit ${prevCommit} and ${currCommit} ######"
    echo "          ${matchedFiles}"
    echo
    echo "git difftool ${prevCommit} ${currCommit} -- ${matchedFiles}"
    git difftool ${prevCommit} ${currCommit} -- ${matchedFiles}
    echo
fi

