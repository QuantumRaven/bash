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

if [[ "$EUID" = 0 ]]; then
    echo "Already root, running..."
else
    printf "Must run with sudo permissions, exiting...\n"
    sleep 2
    exit 1
fi


EPEL="epel-release"


dnf config-manager --set-enabled crb

dnf install epel-release -y

dnf install git tar wget2 curl strace chrony fzf bat ripgrep fish tldr ncdu jq -y

dnf update -y && dnf upgrade -y
