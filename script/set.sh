#!/usr/bin/env bash
############################################################ /ᐠ｡ꞈ｡ᐟ\############################################################
#Developed by: Tal Mendelson
#Purpose: Script to demonstrate Ansible's copy and shell module usage per ansible playbook practice task - Ansible Shallow Dive
#         from https://gitlab.com/vaiolabs-io/ansible-shallow-dive
#Date:17/05/2025
#Version: 0.0.1
############################################################ /ᐠ｡ꞈ｡ᐟ\ ############################################################

# Set Bash safety options to prevent errors from cascading
set -euo pipefail
set -x

# Function to check system compatibility
function check_system_compatibility() {
    LIKE_ID_SYS=$(grep ID_LIKE= /etc/os-release | cut -d= -f2)
    
    if [[ "$LIKE_ID_SYS" != "debian" ]]; then
        echo "This script has been tested on Debian-based systems only."
        read -p "Do you wish to continue anyway? [y/N]: " response
        case "$response" in
            [yY][eE][sS]|[yY])
                echo "Continuing..."
                ;;
            *)
                echo "Exiting."
                exit 1
                ;;
        esac
    fi
}

# Function to verify prerequisites
function verify_prerequisites() {
    # Check if Docker is installed
    if ! command -v docker &>/dev/null; then
        echo "Docker is not installed."
        exit 1
    fi
    
    # Check Internet connectivity
    if ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        echo "No internet connection"
        exit 1
    fi
}

# Function to download repository using curl
function download_with_curl() {
    # If git not available, use curl to download the archive
    curl -L -o ansible-shallow-dive.tar.gz https://gitlab.com/vaiolabs-io/ansible-shallow-dive/-/archive/main/ansible-shallow-dive-main.tar.gz
    
    if [[ $? -ne 0 ]]; then
        echo "Failed to download ansible-shallow-dive repo."
        exit 1
    fi
    
    # Extract archive
    tar -xzf ansible-shallow-dive.tar.gz
    
    if [[ $? -ne 0 ]]; then
        echo "Failed to extract archive."
        exit 1
    fi
    
    mv ansible-shallow-dive-main ansible-shallow-dive
    
    # Remove unneeded .gz file after extracting
    rm -r ansible-shallow-dive.tar.gz
}

# Function to download the repository
function download_repository() {
    # Try Git first if available
    if command -v git >/dev/null 2>&1; then
        git clone https://gitlab.com/vaiolabs-io/ansible-shallow-dive.git
        
        if [[ $? -eq 0 && -d "ansible-shallow-dive" ]]; then
            echo "Repository cloned successfully."
        else
            echo "Git clone failed, attempting to download using CURL."
            download_with_curl
        fi
    else
        # Fall back to curl if Git is not available
        download_with_curl
    fi
}

# Function to start the lab environment
function setup_lab_environment() {
    pushd ./ansible-shallow-dive/99_misc/setup/docker
    
    docker compose up -d
    
    if [[ $? -ne 0 ]]; then
        echo "Something went wrong while starting the containers."
        popd
        exit 1
    fi
    
    popd
}

# Function to create practice environment
function prepare_practice_environment() {
    # Create required directory structure
    mkdir -p ./ansible-shallow-dive/03_playbooks/05_summary_practice
    
    # Copy needed ansible files
    cp -pL ../* ./ansible-shallow-dive/03_playbooks/05_summary_practice/ &>/dev/null
}

# Function to run the ansible playbook
function run_ansible_playbook() {
    pushd ./ansible-shallow-dive/99_misc/setup/docker
    
    docker exec docker-ansible-host-1 bash -c "\
       export ANSIBLE_HOST_KEY_CHECKING=False; \
       cd ~/ansible_course/03_playbooks/05_summary_practice; \
       ansible-playbook playbook.yaml -v -b"
    
    popd
}

# Main function that orchestrates the entire script flow
function main() {
    echo "Starting Ansible practice environment setup..."
    
    # Check system compatibility
    check_system_compatibility
    
    # Verify prerequisites
    verify_prerequisites
    
    # Download the repository
    download_repository
    
    # Set up lab environment
    setup_lab_environment
    
    # Prepare practice environment
    prepare_practice_environment
    
    # Run the Ansible playbook
    run_ansible_playbook
    
    echo "Ansible practice environment setup completed successfully!"
}

# Execute the main function to start the script
main
