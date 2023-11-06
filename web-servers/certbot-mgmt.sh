#!/bin/bash

###################################
# Author: Chloe Carpenter
# Creation date: 2022-06-12
# Purpose: Manage certbot certs
###################################

########################
# Handle err function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

# Variables
read -rep "domain.tld: " DOMAIN1

# Functions
create-cert () {

  certbot --nginx -d "${DOMAIN1}" -d www."${DOMAIN1}"
  nginx -t
  nginx -s reload

}

PS3='
What certbot function do you wish to run? '
options=("Create certitificate" "exit")
select _ in "${options[@]}"
do
  case "${REPLY}" in
  1) create-cert ;;
  *) exit ;;
  esac
done