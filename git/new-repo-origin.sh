#!/bin/bash

: <<"AUTHOR_NOTES"

Author: Chloe Carpenter

Purpose: Push existing repository from the CLI to GitHub

AUTHOR_NOTES

: <<"HANDLE_TRAPS"

Handle trap function for error handling

HANDLE_TRAPS

handle_err() {

  local s=$?
  echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"
  exit $s

}

trap handle_err ERR

main() {
    
    # local variables
    
    local ORIGIN_LINK

    read -rep "Git origin link: " ORIGIN_LINK

    # Check if remote origin already exists

    if git remote get-url origin &>/dev/null; then
        echo "Remote 'origin' already exists. Updating to remote URL."
        git remote set-url origin "${ORIGIN_LINK}"
    else
        git remote add origin "${ORIGIN_LINK}"
    fi

    git branch -M main
    git push -u origin main

}

main
