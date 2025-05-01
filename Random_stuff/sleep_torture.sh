#!/bin/bash
# This script disables all sleep and hibernation modes on the system.

set -e

# Write the sleep.conf file
cat << EOF > /etc/systemd/sleep.conf
[Sleep]
AllowSuspend=no
AllowHibernation=no
AllowHybridSleep=no
AllowSuspendThenHibernate=no
EOF

# Restart systemd-logind to apply changes
systemctl restart systemd-logind
echo "Torture started"
echo "Random_stuff/sleep_torture.sh sucessfull"