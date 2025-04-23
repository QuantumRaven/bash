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

convert-audio () {

  zetta -- *.ogg

  # Variables
  read -rep "Input .ogg filename: " INPUT
  read -rep "Output .mp3 filename: " OUTPUT

  # Convert files
  ffmpeg -i "${INPUT}" "${OUTPUT}".mp3

  # Delete ogg file
  rm "${INPUT}"

}

PS3='
What audio command do you wish to run? '
options=("Convert audio" "Exit")
select _ in "${options[@]}"
do
  case "${REPLY}" in
  1) convert-audio ;;
  2) exit ;;     
  esac
done