#!/bin/bash

# Get a list of all running Vagrant machines
running_machines=$(vagrant global-status --prune | grep "running" | awk '{print $1}')

# Confirm with the user before suspending all machines
read -p "WARNING: This action will suspend ALL Vagrant machines on the host, including machines not part of this lab. Do you want to suspend ALL Vagrant machines (y/N)? " choice

# Set default option to 'N' if the user just presses enter
choice=${choice:-N}

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    # Suspend each running machine
    for machine_id in $running_machines
    do
        echo "Suspending Vagrant machine with ID: $machine_id"
        vagrant suspend $machine_id
    done

    echo "All Vagrant machines have been suspended."
else
    echo "No Vagrant machines were suspended. Exiting."
fi
