#!/bin/bash

###################################
# Author: Chloe Carpenter
# Creation date: 2023-06-11
# Purpose: KVM/QEMU VM
# Creation Menu
###################################

########################
# Handle trap function
# for error handling
########################

handle_err () {

    local s=$?
    echo "$0:${BASH_LINENO[0]} $BASH_COMMAND"
    exit $s

}

trap handle_err ERR

# Global variables

# Global functions



# Manual VM installation

manual-uefi () {

    # Local variables

    local NAME
    read -rep "Name of VM: " NAME
    printf "\n"

    local VCPU
    read -rep "How many virtual cpus: " VCPU
    printf "\n"

    local MEMORY
    # How much memory
    PS3='How much memory: '
    options=("512M" "1G" "2G" "4G" "8G" "16G")
    select _ in "${options[@]}"
    do
    case "${REPLY}" in
      1) MEMORY=2048 ; break ;;
      2) MEMORY=4096 ; break ;;
      3) MEMORY=8192 ; break ;;
      4) MEMORY=16384 ; break ;;
    esac
    done
    printf "\n"

    local DISKSIZE
    read -rep "Disk size in GB: " DISKSIZE
    printf "\n"

    local OSVARIANT
        # Pick OS variant
    PS3='
    Which OS Variant do you wish to use: '
    options=("Generic" "NixOS" "Rocky") 
    select _ in "${options[@]}"
    do
        case "${REPLY}" in
            1) OSVARIANT=generic ; break ;;
            2) OSVARIANT=nixos-25.05 ; break ;;
            3) OSVARIANT=rocky10 ; break ;;
        esac
    done
    printf "\n"

    ls -l /mounts/wd_red/virtualization/isos

    printf "\n"

    local ISO
    read -rep "ISO File: " ISO

    /usr/bin/virt-install \
        --name "${NAME}" \
        --memory "${MEMORY}" \
        --vcpus "${VCPU}" \
        --disk path=/mounts/wd_red/virtualization/vdisks/"${NAME}".qcow2,size="${DISKSIZE}" \
        --os-variant "${OSVARIANT}" \
        --network bridge=br0,model=virtio \
        --location /mounts/wd_red/virtualization/isos/"${ISO}" \
        --graphics none \
	--console pty,target_type=serial \
        --extra-args "console=ttys0,115200n8 inst.text" \
        --boot uefi
    
    exit

}

manual-bios () {

    # Local variables

    local NAME
    read -rep "Name of VM: " NAME
    printf "\n"

    local VCPU
    read -rep "How many virtual cpus: " VCPU
    printf "\n"

    local MEMORY
    # How much memory
    PS3='How much memory: '
    options=("512M" "1G" "2G" "4G" "8G" "16G")
    select _ in "${options[@]}"
    do
    case "${REPLY}" in
      1) MEMORY=2048 ; break ;;
      2) MEMORY=4096 ; break ;;
      3) MEMORY=8192 ; break ;;
      4) MEMORY=16384 ; break ;;
    esac
    done
    printf "\n"

    local DISKSIZE
    read -rep "Disk size in GB: " DISKSIZE
    printf "\n"

    local OSVARIANT
        # Pick OS variant
    PS3='
    Which OS Variant do you wish to use: '
    options=("Generic" "NixOS" "Rocky") 
    select _ in "${options[@]}"
    do
        case "${REPLY}" in
            1) OSVARIANT=generic ; break ;;
            2) OSVARIANT=nixos-25.05 ; break ;;
            3) OSVARIANT=rocky10 ; break ;;
        esac
    done
    printf "\n"

    ls -l /mounts/wd_red/virtualization/isos

    printf "\n"

    local ISO
    read -rep "ISO File: " ISO

    /usr/bin/virt-install \
        --name "${NAME}" \
        --memory "${MEMORY}" \
        --vcpus "${VCPU}" \
        --disk path=/mounts/wd_red/virtualization/vdisks/"${NAME}".qcow2,size="${DISKSIZE}" \
        --os-variant "${OSVARIANT}" \
        --network bridge=br0,model=virtio \
        --location /mounts/wd_red/virtualization/isos/"${ISO}" \
        --graphics none \
	--console pty,target_type=serial \
        --extra-args "console=ttys0,115200n8 inst.text"
    
    exit    

}

# PXE w/ kickstart and preeseed installations for fully automated experience

# To be continued...

menu () {

    clear

    # Choose which fw command to run
    PS3='Which command do you wish to run: '

    options=("Manual UEFI" "Manual BIOS" "exit")
    select _ in "${options[@]}"; do
        case "${REPLY}" in        
        1) manual-uefi ;;           
        2) manual-bios ;;
        *) exit ;;
        esac
    done

}

menu
