#!/bin/bash

source ./resources/Announcement.sh
source ./resources/Cores.sh
source ./resources/Branch.sh
source ./resources/Text_Effects.sh
source ./resources/Support_Functions.sh
source ./resources/Installation_Vars.sh

printf "${LIGHT_YELLOW}Clear screen... ${NORMAL}"
sleep 1s
clear

printf "\n${LIGHT_YELLOW}\nHost informations: ${NORMAL}\n"
sudo neofetch

printf "${LIGHT_YELLOW}\nTarget informations: ${NORMAL}"
printf "${GRAY}\nCPU:${NORMAL}    Broadcom BCM2711"
printf "${GRAY}\nSDRAM:${NORMAL}  4GB LPDDR4-2400"
printf "${GRAY}\nKernel:${NORMAL} rpi-6.6.y"
printf "\n\n"

printf "${LIGHT_YELLOW}\nAnnouncement:${NORMAL}"
printf "\n${__02}\n"

printf "${LIGHT_RED}\nInstall the build dependencies (NO to skip this installation):\n${NORMAL}"
if [ $(get_yes_or_no) -eq 1 ]; then
  # Update, Upgrade
  printf "\n${LIGHT_GREEN}Force run: ${BOLD} update, upgrade${NORMAL}\n"
  sudo apt update -y
  sudo apt upgrade -y

  # Install sshpass + neofetch
  printf "\n${LIGHT_GREEN}Force install: ${BOLD}sshpasss, neofetch${NORMAL}\n"
  sudo apt install sshpass -y
  sudo apt install neofetch -y

  # Install bc bison flex ...
  printf "\n${LIGHT_YELLOW}Installing \e[1mbc bison flex libssl-dev make libc6-dev libncurses5-dev${NORMAL}\n"
  sudo apt install bc bison flex libssl-dev make libc6-dev libncurses5-dev -y

  # Install crossbuild-essential-arm64
  printf "\n${LIGHT_YELLOW}Installing \e[1mthe 64-bit toolchain to build a 64-bit kernel${NORMAL}\n"
  sudo apt install crossbuild-essential-arm64 -y
fi

printf "\n\n${LIGHT_YELLOW}Please confirm mounted status, kernel_dir, root_dev, boot_dev!\n(\'N/n\' to update!)${NORMAL}"
printf "\n${LIGHT_BLUE}boot_dev${NORMAL} = /dev/$boot_dev"
printf "\n${LIGHT_BLUE}root_dev${NORMAL} = /dev/$root_dev"
printf "\n${LIGHT_BLUE}kernel_dir${NORMAL} = $kernel_dir"
printf "\n${LIGHT_BLUE}Mounted devices:${NORMAL}"
lsblk

if [ $(get_yes_or_no -n) -eq 0 ]; then
  printf "\n${LIGHT_YELLOW}You have to enter boot_dev, root_dev, kernel directory before continue!${NORMAL}\n"
  printf "\n${LIGHT_BLUE}Please ${BOLD}un-mount (not eject)${NORMAL}${LIGHT_BLUE} all partitions in your SD-card${NORMAL}\n"
  lsblk
  printf "\n"
  yes_or_no
  printf "\n"
  lsblk

  printf "\n${LIGHT_BLUE}boot_dev${NORMAL} = /dev/"
  read boot_dev
  printf "\n${LIGHT_BLUE}root_dev${NORMAL} = /dev/"
  read root_dev
  printf "\n${LIGHT_BLUE}kernel_dir${NORMAL} = "
  read kernel_dir

  printf "\n\n${LIGHT_YELLOW}Updated boot_dev, root_dev, kernel directory!${NORMAL}"
  printf "\n${LIGHT_BLUE}boot_dev${NORMAL} = /dev/$boot_dev"
  printf "\n${LIGHT_BLUE}root_dev${NORMAL} = /dev/$root_dev"
  printf "\n${LIGHT_BLUE}kernel_dir${NORMAL} = $kernel_dir"
fi

printf "\n\n${LIGHT_YELLOW}Jump into \"kernel_linux\"${NORMAL}"
cd $kernel_dir

printf "\n\n${LIGHT_YELLOW}Create "mnt" directory tree:${NORMAL}"
printf "${mnt_tree}"
yes_or_no -n

skip_mount=0
# Is 'mnt' folder created?
if [ -d "mnt" ]; then
  # 'mnt' folder has been cloned!
  printf "\n${LIGHT_RED}Error${NORMAL}: ${BOLD}\"mnt\"${NORMAL} has existed!"
  # Ask for *delete* or *skip*
  printf "\nDo you want to remove it and re-create?\n"
  if [ $(get_yes_or_no) -eq 1 ]; then
    sudo rm -rf ./mnt
    mkdir ./mnt
    mkdir ./mnt/boot
    mkdir ./mnt/root
  else
    printf "\n${LIGHT_RED}mNote:${NORMAL}: Make sure all kernel has been downloaded before!\n"
    skip_mount=1
  fi
else
  mkdir ./mnt
  mkdir ./mnt/boot
  mkdir ./mnt/root
fi

if [ $skip_mount -eq 0 ]; then
  printf "\n\n${LIGHT_YELLOW}Mount /dev/$boot_dev at ./mnt/boot${NORMAL}"
  sudo mount /dev/${boot_dev} ./mnt/boot

  printf "\n\n${LIGHT_YELLOW}Mount /dev/$root_dev at ./mnt/root${NORMAL}"
  sudo mount /dev/${root_dev} ./mnt/root
fi

printf "\n\n${LIGHT_YELLOW}Please confirm mounted status!\n(\'N/n\' to abort!)${NORMAL}\n"
lsblk
yes_or_no -n

printf "\n\n${LIGHT_YELLOW}Install the kernel modules onto the boot media:${NORMAL}\n"
printf "CORES=$CORES\n"
yes_or_no -n
sudo env PATH=$PATH make -j${CORES} ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=mnt/root modules_install

printf "\n\n${LIGHT_YELLOW}Create a backup image of the current kernel${NORMAL}\n"
printf "KERNEL=$KERNEL\n"
yes_or_no -n
sudo cp mnt/boot/$KERNEL.img mnt/boot/$KERNEL-backup.img

printf "\n\n${LIGHT_YELLOW}Install the fresh kernel image, overlays, README${NORMAL}\n"
yes_or_no -n
sudo cp arch/arm64/boot/Image mnt/boot/$KERNEL.img
sudo cp arch/arm64/boot/dts/broadcom/*.dtb mnt/boot/
sudo cp arch/arm64/boot/dts/overlays/*.dtb* mnt/boot/overlays/
sudo cp arch/arm64/boot/dts/overlays/README mnt/boot/overlays/

printf "\n\n${LIGHT_YELLOW}Unmount the partitions${NORMAL}\n"
sudo umount mnt/boot
sudo umount mnt/root
