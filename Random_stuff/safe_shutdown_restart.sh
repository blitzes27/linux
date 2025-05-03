#!/bin/bash
# This script creates power1 and reboot1 commands and configures sudoers
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

# 5) Inject aliases into ~/.bashrc after the last existing alias
ALIASES_BLOCK=$'\n# power1 & reboot1 (auto-injected)\nalias power1="sudo /usr/local/bin/power1"\nalias reboot1="sudo /usr/local/bin/reboot1"\n'
# Find last alias line number
LAST_ALIAS_LINE=$(grep -n '^alias ' "$BASHRC" | tail -n1 | cut -d: -f1 || true)

if [[ -n "$LAST_ALIAS_LINE" ]]; then
  # Insert immediately after the last alias
  sed -i "${LAST_ALIAS_LINE}a ${ALIASES_BLOCK//$'\n'/\\n}" "$BASHRC"
  echo "Injected aliases after line $LAST_ALIAS_LINE in $BASHRC"
else
  # No alias lines found: append at end
  printf "%s" "$ALIASES_BLOCK" >> "$BASHRC"
  echo "No existing aliases found; appended aliases at end of $BASHRC"
fi


echo "Random_stuff/safe_shutdown_restart.sh successfull"