################################################################################
# This is configuration for csh, tcsh.                                         #
#                                                                              #
# Two ways to use this configuration:                                          #
#                                                                              #
# 1) Check original configure file ~/.cshrc:                                   #
#        cat ~/.cshrc                                                          #
#    Replace it if no useful configuration in original one:                    #
#        cp ~/scripts/conf.cshrc ~/.cshrc                                      #
#                                                                              #
# 2) Copy this configuration to home directory:                                #
#        cp ~/scripts/conf.cshrc ~/.cshrc.user                                 #
#    Source it in original configure file if not yet:                          #
#        cat ~/.cshrc | grep -n source                                         #
#        echo "source ~/.cshrc.user" >> ~/.cshrc                               #
#                                                                              #
################################################################################


################################################################################
# Common Configure
################################################################################

# ls
alias ll  "ls --color=auto -lh"
alias la  "ls --color=auto -lha"

# Disk usage
alias dusum  "du -sh"

# Editor
alias e  'gedit'

# Search in C/C++ headers and source files
# Usage: ss [-i] <keyword>
alias ss  'find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in C/C++ headers only: *.h, *.hpp, *.hxx
# Usage: sh [-i] <keyword>
alias sh  'find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in C/C++ source files only: *.c, *.cc, *.cxx, *.cpp, *.c++
# Usage: sc [-i] <keyword>
alias sc  'find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in java source files only: *.java
# Usage: sj [-i] <keyword>
alias sj  'find . -noignore_readdir_race -nowarn -type f -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -iname "*.java" | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in database: *.txt
# Usage: sdb [-i] <keyword>
alias sdb  'find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" -iname "*.txt" | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in signal files: *.sig
# Usage: ssig [-i] <keyword>
alias ssig  'find . -noignore_readdir_race -nowarn -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" -iname "*.sig" | xargs grep -n -s --color=auto --binary-files=without-match '

# Find Duplicate Files in Current Folder
# Refer to https://blog.csdn.net/zixiaomuwu/article/details/50878383
alias fdf  'find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | cut -b 36- '

# Find specific file within current path
alias ff  'find . -noignore_readdir_race -nowarn -type f -iname'

# Find specific directory within current path
alias fd  'find . -noignore_readdir_race -nowarn -type d -iname'

# Remove tail spaces, used when "git commit" failed caused by pre-commit script
# Usage: rmtailspace lib.c > lib.c.notailspace
alias rmtailspace  "sed -e \"s/[ \t]*$//g\""


################################################################################
# Git Configure
################################################################################

# Git alias
source ~/scripts/conf.git-config

# Git completion
source ~/scripts/conf.git-completion

# Alias to git scripts
alias gls  '~/scripts/git-ls.sh'
alias gdt  '~/scripts/git-dt.sh'
alias gar  '~/scripts/git-archive.sh'

# Build git from source code:
# 1) Clean git
# 2) Build git
# 3) Install built git
alias cleangit    "make distclean"
alias buildgit    "make prefix=/usr all doc info"
alias installgit  "sudo make prefix=/usr install install-doc install-html install-info"


################################################################################
# ClearCase Configure
################################################################################

alias vtree    "cleartool lsvtree -g"
alias ctco     "cleartool co -nc"
alias lsco     "cleartool lsco -a -cview -short"
alias cols     "cleartool ls -l \`cleartool lsco -a -cview -short\`"
alias ctls     "cleartool ls -l"
alias unco     "cleartool unco -keep"
alias ctdiff   "cleartool diff -g"
alias diffpre  "cleartool diff -g -pre"
alias lsall    "cleartool lspriv -other"
alias rmall    "rm -rf \`cleartool lspriv -other\`"


################################################################################
# Python Configure
################################################################################

# Use command pip3 instead of below alias p3pip
alias p3pip  "python3 -m pip"


################################################################################
# Other Configure
################################################################################

