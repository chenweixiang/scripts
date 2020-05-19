################################################################################
# Git Configure
################################################################################

source ~/scripts/git-config.conf

################################################################################
# Common Settings
################################################################################

# Editor
alias e 'gedit'

# Git
alias g 'git'

# Search in C/C++ headers and source files
# Usage: ss [-i] <keyword>
alias ss   'find . -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in C/C++ headers only: *.h, *.hpp, *.hxx
# Usage: sh [-i] <keyword>
alias sh   'find . -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in C/C++ source files only: *.c, *.cc, *.cxx, *.cpp, *.c++
# Usage: sc [-i] <keyword>
alias sc   'find . -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in java source files only: *.java
# Usage: sj [-i] <keyword>
alias sj   'find . -type f -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -iname "*.java" | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in database: *.txt
# Usage: sdb [-i] <keyword>
alias sdb  'find . -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" -iname "*.txt" | xargs grep -n -s --color=auto --binary-files=without-match '

# Search in signal files: *.sig
# Usage: ssig [-i] <keyword>
alias ssig 'find . -type f -not -path "*test*" -a -not -path "*unitTest*" -a -not -path "*blockTest*" -a -not -path "*doc*" -a -not -path "*sw/bin/*" -iname "*.sig" | xargs grep -n -s --color=auto --binary-files=without-match '

# Find Duplicate Files in Current Folder
# Refer to https://blog.csdn.net/zixiaomuwu/article/details/50878383
alias fdf 'find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | cut -b 36- '

# Find specific file within current path
alias ff   'find . -type f -iname'

# Find specific directory within current path
alias fd   'find . -type d -iname'

# Alias to scripts
alias gls  '~/scripts/git-ls.sh'
alias gdt  '~/scripts/git-dt.sh'
alias gar  '~/scripts/git-archive.sh'

################################################################################
# Specific Settings
################################################################################

