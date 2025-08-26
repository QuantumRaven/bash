#!/bin/bash

: <<"AUTHOR_NOTES"

Author: Chloe Carpenter

Purpose: Menu template 1

AUTHOR_NOTES

: <<"HANDLE_TRAPS"

Handle trap function for error handling

HANDLE_TRAPS

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

# Uncomment below if script needs to check for sudo perms before running
# To uncomment, remove the : <<"TEXT" and TEXT

: <<"SUDO_REQUIRED"

if [[ "$EUID" = 0 ]]; then
    echo "Already root, running..."
else
    printf "Must run with sudo permissions, exiting...\n"
    sleep 2
    exit 1
fi

SUDO_REQUIRED

# Functions

a-play () {

    # Local variables
    local playfile

    # List and select a file to play
    lsd -la /home/quantumcrow/asciinema/
    read -rep "Select file to play: " playfile

    printf "Playing cast file...\n"
    asciinema play playfile    

}

option2 () {

    printf "option2\n"

}

option3 () {

    printf "option3\n"
    
}

menu () {

    clear
    printf "
    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │1. Option1                                                                                                           │
    │2. Option2                                                                                                           │
    │3. Option3                                                                                                           │
    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    \n"
    read -rep "Which command should be executed? "
    case "${REPLY}" in
        1)
            option1;
            exit
            ;;
        2)
            option2;
            exit
            ;;
        3)
            option3;
            exit
            ;;
    esac

}

menu
