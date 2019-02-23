#!/bin/bash

# Install EPEL repository 
echo "[TASK 1] install EPEL repository"
yum install -y -q epel-release

# Install EPEL repository 
echo "[TASK 2] install Ansible"
yum install -y -q ansible