#!/bin/bash

echo
echo -e "##################################"
echo -e "### Update Repository: ~/linux ###"
echo -e "##################################"
echo -e "\n--- change directory ---"
echo cd ~/linux
cd ~/linux
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


echo
echo -e "################################"
echo -e "### Update Repository: ~/git ###"
echo -e "################################"
echo -e "\n--- change directory ---"
echo cd ~/git
cd ~/git
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


echo
echo -e "###################################################"
echo -e "### Update Repository: ~/linux-kernel-send-mail ###"
echo -e "###################################################"
echo -e "\n--- change directory ---"
echo cd ~/linux-kernel-send-mail
cd ~/linux-kernel-send-mail
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


echo
echo -e "###################################"
echo -e "### Update Repository: ~/sparse ###"
echo -e "###################################"
echo -e "\n--- change directory ---"
echo cd ~/sparse
cd ~/sparse
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


echo
echo -e "##################################"
echo -e "### Update Repository: ~/quilt ###"
echo -e "##################################"
echo -e "\n--- change directory ---"
echo cd ~/quilt
cd ~/quilt
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


echo
echo -e "###################################"
echo -e "### Update Repository: ~/smatch ###"
echo -e "###################################"
echo -e "\n--- change directory ---"
echo cd ~/smatch
cd ~/smatch
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


echo
echo -e "##############################################"
echo -e "### Update Repository: ~/linux-kernel-test ###"
echo -e "##############################################"
echo -e "\n--- change directory ---"
echo cd ~/linux-kernel-test
cd ~/linux-kernel-test
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


echo
echo -e "#################################"
echo -e "### Update Repository: ~/mutt ###"
echo -e "#################################"
echo -e "\n--- change directory ---"
echo cd ~/mutt
cd ~/mutt
echo -e "\n--- hg pull -u ---"
hg pull -u


#echo
#echo -e "####################################"
#echo -e "### Update Repository: ~/openwrt ###"
#echo -e "####################################"
#echo cd ~/openwrt
#cd ~/openwrt
#git fetch --all


echo
echo -e "####################################"
echo -e "### Update Repository: ~/systemd ###"
echo -e "####################################"
echo -e "\n--- change directory ---"
echo cd ~/systemd
cd ~/systemd
echo -e "\n--- git fetch --all ---"
git fetch --all
echo -e "\n--- git status ---"
git status


#print a new line at the end of the script
echo

