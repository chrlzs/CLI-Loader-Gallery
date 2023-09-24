#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v $1 > /dev/null 2>&1
}

# Check if Python 2 is installed
if ! command -v python &> /dev/null; then
    echo "Python 2 is not installed on your system."
fi

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed on your system."
fi

# If neither Python 2 nor Python 3 is installed, prompt the user to install
if [ ! "$(command -v python)" ] && [ ! "$(command -v python3)" ]; then
    read -p "Do you want to install Python? (y/n): " choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
        # Install Python (adjust package manager and command as needed)
        sudo apt-get install python
        echo "Python has been installed successfully."
    else
        echo "Python is required for this script. Please install it manually."
    fi
else
    echo "Python is already installed on your system."
fi


# Function to display a welcome message
display_welcome() {
    if command_exists figlet; then
        figlet -f mini "W e l c o m e   $USER" | while IFS= read -r line; do
            echo -e "\033[2K\033[1G$line"
            sleep 0.1  # Adjust the sleep duration to control the animation speed
        done
    else
        echo "Welcome $USER"
    fi
}

# Main function
main() {
    # Color definitions
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    blue=$(tput setaf 4)
    magenta=$(tput setaf 5)
    cyan=$(tput setaf 6)
    white=$(tput setaf 7)
    reset=$(tput sgr0)

    printf "${yellow}-------------------------------\n${green}"
    display_welcome

}

# Run the main function
main