#!/bin/bash

# Top directory of all repo in local laptop
repoRootDir=~

# Flags to enable (=Yes) or disable (=No) specific repo
enLinux=Yes
enLinuxGitPull=Yes
enGit=No
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/linux"
	echo -e "### [From] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
	echo -e "##############################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/linux
	cd ${repoRootDir}/linux
if [ ${enLinuxGitPull} == "Yes" ]; then
	echo -e "\n--- git reset --hard HEAD ---"
	git reset --hard HEAD
	echo -e "\n--- git checkout master ---"
	git checkout master
	echo -e "\n--- git pull ---"
	git pull
else
	echo -e "\n--- git fetch --all ---"
	git fetch --all
fi
	echo -e "\n--- git status ---"
	git status
	echo
fi

if [ ${enGit} == "Yes" ]; then
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/git"
	echo -e "### [From] https://github.com/git/git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/gitdm"
	echo -e "### [From] git://git.lwn.net/gitdm.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/linux-kernel-history"
	echo -e "### [From] https://github.com/gregkh/kernel-history.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/linux-kernel-send-mail"
	echo -e "### [From] https://github.com/raphaelsc/Generate-GIT-send-mail-arguments.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/sparse"
	echo -e "### [From] git://git.kernel.org/pub/scm/devel/sparse/sparse.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/quilt"
	echo -e "### [From] git://git.sv.gnu.org/quilt.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/smatch"
	echo -e "### [From] https://repo.or.cz/smatch.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/linux-kernel-test"
	echo -e "### [From] https://github.com/chenweixiang/linux-kernel-test.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/mutt"
	echo -e "### [From] https://gitlab.com/muttmua/mutt.git"
	echo -e "##############################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/mutt
	cd ${repoRootDir}/mutt
	echo -e "\n--- hg pull -u ---"
	#hg pull -u
	echo
fi

if [ ${enOpenwrt} == "Yes" ]; then
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/openwrt"
	echo -e "### [From] https://git.openwrt.org/openwrt/openwrt.git"
	echo -e "##############################################################################"
	echo cd ${repoRootDir}/openwrt
	cd ${repoRootDir}/openwrt
	git fetch --all
	echo
fi

if [ ${enSystemd} == "Yes" ]; then
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/systemd"
	echo -e "### [From] https://github.com/systemd/systemd.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/busybox"
	echo -e "### [From] https://git.busybox.net/busybox"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/u-boot"
	echo -e "### [From] https://github.com/u-boot/u-boot.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/kmod"
	echo -e "### [From] https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/xx-net"
	echo -e "### [From] https://github.com/XX-net/XX-Net.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/rubygems"
	echo -e "### [From] https://github.com/rubygems/rubygems.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/vgrep"
	echo -e "### [From] https://github.com/vrothberg/vgrep.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/cpython"
	echo -e "### [From] https://github.com/python/cpython.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/include-what-you-use"
    echo -e "### [From] https://github.com/include-what-you-use/include-what-you-use.git"
	echo -e "##############################################################################"
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
	echo -e "##############################################################################"
	echo -e "### [Repo] ${repoRootDir}/testng"
	echo -e "### [From] git://github.com/cbeust/testng.git"
	echo -e "##############################################################################"
	echo -e "\n--- change directory ---"
	echo cd ${repoRootDir}/testng
	cd ${repoRootDir}/testng
	echo -e "\n--- git fetch --all ---"
	git fetch --all
	echo -e "\n--- git status ---"
	git status
	echo
fi


