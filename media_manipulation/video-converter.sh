#!/usr/bin/env bash

###############################
# Author: Chloe Carpenter
# Creation date: 2022-04-17
# Purpose: Vid converter
###############################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

# Functions

convert-video () {

  local INPUT

  local OUTPUT

  # Variables
  read -rep "Input filename: " INPUT
  read -rep "Output filename: " OUTPUT

  # Convert files
  ffmpeg -i "${INPUT}" "${OUTPUT}"

}

remove-video () {

  local INPUT

  # Variables
  read -rep "Input file to delete: " INPUT

  # Remove file
  rm "${INPUT}"

}

PS3='
What video command do you wish to run? '
options=("Convert video" "Remove video" "exit")
select _ in "${options[@]}"
do
  case "${REPLY}" in
  1) convert-video ;;
  2) remove-video ;;
  *) exit ;;
  esac
done
