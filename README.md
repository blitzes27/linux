# linux #
My favorit OS

This is what i use to lazy config my new linux with only SSH-server pre inslalled.

## Skripts being used are ##

* Random_stuff/install_stuff.sh

* Random_stuff/sleep_torture.sh

* docker_fun/docker_install_lazy.sh

* docker_fun/compose_path.sh

* Random_stuff/safe_shutdown_restart.sh

* terminal_plastic_operation/auto_install.sh

* Security/ssh_security.sh

* Random_stuff/nfs_share.sh

### Copy and paste it in your terminal to auto install most scripts in this repo. Read what you will get further down ###

### - Dont forget the variables - Its my life Dont you forget ###

```bash
set -e

GITHUB="https://raw.githubusercontent.com/blitzes27/linux/main"

curl -fsSL "$GITHUB/Random_stuff/install_stuff.sh" | sudo bash
curl -fsSL "$GITHUB/Random_stuff/sleep_torture.sh" | sudo bash
curl -fsSL "$GITHUB/docker_fun/docker_install_lazy.sh" | sudo bash
curl -fsSL "$GITHUB/docker_fun/compose_path.sh" | sudo bash
curl -fsSL "$GITHUB/Random_stuff/safe_shutdown_restart.sh" | sudo bash

cd ~
curl -fsSL "$GITHUB/terminal_plastic_operation/auto_install.sh" | bash
curl -fsSL "$GITHUB/Security/ssh_security.sh" | sudo bash
curl -fsSL "$GITHUB/Random_stuff/nfs_share.sh" | sudo env NFS_IP="192.168.0.0" \
NFS_PATH="/volume9/data" NFS_MOUNT_POINT="/mnt/data" bash


echo "the command power1 will turn off Ubuntu, reboot1 will restart but it do a docker compose down"

echo "Dont forget to run: source ~/.bashrc"
```



## Scripts Overview ##

This repository contains a collection of useful Linux scripts for system setup, security, automation, and Docker management. Below is a brief description of each script:

⸻

## 1. install_stuff.sh ##

Installs a set of commonly used tools on Ubuntu systems, including:
	•	tree, curl, wget, fail2ban, unzip, zip, rsync, git, and nfs-common.
Optional tools like net-tools, vim, and nano are also available (commented out).

⸻

## 2. sleep_torture.sh ##

Disables all sleep, suspend, hibernate, and hybrid sleep modes on the system by editing the /etc/systemd/sleep.conf file and restarting systemd-logind.

⸻

## 3. safe_shutdown_restart.sh ##

### Creates two convenient commands: ###

* **power1:** 
    - Safely shuts down the system after stopping Docker containers.

* **reboot1:** 
    - Safely reboots the system after stopping Docker containers.

* Also adds a cron job to automatically start Docker containers after reboot.

⸻

## 4. nfs_share.sh ##

Installs necessary nfs-common, sets the entries required in fstab and then mounts the nfs share
⸻

## 5. ssh_security.sh ##

Enhances SSH server security by:

* Enables PubkeyAuthentication

* Disabling root login over SSH.
	
* Disabling password authentication (forcing key-based        authentication).
	
* Restarting the SSH service to apply the changes.

⸻

## 6. auto_install.sh ##

Automates the installation of terminal enhancements, making auto completion working with many more enhancements.

⸻

## 7. docker_install_lazy.sh ## 

Simplifies Docker installation by:
* Installing Docker Engine and Docker Compose on Ubuntu.
* Adding the current user to the docker group to allow running Docker without sudo.
* Creates the folders/files: 
    - /docker/appdata/docker-compose.yml

⸻

## 8. compose_path.sh

Sets up environment paths related to Docker Compose. Prepares the system to ensure Docker Compose is available globally and can be used easily in scripts or interactive shells.

The command "compose" can be used in any folder such as:
* "compose down"
* "compose up -d"

⸻
