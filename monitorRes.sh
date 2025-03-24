#!/bin/bash

# Set the CPU utilization threshold
THRESHOLD=75

# Set the interval for checking CPU usage (in seconds)
CHECK_INTERVAL=2

# Path to the VM creation script
VM_CREATION_SCRIPT="./createVM.sh"

# Function to get current CPU utilization
get_cpu_usage() {
    # Use top command to get overall CPU usage
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print $1}')
    if [ -z "$cpu_idle" ]; then
        echo "Error: Could not parse CPU idle from top output" >&2
        return 1
    fi
    cpu_usage=$(echo "100 - $cpu_idle" | bc 2>/dev/null)
    if [ -z "$cpu_usage" ]; then
        echo "Error: Could not calculate CPU usage" >&2
        return 1
    fi
    echo "$cpu_usage"
}

# Check if VM creation script exists and is executable
if [ ! -x "$VM_CREATION_SCRIPT" ]; then
    echo "Error: VM creation script '$VM_CREATION_SCRIPT' not found or not executable" >&2
    exit 1
fi

# Main loop to monitor CPU utilization
while true; do
    cpu_usage=$(get_cpu_usage)
    if [ $? -ne 0 ]; then
        echo "Skipping this cycle due to CPU usage retrieval error" >&2
        sleep "$CHECK_INTERVAL"
        continue
    fi
    
    # If CPU usage exceeds the threshold, trigger VM creation
    if [ $(echo "$cpu_usage > $THRESHOLD" | bc) -eq 1 ]; then
        echo "CPU usage is ${cpu_usage}%. Exceeds threshold of ${THRESHOLD}%. Triggering VM creation."
        
        # Run the VM creation script and check its exit status
        bash "$VM_CREATION_SCRIPT"
        if [ $? -ne 0 ]; then
            echo "Warning: VM creation script failed" >&2
        fi
        
        # Sleep to avoid multiple triggers in a short time
        sleep "$CHECK_INTERVAL"
    else
        echo "CPU usage is ${cpu_usage}%. Below threshold of ${THRESHOLD}%. Monitoring continues."
    fi
    
    # Wait for the next check
    sleep "$CHECK_INTERVAL"
done