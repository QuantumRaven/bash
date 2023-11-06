#!/bin/bash

##################################
# Author: Chloe Carpenter
# Creation date: 2022-04-09
# Purpose: Manage containers
##################################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

case "${1}" in
  start)
    echo "Starting ${2} container..."
    docker compose -f "${2}/docker-compose.yml" up -d
    sleep 4s
  ;;
  stop)
    echo "Stopping ${2} contianer"
    docker compose -f "${2}/docker-compose.yml" down
    sleep 4s
  ;;
  build)
    echo "Building ${2} container..."
    docker compose -f "${2}/docker-compose.yml" up --build -d
    sleep 4s
  ;;
  logs)
    echo "Reading logs..."
    docker compose -f "${2}/docker-compose.yml" logs
  ;;
  *) echo "Help?"
     echo "${0} start|stop|build|logs <docker-container>"
  ;;
esac