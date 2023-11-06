#!/bin/bash

######################################
# Author: Chloe Carpenter
# Creation date: 2022-07-04
# Purpose: Manage Python environments
######################################

########################
# Handle err function
# for error handling
########################

handle_err () {
  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit "$s";
}

trap handle_err ERR

# Create new Python environment
py-env-new () {
  # Local variables
  local DIRNAME

  # Set a name for the new environment directory
  read -rep "Name of Python environment directory: " DIRNAME

  # Create PyEnvironments directory in home directory

  mkdir /home/"$(whoami)"/PyEnvironments

  # Create environment
  python3 -m venv /home/"$(whoami)"/PyEnvironments/"${DIRNAME}"
}

PS3='
Which Python environment command do you wish to run? '
options=("Create python environment" "exit")
select _ in "${options[@]}"
do
  case "${REPLY}" in
  1) py-env-new ;;  
  *) exit ;;
  esac
done