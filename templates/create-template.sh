#!/bin/bash

###########################
# Author: Chloe Carpenter
# Creation date: 
# Purpose: Create templates
###########################

########################
# Handle trap function
# for error handling
########################

handle_err () {

  local s=$?; echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s;

}

trap handle_err ERR

# Uncomment below if script needs to check for sudo perms before running

# if [[ "$EUID" = 0 ]]; then
#     echo "(1) already root"
# else
#     sudo -k # make sure to ask for password on next sudo
#     if sudo true; then
#         echo "(2) correct password"
#     else
#         echo "(3) wrong password"
#         exit 1
#     fi
# fi

# Functions

bash-template () {

  SOURCE="/mnt/hq/dev/bash/templates/bash-template.sh"

  read -rep "Choose home: " DEST

  read -rep "Filename: " NAME

  rsync "${SOURCE}" "${DEST}""${NAME}".sh

  chmod +x "${DEST}""${NAME}".sh
  
}

py-template () {

  SOURCE="/mnt/hq/dev/bash/templates/py-template.py"

  read -rep "Choose home: " DEST

  read -rep "Filename: " NAME

  rsync "${SOURCE}" "${DEST}""${NAME}".py
  
}

menu-template-print () {

  SOURCE="/mnt/hq/dev/bash/templates/menu-template-print.sh"

  read -rep "Choose home: " DEST

  read -rep "Filename: " NAME

  rsync "${SOURCE}" "${DEST}""${NAME}".sh

  chmod +x "${DEST}""${NAME}".sh

}

menu-template-ps3 () {

  SOURCE="/mnt/hq/dev/bash/templates/menu-template-ps3.sh"

  read -rep "Choose home: " DEST

  read -rep "Filename: " NAME

  rsync "${SOURCE}" "${DEST}""${NAME}".sh

  chmod +x "${DEST}""${NAME}".sh

}

menu () {

    clear
    printf "
    ┌───────────────────────┐
    │1. bash-template       │
    │2. menu-template-print │
    │3. menu-template-ps3   │
    │4. py-template         │
    │5. exit                │
    └───────────────────────┘
    \n"
    read -rep "Which command should be executed? "
    case "${REPLY}" in
        1)
            bash-template;            
            ;;
        2)
            menu-template-print;            
            ;;
        3)
            menu-template-ps3;
            ;;
        4)  py-template;
            ;;
        *)  exit
            ;;
    esac

}

menu