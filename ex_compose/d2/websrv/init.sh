#!/bin/bash

echo "running provision..."
apt update -y && apt upgrade -y;

echo "upgraded..."

apt install openssh-server -y;

echo "ssh installed..."

apt install curl -y;

sed -i '$a PermitRootLogin '"yes" /etc/ssh/sshd_config
echo "root:root" | chpasswd

echo "running services..."
service ssh start &
service nginx start;
tail -f /dev/null
