#!/bin/bash

#-------------------------------------------------------------------------------
# This Bash script is used to print the files changed by commit with absolute
# path. The commit is specified by input parameter $1. Use HEAD as the commit
# if no input parameter $1 is specified.
#
# Usage: git-ls-commit-file.sh [commit-id]
#-------------------------------------------------------------------------------

#
# 1) Get the commit and its parent
#

if [ "$1" == "" ]; then
    cmt="HEAD"
    parent_cmt="HEAD~"
else
    cmt=$1
    parent_cmt=${cmt}~
fi

#
# 2) Get all changed files in <commit-id>~ and <commit-id>
#

files=`git diff-tree --no-commit-id --name-only -r ${parent_cmt} ${cmt}`

#
# 3) Print the absolute path of each file
#

toppath=`git rev-parse --show-toplevel`

unset absolute_files

for f in $files
do
    absolute_files+="$toppath/$f "
done

echo $absolute_files


