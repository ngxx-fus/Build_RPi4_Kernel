#!/bin/bash

# NOTE:
# You can     mix [1] and [2] (or [1] and [3])
# But can NOT mix [2] and [3] bcz it will overwrite.
# E.g:
#
# echo -e "${BG_RED}This is test!${ENDCOLOR}" 
# --> OKE! Background: Red; Text: Transparent
#
# echo -e "${BG_RED}${YELLOW}This is test!${ENDCOLOR}" 
# echo -e "${YELLOW}${BG_RED}This is test!${ENDCOLOR}" 
# --> The result is much great! Both two cases have 
#     the same result that Background: Red; Text: Transparent

####### [1] TEXT EFFECT #######
BOLD="\e[1m"
FAINT="\e[2m"
ITALICS="\e[3m"
UNDERLINED="\e[4m"

####### [2] TEXT COLOR #######
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MEGENTA="\e[35m"
CYAN="\e[36m"
LIGHT_GRAY="\e[37m"
GRAY="\e[90m"
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
LIGHT_BLUE="\e[94m"
LIGHT_MEGENTA="\e[95m"
LIGHT_CYAN="\e[96m"
WHITE="\e[m97"

####### [3] BACKGROUND COLOR #######
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MEGENTA="\e[45m"
CYAN="\e[46m"
BG_LIGHT_GRAY="\e[47m"
BG_GRAY="\e[100m"
BG_LIGHT_RED="\e[101m"
BG_LIGHT_GREEN="\e[102m"
BG_LIGHT_YELLOW="\e[103m"
BG_LIGHT_BLUE="\e[104m"
BG_LIGHT_MEGENTA="\e[105m"
BG_LIGHT_CYAN="\e[106m"
BG_WHITE="\e[m107"

####### RESET #######
NORMAL="\e[0m"
ENDCOLOR="\e[0m"