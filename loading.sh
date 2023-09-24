#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" > /dev/null 2>&1
}

# Function to install Python
install_python() {
    local python_version=$1
    sudo apt-get install $python_version
    echo "$python_version has been installed successfully."
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
    # Priority for Python 3
    if command_exists python3; then
        #echo "Python 3 is already installed on your system."
        python_version="python3"
    # If Python 3 is not found, check for Python 2
    elif command_exists python; then
        #echo "Python 2 is installed on your system."
        python_version="python"
    # If neither Python 2 nor Python 3 is found, prompt the user to install
    else
        echo "Python is not installed on your system."
        read -p "Do you want to install Python? (y/n): " choice
        if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
            install_python "python3"
            python_version="python3"
        else
            echo "Python is required for this script. Please install it manually."
            exit 1
        fi
    fi

    # Display welcome message
    display_welcome

    # Use $python_version in your script to refer to the selected Python version.
    # For example: $python_version your_script.py
}

# Run the main function
main
