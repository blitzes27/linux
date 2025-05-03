#!/bin/bash
# This script creates power and reboot commands and configures sudoers
# so that these two scripts can be run without a password.
# A direct "shutdown" still requires your sudo password.
# It will do a docker compose down before it shuts down / or restarts the computer.
# It also creates a cron job to start your compose when the computer starts

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
/sbin/shutdown -h now
EOF

chmod +x /usr/local/bin/power1

# Create /usr/local/bin/reboot1
cat << EOF > /usr/local/bin/reboot1
#!/bin/bash
/usr/bin/docker compose -f $COMPOSE_FILE down
/sbin/shutdown -r now
EOF

chmod +x /usr/local/bin/reboot1

LOGGED_IN_USER=$(logname)

SUDOERS_FILE="/etc/sudoers.d/power_reboot_nopasswd"
if [[ ! -f "$SUDOERS_FILE" ]]; then
  cat << EOF > "$SUDOERS_FILE"
# Allow $LOGGED_IN_USER to run power1 and reboot1 without password
$LOGGED_IN_USER ALL=(ALL) NOPASSWD: /usr/local/bin/power1, /usr/local/bin/reboot1
EOF
  chmod 440 "$SUDOERS_FILE"
  echo "Created sudoers entry for power1 & reboot1 in $SUDOERS_FILE"
else
  echo "Sudoers entry already exists: $SUDOERS_FILE"
fi


# Add to crontab
cron_line="@reboot root sleep 15 && /usr/bin/docker compose -f $COMPOSE_FILE up -d"
if ! grep -qF "$cron_line" /etc/crontab; then
  echo "$cron_line" >> /etc/crontab
fi

USER_BASHRC=$(getent passwd "$LOGGED_IN_USER" | cut -d: -f6)/.bashrc

bashrc_line_1='alias power="sudo /usr/local/bin/power1"'
if ! grep -qF "$bashrc_line_1" "$USER_BASHRC"; then
  echo "$bashrc_line_1" >> "$USER_BASHRC"
fi

bashrc_line_2='alias reboot="sudo /usr/local/bin/reboot1"'
if ! grep -qF "$bashrc_line_2" "$USER_BASHRC"; then
  echo "$bashrc_line_2" >> "$USER_BASHRC"
fi

echo "Random_stuff/safe_shutdown_restart.sh successfull"
echo "The following aliases were added to $USER_BASHRC:"
echo "$bashrc_line_1"
echo "$bashrc_line_2"