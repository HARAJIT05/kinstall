#!/bin/bash

# ASCII art
echo "
               ,---------------------------,
              |  /---------------------\  |
              | |                       | |
              | |     KINSTALLER        | |
              | |       MADE BY         | |
              | |       HARAJIT         | |
              | |                       | |
              |  \_____________________/  |
              |___________________________|
            ,---\_____     []     _______/------,
          /         /______________\           /|
        /___________________________________ /  | ___
        |                                   |   |    )
        |  _ _ _                 [-------]  |   |   (
        |  o o o                 [-------]  |  /    _)_
        |__________________________________ |/     /  /
    /-------------------------------------/|      ( )/
  /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"

# Function to install the Nix package manager
install_nix() {
    read -p "The Nix package manager is not installed. Do you want to install it? (y/n): " nix_choice
    if [ "$nix_choice" == "y" ] || [ "$nix_choice" == "Y" ]; then
        echo "Installing Nix..."
        sh <(curl -L https://nixos.org/nix/install)
        echo "Nix installed successfully."
    else
        echo "Aborting installation. Please install Nix manually and rerun the script."
        exit 1
    fi
}

# Function to check if the Nix package manager is installed
check_nix_installed() {
    command -v nix-env &> /dev/null || install_nix
}

# Function to check the package manager and install the package
install_package() {
    local package_name=$1

    check_nix_installed

    if command -v apt-get &> /dev/null; then  # Debian/Ubuntu
        sudo apt-get update
        sudo apt-get install "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif command -v yum &> /dev/null; then  # RHEL/Fedora
        sudo yum install "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif command -v dnf &> /dev/null; then  # Fedora
        sudo dnf install "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif command -v pacman &> /dev/null; then  # Arch Linux
        sudo pacman -S "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif command -v zypper &> /dev/null; then  # openSUSE
        sudo zypper install "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif command -v emerge &> /dev/null; then  # Gentoo
        sudo emerge -av "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif command -v brew &> /dev/null; then  # macOS (Homebrew)
        brew install "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif command -v nix-env &> /dev/null; then  # NixOS
        sudo nix-env -iA nixpkgs."$package_name"
    elif command -v snap &> /dev/null; then  # Snap (Universal Linux)
        sudo snap install "$package_name" || sudo nix-env -iA nixpkgs."$package_name"
    elif [ "$(uname)" == "Darwin" ]; then  # macOS (Fallback)
        echo "Homebrew is not installed. Please install the package manually or install Homebrew from https://brew.sh/"
        exit 1
    else
        echo "Unsupported operating system. Please install the package manually."
        exit 1
    fi
}

# Get input from the user
read -p "Enter the package name: " package_name

# Check if the package name is provided
if [ -z "$package_name" ]; then
    echo "Please enter a valid package name."
    exit 1
fi

# Call the function to install the package
install_package "$package_name"
