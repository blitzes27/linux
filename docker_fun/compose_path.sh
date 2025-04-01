#!/bin/bash
# To delete this script: sudo rm /usr/local/bin/compose

# The script makes it possible to use docker compose commands in all directories for a chosen docker-compose.yml file

# Semi automated script which will not execute if one of the paths don’t exist. You need to define docker_path and compose_path.

# Change the docker and compose path to match your computer.
# docker path will most likely be the same but the compose path will differ.

# To see your docker path use “which docker”




# Predefined paths, ENTER YOUR PATHS HERE
docker_path="/usr/bin/docker"
compose_path="/docker/appdata/docker-compose.yml"

# Check if docker path exists and is executable
if [ ! -x "$docker_path" ]; then
    echo "Error: The specified docker path '$docker_path' does not exist or is not executable."
    exit 1
fi

# Check if the docker-compose.yml file exists
if [ ! -f "$compose_path" ]; then
    echo "Error: The specified compose file '$compose_path' does not exist."
    exit 1
fi


# If both checks pass, create the compose helper script
tee /usr/local/bin/compose > /dev/null << EOF
#!/bin/bash
"$docker_path" compose -f "$compose_path" "\$@"
EOF

chmod +x /usr/local/bin/compose
clear
echo "The 'compose' script has been successfully created at /usr/local/bin/compose."
echo "You can now use it by running commands like:"
echo "  compose up -d"
echo "  compose down"
echo "  compose ps"
echo "compose will automatically run docker compose using the predefined paths."