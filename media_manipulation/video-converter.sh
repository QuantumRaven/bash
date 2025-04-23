#!/bin/bash

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

  # Variables
  read -rep "Input .mkv filename: " INPUT
  read -rep "Output .mp4 filename: " OUTPUT

  # Convert files
  ffmpeg -i "${INPUT}" "${OUTPUT}".mp4

}

remove-video () {

  # Variables
  read -rep "Input .mkv file to delete: " MKV

  # Remove file
  rm "${MKV}"

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