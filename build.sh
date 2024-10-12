#!/bin/bash

source ./resources/Announcement.sh
source ./resources/Cores.sh
source ./resources/Branch.sh
source ./resources/Text_Effects.sh
source ./resources/Support_Functions.sh

#################################### main script ####################################
printf "${LIGHT_YELLOW}Clear screen... ${NORMAL}"
sleep 1s
clear;

printf "\n${LIGHT_YELLOW}\nHost informations: ${NORMAL}\n"
sudo neofetch

printf "${LIGHT_YELLOW}\nTarget informations: ${NORMAL}"
printf "${GRAY}\nCPU:${NORMAL}    Broadcom BCM2711"
printf "${GRAY}\nSDRAM:${NORMAL}  4GB LPDDR4-2400"
printf "${GRAY}\nKernel:${NORMAL} rpi-6.6.y"
printf "\n\n"


printf "${LIGHT_YELLOW}\nAnnouncement:${NORMAL}"
printf "\n${__01}\n"
printf "${LIGHT_RED}\nInstall the build dependencies:\n${NORMAL}"
yes_or_no;

# Update, Upgrade
printf "\n${LIGHT_GREEN}Force run: ${BOLD} update, upgrade${NORMAL}\n"
sudo apt update -y
sudo apt upgrade -y

# Install sshpass + neofetch
printf "\n${LIGHT_GREEN}Force install: ${BOLD}sshpasss, neofetch${NORMAL}\n"
sudo apt install sshpass -y
sudo apt install  neofetch -y

# Install bc bison flex ...
printf "\n${LIGHT_YELLOW}Installing \e[1mbc bison flex libssl-dev make libc6-dev libncurses5-dev${NORMAL}\n"
sudo apt install bc bison flex libssl-dev make libc6-dev libncurses5-dev -y

# Install crossbuild-essential-arm64
printf "\n${LIGHT_YELLOW}Installing \e[1mthe 64-bit toolchain to build a 64-bit kernel${NORMAL}\n"
sudo apt install crossbuild-essential-arm64 -y

# Check for continue? 
printf "${LIGHT_RED}\nBuild configuration\n${NORMAL}"
yes_or_no;

# Check is 'linux' folder cloned? 
skip_clone_linux_repo=0
if [ -d "linux" ]; then
    # 'linux' folder has cloned? 
    printf "\n${LIGHT_RED}Error$/{NORMAL}: \e[1m\"linux\"${NORMAL} has existed!"
    # Ask for *delete* or *skip cloning* 
    printf "\nDo you want to remove it?\n"
    if [ $(get_yes_or_no) -eq 1 ];
    then
         sudo rm -rf ./linux
    else
        skip_clone_linux_repo=1
        printf "\n${LIGHT_RED}mNote:${NORMAL}: Make sure all kernel has been downloaded before!\n"
    fi
fi


# Clone 'linux' folder
if [ $skip_clone_linux_repo -eq 0 ]
then
    printf "\n${LIGHT_YELLOW}Wait 5-seconds before Cloning ${BOLD}raspberrypi/linux${NORMAL}\n"
    sleep 5s
    printf "${LIGHT_YELLOW}Cloning ${BOLD}raspberrypi/linux${NORMAL}${LIGHT_YELLOW} branch=${BRANCH}${NORMAL}\n"
    git clone --depth=1 --branch ${BRANCH} https://github.com/raspberrypi/linux
fi

# Jump into 'linux' folder
printf "${LIGHT_YELLOW}Jumping into ${BOLD}./linux${NORMAL}\n"
cd ./linux

# Run config
printf "${LIGHT_YELLOW}Wait 5-seconds before starting open ${BOLD}menu-config${NORMAL}\n"
printf "${LIGHT_YELLOW}NOTE:${NORMAL} You can config in the ${BOLD}menu-config${NORMAL} to make the kernel for yourself.\n"
sleep 5s
KERNEL=kernel8

# Run default config
printf "${LIGHT_GREEN}Set up default config (bcm2711_defconfig)${NORMAL}\n"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig

# Run default config
printf "${LIGHT_GREEN}Set up more features (via  menu-config)${NORMAL}\n"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig

# Build kernel
printf "${LIGHT_YELLOW}Wait 5-seconds before starting ${BOLD}build kernel${NORMAL}\n"
printf "\n${LIGHT_BLUE}By default, we use ${BOLD}$CORES cores${NORMAL}${LIGHT_BLUE} to run make to build the kernel!${NORMAL}\n"
printf "${LIGHT_BLUE}To change this setting, edit ${BOLD}CORES=${NORMAL}${LIGHT_BLUE} in ${BOLD}resource/Cores.sh ${NORMAL}\n"
yes_or_no;
printf "${LIGHT_YELLOW}CORES=$CORES${NORMAL}\n"
make -j${CORES} ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs

# printf "${LIGHT_YELLOW}Wait 5-seconds before starting run ${BOLD}modules_install${NORMAL}\n"
# sudo make -j${CORES} modules_install

# printf "\n${LIGHT_YELLOW}You must \e[1mmanually copy${NORMAL} kernel into you SDcard!${NORMAL}\n"

printf "\e[92m\n\n----------------- Done! -----------------\n\n${NORMAL}"

################################### debug ######################################
