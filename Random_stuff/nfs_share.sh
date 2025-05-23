#!/bin/bash
# This script mounts an NFS share on Ubuntu
set -e
# IP address of the NFS server
# NFS_IP="NEED_TO_BE_SET"
# Path to the NFS share on the server
# NFS_PATH="NFS_MOUNT_POINT"
# Mount point on the local machine
# nfs_mount_point="/mnt/data"
# install nfs-common package
apt update
apt install -y nfs-common
# Create the mount point directory if it doesn't exist
mkdir -p $NFS_MOUNT_POINT
# Mount the NFS share
echo "$NFS_IP:$NFS_PATH $NFS_MOUNT_POINT nfs defaults 0 0" | tee -a /etc/fstab > /dev/null

# mount the NFS share
mount -a
# veriify the mount
ls $NFS_MOUNT_POINT
echo "reload fstab: sudo systemctl daemon-reload"
echo "NFS share mounted at $NFS_MOUNT_POINT"
echo "NFS_IP: $NFS_IP"
echo "NFS_PATH: $NFS_PATH"
echo "Random_stuff/nfs_share.sh sucessfull"
