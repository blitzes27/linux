#!/bin/bash
# This script is intended to be run on a Ubuntu server to enhance SSH security.
# realy  why scroll trough that *** when you just can run this script/command

sed -i \
-e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
-e 's/^#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' \
-e 's/^#PasswordAuthentication yes/PasswordAuthentication no/' \
/etc/ssh/sshd_config
systemctl restart ssh