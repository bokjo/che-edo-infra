variable "resource_group_name" {
  type        = "string"
  description = "Name of the azure resource group."
  default     = "edo-staging-rg"
}

variable "hostname" {
  description = "VM hostname"
  default     = "edo-api"
}

variable "lb_dns_name" {
  description = "DNS for Load Balancer IP"
  default     = "edo-staging-tf"
}

variable "location" {
  description = "Location in which all the resources will be created."
  default     = "westeurope"
}

variable "virtual_network_name" {
  description = "Name for the virtual network."
  default     = "edo-staging-vnet"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.1.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.1.0.0/24"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_B1s"
}

variable "username" {
  description = "Default username"
  default     = "bstojchevski"
}

variable "sshkey" {
  description = "Default ssh key to use..."
  default     = "~/.ssh/id_rsa"
}

variable "apiport" {
  description = "Edo API backend port"
  default     = "1234"
}
