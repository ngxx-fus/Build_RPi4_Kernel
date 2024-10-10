#!/bin/bash
source ./resources/Cores.sh
source ./resources/Branch.sh
source ./resources/Text_Effects.sh
source ./resources/Support_Functions.sh

#################################### main script ####################################
printf "${LIGHT_YELLOW}Clear screen... ${NORMAL}"
clear;
# check_sshpass_neofetch;

# password=""
# read -s -p "Enter your password: " password

printf "\e[92m\nForce run: ${BOLD} update, upgrade${NORMAL}\n"
sudo apt update -y
sudo apt upgrade -y

printf "\e[92m\nForce install: ${BOLD}sshpasss, neofetch${NORMAL}\n"
sudo apt install sshpass -y
sudo apt install  neofetch -y

printf "\n${LIGHT_YELLOW}\nHost informations: ${NORMAL}"
sudo neofetch

printf "${LIGHT_YELLOW}\nTarget informations: ${NORMAL}"
printf "${GRAY}\nCPU:${NORMAL}    Broadcom BCM2711"
printf "${GRAY}\nSDRAM:${NORMAL}  4GB LPDDR4-2400"
printf "${GRAY}\nKernel:${NORMAL} rpi-6.6.y"
printf "\n\n"


printf "${LIGHT_YELLOW}\nAnnouncement:${NORMAL}"
printf "\n$(cat ./resources/Announcement)\n"

printf "${LIGHT_RED}m\nInstall the build dependencies:\n${NORMAL}"
yes_or_no;

printf "\n${LIGHT_YELLOW}Installing \e[1mbc bison flex libssl-dev make libc6-dev libncurses5-dev${NORMAL}\n"
sudo apt install bc bison flex libssl-dev make libc6-dev libncurses5-dev

sudo apt update -y
sudo apt upgrade -y

printf "\n${LIGHT_YELLOW}Installing \e[1mthe 64-bit toolchain to build a 64-bit kernel${NORMAL}\n"
sudo apt install crossbuild-essential-arm64

printf "${LIGHT_RED}m\nBuild configuration\n${NORMAL}"
yes_or_no;

skip_clone_linux_repo=0
if [ -d "linux" ]; then
    printf "\n${LIGHT_RED}mError${NORMAL}: \e[1m\"linux\"${NORMAL} has existed!"
    printf "\nDo you want to remove it?\n"
    if [ $(get_yes_or_no) -eq 1 ];
    then
         sudo rm -rf ./linux
    else
        skip_clone_linux_repo=1
        printf "\n${LIGHT_RED}mNote:${NORMAL}: Make sure all kernel has been downloaded before!\n"
    fi
fi


if [ $skip_clone_linux_repo -eq 0 ]
then
    printf "\n${LIGHT_YELLOW}Wait 5-seconds before Cloning ${BOLD}raspberrypi/linux${NORMAL}\n"
    sleep 5s
    printf "${LIGHT_YELLOW}Cloning ${BOLD}raspberrypi/linux${NORMAL}${LIGHT_YELLOW} branch=${BRANCH}${NORMAL}\n"
    git clone --depth=1 --branch ${BRANCH} https://github.com/raspberrypi/linux
fi

printf "${LIGHT_YELLOW}Jumping into ${BOLD}./linux${NORMAL}\n"
cd ./linux

printf "${LIGHT_YELLOW}Wait 5-seconds before starting open ${BOLD}menu-config${NORMAL}\n"
printf "${LIGHT_YELLOW}NOTE:${NORMAL} You can config in the ${BOLD}menu-config${NORMAL} to make the kernel for yourself.\n"
sleep 5s
KERNEL=kernel8
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig

printf "${LIGHT_YELLOW}Wait 5-seconds before starting ${BOLD}build kernel${NORMAL}\n"

printf "${LIGHT_YELLOW}CORES=$CORES${NORMAL}\n"
make -j${CORES} ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs

# printf "${LIGHT_YELLOW}Wait 5-seconds before starting run ${BOLD}modules_install${NORMAL}\n"
# sudo make -j${CORES} modules_install

# printf "\n${LIGHT_YELLOW}You must \e[1mmanually copy${NORMAL} kernel into you SDcard!${NORMAL}\n"

# printf "\e[92m\n\n----------------- Done! -----------------\n\n${NORMAL}"

