#!/bin/bash

## Install pre-requisite packages
sudo yum check-update; sudo yum install -y gcc libffi-devel python-devel openssl-devel epel-release 
sudo yum install -y ansible python-pip python-wheel

## Install Ansible and Azure SDKs via pip
sudo pip install ansible[azure]