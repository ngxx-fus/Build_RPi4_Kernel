#!/bin/bash
#################################### function declaration ####################################
yes_or_no(){
    while true; do
        read -n 1 -p "[Y/n]:" yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) printf "Please answer correct form!\n";;
        esac
    done
}

get_yes_or_no(){
    while true; do
        read -n 1 -p "[Y/n]:" yn
        case $yn in
            [Yy]* ) echo '1'; return 0;;
            [Nn]* ) echo '0'; return 0;;
            * ) printf "Please answer correct form!\n";;
        esac
    done
}

check_sshpass_neofetch(){
    if ! command -v sshpass 2>&1 >/dev/null
    then
        echo -e "Error: \e[91msshpass\e[0m could not be found\!\n"
        echo -e "Pls install \e[91msshpass\e[0m via command:\n"
        echo -e "sudo apt install sshpass -y\n"
        exit 0
    fi
    if ! command -v neofetch 2>&1 >/dev/null
    then
        echo -e "Error: \e[91mneofetch\e[0m could not be found! \n"
        echo -e "Pls install \e[91mneofetch\e[0m via command:\n"
        echo -e "sudo apt install neofetch -y\n"
        exit 0
    fi
}
