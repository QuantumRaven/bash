#!/bin/bash

###################################
# Author: Chloe Carpenter
# Creation date: 2023-04-27
# Purpose: Simplify nmcli commands
###################################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

# Functions

show () {

    nmcli con show

}

up () {

    read -rep "Bring up connection: " UP

    nmcli con up "${UP}"

}

down () {

    read -rep "Bring down connection: " DOWN

    nmcli con down "${DOWN}"
    
}

menu () {

    printf "
    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │1. Show available network connections                                                                                │
    │2. Connect to network with [wifi_name] or [ethernet_name]                                                            │
    │3. Disconnect to network with [wifi_name] or [ethernet_name]                                                         │
    │4. exit                                                                                                              │
    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    \n"
    read -rep "Which nmcli command should be executed: "    
    case "${REPLY}" in
        1)
            show
            ;;
        2)
            up
            ;;
        3)
            down
            ;;
        *)
            exit
            ;;
    esac

}

menu