#!/bin/bash

## vNET
az network vnet create --name edo-api-vnet --resource-group edo-api --subnet-name edo-api-subnet --address-prefix 10.1.0.0/16 --subnet-prefix 10.1.0.0/24

#API SERVERS
az vm create --resource-group edo-api --name edo-api-1 --image centos --generate-ssh-keys --size Standard_B1s --public-ip-address "" --no-wait  

az vm create --resource-group edo-api --name edo-api-2 --image centos --generate-ssh-keys --size Standard_B1s --public-ip-address "" --no-wait


# DB SERVER
az vm create --resource-group edo-api --name edo-api-db --image centos --generate-ssh-keys --size Standard_B1s --public-ip-address "" --no-wait

#ANSIBLE MASTER
az vm create --resource-group edo-api --name edo-ansible --image centos --generate-ssh-keys --size Standard_B1s --no-wait
