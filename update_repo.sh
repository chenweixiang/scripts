#!/bin/bash

# Top directory of all repo in local laptop
repoRootDir=~/repo

# Flags to enable (=Yes) or disable (=No) specific repo
enLinux=Yes
enGit=Yes
enGitdm=No
enLinuxKernelSendMail=No
enSparse=No
enQuilt=No
enSmatch=No
enLinuxKernelTest=No
enMutt=No
enOpenwrt=No
enSystemd=No
enBusybox=No
enUboot=No
enKmod=No
enXXnet=No
enRubygems=No
enVgrep=No
enCpython=No
enIncludeWhatYouUse=No


if [ ${enLinux} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ~/linux"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ~/linux
	cd ~/linux
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enGit} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/git"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/git
	cd ${repoRootDir}/git
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enGitdm} == "Yes" ]; then
	echo -e "############################################################"
	echo -e "### Update Repository: ${repoRootDir}/gitdm"
	echo -e "############################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/gitdm
	cd ${repoRootDir}/gitdm
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enLinuxKernelSendMail} == "Yes" ]; then
	echo -e "###################################################################"
	echo -e "### Update Repository: ${repoRootDir}/linux-kernel-send-mail"
	echo -e "###################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/linux-kernel-send-mail
	cd ${repoRootDir}/linux-kernel-send-mail
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enSparse} == "Yes" ]; then
	echo -e "############################################################"
	echo -e "### Update Repository: ${repoRootDir}/sparse"
	echo -e "############################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/sparse
	cd ${repoRootDir}/sparse
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enQuilt} == "Yes" ]; then
	echo -e "############################################################"
	echo -e "### Update Repository: ${repoRootDir}/quilt"
	echo -e "############################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/quilt
	cd ${repoRootDir}/quilt
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enSmatch} == "Yes" ]; then
	echo -e "############################################################"
	echo -e "### Update Repository: ${repoRootDir}/smatch"
	echo -e "############################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/smatch
	cd ${repoRootDir}/smatch
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enLinuxKernelTest} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/linux-kernel-test"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/linux-kernel-test
	cd ${repoRootDir}/linux-kernel-test
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enMutt} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/mutt"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/mutt
	cd ${repoRootDir}/mutt
	echo -e "\n--- hg pull -u ---"
	#hg pull -u
	echo
fi

if [ ${enOpenwrt} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/openwrt"
	echo -e "######################################################################"
	echo cd ${repoRootDir}/openwrt
	cd ${repoRootDir}/openwrt
	git fetch --all
	echo
fi

if [ ${enSystemd} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/systemd"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/systemd
	cd ${repoRootDir}/systemd
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enBusybox} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/busybox"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/busybox
	cd ${repoRootDir}/busybox
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enUboot} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/u-boot"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/u-boot
	cd ${repoRootDir}/u-boot
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enKmod} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/kmod"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/kmod
	cd ${repoRootDir}/kmod
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enXXnet} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/xx-net"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/xx-net
	cd ${repoRootDir}/xx-net
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enRubygems} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/rubygems"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/rubygems
	cd ${repoRootDir}/rubygems
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enVgrep} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/vgrep"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/vgrep
	cd ${repoRootDir}/vgrep
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enCpython} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/cpython"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/cpython
	cd ${repoRootDir}/cpython
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

# A tool "include-what-you-use" for use with clang to analyze #includes in C and C++ source files
# https://include-what-you-use.org
if [ ${enIncludeWhatYouUse} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/include-what-you-use"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/include-what-you-use
	cd ${repoRootDir}/include-what-you-use
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi


