################################################################################
# This is configuration for bash.                                              #
#                                                                              #
# Two ways to use this configuration:                                          #
#                                                                              #
# 1) Check original configure file ~/.bashrc:                                  #
#        cat ~/.bashrc                                                         #
#    Replace it if no useful configuration in original one:                    #
#        cp ~/scripts/conf.bashrc ~/.bashrc                                    #
#                                                                              #
# 2) Copy this configuration to home directory:                                #
#        cp ~/scripts/conf.bashrc ~/.bashrc.user                               #
#    Source it in original configure file if not yet:                          #
#        cat ~/.bashrc | grep -n source                                        #
#        echo "source ~/.bashrc.user" >> ~/.bashrc                             #
#                                                                              #
################################################################################


################################################################################
# Common Configure
################################################################################

# ls
alias ll='ls --color=auto -lh'
alias la='ls --color=auto -lha'

# Disk usage
alias dusum='du -sh'

# Editor
alias e='gedit'

# Search in all files
# Usage: sa [-i] <keyword>
alias sa='find . -noignore_readdir_race -nowarn -type f | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in all files within E///
# Usage: se [-i] <keyword>
alias se='find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in C/C++ headers and source files
# Usage: ss [-i] <keyword>
alias ss='find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in C/C++ headers only: *.h, *.hpp, *.hxx
# Usage: sh [-i] <keyword>
alias sh='find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in C/C++ source files only: *.c, *.cc, *.cxx, *.cpp, *.c++
# Usage: sc [-i] <keyword>
alias sc='find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in java source files only: *.java
# Usage: sj [-i] <keyword>
alias sj='find . -noignore_readdir_race -nowarn -type f -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -iname "*.java" | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in database: *.txt
# Usage: sdb [-i] <keyword>
alias sdb='find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" -iname "*.txt" | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in signal files: *.sig
# Usage: ssig [-i] <keyword>
alias ssig='find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" -iname "*.sig" | xargs grep -n -s --color=auto --binary-files=without-match '

# Find Duplicate Files in Current Folder
# Refer to https://blog.csdn.net/zixiaomuwu/article/details/50878383
alias fdf='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I\{\} -n1 find -type f -size \{\}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | cut -b 36- '

# Find specific file within current path
alias ff='find . -noignore_readdir_race -nowarn -type f -iname'

# Find specific directory within current path
alias fd='find . -noignore_readdir_race -nowarn -type d -iname'


################################################################################
# Git Configure
################################################################################

# Git alias
source ~/scripts/conf.git-config

# Git completion
# cp ~/scripts/conf.git-completion.bash ~/.git-completion.bash
source ~/.git-completion.bash

# Build git from source code:
# 1) Clean git
# 2) Build git
# 3) Install built git
alias cleangit='make distclean'
alias buildgit='make prefix=/usr all doc info'
alias installgit='sudo make prefix=/usr install install-doc install-html install-info'


################################################################################
# ClearCase Configure
################################################################################

alias vtree='cleartool lsvtree -g'
alias ctco='cleartool co -nc'
alias lsco='cleartool lsco -a -cview -short'
alias cols='cleartool ls -l \`cleartool lsco -a -cview -short\`'
alias ctls='cleartool ls -l'
alias unco='cleartool unco -keep'
alias ctdiff='cleartool diff -g'
alias diffpre='cleartool diff -g -pre'
alias lsall='cleartool lspriv -other'
alias rmall='rm -rf \`cleartool lspriv -other\`'


################################################################################
# Python Configure
################################################################################

# Use command pip3 instead of below alias p3pip
alias p3pip='python3 -m pip'


################################################################################
# Other Configure
################################################################################

