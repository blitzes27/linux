# linux #
My favorit OS

This is what i use to fast configure my new linux VMs with only SSH-server pre inslalled.


### Copy and paste the command below in your terminal to auto install most scripts in this repository. Read what you will get further down ###

### Dont forget to set your own variables - Its my life dont you forget ###

```bash
set -e

sudo sh -c 'apt update && apt upgrade -y && apt install -y curl'

GITHUB="https://raw.githubusercontent.com/blitzes27/linux/main"

curl -fsSL "$GITHUB/Random_stuff/install_stuff.sh" | sudo bash
curl -fsSL "$GITHUB/Random_stuff/sleep_torture.sh" | sudo bash
curl -fsSL "$GITHUB/docker_fun/docker_install_lazy.sh" | sudo bash
curl -fsSL "$GITHUB/docker_fun/compose_path.sh" | sudo bash
curl -fsSL "$GITHUB/Random_stuff/safe_shutdown_restart.sh" | sudo bash


cd ~
curl -fsSL "$GITHUB/terminal_plastic_operation/auto_install.sh" | bash
#curl -fsSL "$GITHUB/Security/ssh_security.sh" | sudo bash
#curl -fsSL "$GITHUB/Security/ufw.sh" | sudo env NETWORK_ADDRESS="192.168.0.0/24" bash
#curl -fsSL "$GITHUB/Random_stuff/change_hostname.sh" | sudo env NEW_HOSTNAME="FROG" bash
#curl -fsSL "$GITHUB/Random_stuff/nfs_share.sh" | sudo env NFS_IP="192.168.0.0" \
#NFS_PATH="/volume9/data" NFS_MOUNT_POINT="/mnt/data" bash

echo "the command 'power' will do a docker compose down and then turn off the OS"
echo "The command 'reboot' will do a docker compose down and restart your OS"

echo "Dont forget to run: source ~/.bashrc"
```



## Scripts Overview ##

This repository contains a collection of useful Linux scripts for system setup, security, automation, and Docker management. Below is a brief description of each script:



## 1. install_stuff.sh ##

Installs a set of commonly used tools on Ubuntu systems, including:
	•	tree, curl, wget, fail2ban, unzip, zip, rsync, git, and nfs-common.
Optional tools like net-tools, vim, and nano are also available (commented out).



## 2. sleep_torture.sh ##

Disables all sleep, suspend, hibernate, and hybrid sleep modes on the system by editing the /etc/systemd/sleep.conf file and restarting systemd-logind.



## 3. docker_install_lazy.sh ## 

Simplifies Docker installation by:
* Installing Docker Engine and Docker Compose on Ubuntu.
* Adding the current user to the docker group to allow running Docker without sudo.
* Creates the folders/files: 
    - /docker/appdata/docker-compose.yml



## 4. compose_path.sh

Sets up environment paths related to Docker Compose. Prepares the system to ensure Docker Compose is available globally and can be used easily in scripts or interactive shells.

The command "compose" can be used in any folder such as:
* "compose down"
* "compose up -d"


## 5. safe_shutdown_restart.sh ##

### Creates two convenient commands: ###

* **power:** 
    - Safely shuts down the system after stopping Docker containers by doing docker compose down.

* **reboot:** 
    - Safely reboots the system after stopping Docker containers by doing a docker compose down.

* Also adds a cron job to automatically start Docker containers after reboot.


## 6. auto_install.sh ##

Automates the installation of terminal enhancements, making auto completion working with many more enhancements. look in terminal_plastic_operation for pics and more info.

## 7. ssh_security.sh ##

Enhances SSH server security by:

* Enables PubkeyAuthentication

* Disabling root login over SSH.
	
* Disabling password authentication (forcing key-based        authentication).
	
* Restarting the SSH service to apply the changes.

## 8. ufw.sh ##
Installs UFW (uncomplicated firewall)
* Allows OpenSSH
* Allows Port80 and 443
* Allows the variable NETWORK_ADDRESS
* Enables UFW
* **ENTER YOUR VARIABLE**

## 10. change_hostname.sh ##
* Changes the system hostname
* Backs up the current /etc/hosts
* Updates /etc/hosts with ne hostname
* **ENTER YOUR VARIABLE**

## 11. nfs_share.sh ##

Installs necessary nfs-common, sets the entries required in fstab and then mounts the nfs share. 

**ENTER YOUR VARIABLES**
