#!/bin/bash

# Get a list of all running Vagrant machines
running_machines=$(vagrant global-status --prune | grep "running" | awk '{print $1}')

# Confirm with the user before destroying all machines
read -p "WARNING: This action will DESTROY ALL Vagrant machines on the host, including machines not part of this lab. Do you want to DESTROY ALL Vagrant machines (y/N)? " choice

# Set default option to 'N' if the user just presses enter
choice=${choice:-N}

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    # Destroy each running machine
    for machine_id in $running_machines
    do
        echo "DESTROYING Vagrant machine with ID: $machine_id"
        vagrant destroy $machine_id
    done

    echo "All Vagrant machines have been destroyed."
else
    echo "No Vagrant machines were destroyed. Exiting."
fi
