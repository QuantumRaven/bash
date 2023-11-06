#!/bin/bash

############################################################
# Author: Chloe Carpenter
# Creation date: 2022-07-3
# Purpose: Install and configure certbot, docker, and nginx
############################################################

########################
# Handle trap function
# for error handling
########################

handle_err () {
  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit "$s";
}
trap handle_err ERR

# Install nginx and python3-certbot-nginx
dnf install -y nginx python3-certbot-nginx.noarch

# Install wget tar git vim
dnf install -y wget tar git vim

# Setup modprobe for ip tables
modprobe ip_tables

# Enable nginx
systemctl enable --now nginx