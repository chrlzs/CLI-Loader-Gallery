#!/bin/bash

# Check if Python 2 is installed
if ! command -v python &> /dev/null; then
    echo "Python 2 is not installed on your system."
fi

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed on your system."
fi

# If neither Python 2 nor Python 3 is installed, prompt the user to install
if [ ! command -v python ] && [ ! command -v python3 ]; then
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
