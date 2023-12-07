#!/bin/bash

# Get a list of all running Vagrant machines
running_machines=$(vagrant global-status --prune | grep "saved" | awk '{print $1}')

# Confirm with the user before resuming all machines
read -p "WARNING: This action will resume ALL Vagrant machines on the host, including machines not part of this lab. Do you want to resume ALL Vagrant machines (y/N)? " choice

# Set default option to 'N' if the user just presses enter
choice=${choice:-N}

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    # Resume each running machine
    for machine_id in $running_machines
    do
        echo "Resuming Vagrant machine with ID: $machine_id"
        vagrant resume $machine_id
    done

    echo "All Vagrant machines have been resumed."
else
    echo "No Vagrant machines were resumed. Exiting."
fi
