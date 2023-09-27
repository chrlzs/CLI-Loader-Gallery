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
    local width=40

    for ((i=0; i<=total_steps; i++)); do
        sleep 0.2  # Simulate some work

        # Calculate the progress percentage
        progress=$((i * 100 / total_steps))
        
        # Calculate the number of characters to display for the progress bar
        num_chars=$((i * width / total_steps))

        # Print the progress bar
        printf "\rProgress: [%-${width}s] (%d%%)" "$(printf '#%.0s' $(seq 1 $num_chars))" "$progress"
    done

    echo -e "\nTask completed!"
}


# Function to simulate a task with a bouncing ball animation
simulate_task_with_bouncing_ball() {
    local ball="o"
    local space=" "
    local max_width=20
    local position=1
    local direction=1

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
        if [ "$position" -eq "$max_width" ]; then
            direction=-1
        elif [ "$position" -eq "1" ]; then
            direction=1
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

    (while ! $task_finished; do
        printf "\rProcessing... %c" "${spinner:$i%${#spinner}:1}"
        sleep 0.1
        ((i++))
        if [ $i -eq $total_steps ]; then
            i=0
        fi
    done) &

    local spinner_pid=$!

    # Simulate some work (in this case, sleep for 5 seconds)
    sleep 5

    # Stop the spinner and notify task completion
    kill -TERM $spinner_pid &> /dev/null
    wait $spinner_pid &> /dev/null

    echo -e "\nTask completed!"
    trap - INT  # Reset Ctrl+C handling to default
}

simulate_task_with_pulsing_dot() {
    local dot="."
    local i=1
    local total_dots=5
    local total_cycles=10
    local task_finished=false

    trap 'task_finished=true' INT  # Handle Ctrl+C to stop the animation

    (while ! $task_finished && ((i <= total_cycles)); do
        printf "\rProcessing%s" "$(printf '%*s' $i)"
        sleep 0.2
        ((i = i % (total_dots + 1) + 1))
    done) &

    local animation_pid=$!

    # Simulate some work (in this case, sleep for 5 seconds)
    sleep 5

    # Stop the animation and notify task completion
    kill -TERM $animation_pid &> /dev/null
    wait $animation_pid &> /dev/null

    echo -e "\nTask completed!"
    trap - INT  # Reset Ctrl+C handling to default
}

simulate_task_with_arrow_sequence() {
    local arrows=("→" "↗" "↑" "↖" "←" "↙" "↓" "↘")
    local i=0
    local total_steps=20
    local task_finished=false

    trap 'task_finished=true' INT  # Handle Ctrl+C to stop the animation

    (while ! $task_finished; do
        printf "\rProcessing... %s" "${arrows[$i]}"
        sleep 0.1
        ((i = (i + 1) % ${#arrows[@]}))
    done) &

    local animation_pid=$!

    # Simulate some work (in this case, sleep for 5 seconds)
    sleep 5

    # Stop the animation and notify task completion
    kill -TERM $animation_pid &> /dev/null
    wait $animation_pid &> /dev/null

    echo -e "\nTask completed!"
    trap - INT  # Reset Ctrl+C handling to default
}

simulate_task_with_bouncing_bar() {
    local bar_width=10
    local max_width=40
    local position=1
    local direction=1
    local task_finished=false

    trap 'task_finished=true' INT  # Handle Ctrl+C to stop the animation

    (while ! $task_finished; do
        local display=""
        for ((j=1; j<=max_width; j++)); do
            if [ "$j" -ge "$position" ] && [ "$j" -lt "$((position + bar_width))" ]; then
                display+="="
            else
                display+=" "
            fi
        done
        printf "\rProcessing... [%s]" "$display"
        sleep 0.1
        if [ "$position" -eq "$max_width" ] || [ "$position" -eq "1" ]; then
            direction=$((direction * -1))
        fi
        position=$((position + direction))
    done) &

    local animation_pid=$!

    # Simulate some work (in this case, sleep for 5 seconds)
    sleep 5

    # Stop the animation and notify task completion
    kill -TERM $animation_pid &> /dev/null
    wait $animation_pid &> /dev/null

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

    # Simulate a task with a pulsing 
    simulate_task_with_pulsing_dot

    simulate_task_with_arrow_sequence

    simulate_task_with_bouncing_bar


    echo "Task completed!"
}

# Run the main function
main
