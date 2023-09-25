#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" > /dev/null 2>&1
}

# Function to install Python
install_python() {
    local python_version=$1
    sudo apt-get install $python_version

    # Check if installation was successful
    if command_exists $python_version; then
        echo "$python_version has been installed successfully."
    else
        echo "Error: Failed to install $python_version."
        exit 1
    fi
}

# Function to prompt user for Python installation
prompt_install_python() {
    read -p "Do you want to install Python? (2/3/n): " choice

    if [ "$choice" == "2" ]; then
        install_python "python"
    elif [ "$choice" == "3" ]; then
        install_python "python3"
    else
        echo "Python is required for this script. Please install it manually."
        exit 1
    fi
}

# Function to display a welcome message
display_welcome() {
    local message="Welcome $USER"

    if command_exists figlet; then
        figlet -f mini "$message"
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
    local i=0
    local total_steps=20
    local task_finished=false

    trap 'task_finished=true' INT  # Handle Ctrl+C to stop the spinner

    while ! $task_finished; do
        printf "\rProcessing... %c" "${spinner:$i%${#spinner}:1}"
        sleep 0.1
        ((i++))
        if [ $i -eq $total_steps ]; then
            i=0
        fi
    done

    echo -e "\nTask completed!"
    trap - INT  # Reset Ctrl+C handling to default
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

    # Check if Python 3 is installed
    if ! command_exists python3; then
        # Check if Python 2 is installed
        if ! command_exists python; then
            prompt_install_python
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
