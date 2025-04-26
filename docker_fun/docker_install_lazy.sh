#!/bin/bash
# This script installs Docker on Ubuntu

set -e
# Remove conflicting packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do apt-get remove -y "$pkg"; done

# Add Docker's official GPG key:
apt-get update
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install the latest docker package
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Configure docker to start on boot
systemctl enable docker.service
systemctl enable containerd.service

# test the installation
docker run hello-world

# Add your user to the docker group
usermod -aG docker "${SUDO_USER:-$USER}"

# Create a directory for docker-compose
mkdir -p /docker/appdata

# create a docker-compose.yml file
touch /docker/appdata/docker-compose.yml

# set ownership of the docker directory
chown -R "${SUDO_USER:-$USER}:docker" /docker

