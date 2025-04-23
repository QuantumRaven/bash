#!/bin/bash

################################
# Author: Chloe Carpenter
# Creation date: 
# Purpose: Screen recording
# for asciinema and wf-recorder
################################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

# Uncomment below if script needs to check for sudo perms before running

# if [[ "$EUID" = 0 ]]; then
#     echo "Already root, running..."
# else
#     printf "Must run with sudo permissions, exiting...\n"
#     sleep 2
#     exit 1
# fi

# Functions

rec-asciinema () {

    asciinema rec

}

rec-wf () {

  local LOC

  local TYPE
  
  LOC=/home/"$(whoami)"/Videos/

  printf "\n"

  read -rep "Filename | e.g. my-file: " TYPE

  wf-recorder --audio -f "${LOC}""${TYPE}".mp4 --output DP-2

  sleep 1s

}

menu () {

    clear

    # Choose which recording command to run
    PS3='
    Which command do you wish to run? '
    options=("asciinema" "wf-recorder" "exit")
    select _ in "${options[@]}"
    do
    case "${REPLY}" in
        1) rec-asciinema ;
           exit ;;
        2) rec-wf ;
           exit ;;
        *) exit ;;
  esac
done

}

menu