#!/bin/bash

################################
# Author: Chloe Carpenter
# Creation date: 03/17/2022
# Purpose: RPM Fusion and FFMPEG
################################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

# Enable free and non-free repositories
dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
dnf install --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm

# Install free and non-free repositories
dnf install rpmfusion-free-release
dnf install rpmfusion-nonfree-release

# Install FFMPEG
dnf install ffmpeg
