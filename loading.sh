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

# Function to simulate a task with a progress bar
simulate_task_with_progress() {
    local total_steps=20
    for ((i=1; i<=total_steps; i++)); do
        sleep 0.2  # Simulate some work
        echo -ne "\rProgress: [$(printf '=%.0s' {1..$i})$(printf ' %.0s' {1..$((total_steps-i))})] ($((i*5))%)"
    done
    echo "Task completed!"
}


# Function to simulate a task with a bouncing ball animation
simulate_task_with_bouncing_ball() {
    local ball="o"
    local space=" "
    local max_width=20
    local direction=1
    local position=1

    for ((i=1; i<=50; i++)); do
        sleep 0.1
        local display=""
        for ((j=1; j<=max_width; j++)); do
            if [ "$j" -eq "$position" ]; then
                display+="$ball"
            else
                display+="$space"
            fi
        done
        echo -ne "\r$display"
        if [ "$position" -eq "$max_width" ] || [ "$position" -eq "1" ]; then
            direction=$((direction * -1))
        fi
        position=$((position + direction))
    done

    echo -e "\nTask completed!"
}


simulate_task_with_spinner() {
    local spinner="/-\|"
    local total_steps=20
    while true; do
        printf "\rProcessing... %c" "${spinner:$total_steps%${#spinner}:1}"
        sleep 0.2
        ((i++))
    done
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

    # print page divider and change console colors
    printf "${yellow}-------------------------------\n$"
    # Display welcome message
    display_welcome

    # Use $python_version in your script to refer to the selected Python version.
    # For example: $python_version your_script.py

    printf "${white}-------------------------------\n$"

    # Simulate a task with a progress bar
    simulate_task_with_progress

    # Simulate a task with a bouncing ball
    simulate_task_with_bouncing_ball

    # Simulate a task with a spinner
    simulate_task_with_spinner

    echo "Task completed!"
}

# Run the main function
main
