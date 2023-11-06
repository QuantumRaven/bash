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
      1) MEMORY=512 ; break ;;
      2) MEMORY=1024 ; break ;;
      3) MEMORY=2048 ; break ;;
      4) MEMORY=4096 ; break ;;
      5) MEMORY=8192 ; break ;;
      6) MEMORY=16384 ; break ;;
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
    options=("Fedora" "NixOS" "Debian" "Arch Linux" "OpenSUSE Leap" "OpenSUSE Tumbleweed" "Generic" "Gentoo" "Rocky" "Windows 10" "Windows 11" "Windows Server 2022" "Android 9.0")
    select _ in "${options[@]}"
    do
        case "${REPLY}" in
            1) OSVARIANT=fedora38 ; break ;;
            2) OSVARIANT=nixos-23.05 ; break ;;
            3) OSVARIANT=debian12 ; break ;;
            4) OSVARIANT=archlinux ; break ;;
            5) OSVARIANT=opensuse15.5 ; break ;;
            6) OSVARIANT=opensusetumbleweed ; break ;;
            7) OSVARIANT=generic ; break ;;
            8) OSVARIANT=gentoo ; break ;;
            9) OSVARIANT=rocky9 ; break ;;
            10) OSVARIANT=win10 ; break ;;
            11) OSVARIANT=win10 ; break ;;
            12) OSVARIANT=win2k22 ; break ;;
            13) OSVARIANT=android-x86-9.0 ; break ;;
        esac
    done
    printf "\n"

    ls -l /mnt/kvm/iso

    printf "\n"

    local ISO
    read -rep "ISO File: " ISO

    /usr/bin/virt-install \
        --name "${NAME}" \
        --memory "${MEMORY}" \
        --vcpus "${VCPU}" \
        --disk path=/mnt/kvm/storage/"${NAME}".qcow2,size="${DISKSIZE}" \
        --os-variant "${OSVARIANT}" \
        --network bridge=vm-bridge \
        --cdrom /mnt/kvm/iso/"${ISO}" \
        --graphics spice \
        --autoconsole none \
        --boot uefi
    
    exit

}

manual-bios () {

    # Local variables

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
      1) MEMORY=512 ; break ;;
      2) MEMORY=1024 ; break ;;
      3) MEMORY=2048 ; break ;;
      4) MEMORY=4096 ; break ;;
      5) MEMORY=8192 ; break ;;
      6) MEMORY=16384 ; break ;;
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
    options=("Fedora" "NixOS" "Debian" "Arch Linux" "OpenSUSE Leap" "OpenSUSE Tumbleweed" "Generic" "Gentoo" "Rocky" "Windows 10" "Windows 11" "Windows Server 2022" "Android 9.0")
    select _ in "${options[@]}"
    do
        case "${REPLY}" in
            1) OSVARIANT=fedora38 ; break ;;
            2) OSVARIANT=nixos-23.05 ; break ;;
            3) OSVARIANT=debian12 ; break ;;
            4) OSVARIANT=archlinux ; break ;;
            5) OSVARIANT=opensuse15.5 ; break ;;
            6) OSVARIANT=opensusetumbleweed ; break ;;
            7) OSVARIANT=generic ; break ;;
            8) OSVARIANT=gentoo ; break ;;
            9) OSVARIANT=rocky9 ; break ;;
            10) OSVARIANT=win10 ; break ;;
            11) OSVARIANT=win10 ; break ;;
            12) OSVARIANT=win2k22 ; break ;;
            13) OSVARIANT=android-x86-9.0 ; break ;;
        esac
    done
    printf "\n"

    ls -l /mnt/kvm/iso

    printf "\n"

    local ISO
    read -rep "ISO File: " ISO

    /usr/bin/virt-install \
        --name "${NAME}" \
        --memory "${MEMORY}" \
        --vcpus "${VCPU}" \
        --disk path=/mnt/kvm/storage/"${NAME}".qcow2,size="${DISKSIZE}" \
        --os-variant "${OSVARIANT}" \
        --network bridge=vm-bridge \
        --cdrom /mnt/kvm/iso/"${ISO}" \
        --graphics spice \
        --autoconsole none
    
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
        # 3) fedora38-server ;;
        *) exit ;;
        esac
    done

}

menu
