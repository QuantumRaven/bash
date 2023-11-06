#!/bin/bash

############################
# Author: Chloe Carpenter
# Creation date: 2022-04-28
# Purpose: Install EPEL
# on Rocky Linux
############################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit "$s";

}

trap handle_err ERR

# Install dnf plugins core

dnf -y install dnf-plugins-core

dnf upgrade -y

# Install EPEL and PowerTools repository

/usr/bin/crb enable

dnf install -y epel-release

# Update system

dnf upgrade -y