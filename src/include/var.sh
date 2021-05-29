#!/bin/bash
export LC_MESSAGES="en_US.UTF-8"
LINES=$(tput lines)
COLUMNS=$(tput cols)
PRESS_KEY=" echo 'Press any key to continue...'; read -k1 -s"
GIT_USER_NAME=onoie
GIT_USER_EMAIL=onoie3@gmail.com
declare -a LOADED=()
