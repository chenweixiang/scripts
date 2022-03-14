"===============================================================================
"= This is configuration for Vim. Also check the example:                      =
"=     /usr/share/vim/vim74/vimrc_example.vim                                  =
"=                                                                             =
"= Three ways to use this configuration:                                       =
"=                                                                             =
"= 1) Check original configure file ~/.vimrc:                                  =
"=        cat ~/.vimrc                                                         =
"=    Replace it if no useful configuration in original one:                   =
"=       cp ~/scripts/conf.vimrc ~/.vimrc                                      =
"=                                                                             =
"= 2) Copy this configuration to home directory:                               =
"=       cp ~/scripts/conf.bashrc ~/.vimrc.user                                =
"=   Source it in original configure file if not yet:                          =
"=       cat ~/.vimrc | grep -n source                                         =
"=       echo "source ~/.vimrc.user" >> ~/.vimrc                               =
"=                                                                             =
"= 3) Call the configure file while start Vim:                                 =
"=        vim -u ~/scripts/vimrc.conf                                          =
"=                                                                             =
"===============================================================================

"Don't compatible to vi
set nocompatible

"Show line number
set number

"Show relative line number to current line
set relativenumber

"Highlight the screen line of the cursor with CursorLine.
"NOTE: no need this option if 'set relativenumber' is enabled.
"set cursorline

"Show syntax
set syntax=on

"Tab length
set tabstop=4

"Usage of backspace key
set backspace=2

"Show match brackets
set showmatch

"Highlight the column 80
set colorcolumn=80

"If in Insert, Replace or Visual mode, put a message on the last line.
set showmode

"Show (partial) command in the last line of the screen.
set showcmd

"This option influences when the last window will have a status line:
"  0: never
"  1: only if there are at least two windows
"  2: always
set laststatus=2

"Show the line and column number of the cursor position, separated by a comma.
set ruler

"When there is a previous search pattern, highlight all its matches.
set hlsearch

"While typing a search command, show where the pattern, as it was typed so far,
"matches.
set incsearch

"If the 'ignorecase' option is on, the case of normal letters is ignored.
"'smartcase' can be set to ignore case when the pattern contains lowercase
"letters only.
set ignorecase

"Override the 'ignorecase' option if the search pattern contains upper case
"characters. Only used when the search pattern is typed and 'ignorecase' option
"is on.
set smartcase

"Do not wrap around. By default, the 'wrapscan' option is on, which means that
"when "search next" reaches end of file, it wraps around to the beginning, and
"when "search previous" reaches the beginning, it wraps around to the end.
set nowrapscan

"Don't make a backup
set nobackup

"Don't create swap file
set noswapfile

"Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

"Put Vim in Paste mode.  This is useful if you want to cut or copy some text
"from one window and paste it in Vim.  This will avoid unexpected effects.
"set paste
"set nopaste
