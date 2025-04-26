#!/bin/bash
# This script mounts an NFS share on Ubuntu serverecho "Dont forget to source ~/.bashrc"
set -e
# IP address of the NFS server
# NFS_IP="NEED_TO_BE_SET"
# Path to the NFS share on the server
# NFS_PATH="NFS_MOUNT_POINT
# Mount point on the local machine
# nfs_mount_point="/mnt/data"
# install nfs-common package
apt update
apt install nfs-common -y
# Create the mount point directory if it doesn't exist
mkdir -p /mnt/data
# Mount the NFS share
echo "$NFS_IP:$NFS_PATH $NFS_MOUNT_POINT nfs defaults 0 0" | tee -a /etc/fstab > /dev/null
# reload fstab to apply changes
systemctl daemon-reload
# mount the NFS share
mount -a
# veriify the mount
ls $nfs_mount_point