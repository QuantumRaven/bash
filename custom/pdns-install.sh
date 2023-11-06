#!/bin/bash

################################
# Author: Chloe Carpenter
# Creation date: 2023-10-28
# Purpose: Install PDNS on
# Rocky 9
################################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR


# Uncomment below if script needs to check for sudo perms before running

if [[ "$EUID" = 0 ]]; then
    echo "Already root, running..."
else
    printf "Must run with sudo permissions, exiting...\n"
    sleep 2
    exit 1
fi

# Functions

dnf install -y epel-release

/usr/bin/crb enable

dnf upgrade -y

dnf install -y pdns-recursor pdns pdns-backend-postgresql pdns-tools

rpm --install https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm

dnf -qy module disable postgresql

dnf install -y postgresql16-server

/usr/pgsql-16/bin/postgresql-16-setup initdb

systemctl enable --now postgresql-16