#!/bin/bash
# This script mounts an NFS share on Ubuntu server
set -e
# IP address of the NFS server
nfs_ip="192.168.20.5"
# Path to the NFS share on the server
nfs_path="/volume7/data"
# Mount point on the local machine
nfs_mount_point="/mnt/data"
# install nfs-common package
apt update
apt install nfs-common -y
# Create the mount point directory if it doesn't exist
mkdir -p /mnt/data
# Mount the NFS share
echo "$nfs_ip:$nfs_path $nfs_mount_point nfs defaults 0 0" | tee -a /etc/fstab > /dev/null

# mount the NFS share
mount -a
# veriify the mount
ls $nfs_mount_point