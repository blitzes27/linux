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

### Copy and paste it in your terminal ###

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

