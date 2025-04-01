
#!/bin/bash

# The script makes it possible to use docker compose commands in all directories for a chosen docker-compose.yml file

# Fully automated script which will ask for the docker path and the compose path.
# It will check if the paths exist and are executable.
# If they are not, it will search for the docker path and the compose path.
# If the paths are not found, it will exit with an error message.
# It will create a script in /usr/local/bin/compose which will run docker compose with the specified paths.
# This script is intended for Linux systems.

# To be clear, after this script is run you can use the command "compose" with all the docker compose commands in any directory.
# like, compose up -d, compose down, compose ps etc.


# Ask user for docker path
read -p "Enter the full path to the 'docker' executable (leave blank to auto-detect): " docker_path

# If user did not specify a docker path or it does not exist, try to detect it
if [ -z "$docker_path" ]; then
    echo "No docker path provided. Attempting to find docker with 'which docker'..."
    docker_path="$(which docker 2>/dev/null)"
    if [ -z "$docker_path" ]; then
        echo "No 'docker' executable found in PATH. Please install Docker or provide the correct path."
        exit 1
    fi
fi

# Verify docker path
if [ ! -x "$docker_path" ]; then
    echo "Error: The specified docker path '$docker_path' does not exist or is not executable."
    echo "Attempting to find docker automatically..."
    docker_path="$(which docker 2>/dev/null)"
    if [ -z "$docker_path" ]; then
        echo "No valid docker path found."
        exit 1
    else
        echo "Found docker at: $docker_path"
    fi
fi

echo "Docker path set to: $docker_path"


# Ask user for docker-compose.yml path
read -p "Enter the full path to docker-compose.yml (leave blank to search): " compose_path

# If user did not provide a compose path or the file doesn't exist, search for it
if [ -z "$compose_path" ] || [ ! -f "$compose_path" ]; then
    if [ -n "$compose_path" ] && [ ! -f "$compose_path" ]; then
        echo "The file '$compose_path' does not exist."
    fi
    echo "Searching for docker-compose.yml files, this may take a while..."
    mapfile -t compose_files < <(find / -type f -name "docker-compose.yml" 2>/dev/null)

    if [ ${#compose_files[@]} -eq 0 ]; then
        echo "No docker-compose.yml files found on this system."
        exit 1
    fi

    echo "Found the following docker-compose.yml files:"
    for i in "${!compose_files[@]}"; do
        echo "$((i+1))) ${compose_files[i]}"
    done

    read -p "Enter the number of the file you want to use: " file_num

    # Validate user input
    if ! [[ "$file_num" =~ ^[0-9]+$ ]] || [ "$file_num" -lt 1 ] || [ "$file_num" -gt ${#compose_files[@]} ]; then
        echo "Invalid selection."
        exit 1
    fi

    compose_path="${compose_files[$((file_num-1))]}"
fi

# Final check for compose file
if [ ! -f "$compose_path" ]; then
    echo "Error: The specified compose file '$compose_path' does not exist."
    exit 1
fi

echo "docker-compose.yml file path set to: $compose_path"

# Confirm with the user before creating the script
echo "About to create the 'compose' script with the following configuration:"
echo "  Docker path: $docker_path"
echo "  docker-compose.yml path: $compose_path"
read -p "Proceed? (y/n): " proceed
if [[ ! "$proceed" =~ ^[Yy]$ ]]; then
    echo "Aborted by user."
    exit 0
fi

# Create the helper script
tee /usr/local/bin/compose > /dev/null << EOF
#!/bin/bash
"$docker_path" compose -f "$compose_path" "\$@"
EOF

# Make it executable
chmod +x /usr/local/bin/compose

echo "The 'compose' script has been successfully created at /usr/local/bin/compose."
echo "Usage examples:"
echo "the compose command can be used in any directory"
echo "  compose up -d"
echo "  compose down"
echo "  compose ps"
echo "This script will automatically run 'docker compose' with the specified paths."