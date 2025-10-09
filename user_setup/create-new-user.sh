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
    echo "Running with sudo..."
    printf "\n"
else
    printf "Must run with sudo permissions, exiting...\n"
    sleep 2
    exit 1
fi

# Create new user and give sudo permissions

read -rep "Create this user: " new_user

read -rep "Distro: debian or rhel? " distro

if [[ "${distro}" == "debian" ]]; then
    useradd -m "${new_user}" -G sudo -s /usr/bin/bash

    passwd "${new_user}"
elif [[ "${distro}" == "rhel" ]]; then
    useradd -m "${new_user}" -G wheel -s /usr/bin/bash

    password "${new_user}"
fi

# Create ssh dir and config file
mkdir /home/"${new_user}"/.ssh

touch /home/"${new_user}"/.ssh/config

# Set permissions

chmod 700 /home/"${new_user}"/.ssh

chmod 600 /home/"${new_user}"/.ssh/config

# Prompt on whether to set up SSH keys for new user
printf ""
read -rep "Configure SSH keys: " response

if [[ "${response}" == "yes" ]]; then
    # Create root keys
    ssh-keygen -t ed25519 -f /home/"${new_user}"/ssh/root

    # Create user keys
    ssh-keygen -t ed25519 -f /home/"${new_user}"/.ssh/"${new_user}"

    # Set permissions of .pub keys
    chmod 644 /home/"${new_user}"/.ssh/root.pub

    chmod 644 /home/"${new_user}"/.ssh/"${new_user}".pub

    # Set permissions of private keys
    chmod 600 /home/"${new_user}"/.ssh/root

    chmod 600 /home/"${new_user}"/.ssh/"${new_user}"
else
    echo "Not configuring SSH keys..."
fi

# Create authorized_key file and set permissions
touch /home/"${new_user}"/.ssh/authorized_keys

chmod 600 /home/"${new_user}"/.ssh/authorized_keys

# Set ownership

chown -R "${new_user}":"${new_user}" /home/"${new_user}"/.ssh

# Add user's pubkey to authorized_keys file

read -rep "User pubkey: " pubkey

echo "${pubkey}" | tee -a /home/"${new_user}"/.ssh/authorized_keys
