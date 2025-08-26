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

    # Example input
    # asciinema play /path/to/recording.cast

    # Local variables
    local a_home

    a_home=/home/"$USER"/asciinema/

    local play_file

    # List and select a file to play
    lsd -la a_home
    read -rep "Select file to play: " play_file

    printf "Playing cast file...\n "
    asciinema play "$play_file".cast

}

a-rec () {

    # Example input
    #
    # asciinema rec /path/to/recording.cast

    # Local variables
    
    # Path to asciinema directory
    local a_home

    a_home=/home/"$USER"/asciinema/

    local rec_file

    # Create file and record

    read -rep "Name of file: " rec_file

    asciinema rec "$a_home""$rec_file".cast

}

a-up () {

    # Example input
    #
    # asciinema upload /path/to/recording.cast

    # Local variables
    
    # Path to asciinema directory

    local a_home

    a_home=/home/"$USER"/asciinema/

    local up_file

    # Upload file

    read -rep "Choose file to upload: " up_file

    asciinema upload "$a_home""$up_file".cast
    
}

menu () {

    clear
    printf "
    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │1. Play recorded asciinema file                                                                                                           │
    │2. Record asciinema file                                                                                                           │
    │3. Upload asciinema file                                                                                                           │
    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    \n"
    read -rep "Which command should be executed? "
    case "${REPLY}" in
        1)
            a-play;
            exit
            ;;
        2)
            a-rec;
            exit
            ;;
        3)
            a-up;
            exit
            ;;
    esac

}

menu
