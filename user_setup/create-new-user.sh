#!/usr/bin/env bash

: <<"AUTHOR_NOTES"

Author: Chloe Carpenter

Purpose: Create new user and set up SSH keys and auth

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

# Create new user and give sudo permissions

read -rep "Create this user: " new_user

useradd -m "${new_user}" -G wheel

passwd "${new_user}"

# Set up SSH for new user

read -rep "Will the user be connecting to remote hosts: " response

if [[ "${response}" == "yes" ]]; then

    # Create ssh dir and config file
    mkdir "${HOME}"/.ssh

    touch "${HOME}"/.ssh/config

    # Set permissions
    chmod 700 "${HOME}"/.ssh

    chmod 600 "${HOME}"/.ssh/config

    # Create root keys
    ssh-keygen -t ed25519 -f "${HOME}"/.ssh/root

    # Create user keys
    ssh-keygen -t ed25519 -f "${HOME}"/.ssh/"${new_user}"

    # Set permissions of .pub keys
    chmod 644 "${HOME}"/.ssh/root.pub

    chmod 644 "${HOME}"/.ssh/"${new_user}".pub

    # Set permissions of private keys
    chmod 600 "${HOME}"/.ssh/root

    chmod 600 "${HOME}"/.ssh/"${new_user}"
else
    echo "Not setting up for remote connections..."
fi

# Create authorized_key file and set permissions
touch "${HOME}"/.ssh/authorized_keys

chmod 600 "${HOME}"/.ssh/authorized_keys

# Add user's pubkey to authorized_keys file

read -rep "User pubkey: " pubkey

echo "${pubkey}" | tee -a /home/"${new_user}"/.ssh/authorized_keys
