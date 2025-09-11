#!/usr/bin/env bash

: <<"AUTHOR_NOTES"

Author: Chloe Carpenter

Purpose: Menu template 2

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

# Create new user and give sudo permissions

read -rep "Create this user: " NEW_USER

useradd -m "${NEW_USER}" -G wheel

passwd "${NEW_USER}"
