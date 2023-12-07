#!/bin/bash

# Define the directories
directories=("../ElasticLab/elastic" "../ElasticLab/dc01" "../ElasticLab/dc02" "../ElasticLab/srv02")

# Loop through each directory
for dir in "${directories[@]}"; do
    # Check if the directory exists
    if [ -d "$dir" ]; then
        echo "Creating Vagrant machine in $dir"
        
        # Change to the directory
        cd "$dir" || exit

        # Check if Vagrantfile exists in the directory
        if [ -f "Vagrantfile" ]; then
            # Run vagrant up
            vagrant up
        else
            echo "Vagrantfile not found in $dir"
        fi
    else
        echo "Directory $dir not found"
    fi
done
