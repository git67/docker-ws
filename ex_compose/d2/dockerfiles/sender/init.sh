#!/bin/bash

apt update -y && apt upgrade -y
apt install openssh-server -y
apt install sshpass -y
apt install curl -y

while true
do

  echo "is websrv reachable?"
  IS_REACHABLE=$(curl --fail websrv:80)
  if [[ ${IS_REACHABL} -eq 0 ]]; then
    echo "service websrv now reachable!!!!!"
    break;
  fi

  echo "service websrv not reachable"
done

ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
sshpass -p root ssh-copy-id -o StrictHostKeyChecking=no root@websrv
source /root/sender/changes.sh

