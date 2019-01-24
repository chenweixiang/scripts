#!/bin/bash

# Top directory of all repo in local laptop
repoRootDir=~/repo

# Flags to enable (=Yes) or disable (=No) specific repo
enLinux=Yes
enGit=Yes
enGitdm=No
enLinuxKernelHistory=No
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
enTestNG=No


if [ ${enLinux} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ~/linux from"
    echo -e "### https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
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
	echo -e "### Update Repository: ${repoRootDir}/git from"
    echo -e "### https://github.com/git/git"
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
    echo -e "### git://git.lwn.net/gitdm.git"
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

if [ ${enLinuxKernelHistory} == "Yes" ]; then
	echo -e "###################################################################"
	echo -e "### Update Repository: ${repoRootDir}/linux-kernel-history from"
    echo -e "### https://github.com/gregkh/kernel-history.git"
	echo -e "###################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/linux-kernel-history
	cd ${repoRootDir}/linux-kernel-history
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enLinuxKernelSendMail} == "Yes" ]; then
	echo -e "###################################################################"
	echo -e "### Update Repository: ${repoRootDir}/linux-kernel-send-mail from"
    echo -e "### https://github.com/raphaelsc/Generate-GIT-send-mail-arguments.git"
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
    echo -e "### git://git.kernel.org/pub/scm/devel/sparse/sparse.git"
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
    echo -e "### git://git.sv.gnu.org/quilt.git"
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
    echo -e "### https://repo.or.cz/smatch.git"
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
	echo -e "### Update Repository: ${repoRootDir}/linux-kernel-test from"
    echo -e "### https://github.com/chenweixiang/linux-kernel-test.git"
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
    echo -e "### https://gitlab.com/muttmua/mutt.git"
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
    echo -e "### https://git.openwrt.org/openwrt/openwrt.git"
	echo -e "######################################################################"
	echo cd ${repoRootDir}/openwrt
	cd ${repoRootDir}/openwrt
	git fetch --all
	echo
fi

if [ ${enSystemd} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/systemd"
    echo -e "### https://github.com/systemd/systemd.git"
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
    echo -e "### https://git.busybox.net/busybox"
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
    echo -e "### https://github.com/u-boot/u-boot.git"
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
    echo -e "### https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git"
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
    echo -e "### https://github.com/XX-net/XX-Net.git"
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
    echo -e "### https://github.com/rubygems/rubygems.git"
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
    echo -e "### https://github.com/vrothberg/vgrep.git"
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
    echo -e "### https://github.com/python/cpython.git"
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
    echo -e "### https://github.com/include-what-you-use/include-what-you-use.git"
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

if [ ${enTestNG} == "Yes" ]; then
	echo -e "######################################################################"
	echo -e "### Update Repository: ${repoRootDir}/testng"
    echo -e "### git://github.com/cbeust/testng.git"
	echo -e "######################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/testng
	cd ${repoRootDir}/testng
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi


