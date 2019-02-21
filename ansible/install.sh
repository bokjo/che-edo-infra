#!/bin/bash

# Add the epel repo
echo "[TASK 1] Adding the epel-release package"
sudo yum install -y -q epel-release

echo "[TASK 2] Install ansible"
sudo yum install -y -q ansible

echo "[TASK 3] Install opennssh server"
sudo yum install -y openssh-server 

echo "[TASK 4] Start sshd"
systemctl start sshd

echo "[TASK 5] Generate ssh key"
echo -e "\n" | ssh-keygen -N ""

# sudo nano /etc/ansible/hosts
echo "[TASK 6] Copy the key to all child servers"
ssh-copy-id vagrant@192.168.10.94
ssh-copy-id vagrant@192.168.10.94

echo "[TASK 7] Greate inventory file"
cd ~ && touch inventory 

echo "[TASK 8] Ping all the servers"
ansible -m ping all