#!/bin/bash
# This script is intended to be run on a Ubuntu server to enhance SSH security.
# It will install fail2ban and configure it to protect against brute-force attacks.
# https://www.secopsolution.com/blog/install-and-configure-fail2ban

set -euo pipefail

# Check that the script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "Run this script as root or with sudo."
  exit 1
fi

CONFIG="/etc/fail2ban/jail.local"

apt update && apt install -y fail2ban

# Backup existing jail.local if present
if [ -f "$CONFIG" ]; then
  cp "$CONFIG" "${CONFIG}.bak"
  echo "Existing jail.local backed up to ${CONFIG}.bak"
fi

# Create jail.local that wont get reset during updates compared to /etc/fail2ban/jail.conf
tee "$CONFIG" > /dev/null << 'EOF'
[sshd]
enabled  = true
port     = ssh
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 5
findtime = 600
bantime  = 1800
EOF

# Enable and start or restart fail2ban
systemctl enable fail2ban && systemctl restart fail2ban

echo "$CONFIG has been created and fail2ban has been started."