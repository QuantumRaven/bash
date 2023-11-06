#!/bin/bash

################################
# Author: Chloe Carpenter
# Creation date: 
# Purpose: Create bash template
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

