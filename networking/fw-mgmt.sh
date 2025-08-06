#!/bin/bash

#######################################
# Author: Chloe Carpenter
# Creation date: 2022-06-11
# Purpose: Port management - firewalld
#######################################

########################
# Handle err function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

############
# Functions
############

# Add fireawll port(s)

fw-add-ports () {

  read -rep "Port number(s): " PNUM

  firewall-cmd --permanent --zone=public --add-port="${PNUM}" && sudo firewall-cmd --reload

}

# Remove firewall port(s)

fw-remove-ports () {

  read -rep "Port number(s): " PNUM

  firewall-cmd --permanent --zone=public --remove-port="${PNUM}" && sudo firewall-cmd --reload

}

# List ports

fw-list-ports () {

  firewall-cmd --list-ports

}

# Choose which fw command to run

PS3='
Which firewall command do you wish to run? '
options=("List port" "Add port" "Remove port" "exit")
select _ in "${options[@]}"
do
  case "${REPLY}" in
  1) fw-list-ports ;;
  2) fw-add-ports ;;
  3) fw-remove-ports ;;
  *) exit ;;
  esac
done
