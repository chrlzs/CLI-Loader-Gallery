#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" > /dev/null 2>&1
}

# Function to install Python
install_python() {
    sudo apt-get install python
    echo "Python has been installed successfully."
}

# Function to display a welcome message
display_welcome() {
    local message="Welcome $USER"

    if command_exists figlet; then
        figlet -f mini "$message" | while IFS= read -r line; do
            echo -e "\033[2K\033[1G$line"
            sleep 0.1  # Adjust the sleep duration to control the animation speed
        done
    else
        echo "$message"
    fi
}

# Main function
main() {
    # Check if Python 2 is installed
    if ! command_exists python; then
        echo "Python 2 is not installed on your system."
        read -p "Do you want to install Python? (y/n): " choice
        if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
            install_python
        else
            echo "Python is required for this script. Please install it manually."
        fi
    else
        echo "Python 2 is already installed on your system."
    fi

    # Check if Python 3 is installed
    if ! command_exists python3; then
        echo "Python 3 is not installed on your system."
        read -p "Do you want to install Python 3? (y/n): " choice
        if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
            install_python
        else
            echo "Python 3 is required for this script. Please install it manually."
        fi
    else
        echo "Python 3 is already installed on your system."
    fi

    # Display welcome message
    display_welcome
}

# Run the main function
main
