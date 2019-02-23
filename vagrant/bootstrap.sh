#!/bin/bash

# Update hosts file - doeset work for hyperv - only vbox
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 ansible.example.com ansible
172.42.42.101 api-1.example.com api-1
172.42.42.102 api-2.example.com api-2
172.42.42.103 db.example.com db
EOF

# Install docker from Docker-ce repository
echo "[TASK 2] Install docker container engine"
#yum install -y -q yum-utils device-mapper-persistent-data lvm2 > /dev/null 2>&1
#yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
#yum install -y -q docker-ce >/dev/null 2>&1

# Enable docker service
echo "[TASK 3] Enable and start docker service"
#systemctl enable docker >/dev/null 2>&1
#systemctl start docker

# Disable SELinux
echo "[TASK 4] Disable SELinux"
#setenforce 0
#sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Stop and disable firewalld
echo "[TASK 5] Stop and Disable firewalld"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

# Disable swap
echo "[TASK 6] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Set Root password
echo "[TASK 12] Set root password"
#echo "admin" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

#Genereate SSH key pair