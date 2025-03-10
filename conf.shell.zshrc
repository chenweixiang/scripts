################################################################################
# This is configuration for zsh on Mac OS.                                     #
#                                                                              #
# Two ways to use this configuration:                                          #
#                                                                              #
# 1) Check original configure file ~/.zshrc:                                   #
#        cat ~/.zshrc                                                          #
#    Replace it if no useful configuration in original one:                    #
#        cp ~/scripts/conf.shell.zshrc ~/.zshrc                                #
#                                                                              #
# 2) Copy this configuration to home directory:                                #
#        cp ~/scripts/conf.shell.zshrc ~/.zshrc.user                           #
#    Source it in original configure file if not yet:                          #
#        cat ~/.zshrc | grep -n source                                         #
#        echo "source ~/.zshrc.user" >> ~/.zshrc                               #
#                                                                              #
################################################################################


################################################################################
# Common Configure
################################################################################

# command line prompt
export PS1='%n@%m [%D{%Y-%m-%d %H:%M:%S}] %d %# '

# ls
alias ll='ls --color -D "%Y-%m-%d %H:%M:%S" -lh'
alias lla='ls --color -D "%Y-%m-%d %H:%M:%S" -lha'
alias llt='ls --color -D "%Y-%m-%d %H:%M:%S" -lh -rt'
alias llat='ls --color -D "%Y-%m-%d %H:%M:%S" -lha -rt'

# rm
alias rmf='rm -f'
alias rmr='rm -r'
alias rmrf='rm -rf'

# cp
alias cpf='cp -f'
alias cprf='cp -rf'

# Time
alias t='date "+%Y-%m-%d %H:%M:%S"'

# Disk usage
alias dusum='du -sh'

# Reader: less
alias l='less -N'

# Editor: vim
alias v='vim'

# Editor: code from VSCode
alias c='code'

# Editor: sublime text, atom on Max OS
alias e='~/sublime_text/sublime_text'

# Search in all files
# Usage: sa   <keyword>
#        sai  <keyword>
#        sae  "<regexp>"
#        saie "<regexp>"
alias sa='find . -noignore_readdir_race -type f | xargs grep -n -s --color=auto --binary-files=without-match '
alias sai='find . -noignore_readdir_race -type f | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias sae='find . -noignore_readdir_race -type f | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias saie='find . -noignore_readdir_race -type f | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in all files
# Usage: sa0   <keyword>
#        sai0  <keyword>
#        sae0  "<regexp>"
#        saie0 "<regexp>"
alias sa0='find . -noignore_readdir_race -type f -print0 | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias sai0='find . -noignore_readdir_race -type f -print0 | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias sae0='find . -noignore_readdir_race -type f -print0 | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias saie0='find . -noignore_readdir_race -type f -print0 | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in all files within E///
# Usage: se   <keyword>
#        sei  <keyword>
#        see  "<regexp>"
#        seie "<regexp>"
alias se='find . -noignore_readdir_race -type f -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs grep -n -s --color=auto --binary-files=without-match '
alias sei='find . -noignore_readdir_race -type f -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias see='find . -noignore_readdir_race -type f -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias seie='find . -noignore_readdir_race -type f -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in all files within E///
# Usage: se0   <keyword>
#        sei0  <keyword>
#        see0  "<regexp>"
#        seie0 "<regexp>"
alias se0='find . -noignore_readdir_race -type f -print0 -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias sei0='find . -noignore_readdir_race -type f -print0 -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias see0='find . -noignore_readdir_race -type f -print0 -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias seie0='find . -noignore_readdir_race -type f -print0 -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in C/C++ headers and source files
# Usage: ss   <keyword>
#        ssi  <keyword>
#        sse  "<regexp>"
#        ssie "<regexp>"
alias ss='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '
alias ssi='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias sse='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias ssie='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in C/C++ headers and source files
# Usage: ss0   <keyword>
#        ssi0  <keyword>
#        sse0  "<regexp>"
#        ssie0 "<regexp>"
alias ss0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias ssi0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias sse0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias ssie0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" -or -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in C/C++ headers only: *.h, *.hpp, *.hxx
# Usage: sh   <keyword>
#        shi  <keyword>
#        she  "<regexp>"
#        shie "<regexp>"
alias sh='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs grep -n -s --color=auto --binary-files=without-match '
alias shi='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias she='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias shie='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in C/C++ headers only: *.h, *.hpp, *.hxx
# Usage: sh0   <keyword>
#        shi0  <keyword>
#        she0  "<regexp>"
#        shie0 "<regexp>"
alias sh0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias shi0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias she0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias shie0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.h" -or -iname "*.hpp" -or -iname "*.hxx" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in C/C++ source files only: *.c, *.cc, *.cxx, *.cpp, *.c++
# Usage: sc   <keyword>
#        sci  <keyword>
#        sce  "<regexp>"
#        scie "<regexp>"
alias sc='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match '
alias sci='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias sce='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias scie='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in C/C++ source files only: *.c, *.cc, *.cxx, *.cpp, *.c++
# Usage: sc0   <keyword>
#        sci0  <keyword>
#        sce0  "<regexp>"
#        scie0 "<regexp>"
alias sc0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias sci0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias sce0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias scie0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) \( -iname "*.c" -or -iname "*.cc" -or -iname "*.cxx" -or -iname "*.cpp" -or -iname "*.c++" \) | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in java source files only: *.java
# Usage: sj   <keyword>
#        sji  <keyword>
#        sje  "<regexp>"
#        sjie "<regexp>"
alias sj='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs grep -n -s --color=auto --binary-files=without-match '
alias sji='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias sje='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias sjie='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in java source files only: *.java
# Usage: sj0   <keyword>
#        sji0  <keyword>
#        sje0  "<regexp>"
#        sjie0 "<regexp>"
alias sj0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias sji0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias sje0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias sjie0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.java" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in XML files only: *.xml
# Usage: sx   <keyword>
#        sxi  <keyword>
#        sxe  "<regexp>"
#        sxie "<regexp>"
alias sx='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs grep -n -s --color=auto --binary-files=without-match '
alias sxi='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias sxe='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias sxie='find . -noignore_readdir_race -type f \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in XML files only: *.xml
# Usage: sx0   <keyword>
#        sxi0  <keyword>
#        sxe0  "<regexp>"
#        sxie0 "<regexp>"
alias sx0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias sxi0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias sxe0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias sxie0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" \) -iname "*.xml" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in database: *.txt
# Usage: sdb   <keyword>
#        sdbi  <keyword>
#        sdbe  "<regexp>"
#        sdbie "<regexp>"
alias sdb='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs grep -n -s --color=auto --binary-files=without-match '
alias sdbi='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias sdbe='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias sdbie='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in database: *.txt
# Usage: sdb0   <keyword>
#        sdbi0  <keyword>
#        sdbe0  "<regexp>"
#        sdbie0 "<regexp>"
alias sdb0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias sdbi0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias sdbe0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias sdbie0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.txt" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in signal files: *.sig
# Usage: ssig   <keyword>
#        ssigi  <keyword>
#        ssige  "<regexp>"
#        ssigie "<regexp>"
alias ssig='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs grep -n -s --color=auto --binary-files=without-match '
alias ssigi='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs grep -n -s --color=auto --binary-files=without-match -i '
alias ssige='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs grep -n -s --color=auto --binary-files=without-match -E '
alias ssigie='find . -noignore_readdir_race -type f \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs grep -n -s --color=auto --binary-files=without-match -i -E '

# Search in signal files: *.sig
# Usage: ssig0   <keyword>
#        ssigi0  <keyword>
#        ssige0  "<regexp>"
#        ssigie0 "<regexp>"
alias ssig0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs -0 grep -n -s --color=auto --binary-files=without-match '
alias ssigi0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i '
alias ssige0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs -0 grep -n -s --color=auto --binary-files=without-match -E '
alias ssigie0='find . -noignore_readdir_race -type f -print0 \( -not -path "*/test/*" -a -not -path "*/unitTest/*" -a -not -path "*/blockTest/*" -a -not -path "*/doc/*" -a -not -path "*/sw/bin/*" \) -iname "*.sig" | xargs -0 grep -n -s --color=auto --binary-files=without-match -i -E '

# Find Duplicate Files in Current Folder
# Refer to https://blog.csdn.net/zixiaomuwu/article/details/50878383
#alias fdf='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I\{\} -n1 find -type f -size \{\}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | cut -b 36- '

# Find specific file within current path
alias ff='find . -noignore_readdir_race -type f -iname'
alias sff='~/scripts/find_files.py -t f -s'

# Find specific directory within current path
alias fd='find . -noignore_readdir_race -type d -iname'
alias sfd='~/scripts/find_files.py -t d -s'


################################################################################
# Git Configure
################################################################################

# Git alias
# No need to source it in shell configuration file.
# Source it directly when conf.git-config changed.
# source ~/scripts/conf.git-config

alias g='git'
alias gv='git --version'
alias gh='git h'
alias gconf='git conf'
alias gbr='git br'
alias gbrr='git brr'
alias gbra='git bra'
alias gbrm='git brm'
alias gbrd='git brd'
alias gsw='git sw'
alias gswc='git swc'
alias gswm='git swm'
alias gswd='git swd'
alias gres='git res'
alias gco='git co'
alias gcob='git cob'
alias gcom='git com'
alias ga='git add'
alias gaa='git add --all'
alias gci='git ci'
alias gcia='git cia'
alias grst='git rst'
alias grsth='git rsth'
alias grsth1='git rsth1'
alias grsth2='git rsth2'
alias grsth3='git rsth3'
alias grsth4='git rsth4'
alias grsth5='git rsth5'
alias gcp='git cp'
alias gcpa='git cpa'
alias gcpc='git cpc'
alias grb='git rb'
alias grbm='git rbm'
alias grbi='git rbi'
alias grba='git rba'
alias grbc='git rbc'
alias grvt='git rvt'
alias gblm='git blm'
alias gst='git st'
alias gmt='git mt'
alias gdesc='git desc'
alias grlog='git rlog'
alias glhg='git lhg'
alias glh='git lh'
alias glhd='git lhd'
alias glc='git lc'
alias glch='git lch'
alias glch1='git lch1'
alias glch2='git lch2'
alias glcp='git lcp'
alias glf='git lf'
alias gsls='git sls'
alias gslse='git slse'
alias gslsec='git slsec'
alias gcf='git cf'
alias gsar='git sar'
alias gd='git d'
alias gdh='git dh'
alias gdh1='git dh1'
alias gdh2='git dh2'
alias gdt='git dt'
alias gdth='git dth'
alias gdth1='git dth1'
alias gdth2='git dth2'
alias gsdt='git sdt'
alias gsdtc='git sdtc'
alias gdtc='git dtc'
alias gdtcs='git dtcs'
alias gdtcsf='git dtcsf'
alias glts='git lts'
alias glt='git lt'
alias gllt='git llt'
alias glbt='git lbt'
alias glmb='git lmb'
alias ggl='git gl'
alias gg='git g'
alias ggi='git gi'
alias gcnt='git cnt'
alias gcln='git cln'
alias gopr='git opr'
alias glr='git lr'
alias grem='git rem'
alias gremv='git remv'
alias gf='git f'
alias gfa='git fa'
alias gpl='git pl'
alias gps='git ps'
alias gpsh='git psh'
alias gpsd='git psd'
alias gpsp='git psp'
alias gsub='git sub'
alias gsubst='git subst'
alias gsubstr='git substr'
alias gsubupd1='git subupd1'
alias gsubupdr='git subupdr'
alias gsubrst='git subrst'
alias gsubf='git subf'
alias gsubfa='git subfa'
alias gsubfd='git subfd'
alias gupd='git pull; git subfa; git subupdr'
alias grm='git rm'
alias gmv='git mv'
alias gwt='git wt'
alias gwtl='git wtl'
alias gwta='git wta'
alias gwtrm='git wtrm'
alias gwtp='git wtp'
alias gwtmv='git wtmv'
alias gwtrp='git wtrp'
alias gwtlk='git wtlk'
alias gwtul='git wtul'

# Git completion
# cp ~/scripts/conf.git-completion.bash ~/.git-completion.bash
# cp ~/scripts/conf.git-completion.tcsh ~/.git-completion.tcsh
#source ~/.git-completion.tcsh
#set autolist=ambiguous

# Build git from source code:
# 1) Clean git
# 2) Build git
# 3) Install built git
alias cgit='make distclean'
alias bgit='make prefix=/usr all doc info'
alias igit='sudo make prefix=/usr install install-doc install-html install-info'


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

# Use python3 by default
alias p3='python3'
alias p='python3'


################################################################################
# VirtualBox
################################################################################

# alias llsf='sudols --time-style="+%Y-%m-%d %H:%M:%S" -lha /media/sf_share/'
alias llsf='ls --time-style="+%Y-%m-%d %H:%M:%S" -lha /media/sf_share/'

# alias cpsf='sudo cp -rf /media/sf_share/ /home/chenwx/sf_share/ && sudo chown -R chenwx:chenwx /home/chenwx/share/sf_share/'
alias cpsf='cp -rf /media/sf_share/ /home/chenwx/sf_share/'


################################################################################
# GitHub Blog
################################################################################

alias bblog='jekyll server --incremental 2>/dev/null'
alias bbloginc='jekyll server 2>/dev/null'


################################################################################
# MacBook
################################################################################

# Remove .DS_Store files in current folder on MacOS
alias rmdsstore='find . -name ".DS_Store" -type f -delete'


################################################################################
# Other Configure
################################################################################
