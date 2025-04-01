#!/bin/bash
# This script creates commands/files power1 and reboot1. It puts the files in a folder that is in the path. It means that power1 and reboot1 can be run in a terminal and it will execute the script.

# It will do a docker compose down before it shuts down / or restarts the computer.

# It also creates a cron job to start your compose when the computer starts

set -e

#!/bin/bash
set -e

# Check that the script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "Run this script as root or with sudo."
  exit 1
fi

# Define the compose file path once
COMPOSE_FILE="/docker/appdata/docker-compose.yml"

# Create /usr/local/bin/power1
cat << EOF > /usr/local/bin/power1
#!/bin/bash
/usr/bin/docker compose -f $COMPOSE_FILE down
shutdown -h now
EOF

chmod +x /usr/local/bin/power1

# Create /usr/local/bin/reboot1
cat << EOF > /usr/local/bin/reboot1
#!/bin/bash
/usr/bin/docker compose -f $COMPOSE_FILE down
shutdown -r now
EOF

chmod +x /usr/local/bin/reboot1

# Add to crontab
cron_line="@reboot root /usr/bin/docker compose -f $COMPOSE_FILE up -d"
if ! grep -qF "$cron_line" /etc/crontab; then
  echo "$cron_line" >> /etc/crontab
fi

echo "Done."