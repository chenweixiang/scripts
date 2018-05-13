# scripts

This repo contains useful scripts under Linux environment:

* Configure of useful tools, such as, bash, vim, git and mutt;
* Useful scripts witten by bash, python, perl, awk, sed and etc.

## bashrc.conf

The Bash configure file ```bashrc.conf``` contains some useful alias. It should be moved to ```~/.bashrc```.

## update_repo.sh

The Bash script ```update_repo.sh``` is used to update to local repo from remote sever.

## astyle-formatter.sh

The Bash script ```astyle-formatter.sh``` is used to format C/C++ source code to the specified style.

## linux_kernel_releases.py

The Python script ```linux_kernel_releases.py``` is used to show the relationship of each release of Linux kernel. The script should be executed under local repo of Linux kernel.

## Git configure files

The Git configure files ```git-config.conf``` and ```git-completion.conf``` contains useful Git alias, which can be included into ```~/.bashrc```.

```
################################################################################
# alias for git commands (already moved to git alias, see 'git config --list')
################################################################################
source ~/scripts/git-config.conf

################################################################################
# git commands auto-completion
################################################################################
source ~/scripts/git-completion.conf
```

## git-ls.sh

The Bash script ```git-ls.sh``` is used to list all files with absolute path in the specified commit.

## git-archive.sh

The Bash script ```git-archive.sh``` is used to archive source files included in the specified commit.

## replace-tab-rm-tail-spaces.sh

The Bash script ```replace-tab-rm-tail-spaces.sh``` is used to format source files, that's replace tab to spaces and remove spaces in each line. The function is already included in script ```astyle-formatter.sh```.

## rm-tail-ctrl-M.sh

The Bash script ```rm-tail-ctrl-M.sh``` is used to format source files, that's remove the ```^M``` in each line.

## ClearCase related script

The Bash script ```clearcase-ls-commit.sh``` and its helper Python script ```clearcase-ls-commit-helper.py``` are used to list files in specified commit.

## Linux Kernel related scripts

The Bash scripts ```checkpatch-staging.sh```, ```dmesg_msg_diff.sh``` and ```dmesg_msg_save.sh``` are used to show some information of Linux kernel.
