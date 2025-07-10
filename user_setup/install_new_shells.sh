#!/bin/bash

: <<"AUTHOR_NOTES"

Author: Chloe Carpenter

Purpose: Menu template 2

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

option1 () {

    printf "option1\n"

}

option2 () {

    printf "option2\n"

}

option3 () {

    printf "option3\n"

}

menu () {

    clear

    # Choose which command to run
    PS3='
    Which command do you wish to run? '
    options=("Opt1" "Opt2" "Opt3" "exit")
    select _ in "${options[@]}"
    do
    case "${REPLY}" in
        1) option1 ;;
        2) option2 ;;
        3) option3 ;;
        *) exit ;;
  esac
done

}

menu
