#!/bin/bash
# This script sets the system hostname and updates /etc/hosts.

set -euo pipefail

# 1) Set the hostname
hostnamectl set-hostname "$NEW_HOSTNAME"

# 2) Backup /etc/hosts
cp /etc/hosts /etc/hosts.bak.$(date +%Y%m%d%H%M%S)

# 3) update (or add) the 127.0.1.1 line for the new hostname.
if grep -qE '^127\.0\.1\.1\b' /etc/hosts; then
  sed -i "s/^127\.0\.1\.1\b.*/127.0.1.1 $NEW_HOSTNAME/" /etc/hosts
else
  echo "127.0.1.1 $NEW_HOSTNAME" >> /etc/hosts
fi

echo "Hostname successfully changed to '$NEW_HOSTNAME'."
echo "Original /etc/hosts backed up to /etc/hosts.bak.*"