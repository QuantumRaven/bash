#!/bin/bash

################################
# Author: Chloe Carpenter
# Creation date: 2023-10-28
# Purpose: Create bootable
# usb drive
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

if [[ "$EUID" = 0 ]]; then
    echo "Running with sudo..."
else
    printf "Must run with sudo permissions, exiting...\n"
    sleep 2
    exit 1
fi

# Functions

iso-to-usb () {

  local ISOL

  local ISOF

  local USB

  ISOL="/home/$USER/"

  printf "\n"

  ls -l "${ISOL}" 

  printf "\n"

  read -rep "Which ISO file: " ISOF

  read -rep "Which USB: " USB

  dd if="${ISOL}"/"${ISOF}" of="${USB}" bs="1M" status=progress

}

iso-to-usb
