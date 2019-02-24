resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_availability_set" "avset" {
  name                         = "edo-api-set"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

resource "azurerm_virtual_machine" "api-vm" {
  name                  = "edo-api-${count.index}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  availability_set_id   = "${azurerm_availability_set.avset.id}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${element(azurerm_network_interface.api-nic.*.id, count.index)}"]
  count                 = 2

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-api-${count.index}"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "edo-api-${count.index}"
    admin_username = "${var.username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/bstojchevski/.ssh/authorized_keys"
      key_data = ""
    }
  }
}

resource "azurerm_virtual_machine" "ansible-vm" {
  name                  = "edo-ansible-vm"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${azurerm_network_interface.ansible-nic.*.id}"]

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-ansible"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "edo-ansible"
    admin_username = "${var.username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/bstojchevski/.ssh/authorized_keys"
      key_data = ""
    }
  }
}

resource "azurerm_virtual_machine" "db-vm" {
  name                  = "edo-ansible-vm"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${azurerm_network_interface.db-nic.*.id}"]

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-db"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "edo-db"
    admin_username = "${var.username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/bstojchevski/.ssh/authorized_keys"
      key_data = ""
    }
  }
}
