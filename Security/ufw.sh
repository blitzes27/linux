#!/bin/bash

# Exit on error
set -e

# Enable UFW and allow essential traffic
apt update
apt install -y ufw

# Allow SSH
ufw allow OpenSSH

# Allow HTTP and HTTPS
ufw allow 80/tcp
ufw allow 443/tcp

# Optional: allow access from your local network (replace $NETWORK_IP)
# Example: ufw allow from 192.168.1.0/24
ufw allow from "$NETWORK_ADDRESS"

# Enable UFW and show status
ufw enable
ufw status verbose