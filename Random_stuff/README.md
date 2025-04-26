NFS_share install
```bash
GITHUB="https://raw.githubusercontent.com/blitzes27/linux/main"
curl -fsSL "$GITHUB/Random_stuff/nfs_share.sh" | sudo env NFS_IP="192.168.1.10" \
NFS_PATH="/volume7/data" NFS_MOUNT_POINT="/mnt/data" bash